Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EE51F14B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiEHUfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiEHUfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF221BD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BJj177M1qr0mdk+V5h83h2yX7XDhGHky1f+ZyB2GnAE=; b=iHE+Iu10G2MAVqNTphLUe3l36K
        3+miC5clHUVcULzy8VFtr6dZe51Mh4RK2i1ClwpiZBakhsW8GH9wgisjrIQA2H6gEuvSxc6mHFNVo
        vaq0mK8wghPFXSc2btQDqGjER5QhGbD38lbfRuHSu1yMAcz4Z3BcoYspns2iNZE+pwuQUdj+bGexz
        UggAOUN/65tNUCgQStebpOUe6pS6FrgOHy9JeCvR4lhaotL6zLOUZSASPdqa+7G+949+0U9NeDFIP
        MZD3Ve5UIABz6LGtnFbXpq9zgz3d73kUwJCZSYA64BQA++FuxsqfmK1tJR1Cyr1GHEKJ4Wx+jQSG1
        7WuY579Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ3-002nnY-Qm; Sun, 08 May 2022 20:31:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/37] affs: Convert affs to read_folio
Date:   Sun,  8 May 2022 21:31:02 +0100
Message-Id: <20220508203131.667959-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/affs/file.c    | 5 +++--
 fs/affs/symlink.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 5da562cc7fb7..cd00a4c68a12 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -629,8 +629,9 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 }
 
 static int
-affs_readpage_ofs(struct file *file, struct page *page)
+affs_read_folio_ofs(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	u32 to;
 	int err;
@@ -837,7 +838,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 const struct address_space_operations affs_aops_ofs = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = affs_readpage_ofs,
+	.read_folio = affs_read_folio_ofs,
 	//.writepage = affs_writepage_ofs,
 	.write_begin = affs_write_begin_ofs,
 	.write_end = affs_write_end_ofs
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index a7531b26e8f0..31d6446dc166 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -11,8 +11,9 @@
 
 #include "affs.h"
 
-static int affs_symlink_readpage(struct file *file, struct page *page)
+static int affs_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct buffer_head *bh;
 	struct inode *inode = page->mapping->host;
 	char *link = page_address(page);
@@ -67,7 +68,7 @@ static int affs_symlink_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations affs_symlink_aops = {
-	.readpage	= affs_symlink_readpage,
+	.read_folio	= affs_symlink_read_folio,
 };
 
 const struct inode_operations affs_symlink_inode_operations = {
-- 
2.34.1

