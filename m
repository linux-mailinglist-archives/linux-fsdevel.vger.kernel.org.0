Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BC306E40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhA1HMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhA1HGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797FC061354;
        Wed, 27 Jan 2021 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ygW++6r4tTQMTzApkW4AZOQ5az03gXMpcnJ0OlBXVu4=; b=pAPZgW1WCO3yZwikfchXQjBu+S
        UWjWqpyt73mqskM4+Bpjsbljmz1MM2ciihd5mFQ5EgwLHRaLYBBTaRQ463zkaxNa97b7q38VAfoRg
        GwyNX1WCC7is/0lyzSonI4UjNYnw9RW+ji0vs+zjh72UJPNclakfziUOdhwbYbs5fl7QHOkWgPZCf
        unZOgHSnPWz24hf5/FL74/iptcifgGlJBmsOPNSOT3ZA/5NYwDmndbTwsG5ARc9RaANMw8pUK5irH
        7qN6oi9ubb/HTH76qIVuFR43eJ+qx7ZRBeGk+/VHU+JyazFKm460wIhe0SNcwE5qk9cb/I93jrIAU
        5cQZ7lIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51MD-00848R-9w; Thu, 28 Jan 2021 07:04:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/25] mm: Add wait_for_stable_folio and wait_on_folio_writeback
Date:   Thu, 28 Jan 2021 07:03:58 +0000
Message-Id: <20210128070404.1922318-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index 55f3c1a8be3c..757e437e7f09 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -760,13 +760,21 @@ static inline void wait_on_page_fscache(struct page *page)
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
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

