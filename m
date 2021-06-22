Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF43B030C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhFVLot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhFVLos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:44:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788AC061574;
        Tue, 22 Jun 2021 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/7yTQ2Z0i+ebq2ranwWj3EBCmGl3WnMSrkD+yDrJg2w=; b=Z0g0rUKmOuWq2aRD+zKPBwdi/m
        VklcQMDNpxRnjO+v8rCYNLrXY8oxBoIstDy8AsKwlVdmOWgTRjYtSOXPAw2ylYZn2ibUXCXIPPX66
        8OSldWXFQudqik1rpr//lv5wkfdUjewwtoQZVa8dVae3jZqevg6fQ6W7+uPp5sw/hWVc0GY6kuROq
        Zm/zhZ1L8QezHkJ0C6WgsX16n1k5dxTaQtwbFyhtPS3J/joZB5wj2vi8xSheqv1eGjFkH6Yiw1CBS
        tlupiKLbmT3i0oS2ykVaAl05tqd3p+ZOiDXXJdyGADP0AbNzJY29t4O30CKsXKywLO3HFFFs0SK7o
        Io+Rk5jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvemN-00EDRT-R7; Tue, 22 Jun 2021 11:41:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/33] Memory folios
Date:   Tue, 22 Jun 2021 12:40:45 +0100
Message-Id: <20210622114118.3388190-1-willy@infradead.org>
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

Since v12:
 - Reworded commit message for folio_rotate_reclaimable (Christoph Hellwig)
 - Fixed documentation for folio fscache functions (David Howells)
 - Rebased on set_page_dirty cleanups which are in mmotm
 - Renamed page_offset() to page_pos() and page_file_offset() to
   page_file_pos() (David Howells)
 - Make __folio_lock_or_retry() and lock_page_or_retry() return a bool
   (David Howells)

v11: https://lore.kernel.org/linux-mm/20210614201435.1379188-1-willy@infradead.org/
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
  mm/filemap: Add folio_pos() and folio_file_pos()
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
 include/linux/mmdebug.h                     |  20 +
 include/linux/netfs.h                       |  77 ++--
 include/linux/page-flags.h                  | 245 ++++++++----
 include/linux/page_ref.h                    | 158 +++++++-
 include/linux/pagemap.h                     | 390 +++++++++++---------
 include/linux/swap.h                        |   7 +-
 include/linux/vmstat.h                      | 107 ++++++
 mm/Makefile                                 |   2 +-
 mm/filemap.c                                | 329 +++++++++--------
 mm/folio-compat.c                           |  43 +++
 mm/internal.h                               |   1 +
 mm/memory.c                                 |   8 +-
 mm/page-writeback.c                         |  72 ++--
 mm/page_io.c                                |   4 +-
 mm/swap.c                                   |  30 +-
 mm/swapfile.c                               |   8 +-
 mm/util.c                                   |  59 +--
 27 files changed, 1427 insertions(+), 580 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

