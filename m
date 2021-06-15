Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAE3A770F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFOG2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:28:53 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:44632 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhFOG2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:28:52 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B18AE1B09FE;
        Tue, 15 Jun 2021 16:26:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lt2X2-00CwZc-J7; Tue, 15 Jun 2021 16:26:40 +1000
Date:   Tue, 15 Jun 2021 16:26:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <20210615062640.GD2419729@dread.disaster.area>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614211904.14420-4-hannes@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8
        a=8jYAFbLjmWtUauaYE_oA:9 a=4MXh3Kx2VhTFdy_E:21 a=DcKEzcW9z-AyDCMr:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> Historically (pre-2.5), the inode shrinker used to reclaim only empty
> inodes and skip over those that still contained page cache. This
> caused problems on highmem hosts: struct inode could put fill lowmem
> zones before the cache was getting reclaimed in the highmem zones.
> 
> To address this, the inode shrinker started to strip page cache to
> facilitate reclaiming lowmem. However, this comes with its own set of
> problems: the shrinkers may drop actively used page cache just because
> the inodes are not currently open or dirty - think working with a
> large git tree. It further doesn't respect cgroup memory protection
> settings and can cause priority inversions between containers.
> 
> Nowadays, the page cache also holds non-resident info for evicted
> cache pages in order to detect refaults. We've come to rely heavily on
> this data inside reclaim for protecting the cache workingset and
> driving swap behavior. We also use it to quantify and report workload
> health through psi. The latter in turn is used for fleet health
> monitoring, as well as driving automated memory sizing of workloads
> and containers, proactive reclaim and memory offloading schemes.
> 
> The consequences of dropping page cache prematurely is that we're
> seeing subtle and not-so-subtle failures in all of the above-mentioned
> scenarios, with the workload generally entering unexpected thrashing
> states while losing the ability to reliably detect it.
> 
> To fix this on non-highmem systems at least, going back to rotating
> inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
> ("mm: don't reclaim inodes with many attached pages")) and failed
> (commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
> attached pages"")). The issue is mostly that shrinker pools attract
> pressure based on their size, and when objects get skipped the
> shrinkers remember this as deferred reclaim work. This accumulates
> excessive pressure on the remaining inodes, and we can quickly eat
> into heavily used ones, or dirty ones that require IO to reclaim, when
> there potentially is plenty of cold, clean cache around still.
> 
> Instead, this patch keeps populated inodes off the inode LRU in the
> first place - just like an open file or dirty state would. An
> otherwise clean and unused inode then gets queued when the last cache
> entry disappears. This solves the problem without reintroducing the
> reclaim issues, and generally is a bit more scalable than having to
> wade through potentially hundreds of thousands of busy inodes.
> 
> Locking is a bit tricky because the locks protecting the inode state
> (i_lock) and the inode LRU (lru_list.lock) don't nest inside the
> irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
> serialized through i_lock, taken before the i_pages lock, to make sure
> depopulated inodes are queued reliably. Additions may race with
> deletions, but we'll check again in the shrinker. If additions race
> with the shrinker itself, we're protected by the i_lock: if
> find_inode() or iput() win, the shrinker will bail on the elevated
> i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
> inode, it will set I_FREEING and inhibit further igets(), which will
> cause the other side to create a new instance of the inode instead.

This makes an awful mess of the inode locking and, to me, is a
serious layering violation....

> index e89df447fae3..c9956fac640e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -23,6 +23,56 @@ static inline bool mapping_empty(struct address_space *mapping)
>  	return xa_empty(&mapping->i_pages);
>  }
>  
> +/*
> + * mapping_shrinkable - test if page cache state allows inode reclaim
> + * @mapping: the page cache mapping
> + *
> + * This checks the mapping's cache state for the pupose of inode
> + * reclaim and LRU management.
> + *
> + * The caller is expected to hold the i_lock, but is not required to
> + * hold the i_pages lock, which usually protects cache state. That's
> + * because the i_lock and the list_lru lock that protect the inode and
> + * its LRU state don't nest inside the irq-safe i_pages lock.
> + *
> + * Cache deletions are performed under the i_lock, which ensures that
> + * when an inode goes empty, it will reliably get queued on the LRU.
> + *
> + * Cache additions do not acquire the i_lock and may race with this
> + * check, in which case we'll report the inode as shrinkable when it
> + * has cache pages. This is okay: the shrinker also checks the
> + * refcount and the referenced bit, which will be elevated or set in
> + * the process of adding new cache pages to an inode.
> + */

.... because you're expanding the inode->i_lock to now
cover the page cache additions and removal and that massively
increases the scope of the i_lock. The ilock is for internal inode
serialisation purposes, not serialisation with external subsystems
that inodes interact with like mappings.

