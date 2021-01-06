Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9772EBBF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAFJzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 04:55:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:48020 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbhAFJzp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:55:45 -0500
Received: from [192.168.15.143]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kx5Vr-00FcgL-7c; Wed, 06 Jan 2021 12:53:56 +0300
Subject: Re: [v3 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-4-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <56d26993-1577-3747-2d89-1275d92f7a15@virtuozzo.com>
Date:   Wed, 6 Jan 2021 12:54:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105225817.1036378-4-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.2021 01:58, Yang Shi wrote:
> Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.  This should not exacerbate the contention
> to shrinker_rwsem since just one read side critical section is added.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9db7b4d6d0ae..ddb9f972f856 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  
>  static int memcg_shrinker_map_size;
> -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
>  
>  static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -200,8 +199,6 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  	struct memcg_shrinker_map *new, *old;
>  	int nid;
>  
> -	lockdep_assert_held(&memcg_shrinker_map_mutex);
> -
>  	for_each_node(nid) {
>  		old = rcu_dereference_protected(
>  			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> @@ -250,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
>  
> -	mutex_lock(&memcg_shrinker_map_mutex);
> +	down_read(&shrinker_rwsem);
>  	size = memcg_shrinker_map_size;
>  	for_each_node(nid) {
>  		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> @@ -261,7 +258,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		}
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);

Here we do STORE operation, and since we want the assignment is visible
for shrink_slab_memcg() under down_read(), we have to use down_write()
in memcg_alloc_shrinker_maps().

>  	}
> -	mutex_unlock(&memcg_shrinker_map_mutex);
> +	up_read(&shrinker_rwsem);
>  
>  	return ret;
>  }
> @@ -276,9 +273,8 @@ static int memcg_expand_shrinker_maps(int new_id)
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
> @@ -287,13 +283,13 @@ static int memcg_expand_shrinker_maps(int new_id)
>  		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
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

