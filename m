Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D09FD053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNV2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:28:52 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57926 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfKNV2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:28:52 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 50A2C3A0C7F;
        Fri, 15 Nov 2019 08:28:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVMfW-0003bB-Vv; Fri, 15 Nov 2019 08:28:46 +1100
Date:   Fri, 15 Nov 2019 08:28:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/28] mm: back off direct reclaim on excessive shrinker
 deferral
Message-ID: <20191114212846.GF4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-16-david@fromorbit.com>
 <20191104195822.GF10665@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104195822.GF10665@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=PKJhY7Hcas5Uusv_ylsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:58:22PM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:05AM +1100, Dave Chinner wrote:
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 967e3d3c7748..13c11e10c9c5 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -570,6 +570,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  		deferred_count = min(deferred_count, freeable_objects * 2);
> >  
> >  	}
> > +	if (current->reclaim_state)
> > +		current->reclaim_state->scanned_objects += scanned_objects;
> 
> Looks like scanned_objects is always zero here.

Yeah, that was a rebase mis-merge. It should be after the scan loop.

> >  	/*
> >  	 * Avoid risking looping forever due to too large nr value:
> > @@ -585,8 +587,11 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> >  	 * defer the work to a context that can scan the cache.
> >  	 */
> > -	if (shrinkctl->defer_work)
> > +	if (shrinkctl->defer_work) {
> > +		if (current->reclaim_state)
> > +			current->reclaim_state->deferred_objects += scan_count;
> >  		goto done;
> > +	}
> >  
> >  	/*
> >  	 * Normally, we should not scan less than batch_size objects in one
> > @@ -2871,7 +2876,30 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  
> >  		if (reclaim_state) {
> >  			sc->nr_reclaimed += reclaim_state->reclaimed_pages;
> > +
> > +			/*
> > +			 * If we are deferring more work than we are actually
> > +			 * doing in the shrinkers, and we are scanning more
> > +			 * objects than we are pages, the we have a large amount
> > +			 * of slab caches we are deferring work to kswapd for.
> > +			 * We better back off here for a while, otherwise
> > +			 * we risk priority windup, swap storms and OOM kills
> > +			 * once we empty the page lists but still can't make
> > +			 * progress on the shrinker memory.
> > +			 *
> > +			 * kswapd won't ever defer work as it's run under a
> > +			 * GFP_KERNEL context and can always do work.
> > +			 */
> > +			if ((reclaim_state->deferred_objects >
> > +					sc->nr_scanned - nr_scanned) &&
> 
> Out of curiosity, what's the reasoning behind the direct comparison
> between ->deferred_objects and pages? Shouldn't we generally expect more
> slab objects to exist than pages by the nature of slab?

No, we can't make any assumptions about the amount of memory a
reclaimed object pins. e.g. the xfs buf shrinker frees objects that
might have many pages attached to them (e.g. 64k dir buffer, 16k
inode cluster), the GEM/TTM shrinkers track and free pages, the
ashmem shrinker tracks pages, etc.

What we try to do is balance the cost of reinstantiating objects in
memory against each other. Reading in a page generally takes two
IOs, instantiating a new inode generally requires 2 IOs (dir read,
inode read), etc. That's what shrinker->seeks encodes, and it's an
attempt to balance object counts of the different caches in a
predictable manner.


> Also, the comment says "if we are scanning more objects than we are
> pages," yet the code is checking whether we defer more objects than
> scanned pages. Which is more accurate?

Both. :)

if reclaim_state->deferred_objects is larger than the page scan
count,  then we either have a very small page cache or we are
deferring a lot of shrinker work.

if we have a small page cache and shrinker reclaim is not making
good progress (i.e. defer more than scan), then we want to back off
for a while rather than rapidly ramp up the reclaim priority to give
the shrinker owner a chance to make progress. The current XFS inode
shrinker does this internally by blocking on IO, but we're getting
rid of that backoff so we need so other way to throttle reclaim when
we have lots of deferral going on.  THis reduces the pressure on the
page reclaim code, and goes some way to prevent swap storms (caused
by winding up the reclaim priority on a LRU with no file pages left
on it) when we have pure slab cache memory pressure.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
