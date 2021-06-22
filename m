Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBCB3B04D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhFVMl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhFVMlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:41:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCEC061226;
        Tue, 22 Jun 2021 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=11kdbqvYhRBDCHO2+D2gr2DMHWP2KlimD+LgU9BHCe0=; b=cFgGmWYDTK9mWSw0gdQQKo7U7m
        9yrIfZwdCgGXy8Ha8rqFIs8xSyYk8zcZgQFsrpv+WZGvqNKah4zBRmNGUfDRP6tholvGdIU9/li/b
        0MfDXC2OFf7R9YEk2EXS9sDjaIYxgO2tbDgW7SYtcfQcwDabVYRTQPyr61PraWnKWRsrXZLk8fElJ
        xLNW6DcdJh0YkqMtfQRu3D/uH8zGnQmEnVawP5cYDGCSqLrYC27rdc7qrV4qfQV2vIvvoJ1sfH+It
        T4Iod+iDsOjUR/Nx7yUPaQveNvJQVb843Ho2hRcHlAntQ77XL6yOJZNUnqW61h5K4tJs6usreB4nJ
        lf2YLB8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfeJ-00EHmg-5r; Tue, 22 Jun 2021 12:37:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/46] mm/writeback: Add folio_mark_dirty()
Date:   Tue, 22 Jun 2021 13:15:31 +0100
Message-Id: <20210622121551.3398730-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement set_page_dirty() as a wrapper around folio_mark_dirty().
There is no change to filesystems as they were already being called
with the compound_head of the page being marked dirty.  We avoid
several calls to compound_head(), both statically (through
using folio_dirty() instead of PageDirty() and dynamically by
calling folio_mapping() instead of page_mapping().

Also return bool instead of int to show the range of values actually
returned, and add kernel-doc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h  |  3 ++-
 mm/folio-compat.c   |  6 ++++++
 mm/page-writeback.c | 35 +++++++++++++++++++----------------
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5609095ffcac..3c8dfcb56fa5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1988,7 +1988,8 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
-int set_page_dirty(struct page *page);
+bool folio_mark_dirty(struct folio *folio);
+bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 void __cancel_dirty_page(struct page *page);
 static inline void cancel_dirty_page(struct page *page)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index db9190fa6bf5..60780ceca363 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -89,3 +89,9 @@ bool set_page_writeback(struct page *page)
 	return folio_start_writeback(page_folio(page));
 }
 EXPORT_SYMBOL(set_page_writeback);
+
+bool set_page_dirty(struct page *page)
+{
+	return folio_mark_dirty(page_folio(page));
+}
+EXPORT_SYMBOL(set_page_dirty);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ffb55ca2ddd5..73b937955cc1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2560,18 +2560,21 @@ int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
 
-/*
- * Dirty a page.
+/**
+ * folio_mark_dirty - Mark a folio as being modified.
+ * @folio: The folio.
+ *
+ * For folios with a mapping this should be done under the page lock
+ * for the benefit of asynchronous memory errors who prefer a consistent
+ * dirty state. This rule can be broken in some special cases,
+ * but should be better not to.
  *
- * For pages with a mapping this should be done under the page lock for the
- * benefit of asynchronous memory errors who prefer a consistent dirty state.
- * This rule can be broken in some special cases, but should be better not to.
+ * Return: True if the folio was newly dirtied, false if it was already dirty.
  */
-int set_page_dirty(struct page *page)
+bool folio_mark_dirty(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 
-	page = compound_head(page);
 	if (likely(mapping)) {
 		/*
 		 * readahead/lru_deactivate_page could remain
@@ -2583,17 +2586,17 @@ int set_page_dirty(struct page *page)
 		 * it will confuse readahead and make it restart the size rampup
 		 * process. But it's a trivial problem.
 		 */
-		if (PageReclaim(page))
-			ClearPageReclaim(page);
-		return mapping->a_ops->set_page_dirty(page);
+		if (folio_reclaim(folio))
+			folio_clear_reclaim_flag(folio);
+		return mapping->a_ops->set_page_dirty(&folio->page);
 	}
-	if (!PageDirty(page)) {
-		if (!TestSetPageDirty(page))
-			return 1;
+	if (!folio_dirty(folio)) {
+		if (!folio_test_set_dirty_flag(folio))
+			return true;
 	}
-	return 0;
+	return false;
 }
-EXPORT_SYMBOL(set_page_dirty);
+EXPORT_SYMBOL(folio_mark_dirty);
 
 /*
  * set_page_dirty() is racy if the caller has no reference against
-- 
2.30.2

