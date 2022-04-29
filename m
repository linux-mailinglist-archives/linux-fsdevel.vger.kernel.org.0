Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6485151FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358155AbiD2RaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379595AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D3A622F
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KQBtz+ZwwMq1JJtGAGPM1Be9nShDRCLK9wXs7Y5ncl4=; b=V+6HbnkTPoAsUbRw3EetQwre33
        4yOkXR6vJE6zfmXZrrL/zzg8JoE4mPSTtFJvDohXoyMhgeso5dQtNv3DxAQJyScV36IGe5o1fbhx7
        Fl4CS2oTGNZ4DCrhYmcsQbMIxwlCFVQ2WxcY+CA4vT/xpNP+RPuMF6Sc+D3yuEX3mh+19PnJKDpw8
        ZZIh3ftH5lJ0E8zWcrOHosKAW+bNrFg0szRypWL5re2FFxDXVynk6tQ6rvplxq/gfKIrsngCtckqx
        dEdXLTK8sozCIXodofUJjGVKDlNu4t0Vgt/KCzPaPaHwztIRIWLqVER8O+Qd+fI58PvXouyP/eD3Y
        zppxJLyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZR-NI; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 29/69] readahead: Use a folio in read_pages()
Date:   Fri, 29 Apr 2022 18:25:16 +0100
Message-Id: <20220429172556.3011843-30-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

Handle multi-page folios correctly and removes a few calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8e3775829513..947a7a1fd867 100644
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

