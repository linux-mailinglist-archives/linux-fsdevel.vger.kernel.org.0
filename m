Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07256EDA9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjDYDXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 23:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjDYDXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:23:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C9A8;
        Mon, 24 Apr 2023 20:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TDZKORwzEt+eX2u0tCokEp9eJLCllrYXgwK+Hx7Vcpk=; b=GefC/jvFTqeaTIMWQN69ufb2Me
        sAIXG1NtP1yjyItvIAQpV0D4kpWWMhKNhQ1j7uhKMIIODYwXfUda7IdDsaBIhpXIsyyQw26Sif0xU
        GJZGrm/HqpFBiMyB/OCvROv64NNHzEONcn4r9rYmrzYE8JEe1lhDl64E/NbQHEVVgLEYVLDf7XKAi
        0SpwJfGx2NfwRrdjwnDsO45GmhdvYbJzPdco38YI9bjf7cE5XFGQ42/LX9kwn2tJodQ+6PsDqbShV
        5rAe0q8HQVGBAIm743Vmp0GETWCgQXfu4wG2x7rWLxS4ZB1Xz+HQWvzswUlMKnTru3B82Q7Q7VY0C
        FT4X0aWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pr9Gx-0014cq-LB; Tue, 25 Apr 2023 03:23:19 +0000
Date:   Tue, 25 Apr 2023 04:23:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>, david@redhat.com,
        osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
Message-ID: <ZEdHpxPRwcGVOctJ@casper.infradead.org>
References: <20230424030756.1795926-1-yajun.deng@linux.dev>
 <ZEX8jV/FQm2gL+2j@casper.infradead.org>
 <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:58:23PM -0700, Andrew Morton wrote:
> On Mon, 24 Apr 2023 04:50:37 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun Deng wrote:
> > > Instead of define an index and determining if the zone has memory,
> > > introduce for_each_populated_zone_pgdat() helper that can be used
> > > to iterate over each populated zone in pgdat, and convert the most
> > > obvious users to it.
> > 
> > I don't think the complexity of the helper justifies the simplification
> > of the users.
> 
> Are you sure?
> 
> > > +++ b/include/linux/mmzone.h
> > > @@ -1580,6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);
> > >  			; /* do nothing */		\
> > >  		else
> > >  
> > > +#define for_each_populated_zone_pgdat(zone, pgdat, max) \
> > > +	for (zone = pgdat->node_zones;                  \
> > > +	     zone < pgdat->node_zones + max;            \
> > > +	     zone++)                                    \
> > > +		if (!populated_zone(zone))		\
> > > +			; /* do nothing */		\
> > > +		else
> > > +
> 
> But each of the call sites is doing this, so at least the complexity is
> now seen in only one place.

But they're not doing _that_.  They're doing something normal and
obvious like:

	for (zone = pgdat->node_zones; zone < pgdat->node_zones + max; zone++) {
		if (!populated_zone(zone)
			continue;
		...
	}

which clearly does what it's supposed to.  But with this patch, there's
macro expansion involved, and it's not a nice simple macro, it has a loop
_and_ an if-condition, and there's an else, and now I have to think hard
about whether flow control is going to do the right thing if the body
of the loop isn't simple.

> btw, do we need to do the test that way?  Why won't this work?
> 
> #define for_each_populated_zone_pgdat(zone, pgdat, max) \
> 	for (zone = pgdat->node_zones;                  \
> 	     zone < pgdat->node_zones + max;            \
> 	     zone++)                                    \
> 		if (populated_zone(zone))

I think it will work, except that this is now legal:

	for_each_populated_zone_pgdat(zone, pgdat, 3)
	else i++;

and really, I think that demonstrates why we don't want macros that are
that darn clever.
