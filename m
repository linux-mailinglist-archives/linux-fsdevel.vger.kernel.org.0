Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC2516A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383401AbiEBGAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383370AbiEBF7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968771FCE8
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/wowFiMAsOcZWiLS6mVJs4OWM4I5AIYIiO/PNCaiBG8=; b=odJGYq7K70eMrGyY+GynSiPmWK
        aWg7Oc0gFHQbty59j0OoGiy3ZXw6rD7TNJ9liB82nyl9zN5rQ/PXuwXU1pUcNSaBwB0ddTJfCd75I
        XwSwDX7sc4+0JL4goGYmrf8uQDwLzrbsv7RyslhOTTtutjAoXyeorUi4T2c8qLFBIzNtpQ3lLfkG4
        3YW/LlFOKQhHBocR+F4f8HiQ7SOPH2FFLcKGqRsxhk5MzAvnZUnfjAMxo6YoL//TIIU/z7w8THxwM
        kl3VvxaoqUc2BWQH7MJmpHYSxl+v9pimn0Uqajxid0AON8x/RxneiD89ynxQP744WC0Ho99NW2PWQ
        qCDeQdMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2f-00EZW0-RK; Mon, 02 May 2022 05:56:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/26] erofs: Convert to release_folio
Date:   Mon,  2 May 2022 06:55:56 +0100
Message-Id: <20220502055614.3473032-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

