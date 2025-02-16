Return-Path: <linux-fsdevel+bounces-41791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E1A375EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E493A8790
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CD19DFA2;
	Sun, 16 Feb 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkD1u8Uj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175D19C553;
	Sun, 16 Feb 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724139; cv=none; b=ZfwIJfi73PIiO6rCAIEuQDQbQw3wux2JOUD9K+U0HGDHiPTDlO3uS5vSUnVUu17f1zN2ZY626WPiL7LHIM45I3+UtpEcRlslB4zAJAjCsYaNzjADSDojS4fWRUjrGrCPWiMdM2q5qhb4d8Awu1E9ylZknst6euh8jxk3gQP3dTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724139; c=relaxed/simple;
	bh=0yhYVM7S/m/+LJAHD9tUolFgs28ihCKY3cuMIALsEMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkGLp9bh3ZquCGcaM9rLrbpDDV5BC4RWWjMOJ3TxJSxtKbsxmc0FwPGLKBYpefV3BWk2Uf35K970UZPoXP/P6bt8gksYIS7c8VLDC53lpa/kBSG3ZNODLgzIY8QKfC5XsnZoIp/qneHq/tRFThcdiqbKhVO21TzLc0zeWX0G/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkD1u8Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8DEC4CEEA;
	Sun, 16 Feb 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724139;
	bh=0yhYVM7S/m/+LJAHD9tUolFgs28ihCKY3cuMIALsEMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkD1u8Ujfskss72KlFF/phFTWZIlVlWE5byAHiOT8NAmxQumtmgJNzIx9qMUBlYCb
	 nOXjF2PCksj1J8ax2IrDbp0ccLcSquKRAzItwHtzmxF9FosCda9nMUcA5SOE3npE/E
	 QUzP/ZSObf73f8hHpnMYuyqWuxEGaT35y0qnRMcVCaM+Ud9wueeQHUHcXKt/8WF7P8
	 gHDAFS7jcp/mZJkP0PQc7cuWmoUolz8c/gvuOT0MWYXr+wOtFnhZbcaKH3cGdAZbK8
	 iOr+evE7/Q6Zbj3AmopfJAY8NPI2Ht59imj1MkDPgazvj9a1r5Qv4Tnhdf2QRsKNlZ
	 GmsdJTJNsJ3vA==
Received: by pali.im (Postfix)
	id 588DFDB5; Sun, 16 Feb 2025 17:42:06 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] fs: Implement support for fsx_xflags_mask, fsx_xflags2 and fsx_xflags2_mask into vfs
Date: Sun, 16 Feb 2025 17:40:28 +0100
Message-Id: <20250216164029.20673-4-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216164029.20673-1-pali@kernel.org>
References: <20250216164029.20673-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change adds support for new struct fileattr fields fsx_xflags_mask,
fsx_xflags2 and fsx_xflags2_mask into FS_IOC_FSGETXATTR and
FS_IOC_FSSETXATTR ioctls.

All filesystem will start reporting values in new *_mask fields.
This change does not contain support for any new flag yet. This will be in
some followup changes.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/btrfs/ioctl.c         |  9 +++++-
 fs/efivarfs/inode.c      |  3 +-
 fs/ext2/ioctl.c          |  2 +-
 fs/ext4/ioctl.c          |  2 +-
 fs/f2fs/file.c           |  2 +-
 fs/fuse/ioctl.c          | 13 ++++++--
 fs/gfs2/file.c           | 14 ++++++++-
 fs/hfsplus/inode.c       |  3 +-
 fs/ioctl.c               | 65 +++++++++++++++++++++++++++++++++++-----
 fs/jfs/ioctl.c           | 14 ++++++++-
 fs/nilfs2/ioctl.c        |  2 +-
 fs/ntfs3/file.c          |  3 +-
 fs/ocfs2/ioctl.c         |  2 +-
 fs/orangefs/inode.c      |  2 +-
 fs/ubifs/ioctl.c         |  3 +-
 fs/xfs/xfs_ioctl.c       |  5 +++-
 include/linux/fileattr.h | 11 +++++--
 mm/shmem.c               |  2 +-
 18 files changed, 130 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..600f502ffb46 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -164,6 +164,13 @@ static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 	return iflags;
 }
 
