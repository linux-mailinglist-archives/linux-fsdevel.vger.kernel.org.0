Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB23A5CC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFNGRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhFNGR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:17:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8CC061766;
        Sun, 13 Jun 2021 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ioG7zo7n6vwCtzJ3+HXSWiKfz9FQY0HofqJa7ofFNZ8=; b=q9rAWckPz5pesEyoLsh+TMvTfc
        SHFKKeoJOtxD34SjTi3LdTfdHJtjZPCW6CGnOrh6kjyMx8oIrzx8sXkXte2LEXSo8i2qxzMZG//03
        NNP3OZixgBOGJJijAuUkkJcwcY6DM7vNXBp3kdgATWgHxH5bHXZZc9Zc4JnhqlarqzD1yvM/9U+42
        o4fmKBnbwhevPw22//VfbjBzgviG9jtATS6EuwXHC8g32SR13IZeoHVbHOjxI4Sqv1cdZGJsr0lhc
        51b11qdD6sTJw/ov9N6BOiU429mSSC0LUfckwXFwdzcmvSb60xZqqRsLypa3MNfaqiapOCwrqZxDP
        se8LKcZw==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfsV-00Ch5W-KW; Mon, 14 Jun 2021 06:15:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fs: move ramfs_aops to libfs
Date:   Mon, 14 Jun 2021 08:15:11 +0200
Message-Id: <20210614061512.3966143-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614061512.3966143-1-hch@lst.de>
References: <20210614061512.3966143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the ramfs aops to libfs and reuse them for kernfs and configfs.
Thosw two did not wire up ->set_page_dirty before and now get
__set_page_dirty_no_writeback, which is the right one for no-writeback
address_space usage.

Drop the now unused exports of the libfs helpers only used for
ramfs-style pagecache usage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/configfs/inode.c |  8 +-------
 fs/kernfs/inode.c   |  8 +-------
 fs/libfs.c          | 17 +++++++++++++----
 fs/ramfs/inode.c    |  9 +--------
 include/linux/fs.h  |  5 +----
 5 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index eb5ec3e46283..b601610e9907 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -28,12 +28,6 @@
 static struct lock_class_key default_group_class[MAX_LOCK_DEPTH];
 #endif
 
-static const struct address_space_operations configfs_aops = {
-	.readpage	= simple_readpage,
-	.write_begin	= simple_write_begin,
-	.write_end	= simple_write_end,
-};
-
 static const struct inode_operations configfs_inode_operations ={
 	.setattr	= configfs_setattr,
 };
@@ -114,7 +108,7 @@ struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
 	struct inode * inode = new_inode(s);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_mapping->a_ops = &configfs_aops;
+		inode->i_mapping->a_ops = &ram_aops;
 		inode->i_op = &configfs_inode_operations;
 
 		if (sd->s_iattr) {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index d73950fc3d57..26f2aa3586f9 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -17,12 +17,6 @@
 
 #include "kernfs-internal.h"
 
-static const struct address_space_operations kernfs_aops = {
-	.readpage	= simple_readpage,
-	.write_begin	= simple_write_begin,
-	.write_end	= simple_write_end,
-};
-
 static const struct inode_operations kernfs_iops = {
 	.permission	= kernfs_iop_permission,
 	.setattr	= kernfs_iop_setattr,
@@ -203,7 +197,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	kernfs_get(kn);
 	inode->i_private = kn;
-	inode->i_mapping->a_ops = &kernfs_aops;
+	inode->i_mapping->a_ops = &ram_aops;
 	inode->i_op = &kernfs_iops;
 	inode->i_generation = kernfs_gen(kn);
 
diff --git a/fs/libfs.c b/fs/libfs.c
index e9b29c6ffccb..2d7f086b93d6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -512,7 +512,7 @@ int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL(simple_setattr);
 
-int simple_readpage(struct file *file, struct page *page)
+static int simple_readpage(struct file *file, struct page *page)
 {
 	clear_highpage(page);
 	flush_dcache_page(page);
@@ -520,7 +520,6 @@ int simple_readpage(struct file *file, struct page *page)
 	unlock_page(page);
 	return 0;
 }
-EXPORT_SYMBOL(simple_readpage);
 
 int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
@@ -568,7 +567,7 @@ EXPORT_SYMBOL(simple_write_begin);
  *
  * Use *ONLY* with simple_readpage()
  */
-int simple_write_end(struct file *file, struct address_space *mapping,
+static int simple_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
@@ -597,7 +596,17 @@ int simple_write_end(struct file *file, struct address_space *mapping,
 
 	return copied;
 }
-EXPORT_SYMBOL(simple_write_end);
+
+/*
+ * Provides ramfs-style behavior: data in the pagecache, but no writeback.
+ */
+const struct address_space_operations ram_aops = {
+	.readpage	= simple_readpage,
+	.write_begin	= simple_write_begin,
+	.write_end	= simple_write_end,
+	.set_page_dirty	= __set_page_dirty_no_writeback,
+};
+EXPORT_SYMBOL(ram_aops);
 
 /*
  * the inodes created here are not hashed. If you use iunique to generate
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 9ebd17d7befb..65e7e56005b8 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -53,13 +53,6 @@ struct ramfs_fs_info {
 static const struct super_operations ramfs_ops;
 static const struct inode_operations ramfs_dir_inode_operations;
 
-static const struct address_space_operations ramfs_aops = {
-	.readpage	= simple_readpage,
-	.write_begin	= simple_write_begin,
-	.write_end	= simple_write_end,
-	.set_page_dirty	= __set_page_dirty_no_writeback,
-};
-
 struct inode *ramfs_get_inode(struct super_block *sb,
 				const struct inode *dir, umode_t mode, dev_t dev)
 {
@@ -68,7 +61,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode_init_owner(&init_user_ns, inode, dir, mode);
-		inode->i_mapping->a_ops = &ramfs_aops;
+		inode->i_mapping->a_ops = &ram_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..869909345420 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3422,13 +3422,10 @@ extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
-extern int simple_readpage(struct file *file, struct page *page);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
-extern int simple_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata);
+extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 extern int simple_nosetlease(struct file *, long, struct file_lock **, void **);
-- 
2.30.2

