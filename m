Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC9440CAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhJaDuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Oct 2021 23:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJaDuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Oct 2021 23:50:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBFC061570;
        Sat, 30 Oct 2021 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XXKtskoQytpq/cNWilbNSYHCXWwfn9D22pJ1O4PYUmQ=; b=pP8ETLVWc6u278giveJ9semfXz
        JQ5424ZBl7Nh1bomhHF8RHu74lA41t+UP/+5bejp9nIakciDo/UC6Y8huoN9pnZe/wT2ClFw4IBQC
        5kTFrNQdFnw6tk5i4beMvdtwlfvrozzACmCjiiZLBeXrOA67rjsqVEVBhU3q8DG81UwD/9CfdlYii
        trJA84XImYIXe2/LsMSX60okh99CW4jhIXGoAAjJSfj/eOQHT592RqKXsQJnYPfR55P+e+GXkLXof
        ALtPVVd//dde5vM7R7yezTQZt/w4q1N4Wcr7GTPjaS21QyNhUiuT43CugHxTrx3/MjCbKKb4BCfxu
        NPT2VEjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mh1ne-002pM5-0A; Sun, 31 Oct 2021 03:46:32 +0000
Date:   Sun, 31 Oct 2021 03:46:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Yu Zhao <yuzhao@google.com>, Zi Yan <ziy@nvidia.com>,
        Nick Piggin <npiggin@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Darrick Wong <djwong@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [GIT PULL] Memory folios for v5.16
Message-ID: <YX4RkYNNZtO9WL0L@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Almost all page state is not actually present on tail pages and attempting
to access it (eg page->index) will return incorrect information.  This
patch series introduces the new type 'folio' to represent non-tail pages.

The point of all this churn is to allow filesystems and the page cache
to manage memory in larger chunks than PAGE_SIZE.  The original plan was
to use compound pages like THP does, but I ran into problems with some
functions expecting only a head page while others expect the precise
page containing a particular byte.  The folio type allows a function
to declare that it's expecting only a head page.  Almost incidentally,
this allows us to remove various calls to VM_BUG_ON(PageTail(page))
and compound_head().

This pull request converts just parts of the core MM and the page cache.
For 5.17, we intend to convert various filesystems (XFS and AFS are ready;
other filesystems may make it) and also convert more of the MM and page
cache to folios.  For 5.18, multi-page folios should be ready.

The multi-page folios offer some improvement to some workloads.  The 80%
win is real, but appears to be an artificial benchmark (postgres startup,
which isn't a serious workload).  Real workloads (eg building the kernel,
running postgres in a steady state, etc) seem to benefit between 0-10%.
I haven't heard of any performance losses as a result of this series.
Nobody has done any serious performance tuning; I imagine that tweaking
the readahead algorithm could provide some more interesting wins.
There are also other places where we could choose to create large folios
and currently do not, such as writes that are larger than PAGE_SIZE.

I'd like to thank all my reviewers who've offered review/ack tags:
Christoph Hellwig, David Howells, Jan Kara, Jeff Layton, Johannes Weiner,
Kirill A. Shutemov, Michal Hocko, Mike Rapoport, Vlastimil Babka,
William Kucharski, Yu Zhao and Zi Yan.

I'd also like to thank those who gave feedback I incorporated but haven't
offered up review tags for this part of the series: Nick Piggin, Mel
Gorman, Ming Lei, Darrick Wong, Ted Ts'o, John Hubbard, Hugh Dickins,
and probably a few others who I forget.

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16

for you to fetch changes up to 121703c1c817b3c77f61002466d0bfca7e39f25d:

  mm/writeback: Add folio_write_one (2021-10-18 07:49:41 -0400)

----------------------------------------------------------------
Memory folios