+static inline unsigned int btrfs_supported_fsflags(void)
+{
+	return FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL |
+	       FS_NOATIME_FL | FS_DIRSYNC_FL | FS_NOCOW_FL | FS_VERITY_FL |
+	       FS_NOCOMP_FL | FS_COMPR_FL;
+}
+
 /*
  * Update inode->i_flags based on the btrfs internal flags.
  */
@@ -250,7 +257,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
 
-	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode));
+	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode), btrfs_supported_fsflags());
 	return 0;
 }
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 98a7299a9ee9..a8a3962b7751 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -142,12 +142,13 @@ efivarfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	unsigned int i_flags;
 	unsigned int flags = 0;
+	unsigned int mask = FS_IMMUTABLE_FL;
 
 	i_flags = d_inode(dentry)->i_flags;
 	if (i_flags & S_IMMUTABLE)
 		flags |= FS_IMMUTABLE_FL;
 
-	fileattr_fill_flags(fa, flags);
+	fileattr_fill_flags(fa, flags, mask);
 
 	return 0;
 }
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 44e04484e570..7a70f16c2824 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -22,7 +22,7 @@ int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
 
-	fileattr_fill_flags(fa, ei->i_flags & EXT2_FL_USER_VISIBLE);
+	fileattr_fill_flags(fa, ei->i_flags & EXT2_FL_USER_VISIBLE, EXT2_FL_USER_VISIBLE);
 
 	return 0;
 }
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7b9ce71c1c81..a199d0b74449 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -989,7 +989,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (S_ISREG(inode->i_mode))
 		flags &= ~FS_PROJINHERIT_FL;
 
-	fileattr_fill_flags(fa, flags);
+	fileattr_fill_flags(fa, flags, EXT4_FL_USER_VISIBLE);
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f92a9fba9991..03e1b31d1cbb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3297,7 +3297,7 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
 		fsflags |= FS_NOCOW_FL;
 
-	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
+	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL, F2FS_GETTABLE_FS_FL);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 2d9abf48828f..be0901d7c61e 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -520,14 +520,20 @@ int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 		if (err)
 			goto cleanup;
 
-		fileattr_fill_flags(fa, flags);
+		fileattr_fill_flags(fa, flags, ~0);
 	} else {
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSGETXATTR,
 				      &xfa, sizeof(xfa));
 		if (err)
 			goto cleanup;
 
-		fileattr_fill_xflags(fa, xfa.fsx_xflags);
+		if (!(xfa.fsx_xflags & FS_XFLAG_HASEXTFIELDS)) {
+			xfa.fsx_xflags_mask = 0;
+			xfa.fsx_xflags2 = 0;
+			xfa.fsx_xflags2_mask = 0;
+		}
+
+		fileattr_fill_xflags(fa, xfa.fsx_xflags, xfa.fsx_xflags_mask, xfa.fsx_xflags2, xfa.fsx_xflags2_mask);
 		fa->fsx_extsize = xfa.fsx_extsize;
 		fa->fsx_nextents = xfa.fsx_nextents;
 		fa->fsx_projid = xfa.fsx_projid;
@@ -564,6 +570,9 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 		xfa.fsx_nextents = fa->fsx_nextents;
 		xfa.fsx_projid = fa->fsx_projid;
 		xfa.fsx_cowextsize = fa->fsx_cowextsize;
+		xfa.fsx_xflags2 = fa->fsx_xflags2;
+		xfa.fsx_xflags2_mask = fa->fsx_xflags2_mask;
+		xfa.fsx_xflags_mask = fa->fsx_xflags_mask;
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index c9bb3be21d2b..29d243ade026 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -139,6 +139,16 @@ static struct {
 	{FS_JOURNAL_DATA_FL, GFS2_DIF_JDATA | GFS2_DIF_INHERIT_JDATA},
 };
 
