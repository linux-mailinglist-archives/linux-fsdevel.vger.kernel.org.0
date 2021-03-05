Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803EA32E07F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCEETO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCEETN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F757C061574;
        Thu,  4 Mar 2021 20:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ucXLMgTzg08rBCIow1BkGkrU1Nic7t09CCx8WIlO7ho=; b=IdiTs6R13Lps1O9R6PGCMM9W5d
        vxsb2dkOrBTx+xytNZTT26v9LugaNHMoPOdAeRU6qfeiufLnaC7WGF0mUaE9RHsg1YC0u7ZdGzV8+
        +RigOzond/E2bN27omKjaGcB0fAXTuiCbV750XzDN9O0GH0G1+M9Sqiq2bmjJLYuGIqgPvQ/GxpMk
        PQ+o8u22mmPjY3xjYkDAh9wWDJUCC21Uy+xObWOXpMbZvC3ZowQot2nherhvBKhBy6nTeFxmRuhOv
        kVGnlfHqIiWigq1OaFN0L7wv7n7VNE8zJGx3cbSm+DwbTCthhKynSYhGcAGk1kJaX3T5E45hKvNu5
        VO+h9EmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vf-00A3SH-0m; Fri, 05 Mar 2021 04:19:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 00/25] Page folios
Date:   Fri,  5 Mar 2021 04:18:36 +0000
Message-Id: <20210305041901.2396498-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Our type system does not currently distinguish between tail pages and
head or single pages.  This is a problem because we call compound_head()
multiple times (and the compiler cannot optimise it out), bloating the
kernel.  It also makes programming hard as it is often unclear whether
a function operates on an individual page, or an entire compound page.

This patch series introduces the struct folio, which is a type that
represents an entire compound page.  This initial set reduces the kernel
size by approximately 6kB, although its real purpose is adding
infrastructure to enable further use of the folio.

The big correctness proof that exists in this patch series is that we
never lock or wait for writeback on a tail page.  This is important as
we would miss wakeups due to being on the wrong page waitqueue if we
ever did.

I analysed the text size reduction using a config based on Oracle UEK
with all modules changed to built-in.  That's obviously not a kernel
which makes sense to run, but it serves to compare the effects on (many
common) filesystems & drivers, not just the core.

add/remove: 33510/33499 grow/shrink: 1831/1898 up/down: 888762/-894719 (-5957)

For a Debian config, just comparing vmlinux.o gives a reduction of 3828
bytes of text and 72 bytes of data:

   text    data     bss     dec     hex filename
16125879        4421122 1846344 22393345        155b201 linus/vmlinux.o
16122051        4421050 1846344 22389445        155a2c5 folio/vmlinux.o

For nfs (a module I happened to notice was particularly affected), it's
a reduction of 588 bytes of text and 16 bytes of data:
 257142	  59228	    408	 316778	  4d56a	linus/fs/nfs/nfs.o
 256554	  59212	    408	 316174	  4d30e	folio/fs/nfs/nfs.o

Current tree at:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

(contains another ~70 patches on top of this batch)

v4:
 - Rebase on current Linus tree (including swap fix)
 - Analyse each patch in terms of its effects on kernel text size.
   A few were modified to improve their effect.  In particular, where
   pushing calls to page_folio() into the callers resulted in unacceptable
   size increases, the wrapper was placed in mm/folio-compat.c.  This lets
   us see all the places which are good targets for conversion to folios.
 - Some of the patches were reordered, split or merged in order to make
   more logical sense.
 - Use nth_page() for folio_next() if we're using SPARSEMEM and not
   VMEMMAP (Zi Yan)
 - Increment and decrement page stats in units of pages instead of units
   of folios (Zi Yan)
v3:
 - Rebase on next-20210127.  Two major sources of conflict, the
   generic_file_buffered_read refactoring (in akpm tree) and the
   fscache work (in dhowells tree).
v2:
 - Pare patch series back to just infrastructure and the page waiting
   parts.

Matthew Wilcox (Oracle) (25):
  mm: Introduce struct folio
  mm: Add folio_pgdat and folio_zone
  mm/vmstat: Add functions to account folio statistics
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Handle per-folio private data
  mm: Add folio_index, folio_page and folio_contains
  mm/util: Add folio_mapping and folio_file_mapping
  mm/memcg: Add folio wrappers for various memcontrol functions
  mm/filemap: Add unlock_folio
  mm/filemap: Add lock_folio
  mm/filemap: Add lock_folio_killable
  mm/filemap: Convert lock_page_async to lock_folio_async
  mm/filemap: Convert end_page_writeback to end_folio_writeback
  mm/filemap: Add wait_on_folio_locked & wait_on_folio_locked_killable
  mm/page-writeback: Add wait_on_folio_writeback
  mm/page-writeback: Add wait_for_stable_folio
  mm/filemap: Convert wait_on_page_bit to wait_on_folio_bit
  mm/filemap: Add __lock_folio_or_retry
  mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
  mm/page-writeback: Convert test_clear_page_writeback to take a folio
  mm/filemap: Convert page wait queues to be folios
  cachefiles: Switch to wait_page_key

 fs/afs/write.c             |  21 ++--
 fs/cachefiles/rdwr.c       |  13 +--
 fs/io_uring.c              |   2 +-
 include/linux/fscache.h    |   5 +
 include/linux/memcontrol.h |  30 +++++
 include/linux/mm.h         |  88 ++++++++++-----
 include/linux/mm_types.h   |  33 ++++++
 include/linux/mmdebug.h    |  20 ++++
 include/linux/page-flags.h | 106 ++++++++++++++----
 include/linux/pagemap.h    | 197 +++++++++++++++++++++++----------
 include/linux/vmstat.h     |  83 ++++++++++++++
 mm/Makefile                |   2 +-
 mm/filemap.c               | 218 ++++++++++++++++++-------------------
 mm/folio-compat.c          |  37 +++++++
 mm/memory.c                |   8 +-
 mm/page-writeback.c        |  58 +++++-----
 mm/swapfile.c              |   6 +-
 mm/util.c                  |  20 ++--
 18 files changed, 666 insertions(+), 281 deletions(-)
 create mode 100644 mm/folio-compat.c

-- 
2.30.0

