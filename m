Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB373F64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhEEQSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhEEQSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:18:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66542C061574;
        Wed,  5 May 2021 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iR+jUREiomMhRTmoseCoiGMsLSDkdzy18VAyMLzYr0Y=; b=tDqTcdLd+VRgq+jmVe5kpmm8i4
        BlnFUzII4z3bIp+CMpwYUIzH6qMF5NuU0d+bWqCy09OvoOen8lM9Ru7uvgnNo1l8iHQNHv85LSW4+
        61brQMUMwcCJfwr+kWdi6xX0S/WP59GlNBUe/LCCpTXz4ZM30x/W0AeLqiET6pCGZP8OHy+EuSK8c
        vTikp4+nnQlAPYv1k2AqSjnCchMAcvNV1mxoWyaoDRYT1IVeI5O39NZI6EDsCk+OEucw7Z1RKh/iq
        BjC7hAFdaF0PFOUWuXznIUWDZx7nXO0M9Mye4ST01sBkZHM16wI6qsTmHlgAHPO2d5Jj38t5RzeYa
        MPEaiuvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKBg-000Zkc-OZ; Wed, 05 May 2021 16:16:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 59/96] mm/writeback: Add folio_mark_dirty
Date:   Wed,  5 May 2021 16:05:51 +0100
Message-Id: <20210505150628.111735-60-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
 mm/page-writeback.c | 28 +++++++++++++++-------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 75279db82040..c72cecbfe00d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1998,7 +1998,8 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
-int set_page_dirty(struct page *page);
+bool folio_mark_dirty(struct folio *folio);
+bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 void __cancel_dirty_page(struct page *page);
 static inline void cancel_dirty_page(struct page *page)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index d229b979b00d..a504ecf1d695 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -60,3 +60,9 @@ void mem_cgroup_uncharge(struct page *page)
 	folio_uncharge_cgroup(page_folio(page));
 }
 #endif
+
+bool set_page_dirty(struct page *page)
+{
+	return folio_mark_dirty(page_folio(page));
+}
+EXPORT_SYMBOL(set_page_dirty);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4d36f4d3037f..d810841ed03a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2543,8 +2543,9 @@ int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
 
-/*
- * Dirty a page.
+/**
+ * folio_mark_dirty - Mark a folio as being modified.
+ * @folio: The folio.
  *
  * For pages with a mapping this should be done under the page lock
  * for the benefit of asynchronous memory errors who prefer a consistent
@@ -2553,12 +2554,13 @@ EXPORT_SYMBOL(redirty_page_for_writepage);
  *
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
+ *
+ * Return: True if the folio was newly dirtied, false if it was already dirty.
  */
-int set_page_dirty(struct page *page)
+bool folio_mark_dirty(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 
-	page = compound_head(page);
 	if (likely(mapping)) {
 		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
 		/*
@@ -2571,21 +2573,21 @@ int set_page_dirty(struct page *page)
 		 * it will confuse readahead and make it restart the size rampup
 		 * process. But it's a trivial problem.
 		 */
-		if (PageReclaim(page))
-			ClearPageReclaim(page);
+		if (folio_reclaim(folio))
+			folio_clear_reclaim_flag(folio);
 #ifdef CONFIG_BLOCK
 		if (!spd)
 			spd = __set_page_dirty_buffers;
 #endif
-		return (*spd)(page);
+		return (*spd)(&folio->page);
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

