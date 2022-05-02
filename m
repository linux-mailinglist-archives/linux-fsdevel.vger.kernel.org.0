Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788A516A88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383437AbiEBGAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383405AbiEBGA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC31FA45
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nnCtkQUhI2d87PCg3VDVjmcRpCb4pv9+uwtcssc5XN8=; b=CICndBDyqvWHYJt+ToWzsTNTic
        jli7gheqJpPzsV5tBuf+eOHRM3fq6NJlDqQeMPVI0XXPkc2fnTkwPZ52GBfwKaU8L0H5o6eMB0ZKx
        6HqBSEWVA0dxUuVxIXP1ojSHlj/zGexttf2gw8mNqw4XYejNeYNbWLRjvVLY65WwErfxCpfcuWq14
        fEC0ru2YA+8jPFwIFfyPYTtszuE6JERdwOCrHl9RKrNjMXJKs1eM88tRLsFBNgW7Tnrh2ir1Fhrpt
        KCDESMgON7qMmTL2o42nt2gbKQtlFtpgDPMmUBMqMEUwmYDpY8miiAkEYbzOB6a/YAyLykyHAyMbZ
        NM/E6M3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2h-00EZWz-HY; Mon, 02 May 2022 05:56:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/26] ubifs: Convert to release_folio
Date:   Mon,  2 May 2022 06:56:08 +0100
Message-Id: <20220502055614.3473032-21-willy@infradead.org>
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

