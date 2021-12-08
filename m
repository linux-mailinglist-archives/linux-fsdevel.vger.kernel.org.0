Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94D46CC68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhLHE1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AFC061D76
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9Lt8nc8uCMiQ8EPI8aySjPso9UmiJ/85df+p8gpiD3U=; b=AHmJb0PrliFHPV1qjvwMrHEgRi
        tlvRWFkKM0IIz4vb7L6CaAPw2xP4EOqY+wxsUDTsWGc7DVkTncS3O0D4pG1ZOvmGxspAOukzy8lVn
        iubvMLqDUsr/OSSNmjYBmkk++4JIax4FU2qUEVSkXrb+wf/+JOBHAha7El/eiVcRIlmlHixtgv2KE
        IOQaDpM1V+3ZQhiMHHtGBRnkXnrhQF5cwocnlzcCGs48XU90nYNl5o/c1jqwidWYckvfEeRLSmySM
        51lrPiLtunEKoIElPXZ3iPbLNOhZo6MyJLhqWlUse4N/T8r2yUfi/gDel8+W1/9ar7Kd12jSCkgOY
        NO9nNVtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084YZ-0R; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/48] readahead: Convert page_cache_async_ra() to take a folio
Date:   Wed,  8 Dec 2021 04:22:29 +0000
Message-Id: <20211208042256.1923824-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using the folio here avoids checking whether it's a tail page.
This patch mostly just enables some of the following patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 mm/readahead.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8c2cad7f0c36..30302be6977f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -993,7 +993,7 @@ struct readahead_control {
 void page_cache_ra_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
 void page_cache_sync_ra(struct readahead_control *, unsigned long req_count);
-void page_cache_async_ra(struct readahead_control *, struct page *,
+void page_cache_async_ra(struct readahead_control *, struct folio *,
 		unsigned long req_count);
 void readahead_expand(struct readahead_control *ractl,
 		      loff_t new_start, size_t new_len);
@@ -1040,7 +1040,7 @@ void page_cache_async_readahead(struct address_space *mapping,
 		struct page *page, pgoff_t index, unsigned long req_count)
 {
 	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
-	page_cache_async_ra(&ractl, page, req_count);
+	page_cache_async_ra(&ractl, page_folio(page), req_count);
 }
 
 static inline struct folio *__readahead_folio(struct readahead_control *ractl)
diff --git a/mm/readahead.c b/mm/readahead.c
index 6ae5693de28c..e48e78641772 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -581,7 +581,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
 void page_cache_async_ra(struct readahead_control *ractl,
-		struct page *page, unsigned long req_count)
+		struct folio *folio, unsigned long req_count)
 {
 	/* no read-ahead */
 	if (!ractl->ra->ra_pages)
@@ -590,10 +590,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-	if (PageWriteback(page))
+	if (folio_test_writeback(folio))
 		return;
 
-	ClearPageReadahead(page);
+	folio_clear_readahead(folio);
 
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
-- 
2.33.0

