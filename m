Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA52130063
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 04:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgADDgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 22:36:04 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52914 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbgADDgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:36:04 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6093E7E9D41;
        Sat,  4 Jan 2020 14:36:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1inaEI-0008Ie-MD; Sat, 04 Jan 2020 14:35:58 +1100
Date:   Sat, 4 Jan 2020 14:35:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 4/5] mm: make memcg visible to lru walker isolation
 function
Message-ID: <20200104033558.GD23195@dread.disaster.area>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-5-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577174006-13025-5-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=3DYVB-4WTUzypFxhjPYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:53:25AM -0500, Yafang Shao wrote:
> The lru walker isolation function may use this memcg to do something, e.g.
> the inode isolatation function will use the memcg to do inode protection in
> followup patch. So make memcg visible to the lru walker isolation function.
> 
> Something should be emphasized in this patch is it replaces
> for_each_memcg_cache_index() with for_each_mem_cgroup() in
> list_lru_walk_node(). Because there's a gap between these two MACROs that
> for_each_mem_cgroup() depends on CONFIG_MEMCG while the other one depends
> on CONFIG_MEMCG_KMEM. But as list_lru_memcg_aware() returns false if
> CONFIG_MEMCG_KMEM is not configured, it is safe to this replacement.
> 
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

....

> @@ -299,17 +299,15 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>  				 list_lru_walk_cb isolate, void *cb_arg,
>  				 unsigned long *nr_to_walk)
>  {
> +	struct mem_cgroup *memcg;
>  	long isolated = 0;
> -	int memcg_idx;
>  
> -	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> -				      nr_to_walk);
> -	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> -		for_each_memcg_cache_index(memcg_idx) {
> +	if (list_lru_memcg_aware(lru)) {
> +		for_each_mem_cgroup(memcg) {
>  			struct list_lru_node *nlru = &lru->node[nid];
>  
>  			spin_lock(&nlru->lock);
> -			isolated += __list_lru_walk_one(nlru, memcg_idx,
> +			isolated += __list_lru_walk_one(nlru, memcg,
>  							isolate, cb_arg,
>  							nr_to_walk);
>  			spin_unlock(&nlru->lock);
> @@ -317,7 +315,11 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>  			if (*nr_to_walk <= 0)
>  				break;
>  		}
> +	} else {
> +		isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> +					      nr_to_walk);
>  	}
> +

That's a change of behaviour. The old code always runs per-node
reclaim, then if the LRU is memcg aware it also runs the memcg
aware reclaim. The new code never runs global per-node reclaim
if the list is memcg aware, so shrinkers that are initialised
with the flags SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE seem
likely to have reclaim problems with mixed memcg/global memory
pressure scenarios.

e.g. if all the memory is in the per-node lists, and the memcg needs
to reclaim memory because of a global shortage, it is now unable to
reclaim global memory.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
