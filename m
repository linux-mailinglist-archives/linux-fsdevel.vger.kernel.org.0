Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E82DA6CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLODIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:08:50 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:37098 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgLODIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:08:44 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 2D011620E8;
        Tue, 15 Dec 2020 14:07:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kp0gv-00455r-LR; Tue, 15 Dec 2020 14:07:57 +1100
Date:   Tue, 15 Dec 2020 14:07:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 8/9] mm: memcontrol: reparent nr_deferred when memcg
 offline
Message-ID: <20201215030757.GO3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-9-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-9-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=G0UjF7Cs0_CI2k58uiMA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:21PM -0800, Yang Shi wrote:
> Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> corresponding nr_deferred when memcg offline.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/shrinker.h |  4 ++++
>  mm/memcontrol.c          | 24 ++++++++++++++++++++++++
>  mm/vmscan.c              |  2 +-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1eac79ce57d4..85cfc910dde4 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -78,6 +78,10 @@ struct shrinker {
>  };
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>  
> +#ifdef CONFIG_MEMCG
> +extern int shrinker_nr_max;
> +#endif
> +
>  /* Flags */
>  #define SHRINKER_REGISTERED	(1 << 0)
>  #define SHRINKER_NUMA_AWARE	(1 << 1)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 321d1818ce3d..1f191a15bee1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -59,6 +59,7 @@
>  #include <linux/tracehook.h>
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
> +#include <linux/shrinker.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -612,6 +613,28 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  	}
>  }
>  
> +static void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
> +{
> +	int i, nid;
> +	long nr;
> +	struct mem_cgroup *parent;
> +	struct memcg_shrinker_deferred *child_deferred, *parent_deferred;
> +
> +	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		parent = root_mem_cgroup;
> +
> +	for_each_node(nid) {
> +		child_deferred = memcg->nodeinfo[nid]->shrinker_deferred;
> +		parent_deferred = parent->nodeinfo[nid]->shrinker_deferred;
> +		for (i = 0; i < shrinker_nr_max; i ++) {
> +			nr = atomic_long_read(&child_deferred->nr_deferred[i]);
> +			atomic_long_add(nr,
> +				&parent_deferred->nr_deferred[i]);
> +		}
> +	}
> +}

I would place this function in vmscan.c alongside the
shrink_slab_set_nr_deferred_memcg() function so that all the
accounting is in the one place.

> +
>  /**
>   * mem_cgroup_css_from_page - css of the memcg associated with a page
>   * @page: page of interest
> @@ -5543,6 +5566,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  
>  	memcg_offline_kmem(memcg);
> +	memcg_reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  
>  	drain_all_stock(memcg);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8d5bfd818acd..693a41e89969 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -201,7 +201,7 @@ DECLARE_RWSEM(shrinker_rwsem);
>  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
>  
>  static DEFINE_IDR(shrinker_idr);
> -static int shrinker_nr_max;
> +int shrinker_nr_max;

Then we don't need to make yet another variable global...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
