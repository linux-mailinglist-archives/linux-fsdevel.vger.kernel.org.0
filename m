Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B98463242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 12:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhK3L0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 06:26:10 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:49257 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238891AbhK3L0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:26:10 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 56A67FAFC4
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 11:22:47 +0000 (GMT)
Received: (qmail 5292 invoked from network); 30 Nov 2021 11:22:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2021 11:22:46 -0000
Date:   Tue, 30 Nov 2021 11:22:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211130112244.GQ3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:14:32AM +0100, Mike Galbraith wrote:
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fb9584641ac7..1af12072f40e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1021,6 +1021,39 @@ static void handle_write_error(struct address_space *mapping,
> >         unlock_page(page);
> >  }
> >  
> > +bool skip_throttle_noprogress(pg_data_t *pgdat)
> > +{
> > +       int reclaimable = 0, write_pending = 0;
> > +       int i;
> > +
> > +       /*
> > +        * If kswapd is disabled, reschedule if necessary but do not
> > +        * throttle as the system is likely near OOM.
> > +        */
> > +       if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> > +               return true;
> > +
> > +       /*
> > +        * If there are a lot of dirty/writeback pages then do not
> > +        * throttle as throttling will occur when the pages cycle
> > +        * towards the end of the LRU if still under writeback.
> > +        */
> > +       for (i = 0; i < MAX_NR_ZONES; i++) {
> > +               struct zone *zone = pgdat->node_zones + i;
> > +
> > +               if (!populated_zone(zone))
> > +                       continue;
> > +
> > +               reclaimable += zone_reclaimable_pages(zone);
> > +               write_pending += zone_page_state_snapshot(zone,
> > +                                                 NR_ZONE_WRITE_PENDING);
> > +       }
> > +       if (2 * write_pending <= reclaimable)
> 
> That is always true here...
> 

Always true for you or always true in general?

The intent of the check is "are a majority of reclaimable pages
marked WRITE_PENDING?". It's similar to the check that existed prior
to 132b0d21d21f ("mm/page_alloc: remove the throttling logic from the
page allocator").

-- 
Mel Gorman
SUSE Labs
