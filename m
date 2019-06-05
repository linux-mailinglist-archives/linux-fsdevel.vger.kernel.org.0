Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C503567E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 08:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFEGAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 02:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGAG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:00:06 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F3A20866;
        Wed,  5 Jun 2019 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559714404;
        bh=KegJwvpAQSXmPZk0kg4gegp77j4A68ieVMNI7AfwMkA=;
        h=From:To:Cc:Subject:Date:From;
        b=fIF6OWMo8P4cPJ2ZBogaQnZlxuPoF6EqNSP8s3o1+JGioaiL8O0Sy8XHAj03sEloj
         0If/ar1OqgwNTORFY/anMzXOdL6xyf1P6/Yhdr0rqVIU7PExC3r7XY99ly5zAwCDkH
         NiuoikupierTvlkWHQoKzOmCOukp/IIgPxE5qveg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] f2fs: separate f2fs i_flags from fs_flags and ext4 i_flags
Date:   Tue,  4 Jun 2019 22:59:04 -0700
Message-Id: <20190605055904.4039-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

f2fs copied all the on-disk i_flags from ext4, and along with it the
assumption that the on-disk i_flags are the same as the bits used by
FS_IOC_GETFLAGS and FS_IOC_SETFLAGS.  This is problematic because
reserving an on-disk inode flag in either filesystem's i_flags or in
these ioctls effectively reserves it in all the other places too.  In
fact, most of the "f2fs i_flags" are not used by f2fs at all.

Fix this by separating f2fs's i_flags from the ioctl bits and ext4's
i_flags.

In the process, un-reserve all "f2fs i_flags" that aren't actually
supported by f2fs.  This included various flags that were not settable
at all, as well as various flags that were settable by FS_IOC_SETFLAGS
but didn't actually do anything.

There's a slight chance we'll need to add some flag(s) back to
FS_IOC_SETFLAGS in order to avoid breaking users who expect f2fs to
accept some random flag(s).  But hopefully such users don't exist.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/f2fs.h |  42 +--------
 fs/f2fs/file.c | 239 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 163 insertions(+), 118 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd2bf0f559b6..4fc297c263adc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2335,57 +2335,23 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 }
 
 /*
- * Inode flags
+ * On-disk inode flags (f2fs_inode::i_flags)
  */
-#define F2FS_SECRM_FL			0x00000001 /* Secure deletion */
-#define F2FS_UNRM_FL			0x00000002 /* Undelete */
-#define F2FS_COMPR_FL			0x00000004 /* Compress file */
 #define F2FS_SYNC_FL			0x00000008 /* Synchronous updates */
 #define F2FS_IMMUTABLE_FL		0x00000010 /* Immutable file */
 #define F2FS_APPEND_FL			0x00000020 /* writes to file may only append */
 #define F2FS_NODUMP_FL			0x00000040 /* do not dump file */
 #define F2FS_NOATIME_FL			0x00000080 /* do not update atime */
-/* Reserved for compression usage... */
-#define F2FS_DIRTY_FL			0x00000100
-#define F2FS_COMPRBLK_FL		0x00000200 /* One or more compressed clusters */
-#define F2FS_NOCOMPR_FL			0x00000400 /* Don't compress */
-#define F2FS_ENCRYPT_FL			0x00000800 /* encrypted file */
-/* End compression flags --- maybe not all used */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
-#define F2FS_IMAGIC_FL			0x00002000 /* AFS directory */
-#define F2FS_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
-#define F2FS_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
-#define F2FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
-#define F2FS_HUGE_FILE_FL               0x00040000 /* Set to each huge file */
-#define F2FS_EXTENTS_FL			0x00080000 /* Inode uses extents */
-#define F2FS_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
-#define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
-#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
-#define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
-#define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
-
-#define F2FS_FL_USER_VISIBLE		0x30CBDFFF /* User visible flags */
-#define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
-
-/* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
-#define F2FS_FL_XFLAG_VISIBLE		(F2FS_SYNC_FL | \
-					 F2FS_IMMUTABLE_FL | \
-					 F2FS_APPEND_FL | \
-					 F2FS_NODUMP_FL | \
-					 F2FS_NOATIME_FL | \
-					 F2FS_PROJINHERIT_FL)
 
 /* Flags that should be inherited by new inodes from their parent. */
