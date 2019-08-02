Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F77FD94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfHBPb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbfHBPb2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 647AE4E927;
        Fri,  2 Aug 2019 15:31:27 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1E160635;
        Fri,  2 Aug 2019 15:31:26 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:31:24 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/24] mm: factor shrinker work calculations
Message-ID: <20190802153124.GC60893@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-4-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 02 Aug 2019 15:31:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:31PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Start to clean up the shrinker code by factoring out the calculation
> that determines how much work to do. This separates the calculation
> from clamping and other adjustments that are done before the
> shrinker work is run.
> 
> Also convert the calculation for the amount of work to be done to
> use 64 bit logic so we don't have to keep jumping through hoops to
> keep calculations within 32 bits on 32 bit systems.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  mm/vmscan.c | 74 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ae3035fe94bc..b7472953b0e6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -464,13 +464,45 @@ EXPORT_SYMBOL(unregister_shrinker);
>  
>  #define SHRINK_BATCH 128
>  
> +/*
> + * Calculate the number of new objects to scan this time around. Return
> + * the work to be done. If there are freeable objects, return that number in
> + * @freeable_objects.
> + */
> +static int64_t shrink_scan_count(struct shrink_control *shrinkctl,
> +			    struct shrinker *shrinker, int priority,
> +			    int64_t *freeable_objects)
> +{
> +	uint64_t delta;
> +	uint64_t freeable;
> +
> +	freeable = shrinker->count_objects(shrinker, shrinkctl);
> +	if (freeable == 0 || freeable == SHRINK_EMPTY)
> +		return freeable;
> +
> +	if (shrinker->seeks) {
> +		delta = freeable >> (priority - 2);
> +		do_div(delta, shrinker->seeks);
> +	} else {
> +		/*
> +		 * These objects don't require any IO to create. Trim
> +		 * them aggressively under memory pressure to keep
> +		 * them from causing refetches in the IO caches.
> +		 */
> +		delta = freeable / 2;
> +	}
> +
> +	*freeable_objects = freeable;
> +	return delta > 0 ? delta : 0;

I see Nikolay had some similar comments but FWIW delta is unsigned so
I'm not sure the point of the > 0 check.

Brian

> +}
> +
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  				    struct shrinker *shrinker, int priority)
>  {
>  	unsigned long freed = 0;
> -	unsigned long long delta;
>  	long total_scan;
> -	long freeable;
> +	int64_t freeable_objects = 0;
> +	int64_t scan_count;
>  	long nr;
>  	long new_nr;
>  	int nid = shrinkctl->nid;
> @@ -481,9 +513,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>  		nid = 0;
>  
> -	freeable = shrinker->count_objects(shrinker, shrinkctl);
> -	if (freeable == 0 || freeable == SHRINK_EMPTY)
> -		return freeable;
> +	scan_count = shrink_scan_count(shrinkctl, shrinker, priority,
> +					&freeable_objects);
> +	if (scan_count == 0 || scan_count == SHRINK_EMPTY)
> +		return scan_count;
>  
>  	/*
>  	 * copy the current shrinker scan count into a local variable
> @@ -492,25 +525,11 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 */
>  	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
>  
> -	total_scan = nr;
> -	if (shrinker->seeks) {
> -		delta = freeable >> priority;
> -		delta *= 4;
> -		do_div(delta, shrinker->seeks);
> -	} else {
> -		/*
> -		 * These objects don't require any IO to create. Trim
> -		 * them aggressively under memory pressure to keep
> -		 * them from causing refetches in the IO caches.
> -		 */
> -		delta = freeable / 2;
> -	}
> -
> -	total_scan += delta;
> +	total_scan = nr + scan_count;
>  	if (total_scan < 0) {
>  		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
>  		       shrinker->scan_objects, total_scan);
> -		total_scan = freeable;
> +		total_scan = scan_count;

Why the change from the (now) freeable_objects value to scan_count?

Brian

>  		next_deferred = nr;
>  	} else
>  		next_deferred = total_scan;
> @@ -527,19 +546,20 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * Hence only allow the shrinker to scan the entire cache when
>  	 * a large delta change is calculated directly.
>  	 */
> -	if (delta < freeable / 4)
> -		total_scan = min(total_scan, freeable / 2);
> +	if (scan_count < freeable_objects / 4)
> +		total_scan = min_t(long, total_scan, freeable_objects / 2);
>  
>  	/*
>  	 * Avoid risking looping forever due to too large nr value:
>  	 * never try to free more than twice the estimate number of
>  	 * freeable entries.
>  	 */
> -	if (total_scan > freeable * 2)
> -		total_scan = freeable * 2;
> +	if (total_scan > freeable_objects * 2)
> +		total_scan = freeable_objects * 2;
>  
>  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> -				   freeable, delta, total_scan, priority);
> +				   freeable_objects, scan_count,
> +				   total_scan, priority);
>  
>  	/*
>  	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> @@ -564,7 +584,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * possible.
>  	 */
>  	while (total_scan >= batch_size ||
> -	       total_scan >= freeable) {
> +	       total_scan >= freeable_objects) {
>  		unsigned long ret;
>  		unsigned long nr_to_scan = min(batch_size, total_scan);
>  
> -- 
> 2.22.0
> 
