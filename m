Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1BB37002D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3SJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3SJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:09:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C1C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oXuh0g6FqAi5P1ykBIJ9lU/lyQ0tXMVgf21yCl7vLv0=; b=vVNpKDCYelPqzXzgInxHyUpQYD
        xYZEc6NnyONEQcXys1S+ZrFebTLS/2HA+JA+vYHgIw+xko2rMVSXjh1bj8+LBxsI8GhT3r3IlJKIM
        9cWkrlVefpGED15YmRQ7fQDmE7BIXSS5lCDOZlh4h6oeKyA/XPaEY3OPZcxHqNh6+9f1Icp4kt70l
        9RWLvftHRAmnhI9BVXyklmZj8E5SaHkxtYeQQsuFPBUbwri7BEGWjlevdzx4L+uky0YDQMLLSkukV
        mNoR6lz8cGkW/fFgfQWLoDzvw2O/Jk1LKUq+Nz3Wn/c4XfCXTvhLf2WfuqNQ7ZH39Gj29bJ69hPQM
        FwQKOIJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXYE-00BMHO-43; Fri, 30 Apr 2021 18:07:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v8.1 00/31] Memory Folios
Date:   Fri, 30 Apr 2021 19:07:09 +0100
Message-Id: <20210430180740.2707166-1-willy@infradead.org>
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

Using compound pages or THPs exposes a serious weakness in our type
system.  Functions are often unprepared for compound pages to be passed
to them, and may only act on PAGE_SIZE chunks.  Even functions which are
aware of compound pages may expect a head page, and do the wrong thing
if passed a tail page.

There have been efforts to label function parameters as 'head' instead
of 'page' to indicate that the function expects a head page, but this
leaves us with runtime assertions instead of using the compiler to prove
that nobody has mistakenly passed a tail page.  Calling a struct page
'head' is also inaccurate as they will work perfectly well on base pages.

We also waste a lot of instructions ensuring that we're not looking at
a tail page.  Almost every call to PageFoo() contains one or more hidden
calls to compound_head().  This also happens for get_page(), put_page()
and many more functions.  There does not appear to be a way to tell gcc
that it can cache the result of compound_head(), nor is there a way to
tell it that compound_head() is idempotent.

This series introduces the 'struct folio' as a replacement for
head-or-base pages.  This initial set reduces the kernel size by
approximately 6kB by removing conversions from tail pages to head pages.
The real purpose of this series is adding infrastructure to enable
further use of the folio.

The medium-term goal is to convert all filesystems and some device
drivers to work in terms of folios.  This series contains a lot of
explicit conversions, but it's important to realise it's removing a lot
of implicit conversions in some relatively hot paths.  There will be very
few conversions from folios when this work is completed; filesystems,
the page cache, the LRU and so on will generally only deal with folios.

The text size reduces by between 6kB (a config based on Oracle UEK)
and 1.2kB (allnoconfig).  Performance seems almost unaffected based
on kernbench.

Current tree at:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

(contains another ~120 patches on top of this batch, not all of which are
in good shape for submission)

v8.1:
 - Rebase on next-20210430
 - You need https://lore.kernel.org/linux-mm/20210430145549.2662354-1-willy@infradead.org/ first
 - Big renaming (thanks to peterz):
   - PageFoo() becomes folio_foo()
   - SetFolioFoo() becomes folio_set_foo()
   - ClearFolioFoo() becomes folio_clear_foo()
   - __SetFolioFoo() becomes __folio_set_foo()
   - __ClearFolioFoo() becomes __folio_clear_foo()
   - TestSetPageFoo() becomes folio_test_set_foo()
   - TestClearPageFoo() becomes folio_test_clear_foo()
   - PageHuge() is now folio_hugetlb()
   - put_folio() becomes folio_put()
   - get_folio() becomes folio_get()
   - put_folio_testzero() becomes folio_put_testzero()
   - set_folio_count() becomes folio_set_count()
   - attach_folio_private() becomes folio_attach_private()
   - detach_folio_private() becomes folio_detach_private()
   - lock_folio() becomes folio_lock()
   - unlock_folio() becomes folio_unlock()
   - trylock_folio() becomes folio_trylock()
   - __lock_folio_or_retry becomes __folio_lock_or_retry()
   - __lock_folio_async() becomes __folio_lock_async()
   - wake_up_folio_bit() becomes folio_wake_bit()
   - wake_up_folio() becomes folio_wake()
   - wait_on_folio_bit() becomes folio_wait_bit()
   - wait_for_stable_folio() becomes folio_wait_stable()
   - wait_on_folio() becomes folio_wait()
   - wait_on_folio_locked() becomes folio_wait_locked()
   - wait_on_folio_writeback() becomes folio_wait_writeback()
   - end_folio_writeback() becomes folio_end_writeback()
   - add_folio_wait_queue() becomes folio_add_wait_queue()
 - Add folio_young() and folio_idle() family of functions
 - Move page_folio() to page-flags.h and use _compound_head()
 - Make page_folio() const-preserving
 - Add folio_page() to get the nth page from a folio
 - Improve struct folio kernel-doc
 - Convert folio flag tests to return bool instead of int
 - Eliminate set_folio_private()
 - folio_get_private() is the equivalent of page_private() (as folio_private()
   is now a test for whether the private flag is set on the folio)
 - Move folio_rotate_reclaimable() into this patchset
 - Add page-flags.h to the kernel-doc
 - Add netfs.h to the kernel-doc
 - Add a family of folio_lock_lruvec() wrappers
 - Add a family of folio_relock_lruvec() wrappers

v7:
https://lore.kernel.org/linux-mm/20210409185105.188284-1-willy@infradead.org/

Matthew Wilcox (Oracle) (31):
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

 Documentation/core-api/mm-api.rst           |   4 +
 Documentation/filesystems/netfs_library.rst |   2 +
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 include/linux/memcontrol.h                  |  58 ++++
 include/linux/mm.h                          | 173 ++++++++++--
 include/linux/mm_types.h                    |  71 +++++
 include/linux/mmdebug.h                     |  20 ++
 include/linux/netfs.h                       |  77 +++--
 include/linux/page-flags.h                  | 222 +++++++++++----
 include/linux/page_idle.h                   |  99 ++++---
 include/linux/page_ref.h                    |  88 +++++-
 include/linux/pagemap.h                     | 276 +++++++++++++-----
 include/linux/swap.h                        |   7 +-
 include/linux/vmstat.h                      | 107 +++++++
 mm/Makefile                                 |   2 +-
 mm/filemap.c                                | 295 ++++++++++----------
 mm/folio-compat.c                           |  37 +++
 mm/internal.h                               |   1 +
 mm/memory.c                                 |   8 +-
 mm/page-writeback.c                         |  72 +++--
 mm/page_io.c                                |   4 +-
 mm/swap.c                                   |  18 +-
 mm/swapfile.c                               |   8 +-
 mm/util.c                                   |  30 +-
 26 files changed, 1247 insertions(+), 459 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2
