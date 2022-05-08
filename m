Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA66B51F172
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiEHUgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D335F99
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UyiQtrOlJApVo8TqEZs/5bvdj5z9rp2u4At+a4oNQzQ=; b=iGs8pzm595+I1LBGc3HHvBDiWS
        J0CH90YROjovasnMY7LOW3ta+D3MC2wP4UCuPLQWK/v0Xe0EyS6tEuHcvyf/2zk40/Tcm25VA3erb
        smVbSeHaulGJ+rSPVA2h3am7dvB/rtB0hBhEaVmFHQBmKKFbxWyLGs6plbJwJbL+8GGltcTCsJLhZ
        KoNxMCkwWeMflEM+oZYncK32s7/ukL15u5tTdsXFYnwuQlEdWqY0OrA24dighfvmPnrdR1SqD3wfu
        wKmJhw+F03gqhz+XjcvNNCpM9ErvRnZ89RfiTj2SaUC7qkOl2XgKggsAsNPkso0irfTd97ucjUN1S
        AeSGvPkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ6-002npU-JJ; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 29/37] ocfs2: Convert ocfs2 to read_folio
Date:   Sun,  8 May 2022 21:31:23 +0100
Message-Id: <20220508203131.667959-30-willy@infradead.org>
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
 fs/ocfs2/alloc.c   | 2 +-
 fs/ocfs2/aops.c    | 5 +++--
 fs/ocfs2/file.c    | 2 +-
 fs/ocfs2/symlink.c | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 49f41074baad..51c93929a146 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7427,7 +7427,7 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	/*
 	 * No need to worry about the data page here - it's been
 	 * truncated already and inline data doesn't need it for
-	 * pushing zero's to disk, so we'll let readpage pick it up
+	 * pushing zero's to disk, so we'll let read_folio pick it up
 	 * later.
 	 */
 	if (trunc) {
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 7bf4b6fd93bf..6b1679db9636 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -275,8 +275,9 @@ static int ocfs2_readpage_inline(struct inode *inode, struct page *page)
 	return ret;
 }
 
-static int ocfs2_readpage(struct file *file, struct page *page)
+static int ocfs2_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	loff_t start = (loff_t)page->index << PAGE_SHIFT;
@@ -2454,7 +2455,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations ocfs2_aops = {
 	.dirty_folio		= block_dirty_folio,
-	.readpage		= ocfs2_readpage,
+	.read_folio		= ocfs2_read_folio,
 	.readahead		= ocfs2_readahead,
 	.writepage		= ocfs2_writepage,
 	.write_begin		= ocfs2_write_begin,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 01b7407a8893..7497cd592258 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2526,7 +2526,7 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 		return -EOPNOTSUPP;
 
 	/*
-	 * buffered reads protect themselves in ->readpage().  O_DIRECT reads
+	 * buffered reads protect themselves in ->read_folio().  O_DIRECT reads
 	 * need locks to protect pending reads from racing with truncate.
 	 */
 	if (direct_io) {
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index f755a4985821..d4c5fdcfa1e4 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -52,8 +52,9 @@
 #include "buffer_head_io.h"
 
 
-static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
+static int ocfs2_fast_symlink_read_folio(struct file *f, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
 	int status = ocfs2_read_inode_block(inode, &bh);
@@ -81,7 +82,7 @@ static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
 }
 
 const struct address_space_operations ocfs2_fast_symlink_aops = {
-	.readpage		= ocfs2_fast_symlink_readpage,
+	.read_folio		= ocfs2_fast_symlink_read_folio,
 };
 
 const struct inode_operations ocfs2_symlink_inode_operations = {
-- 
2.34.1

