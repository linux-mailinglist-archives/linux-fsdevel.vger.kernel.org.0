Return-Path: <linux-fsdevel+bounces-37359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E99F155C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061862843CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF751EBFF0;
	Fri, 13 Dec 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTdyCVo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68671EB9E2;
	Fri, 13 Dec 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116430; cv=none; b=ZX6VygxdeuBuikbBH/vcpvEcELNTd6fJiJIP1SQUGvq08ythvQEI1p3igQA03v/C7QnIjoQgL7xIw4IDlF+yHy+W5WaaAIZpGVysMrpQ1egxrbgwJ2WtrTDPSM1KxEnFIfqL0RUsVyxe3eRyvPwlJsBdAt3WBYNIbm+Hz1hJAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116430; c=relaxed/simple;
	bh=4cQrfh6BfHc3IlT0NVwr6zi0Zv3UEuEKb0NBjH4L2/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBJU6T4EZvXYpgzUl2xXd4kcifa19KJ71XN5xvZ8Wj55wRT9jAVU2tVsAx3iD21T2hq/EzNAnUiWit9RHqfRYhzjIuULundpBeptUsqN+SJJiSVElX0EwcODsCL8v2F3MUNxY3u/3DCMqnkbRvRXPr8v1lMMBviw+XKuPS7LwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTdyCVo0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Q2Hh7i1IvMPkDPyJ+H+GPqol4Inldj3eRd/RH+IyPWA=; b=aTdyCVo0A04ii9Be59koxPyCGw
	E2Tc3gu9An0oYSw9mHUF4BGt68XuQnuY7+qEv5mkl8S/1Mb8OjHTdPRLU0Y8nSm9EmCuNg7Z3wqqy
	Gg5gNAXSG5wpcILgrKOSICOswOFwoAOw2xu5W3peK6/AB0NW9WDuFXCZ7pkBtkOFbvrxQ/H/Wso/7
	vup/1RzSjj5IdPAXwNmGeAuD9eAGVay0ADicmlvi1bgfEe78EBpB3K0vpdptd3ZJgBtpkK/k30Da6
	mWavV6+5CbolAjztRsfwtkpu703L7ZYCER9Q3dAaS2BVWWPNc2kEPctCfSAxVGrJ7DNTtle0nUDG7
	bbwW1yNA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAtg-0000000F6TE-2gCj;
	Fri, 13 Dec 2024 19:00:20 +0000
Date: Fri, 13 Dec 2024 19:00:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linuxfoundation.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z1yERChJxMKlZ5nZ@casper.infradead.org>
References: <Z1wQcKKw14iei0Va@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1wQcKKw14iei0Va@tiehlicka>

On Fri, Dec 13, 2024 at 11:46:08AM +0100, Michal Hocko wrote:
> The annual Linux Storage, Filesystem, Memory Management, and BPF
> (LSF/MM/BPF) Summit for 2025 will be held March 24–26, 2025
> at the Delta hotel Montreal

I've written an opinionated guide to Montreal.
Patches accepted, latest version can be found at
https://www.infradead.org/~willy/linux/lsfmm2025.txt


Montreal
========

Montreal is the second-largest French-speaking city in the world.
Despite that, you can generally manage without speaking any French;
they are accustomed to tourists.

Transport
=========

Montreal primarily uses the metro; it is an entirely underground system.
Entrances are indicated with a blue downward pointing arrow.  The Delta
hotel is between McGill and Place-des-Arts metro stops on the green line.
Train announcements are only in French but signage is bilingual.

Tickets for the STM (https://www.stm.info/en) are valid on both busses
& metro (but not local rail which is a different system that you won't
need to care about anyway).  Travel to and from the airport is a special
$11 fare which includes 24 hours of travel.  You can use a credit card
to buy fares from a big orange machine; while you can pay on the bus,
everybody will look askance at you for slowing them down.  You'll get
a credit-card sized piece of card with an embedded antenna; you can
break it by folding it, and it is not recyclable.  While you could buy
a plastic OPUS card, this will not be a wise investment decision.

From the airport, you'll want to take the 747 bus to Lionel-Groulx, go
down into the Metro and catch a green line train towards Honore-Beaugrand,
getting off at McGill.  For getting back to the airport, you will again
need to buy an $11 ticket for the 747 bus.  If you're travelling, say,
Thursday evening, you might want to buy your special $11 ticket on
Thursday morning, use it to travel around the city and eventually catch
the 747 in time to catch your plane.

I would not recommend driving in Montreal.  It is confusing and expensive.
I'm going to take the train from Ottawa, but taking the train from New
York is a 11+ hour ride.  I'm told it's very pretty!  There are also
coaches (Flixbus / Greyhound / etc) but I have no experience with those.

You can rent a bicycle by the minute: https://bixi.com/en/
Scooters are probably not available to rent during winter.

Beer
====

The closest brewer to the conference is Benelux.  They don't open until
mid-afternoon, but the Provigo grocery store across the street sells
their beer if they're not open.  It's not generally legal to drink on
the street; take the beer back to the hotel before opening it.

Other worthwhile breweries include Dieu de Ciel, 4 Origines, Saint Bock,
Brewsky and McAuslan (aka St Ambroise).  Don't be afraid to use the
metro to visit them.  There are many pubs on Crescent and de la Montagne
streets; most will serve local beer.  Cans of beer are readily available
at corner shops (referred to as "dep", short for Depanneur).

Molson is headquartered in Montreal.  It is not usually considered
local beer.

Food
====

Montreal prides itself on food.  Classic dishes include poutine, smoked
meat and tourtiere.  As a major city, there is plenty of international
food.  Montreal and New York have different styles of bagels from each
other and much ink has been spilled on the subject of which is superior;
try St Viateur or Fairmont for a fair example of Montreal bagels.

There is also fierce competition as to whether Quebec, Ontario or
Vermont produces the best maple syrup.  You should probably find a
Cabane a Sucre / Sugar Shack to form an opinion of your own, eg
https://www.parcjeandrapeau.com/en/urban-sugar-shack-spring-restaurant-sainte-helene-bistro-terrace-montreal/

Outside
=======

We're going to be there in March.  It could be -30C or +20C.  Montreal
has an underground city (RESO) which has shops and restaurants, as
well as being a sheltered route between office towers and the metro.
There's an entrance at Union street, just two blocks from the hotel.
https://www.mtl.org/en/experience/guide-underground-city-shopping
(yes, that is a chunk of the Berlin wall in the picture)

If the weather is clement, Mont Royal is a popular destination, but it
can be icy and not much fun at this time of year.  The Lachine canal may
be a better bet, or you can walk or cycle on the Formula 1 circuit on
Ile Notre Dame.  It's not the Nurburgring; while you can drive on it,
the speed limit is 30kph.  A more unusual route would be the Samuel
De Champlain bridge Multiuse Path which is some of the best tarmac in
the city (but ends on an unsurfaced path that connects to the Formula
1 circuit).

The local sport is hockey.  The Habs are not having a good year, so you
may be able to buy tickets to a game.  The Colorado Avalanche are in town
on Saturday 22nd; otherwise you should be able to watch a game in a pub.
Women's hockey is gaining in popularity, and the Montreal Victoire are
playing Toronto at Place Bell at noon on Sunday 23rd.

St Catherine, St Laurent & St Denis are the major shopping streets.
There are markets at Atwater and Jean Talon.  The Vieux Port area
is full of tourist tat (but maybe you want a sweatshirt with Montreal
written on it).

The Biodome and Biosphere are both worth a visit.  There's also a
planetarium, the Musee des Beaux Arts and the botanic gardens.  I like
the Archaeology museum.

