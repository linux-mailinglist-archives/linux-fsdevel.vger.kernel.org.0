Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBE6ED70C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjDXV62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjDXV61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DE5596;
        Mon, 24 Apr 2023 14:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9178E61FEC;
        Mon, 24 Apr 2023 21:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A4C433EF;
        Mon, 24 Apr 2023 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682373505;
        bh=GGIx+HG4RqLpRpWhwicWsnzwRbRDyOa6ai9UmyBpCL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqPKH6tOcxN1rpWBfAP+OHlP6C3ty8wGvGNMxNEcqhAMTpFQWzhRcFgmjvzsD2iST
         +ayLkP6RlEH6L8SGKkhUoIisHVpcAGErbhUeQaaGMA5PA7AgyrJOFWL/2OLRfMrvoh
         EMEV/HZgqiOQSuYbsI5/soHCYkUyl3OhcalnvwAs=
Date:   Mon, 24 Apr 2023 14:58:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>, david@redhat.com,
        osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
Message-Id: <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
In-Reply-To: <ZEX8jV/FQm2gL+2j@casper.infradead.org>
References: <20230424030756.1795926-1-yajun.deng@linux.dev>
        <ZEX8jV/FQm2gL+2j@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 04:50:37 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun Deng wrote:
> > Instead of define an index and determining if the zone has memory,
> > introduce for_each_populated_zone_pgdat() helper that can be used
> > to iterate over each populated zone in pgdat, and convert the most
> > obvious users to it.
> 
> I don't think the complexity of the helper justifies the simplification
> of the users.

Are you sure?

> > +++ b/include/linux/mmzone.h
> > @@ -1580,6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);
> >  			; /* do nothing */		\
> >  		else
> >  
> > +#define for_each_populated_zone_pgdat(zone, pgdat, max) \
> > +	for (zone = pgdat->node_zones;                  \
> > +	     zone < pgdat->node_zones + max;            \
> > +	     zone++)                                    \
> > +		if (!populated_zone(zone))		\
> > +			; /* do nothing */		\
> > +		else
> > +

But each of the call sites is doing this, so at least the complexity is
now seen in only one place.

btw, do we need to do the test that way?  Why won't this work?

#define for_each_populated_zone_pgdat(zone, pgdat, max) \
	for (zone = pgdat->node_zones;                  \
	     zone < pgdat->node_zones + max;            \
	     zone++)                                    \
		if (populated_zone(zone))

I suspect it was done the original way in order to save a tabstop,
which is no longer needed.
