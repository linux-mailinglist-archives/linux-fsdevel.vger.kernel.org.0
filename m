Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F43C967E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGODkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGODkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:40:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C7C06175F;
        Wed, 14 Jul 2021 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RMgBD9KGeNySRCEz7uLJubVuKLqdCwpoG22m5uzWPxI=; b=DX+kVkjXQVjdbRJUvKNmminOVl
        L30pCFEzUIJaqqMhHrO/UPWaHWwHQBwhMVIxOjSOM9weuGR+9uY0BTsah0Ql/RX++nm7APYS029e0
        BJ4nyEk/I+HuIZ2+YGguBPzWoatjsDNZxUpI8Dh7yZIfb3gvKqHwKvGgyFb/cWHRVNhLt3bni+jeh
        v9mix3P73qGh/Xz71SwaDH5xVhHaBLF4XFxewgOSvicfo12AduPethtrqY9mJOIMxMOCT7xhHPefB
        32kyfjUc/P8Pr1iksPPkkHU6GU/wLNfnBKOhAszLFJd2bJO1+SnDH+ZFVu887eqMHyLKoTwb4HT8D
        JcbTHGzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sBU-002uHc-3u; Thu, 15 Jul 2021 03:37:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 000/138] Memory folios
Date:   Thu, 15 Jul 2021 04:34:46 +0100
Message-Id: <20210715033704.692967-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
benefit from a larger "page size".  As an example, an earlier iteration
of this idea which used compound pages (and wasn't particularly tuned)
got a 7% performance boost when compiling the kernel.

Using compound pages or THPs exposes a weakness of our type system.
Functions are often unprepared for compound pages to be passed to them,
and may only act on PAGE_SIZE chunks.  Even functions which are aware of
compound pages may expect a head page, and do the wrong thing if passed
a tail page.

We also waste a lot of instructions ensuring that we're not looking at
a tail page.  Almost every call to PageFoo() contains one or more hidden
calls to compound_head().  This also happens for get_page(), put_page()
and many more functions.

This patch series uses a new type, the struct folio, to manage memory.
It converts enough of the page cache, iomap and XFS to use folios instead
of pages, and then adds support for multi-page folios.  It passes xfstests
(running on XFS) with no regressions compared to v5.14-rc1.

Git: https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/tags/folio_14

v14:
 - Defined folio_memcg() for !CONFIG_MEMCG builds
 - Fixed typo in folio_activate() for !SMP builds
 - Fixed missed conversion of folio_rmapping to folio_raw_mapping in KSM
 - Fixed hugetlb's new dependency on copy_huge_page() by introducing
   folio_copy()
 - Changed the LRU page API to be entirely wrappers around the folio versions
 - Removed page_lru() entirely
 - Renamed folio_add_to_lru_list() -> lruvec_add_folio()
 - Renamed folio_add_to_lru_list_tail() -> lruvec_add_folio_tail()
 - Renamed folio_del_from_lru_list() -> lruvec_del_folio()
 - Changed folio flag operations to be:
   - folio_test_foo()
   - folio_test_set_foo()
   - folio_test_clear_foo()
   - folio_set_foo()
   - folio_clear_foo()
   - __folio_set_foo()
   - __folio_clear_foo()
 - Converted trace_mm_lru_activate() to take a folio
 - Converted trace_wait_on_page_writeback() to trace_folio_wait_writeback()
 - Converted trace_writeback_dirty_page() to trace_writeback_dirty_folio()
 - Converted trace_mm_lru_insertion() to take a folio
 - Renamed alloc_folio() -> folio_alloc()
 - Renamed __alloc_folio() -> __folio_alloc()
 - Renamed __alloc_folio_node() -> __folio_alloc_node()

Matthew Wilcox (Oracle) (138):
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
  mm/memcg: Add folio_lruvec_relock_irq() and
    folio_lruvec_relock_irqsave()
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
  block: Add bio_add_folio()
  block: Add bio_for_each_folio_all()
  iomap: Convert to_iomap_page to take a folio
  iomap: Convert iomap_page_create to take a folio
  iomap: Convert iomap_page_release to take a folio
  iomap: Convert iomap_releasepage to use a folio
  iomap: Convert iomap_invalidatepage to use a folio
  iomap: Pass the iomap_page into iomap_set_range_uptodate
  iomap: Use folio offsets instead of page offsets
  iomap: Convert bio completions to use folios
  iomap: Convert readahead and readpage to use a folio
  iomap: Convert iomap_page_mkwrite to use a folio
  iomap: Convert iomap_write_begin and iomap_write_end to folios
  iomap: Convert iomap_read_inline_data to take a folio
  iomap: Convert iomap_write_end_inline to take a folio
  iomap: Convert iomap_add_to_ioend to take a folio
  iomap: Convert iomap_do_writepage to use a folio
  iomap: Convert iomap_migrate_page to use folios
  mm/filemap: Convert page_cache_delete to take a folio
  mm/filemap: Convert unaccount_page_cache_page to
    filemap_unaccount_folio
  mm/filemap: Add filemap_remove_folio and __filemap_remove_folio
  mm/filemap: Convert find_get_entry to return a folio
  mm/filemap: Convert filemap_get_read_batch to use folios
  mm/filemap: Convert find_get_pages_contig to folios
  mm/filemap: Convert filemap_read_page to take a folio
  mm/filemap: Convert filemap_create_page to folio
  mm/filemap: Convert filemap_range_uptodate to folios
  mm/filemap: Convert filemap_fault to folio
  mm/filemap: Add read_cache_folio and read_mapping_folio
  mm/filemap: Convert filemap_get_pages to use folios
  mm/filemap: Convert page_cache_delete_batch to folios
  mm/filemap: Remove PageHWPoison check from next_uptodate_page()
  mm/filemap: Use folios in next_uptodate_page
  mm/filemap: Use a folio in filemap_map_pages
  fs: Convert vfs_dedupe_file_range_compare to folios
  mm/truncate,shmem: Handle truncates that split THPs
  mm/filemap: Return only head pages from find_get_entries
  mm: Use multi-index entries in the page cache
  iomap: Support multi-page folios in invalidatepage
  xfs: Support THPs
  mm/truncate: Convert invalidate_inode_pages2_range to folios
  mm/truncate: Fix invalidate_complete_page2 for THPs
  mm/vmscan: Free non-shmem THPs without splitting them
  mm: Fix READ_ONLY_THP warning
  mm: Support arbitrary THP sizes
  mm/filemap: Allow multi-page folios to be added to the page cache
  mm/vmscan: Optimise shrink_page_list for smaller THPs
  mm/readahead: Convert page_cache_async_ra() to take a folio
  mm/readahead: Add multi-page folio readahead

 Documentation/core-api/cachetlb.rst         |    6 +
 Documentation/core-api/mm-api.rst           |    4 +
 Documentation/filesystems/netfs_library.rst |    2 +
 arch/nds32/include/asm/cacheflush.h         |    1 +
 block/bio.c                                 |   21 +
 fs/afs/write.c                              |    9 +-
 fs/cachefiles/rdwr.c                        |   16 +-
 fs/io_uring.c                               |    2 +-
 fs/iomap/buffered-io.c                      |  524 ++++----
 fs/jfs/jfs_metapage.c                       |    1 +
 fs/remap_range.c                            |  116 +-
 fs/xfs/xfs_aops.c                           |   11 +-
 fs/xfs/xfs_super.c                          |    3 +-
 include/asm-generic/cacheflush.h            |    6 +
 include/linux/backing-dev.h                 |    6 +-
 include/linux/bio.h                         |   46 +-
 include/linux/flex_proportions.h            |    9 +-
 include/linux/gfp.h                         |   22 +-
 include/linux/highmem-internal.h            |   11 +
 include/linux/highmem.h                     |   38 +
 include/linux/huge_mm.h                     |   23 +-
 include/linux/ksm.h                         |    4 +-
 include/linux/memcontrol.h                  |  226 ++--
 include/linux/migrate.h                     |    4 +
 include/linux/mm.h                          |  268 +++-
 include/linux/mm_inline.h                   |   98 +-
 include/linux/mm_types.h                    |   77 ++
 include/linux/mmdebug.h                     |   20 +
 include/linux/netfs.h                       |   77 +-
 include/linux/page-flags.h                  |  267 ++--
 include/linux/page_idle.h                   |   99 +-
 include/linux/page_owner.h                  |    8 +-
 include/linux/page_ref.h                    |  158 ++-
 include/linux/pagemap.h                     |  615 +++++----
 include/linux/rmap.h                        |   10 +-
 include/linux/swap.h                        |   17 +-
 include/linux/vmstat.h                      |  107 ++
 include/linux/writeback.h                   |    9 +-
 include/trace/events/pagemap.h              |   46 +-
 include/trace/events/writeback.h            |   28 +-
 kernel/bpf/verifier.c                       |    2 +-
 kernel/events/uprobes.c                     |    3 +-
 lib/flex_proportions.c                      |   28 +-
 mm/Makefile                                 |    2 +-
 mm/compaction.c                             |    4 +-
 mm/filemap.c                                | 1285 +++++++++----------
 mm/folio-compat.c                           |  147 +++
 mm/huge_memory.c                            |   27 +-
 mm/hugetlb.c                                |    2 +-
 mm/internal.h                               |   40 +-
 mm/khugepaged.c                             |   20 +-
 mm/ksm.c                                    |   34 +-
 mm/memcontrol.c                             |  323 +++--
 mm/memory-failure.c                         |    2 +-
 mm/memory.c                                 |   20 +-
 mm/mempolicy.c                              |   10 +
 mm/memremap.c                               |    2 +-
 mm/migrate.c                                |  193 ++-
 mm/mlock.c                                  |    3 +-
 mm/page-writeback.c                         |  447 ++++---
 mm/page_alloc.c                             |   14 +-
 mm/page_io.c                                |    4 +-
 mm/page_owner.c                             |   10 +-
 mm/readahead.c                              |  108 +-
 mm/rmap.c                                   |   14 +-
 mm/shmem.c                                  |  115 +-
 mm/swap.c                                   |  180 +--
 mm/swap_state.c                             |    2 +-
 mm/swapfile.c                               |    8 +-
 mm/truncate.c                               |  193 +--
 mm/userfaultfd.c                            |    2 +-
 mm/util.c                                   |   98 +-
 mm/vmscan.c                                 |   15 +-
 mm/workingset.c                             |   44 +-
 74 files changed, 3865 insertions(+), 2551 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

