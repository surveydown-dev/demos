# ---------------------------------------------------------------------
# Package setup ----
#
# Install required packages:
# install.packages('surveydown')
#
# Load packages
library(surveydown)

# ---------------------------------------------------------------------
# Database setup ----
#
# Details at: https://surveydown.org/manuals/storing-data
#
# surveydown stores data on any PostgreSQL database. We recommend
# https://supabase.com/ for a free and easy to use service.
#
# Once you have your database ready, run the following function to store your
# database configuration parameters in a local .env file:
#
# sd_db_config()
#
# Once your parameters are stored, you are ready to connect to your database.
# For this demo, we set ignore = TRUE in the following code, which will ignore
# the connection settings and won't attempt to connect to the database. This is
# helpful if you don't want to record testing data in the database table while
# doing local testing. Once you're ready to collect survey responses, set
# ignore = FALSE or just delete this argument.

db <- sd_db_connect(ignore = TRUE)

# ---------------------------------------------------------------------
# Server setup ----

server <- function(input, output, session) {

  # Define any conditional skipping logic here (skip to page if a condition is true)
  sd_skip_if(
    input$vehicle_simple == "no" ~ "screenout",
    input$vehicle_complex == "no" &
      input$buy_vehicle == "no" ~ "screenout"

  )

  # Other settings
  sd_server(
    db = db,
    all_questions_required = TRUE
  )

}

# shinyApp() initiates your app - don't change it
shiny::shinyApp(ui = sd_ui(), server = server)
