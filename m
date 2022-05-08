Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8551F14C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiEHUfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiEHUfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4B21BD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oLZttNpg9GHxm8+YKL8duErFYqMm2L4NPmkg41bCydo=; b=CZ/r7R3sGnPEJ0M7jxyb8ab7cX
        XM/7QK6548j1JYKFiyXVEpXh1b03P8YBltSDwk1+x0BI6PeJ7qEgOXtneJim7Ty57Z6XiBMY1n/xD
        RlKM5ji6lotK16983KWpbwkH53uKJ7dOdM+O/xmhHo/cmDF5QyERIwMbJn7mrdit0oHYTSt1AETQb
        JSl3Y6VluT7vxHsRQdTJrjrjQa393Zj7uUZuAG1g5yuTVrI2RErtG28f3E3gGLmbpOooR0yacdayb
        iik8n6Ye22+ekmups8fyFTkjIhVDlvcoP9judEMGAt43hqIGoyrnX7Zo+yufJPvDT0oHlHOMfaYl1
        QjX4xpgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYh-002nkR-Me; Sun, 08 May 2022 20:31:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] readahead: Use a folio in read_pages()
Date:   Sun,  8 May 2022 21:31:08 +0100
Message-Id: <20220508203111.667840-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203111.667840-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203111.667840-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle multi-page folios correctly and removes a few calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/readahead.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 4a60cdb64262..60a28af25c4e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -145,7 +145,7 @@ EXPORT_SYMBOL_GPL(file_ra_state_init);
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
-	struct page *page;
+	struct folio *folio;
 	struct blk_plug plug;
 
 	if (!readahead_count(rac))
@@ -156,24 +156,23 @@ static void read_pages(struct readahead_control *rac)
 	if (aops->readahead) {
 		aops->readahead(rac);
 		/*
-		 * Clean up the remaining pages.  The sizes in ->ra
+		 * Clean up the remaining folios.  The sizes in ->ra
 		 * may be used to size the next readahead, so make sure
 		 * they accurately reflect what happened.
 		 */
-		while ((page = readahead_page(rac))) {
-			rac->ra->size -= 1;
-			if (rac->ra->async_size > 0) {
-				rac->ra->async_size -= 1;
-				delete_from_page_cache(page);
+		while ((folio = readahead_folio(rac)) != NULL) {
+			unsigned long nr = folio_nr_pages(folio);
+
+			rac->ra->size -= nr;
+			if (rac->ra->async_size >= nr) {
+				rac->ra->async_size -= nr;
+				filemap_remove_folio(folio);
 			}
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
 		}
 	} else {
-		while ((page = readahead_page(rac))) {
-			aops->readpage(rac->file, page);
-			put_page(page);
-		}
+		while ((folio = readahead_folio(rac)))
+			aops->readpage(rac->file, &folio->page);
 	}
 
 	blk_finish_plug(&plug);
-- 
2.34.1

