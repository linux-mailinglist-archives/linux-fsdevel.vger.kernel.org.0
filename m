Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21BA3A6FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhFNURM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhFNURL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:17:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F17C061574;
        Mon, 14 Jun 2021 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=T+uDU9PS2lm9skXG3INq+pyo45zjQkF1zuHsAD6rWAU=; b=LL8upfxRi7VG0e5aQTrl3u+WdI
        g/I0PILX90LqfpgvtIFv0iAMkFOknPvU0hOTluqyRIpTFWBTAQ0ZExWe1Tj012RTWEsW4JzR4srtL
        bwsjTgThSgJXkJJIlpTulwc67e2CcZv3bMH9gCEkHf9/XIWiO5WGzmHBLO25weovUEzlKSoPioP1G
        Ix8r1RGGhWJEWY1hCjdYjIoOvqulexXCEAoVzYf/ZndhIkzshbUWcvKyKFqZmpqHHQdy7dpKXpbHd
        X/yhfL1fdkZfgqTu2HuIRPrEIM2R2wfgou/DWKe+A/PswLQLSmPt9IkrL+rsZTqWCfdXRMtYoawaq
        RQPrVanA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lssyi-005mnj-5m; Mon, 14 Jun 2021 20:14:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/33] Memory folios
Date:   Mon, 14 Jun 2021 21:14:02 +0100
Message-Id: <20210614201435.1379188-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
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
It provides some basic infrastructure that's worthwhile in its own right,
shrinking the kernel by about 6kB of text.

The full patch series is considerably larger (~200 patches),
and enables XFS to use large pages.  It can be found at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
(not everything there is in good shape for upstream submission, but
if you go as far as "mm/readahead: Add multi-page folio readahead",
it passes xfstests).  An earlier version of this patch set found it was
worth about a 7% reduction of wall-clock time on kernel compiles.

Since v11:
 - Rebase onto 5.13-rc4 plus eight patches from me currently in -mm.
 - Remove thp_head() (Vlastimil)
 - Add folio_memcg_rcu()
 - Make mem_cgroup_folio_lruvec() follow the new calling convention that's
   in mmotm, even though it's not upstream yet.
 - Make get_page_unless_zero() return bool.
 - Add folio_zonenum()
 - Add __folio_clear_lru_flags()
 - Add folio_lru_list()
 - Add folio_add_to_lru_list() and folio_del_from_lru_list()
 - Make add_page_to_lru_list() and add_page_to_lru_list_tail()
   work on compound pages of arbitrary order.
 - Add folio_mapcount_ptr() (Christoph)
 - Improve the comment on folio_page() (William)
 - Change indentation for PageFoo() (Vlastimil)
 - Fix folio_file_page() for HugeTLBfs (Vlastimil)
 - Remove externs from folio_wait_bit()
 - Remove set_page_private_2()
 - Add check that PG_locked is in the first byte of the flags
 - Rewrap some comments to avoid line length problems
 - Convert pagevec_move_tail_fn() to use a folio internally
 - Drop folio idle/young conversion from this patchset

v10: https://lore.kernel.org/linux-mm/20210511214735.1836149-1-willy@infradead.org/
v9: https://lore.kernel.org/linux-mm/20210505150628.111735-1-willy@infradead.org/
v8: https://lore.kernel.org/linux-mm/20210430180740.2707166-1-willy@infradead.org/

Matthew Wilcox (Oracle) (33):
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
  mm/filemap: Add folio_offset() and folio_file_offset()
  mm/util: Add folio_mapping() and folio_file_mapping()
  mm/memcg: Add folio wrappers for various functions
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

 Documentation/core-api/mm-api.rst           |   4 +
 Documentation/filesystems/netfs_library.rst |   2 +
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 include/linux/huge_mm.h                     |  15 -
 include/linux/memcontrol.h                  |  72 ++++
 include/linux/mm.h                          | 165 +++++++--
 include/linux/mm_inline.h                   |  85 +++--
 include/linux/mm_types.h                    |  77 ++++
 include/linux/mmdebug.h                     |  20 ++
 include/linux/netfs.h                       |  77 ++--
 include/linux/page-flags.h                  | 245 +++++++++----
 include/linux/page_ref.h                    | 158 +++++++-
 include/linux/pagemap.h                     | 377 +++++++++++---------
 include/linux/swap.h                        |   7 +-
 include/linux/vmstat.h                      | 107 ++++++
 mm/Makefile                                 |   2 +-
 mm/filemap.c                                | 321 +++++++++--------
 mm/folio-compat.c                           |  43 +++
 mm/internal.h                               |   1 +
 mm/memory.c                                 |   8 +-
 mm/page-writeback.c                         |  72 ++--
 mm/page_io.c                                |   4 +-
 mm/swap.c                                   |  30 +-
 mm/swapfile.c                               |   8 +-
 mm/util.c                                   |  59 +--
 27 files changed, 1411 insertions(+), 575 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

