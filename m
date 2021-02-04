Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3D30F04F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhBDKQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:16:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:56350 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhBDKQu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:16:50 -0500
Received: from [192.168.15.247]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1l7bfZ-001fdg-PK; Thu, 04 Feb 2021 13:15:25 +0300
Subject: Re: [v6 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg
 offline
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203172042.800474-1-shy828301@gmail.com>
 <20210203172042.800474-11-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <05b2ce17-9fd3-5702-8eeb-bcbb671d8716@virtuozzo.com>
Date:   Thu, 4 Feb 2021 13:15:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203172042.800474-11-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.02.2021 20:20, Yang Shi wrote:
> Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> corresponding nr_deferred when memcg offline.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  include/linux/memcontrol.h |  1 +
>  mm/memcontrol.c            |  1 +
>  mm/vmscan.c                | 24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c457fc7bc631..e1c4b93889ad 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1585,6 +1585,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  int alloc_shrinker_info(struct mem_cgroup *memcg);
>  void free_shrinker_info(struct mem_cgroup *memcg);
>  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
> +void reparent_shrinker_deferred(struct mem_cgroup *memcg);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f64ad0d044d9..21f36b73f36a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5282,6 +5282,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  
>  	memcg_offline_kmem(memcg);
> +	reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  
>  	drain_all_stock(memcg);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 20a35d26ae12..574d920c4cab 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -386,6 +386,30 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
> +void reparent_shrinker_deferred(struct mem_cgroup *memcg)
> +{
> +	int i, nid;
> +	long nr;
> +	struct mem_cgroup *parent;
> +	struct shrinker_info *child_info, *parent_info;
> +
> +	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		parent = root_mem_cgroup;
> +
> +	/* Prevent from concurrent shrinker_info expand */
> +	down_read(&shrinker_rwsem);
> +	for_each_node(nid) {
> +		child_info = shrinker_info_protected(memcg, nid);
> +		parent_info = shrinker_info_protected(parent, nid);
> +		for (i = 0; i < shrinker_nr_max; i++) {
> +			nr = atomic_long_read(&child_info->nr_deferred[i]);
> +			atomic_long_add(nr, &parent_info->nr_deferred[i]);
> +		}
> +	}
> +	up_read(&shrinker_rwsem);
> +}
> +
>  static bool cgroup_reclaim(struct scan_control *sc)
>  {
>  	return sc->target_mem_cgroup;
> 

