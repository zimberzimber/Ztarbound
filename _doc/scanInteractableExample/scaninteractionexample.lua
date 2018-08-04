
texts = {
	"Oh yeah baby one more time",
	"Hhhng, oh yeah thats the spot",
	"Again, AGAIN!",
	"Scan me like one of your travel suit cases",
	"Scan every inch of me baby",
	"Oh yeah thats so hot",
	"Like what you're seeing? ;)",
	"Don't just scan me, TAKE ME! TAKE ME NOW!"
}

function init()
	-- Must add this to the object in order to enable scan interactions
	message.setHandler('scanInteraction', scanInteraction)
	
	if storage.state == nil then
		output(config.getParameter("defaultSwitchState", false))
	else
		output(storage.state)
	end
	
	if storage.triggered == nil then
		storage.triggered = false
	end
end

-- This function is called when the object is scanned.
-- Note that you MUST add the handler inside 'init'
function scanInteraction(_, _, playerID)
	object.say(texts[math.random(1, #texts)])
	object.setInteractive(true)
	
	if not self.scanned then
		world.spawnTreasure(object.position(), config.getParameter("treasure.pool"), config.getParameter("treasure.level"), config.getParameter("treasure.seed")) 
		self.scanned = true
	end  
end

function onInteraction()
	object.setInteractive(false)
	output(not storage.state)
end


function output(state)
	storage.state = state
	if state then
		object.setAllOutputNodes(true)
	else
		object.setAllOutputNodes(false)
	end
end
