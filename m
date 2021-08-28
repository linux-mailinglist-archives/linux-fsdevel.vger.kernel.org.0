Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49713FA35B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhH1DbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhH1DbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 23:31:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E507C0613D9;
        Fri, 27 Aug 2021 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vG2BrsxklzvaYU3MGJElnbZXqonpHe4yr8aACjbagfc=; b=HB5IqswwGXiCJh9Egt+aPJbO8Y
        croLE9MB+SlJ6K5TAqN9IwM0Fjv30ThTPO7HLk3Hpb1NytmMADsGvT0RvUg7/fGRUGAUq8Mfd/B0N
        K3rxdNiSTnEfoblUSEXhMXIVjgMtjz/SB1OZ0T8+M560UKjXHo+G3fKfueTN7k7tFJkgSGBqnZ3tJ
        1bU8kj99ZZTkdY22aVbafskcujM5dy388q7QUt6U85VR/RorIpDs2s1+tcmJ/shqHogZlN/XYM1Gx
        TOhppVGTks18RyTK4QvvJO5Ml776E59oM+kPkvHECJGyylnpQMV9Mbn7ZFJ9OfkJXE+F32q8LNZm/
        27Neq4KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJp1x-00FFSp-IG; Sat, 28 Aug 2021 03:29:25 +0000
Date:   Sat, 28 Aug 2021 04:29:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSmtjVTqR9/4W1aq@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPwmNNuuQhXNToQ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:01:44PM +0100, Matthew Wilcox wrote:
> The following changes since commit f0eb870a84224c9bfde0dc547927e8df1be4267c:
> 
>   Merge tag 'xfs-5.14-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2021-07-18 11:27:25 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.15
> 
> for you to fetch changes up to 1a90e9dae32ce26de43c1c5eddb3ecce27f2a640:
> 
>   mm/writeback: Add folio_write_one (2021-08-15 23:04:07 -0400)

Running 'sed -i' across the patches and reapplying them got me this:

The following changes since commit f0eb870a84224c9bfde0dc547927e8df1be4267c:

  Merge tag 'xfs-5.14-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2021-07-18 11:27:25 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/pageset-5.15

for you to fetch changes up to dc185ab836d41729f15b2925a59c7dc29ae72377:

  mm/writeback: Add pageset_write_one (2021-08-27 22:52:26 -0400)

----------------------------------------------------------------
Pagesets