-#define F2FS_FL_INHERITED (F2FS_SECRM_FL | F2FS_UNRM_FL | F2FS_COMPR_FL |\
-			   F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL |\
-			   F2FS_NOCOMPR_FL | F2FS_JOURNAL_DATA_FL |\
-			   F2FS_NOTAIL_FL | F2FS_DIRSYNC_FL |\
-			   F2FS_PROJINHERIT_FL)
+#define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
+			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+#define F2FS_REG_FLMASK		(~F2FS_DIRSYNC_FL)
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 45b45f37d347e..efdafa8865106 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -707,11 +707,9 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
-	flags = fi->i_flags & F2FS_FL_USER_VISIBLE;
+	flags = fi->i_flags;
 	if (flags & F2FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-	if (flags & F2FS_COMPR_FL)
-		stat->attributes |= STATX_ATTR_COMPRESSED;
 	if (IS_ENCRYPTED(inode))
 		stat->attributes |= STATX_ATTR_ENCRYPTED;
 	if (flags & F2FS_IMMUTABLE_FL)
@@ -720,7 +718,6 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 		stat->attributes |= STATX_ATTR_NODUMP;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
-				  STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
@@ -1648,44 +1645,22 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	return 0;
 }
 
-static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int flags = fi->i_flags;
-
-	if (IS_ENCRYPTED(inode))
-		flags |= F2FS_ENCRYPT_FL;
-	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
-		flags |= F2FS_INLINE_DATA_FL;
-	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		flags |= F2FS_NOCOW_FL;
-
-	flags &= F2FS_FL_USER_VISIBLE;
-
-	return put_user(flags, (int __user *)arg);
-}
-
-static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
+static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int oldflags;
+	u32 oldflags;
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
-	flags = f2fs_mask_flags(inode->i_mode, flags);
-
 	oldflags = fi->i_flags;
 
