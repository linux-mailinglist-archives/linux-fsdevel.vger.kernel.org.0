Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C062FA6F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405358AbhARRCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390579AbhARRCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:02:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30CC061573;
        Mon, 18 Jan 2021 09:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=baMXZw5lvGF/G8581QjF8wrs+U9YxbMcE+gHKjNQji4=; b=Ol5QwQ9QSRhy+78YE4534eV0v2
        V8vgAwBi5YzvaHp+L53P1hG9YNRllssT8JenrgUNjvnlJtiDHdANZge3hx7mpIsS3tvYQRKpHarBL
        MFs0TVcTbpJhCvLbw0WqwpDtHc/5l2/WJtoGhJXzu7sDH2mRGkSTErRLt16bzKJkVnjiI4z7feeN8
        Tq7fkx0l0n3VQNV/kZJpY3gCAFU3qK1rfM4qs4gMVVxvalzimjbXL7rhAUFi8rrfcHcjFdxAme3u5
        gmXIPQHejDvRR4QXktDq+HOLasAVWFkF3cxw2/YsJSJoWTkEL7FvbsitLB2CHgYvow9J/XoF+c8Nv
        ZU7Jz6/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XuX-00D7HH-BJ; Mon, 18 Jan 2021 17:01:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/27] Page folios
Date:   Mon, 18 Jan 2021 17:01:21 +0000
Message-Id: <20210118170148.3126186-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some functions which take a struct page as an argument operate on
PAGE_SIZE bytes.  Others operate on the entire compound page if
passed either a head or tail page.  Others operate on the compound
page if passed a head page, but PAGE_SIZE bytes if passed a tail page.
Yet others either BUG or do the wrong thing if passed a tail page.

This patch series starts to resolve this ambiguity by introducing a new
type, the struct folio.  A function which takes a struct folio argument
declares that it will operate on the entire page.  In return, the caller
guarantees that the pointer it is passing does not point to a tail page.

This allows us to do less work.  Now we have a type that is guaranteed
not to be a tail page, we can avoid calling compound_head().  That saves
us hundreds of bytes of text and even manages to reduce the amount of
data in the kernel image somehow.

This patch series is just an introduction.  I have dozens more patches
in progress which you can find at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
(currently based on next-20210118)

The focus for this patch series is on introducing infrastructure.
The big correctness proof that exists in this patch series is to make
it clear that one cannot wait (for the page lock or writeback) on a
tail page.  I don't believe there were any places which could miss a
wakeup due to this, but it's hard to prove that without struct folio.
Now the compiler proves it for us.

Matthew Wilcox (Oracle) (27):
  mm: Introduce struct folio
  mm: Add folio_pgdat
  mm/vmstat: Add folio stat wrappers
  mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Handle per-folio private data
  mm: Add folio_index, folio_page and folio_contains
  mm/util: Add folio_mapping and folio_file_mapping
  mm/memcg: Add folio_memcg, lock_folio_memcg and unlock_folio_memcg
  mm/memcg: Add mem_cgroup_folio_lruvec
  mm: Add unlock_folio
  mm: Add lock_folio
  mm: Add lock_folio_killable
  mm: Convert lock_page_async to lock_folio_async
  mm/filemap: Convert lock_page_for_iocb to lock_folio_for_iocb
  mm/filemap: Convert wait_on_page_locked_async to
    wait_on_folio_locked_async
  mm/filemap: Convert end_page_writeback to end_folio_writeback
  mm: Convert wait_on_page_bit to wait_on_folio_bit
  mm: Add wait_for_stable_folio and wait_on_folio_writeback
  mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
  mm: Convert lock_page_or_retry to lock_folio_or_retry
  mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
  mm: Convert test_clear_page_writeback to test_clear_folio_writeback
  mm/filemap: Convert page wait queues to be folios
  cachefiles: Switch to wait_page_key

 fs/afs/write.c             |   2 +-
 fs/cachefiles/rdwr.c       |  13 +--
 fs/io_uring.c              |   2 +-
 include/linux/fscache.h    |   6 +
 include/linux/memcontrol.h |  22 ++++
 include/linux/mm.h         |  88 +++++++++++----
 include/linux/mm_types.h   |  33 ++++++
 include/linux/mmdebug.h    |  20 ++++
 include/linux/page-flags.h | 106 ++++++++++++++----
 include/linux/pagemap.h    | 194 ++++++++++++++++++++++----------
 include/linux/vmstat.h     |  60 ++++++++++
 mm/filemap.c               | 223 ++++++++++++++++++-------------------
 mm/memcontrol.c            |  36 ++++--
 mm/memory.c                |  10 +-
 mm/page-writeback.c        |  48 ++++----
 mm/swapfile.c              |   6 +-
 mm/util.c                  |  20 ++--
 17 files changed, 610 insertions(+), 279 deletions(-)

-- 
2.29.2

