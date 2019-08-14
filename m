Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701A88D2CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNMSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:18:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55515 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNMSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:18:49 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEp-0005kI-EW; Wed, 14 Aug 2019 14:18:47 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEm-00082Y-Pl; Wed, 14 Aug 2019 14:18:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 09/11] ubifs: Add support for project id
Date:   Wed, 14 Aug 2019 14:18:32 +0200
Message-Id: <20190814121834.13983-10-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814121834.13983-1-s.hauer@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The project id is necessary for quota project id support. This adds
support for the project id to UBIFS aswell as support for the
FS_PROJINHERIT_FL flag.

This includes a change for the UBIFS on-disk format. struct
ubifs_ino_node gains a project id number and a UBIFS_PROJINHERIT_FL
flag.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/dir.c         | 11 +++++++-
 fs/ubifs/ioctl.c       | 61 +++++++++++++++++++++++++++++++++++++++++-
 fs/ubifs/journal.c     |  2 +-
 fs/ubifs/super.c       |  1 +
 fs/ubifs/ubifs-media.h |  6 +++--
 fs/ubifs/ubifs.h       |  4 +++
 6 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index cfce5fee9262..e2d3dfb67ae3 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -56,7 +56,8 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
 		 */
 		return 0;
 
-	flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL);
+	flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL |
+			     UBIFS_PROJINHERIT_FL);
 	if (!S_ISDIR(mode))
 		/* The "DIRSYNC" flag only applies to directories */
 		flags &= ~UBIFS_DIRSYNC_FL;
@@ -112,6 +113,11 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
 
+	if (ubifs_inode(dir)->flags & UBIFS_PROJINHERIT_FL)
+		ui->projid = ubifs_inode(dir)->projid;
+	else
+		ui->projid = make_kprojid(&init_user_ns, UBIFS_DEF_PROJID);
+
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_mapping->a_ops = &ubifs_file_address_operations;
@@ -705,6 +711,9 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	ubifs_assert(c, inode_is_locked(dir));
 	ubifs_assert(c, inode_is_locked(inode));
 
+	if (!projid_eq(dir_ui->projid, ui->projid))
+                return -EXDEV;
+
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
 	if (err)
 		return err;
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 121aa1003e24..824def711381 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -66,6 +66,8 @@ static int ioctl2ubifs(int ioctl_flags)
 		ubifs_flags |= UBIFS_IMMUTABLE_FL;
 	if (ioctl_flags & FS_DIRSYNC_FL)
 		ubifs_flags |= UBIFS_DIRSYNC_FL;
+	if (ioctl_flags & FS_PROJINHERIT_FL)
+		ubifs_flags |= UBIFS_PROJINHERIT_FL;
 
 	return ubifs_flags;
 }
@@ -91,6 +93,8 @@ static int ubifs2ioctl(int ubifs_flags)
 		ioctl_flags |= FS_IMMUTABLE_FL;
 	if (ubifs_flags & UBIFS_DIRSYNC_FL)
 		ioctl_flags |= FS_DIRSYNC_FL;
+	if (ubifs_flags & UBIFS_PROJINHERIT_FL)
+		ioctl_flags |= FS_PROJINHERIT_FL;
 
 	return ioctl_flags;
 }
@@ -106,6 +110,8 @@ static inline unsigned long ubifs_xflags_to_iflags(__u32 xflags)
 		iflags |= UBIFS_IMMUTABLE_FL;
 	if (xflags & FS_XFLAG_APPEND)
 		iflags |= UBIFS_APPEND_FL;
+	if (xflags & FS_XFLAG_PROJINHERIT)
+		iflags |= UBIFS_PROJINHERIT_FL;
 
         return iflags;
 }
@@ -121,10 +127,51 @@ static inline __u32 ubifs_iflags_to_xflags(unsigned long flags)
 		xflags |= FS_XFLAG_IMMUTABLE;
 	if (flags & UBIFS_APPEND_FL)
 		xflags |= FS_XFLAG_APPEND;
+	if (flags & UBIFS_PROJINHERIT_FL)
+		xflags |= FS_XFLAG_PROJINHERIT;
 
         return xflags;
 }
 
