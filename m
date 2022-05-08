Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1051F178
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiEHUhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiEHUgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FC11C13
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LlxdlBMdkVhJs6JSYU0fD3emEVif/dc5eg6H/kUabyk=; b=Fys2xSX7mislUAwT3I0F062Bmd
        feh4uQcO2zc/oexkEzUT607QLAefr0foiVrPcJn36Z57sbwvMH1P2hwnW2TfB8Xcs+a9Dve1+Tpoy
        HCTgoytdB/xLE0B8HTFP+daeivDoxzGJ1ouQqNZ0yLihUJHNoB2/C9G6cOl1hzKd+Cc2Wd+HQ9469
        5NW+v7GERRwhPVmqhL7NEVzEfuENgCKnHYsKG767CUwITqzUc1uvLTbCjiWmXc04htGgNUuNwlu+z
        OgOA6T/JQJ5AWy/9gzF7thHVXO8eFOYyGbKFnnkxTT4Iv8WG/RQY+qRgIYQ+mrG5Y8z6somWgt3JX
        KQO6tL2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o0w-5G; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/26] 9p: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:24 +0100
Message-Id: <20220508203247.668791-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

A straightforward conversion as it already works in terms of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 3a84167f4893..8ce82ff1e40a 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -100,29 +100,28 @@ const struct netfs_request_ops v9fs_req_ops = {
 };
 
 /**
- * v9fs_release_page - release the private state associated with a page
- * @page: The page to be released
+ * v9fs_release_folio - release the private state associated with a folio
+ * @folio: The folio to be released
  * @gfp: The caller's allocation restrictions
  *
- * Returns 1 if the page can be released, false otherwise.
+ * Returns true if the page can be released, false otherwise.
  */
 
-static int v9fs_release_page(struct page *page, gfp_t gfp)
+static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio_inode(folio);
 
 	if (folio_test_private(folio))
-		return 0;
+		return false;
 #ifdef CONFIG_9P_FSCACHE
 	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return 0;
+			return false;
 		folio_wait_fscache(folio);
 	}
 #endif
 	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(inode)));
-	return 1;
+	return true;
 }
 
 static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
@@ -342,7 +341,7 @@ const struct address_space_operations v9fs_addr_operations = {
 	.writepage = v9fs_vfs_writepage,
 	.write_begin = v9fs_write_begin,
 	.write_end = v9fs_write_end,
-	.releasepage = v9fs_release_page,
+	.release_folio = v9fs_release_folio,
 	.invalidate_folio = v9fs_invalidate_folio,
 	.launder_folio = v9fs_launder_folio,
 	.direct_IO = v9fs_direct_IO,
-- 
2.34.1

