Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E8307D32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhA1R5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 12:57:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:47310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhA1R45 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:56:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8B20ACF4;
        Thu, 28 Jan 2021 17:56:14 +0000 (UTC)
Subject: Re: [v5 PATCH 06/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-7-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <df26e4ae-ec84-227e-08e1-5849f7fb7be3@suse.cz>
Date:   Thu, 28 Jan 2021 18:56:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127233345.339910-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 12:33 AM, Yang Shi wrote:
> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> This approach is fine with nr_deferred at the shrinker level, but the following
> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> from unregistering correctly.
> 
> Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> successfully by the new flag.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/shrinker.h |  7 ++++---
>  mm/vmscan.c              | 27 +++++++++------------------
>  2 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..1eac79ce57d4 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -79,13 +79,14 @@ struct shrinker {
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>  
>  /* Flags */
> -#define SHRINKER_NUMA_AWARE	(1 << 0)
> -#define SHRINKER_MEMCG_AWARE	(1 << 1)
> +#define SHRINKER_REGISTERED	(1 << 0)
> +#define SHRINKER_NUMA_AWARE	(1 << 1)
> +#define SHRINKER_MEMCG_AWARE	(1 << 2)
>  /*
>   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
>   * non-MEMCG_AWARE shrinker should not have this flag set.
>   */
> -#define SHRINKER_NONSLAB	(1 << 2)
> +#define SHRINKER_NONSLAB	(1 << 3)
>  
>  extern int prealloc_shrinker(struct shrinker *shrinker);
>  extern void register_shrinker_prepared(struct shrinker *shrinker);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 92e917033797..256896d157d4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -308,19 +308,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  	}
>  }
>  
> -/*
> - * We allow subsystems to populate their shrinker-related
> - * LRU lists before register_shrinker_prepared() is called
> - * for the shrinker, since we don't want to impose
> - * restrictions on their internal registration order.
> - * In this case shrink_slab_memcg() may find corresponding
> - * bit is set in the shrinkers map.
> - *
> - * This value is used by the function to detect registering
> - * shrinkers and to skip do_shrink_slab() calls for them.
> - */
> -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> -
>  static DEFINE_IDR(shrinker_idr);
>  
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> @@ -329,7 +316,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
> -	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> +	id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);

Is it still needed to register a NULL and then replace it with real pointer,
given the SHRINKER_REGISTERED flag?

>  	if (id < 0)
>  		goto unlock;
>  
> @@ -496,6 +483,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
>  #endif
> +	shrinker->flags |= SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
>  }
>  
> @@ -515,13 +503,16 @@ EXPORT_SYMBOL(register_shrinker);
>   */
>  void unregister_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> +	if (!(shrinker->flags & SHRINKER_REGISTERED))
>  		return;
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
> +
>  	down_write(&shrinker_rwsem);
>  	list_del(&shrinker->list);
> +	shrinker->flags &= ~SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
>  }
> @@ -687,7 +678,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		struct shrinker *shrinker;
>  
>  		shrinker = idr_find(&shrinker_idr, i);
> -		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> +		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
>  			if (!shrinker)
>  				clear_bit(i, info->map);
>  			continue;
> 

