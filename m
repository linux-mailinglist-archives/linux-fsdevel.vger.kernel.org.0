Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8884B5B87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiBNUzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:55:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBNUza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:55:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD08AE66
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rLkp+NVco19SWWCWG6ARM6GyjcMhE2nofxKuhunYvDE=; b=TSySHaxSmHclYNTQQpXJR/Z55u
        P4BXbH/qp3OgHkvU7CT47LGPeraYuezmJp/Wo/kIpij91nZpnHSOWb8e/tBuWdtTFtPCyHv4T6KBL
        1VxNiTXAUA23N2ppqCeWF+BvEEJU5Za9l9TXdKWOTS/42DhYOrLGujgUmSF3VnVjjDxPY+JzvsnzE
        UUJaZgP11K3AoADu7xYJlbBUVfY4Zfi0tVxAGcUo9DCdKVvK7l5yyI623m18weM4EkpnMZqFpEgR8
        4EnEzioxIp1iC1wZkX0W8PGe5iWBvk5Wci21Ih46xxYFPohHi/sLI1ijgowOvz1rejsB5kFBX/hmA
        ibxx+q6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWF-00DDdW-HO; Mon, 14 Feb 2022 20:00:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page() into its one caller
Date:   Mon, 14 Feb 2022 20:00:09 +0000
Message-Id: <20220214200017.3150590-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
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

invalidate_inode_page() is the only caller of invalidate_complete_page()
and inlining it reveals that the first check is unnecessary (because we
hold the page locked, and we just retrieved the mapping from the page).
Actually, it does make a difference, in that tail pages no longer fail
at this check, so it's now possible to remove a tail page from a mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 9dbf0b75da5d..e5e2edaa0b76 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -193,27 +193,6 @@ static void truncate_cleanup_folio(struct folio *folio)
 	folio_clear_mappedtodisk(folio);
 }
 
-/*
- * This is for invalidate_mapping_pages().  That function can be called at
- * any time, and is not supposed to throw away dirty pages.  But pages can
- * be marked dirty at any time too, so use remove_mapping which safely
- * discards clean, unused pages.
- *
- * Returns non-zero if the page was successfully invalidated.
- */
-static int
-invalidate_complete_page(struct address_space *mapping, struct page *page)
-{
-
-	if (page->mapping != mapping)
-		return 0;
-
-	if (page_has_private(page) && !try_to_release_page(page, 0))
-		return 0;
-
-	return remove_mapping(mapping, page);
-}
-
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 {
 	if (folio->mapping != mapping)
@@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
 		return 0;
 	if (page_mapped(page))
 		return 0;
-	return invalidate_complete_page(mapping, page);
+	if (page_has_private(page) && !try_to_release_page(page, 0))
+		return 0;
+
+	return remove_mapping(mapping, page);
 }
 
 /**
@@ -584,7 +566,7 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
 }
 
 /*
- * This is like invalidate_complete_page(), except it ignores the page's
+ * This is like invalidate_inode_page(), except it ignores the page's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave pages behind because
  * shrink_page_list() has a temp ref on them, or because they're transiently
-- 
2.34.1

