Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7030EE36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhBDIRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 03:17:05 -0500
Received: from relay.sw.ru ([185.231.240.75]:46472 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234951AbhBDIQ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:16:57 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7ZnY-001emk-Kn; Thu, 04 Feb 2021 11:15:32 +0300
Subject: Re: [v6 PATCH 06/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-7-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3343b6a8-c192-9668-68ce-8b2abb7026ba@virtuozzo.com>
Date:   Thu, 4 Feb 2021 11:15:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
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

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  include/linux/shrinker.h |  7 ++++---
>  mm/vmscan.c              | 31 +++++++++----------------------
>  2 files changed, 13 insertions(+), 25 deletions(-)
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
> index 9436f9246d32..dc0d69e081b0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -309,19 +309,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
> @@ -330,7 +317,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
> -	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> +	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
>  
> @@ -493,10 +480,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>  	down_write(&shrinker_rwsem);
>  	list_add_tail(&shrinker->list, &shrinker_list);
> -#ifdef CONFIG_MEMCG
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		idr_replace(&shrinker_idr, shrinker, shrinker->id);
> -#endif
> +	shrinker->flags |= SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
>  }
>  
> @@ -516,13 +500,16 @@ EXPORT_SYMBOL(register_shrinker);
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
> @@ -688,7 +675,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		struct shrinker *shrinker;
>  
>  		shrinker = idr_find(&shrinker_idr, i);
> -		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> +		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
>  			if (!shrinker)
>  				clear_bit(i, info->map);
>  			continue;
> 