Add memory folios, a new type to represent either order-0 pages or
the head page of a compound page.  This should be enough infrastructure
to support filesystems converting from pages to folios.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (90):
      mm: Convert get_page_unless_zero() to return bool
      mm: Introduce struct folio
      mm: Add folio_pgdat(), folio_zone() and folio_zonenum()
      mm/vmstat: Add functions to account folio statistics
      mm/debug: Add VM_BUG_ON_FOLIO() and VM_WARN_ON_ONCE_FOLIO()
      mm: Add folio reference count functions
      mm: Add folio_put()
      mm: Add folio_get()
      mm: Add folio_try_get_rcu()
      mm: Add folio flag manipulation functions
      mm/lru: Add folio LRU functions
      mm: Handle per-folio private data
      mm/filemap: Add folio_index(), folio_file_page() and folio_contains()
      mm/filemap: Add folio_next_index()
      mm/filemap: Add folio_pos() and folio_file_pos()
      mm/util: Add folio_mapping() and folio_file_mapping()
      mm/filemap: Add folio_unlock()
      mm/filemap: Add folio_lock()
      mm/filemap: Add folio_lock_killable()
      mm/filemap: Add __folio_lock_async()
      mm/filemap: Add folio_wait_locked()
      mm/filemap: Add __folio_lock_or_retry()
      mm/swap: Add folio_rotate_reclaimable()
      mm/filemap: Add folio_end_writeback()
      mm/writeback: Add folio_wait_writeback()
      mm/writeback: Add folio_wait_stable()
      mm/filemap: Add folio_wait_bit()
      mm/filemap: Add folio_wake_bit()
      mm/filemap: Convert page wait queues to be folios
      mm/filemap: Add folio private_2 functions
      fs/netfs: Add folio fscache functions
      mm: Add folio_mapped()
      mm: Add folio_nid()
      mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
      mm/memcg: Use the node id in mem_cgroup_update_tree()
      mm/memcg: Remove soft_limit_tree_node()
      mm/memcg: Convert memcg_check_events to take a node ID
      mm/memcg: Add folio_memcg() and related functions
      mm/memcg: Convert commit_charge() to take a folio
      mm/memcg: Convert mem_cgroup_charge() to take a folio
      mm/memcg: Convert uncharge_page() to uncharge_folio()
      mm/memcg: Convert mem_cgroup_uncharge() to take a folio
      mm/memcg: Convert mem_cgroup_migrate() to take folios
      mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
      mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
      mm/memcg: Convert mem_cgroup_move_account() to use a folio
      mm/memcg: Add folio_lruvec()
      mm/memcg: Add folio_lruvec_lock() and similar functions
      mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
      mm/workingset: Convert workingset_activation to take a folio
      mm: Add folio_pfn()
      mm: Add folio_raw_mapping()
      mm: Add flush_dcache_folio()
      mm: Add kmap_local_folio()
      mm: Add arch_make_folio_accessible()
      mm: Add folio_young and folio_idle
      mm/swap: Add folio_activate()
      mm/swap: Add folio_mark_accessed()
      mm/rmap: Add folio_mkclean()
      mm/migrate: Add folio_migrate_mapping()
      mm/migrate: Add folio_migrate_flags()
      mm/migrate: Add folio_migrate_copy()
      mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
      flex_proportions: Allow N events instead of 1
      mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
      mm/writeback: Add __folio_end_writeback()
      mm/writeback: Add folio_start_writeback()
      mm/writeback: Add folio_mark_dirty()
      mm/writeback: Add __folio_mark_dirty()
      mm/writeback: Convert tracing writeback_page_template to folios
      mm/writeback: Add filemap_dirty_folio()
      mm/writeback: Add folio_account_cleaned()
      mm/writeback: Add folio_cancel_dirty()
      mm/writeback: Add folio_clear_dirty_for_io()
      mm/writeback: Add folio_account_redirty()
      mm/writeback: Add folio_redirty_for_writepage()
      mm/filemap: Add i_blocks_per_folio()
      mm/filemap: Add folio_mkwrite_check_truncate()
      mm/filemap: Add readahead_folio()
      mm/workingset: Convert workingset_refault() to take a folio
      mm: Add folio_evictable()
      mm/lru: Convert __pagevec_lru_add_fn to take a folio
      mm/lru: Add folio_add_lru()
      mm/page_alloc: Add folio allocation functions
      mm/filemap: Add filemap_alloc_folio
      mm/filemap: Add filemap_add_folio()
      mm/filemap: Convert mapping_get_entry to return a folio
      mm/filemap: Add filemap_get_folio
      mm/filemap: Add FGP_STABLE
      mm/writeback: Add folio_write_one

 Documentation/core-api/cachetlb.rst         |   6 +
 Documentation/core-api/mm-api.rst           |   5 +
 Documentation/filesystems/netfs_library.rst |   2 +
 arch/arc/include/asm/cacheflush.h           |   1 +
 arch/arm/include/asm/cacheflush.h           |   1 +
 arch/m68k/include/asm/cacheflush_mm.h       |   1 +
 arch/mips/include/asm/cacheflush.h          |   2 +
 arch/nds32/include/asm/cacheflush.h         |   1 +
 arch/nios2/include/asm/cacheflush.h         |   3 +-
 arch/parisc/include/asm/cacheflush.h        |   3 +-
 arch/sh/include/asm/cacheflush.h            |   3 +-
 arch/xtensa/include/asm/cacheflush.h        |   5 +-
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
 include/linux/memcontrol.h                  | 264 ++++++++-----
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
 mm/filemap.c                                | 567 +++++++++++++--------------
 mm/folio-compat.c                           | 142 +++++++
 mm/huge_memory.c                            |   7 +-
 mm/hugetlb.c                                |   2 +-
 mm/internal.h                               |  36 +-
 mm/khugepaged.c                             |   8 +-
 mm/ksm.c                                    |  34 +-
 mm/memcontrol.c                             | 356 +++++++++--------
 mm/memory-failure.c                         |   2 +-
 mm/memory.c                                 |  20 +-
 mm/mempolicy.c                              |  10 +
 mm/memremap.c                               |   2 +-
 mm/migrate.c                                | 189 +++++----
 mm/mlock.c                                  |   3 +-
 mm/page-writeback.c                         | 476 ++++++++++++----------
 mm/page_alloc.c                             |  14 +-
 mm/page_io.c                                |   4 +-
 mm/page_owner.c                             |  10 +-
 mm/rmap.c                                   |  14 +-
 mm/shmem.c                                  |   7 +-
 mm/swap.c                                   | 197 +++++-----
 mm/swap_state.c                             |   2 +-
 mm/swapfile.c                               |   8 +-
 mm/userfaultfd.c                            |   2 +-
 mm/util.c                                   | 111 +++---
 mm/vmscan.c                                 |   8 +-
 mm/workingset.c                             |  52 +--
 74 files changed, 2914 insertions(+), 1703 deletions(-)
 create mode 100644 mm/folio-compat.c

