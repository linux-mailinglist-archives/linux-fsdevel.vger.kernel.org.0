Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5927E515213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379643AbiD2RbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379619AbiD2R3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E298A6E21
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UyiQtrOlJApVo8TqEZs/5bvdj5z9rp2u4At+a4oNQzQ=; b=VhaC8U35yC590pCxrbYl4QtkdD
        JmFfOkLuvJfWw8yE4w4JgDeD3Ty3vMgvIKbr7JohmcovdNEM+dVNAqmaUy5loFO0V6Ky6T6T3GreA
        rWF1TeASBH8mzVpr2TtL2mkM5jeeFLQwdw4/US2hxLy/3KEpESGClFL/dS/f4OCt3lEHyjmfOB4FF
        ME90fu9KcdKK7rn4e/g36y9fR1SqdSp/XSILaAnJIKoWFTTKiABCjg/PzEh4sLaRNsVmJu3gt1GKC
        dLL8NoFY/5OCfHRbiOH4fs0r8JbSIzTG3KKT42wwktQjVRLAYaafdL5SFLZ24e5ic2jmcHdPfbC3z
        moQ+FIgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNe-00Cdd4-DI; Fri, 29 Apr 2022 17:26:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 61/69] ocfs2: Convert ocfs2 to read_folio
Date:   Fri, 29 Apr 2022 18:25:48 +0100
Message-Id: <20220429172556.3011843-62-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

