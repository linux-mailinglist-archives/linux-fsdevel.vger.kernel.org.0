Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE9373E19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhEEPIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhEEPIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:08:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF10C061574;
        Wed,  5 May 2021 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x2iXnp38r1hB0qF1pGeXq5kFsGn8s6a3uTVloIaIDJE=; b=Rlr6OxLkJqcgEZ8jJPAfzIx8tZ
        uAzG+Z+Dsk4MdrjYAd715h1zsxv6xNSlmWti0lKuOFDUIKTImuStvEYh+3AmjDigSc1nITZnxS5xO
        YhBH0IyRXZyqaw25ipgob+7KhrstTsmelTafJFi/OtYlAMphnvZ+WNsn50jkw7k8jkT1fAqyi7PLq
        OBjrEW7V0GV8JxB0pQpXI1OaTOY/y/KoklziP+0CCIQQB+Mbf/aL03ILWqkQw5z7U6isnryvFZ3Ja
        5KUpSZIzyV8Ep1JY19RfuzaE5zmg+ACanVSoDUbHqolfnUXqRpns2O6CRzP6ELAEcgRCuVNXUIeVW
        lwWXrwLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJ6c-000T53-7R; Wed, 05 May 2021 15:06:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/96] Memory folios
Date:   Wed,  5 May 2021 16:04:52 +0100
Message-Id: <20210505150628.111735-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
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
and many more functions.  There does not appear to be a way to tell gcc
that it can cache the result of compound_head(), nor is there a way to
tell it that compound_head() is idempotent.

This patch series uses a new type, the struct folio, to manage memory.
The first 8 patches are prep work that don't involve the folio at all
but fix problems I found while working on this.  Patches 9-81 introduce
infrastructure (that more than pays for itself, shrinking the kernel by
over 4kB of text).  Patches 82-96 convert iomap (ie xfs) to use folios
as an example.

Git: https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/tags/folio_9
v8: https://lore.kernel.org/linux-mm/20210430180740.2707166-1-willy@infradead.org/
Even more work that's not being submitted:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

v9:
 - Rebase onto next-20210505
 - Rename folio_test_set_foo() to folio_test_set_foo_flag() (Nick Piggin)
 - Rename folio_set_uptodate() to folio_mark_uptodate()
 - Rename trylock_folio_flag() to folio_trylock_flag()
 - Add all remaining supporting patches for iomap
 - Add iomap conversion patches

