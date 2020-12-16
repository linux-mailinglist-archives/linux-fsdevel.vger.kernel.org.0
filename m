Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C322DC642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgLPSZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A0C061257;
        Wed, 16 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wgSLUQVGs2mzK29oI4B8XueV4kSBF9PQMmHMnOv+VpU=; b=CnY/hkQUJgs4MRuYLidMJcab1L
        SspioDLyhuvuidzcKpZW06yDf+tytY2a7/hGBj5gTrXx/Wq/OULF/j52VUC6ohh9Rh1kcQ3cYYpd5
        x35DOjymVH5/PpkbpenmXQxsKteFDbzTKwtc5bMmfY7CW0sehxqQGr5vldSjrIROAejtWYRDOSMbN
        fxdp21DFwvrYxkDVTr57Ss6eyR0zsca5/03pwrR8JOLfpZ2kS2d19RiurLBWTCAX1DOu6NxeM7Mgl
        fTWYGx1xuP+XJEpwjvmE9/LFXrbNQl2+wcaScqkDXtvHr4y/57DLACo25Px8RmMNVjlxstZtinB2q
        PfGMUgzA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSe-00076u-1i; Wed, 16 Dec 2020 18:23:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] mm/filemap: Convert end_page_writeback to use a folio
Date:   Wed, 16 Dec 2020 18:23:20 +0000
Message-Id: <20201216182335.27227-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With my config, this function shrinks from 480 bytes to 240 bytes
due to elimination of repeated calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6012e8a7bd6c..654bba53442a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1148,11 +1148,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
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
@@ -1466,6 +1466,8 @@ EXPORT_SYMBOL(unlock_folio);
  */
 void end_page_writeback(struct page *page)
 {
+	struct folio *folio = page_folio(page);
+
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
 	 * operation and overkill in this particular case. Failing to
@@ -1473,9 +1475,9 @@ void end_page_writeback(struct page *page)
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
@@ -1484,13 +1486,13 @@ void end_page_writeback(struct page *page)
 	 * But here we must make sure that the page is not freed and
 	 * reused before the wake_up_page().
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
 EXPORT_SYMBOL(end_page_writeback);
 
-- 
2.29.2

