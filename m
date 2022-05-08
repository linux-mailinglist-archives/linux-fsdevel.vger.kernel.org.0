Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01DB51F189
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiEHUhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC111C1F
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/wowFiMAsOcZWiLS6mVJs4OWM4I5AIYIiO/PNCaiBG8=; b=dqBMjU9Mczlf+GUhaeYXkPJkcp
        VQeaKwg3r3pqWrUIcTtgOdV2wEyysCJCeSqjk4EiTMHQ4rBWPqzBxSMSRMy8Ls3RomvF9MDAIrsIi
        za4ztfauMVQfS9tFD/x2uJqxKacpQpTEUdwvYD6Is3cCJYBdOgmbC4D3cHOeK0/b0n5JFYwF6rIZD
        coEOfWlbF5EMf29ImD5mul1IY3eK36h7I6On89T3JZl/xYzf7maydRdrDPukU+KcHvU6tq+T6TstZ
        V6xElJxpfb1PliYQ/07qxaQz1mIq4pgyLlBepUW0OcbMFWtHYRTT/HxjgexifBWNpQ40bXNS7RNRo
        PXdSpWdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o1L-Pd; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/26] erofs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:29 +0100
Message-Id: <20220508203247.668791-9-willy@infradead.org>
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

Use a folio in erofs_managed_cache_release_folio(), but use of folios
should be pushed into erofs_try_to_free_cached_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/erofs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..0e3862a72bfe 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -518,16 +518,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 #ifdef CONFIG_EROFS_FS_ZIP
 static const struct address_space_operations managed_cache_aops;
 
-static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
+static bool erofs_managed_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
-	int ret = 1;	/* 0 - busy */
-	struct address_space *const mapping = page->mapping;
+	bool ret = true;
+	struct address_space *const mapping = folio->mapping;
 
-	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(!folio_test_locked(folio));
 	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
 
-	if (PagePrivate(page))
-		ret = erofs_try_to_free_cached_page(page);
+	if (folio_test_private(folio))
+		ret = erofs_try_to_free_cached_page(&folio->page);
 
 	return ret;
 }
@@ -548,12 +548,12 @@ static void erofs_managed_cache_invalidate_folio(struct folio *folio,
 	DBG_BUGON(stop > folio_size(folio) || stop < length);
 
 	if (offset == 0 && stop == folio_size(folio))
-		while (!erofs_managed_cache_releasepage(&folio->page, GFP_NOFS))
+		while (!erofs_managed_cache_release_folio(folio, GFP_NOFS))
 			cond_resched();
 }
 
 static const struct address_space_operations managed_cache_aops = {
-	.releasepage = erofs_managed_cache_releasepage,
+	.release_folio = erofs_managed_cache_release_folio,
 	.invalidate_folio = erofs_managed_cache_invalidate_folio,
 };
 
-- 
2.34.1

