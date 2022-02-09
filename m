Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35D4AFE65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiBIUXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66EBE040C93
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t1J/tdp9tI2gKLFBoJBhzbxtUufDfh0XO+BHr5PmDxg=; b=WdGtqSWijEs+sO/JVYCwOKgCg4
        nJOSUL9y8EsMjC6CdR5fU6Y+NfXIRraJJ1WvK1zYmi5jHSQYyJdG8aXeTNyBXAFshr96VUwXFcLQd
        Y1nMiBwL+iNpU/DFlllJQ6NCwXX23Bemou0TkjiGQvU/xt954WCp4bsYNCKucs/wSdArcx0gtW76p
        OKKh7cTEkUwo7OSbxPQc39K6n7d17vxGxCsEvqLYwd1i2LF1+RIwWJ4a7ra9tK9wg/nV0CnrnNDWi
        2qQjUhGazdwHQWsjJqskUn9xI+oT0v/zFx+2kGFkSLU+UUGv/30SOYhRSrGuHUnL5c4sxe1vO1w4D
        khXdjetw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008ctS-17; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 50/56] ubifs: Convert ubifs_set_page_dirty to ubifs_dirty_folio
Date:   Wed,  9 Feb 2022 20:22:09 +0000
Message-Id: <20220209202215.2055748-51-willy@infradead.org>
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

Removes a call to __set_page_dirty_nobuffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 52c6c67b9784..8a9ffc2d4167 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1445,18 +1445,18 @@ static ssize_t ubifs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return generic_file_write_iter(iocb, from);
 }
 
-static int ubifs_set_page_dirty(struct page *page)
+static bool ubifs_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	int ret;
-	struct inode *inode = page->mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	bool ret;
+	struct ubifs_info *c = mapping->host->i_sb->s_fs_info;
 
-	ret = __set_page_dirty_nobuffers(page);
+	ret = filemap_dirty_folio(mapping, folio);
 	/*
 	 * An attempt to dirty a page without budgeting for it - should not
 	 * happen.
 	 */
-	ubifs_assert(c, ret == 0);
+	ubifs_assert(c, ret == false);
 	return ret;
 }
 
@@ -1647,7 +1647,7 @@ const struct address_space_operations ubifs_file_address_operations = {
 	.write_begin    = ubifs_write_begin,
 	.write_end      = ubifs_write_end,
 	.invalidate_folio = ubifs_invalidate_folio,
-	.set_page_dirty = ubifs_set_page_dirty,
+	.dirty_folio	= ubifs_dirty_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= ubifs_migrate_page,
 #endif
-- 
2.34.1

