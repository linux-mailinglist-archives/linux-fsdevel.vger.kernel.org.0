Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24B5364F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353668AbiE0PvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352485AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A29134E35
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8Xen5gC1HhkspCEo+ZyScnM78AzlIPquQEw05FXhHuQ=; b=pr2MHsNtJ4o0Up/SM7gZj552Qv
        MBlnsEH1oadbJ1tbDIue/HxbW1HHv8JdfkD4Uc8hmg4N53qWtF5nr6X3EAuYAWUCJqRm7XBsnje1o
        peatyEetm9/zjQ01/TSaHvAlWkRNfh5RC7eo1AN/U6Lp17Kjv5UkRur80bK1klQlB+URXYGi/L+R+
        MEhYRygopP0fZLDL/UjRf3ROTu2Tropvugs4i3wgMOm9t/AZZhHDoE2cAqLRPdQSvczr5q36lNJ2F
        PDK2sx7jK5Xbi2IOi/NKhFQ9hd2YK1uWIZgiw4/gIV4OaIMVuN7Gw0CjTlbgIn8C1VuvwgetDAeLC
        MgQk7TUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEc-002CXj-4F; Fri, 27 May 2022 15:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 21/24] buffer: Don't test folio error in block_read_full_folio()
Date:   Fri, 27 May 2022 16:50:33 +0100
Message-Id: <20220527155036.524743-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

We can cache this information in a local variable instead of communicating
from one part of the function to another via folio flags.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c37a9c3bfb2f..5a4609b8b2b4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2259,6 +2259,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	unsigned int blocksize, bbits;
 	int nr, i;
 	int fully_mapped = 1;
+	bool page_error = false;
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
@@ -2283,8 +2284,10 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
-				if (err)
+				if (err) {
 					folio_set_error(folio);
+					page_error = true;
+				}
 			}
 			if (!buffer_mapped(bh)) {
 				folio_zero_range(folio, i * blocksize,
@@ -2311,7 +2314,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		 * All buffers are uptodate - we can set the folio uptodate
 		 * as well. But not if get_block() returned an error.
 		 */
-		if (!folio_test_error(folio))
+		if (!page_error)
 			folio_mark_uptodate(folio);
 		folio_unlock(folio);
 		return 0;
-- 
2.34.1

