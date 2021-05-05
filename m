Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316A8373F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhEEQUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhEEQUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:20:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2541C06174A;
        Wed,  5 May 2021 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TOcA+5xL6B0vTfPXpuhbkkfct64kvjU4a4xf29UW6uw=; b=AY4CsH4dOnn9iGq/u55jXZThjc
        2E4jBmhOlNVOtl6xpv9wS6UzDMYCgWMNGSiRc8Hz3fThqri+D/qRG0gMzWCwEC7F4vuGO8dA8TMB3
        1TU8bgQfB7iyB3JiCic4TWzXwbgdnx09/7dqB364y22nag25qdt7JKMrEAzVfRIMNC3CnPgDaER2q
        plo+5EWw00lst3Rfla8w5esjWZfb8KXX07eIOuYtK8kGaYjne8H7BF5ovkKv31bgZnBEHdu4fBiAm
        egHgMrsp5CExZ9ELaQPYdvk9NMp/AmbfSySYIY5cvyro6icqHQOFYAD45HS2oHlxq1M3G23Rb3NRM
        bPQyVx1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKDh-000Zt5-8N; Wed, 05 May 2021 16:18:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 62/96] mm/writeback: Add filemap_dirty_folio
Date:   Wed,  5 May 2021 16:05:54 +0100
Message-Id: <20210505150628.111735-63-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 88f6734706c9..93a00d3efa55 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2489,39 +2489,47 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(__folio_mark_dirty);
 
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
-		if (!mapping) {
-			unlock_page_memcg(page);
-			return 1;
-		}
+	lock_folio_memcg(folio);
+	if (folio_test_set_dirty_flag(folio)) {
+		unlock_folio_memcg(folio);
+		return false;
+	}
 
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

