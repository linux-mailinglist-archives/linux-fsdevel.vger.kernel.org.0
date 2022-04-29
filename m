Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49065515209
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379711AbiD2Rau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379519AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14DA6E23
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5hLucSIlWDT7gvjGd1USQbBcvVhzGdatd4MGsucOT5s=; b=F37OYXJBaaL1kbIepcSiiBWZsh
        QXoTxghyd7mgtoKYEyjNYn7QRQojmz5KeyFkhyrfskbqlkuFKe0IkYMvdGEEkBmsn/amiWklkOZWk
        NH7njvlSTtj4pPRaCqzqIC/ae8wlmr/p8ojmn7iEpadPmR1NllUKzyckYkyd0cnzWV/EMgwMMKFUJ
        MGRTCwG4EFOcqgQVlDOe/yfykp9eefE3MM5ds8mbpSqn0ufwXstzqCqFWYgQOx0juGwlog37AW0SD
        MKgvchLAVj7vHpN4TA0yjBcZkxdbj5IOLMOa8eQW5AEO7z5TZVMTvLYk8LMaxN4w4If+ak+MMKE/Z
        MLlvgxtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNe-00CddT-P1; Fri, 29 Apr 2022 17:26:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 64/69] squashfs: Convert squashfs to read_folio
Date:   Fri, 29 Apr 2022 18:25:51 +0100
Message-Id: <20220429172556.3011843-65-willy@infradead.org>
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
 fs/squashfs/file.c    | 5 +++--
 fs/squashfs/super.c   | 2 +-
 fs/squashfs/symlink.c | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 89d492916dea..a8e495d8eb86 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -444,8 +444,9 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
 	return 0;
 }
 
-static int squashfs_readpage(struct file *file, struct page *page)
+static int squashfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
@@ -496,5 +497,5 @@ static int squashfs_readpage(struct file *file, struct page *page)
 
 
 const struct address_space_operations squashfs_aops = {
-	.readpage = squashfs_readpage
+	.read_folio = squashfs_read_folio
 };
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 4f74abbc1a54..6d594ba2ed28 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -148,7 +148,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/*
 	 * squashfs provides 'backing_dev_info' in order to disable read-ahead. For
-	 * squashfs, I/O is not deferred, it is done immediately in readpage,
+	 * squashfs, I/O is not deferred, it is done immediately in read_folio,
 	 * which means the user would always have to wait their own I/O. So the effect
 	 * of readahead is very weak for squashfs. squashfs_bdi_init will set
 	 * sb->s_bdi->ra_pages and sb->s_bdi->io_pages to 0 and close readahead for
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 1430613183e6..2bf977a52c2c 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -30,8 +30,9 @@
 #include "squashfs.h"
 #include "xattr.h"
 
-static int squashfs_symlink_readpage(struct file *file, struct page *page)
+static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
@@ -101,7 +102,7 @@ static int squashfs_symlink_readpage(struct file *file, struct page *page)
 
 
 const struct address_space_operations squashfs_symlink_aops = {
-	.readpage = squashfs_symlink_readpage
+	.read_folio = squashfs_symlink_read_folio
 };
 
 const struct inode_operations squashfs_symlink_inode_ops = {
-- 
2.34.1

