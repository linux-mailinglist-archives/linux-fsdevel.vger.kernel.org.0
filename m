Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771821485B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 14:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbgAXNN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 08:13:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389187AbgAXNN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:13:28 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0003aJ-Rc; Fri, 24 Jan 2020 14:13:25 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0006ZP-47; Fri, 24 Jan 2020 14:13:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/8] ubifs: Add support for project id
Date:   Fri, 24 Jan 2020 14:13:21 +0100
Message-Id: <20200124131323.23885-7-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124131323.23885-1-s.hauer@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
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
support for the project id to UBIFS as well as support for the
FS_PROJINHERIT_FL flag.

This includes a change for the UBIFS on-disk format. struct
ubifs_ino_node gains a project id number and a UBIFS_PROJINHERIT_FL
flag. A feature flag is added to prevent older UBIFS implementations
from mounting images with project ids. The feature flag is set when
a projid is set for the first time.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/dir.c         | 36 +++++++++++++++++++++++++++++++++--
 fs/ubifs/ioctl.c       | 43 ++++++++++++++++++++++++++++++++++++++++--
 fs/ubifs/journal.c     |  2 +-
 fs/ubifs/sb.c          |  5 +++++
 fs/ubifs/super.c       |  1 +
 fs/ubifs/ubifs-media.h | 10 +++++++---
 fs/ubifs/ubifs.h       |  5 +++++
 7 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index cfce5fee9262..06d9192000cb 100644
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
@@ -1538,6 +1547,20 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
+static int ubifs_rename_check_projid(struct inode *dir, struct inode *inode)
+{
+	struct ubifs_inode *ud = ubifs_inode(dir);
+	struct ubifs_inode *ui = ubifs_inode(inode);
+
+	if (!(ud->flags & UBIFS_PROJINHERIT_FL))
+		return 0;
+
+	if (projid_eq(ud->projid, ui->projid))
+		return 0;
+
+	return -EXDEV;
+}
+
 static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
@@ -1556,8 +1579,17 @@ static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		return err;
 
