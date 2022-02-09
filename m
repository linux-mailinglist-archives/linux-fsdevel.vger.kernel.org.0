Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85C4AFE54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiBIUXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D122E040DE0
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YOxgU1B+isE59LO6JtgHbg/fwgB0pSKf+fTIWwulhNg=; b=s0IfBHwAFUutnq4OzA/zBg/yeu
        ThubsQhZkgf/Z3NMgQ0DrxxWD3Ht+whzz0qFXQmujumRP/0TEZ1V5fWXCaCubgPFcN+hQrvFi8deO
        iLotmhHIUUiY+vH/EVgD0GoWwACHD55jx06OKlAyJNXnKzC8GbqjaOXUFMzRYY3v1hUUqKDsaUI+3
        QEf8OQSVnrGSJyN5oFEY9+ddt+uKhhk8JektQRnjb5rSvZ9nVcII98UjKybw7vluCF1HYa6r+ph01
        YKI2V/yy2PgFOEbl6q3Zxjs1xHZKrbCpb4sfV1W5MKcnjVjhFchLbEFm93PVp6sCx3oEeuL4yYzhA
        K/3igB1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008csV-Pm; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 41/56] fs: Add aops->dirty_folio
Date:   Wed,  9 Feb 2022 20:22:00 +0000
Message-Id: <20220209202215.2055748-42-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces ->set_page_dirty().  It returns a bool instead of an int
and takes the address_space as a parameter instead of expecting the
implementations to retrieve the address_space from the page.  This is
particularly important for filesystems which use FS_OPS for swap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 15 ++++++++-------
 Documentation/filesystems/vfs.rst     | 16 ++++++++--------
 include/linux/fs.h                    |  1 +
 mm/page-writeback.c                   | 17 ++++++++++-------
 mm/page_io.c                          |  5 ++++-
 5 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index dee512efb458..72fa12dabd39 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -239,7 +239,7 @@ prototypes::
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
-	int (*set_page_dirty)(struct page *page);
+	bool (*dirty_folio)(struct address_space *, struct folio *folio);
 	void (*readahead)(struct readahead_control *);
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
@@ -264,7 +264,7 @@ prototypes::
 	int (*swap_deactivate)(struct file *);
 
 locking rules:
-	All except set_page_dirty and freepage may block
+	All except dirty_folio and freepage may block
 
 ======================	======================== =========	===============
 ops			PageLocked(page)	 i_rwsem	invalidate_lock
@@ -272,7 +272,7 @@ ops			PageLocked(page)	 i_rwsem	invalidate_lock
 writepage:		yes, unlocks (see below)
 readpage:		yes, unlocks				shared
 writepages:
-set_page_dirty		no
+dirty_folio		maybe
 readahead:		yes, unlocks				shared
 readpages:		no					shared
 write_begin:		locks the page		 exclusive
@@ -361,10 +361,11 @@ If nr_to_write is NULL, all dirty pages must be written.
 writepages should _only_ write pages which are present on
 mapping->io_pages.
 
-->set_page_dirty() is called from various places in the kernel
-when the target page is marked as needing writeback.  It may be called
-under spinlock (it cannot block) and is sometimes called with the page
-not locked.
+->dirty_folio() is called from various places in the kernel when
+the target folio is marked as needing writeback.  The folio cannot be
+truncated because either the caller holds the folio lock, or the caller
+has found the folio while holding the page table lock which will block
+truncation.
 
 ->bmap() is currently used by legacy ioctl() (FIBMAP) provided by some
 filesystems and by the swapper. The latter will eventually go away.  Please,
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index c54ca4d88ed6..d16bee420326 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -658,7 +658,7 @@ pages, however the address_space has finer control of write sizes.
 
 The read process essentially only requires 'readpage'.  The write
 process is more complicated and uses write_begin/write_end or
-set_page_dirty to write data into the address_space, and writepage and
+dirty_folio to write data into the address_space, and writepage and
 writepages to writeback data to storage.
 
 Adding and removing pages to/from an address_space is protected by the