> +static inline bool mapping_shrinkable(struct address_space *mapping)
> +{
> +	void *head;
> +
> +	/*
> +	 * On highmem systems, there could be lowmem pressure from the
> +	 * inodes before there is highmem pressure from the page
> +	 * cache. Make inodes shrinkable regardless of cache state.
> +	 */
> +	if (IS_ENABLED(CONFIG_HIGHMEM))
> +		return true;
> +
> +	/* Cache completely empty? Shrink away. */
> +	head = rcu_access_pointer(mapping->i_pages.xa_head);
> +	if (!head)
> +		return true;
> +
> +	/*
> +	 * The xarray stores single offset-0 entries directly in the
> +	 * head pointer, which allows non-resident page cache entries
> +	 * to escape the shadow shrinker's list of xarray nodes. The
> +	 * inode shrinker needs to pick them up under memory pressure.
> +	 */
> +	if (!xa_is_node(head) && xa_is_value(head))
> +		return true;
> +
> +	return false;
> +}

It just occurred to me: mapping_shrinkable() == available for
shrinking, not "mapping can be shrunk by having pages freed from
it".

If this lives, it really needs a better name and API - this isn't
applying a check of whether the mapping can be shrunk, it indicates
whether the inode hosting the mapping is considered freeable or not.

>  /*
>   * Bits in mapping->flags.
>   */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 819d2589abef..0d0d72ced961 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -260,9 +260,13 @@ void delete_from_page_cache(struct page *page)
>  	struct address_space *mapping = page_mapping(page);
>  
>  	BUG_ON(!PageLocked(page));
> +	spin_lock(&mapping->host->i_lock);
>  	xa_lock_irq(&mapping->i_pages);
>  	__delete_from_page_cache(page, NULL);
>  	xa_unlock_irq(&mapping->i_pages);
> +	if (mapping_shrinkable(mapping))
> +		inode_add_lru(mapping->host);
> +	spin_unlock(&mapping->host->i_lock);
>  

This, to me is an example of the layering problesm here. No mapping
specific function should be using locks that belong to the mapping
host for internal mapping serialisation.

Especially considering that inode_add_lru() is defined in
fs/internal.h - nothing outside the core fs code should really be
using inode_add_lru(), just lik enothing outside of fs code should
be using the inode->i_lock for anything.

This just doesn't seem like a robust, maintainable solution to the
problem you're trying to address....

> @@ -73,8 +77,10 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>  		return;
>  
>  	dax = dax_mapping(mapping);
> -	if (!dax)
> +	if (!dax) {
> +		spin_lock(&mapping->host->i_lock);
>  		xa_lock_irq(&mapping->i_pages);
> +	}
>  
>  	for (i = j; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> @@ -93,8 +99,12 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>  		__clear_shadow_entry(mapping, index, page);
>  	}
>  
> -	if (!dax)
> +	if (!dax) {
>  		xa_unlock_irq(&mapping->i_pages);
> +		if (mapping_shrinkable(mapping))
> +			inode_add_lru(mapping->host);
> +		spin_unlock(&mapping->host->i_lock);
> +	}
>  	pvec->nr = j;
>  }

No. Just no.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cc5d7cd75935..6dd5ef8a11bc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1055,6 +1055,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  	BUG_ON(!PageLocked(page));
>  	BUG_ON(mapping != page_mapping(page));
>  
> +	if (!PageSwapCache(page))
> +		spin_lock(&mapping->host->i_lock);
>  	xa_lock_irq(&mapping->i_pages);
>  	/*
>  	 * The non racy check for a busy page.
> @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  			shadow = workingset_eviction(page, target_memcg);
>  		__delete_from_page_cache(page, shadow);
>  		xa_unlock_irq(&mapping->i_pages);
> +		if (mapping_shrinkable(mapping))
> +			inode_add_lru(mapping->host);
> +		spin_unlock(&mapping->host->i_lock);
>  

No. Inode locks have absolutely no place serialising core vmscan
algorithms.

Really, all this complexity because:

| The issue is mostly that shrinker pools attract pressure based on
| their size, and when objects get skipped the shrinkers remember this
| as deferred reclaim work.

And so you want inodes with reclaimable mappings to avoid being
considered deferred work for the inode shrinker. That's what is
occuring because we are currently returning LRU_RETRY to them, or
would also happen if we returned LRU_SKIP or LRU_ROTATE just to
ignore them.

However, it's trivial to change inode_lru_isolate() to do something
like:

	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
		if (!IS_ENABLED(CONFIG_HIGHMEM)) {
			spin_unlock(&inode->i_lock);
			return LRU_ROTATE_NODEFER;
		}
		.....
	}

And in __list_lru_walk_one() just add:

		case LRU_ROTATE_NODEFER:
			isolated++;
			/* fallthrough */
		case LRU_ROTATE:
			list_move_tail(item, &l->list);
			break;

And now inodes with active page cache  rotated to the tail of the
list and are considered to have had work done on them. Hence they
don't add to the work accumulation that the shrinker infrastructure
defers, and so will allow the page reclaim to do it's stuff with
page reclaim before such inodes will get reclaimed.

That's *much* simpler than your proposed patch and should get you
pretty much the same result.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