-	if (flags & RENAME_EXCHANGE)
+	err = ubifs_rename_check_projid(new_dir, old_dentry->d_inode);
+	if (err)
+		return err;
+
+	if (flags & RENAME_EXCHANGE) {
+		err = ubifs_rename_check_projid(old_dir, new_dentry->d_inode);
+		if (err)
+			return err;
+
 		return ubifs_xrename(old_dir, old_dentry, new_dir, new_dentry);
+	}
 
 	return do_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
 }
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 23967031b947..e5c684b6d7a7 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -19,7 +19,7 @@
 /* Need to be kept consistent with checked flags in ioctl2ubifs() */
 #define UBIFS_SUPPORTED_IOCTL_FLAGS \
 	(FS_COMPR_FL | FS_SYNC_FL | FS_APPEND_FL | \
-	 FS_IMMUTABLE_FL | FS_DIRSYNC_FL)
+	 FS_IMMUTABLE_FL | FS_DIRSYNC_FL | FS_PROJINHERIT_FL)
 
 /**
  * ubifs_set_inode_flags - set VFS inode flags.
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
@@ -106,6 +110,8 @@ static unsigned long ubifs_xflags_to_iflags(__u32 xflags)
 		iflags |= UBIFS_IMMUTABLE_FL;
 	if (xflags & FS_XFLAG_APPEND)
 		iflags |= UBIFS_APPEND_FL;
+	if (xflags & FS_XFLAG_PROJINHERIT)
+		iflags |= UBIFS_PROJINHERIT_FL;
 
         return iflags;
 }
@@ -121,15 +127,34 @@ static __u32 ubifs_iflags_to_xflags(unsigned long flags)
 		xflags |= FS_XFLAG_IMMUTABLE;
 	if (flags & UBIFS_APPEND_FL)
 		xflags |= FS_XFLAG_APPEND;
+	if (flags & UBIFS_PROJINHERIT_FL)
+		xflags |= FS_XFLAG_PROJINHERIT;
 
         return xflags;
 }
 
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
 static void ubifs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 {
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
 	simple_fill_fsxattr(fa, ubifs_iflags_to_xflags(ui->flags));
+
+	fa->fsx_projid = (__u32)from_kprojid(&init_user_ns, ui->projid);
 }
 
 static int setflags(struct file *file, int flags, struct fsxattr *fa)
@@ -140,6 +165,7 @@ static int setflags(struct file *file, int flags, struct fsxattr *fa)
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 					.dirtied_ino_d = ui->data_len };
+	__u32 projid = UBIFS_DEF_PROJID;
 
 	if (IS_RDONLY(inode))
 		return -EROFS;
@@ -182,9 +208,21 @@ static int setflags(struct file *file, int flags, struct fsxattr *fa)
 		err = vfs_ioc_fssetxattr_check(inode, &old_fa, fa);
 		if (err)
 			goto out_unlock;
+
+		projid = fa->fsx_projid;
+
+		err = ubifs_ioc_setproject(file, projid);
+		if (err)
+			goto out_unlock;
 	}
 
 	ui->flags = ubi_flags;
+	if (ui->flags & UBIFS_FLG_PROJID || projid != UBIFS_DEF_PROJID) {
+		err = ubifs_enable_projid(c);
+		if (err)
+			goto out_unlock;
+	}
+
 	ubifs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
 	release = ui->dirty;
@@ -225,7 +263,8 @@ static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
 
 static int check_xflags(unsigned int flags)
 {
-	if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND))
+	if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND |
+		      FS_XFLAG_PROJINHERIT))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 388fe8f5dc51..0a46eefd98a0 100644
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
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 628b9adec865..8f8a8f72d532 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -959,3 +959,8 @@ int ubifs_enable_encryption(struct ubifs_info *c)
 
 	return err;
 }
+
+int ubifs_enable_projid(struct ubifs_info *c)
+{
+	return ubifs_set_feature_flag(c, UBIFS_FLG_PROJID);
+}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 5e1e8ec0589e..e702fb4e92cf 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -141,6 +141,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	ui->xattr_size  = le32_to_cpu(ino->xattr_size);
 	ui->xattr_names = le32_to_cpu(ino->xattr_names);
 	ui->synced_i_size = ui->ui_size = inode->i_size;
+	ui->projid = make_kprojid(&init_user_ns, le32_to_cpu(ino->projid));
 
 	ui->xattr = (ui->flags & UBIFS_XATTR_FL) ? 1 : 0;
 
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 3c9792cbb6ff..59077e7fddbc 100644
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
@@ -427,6 +429,7 @@ enum {
  *			  support 64bit cookies for lookups by hash
  * UBIFS_FLG_ENCRYPTION: this filesystem contains encrypted files
  * UBIFS_FLG_AUTHENTICATION: this filesystem contains hashes for authentication
+ * UBIFS_FLG_PROJID: this filesystem has project id support enabled
  */
 enum {
 	UBIFS_FLG_BIGLPT = 0x02,
@@ -434,11 +437,12 @@ enum {
 	UBIFS_FLG_DOUBLE_HASH = 0x08,
 	UBIFS_FLG_ENCRYPTION = 0x10,
 	UBIFS_FLG_AUTHENTICATION = 0x20,
+	UBIFS_FLG_PROJID = 0x40,
 };
 
 #define UBIFS_FLG_MASK (UBIFS_FLG_BIGLPT | UBIFS_FLG_SPACE_FIXUP | \
 		UBIFS_FLG_DOUBLE_HASH | UBIFS_FLG_ENCRYPTION | \
-		UBIFS_FLG_AUTHENTICATION)
+		UBIFS_FLG_AUTHENTICATION | UBIFS_FLG_PROJID)
 
 /**
  * struct ubifs_ch - common header node.
@@ -497,7 +501,7 @@ union ubifs_dev_desc {
  * @data_len: inode data length
  * @xattr_cnt: count of extended attributes this inode has
  * @xattr_size: summarized size of all extended attributes in bytes
- * @padding1: reserved for future, zeroes
+ * @projid: Quota project id
  * @xattr_names: sum of lengths of all extended attribute names belonging to
  *               this inode
  * @compr_type: compression type used for this inode
@@ -531,7 +535,7 @@ struct ubifs_ino_node {
 	__le32 data_len;
 	__le32 xattr_cnt;
 	__le32 xattr_size;
-	__u8 padding1[4]; /* Watch 'zero_ino_node_unused()' if changing! */
+	__le32 projid;
 	__le32 xattr_names;
 	__le16 compr_type;
 	__u8 padding2[26]; /* Watch 'zero_ino_node_unused()' if changing! */
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c55f212dcb75..16e140420f35 100644
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
@@ -1901,6 +1905,7 @@ int ubifs_read_superblock(struct ubifs_info *c);
 int ubifs_write_sb_node(struct ubifs_info *c, struct ubifs_sb_node *sup);
 int ubifs_fixup_free_space(struct ubifs_info *c);
 int ubifs_enable_encryption(struct ubifs_info *c);
+int ubifs_enable_projid(struct ubifs_info *c);
 
 /* replay.c */
 int ubifs_validate_entry(struct ubifs_info *c,
-- 
2.25.0