+static inline u32 gfs2_supported_fsflags(void)
+{
+	int i;
+	u32 fsflags = 0;
+
+	for (i = 0; i < ARRAY_SIZE(fsflag_gfs2flag); i++)
+		fsflags |= fsflag_gfs2flag[i].fsflag;
+	return fsflags;
+}
+
 static inline u32 gfs2_gfsflags_to_fsflags(struct inode *inode, u32 gfsflags)
 {
 	int i;
@@ -162,6 +172,7 @@ int gfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	struct gfs2_holder gh;
 	int error;
 	u32 fsflags;
+	u32 fsmask;
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
@@ -172,8 +183,9 @@ int gfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 		goto out_uninit;
 
 	fsflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
+	fsmask = gfs2_supported_fsflags();
 
-	fileattr_fill_flags(fa, fsflags);
+	fileattr_fill_flags(fa, fsflags, fsmask);
 
 	gfs2_glock_dq(&gh);
 out_uninit:
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f331e9574217..bb430a920f2b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -659,6 +659,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	unsigned int flags = 0;
+	unsigned int mask = FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL;
 
 	if (inode->i_flags & S_IMMUTABLE)
 		flags |= FS_IMMUTABLE_FL;
@@ -667,7 +668,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (hip->userflags & HFSPLUS_FLG_NODUMP)
 		flags |= FS_NODUMP_FL;
 
-	fileattr_fill_flags(fa, flags);
+	fileattr_fill_flags(fa, flags, mask);
 
 	return 0;
 }
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 9f3609b50779..ef4d7d3d417b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -458,14 +458,19 @@ static int ioctl_file_dedupe_range(struct file *file,
  * @fa:		fileattr pointer
  * @xflags:	FS_XFLAG_* flags
  *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
+ * Set ->fsx_xflags, ->fsx_xflags2, ->fsx->xflags_mask, ->fsx_xflags2_mask,
+ * ->fsx_valid and ->flags (translated xflags).  All other fields are zeroed.
  */
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags, u32 xflags_mask, u16 xflags2, u16 xflags2_mask)
 {
 	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
+	fa->fsx_xflags2 = xflags2;
+	fa->fsx_xflags_mask = xflags_mask;
+	fa->fsx_xflags2_mask = xflags2_mask;
+	if (fa->fsx_xflags2 != 0 || fa->fsx_xflags_mask != 0 || fa->fsx_xflags2_mask != 0)
+		fa->fsx_xflags |= FS_XFLAG_HASEXTFIELDS;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
 		fa->flags |= FS_IMMUTABLE_FL;
 	if (fa->fsx_xflags & FS_XFLAG_APPEND)
@@ -491,15 +496,20 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * fileattr_fill_flags - initialize fileattr with flags
  * @fa:		fileattr pointer
  * @flags:	FS_*_FL flags
+ * @mask:	FS_*_FL flags mask
  *
- * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
+ * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags),
+ * fa->fsx_xflags_mask (translated flags mask).
  * All other fields are zeroed.
  */