Matthew Wilcox (Oracle) (96):
  mm: Optimise nth_page for contiguous memmap
  mm: Make __dump_page static
  mm/debug: Factor PagePoisoned out of __dump_page
  mm/page_owner: Constify dump_page_owner
  mm: Make compound_head const-preserving
  mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
  mm: Constify page_count and page_ref_count
  mm: Fix struct page layout on 32-bit systems
  mm: Introduce struct folio
  mm: Add folio_pgdat and folio_zone
  mm/vmstat: Add functions to account folio statistics
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add folio reference count functions
  mm: Add folio_put
  mm: Add folio_get
  mm: Add folio flag manipulation functions
  mm: Add folio_young() and folio_idle()
  mm: Handle per-folio private data
  mm/filemap: Add folio_index, folio_file_page and folio_contains
  mm/filemap: Add folio_next_index
  mm/filemap: Add folio_offset and folio_file_offset
  mm/util: Add folio_mapping and folio_file_mapping
  mm: Add folio_mapcount
  mm/memcg: Add folio wrappers for various functions
  mm/filemap: Add folio_unlock
  mm/filemap: Add folio_lock
  mm/filemap: Add folio_lock_killable
  mm/filemap: Add __folio_lock_async
  mm/filemap: Add __folio_lock_or_retry
  mm/filemap: Add folio_wait_locked
  mm/swap: Add folio_rotate_reclaimable
  mm/filemap: Add folio_end_writeback
  mm/writeback: Add folio_wait_writeback
  mm/writeback: Add folio_wait_stable
  mm/filemap: Add folio_wait_bit
  mm/filemap: Add folio_wake_bit
  mm/filemap: Convert page wait queues to be folios
  mm/filemap: Add folio private_2 functions
  fs/netfs: Add folio fscache functions
  mm: Add folio_mapped
  mm/workingset: Convert workingset_activation to take a folio
  mm/swap: Add folio_activate
  mm/swap: Add folio_mark_accessed
  mm/rmap: Add folio_mkclean
  mm: Add kmap_local_folio
  mm: Add flush_dcache_folio
  mm: Add arch_make_folio_accessible
  mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics
  mm/memcg: Use the node id in mem_cgroup_update_tree
  mm/memcg: Convert commit_charge to take a folio
  mm/memcg: Add folio_charge_cgroup
  mm/memcg: Add folio_uncharge_cgroup
  mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath to folio
  mm/writeback: Rename __add_wb_stat to wb_stat_mod
  flex_proportions: Allow N events instead of 1
  mm/writeback: Change __wb_writeout_inc to __wb_writeout_add
  mm/writeback: Convert test_clear_page_writeback to
    __folio_end_writeback
  mm/writeback: Add folio_start_writeback
  mm/writeback: Add folio_mark_dirty
  mm/writeback: Use __set_page_dirty in __set_page_dirty_nobuffers
  mm/writeback: Add __folio_mark_dirty
  mm/writeback: Add filemap_dirty_folio
  mm/writeback: Add folio_account_cleaned
  mm/writeback: Add folio_cancel_dirty
  mm/writeback: Add folio_clear_dirty_for_io
  mm/writeback: Add folio_account_redirty
  mm/writeback: Add folio_redirty_for_writepage
  mm/filemap: Add i_blocks_per_folio
  mm/filemap: Add folio_mkwrite_check_truncate
  mm/filemap: Add readahead_folio
  block: Add bio_add_folio
  block: Add bio_for_each_folio_all
  mm/lru: Add folio_lru and folio_is_file_lru
  mm/workingset: Convert workingset_refault to take a folio
  mm/lru: Add folio_add_lru
  mm/page_alloc: Add __alloc_folio, __alloc_folio_node and alloc_folio
  mm/filemap: Add filemap_alloc_folio
  mm/filemap: Add folio_add_to_page_cache
  mm/filemap: Convert mapping_get_entry to return a folio
  mm/filemap: Add filemap_get_folio and find_get_folio
  mm/filemap: Add filemap_get_stable_folio
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

 Documentation/core-api/cachetlb.rst         |   6 +
 Documentation/core-api/mm-api.rst           |   4 +
 Documentation/filesystems/netfs_library.rst |   2 +
 block/bio.c                                 |  21 +
 fs/afs/write.c                              |   9 +-
 fs/buffer.c                                 |  25 -
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 fs/iomap/buffered-io.c                      | 524 +++++++++-----------
 fs/jfs/jfs_metapage.c                       |   1 +
 include/asm-generic/cacheflush.h            |  14 +
 include/linux/backing-dev.h                 |   6 +-
 include/linux/bio.h                         |  46 +-
 include/linux/flex_proportions.h            |   9 +-
 include/linux/gfp.h                         |  22 +-
 include/linux/highmem-internal.h            |  11 +
 include/linux/highmem.h                     |  38 ++
 include/linux/iomap.h                       |   2 +-
 include/linux/memcontrol.h                  |  81 ++-
 include/linux/mm.h                          | 226 +++++++--
 include/linux/mm_inline.h                   |  44 +-
 include/linux/mm_types.h                    |  75 ++-
 include/linux/mmdebug.h                     |  23 +-
 include/linux/netfs.h                       |  77 +--
 include/linux/page-flags.h                  | 260 +++++++---
 include/linux/page_idle.h                   |  99 ++--
 include/linux/page_owner.h                  |   6 +-
 include/linux/page_ref.h                    |  92 +++-
 include/linux/pageblock-flags.h             |   2 +-
 include/linux/pagemap.h                     | 467 ++++++++++++-----
 include/linux/rmap.h                        |  10 +-
 include/linux/swap.h                        |  17 +-
 include/linux/vmstat.h                      | 107 ++++
 include/linux/writeback.h                   |   9 +-
 include/net/page_pool.h                     |  12 +-
 include/trace/events/writeback.h            |   8 +-
 lib/flex_proportions.c                      |  28 +-
 mm/Makefile                                 |   2 +-
 mm/debug.c                                  |  25 +-
 mm/filemap.c                                | 509 +++++++++----------
 mm/folio-compat.c                           | 107 ++++
 mm/internal.h                               |   2 +
 mm/khugepaged.c                             |  32 +-
 mm/memcontrol.c                             | 100 ++--
 mm/memory.c                                 |  11 +-
 mm/mempolicy.c                              |  10 +
 mm/migrate.c                                |  56 +--
 mm/page-writeback.c                         | 461 ++++++++++-------
 mm/page_alloc.c                             |  28 +-
 mm/page_io.c                                |   4 +-
 mm/page_owner.c                             |   2 +-
 mm/rmap.c                                   |  12 +-
 mm/swap.c                                   | 101 ++--
 mm/swap_state.c                             |   2 +-
 mm/swapfile.c                               |   8 +-
 mm/util.c                                   |  60 ++-
 mm/workingset.c                             |  44 +-
 net/core/page_pool.c                        |  12 +-
 58 files changed, 2568 insertions(+), 1421 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