-	if ((flags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
+	if ((iflags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
 		if (!capable(CAP_LINUX_IMMUTABLE))
 			return -EPERM;
 
-	flags = flags & F2FS_FL_USER_MODIFIABLE;
-	flags |= oldflags & ~F2FS_FL_USER_MODIFIABLE;
-	fi->i_flags = flags;
+	fi->i_flags = iflags | (oldflags & ~mask);
 
 	if (fi->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
@@ -1698,26 +1673,124 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
+/* FS_IOC_GETFLAGS and FS_IOC_SETFLAGS support */
+
+/*
+ * To make a new on-disk f2fs i_flag gettable via FS_IOC_GETFLAGS, add an entry
+ * for it to f2fs_fsflags_map[], and add its FS_*_FL equivalent to
+ * F2FS_GETTABLE_FS_FL.  To also make it settable via FS_IOC_SETFLAGS, also add
+ * its FS_*_FL equivalent to F2FS_SETTABLE_FS_FL.
+ */
+
+static const struct {
+	u32 iflag;
+	u32 fsflag;
+} f2fs_fsflags_map[] = {
+	{ F2FS_SYNC_FL,		FS_SYNC_FL },
+	{ F2FS_IMMUTABLE_FL,	FS_IMMUTABLE_FL },
+	{ F2FS_APPEND_FL,	FS_APPEND_FL },
+	{ F2FS_NODUMP_FL,	FS_NODUMP_FL },
+	{ F2FS_NOATIME_FL,	FS_NOATIME_FL },
+	{ F2FS_INDEX_FL,	FS_INDEX_FL },
+	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
+	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
+};
+
+#define F2FS_GETTABLE_FS_FL (		\
+		FS_SYNC_FL |		\
+		FS_IMMUTABLE_FL |	\
+		FS_APPEND_FL |		\
+		FS_NODUMP_FL |		\
+		FS_NOATIME_FL |		\
+		FS_INDEX_FL |		\
+		FS_DIRSYNC_FL |		\
+		FS_PROJINHERIT_FL |	\
+		FS_ENCRYPT_FL |		\
+		FS_INLINE_DATA_FL |	\
+		FS_NOCOW_FL)
+
+#define F2FS_SETTABLE_FS_FL (		\
+		FS_SYNC_FL |		\
+		FS_IMMUTABLE_FL |	\
+		FS_APPEND_FL |		\
+		FS_NODUMP_FL |		\
+		FS_NOATIME_FL |		\
+		FS_DIRSYNC_FL |		\
+		FS_PROJINHERIT_FL)
+
+/* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
+static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
+{
+	u32 fsflags = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f2fs_fsflags_map); i++)
+		if (iflags & f2fs_fsflags_map[i].iflag)
+			fsflags |= f2fs_fsflags_map[i].fsflag;
+
+	return fsflags;
+}
+
+/* Convert FS_IOC_{GET,SET}FLAGS flags to f2fs on-disk i_flags */
+static inline u32 f2fs_fsflags_to_iflags(u32 fsflags)
+{
+	u32 iflags = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f2fs_fsflags_map); i++)
+		if (fsflags & f2fs_fsflags_map[i].fsflag)
+			iflags |= f2fs_fsflags_map[i].iflag;
+
+	return iflags;
+}
+
+static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
+
+	if (IS_ENCRYPTED(inode))
+		fsflags |= FS_ENCRYPT_FL;
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		fsflags |= FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		fsflags |= FS_NOCOW_FL;
+
+	fsflags &= F2FS_GETTABLE_FS_FL;
+
+	return put_user(fsflags, (int __user *)arg);
+}
+
 static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
+	u32 fsflags;
+	u32 iflags;
 	int ret;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (get_user(flags, (int __user *)arg))
+	if (get_user(fsflags, (int __user *)arg))
 		return -EFAULT;
 
+	if (fsflags & ~F2FS_GETTABLE_FS_FL)
+		return -EOPNOTSUPP;
+	fsflags &= F2FS_SETTABLE_FS_FL;
+
+	iflags = f2fs_fsflags_to_iflags(fsflags);
+	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
+		return -EOPNOTSUPP;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
 	inode_lock(inode);
 
-	ret = __f2fs_ioc_setflags(inode, flags);
-
+	ret = f2fs_setflags_common(inode, iflags,
+			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2727,47 +2800,56 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 }
 #endif
 
