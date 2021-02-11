Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98268318BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 14:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhBKNOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 08:14:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:53356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231886AbhBKNLf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23232AC69;
        Thu, 11 Feb 2021 13:10:50 +0000 (UTC)
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-13-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [v7 PATCH 12/12] mm: vmscan: shrink deferred objects proportional
 to priority
Message-ID: <acd1915c-306b-08a8-9e0f-b06c1e09fb4c@suse.cz>
Date:   Thu, 11 Feb 2021 14:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209174646.1310591-13-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 6:46 PM, Yang Shi wrote:
> The number of deferred objects might get windup to an absurd number, and it
> results in clamp of slab objects.  It is undesirable for sustaining workingset.
> 
> So shrink deferred objects proportional to priority and cap nr_deferred to twice
> of cache items.

Makes sense to me, minimally it's simpler than the old code and avoiding absurd
growth of nr_deferred should be a good thing, as well as the "proportional to
priority" part.

I just suspect there's a bit of unnecessary bias in the implementation, as
explained below:

> The idea is borrowed from Dave Chinner's patch:
> https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> 
> Tested with kernel build and vfs metadata heavy workload in our production
> environment, no regression is spotted so far.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 40 +++++-----------------------------------
>  1 file changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 66163082cc6f..d670b119d6bd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -654,7 +654,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 */
>  	nr = count_nr_deferred(shrinker, shrinkctl);
>  
> -	total_scan = nr;
>  	if (shrinker->seeks) {
>  		delta = freeable >> priority;
>  		delta *= 4;
> @@ -668,37 +667,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		delta = freeable / 2;
>  	}
>  
> +	total_scan = nr >> priority;
>  	total_scan += delta;

So, our scan goal consists of the part based on freeable objects (delta), plus a
part of the defferred objects (nr >> priority). Fine.

> -	if (total_scan < 0) {
> -		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> -		       shrinker->scan_objects, total_scan);
> -		total_scan = freeable;
> -		next_deferred = nr;
> -	} else
> -		next_deferred = total_scan;
> -
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
> -	if (delta < freeable / 4)
> -		total_scan = min(total_scan, freeable / 2);
> -
> -	/*
> -	 * Avoid risking looping forever due to too large nr value:
> -	 * never try to free more than twice the estimate number of
> -	 * freeable entries.
> -	 */
> -	if (total_scan > freeable * 2)
> -		total_scan = freeable * 2;
> +	total_scan = min(total_scan, (2 * freeable));

Probably unnecessary as we cap next_deferred below anyway? So total_scan cannot
grow without limits anymore. But can't hurt.

>  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>  				   freeable, delta, total_scan, priority);
> @@ -737,10 +708,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		cond_resched();
>  	}
>  
> -	if (next_deferred >= scanned)
> -		next_deferred -= scanned;
> -	else
> -		next_deferred = 0;
> +	next_deferred = max_t(long, (nr - scanned), 0) + total_scan;

And here's the bias I think. Suppose we scanned 0 due to e.g. GFP_NOFS. We count
as newly deferred both the "delta" part of total_scan, which is fine, but also
the "nr >> priority" part, where we failed to our share of the "reduce
nr_deferred" work, but I don't think it means we should also increase
nr_deferred by that amount of failed work.
OTOH if we succeed and scan exactly the whole goal, we are subtracting from
nr_deferred both the "nr >> priority" part, which is correct, but also delta,
which was new work, not deferred one, so that's incorrect IMHO as well.
So the calculation should probably be something like this?

	next_deferred = max_t(long, nr + delta - scanned, 0);

Thanks,
Vlastimil

> +	next_deferred = min(next_deferred, (2 * freeable));
> +
>  	/*
>  	 * move the unused scan count back into the shrinker in a
>  	 * manner that handles concurrent updates.
> 

