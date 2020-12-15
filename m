Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CB2DA6E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLODGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:06:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41330 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgLODGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:06:15 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 60AA458C677;
        Tue, 15 Dec 2020 14:05:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kp0eW-00454U-Mx; Tue, 15 Dec 2020 14:05:28 +1100
Date:   Tue, 15 Dec 2020 14:05:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 7/9] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
Message-ID: <20201215030528.GN3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-8-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-8-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=HoWvQtbgcFNr9bk3r4sA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:20PM -0800, Yang Shi wrote:
> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> allocate shrinker->nr_deferred for such shrinkers anymore.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bce8cf44eca2..8d5bfd818acd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -420,7 +420,15 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>   */
>  int prealloc_shrinker(struct shrinker *shrinker)
>  {
> -	unsigned int size = sizeof(*shrinker->nr_deferred);
> +	unsigned int size;
> +
> +	if (is_deferred_memcg_aware(shrinker)) {
> +		if (prealloc_memcg_shrinker(shrinker))
> +			return -ENOMEM;
> +		return 0;
> +	}
> +
> +	size = sizeof(*shrinker->nr_deferred);
>  
>  	if (shrinker->flags & SHRINKER_NUMA_AWARE)
>  		size *= nr_node_ids;
> @@ -429,26 +437,18 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -		if (prealloc_memcg_shrinker(shrinker))
> -			goto free_deferred;
> -	}
> -
>  	return 0;
> -
> -free_deferred:
> -	kfree(shrinker->nr_deferred);
> -	shrinker->nr_deferred = NULL;
> -	return -ENOMEM;
>  }

I'm trying to put my finger on it, but this seems wrong to me. If
memcgs are disabled, then prealloc_memcg_shrinker() needs to fail.
The preallocation code should not care about internal memcg details
like this.

	/*
	 * If the shrinker is memcg aware and memcgs are not
	 * enabled, clear the MEMCG flag and fall back to non-memcg
	 * behaviour for the shrinker.
	 */
	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
		error = prealloc_memcg_shrinker(shrinker);
		if (!error)
			return 0;
		if (error != -ENOSYS)
			return error;

		/* memcgs not enabled! */
		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
	}

	size = sizeof(*shrinker->nr_deferred);
	....
	return 0;
}

This guarantees that only the shrinker instances taht have a
correctly set up memcg attached to them will have the
SHRINKER_MEMCG_AWARE flag set. Hence in all the rest of the shrinker
code, we only ever need to check for SHRINKER_MEMCG_AWARE to
determine what we should do....

>  void free_prealloced_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> +	if (is_deferred_memcg_aware(shrinker)) {
> +		unregister_memcg_shrinker(shrinker);
>  		return;
> +	}
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
> +	if (!shrinker->nr_deferred)
> +		return;
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;

e.g. then this function can simply do:

{
	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
		return unregister_memcg_shrinker(shrinker);
	kfree(shrinker->nr_deferred);
	shrinker->nr_deferred = NULL;
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
