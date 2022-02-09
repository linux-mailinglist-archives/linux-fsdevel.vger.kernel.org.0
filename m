Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60544AFE3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiBIUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiBIUW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A05DE03A55C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+aflmQ9Wqkqj+Pu6kmGcv7RdCy+Hh+xpHDDfgp3Wb6c=; b=rQ4B5JRBVgTx88zXzc1xesIEdE
        PFykTCtSniqE0J5PuI48vCBBdPGJAMK/S2RZJudlNRX5SMMli/N90XnzwC3LC561CXJbVlsWhhMo2
        OaeyvFZ37dJCJ7DRSJwrpV2H5OBLt/+x8LrgxxFGf5N/lIBN0u5/BJB9VUviTtggVtl3tCqdRo1qe
        tZ+1525rmtdqRtJdd53FPWprdYS69+vJ3jKDu1Rx9BeZpTRQO3BF/J9tX47rQgH4LiLelJySg0aVD
        XPefMw4xeWmLSqTxYYvQOHlMN946Z5T8mReLNeNpURmoNfPUmj2DmP6DeXLhRtfx4qDma/+5ggbGF
        SuZU7kmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008cra-Gl; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 31/56] ubifs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:50 +0000
Message-Id: <20220209202215.2055748-32-willy@infradead.org>
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

This is a straightfoward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5cfa28cd00cd..52c6c67b9784 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1287,25 +1287,25 @@ int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	return err;
 }
 
-static void ubifs_invalidatepage(struct page *page, unsigned int offset,
-				 unsigned int length)
+static void ubifs_invalidate_folio(struct folio *folio, size_t offset,
+				 size_t length)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
-	ubifs_assert(c, PagePrivate(page));
-	if (offset || length < PAGE_SIZE)
-		/* Partial page remains dirty */
+	ubifs_assert(c, folio_test_private(folio));
+	if (offset || length < folio_size(folio))
+		/* Partial folio remains dirty */
 		return;
 
-	if (PageChecked(page))
+	if (folio_test_checked(folio))
 		release_new_page_budget(c);
 	else
 		release_existing_page_budget(c);
 
 	atomic_long_dec(&c->dirty_pg_cnt);
-	ClearPagePrivate(page);
-	ClearPageChecked(page);
+	folio_clear_private(folio);
+	folio_clear_checked(folio);
 }
 
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
@@ -1646,7 +1646,7 @@ const struct address_space_operations ubifs_file_address_operations = {
 	.writepage      = ubifs_writepage,
 	.write_begin    = ubifs_write_begin,
 	.write_end      = ubifs_write_end,
-	.invalidatepage = ubifs_invalidatepage,
+	.invalidate_folio = ubifs_invalidate_folio,
 	.set_page_dirty = ubifs_set_page_dirty,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= ubifs_migrate_page,
-- 
2.34.1

