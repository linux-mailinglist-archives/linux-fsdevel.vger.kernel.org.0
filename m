Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E32D71CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfJOJIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 05:08:04 -0400
Received: from mx-out.tlen.pl ([193.222.135.142]:33571 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfJOJID (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:08:03 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 05:08:02 EDT
Received: (wp-smtpd smtp.tlen.pl 11047 invoked from network); 15 Oct 2019 11:01:22 +0200
Received: from unknown (HELO localhost.localdomain) (p.sarna@tlen.pl@[31.179.144.84])
          (envelope-sender <p.sarna@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 15 Oct 2019 11:01:22 +0200
From:   Piotr Sarna <p.sarna@tlen.pl>
To:     linux-kernel@vger.kernel.org, mike.kravetz@oracle.com
Cc:     Piotr Sarna <p.sarna@tlen.pl>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hugetlbfs: add O_TMPFILE support
Date:   Tue, 15 Oct 2019 11:01:12 +0200
Message-Id: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: e93136fb553552c8e020d3da8703060d
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [sUP0]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With hugetlbfs, a common pattern for mapping anonymous huge pages
is to create a temporary file first. Currently libraries like
libhugetlbfs and seastar create these with a standard mkstemp+unlink
trick, but it would be more robust to be able to simply pass
the O_TMPFILE flag to open(). O_TMPFILE is already supported by several
file systems like ext4 and xfs. The implementation simply uses the existing
d_tmpfile utility function to instantiate the dcache entry for the file.

Tested manually by successfully creating a temporary file by opening
it with (O_TMPFILE|O_RDWR) on mounted hugetlbfs and successfully
mapping 2M huge pages with it. Without the patch, trying to open
a file with O_TMPFILE results in -ENOSUP.

Signed-off-by: Piotr Sarna <p.sarna@tlen.pl>
---
 fs/hugetlbfs/inode.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1dcc57189382..277b7d231db8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -815,8 +815,11 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry, umode_t mode, dev_t dev)
+static int do_hugetlbfs_mknod(struct inode *dir,
+			struct dentry *dentry,
+			umode_t mode,
+			dev_t dev,
+			bool tmpfile)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -824,13 +827,22 @@ static int hugetlbfs_mknod(struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (inode) {
 		dir->i_ctime = dir->i_mtime = current_time(dir);
-		d_instantiate(dentry, inode);
+		if (tmpfile)
+			d_tmpfile(dentry, inode);
+		else
+			d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
 	}
 	return error;
 }
 
+static int hugetlbfs_mknod(struct inode *dir,
+			struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+}
+
 static int hugetlbfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
@@ -844,6 +856,12 @@ static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mo
 	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
 }
 
+static int hugetlbfs_tmpfile(struct inode *dir,
+			struct dentry *dentry, umode_t mode)
+{
+	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+}
+
 static int hugetlbfs_symlink(struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
@@ -1102,6 +1120,7 @@ static const struct inode_operations hugetlbfs_dir_inode_operations = {
 	.mknod		= hugetlbfs_mknod,
 	.rename		= simple_rename,
 	.setattr	= hugetlbfs_setattr,
+	.tmpfile	= hugetlbfs_tmpfile,
 };
 
 static const struct inode_operations hugetlbfs_inode_operations = {
-- 
2.21.0

