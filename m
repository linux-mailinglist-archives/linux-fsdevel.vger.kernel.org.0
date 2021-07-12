Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1593C4230
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhGLDs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGLDs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:48:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F57C0613DD;
        Sun, 11 Jul 2021 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nAWWLd0Jw+HcPX/B0JYf+cxlTXgzq/qxcOfR9aFVYxk=; b=CsgQiIg9pHsyqehYbGhd9i+GGo
        /DqPhCzmQtjPUuhNo2NiyB4EMpcpedP+aiDevTqaiMejnx8+OVbfe3zq+J3RK8CuMAimBLL7YuuAk
        4HmIEuPu/eSlejkcCnt19SOIKHYCTAEt/fuvKvuSOphKoUm7MxsZQVPAMUAmUWjLAJy3rI6SwMHBY
        2HoDkF+JHCbBnUaRB3C42iy5vYC1bI/JUJlpJFkqsHz6+8TjNM5rt8AxrlpTY7FynBNdYjBOGqkKo
        CHv6Y92tfZRarEnjQB1617OT9PzI1NvhoTvzdH+ywkhvyhGhXo9HFAapHyXcRF2q/NsPteBU2FSV6
        Op/I0Yuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mrk-00GpOc-Fy; Mon, 12 Jul 2021 03:44:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 070/137] mm/writeback: Add filemap_dirty_folio()
Date:   Mon, 12 Jul 2021 04:05:54 +0100
Message-Id: <20210712030701.4000097-71-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement __set_page_dirty_nobuffers() as a wrapper around
filemap_dirty_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  1 +
 mm/folio-compat.c         |  6 ++++
 mm/page-writeback.c       | 60 ++++++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 667e86cfbdcf..eda9cc778ef6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -398,6 +398,7 @@ void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
+bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
 void account_page_redirty(struct page *page);
 
 void sb_mark_inode_writeback(struct inode *inode);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 2c2b3917b5dc..dad962b920e5 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -83,3 +83,9 @@ bool set_page_dirty(struct page *page)
 	return folio_mark_dirty(page_folio(page));
 }
 EXPORT_SYMBOL(set_page_dirty);
+
+int __set_page_dirty_nobuffers(struct page *page)
+{
+	return filemap_dirty_folio(page_mapping(page), page_folio(page));
+}
+EXPORT_SYMBOL(__set_page_dirty_nobuffers);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3b5d2d42582f..35e998f064c2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2488,41 +2488,43 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
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
+	folio_memcg_lock(folio);
+	if (folio_test_set_dirty_flag(folio)) {
+		folio_memcg_unlock(folio);
+		return false;
+	}
 
-		if (!mapping) {
-			unlock_page_memcg(page);
-			return 1;
-		}
-		__set_page_dirty(page, mapping, !PagePrivate(page));
-		unlock_page_memcg(page);
+	__folio_mark_dirty(folio, mapping, !folio_private(folio));
+	folio_memcg_unlock(folio);
 
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
 }
-EXPORT_SYMBOL(__set_page_dirty_nobuffers);
+EXPORT_SYMBOL(filemap_dirty_folio);
 
 /*
  * Call this whenever redirtying a page, to de-account the dirty counters
-- 
2.30.2

