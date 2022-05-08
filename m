Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBCD51F19C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiEHUjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiEHUhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AD612628
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EB3A2sOgjHMTMWwA+TejH9MB2tzBN0oX5krLJwfWhfQ=; b=pvjv+1oskRTNwQIGMhkIuSNpze
        +Hc1+5eXwpx97EZ3LcC31HtlpdEgtdzkcUkVfYTf89xQASpPa2C4z7oWlSLw5eXslMfh4mO90MhqE
        TC1inXOXDxjqe69w1sFWoLZgTDcd8dPeZnzs5lB+pZK5ZHmGEzJIX8KJYkXLzPVqTob5P3fX82Fx2
        np4s0GpgJZDQvrQc7UczZNgJ67DFlg5QQXF0tdIyuiuueZayJlt/UIKfI/8AwtLUjhkWR3ssw2CkZ
        XLdBAWa0X/xggH0Nk0YrGEHM3KARzCR4e1tOYDzZRqqHD9chWU0Wyee0ROVt1EmWb+ghBEIkL8gTa
        rddrzHig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaS-002o6T-SP; Sun, 08 May 2022 20:33:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/5] fs: Add free_folio address space operation
Date:   Sun,  8 May 2022 21:32:57 +0100
Message-Id: <20220508203301.669147-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203301.669147-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203301.669147-1-willy@infradead.org>
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

Include documentation and convert the callers to use ->free_folio as
well as ->freepage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 10 +++++-----
 Documentation/filesystems/vfs.rst     |  6 +++---
 include/linux/fs.h                    |  1 +
 mm/filemap.c                          |  9 ++++++++-
 mm/vmscan.c                           |  6 +++++-
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2a295bb72dbc..55b029b2d420 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -250,7 +250,7 @@ prototypes::
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 	int (*release_folio)(struct folio *, gfp_t);
-	void (*freepage)(struct page *);
+	void (*free_folio)(struct folio *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	bool (*isolate_page) (struct page *, isolate_mode_t);
 	int (*migratepage)(struct address_space *, struct page *, struct page *);
@@ -262,10 +262,10 @@ prototypes::
 	int (*swap_deactivate)(struct file *);
 
 locking rules:
-	All except dirty_folio and freepage may block
+	All except dirty_folio and free_folio may block
 
 ======================	======================== =========	===============
-ops			PageLocked(page)	 i_rwsem	invalidate_lock
+ops			folio locked		 i_rwsem	invalidate_lock
 ======================	======================== =========	===============
 writepage:		yes, unlocks (see below)
 read_folio:		yes, unlocks				shared
@@ -277,7 +277,7 @@ write_end:		yes, unlocks		 exclusive
 bmap:
 invalidate_folio:	yes					exclusive
 release_folio:		yes
-freepage:		yes
+free_folio:		yes
 direct_IO:
 isolate_page:		yes
 migratepage:		yes (both)
@@ -377,7 +377,7 @@ buffers from the folio in preparation for freeing it.  It returns false to
 indicate that the buffers are (or may be) freeable.  If ->release_folio is
 NULL, the kernel assumes that the fs has no private interest in the buffers.
 
-->freepage() is called when the kernel is done dropping the page
+->free_folio() is called when the kernel has dropped the folio
 from the page cache.
 
 ->launder_folio() may be called prior to releasing a folio if
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 679887b5c8fc..12a011d2cbc6 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -735,7 +735,7 @@ cache in your filesystem.  The following members are defined:
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 		bool (*release_folio)(struct folio *, gfp_t);
-		void (*freepage)(struct page *);
+		void (*free_folio)(struct folio *);
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		/* isolate a page for migration */
 		bool (*isolate_page) (struct page *, isolate_mode_t);
@@ -891,8 +891,8 @@ cache in your filesystem.  The following members are defined:
 	its release_folio will need to ensure this.  Possibly it can
 	clear the uptodate flag if it cannot free private data yet.
 
-``freepage``
-	freepage is called once the page is no longer visible in the
+``free_folio``
+	free_folio is called once the folio is no longer visible in the
 	page cache in order to allow the cleanup of any private data.
 	Since it may be called by the memory reclaimer, it should not
 	assume that the original address_space mapping still exists, and
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cee64d9724b..915844e6293e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -356,6 +356,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
+	void (*free_folio)(struct folio *folio);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
diff --git a/mm/filemap.c b/mm/filemap.c
index d335a154a0d9..adcdef56890f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -226,8 +226,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*freepage)(struct page *);
+	void (*free_folio)(struct folio *);
 	int refs = 1;
 
+	free_folio = mapping->a_ops->free_folio;
+	if (free_folio)
+		free_folio(folio);
 	freepage = mapping->a_ops->freepage;
 	if (freepage)
 		freepage(&folio->page);
@@ -807,6 +811,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	struct folio *fold = page_folio(old);
 	struct folio *fnew = page_folio(new);
 	struct address_space *mapping = old->mapping;
+	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
@@ -835,9 +840,11 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	if (PageSwapBacked(new))
 		__inc_lruvec_page_state(new, NR_SHMEM);
 	xas_unlock_irq(&xas);
+	if (free_folio)
+		free_folio(fold);
 	if (freepage)
 		freepage(old);
-	put_page(old);
+	folio_put(fold);
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f3f7ce2c4068..d8a031128ad0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1282,8 +1282,10 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_page(&folio->page, swap);
 	} else {
+		void (*free_folio)(struct folio *);
 		void (*freepage)(struct page *);
 
+		free_folio = mapping->a_ops->free_folio;
 		freepage = mapping->a_ops->freepage;
 		/*
 		 * Remember a shadow entry for reclaimed file cache in
@@ -1310,7 +1312,9 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 			inode_add_lru(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 
-		if (freepage != NULL)
+		if (free_folio)
+			free_folio(folio);
+		if (freepage)
 			freepage(&folio->page);
 	}
 
-- 
2.34.1

