Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F774AFE30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiBIUW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C6E040CB5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qSCeS2lIoeDq5JpMv4LFyTOHXDeIVNnQIvhYmIS/IpI=; b=QmctZllRFg43+YjpGrkFrzUMTr
        36Z8oIP36rD6gCxkU3cOs1yWC5TOQzSG/kGt58da+iWze5cggUQXjTrcHM9NNjnr33IcySWrxcxHA
        aDV6BitOgJ5EbD5KC3QMvOMGATLHnMEjty+m5rs9Cx5+x908NVVe3nPifcy4ckioJYHi2SYe/hreX
        YK8wTeOvj3t6vOpWCLhTM43bG+3RwjIREdiBO66whyQnlFT/aaVNCMjb+ntBJiudz548PW6J27gvd
        3iGGStWxPgNG1Zpu7QMtwMDZX4I5Nz5OEQgyApsuOXsHnlNvH5dI2voEjWhpbJdJYuUwxFHJiqqCU
        VlxXM93g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cr7-W6; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 27/56] jfs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:46 +0000
Message-Id: <20220209202215.2055748-28-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

This is a straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 104ae698443e..d856aee3eec3 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -555,21 +555,21 @@ static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
-static void metapage_invalidatepage(struct page *page, unsigned int offset,
-				    unsigned int length)
+static void metapage_invalidate_folio(struct folio *folio, size_t offset,
+				    size_t length)
 {
-	BUG_ON(offset || length < PAGE_SIZE);
+	BUG_ON(offset || length < folio_size(folio));
 
-	BUG_ON(PageWriteback(page));
+	BUG_ON(folio_test_writeback(folio));
 
-	metapage_releasepage(page, 0);
+	metapage_releasepage(&folio->page, 0);
 }
 
 const struct address_space_operations jfs_metapage_aops = {
 	.readpage	= metapage_readpage,
 	.writepage	= metapage_writepage,
 	.releasepage	= metapage_releasepage,
-	.invalidatepage	= metapage_invalidatepage,
+	.invalidate_folio = metapage_invalidate_folio,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 };
 
-- 
2.34.1

