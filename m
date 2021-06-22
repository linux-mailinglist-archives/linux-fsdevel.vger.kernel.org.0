Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4B3B04E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhFVMoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhFVMnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:43:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B101C06175F;
        Tue, 22 Jun 2021 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ml6en5WP7nNAZwLT8qOLPbblbdB7QSwp/dTo7kgFCNc=; b=XMv80mAqzfnRawnpGahlkF8+Yh
        qONgvzw2I/Xp7oGij5GR5dTcyZPm7LAg6r5/p6v8uO65k3DN2SRWX2qmdkiiTSbQtTHxqzTYUCWQa
        sSYdhsk9njYgHn+BxFwWNgwoHcdcfViUuOZ1DMhrIZSTFXIoN3DzA/dCoIfGBB4GvG9/61Un72P9x
        uLh78Kb9LxFVvCkm1dgHHQqhX8knpzFwU8FUIUZaGFd1y8dD4lPVdrAI1+ZUiJVNwPkWoDyr4vRWm
        p+tVfVHaB0H++TGw45xHTK7Zn/JuGqqk204ibsnxIr5DSeoA10+OtESDoJkxt9wXt8klXiCViqzSc
        IA3sNBpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfgA-00EHwq-Uw; Tue, 22 Jun 2021 12:39:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/46] mm/writeback: Add filemap_dirty_folio()
Date:   Tue, 22 Jun 2021 13:15:33 +0100
Message-Id: <20210622121551.3398730-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement __set_page_dirty_nobuffers() as a wrapper around
filemap_dirty_folio().  This can use a cast to struct folio
because we know that the ->set_page_dirty address space op
is always called with a page pointer that happens to also be
a folio pointer.  Saves 7 bytes of kernel text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 64 ++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8e5c5bb16e2d..aa372f6d2b55 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -398,6 +398,7 @@ void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
+bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
 void account_page_redirty(struct page *page);
 
 void sb_mark_inode_writeback(struct inode *inode);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a7989870b171..64b989eff9f5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2484,39 +2484,47 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
-/*
- * For address_spaces which do not use buffers.  Just tag the page as dirty in
- * the xarray.
- *
- * This is also used when a single buffer is being dirtied: we want to set the
- * page dirty in that case, but not all the buffers.  This is a "bottom-up"
- * dirtying, whereas __set_page_dirty_buffers() is a "top-down" dirtying.
- *
- * The caller must ensure this doesn't race with truncation.  Most will simply
- * hold the page lock, but e.g. zap_pte_range() calls with the page mapped and
- * the pte lock held, which also locks out truncation.
+/**
+ * filemap_dirty_folio - Mark a folio dirty for filesystems which do not use buffer_heads.
+ * @mapping: Address space this folio belongs to.
+ * @folio: Folio to be marked as dirty.
+ *
+ * Filesystems which do not use buffer heads should call this function
+ * from their set_page_dirty address space operation.  It ignores the
+ * contents of folio_private(), so if the filesystem marks individual
+ * blocks as dirty, the filesystem should handle that itself.
+ *
+ * This is also sometimes used by filesystems which use buffer_heads when
+ * a single buffer is being dirtied: we want to set the folio dirty in
+ * that case, but not all the buffers.  This is a "bottom-up" dirtying,
+ * whereas __set_page_dirty_buffers() is a "top-down" dirtying.
+ *
+ * The caller must ensure this doesn't race with truncation.  Most will
+ * simply hold the folio lock, but e.g. zap_pte_range() calls with the
+ * folio mapped and the pte lock held, which also locks out truncation.
  */
-int __set_page_dirty_nobuffers(struct page *page)
+bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	lock_page_memcg(page);
-	if (!TestSetPageDirty(page)) {
-		struct address_space *mapping = page_mapping(page);
+	lock_folio_memcg(folio);
+	if (folio_test_set_dirty_flag(folio)) {
+		unlock_folio_memcg(folio);
+		return false;
+	}
 
-		if (!mapping) {
-			unlock_page_memcg(page);
-			return 1;
-		}
-		__set_page_dirty(page, mapping, !PagePrivate(page));
-		unlock_page_memcg(page);
+	__folio_mark_dirty(folio, mapping, !folio_private(folio));
+	unlock_folio_memcg(folio);
 
-		if (mapping->host) {
-			/* !PageAnon && !swapper_space */
-			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-		}
-		return 1;
+	if (mapping->host) {
+		/* !PageAnon && !swapper_space */
+		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
-	unlock_page_memcg(page);
-	return 0;
+	return true;
+}
+EXPORT_SYMBOL(filemap_dirty_folio);
+
+int __set_page_dirty_nobuffers(struct page *page)
+{
+	return filemap_dirty_folio(page_mapping(page), (struct folio *)page);
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
-- 
2.30.2

