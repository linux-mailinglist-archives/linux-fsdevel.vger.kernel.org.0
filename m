Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99230ED49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 08:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhBDH0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 02:26:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:46720 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhBDH0F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:26:05 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7Z0L-001eHJ-Ak; Thu, 04 Feb 2021 10:24:41 +0300
Subject: Re: [v6 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-4-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e22026cb-c4c9-9c1b-388b-74b8dbebb26a@virtuozzo.com>
Date:   Thu, 4 Feb 2021 10:24:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-4-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.
> 
> Kirill Tkhai suggested use write lock since:
> 
>   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
>   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
>     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
>     is not actually protected.
>   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
>     alloc_shrinker_info()->free_shrinker_info() may free memory right after
>     shrink_slab_memcg() dereferenced it. You may say
>     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
>     but this is not the thing we want to remember in the future, since this
>     spreads modularity.
> 
> And a test with heavy paging workload didn't show write lock makes things worse.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/vmscan.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 96b08c79f18d..e4ddaaaeffe2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  
>  static int memcg_shrinker_map_size;
> -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
>  
>  static void free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -200,8 +199,6 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  	struct memcg_shrinker_map *new, *old;
>  	int nid;
>  
> -	lockdep_assert_held(&memcg_shrinker_map_mutex);
> -
>  	for_each_node(nid) {
>  		old = rcu_dereference_protected(
>  			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> @@ -249,7 +246,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
>  
> -	mutex_lock(&memcg_shrinker_map_mutex);
> +	down_write(&shrinker_rwsem);
>  	size = memcg_shrinker_map_size;
>  	for_each_node(nid) {
>  		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> @@ -260,7 +257,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		}
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
>  	}
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> +	up_write(&shrinker_rwsem);
>  
>  	return ret;
>  }
> @@ -275,9 +272,8 @@ static int expand_shrinker_maps(int new_id)
>  	if (size <= old_size)
>  		return 0;
>  
> -	mutex_lock(&memcg_shrinker_map_mutex);
>  	if (!root_mem_cgroup)
> -		goto unlock;
> +		goto out;
>  
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> @@ -286,13 +282,13 @@ static int expand_shrinker_maps(int new_id)
>  		ret = expand_one_shrinker_map(memcg, size, old_size);
>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
> -			goto unlock;
> +			goto out;
>  		}
>  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> -unlock:
> +out:
>  	if (!ret)
>  		memcg_shrinker_map_size = size;
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> +
>  	return ret;
>  }
>  
> 

