Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0730EFB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 10:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhBDJbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 04:31:14 -0500
Received: from relay.sw.ru ([185.231.240.75]:57802 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhBDJbM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:31:12 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7axL-001fKb-Hd; Thu, 04 Feb 2021 12:29:43 +0300
Subject: Re: [v6 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-10-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <656865f5-bb56-4f4c-b88d-ec933a042b4c@virtuozzo.com>
Date:   Thu, 4 Feb 2021 12:29:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-10-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> allocate shrinker->nr_deferred for such shrinkers anymore.
> 
> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> This makes the implementation of this patch simpler.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 545422d2aeec..20a35d26ae12 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -334,6 +334,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
>  
> +	if (mem_cgroup_disabled())
> +		return -ENOSYS;
> +
>  	down_write(&shrinker_rwsem);
>  	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> @@ -414,7 +417,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #else
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static void unregister_memcg_shrinker(struct shrinker *shrinker)
> @@ -525,8 +528,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>   */
>  int prealloc_shrinker(struct shrinker *shrinker)
>  {
> -	unsigned int size = sizeof(*shrinker->nr_deferred);
> +	unsigned int size;
> +	int err;
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		err = prealloc_memcg_shrinker(shrinker);
> +		if (err != -ENOSYS)
> +			return err;
>  
> +		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> +	}
> +
> +	size = sizeof(*shrinker->nr_deferred);
>  	if (shrinker->flags & SHRINKER_NUMA_AWARE)
>  		size *= nr_node_ids;

This may sound surprisingly, but IIRC do_shrink_slab() may be called on early boot
*even before* root_mem_cgroup is allocated. AFAIR, I received syzcaller crash report
because of this, when I was implementing shrinker_maps.

This is a reason why we don't use shrinker_maps even in case of mem cgroup is not
disabled: we iterate every shrinker of shrinker_list. See check in shrink_slab():

	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))

Possible, we should do the same for nr_deferred: 1)always allocate shrinker->nr_deferred,
2)use shrinker->nr_deferred in count_nr_deferred() and set_nr_deferred().

>  
> @@ -534,26 +547,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> -	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -		if (prealloc_memcg_shrinker(shrinker))
> -			goto free_deferred;
> -	}
>  
>  	return 0;
> -
> -free_deferred:
> -	kfree(shrinker->nr_deferred);
> -	shrinker->nr_deferred = NULL;
> -	return -ENOMEM;
>  }
>  
>  void free_prealloced_shrinker(struct shrinker *shrinker)
>  {
> -	if (!shrinker->nr_deferred)
> -		return;
> -
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -		unregister_memcg_shrinker(shrinker);
> +		return unregister_memcg_shrinker(shrinker);
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> 

