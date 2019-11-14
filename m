Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E498FD07B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKNVlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:41:22 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52277 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfKNVlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:41:22 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B51003A2343;
        Fri, 15 Nov 2019 08:41:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVMrf-0003e9-68; Fri, 15 Nov 2019 08:41:19 +1100
Date:   Fri, 15 Nov 2019 08:41:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/28] mm: kswapd backoff for shrinkers
Message-ID: <20191114214119.GG4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-17-david@fromorbit.com>
 <20191104195853.GG10665@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104195853.GG10665@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=4CHpgsQJY5_7MyMTHV4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:58:53PM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:06AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > When kswapd reaches the end of the page LRU and starts hitting dirty
> > pages, the logic in shrink_node() allows it to back off and wait for
> > IO to complete, thereby preventing kswapd from scanning excessively
> > and driving the system into swap thrashing and OOM conditions.
> > 
> > When we have inode cache heavy workloads on XFS, we have exactly the
> > same problem with reclaim inodes. The non-blocking kswapd reclaim
> > will keep putting pressure onto the inode cache which is unable to
> > make progress. When the system gets to the point where there is no
> > pages in the LRU to free, there is no swap left and there are no
> > clean inodes that can be freed, it will OOM. This has a specific
> > signature in OOM:
> > 
> > [  110.841987] Mem-Info:
> > [  110.842816] active_anon:241 inactive_anon:82 isolated_anon:1
> >                 active_file:168 inactive_file:143 isolated_file:0
> >                 unevictable:2621523 dirty:1 writeback:8 unstable:0
> >                 slab_reclaimable:564445 slab_unreclaimable:420046
> >                 mapped:1042 shmem:11 pagetables:6509 bounce:0
> >                 free:77626 free_pcp:2 free_cma:0
> > 
> > In this case, we have about 500-600 pages left in teh LRUs, but we
> > have ~565000 reclaimable slab pages still available for reclaim.
> > Unfortunately, they are mostly dirty inodes, and so we really need
> > to be able to throttle kswapd when shrinker progress is limited due
> > to reaching the dirty end of the LRU...
> > 
> > So, add a flag into the reclaim_state so if the shrinker decides it
> > needs kswapd to back off and wait for a while (for whatever reason)
> > it can do so.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  include/linux/swap.h |  1 +
> >  mm/vmscan.c          | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index da0913e14bb9..76fc28f0e483 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -133,6 +133,7 @@ struct reclaim_state {
> >  	unsigned long	reclaimed_pages;	/* pages freed by shrinkers */
> >  	unsigned long	scanned_objects;	/* quantity of work done */ 
> >  	unsigned long	deferred_objects;	/* work that wasn't done */
> > +	bool		need_backoff;		/* tell kswapd to slow down */
> >  };
> >  
> >  /*
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 13c11e10c9c5..0f7d35820057 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2949,8 +2949,16 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  			 * implies that pages are cycling through the LRU
> >  			 * faster than they are written so also forcibly stall.
> >  			 */
> > -			if (sc->nr.immediate)
> > +			if (sc->nr.immediate) {
> >  				congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +			} else if (reclaim_state && reclaim_state->need_backoff) {
> > +				/*
> > +				 * Ditto, but it's a slab cache that is cycling
> > +				 * through the LRU faster than they are written
> > +				 */
> > +				congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +				reclaim_state->need_backoff = false;
> > +			}
> 
> Seems reasonable from a functional standpoint, but why not plug in to
> the existing stall instead of duplicate it? E.g., add a corresponding
> ->nr_immediate field to reclaim_state rather than a bool, then transfer
> that to the scan_control earlier in the function where we already check
> for reclaim_state and handle transferring fields (or alternatively just
> leave the bool and use it to bump the scan_control field). That seems a
> bit more consistent with the page processing code, keeps the
> reclaim_state resets in one place and also wouldn't leave us with an
> if/else here for the same stall. Hm?

Because I didn't want to touch the page reclaim logic. That code a
horrible unmaintainalbe spaghetti nightmare of undocumented
hueristics, conditional behaviours and stuff that doesn't work
anymore (e.g. IO load driven congestion backoffs).

Hence folding new things into existing variables is likely to have
unforseen side effects. e.g.  sc->nr.immediate only changes when the
PGDAT_WRITEBACK bit is set.  Hence the immediate reclaim behaviour
is very specific to a set of conditions in the page reclaim
algorithm and I don't want to risk perturbing this horiffic mess if
I can avoid it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