Add pagesets, a new type to represent either an order-0 page or the
head page of a compound page.  This should be enough infrastructure to
support filesystems converting from pages to pagesets.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (90):
      mm: Convert get_page_unless_zero() to return bool
      mm: Introduce struct pageset
      mm: Add pageset_pgdat(), pageset_zone() and pageset_zonenum()
      mm/vmstat: Add functions to account pageset statistics
      mm/debug: Add VM_BUG_ON_PAGESET() and VM_WARN_ON_ONCE_PAGESET()
      mm: Add pageset reference count functions
      mm: Add pageset_put()
      mm: Add pageset_get()
      mm: Add pageset_try_get_rcu()
      mm: Add pageset flag manipulation functions
      mm/lru: Add pageset LRU functions
      mm: Handle per-pageset private data
      mm/filemap: Add pageset_index(), pageset_file_page() and pageset_contains()
      mm/filemap: Add pageset_next_index()
      mm/filemap: Add pageset_pos() and pageset_file_pos()
      mm/util: Add pageset_mapping() and pageset_file_mapping()
      mm/filemap: Add pageset_unlock()
      mm/filemap: Add pageset_lock()
      mm/filemap: Add pageset_lock_killable()
      mm/filemap: Add __pageset_lock_async()
      mm/filemap: Add pageset_wait_locked()
      mm/filemap: Add __pageset_lock_or_retry()
      mm/swap: Add pageset_rotate_reclaimable()
      mm/filemap: Add pageset_end_writeback()
      mm/writeback: Add pageset_wait_writeback()
      mm/writeback: Add pageset_wait_stable()
      mm/filemap: Add pageset_wait_bit()
      mm/filemap: Add pageset_wake_bit()
      mm/filemap: Convert page wait queues to be pagesets
      mm/filemap: Add pageset private_2 functions
      fs/netfs: Add pageset fscache functions
      mm: Add pageset_mapped()
      mm: Add pageset_nid()
      mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
      mm/memcg: Use the node id in mem_cgroup_update_tree()
      mm/memcg: Remove soft_limit_tree_node()
      mm/memcg: Convert memcg_check_events to take a node ID
      mm/memcg: Add pageset_memcg() and related functions
      mm/memcg: Convert commit_charge() to take a pageset
      mm/memcg: Convert mem_cgroup_charge() to take a pageset
      mm/memcg: Convert uncharge_page() to uncharge_pageset()
      mm/memcg: Convert mem_cgroup_uncharge() to take a pageset
      mm/memcg: Convert mem_cgroup_migrate() to take pagesets
      mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to pageset
      mm/memcg: Add pageset_memcg_lock() and pageset_memcg_unlock()
      mm/memcg: Convert mem_cgroup_move_account() to use a pageset
      mm/memcg: Add pageset_lruvec()
      mm/memcg: Add pageset_lruvec_lock() and similar functions
      mm/memcg: Add pageset_lruvec_relock_irq() and pageset_lruvec_relock_irqsave()
      mm/workingset: Convert workingset_activation to take a pageset
      mm: Add pageset_pfn()
      mm: Add pageset_raw_mapping()
      mm: Add flush_dcache_pageset()
      mm: Add kmap_local_pageset()
      mm: Add arch_make_pageset_accessible()
      mm: Add pageset_young and pageset_idle
      mm/swap: Add pageset_activate()
      mm/swap: Add pageset_mark_accessed()
      mm/rmap: Add pageset_mkclean()
      mm/migrate: Add pageset_migrate_mapping()
      mm/migrate: Add pageset_migrate_flags()
      mm/migrate: Add pageset_migrate_copy()
      mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
      flex_proportions: Allow N events instead of 1
      mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
      mm/writeback: Add __pageset_end_writeback()
      mm/writeback: Add pageset_start_writeback()
      mm/writeback: Add pageset_mark_dirty()
      mm/writeback: Add __pageset_mark_dirty()
      mm/writeback: Convert tracing writeback_page_template to pagesets
      mm/writeback: Add filemap_dirty_pageset()
      mm/writeback: Add pageset_account_cleaned()
      mm/writeback: Add pageset_cancel_dirty()
      mm/writeback: Add pageset_clear_dirty_for_io()
      mm/writeback: Add pageset_account_redirty()
      mm/writeback: Add pageset_redirty_for_writepage()
      mm/filemap: Add i_blocks_per_pageset()
      mm/filemap: Add pageset_mkwrite_check_truncate()
      mm/filemap: Add readahead_pageset()
      mm/workingset: Convert workingset_refault() to take a pageset
      mm: Add pageset_evictable()
      mm/lru: Convert __pagevec_lru_add_fn to take a pageset
      mm/lru: Add pageset_add_lru()
      mm/page_alloc: Add pageset allocation functions
      mm/filemap: Add filemap_alloc_pageset
      mm/filemap: Add filemap_add_pageset()
      mm/filemap: Convert mapping_get_entry to return a pageset
      mm/filemap: Add filemap_get_pageset
      mm/filemap: Add FGP_STABLE
      mm/writeback: Add pageset_write_one

 Documentation/core-api/cachetlb.rst         |   6 +
 Documentation/core-api/mm-api.rst           |   5 +
 Documentation/filesystems/netfs_library.rst |   2 +
 arch/arc/include/asm/cacheflush.h           |   1 +
 arch/arm/include/asm/cacheflush.h           |   1 +
 arch/mips/include/asm/cacheflush.h          |   2 +
 arch/nds32/include/asm/cacheflush.h         |   1 +
 arch/nios2/include/asm/cacheflush.h         |   3 +-
 arch/parisc/include/asm/cacheflush.h        |   3 +-
 arch/sh/include/asm/cacheflush.h            |   3 +-
 arch/xtensa/include/asm/cacheflush.h        |   3 +-
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 fs/jfs/jfs_metapage.c                       |   1 +
 include/asm-generic/cacheflush.h            |   6 +
 include/linux/backing-dev.h                 |   6 +-
 include/linux/flex_proportions.h            |   9 +-
 include/linux/gfp.h                         |  22 +-
 include/linux/highmem-internal.h            |  11 +
 include/linux/highmem.h                     |  37 ++
 include/linux/huge_mm.h                     |  15 -
 include/linux/ksm.h                         |   4 +-
 include/linux/memcontrol.h                  | 231 ++++++-----
 include/linux/migrate.h                     |   4 +
 include/linux/mm.h                          | 239 +++++++++---
 include/linux/mm_inline.h                   | 103 +++--
 include/linux/mm_types.h                    |  77 ++++
 include/linux/mmdebug.h                     |  20 +
 include/linux/netfs.h                       |  77 ++--
 include/linux/page-flags.h                  | 267 +++++++++----
 include/linux/page_idle.h                   |  99 +++--
 include/linux/page_owner.h                  |   8 +-
 include/linux/page_ref.h                    | 158 +++++++-
 include/linux/pagemap.h                     | 585 ++++++++++++++++++----------
 include/linux/rmap.h                        |  10 +-
 include/linux/swap.h                        |  17 +-
 include/linux/vmstat.h                      | 113 +++++-
 include/linux/writeback.h                   |   9 +-
 include/trace/events/pagemap.h              |  46 ++-
 include/trace/events/writeback.h            |  28 +-
 kernel/bpf/verifier.c                       |   2 +-
 kernel/events/uprobes.c                     |   3 +-
 lib/flex_proportions.c                      |  28 +-
 mm/Makefile                                 |   2 +-
 mm/compaction.c                             |   4 +-
 mm/filemap.c                                | 575 +++++++++++++--------------
 mm/huge_memory.c                            |   7 +-
 mm/hugetlb.c                                |   2 +-
 mm/internal.h                               |  36 +-
 mm/khugepaged.c                             |   8 +-
 mm/ksm.c                                    |  34 +-
 mm/memcontrol.c                             | 358 +++++++++--------
 mm/memory-failure.c                         |   2 +-
 mm/memory.c                                 |  20 +-
 mm/mempolicy.c                              |  10 +
 mm/memremap.c                               |   2 +-
 mm/migrate.c                                | 189 +++++----
 mm/mlock.c                                  |   3 +-
 mm/page-writeback.c                         | 477 +++++++++++++----------
 mm/page_alloc.c                             |  14 +-
 mm/page_io.c                                |   4 +-
 mm/page_owner.c                             |  10 +-
 mm/pageset-compat.c                         | 142 +++++++
 mm/rmap.c                                   |  14 +-
 mm/shmem.c                                  |   7 +-
 mm/swap.c                                   | 197 +++++-----
 mm/swap_state.c                             |   2 +-
 mm/swapfile.c                               |   8 +-
 mm/userfaultfd.c                            |   2 +-
 mm/util.c                                   | 111 +++---
 mm/vmscan.c                                 |   8 +-
 mm/workingset.c                             |  52 +--
 73 files changed, 2900 insertions(+), 1692 deletions(-)
 create mode 100644 mm/pageset-compat.c
