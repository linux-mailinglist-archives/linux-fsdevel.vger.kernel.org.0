Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BF3C6317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhGLTFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhGLTFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:05:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF8C0613DD;
        Mon, 12 Jul 2021 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IVmHYOAXTI19qlhMZur37PZfYtnXt/URUV67Hwi1f7M=; b=ljsTVykPu0NKoRx0Qif/upo39b
        pNyoxZap3Z9yUs1ArecBeTCy3qU2LiRB3UVIYeKa9gzqw+FiAuGeAXYgVzNQOZV5DRaEhGboQayve
        EDOh1c8k3pZfGz4EW/KqRShUYCNbFYuEnhsCePUPhDuqCYi0REvJAv1CHexcxmt+lkboX3vpKhvnm
        gcQ3WNdKmFkRr7G6OniTRWjtgzsY9X/dMFjCLX5LYUzJWKAFcdeHPLwioR7HOy3jbSGAEp0U2fqsH
        cDHH1GU+10nj20nsAKwy46ak5AYLUK3XNbFDZezhANy1wXnsu/+d0dfEHfPIK0bPKfTBX5u4p0vmC
        2G0LhAOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31Bt-000L5O-U5; Mon, 12 Jul 2021 19:02:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v13a 00/32] Memory folios
Date:   Mon, 12 Jul 2021 20:01:32 +0100
Message-Id: <20210712190204.80979-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
benefit from managing memory in larger chunks.  As an example, an earlier
iteration of this idea which used compound pages (and wasn't particularly
tuned) got a 7% performance boost when compiling the kernel.

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
It provides some basic infrastructure that's worthwhile in its own right,
shrinking the kernel by about 6kB of text.

-- 8< --

This is the first batch of patches for the next merge window.  They are
identical to the ones sent yesterday to linux-kernel and the build bots
didn't complain about any of these.  They have been extensively reviewed.
Please apply.

Matthew Wilcox (Oracle) (32):
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

 Documentation/core-api/mm-api.rst           |   4 +
 Documentation/filesystems/netfs_library.rst |   2 +
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/rdwr.c                        |  16 +-
 fs/io_uring.c                               |   2 +-
 include/linux/huge_mm.h                     |  15 -
 include/linux/mm.h                          | 165 +++++++--
 include/linux/mm_inline.h                   |  85 +++--
 include/linux/mm_types.h                    |  77 ++++
 include/linux/mmdebug.h                     |  20 +
 include/linux/netfs.h                       |  77 ++--
 include/linux/page-flags.h                  | 247 +++++++++----
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
 26 files changed, 1356 insertions(+), 581 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.2

