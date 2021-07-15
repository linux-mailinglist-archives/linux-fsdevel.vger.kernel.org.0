Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2397E3C977D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhGOEe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbhGOEe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:34:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A0C06175F;
        Wed, 14 Jul 2021 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xQjoI7gQK9ZaPd2yc5A5rXOJHMJVziT90rkS1B75TtQ=; b=uYhDEH7u1wTwo6yjv/RakWAoSL
        tUyCYH8zrcltFk8xSxea9G9GRdnT4UDzmaDbvuAaKk9gqdv9rbz6IGLjhwft5vybc9aiJj4BLAGhg
        2v/Dl96dm3beF/t230LEG+OQQYdYFq6mZEr7EV/fK+5srrBBoSfS0PF0s/GgW37FTRAhzH+UFr4TE
        2CKltbEGYGorGprE8K8C5hhrH9bVI9mbCKffwPOLlCatBDVcT0wiwH7mzSvrzn8ZqRf3mBFKOCBsN
        AKoTd6cYPtsbg2XruVdLEA3Ak8vv5Ib4JF392pmYXYlYW9JgSXvmEzW5lx/LlB1Ah/f2QFL4nwhaJ
        CaWJwLmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t1D-002xeU-HM; Thu, 15 Jul 2021 04:30:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 068/138] mm/writeback: Add folio_mark_dirty()
Date:   Thu, 15 Jul 2021 04:35:54 +0100
Message-Id: <20210715033704.692967-69-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement set_page_dirty() as a wrapper around folio_mark_dirty().
There is no change to filesystems as they were already being called
with the compound_head of the page being marked dirty.  We avoid
several calls to compound_head(), both statically (through
using folio_test_dirty() instead of PageDirty() and dynamically by
calling folio_mapping() instead of page_mapping().

Also return bool instead of int to show the range of values actually
returned, and add kernel-doc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h  |  3 ++-
 mm/folio-compat.c   |  6 ++++++
 mm/page-writeback.c | 35 +++++++++++++++++++----------------
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 23276330ef4f..43c1b5731c7f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2005,7 +2005,8 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
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
index 10ce5582d869..2c2b3917b5dc 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -77,3 +77,9 @@ bool set_page_writeback(struct page *page)
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
index 0336273154fb..d7c0cad6a57f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2564,18 +2564,21 @@ int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
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
@@ -2587,17 +2590,17 @@ int set_page_dirty(struct page *page)
 		 * it will confuse readahead and make it restart the size rampup
 		 * process. But it's a trivial problem.
 		 */
-		if (PageReclaim(page))
-			ClearPageReclaim(page);
-		return mapping->a_ops->set_page_dirty(page);
+		if (folio_test_reclaim(folio))
+			folio_clear_reclaim(folio);
+		return mapping->a_ops->set_page_dirty(&folio->page);
 	}
-	if (!PageDirty(page)) {
-		if (!TestSetPageDirty(page))
-			return 1;
+	if (!folio_test_dirty(folio)) {
+		if (!folio_test_set_dirty(folio))
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

