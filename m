Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CCF64E36A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOVoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLOVoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F25C771
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qdO/DqGtnGYOBvBVhitPl5mQ783V5yC6feoboQP062M=; b=o9cdh32C9HCIUu30/PEpOiWsox
        DBvIpD4x2L1Jw/kmJwNhChLEeHiq2VvcDKWFqQZcfg5zGog1+Yg3qPIpq4CdXtUoqhmGUiyU+vx/U
        J/IdIXlttY4o96BUCK2bxcdW+Vy5nRLgwuIu0lV5TvP8e38KXFvJPyryZ+EffZU01lVrkhd0U8ShV
        zTvM35l/rY5wfHO2zMTKqgV+61A2hRpK5PywfG1Trkvb46RrtxGOG/tPe018GnlwoUIbJ3sE1FpqR
        E3XyCREvTIwWQh911FnSEcEyJWOiVMfW+z2myTkJuAPE+ENlAL/JOrB05Ext/sXDpWGO5k3PBS62g
        6L7uJldg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLQ-Hc; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] buffer: Use b_folio in end_buffer_async_read()
Date:   Thu, 15 Dec 2022 21:43:54 +0000
Message-Id: <20221215214402.3522366-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removes a call to compound_head() in SetPageError(), saving 76 bytes
of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8a02fdaeec9a..5bdcc040eca3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -246,18 +246,18 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	unsigned long flags;
 	struct buffer_head *first;
 	struct buffer_head *tmp;
-	struct page *page;
-	int page_uptodate = 1;
+	struct folio *folio;
+	int folio_uptodate = 1;
 
 	BUG_ON(!buffer_async_read(bh));
 
-	page = bh->b_page;
+	folio = bh->b_folio;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
 		clear_buffer_uptodate(bh);
 		buffer_io_error(bh, ", async page read");
-		SetPageError(page);
+		folio_set_error(folio);
 	}
 
 	/*
@@ -265,14 +265,14 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	 * two buffer heads end IO at almost the same time and both
 	 * decide that the page is now completely done.
 	 */
-	first = page_buffers(page);
+	first = folio_buffers(folio);
 	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
 	do {
 		if (!buffer_uptodate(tmp))
-			page_uptodate = 0;
+			folio_uptodate = 0;
 		if (buffer_async_read(tmp)) {
 			BUG_ON(!buffer_locked(tmp));
 			goto still_busy;
@@ -285,9 +285,9 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	 * If all of the buffers are uptodate then we can set the page
 	 * uptodate.
 	 */
-	if (page_uptodate)
-		SetPageUptodate(page);
-	unlock_page(page);
+	if (folio_uptodate)
+		folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return;
 
 still_busy:
-- 
2.35.1