@@ -724,7 +724,7 @@ cache in your filesystem.  The following members are defined:
 		int (*writepage)(struct page *page, struct writeback_control *wbc);
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
-		int (*set_page_dirty)(struct page *page);
+		bool (*dirty_folio)(struct address_space *, struct folio *);
 		void (*readahead)(struct readahead_control *);
 		int (*readpages)(struct file *filp, struct address_space *mapping,
 				 struct list_head *pages, unsigned nr_pages);
@@ -793,13 +793,13 @@ cache in your filesystem.  The following members are defined:
 	This will choose pages from the address space that are tagged as
 	DIRTY and will pass them to ->writepage.
 
-``set_page_dirty``
-	called by the VM to set a page dirty.  This is particularly
-	needed if an address space attaches private data to a page, and
-	that data needs to be updated when a page is dirtied.  This is
+``dirty_folio``
+	called by the VM to mark a folio as dirty.  This is particularly
+	needed if an address space attaches private data to a folio, and
+	that data needs to be updated when a folio is dirtied.  This is
 	called, for example, when a memory mapped page gets modified.
-	If defined, it should set the PageDirty flag, and the
-	PAGECACHE_TAG_DIRTY tag in the radix tree.
+	If defined, it should set the folio dirty flag, and the
+	PAGECACHE_TAG_DIRTY search mark in i_pages.
 
 ``readahead``
 	Called by the VM to read pages associated with the address_space
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 055be40084f1..c3d5db8851ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -369,6 +369,7 @@ struct address_space_operations {
 
 	/* Set a page dirty.  Return true if this dirtied it */
 	int (*set_page_dirty)(struct page *page);
+	bool (*dirty_folio)(struct address_space *, struct folio *);
 
 	/*
 	 * Reads in the requested pages. Unlike ->readpage(), this is
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 91d163f8d36b..27a87ae4502c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2616,7 +2616,7 @@ EXPORT_SYMBOL(folio_redirty_for_writepage);
  * folio_mark_dirty - Mark a folio as being modified.
  * @folio: The folio.
  *
- * For folios with a mapping this should be done under the page lock
+ * For folios with a mapping this should be done with the folio lock held
  * for the benefit of asynchronous memory errors who prefer a consistent
  * dirty state. This rule can be broken in some special cases,
  * but should be better not to.
@@ -2630,16 +2630,19 @@ bool folio_mark_dirty(struct folio *folio)
 	if (likely(mapping)) {
 		/*
 		 * readahead/lru_deactivate_page could remain
-		 * PG_readahead/PG_reclaim due to race with end_page_writeback
-		 * About readahead, if the page is written, the flags would be
+		 * PG_readahead/PG_reclaim due to race with folio_end_writeback
+		 * About readahead, if the folio is written, the flags would be
 		 * reset. So no problem.
-		 * About lru_deactivate_page, if the page is redirty, the flag
-		 * will be reset. So no problem. but if the page is used by readahead
-		 * it will confuse readahead and make it restart the size rampup
-		 * process. But it's a trivial problem.
+		 * About lru_deactivate_page, if the folio is redirtied,
+		 * the flag will be reset. So no problem. but if the
+		 * folio is used by readahead it will confuse readahead
+		 * and make it restart the size rampup process. But it's
+		 * a trivial problem.
 		 */
 		if (folio_test_reclaim(folio))
 			folio_clear_reclaim(folio);
+		if (mapping->a_ops->dirty_folio)
+			return mapping->a_ops->dirty_folio(mapping, folio);
 		return mapping->a_ops->set_page_dirty(&folio->page);
 	}
 	if (!folio_test_dirty(folio)) {
diff --git a/mm/page_io.c b/mm/page_io.c
index 0bf8e40f4e57..24c975fb4e21 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -444,9 +444,12 @@ int swap_set_page_dirty(struct page *page)
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
 		struct address_space *mapping = sis->swap_file->f_mapping;
+		const struct address_space_operations *aops = mapping->a_ops;
 
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-		return mapping->a_ops->set_page_dirty(page);
+		if (aops->dirty_folio)
+			return aops->dirty_folio(mapping, page_folio(page));
+		return aops->set_page_dirty(page);
 	} else {
 		return __set_page_dirty_no_writeback(page);
 	}
-- 
2.34.1