-void fileattr_fill_flags(struct fileattr *fa, u32 flags)
+void fileattr_fill_flags(struct fileattr *fa, u32 flags, u32 mask)
 {
 	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
+
+	fa->fsx_xflags |= FS_XFLAG_HASEXTFIELDS;
+
 	if (fa->flags & FS_COMPR_FL)
 		fa->fsx_xflags |= FS_XFLAG_COMPRESSED;
 	if (fa->flags & FS_SYNC_FL)
@@ -518,6 +528,25 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_DAX;
 	if (fa->flags & FS_PROJINHERIT_FL)
 		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+
+	if (mask & FS_COMPR_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_COMPRESSED;
+	if (mask & FS_SYNC_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_SYNC;
+	if (mask & FS_IMMUTABLE_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_IMMUTABLE;
+	if (mask & FS_APPEND_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_APPEND;
+	if (mask & FS_NODUMP_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_NODUMP;
+	if (mask & FS_NOATIME_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_NOATIME;
+	if (mask & FS_ENCRYPT_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_ENCRYPTED;
+	if (mask & FS_DAX_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_DAX;
+	if (mask & FS_PROJINHERIT_FL)
+		fa->fsx_xflags_mask |= FS_XFLAG_PROJINHERIT;
 }
 EXPORT_SYMBOL(fileattr_fill_flags);
 
@@ -558,6 +587,11 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 	xfa.fsx_nextents = fa->fsx_nextents;
 	xfa.fsx_projid = fa->fsx_projid;
 	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+	if (xfa.fsx_xflags & FS_XFLAG_HASEXTFIELDS) {
+		xfa.fsx_xflags2 = fa->fsx_xflags2;
+		xfa.fsx_xflags2_mask = fa->fsx_xflags2_mask;
+		xfa.fsx_xflags_mask = fa->fsx_xflags_mask;
+	}
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -574,7 +608,13 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	if (!(xfa.fsx_xflags & FS_XFLAG_HASEXTFIELDS)) {
+		xfa.fsx_xflags_mask = 0;
+		xfa.fsx_xflags2 = 0;
+		xfa.fsx_xflags2_mask = 0;
+	}
+
+	fileattr_fill_xflags(fa, xfa.fsx_xflags, xfa.fsx_xflags_mask, xfa.fsx_xflags2, xfa.fsx_xflags2_mask);
 	fa->fsx_extsize = xfa.fsx_extsize;
 	fa->fsx_nextents = xfa.fsx_nextents;
 	fa->fsx_projid = xfa.fsx_projid;
@@ -692,11 +732,22 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		/* initialize missing bits from old_ma */
 		if (fa->flags_valid) {
 			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+			fa->fsx_xflags_mask = fa->fsx_xflags ^ old_ma.fsx_xflags;
 			fa->fsx_extsize = old_ma.fsx_extsize;
 			fa->fsx_nextents = old_ma.fsx_nextents;
 			fa->fsx_projid = old_ma.fsx_projid;
 			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+			fa->fsx_xflags2 = 0;
+			fa->fsx_xflags2_mask = 0;
 		} else {
+			if (fa->fsx_xflags & FS_XFLAG_HASEXTFIELDS) {
+				fa->fsx_xflags = (fa->fsx_xflags & fa->fsx_xflags_mask) | (old_ma.fsx_xflags & ~fa->fsx_xflags_mask);
+				fa->fsx_xflags2 = (fa->fsx_xflags2 & fa->fsx_xflags2_mask) | (old_ma.fsx_xflags2 & ~fa->fsx_xflags2_mask);
+			} else {
+				fa->fsx_xflags_mask = fa->fsx_xflags ^ old_ma.fsx_xflags;
+				fa->fsx_xflags2 = old_ma.fsx_xflags2;
+				fa->fsx_xflags2_mask = 0;
+			}
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
 		err = fileattr_set_prepare(inode, &old_ma, fa);
@@ -732,7 +783,7 @@ static int ioctl_setflags(struct file *file, unsigned int __user *argp)
 	if (!err) {
 		err = mnt_want_write_file(file);
 		if (!err) {
-			fileattr_fill_flags(&fa, flags);
+			fileattr_fill_flags(&fa, flags, FS_COMMON_FL);
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
 		}
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index f7bd7e8f5be4..86184e32015c 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -39,6 +39,18 @@ static struct {
 	{0, 0},
 };
 
+static long jfs_supported_ext2_flags(void)
+{
+	int index=0;
+	long mapped=0;
+
+	while (jfs_map[index].jfs_flag) {
+		mapped |= jfs_map[index].ext2_flag;
+		index++;
+	}
+	return mapped;
+}
+
 static long jfs_map_ext2(unsigned long flags, int from)
 {
 	int index=0;
@@ -65,7 +77,7 @@ int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
-	fileattr_fill_flags(fa, jfs_map_ext2(flags, 0));
+	fileattr_fill_flags(fa, jfs_map_ext2(flags, 0), jfs_supported_ext2_flags());
 
 	return 0;
 }
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index a66d62a51f77..2f1d5d765dcb 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -122,7 +122,7 @@ int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 
-	fileattr_fill_flags(fa, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE);
+	fileattr_fill_flags(fa, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE, FS_FL_USER_VISIBLE);
 
 	return 0;
 }
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3f96a11804c9..a8f4d0b08d83 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -57,6 +57,7 @@ int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u32 flags = 0;
+	u32 mask = FS_IMMUTABLE_FL | FS_APPEND_FL | FS_COMPR_FL | FS_ENCRYPT_FL;
 
 	if (inode->i_flags & S_IMMUTABLE)
 		flags |= FS_IMMUTABLE_FL;
@@ -70,7 +71,7 @@ int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (is_encrypted(ni))
 		flags |= FS_ENCRYPT_FL;
 
-	fileattr_fill_flags(fa, flags);
+	fileattr_fill_flags(fa, flags, mask);
 
 	return 0;
 }
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 7ae96fb8807a..fa48d1b92aab 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -77,7 +77,7 @@ int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	flags = OCFS2_I(inode)->ip_attr;
 	ocfs2_inode_unlock(inode, 0);
 
-	fileattr_fill_flags(fa, flags & OCFS2_FL_VISIBLE);
+	fileattr_fill_flags(fa, flags & OCFS2_FL_VISIBLE, OCFS2_FL_VISIBLE);
 
 	return status;
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767d..36104a08d654 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -923,7 +923,7 @@ static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 	gossip_debug(GOSSIP_FILE_DEBUG, "%s: flags=%u\n", __func__, (u32) val);
 
-	fileattr_fill_flags(fa, val);
+	fileattr_fill_flags(fa, val, FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL);
 	return 0;
 }
 
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 2c99349cf537..7d445c03a877 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -134,12 +134,13 @@ int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	int flags = ubifs2ioctl(ubifs_inode(inode)->flags);
+	int mask = ubifs2ioctl(~0);
 
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
 	dbg_gen("get flags: %#x, i_flags %#x", flags, inode->i_flags);
-	fileattr_fill_flags(fa, flags);
+	fileattr_fill_flags(fa, flags, mask);
 
 	return 0;
 }
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ed85322507dd..9c5e75568c94 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -448,8 +448,11 @@ xfs_fill_fsxattr(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
+	struct xfs_inode	ip_all_xflags = { .i_diflags = XFS_DIFLAG_ANY,
+						  .i_diflags2 = XFS_DIFLAG2_ANY,
+						  .i_forkoff = 1 };
 
-	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
+	fileattr_fill_xflags(fa, xfs_ip2xflags(ip), xfs_ip2xflags(&ip_all_xflags), 0, 0);
 
 	if (ip->i_diflags & XFS_DIFLAG_EXTSIZE) {
 		fa->fsx_extsize = XFS_FSB_TO_B(mp, ip->i_extsize);
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index c297e6151703..f2107598ed6b 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -28,6 +28,9 @@ struct fileattr {
 	u32	fsx_nextents;	/* nextents field value (get)	*/
 	u32	fsx_projid;	/* project identifier (get/set) */
 	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	u16	fsx_xflags2;	/* xflags2 field value (get/set)*/
+	u16	fsx_xflags2_mask;/*mask for xflags2 (get/set)*/
+	u32	fsx_xflags_mask;/* mask for xflags (get/set)*/
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
@@ -35,8 +38,8 @@ struct fileattr {
 
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
 
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
-void fileattr_fill_flags(struct fileattr *fa, u32 flags);
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags, u32 xflags_mask, u16 xflags2, u16 xflags2_mask);
+void fileattr_fill_flags(struct fileattr *fa, u32 flags, u32 mask);
 
 /**
  * fileattr_has_fsx - check for extended flags/attributes
@@ -49,7 +52,9 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
 {
 	return fa->fsx_valid &&
 		((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
-		 fa->fsx_projid != 0 ||	fa->fsx_cowextsize != 0);
+		 fa->fsx_projid != 0 || fa->fsx_cowextsize != 0 ||
+		 fa->fsx_xflags2 != 0 || fa->fsx_xflags2_mask != 0 ||
+		 (fa->fsx_xflags_mask & ~FS_XFLAG_COMMON));
 }
 
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..b991f49ee638 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4178,7 +4178,7 @@ static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
 
-	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
+	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE, SHMEM_FL_USER_VISIBLE);
 
 	return 0;
 }
-- 
2.20.1


