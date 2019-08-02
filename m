Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0852D7FD9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfHBPeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfHBPeE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 940DE309DEF3;
        Fri,  2 Aug 2019 15:34:03 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 012C219C6A;
        Fri,  2 Aug 2019 15:34:02 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:34:01 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/24] shrinker: defer work only to kswapd
Message-ID: <20190802153400.GD60893@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-5-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 02 Aug 2019 15:34:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:32PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Right now deferred work is picked up by whatever GFP_KERNEL context
> reclaimer that wins the race to empty the node's deferred work
> counter. However, if there are lots of direct reclaimers, that
> work might be continually picked up by contexts taht can't do any
> work and so the opportunities to do the work are missed by contexts
> that could do them.
> 
> A further problem with the current code is that the deferred work
> can be picked up by a random direct reclaimer, resulting in that
> specific process having to do all the deferred reclaim work and
> hence can take extremely long latencies if the reclaim work blocks
> regularly. This is not good for direct reclaim fairness or for
> minimising long tail latency events.
> 
> To avoid these problems, simply limit deferred work to kswapd
> contexts. We know kswapd is a context that can always do reclaim
> work, and hence deferring work to kswapd allows the deferred work to
> be done in the background and not adversely affect any specific
> process context doing direct reclaim.
> 
> The advantage of this is that amount of work to be done in direct
> reclaim is now bound and predictable - it is entirely based on
> the cache's freeable objects and the reclaim priority. hence all
> direct reclaimers running at the same time should be doing
> relatively equal amounts of work, thereby reducing the incidence of
> long tail latencies due to uneven reclaim workloads.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  mm/vmscan.c | 93 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b7472953b0e6..c583b4efb9bf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -500,15 +500,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  				    struct shrinker *shrinker, int priority)
>  {
>  	unsigned long freed = 0;
> -	long total_scan;
>  	int64_t freeable_objects = 0;
>  	int64_t scan_count;
> -	long nr;
> +	int64_t scanned_objects = 0;
> +	int64_t next_deferred = 0;
> +	int64_t deferred_count = 0;
>  	long new_nr;
>  	int nid = shrinkctl->nid;
>  	long batch_size = shrinker->batch ? shrinker->batch
>  					  : SHRINK_BATCH;
> -	long scanned = 0, next_deferred;
>  
>  	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>  		nid = 0;
> @@ -519,47 +519,53 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		return scan_count;
>  
>  	/*
> -	 * copy the current shrinker scan count into a local variable
> -	 * and zero it so that other concurrent shrinker invocations
> -	 * don't also do this scanning work.
> +	 * If kswapd, we take all the deferred work and do it here. We don't let
> +	 * direct reclaim do this, because then it means some poor sod is going
> +	 * to have to do somebody else's GFP_NOFS reclaim, and it hides the real
> +	 * amount of reclaim work from concurrent kswapd operations. Hence we do
> +	 * the work in the wrong place, at the wrong time, and it's largely
> +	 * unpredictable.
> +	 *
> +	 * By doing the deferred work only in kswapd, we can schedule the work
> +	 * according the the reclaim priority - low priority reclaim will do
> +	 * less deferred work, hence we'll do more of the deferred work the more
> +	 * desperate we become for free memory. This avoids the need for needing
> +	 * to specifically avoid deferred work windup as low amount os memory
> +	 * pressure won't excessive trim caches anymore.
>  	 */
> -	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> +	if (current_is_kswapd()) {
> +		int64_t	deferred_scan;
>  
> -	total_scan = nr + scan_count;
> -	if (total_scan < 0) {
> -		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> -		       shrinker->scan_objects, total_scan);
> -		total_scan = scan_count;
> -		next_deferred = nr;
> -	} else
> -		next_deferred = total_scan;
> +		deferred_count = atomic64_xchg(&shrinker->nr_deferred[nid], 0);
>  
> -	/*
> -	 * We need to avoid excessive windup on filesystem shrinkers
> -	 * due to large numbers of GFP_NOFS allocations causing the
> -	 * shrinkers to return -1 all the time. This results in a large
> -	 * nr being built up so when a shrink that can do some work
> -	 * comes along it empties the entire cache due to nr >>>
> -	 * freeable. This is bad for sustaining a working set in
> -	 * memory.
> -	 *
> -	 * Hence only allow the shrinker to scan the entire cache when
> -	 * a large delta change is calculated directly.
> -	 */
> -	if (scan_count < freeable_objects / 4)
> -		total_scan = min_t(long, total_scan, freeable_objects / 2);
> +		/* we want to scan 5-10% of the deferred work here at minimum */
> +		deferred_scan = deferred_count;
> +		if (priority)
> +			do_div(deferred_scan, priority);
> +		scan_count += deferred_scan;
> +
> +		/*
> +		 * If there is more deferred work than the number of freeable
> +		 * items in the cache, limit the amount of work we will carry
> +		 * over to the next kswapd run on this cache. This prevents
> +		 * deferred work windup.
> +		 */
> +		if (deferred_count > freeable_objects * 2)
> +			deferred_count = freeable_objects * 2;
> +

Hmm, what's the purpose of this check? Is this not handled once the
deferred count is absorbed into scan_count (where we apply the same
logic a few lines below)? Perhaps the latter prevents too much scanning
in a single call into the shrinker whereas this check prevents kswapd
from getting too far behind?

> +	}
>  
>  	/*
>  	 * Avoid risking looping forever due to too large nr value:
>  	 * never try to free more than twice the estimate number of
>  	 * freeable entries.
>  	 */
> -	if (total_scan > freeable_objects * 2)
> -		total_scan = freeable_objects * 2;
> +	if (scan_count > freeable_objects * 2)
> +		scan_count = freeable_objects * 2;
>  
> -	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> +	trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
>  				   freeable_objects, scan_count,
> -				   total_scan, priority);
> +				   scan_count, priority);
>  
>  	/*
>  	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> @@ -583,10 +589,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * scanning at high prio and therefore should try to reclaim as much as
>  	 * possible.
>  	 */
> -	while (total_scan >= batch_size ||
> -	       total_scan >= freeable_objects) {
> +	while (scan_count >= batch_size ||
> +	       scan_count >= freeable_objects) {
>  		unsigned long ret;
> -		unsigned long nr_to_scan = min(batch_size, total_scan);
> +		unsigned long nr_to_scan = min_t(long, batch_size, scan_count);
>  
>  		shrinkctl->nr_to_scan = nr_to_scan;
>  		shrinkctl->nr_scanned = nr_to_scan;
> @@ -596,17 +602,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		freed += ret;
>  
>  		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
> -		total_scan -= shrinkctl->nr_scanned;
> -		scanned += shrinkctl->nr_scanned;
> +		scan_count -= shrinkctl->nr_scanned;
> +		scanned_objects += shrinkctl->nr_scanned;
>  
>  		cond_resched();
>  	}
>  
>  done:
> -	if (next_deferred >= scanned)
> -		next_deferred -= scanned;
> -	else
> -		next_deferred = 0;
> +	if (deferred_count)
> +		next_deferred = deferred_count - scanned_objects;
> +	else if (scan_count > 0)
> +		next_deferred = scan_count;

I was wondering why we dropped the >= scanned_objects check, but I see
that next_deferred is signed and we check for next_deferred > 0 below.
What is odd is that so is scan_count, yet we check > 0 here for
assignment to the same variable. Can we be a little more consistent here
one way or the other?

Brian

>  	/*
>  	 * move the unused scan count back into the shrinker in a
>  	 * manner that handles concurrent updates. If we exhausted the
> @@ -618,7 +624,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	else
>  		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
>  
> -	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
> +	trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr,
> +					scan_count);
>  	return freed;
>  }
>  
> -- 
> 2.22.0
> 
