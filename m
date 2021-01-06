Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726652EBD42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 12:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbhAFLkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 06:40:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:57296 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbhAFLkJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:40:09 -0500
Received: from [192.168.15.143]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kx78v-00FdBi-4Z; Wed, 06 Jan 2021 14:38:21 +0300
Subject: Re: [v3 PATCH 06/11] mm: memcontrol: rename shrinker_map to
 shrinker_info
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-7-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ce786c09-64bd-b7fc-4fe8-c4862440c129@virtuozzo.com>
Date:   Wed, 6 Jan 2021 14:38:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105225817.1036378-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.2021 01:58, Yang Shi wrote:
> The following patch is going to add nr_deferred into shrinker_map, the change will
> make shrinker_map not only include map anymore, so rename it to a more general
> name.  And this should make the patch adding nr_deferred cleaner and readable and make
> review easier.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/memcontrol.h |  8 ++---
>  mm/memcontrol.c            |  6 ++--
>  mm/vmscan.c                | 66 +++++++++++++++++++-------------------
>  3 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d128d2842f22..e05bbe8277cc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -96,7 +96,7 @@ struct lruvec_stat {
>   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>   * which have elements charged to this memcg.
>   */
> -struct memcg_shrinker_map {
> +struct memcg_shrinker_info {

Reviewing your next patch actively using new fields in this structure,
I strongly insist on renaming it in "struct shrinker_info" instead of that.

Otherwise, lines of function declarations become too long.

>  	struct rcu_head rcu;
>  	unsigned long map[];
>  };
> @@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
>  
>  	struct mem_cgroup_reclaim_iter	iter;
>  
> -	struct memcg_shrinker_map __rcu	*shrinker_map;
> +	struct memcg_shrinker_info __rcu	*shrinker_info;
>  
>  	struct rb_node		tree_node;	/* RB tree node */
>  	unsigned long		usage_in_excess;/* Set to the value by which */
> @@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -extern int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg);
> -extern void memcg_free_shrinker_maps(struct mem_cgroup *memcg);
> +extern int memcg_alloc_shrinker_info(struct mem_cgroup *memcg);
> +extern void memcg_free_shrinker_info(struct mem_cgroup *memcg);
>  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  				   int nid, int shrinker_id);
>  #else
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 817dde366258..126f1fd550c8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5248,11 +5248,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
>  	/*
> -	 * A memcg must be visible for memcg_expand_shrinker_maps()
> +	 * A memcg must be visible for memcg_expand_shrinker_info()
>  	 * by the time the maps are allocated. So, we allocate maps
>  	 * here, when for_each_mem_cgroup() can't skip it.
>  	 */
> -	if (memcg_alloc_shrinker_maps(memcg)) {
> +	if (memcg_alloc_shrinker_info(memcg)) {
>  		mem_cgroup_id_remove(memcg);
>  		return -ENOMEM;
>  	}
> @@ -5316,7 +5316,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	vmpressure_cleanup(&memcg->vmpressure);
>  	cancel_work_sync(&memcg->high_work);
>  	mem_cgroup_remove_from_trees(memcg);
> -	memcg_free_shrinker_maps(memcg);
> +	memcg_free_shrinker_info(memcg);
>  	memcg_free_kmem(memcg);
>  	mem_cgroup_free(memcg);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9761c7c27412..0033659abf9e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,20 +187,20 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
>  
> -static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> +static void memcg_free_shrinker_info_rcu(struct rcu_head *head)
>  {
> -	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> +	kvfree(container_of(head, struct memcg_shrinker_info, rcu));
>  }
>  
> -static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> -					 int size, int old_size)
> +static int memcg_expand_one_shrinker_info(struct mem_cgroup *memcg,
> +					  int size, int old_size)
>  {
> -	struct memcg_shrinker_map *new, *old;
> +	struct memcg_shrinker_info *new, *old;
>  	int nid;
>  
>  	for_each_node(nid) {
>  		old = rcu_dereference_protected(
> -			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> +			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> @@ -213,17 +213,17 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		memset(new->map, (int)0xff, old_size);
>  		memset((void *)new->map + old_size, 0, size - old_size);
>  
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> +		call_rcu(&old->rcu, memcg_free_shrinker_info_rcu);
>  	}
>  
>  	return 0;
>  }
>  
> -void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> +void memcg_free_shrinker_info(struct mem_cgroup *memcg)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	struct memcg_shrinker_map *map;
> +	struct memcg_shrinker_info *info;
>  	int nid;
>  
>  	if (mem_cgroup_is_root(memcg))
> @@ -231,16 +231,16 @@ void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>  
>  	for_each_node(nid) {
>  		pn = mem_cgroup_nodeinfo(memcg, nid);
> -		map = rcu_dereference_protected(pn->shrinker_map, true);
> -		if (map)
> -			kvfree(map);
> -		rcu_assign_pointer(pn->shrinker_map, NULL);
> +		info = rcu_dereference_protected(pn->shrinker_info, true);
> +		if (info)
> +			kvfree(info);
> +		rcu_assign_pointer(pn->shrinker_info, NULL);
>  	}
>  }
>  
> -int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> +int memcg_alloc_shrinker_info(struct mem_cgroup *memcg)
>  {
> -	struct memcg_shrinker_map *map;
> +	struct memcg_shrinker_info *info;
>  	int nid, size, ret = 0;
>  
>  	if (mem_cgroup_is_root(memcg))
> @@ -249,20 +249,20 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	down_read(&shrinker_rwsem);
>  	size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
>  	for_each_node(nid) {
> -		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> -		if (!map) {
> -			memcg_free_shrinker_maps(memcg);
> +		info = kvzalloc(sizeof(*info) + size, GFP_KERNEL);
> +		if (!info) {
> +			memcg_free_shrinker_info(memcg);
>  			ret = -ENOMEM;
>  			break;
>  		}
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
>  	up_read(&shrinker_rwsem);
>  
>  	return ret;
>  }
>  
> -static int memcg_expand_shrinker_maps(int new_id)
> +static int memcg_expand_shrinker_info(int new_id)
>  {
>  	int size, old_size, ret = 0;
>  	struct mem_cgroup *memcg;
> @@ -279,7 +279,7 @@ static int memcg_expand_shrinker_maps(int new_id)
>  	do {
>  		if (mem_cgroup_is_root(memcg))
>  			continue;
> -		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> +		ret = memcg_expand_one_shrinker_info(memcg, size, old_size);
>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
>  			goto out;
> @@ -293,13 +293,13 @@ static int memcg_expand_shrinker_maps(int new_id)
>  void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  {
>  	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> -		struct memcg_shrinker_map *map;
> +		struct memcg_shrinker_info *info;
>  
>  		rcu_read_lock();
> -		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> +		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
>  		/* Pairs with smp mb in shrink_slab() */
>  		smp_mb__before_atomic();
> -		set_bit(shrinker_id, map->map);
> +		set_bit(shrinker_id, info->map);
>  		rcu_read_unlock();
>  	}
>  }
> @@ -330,7 +330,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		goto unlock;
>  
>  	if (id >= shrinker_nr_max) {
> -		if (memcg_expand_shrinker_maps(id)) {
> +		if (memcg_expand_shrinker_info(id)) {
>  			idr_remove(&shrinker_idr, id);
>  			goto unlock;
>  		}
> @@ -666,7 +666,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			struct mem_cgroup *memcg, int priority)
>  {
> -	struct memcg_shrinker_map *map;
> +	struct memcg_shrinker_info *info;
>  	unsigned long ret, freed = 0;
>  	int i;
>  
> @@ -676,12 +676,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (!down_read_trylock(&shrinker_rwsem))
>  		return 0;
>  
> -	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
> -					true);
> -	if (unlikely(!map))
> +	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 true);
> +	if (unlikely(!info))
>  		goto unlock;
>  
> -	for_each_set_bit(i, map->map, shrinker_nr_max) {
> +	for_each_set_bit(i, info->map, shrinker_nr_max) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
> @@ -692,7 +692,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		shrinker = idr_find(&shrinker_idr, i);
>  		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
>  			if (!shrinker)
> -				clear_bit(i, map->map);
> +				clear_bit(i, info->map);
>  			continue;
>  		}
>  
> @@ -703,7 +703,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY) {
> -			clear_bit(i, map->map);
> +			clear_bit(i, info->map);
>  			/*
>  			 * After the shrinker reported that it had no objects to
>  			 * free, but before we cleared the corresponding bit in
> 

