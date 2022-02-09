Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B204AFE32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiBIUWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiBIUWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C0E01CC92
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mozTpindfCwRfzIRCAndtSbsLRj46wc20oUOae0BEoE=; b=Tf08/jp404wub7CV7jgIt+arvF
        P2E+ZMccN7IgXtT6F7QKw945JwpWmPFWNcvGGlU+1xU4fIlxwgKwpfn7yfUa/2E265NW8Dc1ugrqn
        yuSnWgFofa60KAei/8LpwjMUTA9MmfQFHL7bhVOSK4aoQ8X5dGjquIo7xApVIgmc3ZvMkJMrEG7TL
        uqh316ALV0QfgJokvHXSqjrGIAo9g4qTL0CGahPZfdznqLQFzjHnhzuFqE7HXW5dxuowqlwnAYFp4
        mtx9cXc15zq9p+G9G5X0Xa+DtNCr13C3ftRl2dDkaZWavD4bY6489JqsyS8WYEauu9Wkd/hxY+1cC
        SALuvv4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cq8-LE; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/56] fs: Remove noop_invalidatepage()
Date:   Wed,  9 Feb 2022 20:21:35 +0000
Message-Id: <20220209202215.2055748-17-willy@infradead.org>
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

We used to have to use noop_invalidatepage() to prevent
block_invalidatepage() from being called, but that behaviour is now gone.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/dax/device.c |  1 -
 fs/ext2/inode.c      |  1 -
 fs/ext4/inode.c      |  1 -
 fs/fuse/dax.c        |  1 -
 fs/libfs.c           | 11 -----------
 fs/xfs/xfs_aops.c    |  1 -
 include/linux/fs.h   |  2 --
 7 files changed, 18 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index d33a0613ed0c..7a59ca51217e 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -347,7 +347,6 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 
 static const struct address_space_operations dev_dax_aops = {
 	.set_page_dirty		= __set_page_dirty_no_writeback,
-	.invalidatepage		= noop_invalidatepage,
 };
 
 static int dax_open(struct inode *inode, struct file *filp)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 1e14777c3ca6..9b579ee56eaf 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1001,7 +1001,6 @@ static const struct address_space_operations ext2_dax_aops = {
 	.writepages		= ext2_dax_writepages,
 	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
-	.invalidatepage		= noop_invalidatepage,
 };
 
 /*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 07ef3f84db9e..d7086209572a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3632,7 +3632,6 @@ static const struct address_space_operations ext4_dax_aops = {
 	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.bmap			= ext4_bmap,
-	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 182b24a14804..b11fa10b88d8 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1327,7 +1327,6 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 	.writepages	= fuse_dax_writepages,
 	.direct_IO	= noop_direct_IO,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
-	.invalidatepage	= noop_invalidatepage,
 };
 
 static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
diff --git a/fs/libfs.c b/fs/libfs.c
index 974125270a42..4e047841e61d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1198,17 +1198,6 @@ int noop_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 EXPORT_SYMBOL(noop_fsync);
 
-void noop_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int length)
-{
-	/*
-	 * There is no page cache to invalidate in the dax case, however
-	 * we need this callback defined to prevent falling back to
-	 * block_invalidatepage() in do_invalidatepage().
-	 */
-}
-EXPORT_SYMBOL_GPL(noop_invalidatepage);
-
 ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	/*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 51a040b658cb..7dd314f2288f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -582,6 +582,5 @@ const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
 	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
-	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= xfs_iomap_swapfile_activate,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bcdb613cd652..a40ea82248da 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3323,8 +3323,6 @@ extern int simple_rename(struct user_namespace *, struct inode *,
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
-extern void noop_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
-- 
2.34.1

