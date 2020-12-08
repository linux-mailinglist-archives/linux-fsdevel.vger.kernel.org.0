Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC92D3397
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgLHUWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgLHUWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4DC061793;
        Tue,  8 Dec 2020 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EWMwluwghzqMbyH7unQrphsIIg3dNu3LaF6rUw+qDGE=; b=aE6s6V1H9YrEt3+UkLCtIYZgU+
        W/y4dZ9TRX/TgA1zCHDt00x0BZn+x567FJ1PsG9dKTruIgFuTYUltHDwQCg8JiQFA7KsMMWb1PRTU
        0moz6DO6HcRj69g7cHI5ZpGPEtw7iIQDA0VD/Q+OhYbBZ+lvtGGxDWsIFk9GGGEY9dy/64szeOm2z
        WG/jNwhUuvpZw/rTFs0xCnMvD3wbgrUxwHzt/ddNIRDC5/oOrh1kOK7AL27ktUJRyhOYgHm115PqP
        QeierKpiLGoi7zGdXyqozaQiIsg/LzgxbaqwCLTxTK6l8SC9r4ZThst1no9l7OVbETSiyPSrKsKyo
        9I9/db4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwt-00050y-H9; Tue, 08 Dec 2020 19:46:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/11] mm/filemap: Convert end_page_writeback to use a folio
Date:   Tue,  8 Dec 2020 19:46:50 +0000
Message-Id: <20201208194653.19180-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
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
index 50535b21b452..f1b65f777539 100644
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

