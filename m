Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F915306E5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhA1HMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhA1HGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF5C061352;
        Wed, 27 Jan 2021 23:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vubdtaQWQeb3O1xbmJzkY0QVyoI2oW12CsKSfFTBgHk=; b=VDnjqafO8M2A37eQLwr/AMPx9B
        eoKUec9vhasFawd0N5bbQkHDVR7q+tg3MFNYd3gsAR74QRj2fzzfOO9lvjDwIaDXH/3dMmdlVZ7Sq
        aACTKJwc3V+SCOLbW2IJtL/b1knWrq8nF4V5dOCxInQHsV+bRZCeAXxUz1sSga2gmYfbdyybTJtX3
        dJDIGUpdxqZB1/GzFJIB9aKKV3sj8ZB7TQrtXK5GREHAj+P2/wUVNlOMFVoOlnlc6x1MLBVGnxV+2
        iIm7CeU/R/mcdOkCWZojDJOrWCchebD0qQIZEO9K5wozUV35suCNT3OnEd6TG19NGKt53/AxbpQU3
        RJOCe4nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51MA-00848H-CF; Thu, 28 Jan 2021 07:04:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/25] mm/filemap: Convert end_page_writeback to end_folio_writeback
Date:   Thu, 28 Jan 2021 07:03:56 +0000
Message-Id: <20210128070404.1922318-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index 131d1aa2af61..67d3badc9fe0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -758,7 +758,11 @@ static inline void wait_on_page_fscache(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
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
index a54eb4641385..65008c42e47d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1147,11 +1147,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
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
@@ -1443,10 +1443,10 @@ void unlock_page_fscache(struct page *page)
 EXPORT_SYMBOL(unlock_page_fscache);
 
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
@@ -1455,26 +1455,26 @@ void end_page_writeback(struct page *page)
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

