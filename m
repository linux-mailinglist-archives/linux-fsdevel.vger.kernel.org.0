Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8480BBC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfHDQsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 12:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfHDQsF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 12:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A7D1AF0D;
        Sun,  4 Aug 2019 16:48:03 +0000 (UTC)
Subject: Re: [PATCH 04/24] shrinker: defer work only to kswapd
To:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-5-david@fromorbit.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <625f5e1e-b362-7a76-be01-7f1057646588@suse.com>
Date:   Sun, 4 Aug 2019 19:48:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801021752.4986-5-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.08.19 г. 5:17 ч., Dave Chinner wrote:
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

nit : deferred_count = min(deferred_count, freeable_objects * 2).

How can we have more deferred objects than are currently on the LRU?
Aren't deferred objects always some part of freeable objects. Shouldn't
this mean that for a particular shrinker deferred_count <= freeable_objects?

> +
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

nit: scan_count = min(scan_count, freeable_objects * 2);
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
> 
