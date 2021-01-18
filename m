Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D362FA724
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393533AbhARRLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406664AbhARREF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3DC061794;
        Mon, 18 Jan 2021 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uqJ8K0YMB9W8U/LhIs0PpD/u/oUu+JAwDIVdGmLFoDY=; b=NfKyfgzBwEydTE3gXbtb31IXe5
        LXpuRBDgfzp/cyUX0ia9X9rsq3YOfK8YaIaszR2N0Y8VVyiF9JTd5Yhpf3+Qml05lpji5mnEZn3aa
        I2m3CivFy9kOANoQLlEG8+IcB1KHAljtYXnf6hsmaVD+6Cr//zJYPT4gcg9WmBn/HrN3xaciWaJjM
        d0U14EgHXlsakKsu2FzPsKZ4+LkrO5KvraCVLP5TDZhJ9c3HbP1LlXX6iQ3kLmsRe2Xas/6mUvCEC
        c/VIMrlhBY7WE1+6fc5lUr+R4xOKOFVxjTj63vPlv3S3sYeNNeegiZRLoBRI/qdMnl6XbacwMLnOE
        HjxpRIvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XvM-00D7No-T1; Mon, 18 Jan 2021 17:02:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/27] mm/filemap: Convert end_page_writeback to end_folio_writeback
Date:   Mon, 18 Jan 2021 17:01:40 +0000
Message-Id: <20210118170148.3126186-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wrapper function for users that are not yet converted to folios.
With a distro config, this function shrinks from 213 bytes to 105 bytes
due to elimination of repeated calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  6 +++++-
 mm/filemap.c            | 30 +++++++++++++++---------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 44fa7d974aa4..7a79e159307c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -745,7 +745,11 @@ static inline int wait_on_page_locked_killable(struct page *page)
 extern void put_and_wait_on_page_locked(struct page *page);
 
 void wait_on_page_writeback(struct page *page);
-extern void end_page_writeback(struct page *page);
+void end_folio_writeback(struct folio *folio);
+static inline void end_page_writeback(struct page *page)
+{
+	return end_folio_writeback(page_folio(page));
+}
 void wait_for_stable_page(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
diff --git a/mm/filemap.c b/mm/filemap.c
index e997f4424ed9..952457071630 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1143,11 +1143,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
+static void wake_up_folio(struct folio *folio, int bit)
 {
-	if (!PageWaiters(page))
+	if (!FolioWaiters(folio))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(&folio->page, bit);
 }
 
 /*
@@ -1456,10 +1456,10 @@ void unlock_folio(struct folio *folio)
 EXPORT_SYMBOL(unlock_folio);
 
 /**
- * end_page_writeback - end writeback against a page
- * @page: the page
+ * end_folio_writeback - End writeback against a page.
+ * @folio: The page.
  */
-void end_page_writeback(struct page *page)
+void end_folio_writeback(struct folio *folio)
 {
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
@@ -1468,26 +1468,26 @@ void end_page_writeback(struct page *page)
 	 * justify taking an atomic operation penalty at the end of
 	 * ever page writeback.
 	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
+	if (FolioReclaim(folio)) {
+		ClearFolioReclaim(folio);
+		rotate_reclaimable_page(&folio->page);
 	}
 
 	/*
 	 * Writeback does not hold a page reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
 	 * But here we must make sure that the page is not freed and
-	 * reused before the wake_up_page().
+	 * reused before the wake_up_folio().
 	 */
-	get_page(page);
-	if (!test_clear_page_writeback(page))
+	get_folio(folio);
+	if (!test_clear_page_writeback(&folio->page))
 		BUG();
 
 	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
-	put_page(page);
+	wake_up_folio(folio, PG_writeback);
+	put_folio(folio);
 }
-EXPORT_SYMBOL(end_page_writeback);
+EXPORT_SYMBOL(end_folio_writeback);
 
 /*
  * After completing I/O on a page, call this routine to update the page
-- 
2.29.2