+static int ubifs_ioctl_check_project(struct ubifs_inode *ui, struct fsxattr *fa)
+{
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() == &init_user_ns)
+		return 0;
+
+	if (__kprojid_val(ui->projid) != fa->fsx_projid)
+		return -EINVAL;
+
+	if (ui->flags & UBIFS_PROJINHERIT_FL) {
+		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
+			return -EINVAL;
+	} else {
+		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ubifs_ioc_setproject(struct file *file, __u32 projid)
+{
+	struct inode *inode = file_inode(file);
+	struct ubifs_inode *ui = ubifs_inode(inode);
+	kprojid_t kprojid;
+
+	kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
+	if (projid_eq(kprojid, ui->projid))
+		return 0;
+
+	ui->projid = kprojid;
+
+	return 0;
+}
+
 static int setflags(struct file *file, int flags, struct fsxattr *fa)
 {
 	int ubi_flags, oldflags, err, release;
@@ -165,6 +212,16 @@ static int setflags(struct file *file, int flags, struct fsxattr *fa)
 	if (err)
 		goto out_unlock;
 
+	if (fa) {
+		err = ubifs_ioctl_check_project(ui, fa);
+		if (err)
+			goto out_unlock;
+
+		err = ubifs_ioc_setproject(file, fa->fsx_projid);
+		if (err)
+			goto out_unlock;
+	}
+
 	ui->flags = ubi_flags;
 	ubifs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
@@ -200,6 +257,7 @@ static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
 	memset(&fa, 0, sizeof(fa));
 
 	fa.fsx_xflags = ubifs_iflags_to_xflags(ui->flags);
+	fa.fsx_projid = (__u32)from_kprojid(&init_user_ns, ui->projid);
 
 	if (copy_to_user(arg, &fa, sizeof(fa)))
 		return -EFAULT;
@@ -209,7 +267,8 @@ static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
 
 static int check_xflags(unsigned int flags)
 {
-	if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND))
+	if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND |
+		      FS_XFLAG_PROJINHERIT))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4fd9683b8245..d8961993f9dd 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -54,7 +54,6 @@
  */
 static inline void zero_ino_node_unused(struct ubifs_ino_node *ino)
 {
-	memset(ino->padding1, 0, 4);
 	memset(ino->padding2, 0, 26);
 }
 
@@ -469,6 +468,7 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
 	ino->xattr_cnt   = cpu_to_le32(ui->xattr_cnt);
 	ino->xattr_size  = cpu_to_le32(ui->xattr_size);
 	ino->xattr_names = cpu_to_le32(ui->xattr_names);
+	ino->projid = cpu_to_le32(from_kprojid(&init_user_ns, ui->projid));
 	zero_ino_node_unused(ino);
 
 	/*
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 2c0803b0ac3a..dc7e235b1a4a 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -141,6 +141,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	ui->xattr_size  = le32_to_cpu(ino->xattr_size);
 	ui->xattr_names = le32_to_cpu(ino->xattr_names);
 	ui->synced_i_size = ui->ui_size = inode->i_size;
+	ui->projid = make_kprojid(&init_user_ns, le32_to_cpu(ino->projid));
 
 	ui->xattr = (ui->flags & UBIFS_XATTR_FL) ? 1 : 0;
 
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 3c9792cbb6ff..418f4eba1624 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -316,6 +316,7 @@ enum {
  * UBIFS_DIRSYNC_FL: I/O on this directory inode has to be synchronous
  * UBIFS_XATTR_FL: this inode is the inode for an extended attribute value
  * UBIFS_CRYPT_FL: use encryption for this inode
+ * UBIFS_PROJINHERIT_FL: Create with parents projid
  *
  * Note, these are on-flash flags which correspond to ioctl flags
  * (@FS_COMPR_FL, etc). They have the same values now, but generally, do not
@@ -329,6 +330,7 @@ enum {
 	UBIFS_DIRSYNC_FL   = 0x10,
 	UBIFS_XATTR_FL     = 0x20,
 	UBIFS_CRYPT_FL     = 0x40,
+	UBIFS_PROJINHERIT_FL = 0x80,
 };
 
 /* Inode flag bits used by UBIFS */
@@ -497,7 +499,7 @@ union ubifs_dev_desc {
  * @data_len: inode data length
  * @xattr_cnt: count of extended attributes this inode has
  * @xattr_size: summarized size of all extended attributes in bytes
- * @padding1: reserved for future, zeroes
+ * @projid: Quota project id
  * @xattr_names: sum of lengths of all extended attribute names belonging to
  *               this inode
  * @compr_type: compression type used for this inode
@@ -531,7 +533,7 @@ struct ubifs_ino_node {
 	__le32 data_len;
 	__le32 xattr_cnt;
 	__le32 xattr_size;
-	__u8 padding1[4]; /* Watch 'zero_ino_node_unused()' if changing! */
+	__le32 projid;
 	__le32 xattr_names;
 	__le16 compr_type;
 	__u8 padding2[26]; /* Watch 'zero_ino_node_unused()' if changing! */
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c55f212dcb75..3f8a33fca67b 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -155,6 +155,8 @@
 #define UBIFS_HMAC_ARR_SZ 0
 #endif
 
+#define UBIFS_DEF_PROJID 0
+
 /*
  * Lockdep classes for UBIFS inode @ui_mutex.
  */
@@ -362,6 +364,7 @@ struct ubifs_gced_idx_leb {
  *                 inodes
  * @ui_size: inode size used by UBIFS when writing to flash
  * @flags: inode flags (@UBIFS_COMPR_FL, etc)
+ * @projid: The project id of this inode
  * @compr_type: default compression type used for this inode
  * @last_page_read: page number of last page read (for bulk read)
  * @read_in_a_row: number of consecutive pages read in a row (for bulk read)
@@ -413,6 +416,7 @@ struct ubifs_inode {
 	loff_t synced_i_size;
 	loff_t ui_size;
 	int flags;
+	kprojid_t projid;
 	pgoff_t last_page_read;
 	pgoff_t read_in_a_row;
 	int data_len;
-- 
2.20.1

