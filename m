Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18137B0FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEKVtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 17:49:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6AC061574;
        Tue, 11 May 2021 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZkUktfxKz2aP5vJvHDus4/RHgQ8UdnzEwj2hqUXJcNg=; b=KpRPJTBWrUrZLNckQf7Kt5qG+T
        RzF37V5tiQxgbJ0RhvCJfXTwfMgJUcDcbbmdSulMk74H8qRBsGVZKB97m7/uje6rQAGbdfGofCnZb
        xEQyhfWtkIvuKsNTqFnWpKbcw/pIFB2ObKLNY8bGxgBA5uaIGIafzS7TQtk0tx7D6vH5i2HNXnZuP
        Uh6Wqd0FXgPtqT46lg+0n9c6hQhWJcNGz2H4YEKPFFs733ZQJ/fHIUu1I2ZV1AU4Mbln7EJZDrFpm
        3A8Q25E1VR6LWaZigEn7H1s3nOclMqP4tLXFyXisfsomldZEbJ14xuEuDD38eID9bZns7QaYPxH+z
        TnoKrd2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaE4-007hgI-Ga; Tue, 11 May 2021 21:47:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 00/33] Memory folios
Date:   Tue, 11 May 2021 22:47:02 +0100
Message-Id: <20210511214735.1836149-1-willy@infradead.org>
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
shrinking the kernel by about 5kB of text.

Since v9:
 - Rebase onto mmotm 2021-05-10-21-46
 - Add folio_memcg() definition for !MEMCG (intel lkp)
 - Change folio->private from an unsigned long to a void *
 - Use folio_page() to implement folio_file_page()
 - Add folio_try_get() and folio_try_get_rcu()
 - Trim back down to just the first few patches, which are better-reviewed.
v9: https://lore.kernel.org/linux-mm/20210505150628.111735-1-willy@infradead.org/
v8: https://lore.kernel.org/linux-mm/20210430180740.2707166-1-willy@infradead.org/

Matthew Wilcox (Oracle) (33):
  mm: Introduce struct folio
  mm: Add folio_pgdat and folio_zone
  mm/vmstat: Add functions to account folio statistics
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add folio reference count functions
  mm: Add folio_put
  mm: Add folio_get
  mm: Add folio_try_get_rcu
  mm: Add folio flag manipulation functions
  mm: Add folio_young and folio_idle
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

 Documentation/core-api/mm-api.rst           |   4 +
 Documentation/filesystems/netfs_library.rst |   2 +
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 include/linux/memcontrol.h                  |  63 ++++
 include/linux/mm.h                          | 174 ++++++++--
 include/linux/mm_types.h                    |  71 ++++
 include/linux/mmdebug.h                     |  20 ++
 include/linux/netfs.h                       |  77 +++--
 include/linux/page-flags.h                  | 230 ++++++++++---
 include/linux/page_idle.h                   |  99 +++---
 include/linux/page_ref.h                    | 158 ++++++++-
 include/linux/pagemap.h                     | 358 ++++++++++++--------
 include/linux/swap.h                        |   7 +-
 include/linux/vmstat.h                      | 107 ++++++
 mm/Makefile                                 |   2 +-
 mm/filemap.c                                | 315 ++++++++---------
 mm/folio-compat.c                           |  43 +++
 mm/internal.h                               |   1 +
 mm/memory.c                                 |   8 +-
 mm/page-writeback.c                         |  72 ++--
 mm/page_io.c                                |   4 +-
 mm/swap.c                                   |  18 +-
 mm/swapfile.c                               |   8 +-
 mm/util.c                                   |  59 ++--
 26 files changed, 1374 insertions(+), 553 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

