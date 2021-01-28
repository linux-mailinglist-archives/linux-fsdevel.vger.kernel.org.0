Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11386306E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhA1HEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1HEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:04:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD44C061573;
        Wed, 27 Jan 2021 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xTj5iUr2pNOoeNVjs1n88tIxBjCvKioFx6e9RyoCseM=; b=dz2TgDLK5eoH2z4ZCfs/qT5PIV
        IaRzVY2+eFwm52EJfrNvLBC6Wd1hJNVg7QlsnIQFcXfyDKod78aGFtup/wxdWpT7+vHPPsMe5IVTZ
        zQs1+jXDUBcNUaMTMz40LzbVWZ54ILVqxDm6PUl+qSFvwfIDnh2O6LbX2osrfHcAWihdX+zBnmC1z
        B1rJgb99SVAWNOzzU3HlOqJDhPrFp0zOihrDsqeRNjcJ3Am5ECf7OoFiH+n7WbnmEd3rAoYJnKqY7
        Mq2tTcOEmeXIOEDBURdhn8Os4toUDxKjLZ+40iQD+Jzbck7fDGE3LAF0q31ug/Xxp1wxDWFWX5rxm
        B+anS/gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51LZ-00845z-RY; Thu, 28 Jan 2021 07:04:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/25] Page folios
Date:   Thu, 28 Jan 2021 07:03:39 +0000
Message-Id: <20210128070404.1922318-1-willy@infradead.org>
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

The focus for this patch series is on introducing infrastructure.
The big correctness proof that exists in this patch series is to make
it clear that one cannot wait (for the page lock or writeback) on a
tail page.  I don't believe there were any places which could miss a
wakeup due to this, but it's hard to prove that without struct folio.
Now the compiler proves it for us.

v3:
 - Rebase on next-20210127.  Two major sources of conflict, the
   generic_file_buffered_read refactoring (in akpm tree) and the
   fscache work (in dhowells tree).  Not sure how this patch series
   can get merged with these two sources of conflict?
v2:
 - Pare patch series back to just infrastructure and the page waiting
   parts.

Matthew Wilcox (Oracle) (25):
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
  mm/filemap: Convert end_page_writeback to end_folio_writeback
  mm: Convert wait_on_page_bit to wait_on_folio_bit
  mm: Add wait_for_stable_folio and wait_on_folio_writeback
  mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
  mm: Convert lock_page_or_retry to lock_folio_or_retry
  mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
  mm: Convert test_clear_page_writeback to test_clear_folio_writeback
  mm/filemap: Convert page wait queues to be folios
  cachefiles: Switch to wait_page_key

 fs/afs/write.c             |  31 +++---
 fs/cachefiles/rdwr.c       |  13 ++-
 fs/io_uring.c              |   2 +-
 include/linux/memcontrol.h |  22 ++++
 include/linux/mm.h         |  88 ++++++++++++----
 include/linux/mm_types.h   |  33 ++++++
 include/linux/mmdebug.h    |  20 ++++
 include/linux/netfs.h      |   5 +
 include/linux/page-flags.h | 106 +++++++++++++++----
 include/linux/pagemap.h    | 201 ++++++++++++++++++++++++-----------
 include/linux/vmstat.h     |  60 +++++++++++
 mm/filemap.c               | 207 ++++++++++++++++++-------------------
 mm/memcontrol.c            |  36 ++++---
 mm/memory.c                |  10 +-
 mm/page-writeback.c        |  48 ++++-----
 mm/swapfile.c              |   6 +-
 mm/util.c                  |  20 ++--
 17 files changed, 621 insertions(+), 287 deletions(-)

-- 
2.29.2

