Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF40730ED45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 08:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhBDHYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 02:24:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:45926 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhBDHYu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:24:50 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7Yz5-001eGQ-6L; Thu, 04 Feb 2021 10:23:23 +0300
Subject: Re: [v6 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling
 code
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-3-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <118d4862-a2af-8e91-13b7-b7c9ebb83ab0@virtuozzo.com>
Date:   Thu, 4 Feb 2021 10:23:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-3-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> The shrinker map management is not purely memcg specific, it is at the intersection
> between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> and the only memcg bit is the map is being stored in a memcg structure.  So move the
> shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> and remove the "memcg_" prefix.  There is no functional change.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  include/linux/memcontrol.h |  11 ++--
>  mm/huge_memory.c           |   4 +-
>  mm/list_lru.c              |   6 +-
>  mm/memcontrol.c            | 129 +-----------------------------------
>  mm/vmscan.c                | 131 ++++++++++++++++++++++++++++++++++++-
>  5 files changed, 141 insertions(+), 140 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index eeb0b52203e9..1739f17e0939 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1581,10 +1581,9 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -extern int memcg_expand_shrinker_maps(int new_id);
> -
> -extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> -				   int nid, int shrinker_id);
> +int alloc_shrinker_maps(struct mem_cgroup *memcg);
> +void free_shrinker_maps(struct mem_cgroup *memcg);
> +void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> @@ -1594,8 +1593,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> -					  int nid, int shrinker_id)
> +static inline void set_shrinker_bit(struct mem_cgroup *memcg,
> +				    int nid, int shrinker_id)
>  {
>  }
>  #endif
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9237976abe72..05190d7f32ae 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2823,8 +2823,8 @@ void deferred_split_huge_page(struct page *page)
>  		ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
>  		if (memcg)
> -			memcg_set_shrinker_bit(memcg, page_to_nid(page),
> -					       deferred_split_shrinker.id);
> +			set_shrinker_bit(memcg, page_to_nid(page),
> +					 deferred_split_shrinker.id);
>  #endif
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index fe230081690b..628030fa5f69 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -125,8 +125,8 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
>  		list_add_tail(item, &l->list);
>  		/* Set shrinker bit if the first element was added */
>  		if (!l->nr_items++)
> -			memcg_set_shrinker_bit(memcg, nid,
> -					       lru_shrinker_id(lru));
> +			set_shrinker_bit(memcg, nid,
> +					 lru_shrinker_id(lru));
>  		nlru->nr_items++;
>  		spin_unlock(&nlru->lock);
>  		return true;
> @@ -548,7 +548,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>  
>  	if (src->nr_items) {
>  		dst->nr_items += src->nr_items;
> -		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> +		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
>  		src->nr_items = 0;
>  	}
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1bdb93ee8e72..f5c9a0d2160b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -397,129 +397,6 @@ DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
>  EXPORT_SYMBOL(memcg_kmem_enabled_key);
>  #endif
>  
> -static int memcg_shrinker_map_size;
> -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> -
> -static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> -{
> -	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> -}
> -
> -static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> -					 int size, int old_size)
> -{
> -	struct memcg_shrinker_map *new, *old;
> -	int nid;
> -
> -	lockdep_assert_held(&memcg_shrinker_map_mutex);
> -
> -	for_each_node(nid) {
> -		old = rcu_dereference_protected(
> -			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> -		/* Not yet online memcg */
> -		if (!old)
> -			return 0;
> -
> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> -		if (!new)
> -			return -ENOMEM;
> -
> -		/* Set all old bits, clear all new bits */
> -		memset(new->map, (int)0xff, old_size);
> -		memset((void *)new->map + old_size, 0, size - old_size);
> -
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
> -	}
> -
> -	return 0;
> -}
> -
> -static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup_per_node *pn;
> -	struct memcg_shrinker_map *map;
> -	int nid;
> -
> -	if (mem_cgroup_is_root(memcg))
> -		return;
> -
> -	for_each_node(nid) {
> -		pn = mem_cgroup_nodeinfo(memcg, nid);
> -		map = rcu_dereference_protected(pn->shrinker_map, true);
> -		kvfree(map);
> -		rcu_assign_pointer(pn->shrinker_map, NULL);
> -	}
> -}
> -
> -static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> -{
> -	struct memcg_shrinker_map *map;
> -	int nid, size, ret = 0;
> -
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
> -
> -	mutex_lock(&memcg_shrinker_map_mutex);
> -	size = memcg_shrinker_map_size;
> -	for_each_node(nid) {
> -		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> -		if (!map) {
> -			memcg_free_shrinker_maps(memcg);
> -			ret = -ENOMEM;
> -			break;
> -		}
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> -	}
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> -
> -	return ret;
> -}
> -
> -int memcg_expand_shrinker_maps(int new_id)
> -{
> -	int size, old_size, ret = 0;
> -	struct mem_cgroup *memcg;
> -
> -	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> -	old_size = memcg_shrinker_map_size;
> -	if (size <= old_size)
> -		return 0;
> -
> -	mutex_lock(&memcg_shrinker_map_mutex);
> -	if (!root_mem_cgroup)
> -		goto unlock;
> -
> -	for_each_mem_cgroup(memcg) {
> -		if (mem_cgroup_is_root(memcg))
> -			continue;
> -		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> -		if (ret) {
> -			mem_cgroup_iter_break(NULL, memcg);
> -			goto unlock;
> -		}
> -	}
> -unlock:
> -	if (!ret)
> -		memcg_shrinker_map_size = size;
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> -	return ret;
> -}
> -
> -void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> -{
> -	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> -		struct memcg_shrinker_map *map;
> -
> -		rcu_read_lock();
> -		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> -		/* Pairs with smp mb in shrink_slab() */
> -		smp_mb__before_atomic();
> -		set_bit(shrinker_id, map->map);
> -		rcu_read_unlock();
> -	}
> -}
> -
>  /**
>   * mem_cgroup_css_from_page - css of the memcg associated with a page
>   * @page: page of interest
> @@ -5369,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
>  	/*
> -	 * A memcg must be visible for memcg_expand_shrinker_maps()
> +	 * A memcg must be visible for expand_shrinker_maps()
>  	 * by the time the maps are allocated. So, we allocate maps
>  	 * here, when for_each_mem_cgroup() can't skip it.
>  	 */
> -	if (memcg_alloc_shrinker_maps(memcg)) {
> +	if (alloc_shrinker_maps(memcg)) {
>  		mem_cgroup_id_remove(memcg);
>  		return -ENOMEM;
>  	}
> @@ -5437,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	vmpressure_cleanup(&memcg->vmpressure);
>  	cancel_work_sync(&memcg->high_work);
>  	mem_cgroup_remove_from_trees(memcg);
> -	memcg_free_shrinker_maps(memcg);
> +	free_shrinker_maps(memcg);
>  	memcg_free_kmem(memcg);
>  	mem_cgroup_free(memcg);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b512dd5e3a1c..96b08c79f18d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -185,6 +185,131 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG
> +
> +static int memcg_shrinker_map_size;
> +static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> +
> +static void free_shrinker_map_rcu(struct rcu_head *head)
> +{
> +	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> +}
> +
> +static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> +				   int size, int old_size)
> +{
> +	struct memcg_shrinker_map *new, *old;
> +	int nid;
> +
> +	lockdep_assert_held(&memcg_shrinker_map_mutex);
> +
> +	for_each_node(nid) {
> +		old = rcu_dereference_protected(
> +			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> +		/* Not yet online memcg */
> +		if (!old)
> +			return 0;
> +
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> +		if (!new)
> +			return -ENOMEM;
> +
> +		/* Set all old bits, clear all new bits */
> +		memset(new->map, (int)0xff, old_size);
> +		memset((void *)new->map + old_size, 0, size - old_size);
> +
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> +		call_rcu(&old->rcu, free_shrinker_map_rcu);
> +	}
> +
> +	return 0;
> +}
> +
> +void free_shrinker_maps(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup_per_node *pn;
> +	struct memcg_shrinker_map *map;
> +	int nid;
> +
> +	if (mem_cgroup_is_root(memcg))
> +		return;
> +
> +	for_each_node(nid) {
> +		pn = mem_cgroup_nodeinfo(memcg, nid);
> +		map = rcu_dereference_protected(pn->shrinker_map, true);
> +		kvfree(map);
> +		rcu_assign_pointer(pn->shrinker_map, NULL);
> +	}
> +}
> +
> +int alloc_shrinker_maps(struct mem_cgroup *memcg)
> +{
> +	struct memcg_shrinker_map *map;
> +	int nid, size, ret = 0;
> +
> +	if (mem_cgroup_is_root(memcg))
> +		return 0;
> +
> +	mutex_lock(&memcg_shrinker_map_mutex);
> +	size = memcg_shrinker_map_size;
> +	for_each_node(nid) {
> +		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> +		if (!map) {
> +			free_shrinker_maps(memcg);
> +			ret = -ENOMEM;
> +			break;
> +		}
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> +	}
> +	mutex_unlock(&memcg_shrinker_map_mutex);
> +
> +	return ret;
> +}
> +
> +static int expand_shrinker_maps(int new_id)
> +{
> +	int size, old_size, ret = 0;
> +	struct mem_cgroup *memcg;
> +
> +	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> +	old_size = memcg_shrinker_map_size;
> +	if (size <= old_size)
> +		return 0;
> +
> +	mutex_lock(&memcg_shrinker_map_mutex);
> +	if (!root_mem_cgroup)
> +		goto unlock;
> +
> +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> +	do {
> +		if (mem_cgroup_is_root(memcg))
> +			continue;
> +		ret = expand_one_shrinker_map(memcg, size, old_size);
> +		if (ret) {
> +			mem_cgroup_iter_break(NULL, memcg);
> +			goto unlock;
> +		}
> +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> +unlock:
> +	if (!ret)
> +		memcg_shrinker_map_size = size;
> +	mutex_unlock(&memcg_shrinker_map_mutex);
> +	return ret;
> +}
> +
> +void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> +{
> +	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> +		struct memcg_shrinker_map *map;
> +
> +		rcu_read_lock();
> +		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> +		/* Pairs with smp mb in shrink_slab() */
> +		smp_mb__before_atomic();
> +		set_bit(shrinker_id, map->map);
> +		rcu_read_unlock();
> +	}
> +}
> +
>  /*
>   * We allow subsystems to populate their shrinker-related
>   * LRU lists before register_shrinker_prepared() is called
> @@ -212,7 +337,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		goto unlock;
>  
>  	if (id >= shrinker_nr_max) {
> -		if (memcg_expand_shrinker_maps(id)) {
> +		if (expand_shrinker_maps(id)) {
>  			idr_remove(&shrinker_idr, id);
>  			goto unlock;
>  		}
> @@ -589,7 +714,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			 * case, we invoke the shrinker one more time and reset
>  			 * the bit if it reports that it is not empty anymore.
>  			 * The memory barrier here pairs with the barrier in
> -			 * memcg_set_shrinker_bit():
> +			 * set_shrinker_bit():
>  			 *
>  			 * list_lru_add()     shrink_slab_memcg()
>  			 *   list_add_tail()    clear_bit()
> @@ -601,7 +726,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			if (ret == SHRINK_EMPTY)
>  				ret = 0;
>  			else
> -				memcg_set_shrinker_bit(memcg, nid, i);
> +				set_shrinker_bit(memcg, nid, i);
>  		}
>  		freed += ret;
>  
> 

