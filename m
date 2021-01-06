Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E957B2EBD33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFLgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 06:36:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:55910 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbhAFLgR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:36:17 -0500
Received: from [192.168.15.143]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kx75B-00FdAy-9u; Wed, 06 Jan 2021 14:34:29 +0300
Subject: Re: [v3 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg
 offline
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-11-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <777d47b3-65f7-5727-2d21-dbef93e7d1ed@virtuozzo.com>
Date:   Wed, 6 Jan 2021 14:34:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105225817.1036378-11-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.2021 01:58, Yang Shi wrote:
> Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> corresponding nr_deferred when memcg offline.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/memcontrol.h |  1 +
>  mm/memcontrol.c            |  1 +
>  mm/vmscan.c                | 29 +++++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5599082df623..d1e52e916cc2 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1586,6 +1586,7 @@ extern int memcg_alloc_shrinker_info(struct mem_cgroup *memcg);
>  extern void memcg_free_shrinker_info(struct mem_cgroup *memcg);
>  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  				   int nid, int shrinker_id);
> +extern void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 126f1fd550c8..19e555675582 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5284,6 +5284,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  
>  	memcg_offline_kmem(memcg);
> +	memcg_reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  
>  	drain_all_stock(memcg);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d9795fb0f1c5..71056057d26d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -396,6 +396,35 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
> +void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
> +{
> +	int i, nid;
> +	long nr;
> +	struct mem_cgroup *parent;
> +	struct memcg_shrinker_info *child_info, *parent_info;
> +
> +	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		parent = root_mem_cgroup;
> +
> +	/* Prevent from concurrent shrinker_info expand */
> +	down_read(&shrinker_rwsem);
> +	for_each_node(nid) {
> +		child_info = rcu_dereference_protected(
> +					memcg->nodeinfo[nid]->shrinker_info,
> +					true);
> +		parent_info = rcu_dereference_protected(
> +					parent->nodeinfo[nid]->shrinker_info,
> +					true);

Simple assignment can't take such lots of space, we have to do something with that.

Number of these

	rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info, true)

became too big, and we can't allow every of them takes 3 lines.

We should introduce a short helper to dereferrence this, so we will be able to give
out attention to really difficult logic instead of wasting it on parsing this.

		child_info = memcg_shrinker_info(memcg, nid);
or
		child_info = memcg_shrinker_info_protected(memcg, nid);

Both of them fit in single line.

struct memcg_shrinker_info *memcg_shrinker_info_protected(
					struct mem_cgroup *memcg, int nid)
{
	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
					 lockdep_assert_held(&shrinker_rwsem));
}


> +		for (i = 0; i < shrinker_nr_max; i++) {
> +			nr = atomic_long_read(&child_info->nr_deferred[i]);
> +			atomic_long_add(nr,
> +					&parent_info->nr_deferred[i]);

Why new line is here? In case of you merge it up, it will be even shorter then previous line.

> +		}
> +	}
> +	up_read(&shrinker_rwsem);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> 

