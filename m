Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B584F373F66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhEEQSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhEEQSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937DC061574;
        Wed,  5 May 2021 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pzjZKBvHXw5UVmhHuKH02gMk37gDkBoR1/yDv6e9RKI=; b=Pvr5Mu42EI3H0gpKkAhF6FtJD8
        IEVpcJmbAYhJubhZinlC4Nw4T/LLLAMihxQuVNBQC0wgh9CNlLZB5GBT99Z9QACfh3qvEJQU3EzQq
        n/eeCxJm3ZUn1Buse/T46ZUGP5EtS619vk+6HXIbTUzhqjPVGVzO2aSMuRBCLGbDFJqQLzTelCEr0
        tVFI0+4csJ30DXVbAjEXyrXOYSETaFgrZc5uSP+JteRIe65tNQ8pZ8bL7gRrvWhA509Vqs2VNCuGu
        Jxmlr+qAkhkMt1X6hec+Falk2wituZwQwoXYlQYK0CzYk86/k0WS40g19gauUZCxZ5JkIqX0dlEjO
        NF9Szn2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKCW-000Znc-VV; Wed, 05 May 2021 16:16:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 60/96] mm/writeback: Use __set_page_dirty in __set_page_dirty_nobuffers
Date:   Wed,  5 May 2021 16:05:52 +0100
Message-Id: <20210505150628.111735-61-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move __set_page_dirty() from buffer.c (which is not compiled if
CONFIG_BLOCK is deselected) to writeback.c (which is always compiled
in).  This code was repeated almost verbatim, although the BUG_ON()
in __set_page_dirty_nobuffers() is removed because I can't prove to my
satisfaction that it never happens.

This means that account_page_dirtied() can now be static.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c         | 25 -------------------------
 include/linux/mm.h  |  1 -
 mm/page-writeback.c | 42 ++++++++++++++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 673cfbef9eec..f5384cff7e0c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -588,31 +588,6 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
-/*
- * Mark the page dirty, and set it dirty in the page cache, and mark the inode
- * dirty.
- *
- * If warn is true, then emit a warning if the page is not uptodate and has
- * not been truncated.
- *
- * The caller must hold lock_page_memcg().
- */
-void __set_page_dirty(struct page *page, struct address_space *mapping,
-			     int warn)
-{
-	unsigned long flags;
-
-	xa_lock_irqsave(&mapping->i_pages, flags);
-	if (page->mapping) {	/* Race with truncate? */
-		WARN_ON_ONCE(warn && !PageUptodate(page));
-		account_page_dirtied(page, mapping);
-		__xa_set_mark(&mapping->i_pages, page_index(page),
-				PAGECACHE_TAG_DIRTY);
-	}
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
-}
-EXPORT_SYMBOL_GPL(__set_page_dirty);
-
 /*
  * Add a page to the dirty page list.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c72cecbfe00d..8970ea86a5e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1995,7 +1995,6 @@ int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
-void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
 bool folio_mark_dirty(struct folio *folio);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d810841ed03a..534b9ef5dcd7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2417,7 +2417,8 @@ int __set_page_dirty_no_writeback(struct page *page)
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
-void account_page_dirtied(struct page *page, struct address_space *mapping)
+static void account_page_dirtied(struct page *page,
+		struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 
@@ -2458,6 +2459,35 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
 	}
 }
 
+/*
+ * Mark the page dirty, and set it dirty in the page cache, and mark the inode
+ * dirty.
+ *
+ * If warn is true, then emit a warning if the page is not uptodate and has
+ * not been truncated.
+ *
+ * The caller must hold lock_page_memcg().  Most callers have the page
+ * locked.  A few have the page blocked from truncation through other
+ * means (eg zap_page_range() has it mapped and is holding the page table
+ * lock).  This can also be called from mark_buffer_dirty(), which I
+ * cannot prove is always protected against truncate.
+ */
+void __set_page_dirty(struct page *page, struct address_space *mapping,
+			     int warn)
+{
+	unsigned long flags;
+
+	xa_lock_irqsave(&mapping->i_pages, flags);
+	if (page->mapping) {	/* Race with truncate? */
+		WARN_ON_ONCE(warn && !PageUptodate(page));
+		account_page_dirtied(page, mapping);
+		__xa_set_mark(&mapping->i_pages, page_index(page),
+				PAGECACHE_TAG_DIRTY);
+	}
+	xa_unlock_irqrestore(&mapping->i_pages, flags);
+}
+EXPORT_SYMBOL_GPL(__set_page_dirty);
+
 /*
  * For address_spaces which do not use buffers.  Just tag the page as dirty in
  * the xarray.
@@ -2475,20 +2505,12 @@ int __set_page_dirty_nobuffers(struct page *page)
 	lock_page_memcg(page);
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
-		unsigned long flags;
-
 		if (!mapping) {
 			unlock_page_memcg(page);
 			return 1;
 		}
 
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		BUG_ON(page_mapping(page) != mapping);
-		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
-		account_page_dirtied(page, mapping);
-		__xa_set_mark(&mapping->i_pages, page_index(page),
-				   PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		__set_page_dirty(page, mapping, !PagePrivate(page));
 		unlock_page_memcg(page);
 
 		if (mapping->host) {
-- 
2.30.2

