Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA80D51F191
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiEHUhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEHUgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDB11C38
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nnCtkQUhI2d87PCg3VDVjmcRpCb4pv9+uwtcssc5XN8=; b=C1yb1uIDSissfJcqxZxoKnUinr
        npAvoGaSWekf+xT+mllBQDmRXzNsxKnoBYvqknytKj8yXNsA6NoTAMz0xodVHRhZsqmim0m7a2PLw
        CnicsdZkHolHRACn4gWeDX12vsgSe/62sbgmmkbh1wh1zD9H7gRi4RHAi/pp+69PTXzgkI98vhii1
        gx11uEzvPBRbG9gYoZn91v+srHrTacMn1S8LZ2N1hquTKb9EKeA4UAvGLiLPa2N5tovkjDcsNnyq3
        E67Hhuau9+QaYL94hcwg20SLTDJbOggmM//amRPyjrLr4Uu3nefB2ZAjdrtLPuGyjgkl7Mu5JJS/M
        nNM7K/xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2b-Bp; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/26] ubifs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:41 +0100
Message-Id: <20220508203247.668791-21-willy@infradead.org>
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

Use folios throughout the release_folio path.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 7cbf2edf8907..04ced154960f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1484,22 +1484,22 @@ static int ubifs_migrate_page(struct address_space *mapping,
 }
 #endif
 
-static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
+static bool ubifs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
 	/*
 	 * An attempt to release a dirty page without budgeting for it - should
 	 * not happen.
 	 */
-	if (PageWriteback(page))
-		return 0;
-	ubifs_assert(c, PagePrivate(page));
+	if (folio_test_writeback(folio))
+		return false;
+	ubifs_assert(c, folio_test_private(folio));
 	ubifs_assert(c, 0);
-	detach_page_private(page);
-	ClearPageChecked(page);
-	return 1;
+	folio_detach_private(folio);
+	folio_clear_checked(folio);
+	return true;
 }
 
 /*
@@ -1652,7 +1652,7 @@ const struct address_space_operations ubifs_file_address_operations = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= ubifs_migrate_page,
 #endif
-	.releasepage    = ubifs_releasepage,
+	.release_folio    = ubifs_release_folio,
 };
 
 const struct inode_operations ubifs_file_inode_operations = {
-- 
2.34.1

