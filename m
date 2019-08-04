Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C009080CC2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfHDVip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 17:38:45 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58287 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfHDVip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 17:38:45 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 93413363EA3;
        Mon,  5 Aug 2019 07:38:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huOC4-00042w-VB; Mon, 05 Aug 2019 07:37:32 +1000
Date:   Mon, 5 Aug 2019 07:37:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/24] shrinker: defer work only to kswapd
Message-ID: <20190804213732.GU7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-5-david@fromorbit.com>
 <625f5e1e-b362-7a76-be01-7f1057646588@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <625f5e1e-b362-7a76-be01-7f1057646588@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=nQ34gEPkiAxst3lwC7UA:9
        a=jnwo7tyyz5iTtFde:21 a=4Sqdatv-7O9S_ltl:21 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 04, 2019 at 07:48:01PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.08.19 г. 5:17 ч., Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Right now deferred work is picked up by whatever GFP_KERNEL context
> > reclaimer that wins the race to empty the node's deferred work
> > counter. However, if there are lots of direct reclaimers, that
> > work might be continually picked up by contexts taht can't do any
> > work and so the opportunities to do the work are missed by contexts
> > that could do them.
> > 
> > A further problem with the current code is that the deferred work
> > can be picked up by a random direct reclaimer, resulting in that
> > specific process having to do all the deferred reclaim work and
> > hence can take extremely long latencies if the reclaim work blocks
> > regularly. This is not good for direct reclaim fairness or for
> > minimising long tail latency events.
> > 
> > To avoid these problems, simply limit deferred work to kswapd
> > contexts. We know kswapd is a context that can always do reclaim
> > work, and hence deferring work to kswapd allows the deferred work to
> > be done in the background and not adversely affect any specific
> > process context doing direct reclaim.
> > 
> > The advantage of this is that amount of work to be done in direct
> > reclaim is now bound and predictable - it is entirely based on
> > the cache's freeable objects and the reclaim priority. hence all
> > direct reclaimers running at the same time should be doing
> > relatively equal amounts of work, thereby reducing the incidence of
> > long tail latencies due to uneven reclaim workloads.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  mm/vmscan.c | 93 ++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 50 insertions(+), 43 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b7472953b0e6..c583b4efb9bf 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -500,15 +500,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  				    struct shrinker *shrinker, int priority)
> >  {
> >  	unsigned long freed = 0;
> > -	long total_scan;
> >  	int64_t freeable_objects = 0;
> >  	int64_t scan_count;
> > -	long nr;
> > +	int64_t scanned_objects = 0;
> > +	int64_t next_deferred = 0;
> > +	int64_t deferred_count = 0;
> >  	long new_nr;
> >  	int nid = shrinkctl->nid;
> >  	long batch_size = shrinker->batch ? shrinker->batch
> >  					  : SHRINK_BATCH;
> > -	long scanned = 0, next_deferred;
> >  
> >  	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >  		nid = 0;
> > @@ -519,47 +519,53 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  		return scan_count;
> >  
> >  	/*
> > -	 * copy the current shrinker scan count into a local variable
> > -	 * and zero it so that other concurrent shrinker invocations
> > -	 * don't also do this scanning work.
> > +	 * If kswapd, we take all the deferred work and do it here. We don't let
> > +	 * direct reclaim do this, because then it means some poor sod is going
> > +	 * to have to do somebody else's GFP_NOFS reclaim, and it hides the real
> > +	 * amount of reclaim work from concurrent kswapd operations. Hence we do
> > +	 * the work in the wrong place, at the wrong time, and it's largely
> > +	 * unpredictable.
> > +	 *
> > +	 * By doing the deferred work only in kswapd, we can schedule the work
> > +	 * according the the reclaim priority - low priority reclaim will do
> > +	 * less deferred work, hence we'll do more of the deferred work the more
> > +	 * desperate we become for free memory. This avoids the need for needing
> > +	 * to specifically avoid deferred work windup as low amount os memory
> > +	 * pressure won't excessive trim caches anymore.
> >  	 */
> > -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +	if (current_is_kswapd()) {
> > +		int64_t	deferred_scan;
> >  
> > -	total_scan = nr + scan_count;
> > -	if (total_scan < 0) {
> > -		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> > -		       shrinker->scan_objects, total_scan);
> > -		total_scan = scan_count;
> > -		next_deferred = nr;
> > -	} else
> > -		next_deferred = total_scan;
> > +		deferred_count = atomic64_xchg(&shrinker->nr_deferred[nid], 0);
> >  
> > -	/*
> > -	 * We need to avoid excessive windup on filesystem shrinkers
> > -	 * due to large numbers of GFP_NOFS allocations causing the
> > -	 * shrinkers to return -1 all the time. This results in a large
> > -	 * nr being built up so when a shrink that can do some work
> > -	 * comes along it empties the entire cache due to nr >>>
> > -	 * freeable. This is bad for sustaining a working set in
> > -	 * memory.
> > -	 *
> > -	 * Hence only allow the shrinker to scan the entire cache when
> > -	 * a large delta change is calculated directly.
> > -	 */
> > -	if (scan_count < freeable_objects / 4)
> > -		total_scan = min_t(long, total_scan, freeable_objects / 2);
> > +		/* we want to scan 5-10% of the deferred work here at minimum */
> > +		deferred_scan = deferred_count;
> > +		if (priority)
> > +			do_div(deferred_scan, priority);
> > +		scan_count += deferred_scan;
> > +
> > +		/*
> > +		 * If there is more deferred work than the number of freeable
> > +		 * items in the cache, limit the amount of work we will carry
> > +		 * over to the next kswapd run on this cache. This prevents
> > +		 * deferred work windup.
> > +		 */
> > +		if (deferred_count > freeable_objects * 2)
> > +			deferred_count = freeable_objects * 2;
> 
> nit : deferred_count = min(deferred_count, freeable_objects * 2).

*nod*

> How can we have more deferred objects than are currently on the LRU?

deferred work is aggregated. Put enough direct reclaimers in action
in GFP_NOFS context (e.g. fsmark create workload) and it will wind
up the deferred count much faster than kswapd can drain it.

> Aren't deferred objects always some part of freeable objects.

For a single scan, yes. In aggregate, no.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
