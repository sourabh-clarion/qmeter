require 'fileutils'

module Qmeter
  class ReportController < ::ApplicationController

  	# GET::report#index
  	# localhost:3000/qmeter
    def index
    	thresholds = {}
	  	thresholds['security_warnings_min'] = 1
	  	thresholds['security_warnings_max'] = 9
	  	
	  	thresholds['rails_best_practices_min'] = 30
	  	thresholds['rails_best_practices_max'] = 50
	  	
	  	thresholds['flog_complexity_min'] = 3
			thresholds['flog_complexity_max'] = 5

	  	thresholds['stats_ratio_min'] = 0.0
	  	thresholds['stats_ratio_max'] = 0.5

			extend Qmeter
			# Call methods from lib/qmeter.rb
			self.initialize_thresholds(thresholds)
			self.generate_final_report
			self.choose_color

			# move report.html from root to the /public folder
			FileUtils.cp('report.html', 'public/') if File.file?("#{Rails.root}/report.html")

    	render layout: false
    end

  end
end