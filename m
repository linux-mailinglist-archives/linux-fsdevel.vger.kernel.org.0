Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7EB3A865E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFOQ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQ1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:27:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4AC06175F;
        Tue, 15 Jun 2021 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IU3uQ9dfLdujI7vBKXSENxNJrVKzI0DwLt9eQ0OWiv4=; b=mUqd0HzNMuiamZCq7haghNckiU
        1+R82zegJ/jod0xWzejW2ZQ2fpnQDVbpC2GWuRF0V5f7WjNfQ22YG2NMP+3Zt6krEP3lG92znu4c6
        8SUfiQ38SXoWvGCwhJUI/qELoROABdzJMsNVcM/6z0awEj3bgHewPByBiBpnHcUUDv9+vUsmHCCPw
        ljbyjVeLBEy/CoMgQ5HKB7KGqHH/UVU7I6SMI02dXcUlz8HZIfabkVCGIQaI59xKf/S0A4949G08S
        tYqx4N1HE3NVvX20HxxYo/5WbNiTgo1evnXsXNV3yeEoE7TTRUXplxRLWPwBNLiU/lQ5ESVCNFug0
        6f834zKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBrJ-0070Jv-7e; Tue, 15 Jun 2021 16:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/6] mm/writeback: Move __set_page_dirty() to core mm
Date:   Tue, 15 Jun 2021 17:23:37 +0100
Message-Id: <20210615162342.1669332-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nothing in __set_page_dirty() is specific to buffer_head, so
move it to mm/page-writeback.c.  That removes the only caller of
account_page_dirtied() outside of page-writeback.c, so make it static.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c         | 24 ------------------------
 include/linux/mm.h  |  1 -
 mm/page-writeback.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c02e44f16f2..f5384cff7e0c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -588,30 +588,6 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
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
-
 /*
  * Add a page to the dirty page list.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d64f8a1284d9..1086b556961a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1858,7 +1858,6 @@ int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
-void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
 int set_page_dirty(struct page *page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f6ee085767cb..0c2c8355f97f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2420,7 +2420,8 @@ int __set_page_dirty_no_writeback(struct page *page)
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
-void account_page_dirtied(struct page *page, struct address_space *mapping)
+static void account_page_dirtied(struct page *page,
+		struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 
@@ -2461,6 +2462,30 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
 	}
 }
 
+/*
+ * Mark the page dirty, and set it dirty in the page cache, and mark the inode
+ * dirty.
+ *
+ * If warn is true, then emit a warning if the page is not uptodate and has
+ * not been truncated.
+ *
+ * The caller must hold lock_page_memcg().
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
+
 /*
  * For address_spaces which do not use buffers.  Just tag the page as dirty in
  * the xarray.
-- 
2.30.2

