Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0630F085
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhBDKYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:60854 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235342AbhBDKYe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:34 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7bn1-001fia-Ri; Thu, 04 Feb 2021 13:23:07 +0300
Subject: Re: [v6 PATCH 11/11] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-12-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8c11f94a-bd1a-3311-2160-0f2c83994a53@virtuozzo.com>
Date:   Thu, 4 Feb 2021 13:23:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-12-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> The number of deferred objects might get windup to an absurd number, and it
> results in clamp of slab objects.  It is undesirable for sustaining workingset.
> 
> So shrink deferred objects proportional to priority and cap nr_deferred to twice
> of cache items.
> 
> The idea is borrowed fron Dave Chinner's patch:
> https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> 
> Tested with kernel build and vfs metadata heavy workload in our production
> environment, no regression is spotted so far.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

For some time I was away from this do_shrink_slab() magic formulas and recent changes,
so I hope somebody else, who is being in touch with this, can review.

> ---
>  mm/vmscan.c | 40 +++++-----------------------------------
>  1 file changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 574d920c4cab..d0a86170854b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -649,7 +649,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 */
>  	nr = count_nr_deferred(shrinker, shrinkctl);
>  
> -	total_scan = nr;
>  	if (shrinker->seeks) {
>  		delta = freeable >> priority;
>  		delta *= 4;
> @@ -663,37 +662,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		delta = freeable / 2;
>  	}
>  
> +	total_scan = nr >> priority;
>  	total_scan += delta;
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
>  
>  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>  				   freeable, delta, total_scan, priority);
> @@ -732,10 +703,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		cond_resched();
>  	}
>  
> -	if (next_deferred >= scanned)
> -		next_deferred -= scanned;
> -	else
> -		next_deferred = 0;
> +	next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
> +	next_deferred = min(next_deferred, (2 * freeable));
> +
>  	/*
>  	 * move the unused scan count back into the shrinker in a
>  	 * manner that handles concurrent updates.

Thanks

