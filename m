Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2090F1300B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 04:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgADDzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 22:55:08 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36825 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgADDzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:55:08 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1F5D47E90CB;
        Sat,  4 Jan 2020 14:55:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1inaWj-0008JK-8d; Sat, 04 Jan 2020 14:55:01 +1100
Date:   Sat, 4 Jan 2020 14:55:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 5/5] memcg, inode: protect page cache from freeing
 inode
Message-ID: <20200104035501.GE23195@dread.disaster.area>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-6-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577174006-13025-6-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=Oh9UgjFkKrP7v1tT2gIA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:53:26AM -0500, Yafang Shao wrote:
> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.
> Once an inode is freed, all its belonging page caches will be dropped as
> well, no matter how may page caches it has. So if we intend to protect the
> page caches in a memcg, we must protect their host (the inode) first.
> Otherwise the memcg protection can be easily bypassed with freeing inode,
> especially if there're big files in this memcg.
> 
> Supposes we have a memcg, and the stat of this memcg is,
> 	memory.current = 1024M
> 	memory.min = 512M
> And in this memcg there's a inode with 800M page caches.
> Once this memcg is scanned by kswapd or other regular reclaimers,
>     kswapd <<<< It can be either of the regular reclaimers.
>         shrink_node_memcgs
> 	    switch (mem_cgroup_protected()) <<<< Not protected
> 		case MEMCG_PROT_NONE:  <<<< Will scan this memcg
> 			beak;
>             shrink_lruvec() <<<< Reclaim the page caches
>             shrink_slab()   <<<< It may free this inode and drop all its
>                                  page caches(800M).
> So we must protect the inode first if we want to protect page caches.
> 
> The inherent mismatch between memcg and inode is a trouble. One inode can
> be shared by different MEMCGs, but it is a very rare case. If an inode is
> shared, its belonging page caches may be charged to different MEMCGs.
> Currently there's no perfect solution to fix this kind of issue, but the
> inode majority-writer ownership switching can help it more or less.

There's multiple changes in this patch set. Yes, there's some inode
cache futzing to deal with memcgs, but it also adds some weird
undocumented "in low reclaim" heuristic that does something magical
with "protection" that you don't describe or document at all. PLease
separate that out into a new patch and document it clearly (both in
the commit message and the code, please).

> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a..4f4b2f3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -54,6 +54,13 @@
>   *   inode_hash_lock
>   */
>  
> +struct inode_head {

not an "inode head" structure. They are inode isolation arguments.
i.e. struct inode_isolation_args {...};

> +	struct list_head *freeable;
> +#ifdef CONFIG_MEMCG_KMEM
> +	struct mem_cgroup *memcg;
> +#endif
> +};

These defines are awful, too, and completely unnecesarily because
the struct shrink_control unconditionally defines sc->memcg and
so we can just code it throughout without caring whether memcgs are
enabled or not.

> +
>  static unsigned int i_hash_mask __read_mostly;
>  static unsigned int i_hash_shift __read_mostly;
>  static struct hlist_head *inode_hashtable __read_mostly;
> @@ -724,8 +731,10 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>  static enum lru_status inode_lru_isolate(struct list_head *item,
>  		struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
>  {
> -	struct list_head *freeable = arg;
> +	struct inode_head *ihead = (struct inode_head *)arg;

No need for a cast of a void *.

> +	struct list_head *freeable = ihead->freeable;
>  	struct inode	*inode = container_of(item, struct inode, i_lru);
> +	struct mem_cgroup *memcg = NULL;

	struct inode_isolation_args *iargs = arg;
	struct list_head *freeable = iargs->freeable;
	struct mem_cgroup *memcg = iargs->memcg;
	struct inode	*inode = container_of(item, struct inode, i_lru);

> @@ -734,6 +743,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	if (!spin_trylock(&inode->i_lock))
>  		return LRU_SKIP;
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	memcg = ihead->memcg;
> +#endif

This is no longer necessary.

> +	if (memcg && inode->i_data.nrpages &&
> +	    !(memcg_can_reclaim_inode(memcg, inode))) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_ROTATE;
> +	}

I'd argue that both the memcg and the inode->i_data.nrpages check
should be inside memcg_can_reclaim_inode(), that way this entire
chunk of code disappears when CONFIG_MEMCG_KMEM=N.

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f36ada9..d1d4175 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -247,6 +247,9 @@ struct mem_cgroup {
>  	unsigned int tcpmem_active : 1;
>  	unsigned int tcpmem_pressure : 1;
>  
> +	/* Soft protection will be ignored if it's true */
> +	unsigned int in_low_reclaim : 1;

This is the stuff that has nothing to do with the changes to the
inode reclaim shrinker...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
