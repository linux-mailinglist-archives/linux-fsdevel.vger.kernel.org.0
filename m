Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D4741884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjF1TAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjF1S7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:59:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27AC2102;
        Wed, 28 Jun 2023 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6P08QVXXRrbXoyateQxxQCk4bh+paRKekLCZ82zEgH8=; b=url2F0fZ01ji+ds4Rem0FLeG/t
        3dBgDzfYIW7OTTtfNLTt4rIH8crndyry4OHdQvZbyIyMr7Ajb+Ot4P1UNdIXGYTPc2hf3qzLWaJFe
        pspy9msXJ+wykOy3fBGL5CoAAPKY3IE7oB9mUn9o3bCcgNirkUg9veocsCNB8mPWiIf95QyUPcM2U
        QxocqigmcFUM2BtK2mRWdF665uuL0dFsM3gIdK08lFx8RbxxTfbCJeh3vnoMChqvx3PkZ+mKXLbEM
        Cg/NaR6/AbFocoTrKu1dv6QzWIfOmOAMf7EZ66V4Xww7T4aQdeNDAnbEs2Fbx5ZHJOwqsGouzITT0
        zNLlPUsw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEaKT-0047Ys-Ue; Wed, 28 Jun 2023 18:55:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] writeback: Account the number of pages written back
Date:   Wed, 28 Jun 2023 19:55:48 +0100
Message-Id: <20230628185548.981888-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nr_to_write is a count of pages, so we need to decrease it by the number
of pages in the folio we just wrote, not by 1.  Most callers specify
either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
might end up writing 512x as many pages as it asked for.

Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1d17fb1ec863..d3f42009bb70 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,6 +2434,7 @@ int write_cache_pages(struct address_space *mapping,
 
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
+			unsigned long nr;
 
 			done_index = folio->index;
 
@@ -2471,6 +2472,7 @@ int write_cache_pages(struct address_space *mapping,
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 			error = writepage(folio, wbc, data);
+			nr = folio_nr_pages(folio);
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2489,8 +2491,7 @@ int write_cache_pages(struct address_space *mapping,
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
 					ret = error;
-					done_index = folio->index +
-						folio_nr_pages(folio);
+					done_index = folio->index + nr;
 					done = 1;
 					break;
 				}
@@ -2504,7 +2505,8 @@ int write_cache_pages(struct address_space *mapping,
 			 * keep going until we have written all the pages
 			 * we tagged for writeback prior to entering this loop.
 			 */
-			if (--wbc->nr_to_write <= 0 &&
+			wbc->nr_to_write -= nr;
+			if (wbc->nr_to_write <= 0 &&
 			    wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
 				break;
-- 
2.39.2

