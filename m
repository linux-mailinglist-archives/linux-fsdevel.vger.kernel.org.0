Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2F2FA701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406350AbhARREx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393255AbhARRDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D4C061573;
        Mon, 18 Jan 2021 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=29ihG3xZAVE81H4LadxPn1TMPDKRCe/1A1Z2RRLt+j4=; b=ASYVqcvM/jSp/unq2q+YR91LRN
        RyUrJa7CPtd29B5q9OqfSA/7c2RekdkQjVR8Y/fgZ7MCzLZ9ddw+II8hkhV+o6tlTcSpX5AxMU0B/
        YcyF1y+4csi9RMVPl0fE5nwxu2DfVVKnQr8idWkOAeyW7CVGNI/9Ia/jD9WPq2T2NSGwgOeVMpqgK
        +rAhNyoZ++uaYKx8CeSnqeHiooEb71cgcvyxwUlVNHDHsefRKY/Ion9oHDRCNE49vtn+9oWNPfnm/
        5hrZOV4j7YQsvfcx7Hol1pWcEbOsbCmcOp6RsGL5bHXwRGZFjiPp+RFD+jyrl9KVXiH6of5pg+lu4
        FKoOw7oA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xvz-00D7VL-4Z; Mon, 18 Jan 2021 17:03:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/27] mm: Add wait_for_stable_folio and wait_on_folio_writeback
Date:   Mon, 18 Jan 2021 17:01:42 +0000
Message-Id: <20210118170148.3126186-22-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add compatibility wrappers for code which has not yet been converted
to use folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 12 ++++++++++--
 mm/page-writeback.c     | 27 +++++++++++++--------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 685f1b394629..619bfc6ea1ff 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -746,13 +746,21 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 extern void put_and_wait_on_page_locked(struct page *page);
 
-void wait_on_page_writeback(struct page *page);
+void wait_on_folio_writeback(struct folio *folio);
+static inline void wait_on_page_writeback(struct page *page)
+{
+	return wait_on_folio_writeback(page_folio(page));
+}
 void end_folio_writeback(struct folio *folio);
 static inline void end_page_writeback(struct page *page)
 {
 	return end_folio_writeback(page_folio(page));
 }
-void wait_for_stable_page(struct page *page);
+void wait_for_stable_folio(struct folio *folio);
+static inline void wait_for_stable_page(struct page *page)
+{
+	return wait_for_stable_folio(page_folio(page));
+}
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 51b4326f0aaa..908fc7f60ae7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2822,30 +2822,29 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 EXPORT_SYMBOL(__test_set_page_writeback);
 
 /*
- * Wait for a page to complete writeback
+ * Wait for a folio to complete writeback
  */
-void wait_on_page_writeback(struct page *page)
+void wait_on_folio_writeback(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	while (FolioWriteback(folio)) {
-		trace_wait_on_page_writeback(page, folio_mapping(folio));
+		trace_wait_on_page_writeback(&folio->page,
+						folio_mapping(folio));
 		wait_on_folio_bit(folio, PG_writeback);
 	}
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
 
 /**
- * wait_for_stable_page() - wait for writeback to finish, if necessary.
- * @page:	The page to wait on.
+ * wait_for_stable_folio() - wait for writeback to finish, if necessary.
+ * @folio: The folio to wait on.
  *
- * This function determines if the given page is related to a backing device
- * that requires page contents to be held stable during writeback.  If so, then
+ * This function determines if the given folio is related to a backing device
+ * that requires folio contents to be held stable during writeback.  If so, then
  * it will wait for any pending writeback to complete.
  */
-void wait_for_stable_page(struct page *page)
+void wait_for_stable_folio(struct folio *folio)
 {
-	page = thp_head(page);
-	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
-		wait_on_page_writeback(page);
+	if (folio->page.mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+		wait_on_folio_writeback(folio);
 }
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
+EXPORT_SYMBOL_GPL(wait_for_stable_folio);
-- 
2.29.2