-/* Transfer internal flags to xflags */
-static inline __u32 f2fs_iflags_to_xflags(unsigned long iflags)
-{
-	__u32 xflags = 0;
-
-	if (iflags & F2FS_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
-	if (iflags & F2FS_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	if (iflags & F2FS_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
-	if (iflags & F2FS_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
-	if (iflags & F2FS_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
-	if (iflags & F2FS_PROJINHERIT_FL)
-		xflags |= FS_XFLAG_PROJINHERIT;
+/* FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR support */
+
+/*
+ * To make a new on-disk f2fs i_flag gettable via FS_IOC_FSGETXATTR and settable
+ * via FS_IOC_FSSETXATTR, add an entry for it to f2fs_xflags_map[], and add its
+ * FS_XFLAG_* equivalent to F2FS_SUPPORTED_XFLAGS.
+ */
+
+static const struct {
+	u32 iflag;
+	u32 xflag;
+} f2fs_xflags_map[] = {
+	{ F2FS_SYNC_FL,		FS_XFLAG_SYNC },
+	{ F2FS_IMMUTABLE_FL,	FS_XFLAG_IMMUTABLE },
+	{ F2FS_APPEND_FL,	FS_XFLAG_APPEND },
+	{ F2FS_NODUMP_FL,	FS_XFLAG_NODUMP },
+	{ F2FS_NOATIME_FL,	FS_XFLAG_NOATIME },
+	{ F2FS_PROJINHERIT_FL,	FS_XFLAG_PROJINHERIT },
+};
+
+#define F2FS_SUPPORTED_XFLAGS (		\
+		FS_XFLAG_SYNC |		\
+		FS_XFLAG_IMMUTABLE |	\
+		FS_XFLAG_APPEND |	\
+		FS_XFLAG_NODUMP |	\
+		FS_XFLAG_NOATIME |	\
+		FS_XFLAG_PROJINHERIT)
+
+/* Convert f2fs on-disk i_flags to FS_IOC_FS{GET,SET}XATTR flags */
+static inline u32 f2fs_iflags_to_xflags(u32 iflags)
+{
+	u32 xflags = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
+		if (iflags & f2fs_xflags_map[i].iflag)
+			xflags |= f2fs_xflags_map[i].xflag;
+
 	return xflags;
 }
 
-#define F2FS_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
-				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
-				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
-
-/* Transfer xflags flags to internal */
-static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
+/* Convert FS_IOC_FS{GET,SET}XATTR flags to f2fs on-disk i_flags */
+static inline u32 f2fs_xflags_to_iflags(u32 xflags)
 {
-	unsigned long iflags = 0;
+	u32 iflags = 0;
+	int i;
 
-	if (xflags & FS_XFLAG_SYNC)
-		iflags |= F2FS_SYNC_FL;
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		iflags |= F2FS_IMMUTABLE_FL;
-	if (xflags & FS_XFLAG_APPEND)
-		iflags |= F2FS_APPEND_FL;
-	if (xflags & FS_XFLAG_NODUMP)
-		iflags |= F2FS_NODUMP_FL;
-	if (xflags & FS_XFLAG_NOATIME)
-		iflags |= F2FS_NOATIME_FL;
-	if (xflags & FS_XFLAG_PROJINHERIT)
-		iflags |= F2FS_PROJINHERIT_FL;
+	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
+		if (xflags & f2fs_xflags_map[i].xflag)
+			iflags |= f2fs_xflags_map[i].iflag;
 
 	return iflags;
 }
@@ -2779,8 +2861,7 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 	struct fsxattr fa;
 
 	memset(&fa, 0, sizeof(struct fsxattr));
-	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
-				F2FS_FL_USER_VISIBLE);
+	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
@@ -2818,9 +2899,8 @@ static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
 static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct fsxattr fa;
-	unsigned int flags;
+	u32 iflags;
 	int err;
 
 	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
@@ -2830,11 +2910,11 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (fa.fsx_xflags & ~F2FS_SUPPORTED_FS_XFLAGS)
+	if (fa.fsx_xflags & ~F2FS_SUPPORTED_XFLAGS)
 		return -EOPNOTSUPP;
 
-	flags = f2fs_xflags_to_iflags(fa.fsx_xflags);
-	if (f2fs_mask_flags(inode->i_mode, flags) != flags)
+	iflags = f2fs_xflags_to_iflags(fa.fsx_xflags);
+	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
 		return -EOPNOTSUPP;
 
 	err = mnt_want_write_file(filp);
@@ -2845,9 +2925,8 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 	err = f2fs_ioctl_check_project(inode, &fa);
 	if (err)
 		goto out;
-	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
-				(flags & F2FS_FL_XFLAG_VISIBLE);
-	err = __f2fs_ioc_setflags(inode, flags);
+	err = f2fs_setflags_common(inode, iflags,
+			f2fs_xflags_to_iflags(F2FS_SUPPORTED_XFLAGS));
 	if (err)
 		goto out;
 
-- 
2.21.0

