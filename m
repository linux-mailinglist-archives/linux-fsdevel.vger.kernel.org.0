Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F122FED1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbhAUOkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:40:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbhAUNey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:34:54 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZvY-0005g7-26; Thu, 21 Jan 2021 13:23:08 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 39/40] xfs: support idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:58 +0100
Message-Id: <20210121131959.646623-40-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=d7ldZtaFSwLMbVFbt4m1mmWsaSb85RxEpfrHiOUpdc0=; m=QwSbW4sL84srtFIqwxJ/4EoBPbQH8EcV1XEmIc9k0es=; p=asmXEq1/0ldV3uydC+jwuPD/ZSgCIRiczcJb1mEQDsk=; g=400b191755559fb8ee4e3aa205a43c76e3098a0b
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pwAKCRCRxhvAZXjcomxaAP4yxxS tPsdAtkjrKM4SCM8IFnt5bGfurNhOvF4WMErD2QD7B6tkHKZ2CI46sczpdW4excm26SfW2bqsMk4l vWwtiwc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Enable idmapped mounts for xfs. This basically just means passing down
the user_namespace argument from the VFS methods down to where it is
passed to the relevant helpers.

Note that full-filesystem bulkstat is not supported from inside idmapped
mounts as it is an administrative operation that acts on the whole file
system. The limitation is not applied to the bulkstat single operation
that just operates on a single inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */

/* v3 */

/* v4 */

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 fs/xfs/xfs_acl.c     |  3 +--
 fs/xfs/xfs_file.c    |  4 +++-
 fs/xfs/xfs_inode.c   | 26 +++++++++++++++--------
 fs/xfs/xfs_inode.h   | 16 +++++++++------
 fs/xfs/xfs_ioctl.c   | 35 ++++++++++++++++++-------------
 fs/xfs/xfs_ioctl32.c |  6 ++++--
 fs/xfs/xfs_iops.c    | 49 +++++++++++++++++++++++++-------------------
 fs/xfs/xfs_iops.h    |  3 ++-
 fs/xfs/xfs_itable.c  | 17 +++++++++++----
 fs/xfs/xfs_itable.h  |  1 +
 fs/xfs/xfs_qm.c      |  3 ++-
 fs/xfs/xfs_super.c   |  2 +-
 fs/xfs/xfs_symlink.c |  5 +++--
 fs/xfs/xfs_symlink.h |  5 +++--
 14 files changed, 110 insertions(+), 65 deletions(-)

diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 332e87153c6c..d02bef24b32b 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -253,8 +253,7 @@ xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		return error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(&init_user_ns, inode, &mode,
-					      &acl);
+		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
 		if (error)
 			return error;
 		set_mode = true;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f73837..1bdc3560aed9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/mman.h>
 #include <linux/fadvise.h>
+#include <linux/mount.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -994,7 +995,8 @@ xfs_file_fallocate(
 
 		iattr.ia_valid = ATTR_SIZE;
 		iattr.ia_size = new_size;
-		error = xfs_vn_setattr_size(file_dentry(file), &iattr);
+		error = xfs_vn_setattr_size(file_mnt_user_ns(file),
+					    file_dentry(file), &iattr);
 		if (error)
 			goto out_unlock;
 	}
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index b7352bc4c815..95b7f2ba4e06 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -766,6 +766,7 @@ xfs_inode_inherit_flags2(
  */
 static int
 xfs_init_new_inode(
+	struct user_namespace	*mnt_userns,
 	struct xfs_trans	*tp,
 	struct xfs_inode	*pip,
 	xfs_ino_t		ino,
@@ -806,7 +807,7 @@ xfs_init_new_inode(
 	inode = VFS_I(ip);
 	inode->i_mode = mode;
 	set_nlink(inode, nlink);
-	inode->i_uid = current_fsuid();
+	inode->i_uid = fsuid_into_mnt(mnt_userns);
 	inode->i_rdev = rdev;
 	ip->i_d.di_projid = prid;
 
@@ -815,7 +816,7 @@ xfs_init_new_inode(
 		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
 			inode->i_mode |= S_ISGID;
 	} else {
-		inode->i_gid = current_fsgid();
+		inode->i_gid = fsgid_into_mnt(mnt_userns);
 	}
 
 	/*
@@ -824,7 +825,8 @@ xfs_init_new_inode(
 	 * (and only if the irix_sgid_inherit compatibility variable is set).
 	 */
 	if (irix_sgid_inherit &&
-	    (inode->i_mode & S_ISGID) && !in_group_p(inode->i_gid))
+	    (inode->i_mode & S_ISGID) &&
+	    !in_group_p(i_gid_into_mnt(mnt_userns, inode)))
 		inode->i_mode &= ~S_ISGID;
 
 	ip->i_d.di_size = 0;
@@ -901,6 +903,7 @@ xfs_init_new_inode(
  */
 int
 xfs_dir_ialloc(
+	struct user_namespace	*mnt_userns,
 	struct xfs_trans	**tpp,
 	struct xfs_inode	*dp,
 	umode_t			mode,
@@ -933,7 +936,8 @@ xfs_dir_ialloc(
 		return error;
 	ASSERT(ino != NULLFSINO);
 
-	return xfs_init_new_inode(*tpp, dp, ino, mode, nlink, rdev, prid, ipp);
+	return xfs_init_new_inode(mnt_userns, *tpp, dp, ino, mode, nlink, rdev,
+				  prid, ipp);
 }
 
 /*
@@ -973,6 +977,7 @@ xfs_bumplink(
 
 int
 xfs_create(
+	struct user_namespace	*mnt_userns,
 	xfs_inode_t		*dp,
 	struct xfs_name		*name,
 	umode_t			mode,
@@ -1047,7 +1052,8 @@ xfs_create(
 	 * entry pointing to them, but a directory also the "." entry
 	 * pointing to itself.
 	 */
-	error = xfs_dir_ialloc(&tp, dp, mode, is_dir ? 2 : 1, rdev, prid, &ip);
+	error = xfs_dir_ialloc(mnt_userns, &tp, dp, mode, is_dir ? 2 : 1, rdev,
+			       prid, &ip);
 	if (error)
 		goto out_trans_cancel;
 
@@ -1128,6 +1134,7 @@ xfs_create(
 
 int
 xfs_create_tmpfile(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*dp,
 	umode_t			mode,
 	struct xfs_inode	**ipp)
@@ -1169,7 +1176,7 @@ xfs_create_tmpfile(
 	if (error)
 		goto out_trans_cancel;
 
-	error = xfs_dir_ialloc(&tp, dp, mode, 0, 0, prid, &ip);
+	error = xfs_dir_ialloc(mnt_userns, &tp, dp, mode, 0, 0, prid, &ip);
 	if (error)
 		goto out_trans_cancel;
 
@@ -2977,13 +2984,15 @@ xfs_cross_rename(
  */
 static int
 xfs_rename_alloc_whiteout(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*dp,
 	struct xfs_inode	**wip)
 {
 	struct xfs_inode	*tmpfile;
 	int			error;
 
-	error = xfs_create_tmpfile(dp, S_IFCHR | WHITEOUT_MODE, &tmpfile);
+	error = xfs_create_tmpfile(mnt_userns, dp, S_IFCHR | WHITEOUT_MODE,
+				   &tmpfile);
 	if (error)
 		return error;
 
@@ -3005,6 +3014,7 @@ xfs_rename_alloc_whiteout(
  */
 int
 xfs_rename(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*src_dp,
 	struct xfs_name		*src_name,
 	struct xfs_inode	*src_ip,
@@ -3036,7 +3046,7 @@ xfs_rename(
 	 */
 	if (flags & RENAME_WHITEOUT) {
 		ASSERT(!(flags & (RENAME_NOREPLACE | RENAME_EXCHANGE)));
-		error = xfs_rename_alloc_whiteout(target_dp, &wip);
+		error = xfs_rename_alloc_whiteout(mnt_userns, target_dp, &wip);
 		if (error)
 			return error;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eca333f5f715..88ee4c3930ae 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -369,15 +369,18 @@ int		xfs_release(struct xfs_inode *ip);
 void		xfs_inactive(struct xfs_inode *ip);
 int		xfs_lookup(struct xfs_inode *dp, struct xfs_name *name,
 			   struct xfs_inode **ipp, struct xfs_name *ci_name);
-int		xfs_create(struct xfs_inode *dp, struct xfs_name *name,
+int		xfs_create(struct user_namespace *mnt_userns,
+			   struct xfs_inode *dp, struct xfs_name *name,
 			   umode_t mode, dev_t rdev, struct xfs_inode **ipp);
-int		xfs_create_tmpfile(struct xfs_inode *dp, umode_t mode,
+int		xfs_create_tmpfile(struct user_namespace *mnt_userns,
+			   struct xfs_inode *dp, umode_t mode,
 			   struct xfs_inode **ipp);
 int		xfs_remove(struct xfs_inode *dp, struct xfs_name *name,
 			   struct xfs_inode *ip);
 int		xfs_link(struct xfs_inode *tdp, struct xfs_inode *sip,
 			 struct xfs_name *target_name);
-int		xfs_rename(struct xfs_inode *src_dp, struct xfs_name *src_name,
+int		xfs_rename(struct user_namespace *mnt_userns,
+			   struct xfs_inode *src_dp, struct xfs_name *src_name,
 			   struct xfs_inode *src_ip, struct xfs_inode *target_dp,
 			   struct xfs_name *target_name,
 			   struct xfs_inode *target_ip, unsigned int flags);
@@ -407,9 +410,10 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
 xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
 xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
 
-int xfs_dir_ialloc(struct xfs_trans **tpp, struct xfs_inode *dp, umode_t mode,
-		   xfs_nlink_t nlink, dev_t dev, prid_t prid,
-		   struct xfs_inode **ipp);
+int		xfs_dir_ialloc(struct user_namespace *mnt_userns,
+			       struct xfs_trans **tpp, struct xfs_inode *dp,
+			       umode_t mode, xfs_nlink_t nlink, dev_t dev,
+			       prid_t prid, struct xfs_inode **ipp);
 
 static inline int
 xfs_itruncate_extents(
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 218e80afc859..3d4c7ca080fb 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -693,7 +693,8 @@ xfs_ioc_space(
 
 	iattr.ia_valid = ATTR_SIZE;
 	iattr.ia_size = bf->l_start;
-	error = xfs_vn_setattr_size(file_dentry(filp), &iattr);
+	error = xfs_vn_setattr_size(file_mnt_user_ns(filp), file_dentry(filp),
+				    &iattr);
 	if (error)
 		goto out_unlock;
 
@@ -734,13 +735,15 @@ xfs_fsinumbers_fmt(
 
 STATIC int
 xfs_ioc_fsbulkstat(
-	xfs_mount_t		*mp,
+	struct file		*file,
 	unsigned int		cmd,
 	void			__user *arg)
 {
+	struct xfs_mount	*mp = XFS_I(file_inode(file))->i_mount;
 	struct xfs_fsop_bulkreq	bulkreq;
 	struct xfs_ibulk	breq = {
 		.mp		= mp,
+		.mnt_userns	= file_mnt_user_ns(file),
 		.ocount		= 0,
 	};
 	xfs_ino_t		lastino;
@@ -908,13 +911,15 @@ xfs_bulk_ireq_teardown(
 /* Handle the v5 bulkstat ioctl. */
 STATIC int
 xfs_ioc_bulkstat(
-	struct xfs_mount		*mp,
+	struct file			*file,
 	unsigned int			cmd,
 	struct xfs_bulkstat_req __user	*arg)
 {
+	struct xfs_mount		*mp = XFS_I(file_inode(file))->i_mount;
 	struct xfs_bulk_ireq		hdr;
 	struct xfs_ibulk		breq = {
 		.mp			= mp,
+		.mnt_userns		= file_mnt_user_ns(file),
 	};
 	int				error;
 
@@ -1275,8 +1280,9 @@ xfs_ioctl_setattr_prepare_dax(
  */
 static struct xfs_trans *
 xfs_ioctl_setattr_get_trans(
-	struct xfs_inode	*ip)
+	struct file		*file)
 {
+	struct xfs_inode	*ip = XFS_I(file_inode(file));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	int			error = -EROFS;
@@ -1300,7 +1306,7 @@ xfs_ioctl_setattr_get_trans(
 	 * The user ID of the calling process must be equal to the file owner
 	 * ID, except in cases where the CAP_FSETID capability is applicable.
 	 */
-	if (!inode_owner_or_capable(&init_user_ns, VFS_I(ip))) {
+	if (!inode_owner_or_capable(file_mnt_user_ns(file), VFS_I(ip))) {
 		error = -EPERM;
 		goto out_cancel;
 	}
@@ -1428,9 +1434,11 @@ xfs_ioctl_setattr_check_projid(
 
 STATIC int
 xfs_ioctl_setattr(
-	xfs_inode_t		*ip,
+	struct file		*file,
 	struct fsxattr		*fa)
 {
+	struct user_namespace	*mnt_userns = file_mnt_user_ns(file);
+	struct xfs_inode	*ip = XFS_I(file_inode(file));
 	struct fsxattr		old_fa;
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -1462,7 +1470,7 @@ xfs_ioctl_setattr(
 
 	xfs_ioctl_setattr_prepare_dax(ip, fa);
 
-	tp = xfs_ioctl_setattr_get_trans(ip);
+	tp = xfs_ioctl_setattr_get_trans(file);
 	if (IS_ERR(tp)) {
 		code = PTR_ERR(tp);
 		goto error_free_dquots;
@@ -1502,7 +1510,7 @@ xfs_ioctl_setattr(
 	 */
 
 	if ((VFS_I(ip)->i_mode & (S_ISUID|S_ISGID)) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, VFS_I(ip), CAP_FSETID))
+	    !capable_wrt_inode_uidgid(mnt_userns, VFS_I(ip), CAP_FSETID))
 		VFS_I(ip)->i_mode &= ~(S_ISUID|S_ISGID);
 
 	/* Change the ownerships and register project quota modifications */
@@ -1549,7 +1557,6 @@ xfs_ioctl_setattr(
 
 STATIC int
 xfs_ioc_fssetxattr(
-	xfs_inode_t		*ip,
 	struct file		*filp,
 	void			__user *arg)
 {
@@ -1562,7 +1569,7 @@ xfs_ioc_fssetxattr(
 	error = mnt_want_write_file(filp);
 	if (error)
 		return error;
-	error = xfs_ioctl_setattr(ip, &fa);
+	error = xfs_ioctl_setattr(filp, &fa);
 	mnt_drop_write_file(filp);
 	return error;
 }
@@ -1608,7 +1615,7 @@ xfs_ioc_setxflags(
 
 	xfs_ioctl_setattr_prepare_dax(ip, &fa);
 
-	tp = xfs_ioctl_setattr_get_trans(ip);
+	tp = xfs_ioctl_setattr_get_trans(filp);
 	if (IS_ERR(tp)) {
 		error = PTR_ERR(tp);
 		goto out_drop_write;
@@ -2119,10 +2126,10 @@ xfs_file_ioctl(
 	case XFS_IOC_FSBULKSTAT_SINGLE:
 	case XFS_IOC_FSBULKSTAT:
 	case XFS_IOC_FSINUMBERS:
-		return xfs_ioc_fsbulkstat(mp, cmd, arg);
+		return xfs_ioc_fsbulkstat(filp, cmd, arg);
 
 	case XFS_IOC_BULKSTAT:
-		return xfs_ioc_bulkstat(mp, cmd, arg);
+		return xfs_ioc_bulkstat(filp, cmd, arg);
 	case XFS_IOC_INUMBERS:
 		return xfs_ioc_inumbers(mp, cmd, arg);
 
@@ -2144,7 +2151,7 @@ xfs_file_ioctl(
 	case XFS_IOC_FSGETXATTRA:
 		return xfs_ioc_fsgetxattr(ip, 1, arg);
 	case XFS_IOC_FSSETXATTR:
-		return xfs_ioc_fssetxattr(ip, filp, arg);
+		return xfs_ioc_fssetxattr(filp, arg);
 	case XFS_IOC_GETXFLAGS:
 		return xfs_ioc_getxflags(ip, arg);
 	case XFS_IOC_SETXFLAGS:
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index c1771e728117..926427b19573 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -209,14 +209,16 @@ xfs_fsbulkstat_one_fmt_compat(
 /* copied from xfs_ioctl.c */
 STATIC int
 xfs_compat_ioc_fsbulkstat(
-	xfs_mount_t		  *mp,
+	struct file		*file,
 	unsigned int		  cmd,
 	struct compat_xfs_fsop_bulkreq __user *p32)
 {
+	struct xfs_mount	*mp = XFS_I(file_inode(file))->i_mount;
 	u32			addr;
 	struct xfs_fsop_bulkreq	bulkreq;
 	struct xfs_ibulk	breq = {
 		.mp		= mp,
+		.mnt_userns	= file_mnt_user_ns(file),
 		.ocount		= 0,
 	};
 	xfs_ino_t		lastino;
@@ -507,7 +509,7 @@ xfs_file_compat_ioctl(
 	case XFS_IOC_FSBULKSTAT_32:
 	case XFS_IOC_FSBULKSTAT_SINGLE_32:
 	case XFS_IOC_FSINUMBERS_32:
-		return xfs_compat_ioc_fsbulkstat(mp, cmd, arg);
+		return xfs_compat_ioc_fsbulkstat(filp, cmd, arg);
 	case XFS_IOC_FD_TO_HANDLE_32:
 	case XFS_IOC_PATH_TO_HANDLE_32:
 	case XFS_IOC_PATH_TO_FSHANDLE_32: {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f5dfa128af64..816a0f77a39f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -128,6 +128,7 @@ xfs_cleanup_inode(
 
 STATIC int
 xfs_generic_create(
+	struct user_namespace	*mnt_userns,
 	struct inode	*dir,
 	struct dentry	*dentry,
 	umode_t		mode,
@@ -161,9 +162,10 @@ xfs_generic_create(
 		goto out_free_acl;
 
 	if (!tmpfile) {
-		error = xfs_create(XFS_I(dir), &name, mode, rdev, &ip);
+		error = xfs_create(mnt_userns, XFS_I(dir), &name, mode, rdev,
+				   &ip);
 	} else {
-		error = xfs_create_tmpfile(XFS_I(dir), mode, &ip);
+		error = xfs_create_tmpfile(mnt_userns, XFS_I(dir), mode, &ip);
 	}
 	if (unlikely(error))
 		goto out_free_acl;
@@ -226,7 +228,7 @@ xfs_vn_mknod(
 	umode_t			mode,
 	dev_t			rdev)
 {
-	return xfs_generic_create(dir, dentry, mode, rdev, false);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode, rdev, false);
 }
 
 STATIC int
@@ -237,7 +239,7 @@ xfs_vn_create(
 	umode_t			mode,
 	bool			flags)
 {
-	return xfs_generic_create(dir, dentry, mode, 0, false);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, false);
 }
 
 STATIC int
@@ -247,7 +249,8 @@ xfs_vn_mkdir(
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return xfs_generic_create(dir, dentry, mode | S_IFDIR, 0, false);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode | S_IFDIR, 0,
+				  false);
 }
 
 STATIC struct dentry *
@@ -381,7 +384,7 @@ xfs_vn_symlink(
 	if (unlikely(error))
 		goto out;
 
-	error = xfs_symlink(XFS_I(dir), &name, symname, mode, &cip);
+	error = xfs_symlink(mnt_userns, XFS_I(dir), &name, symname, mode, &cip);
 	if (unlikely(error))
 		goto out;
 
@@ -436,8 +439,8 @@ xfs_vn_rename(
 	if (unlikely(error))
 		return error;
 
-	return xfs_rename(XFS_I(odir), &oname, XFS_I(d_inode(odentry)),
-			  XFS_I(ndir), &nname,
+	return xfs_rename(mnt_userns, XFS_I(odir), &oname,
+			  XFS_I(d_inode(odentry)), XFS_I(ndir), &nname,
 			  new_inode ? XFS_I(new_inode) : NULL, flags);
 }
 
@@ -553,8 +556,8 @@ xfs_vn_getattr(
 	stat->dev = inode->i_sb->s_dev;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
-	stat->uid = inode->i_uid;
-	stat->gid = inode->i_gid;
+	stat->uid = i_uid_into_mnt(mnt_userns, inode);
+	stat->gid = i_gid_into_mnt(mnt_userns, inode);
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
@@ -632,8 +635,9 @@ xfs_setattr_time(
 
 static int
 xfs_vn_change_ok(
-	struct dentry	*dentry,
-	struct iattr	*iattr)
+	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
+	struct iattr		*iattr)
 {
 	struct xfs_mount	*mp = XFS_I(d_inode(dentry))->i_mount;
 
@@ -643,7 +647,7 @@ xfs_vn_change_ok(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	return setattr_prepare(&init_user_ns, dentry, iattr);
+	return setattr_prepare(mnt_userns, dentry, iattr);
 }
 
 /*
@@ -654,6 +658,7 @@ xfs_vn_change_ok(
  */
 static int
 xfs_setattr_nonsize(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
 {
@@ -813,7 +818,7 @@ xfs_setattr_nonsize(
 	 * 	     Posix ACL code seems to care about this issue either.
 	 */
 	if (mask & ATTR_MODE) {
-		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+		error = posix_acl_chmod(mnt_userns, inode, inode->i_mode);
 		if (error)
 			return error;
 	}
@@ -837,6 +842,7 @@ xfs_setattr_nonsize(
  */
 STATIC int
 xfs_setattr_size(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*ip,
 	struct iattr		*iattr)
 {
@@ -868,7 +874,7 @@ xfs_setattr_size(
 		 * Use the regular setattr path to update the timestamps.
 		 */
 		iattr->ia_valid &= ~ATTR_SIZE;
-		return xfs_setattr_nonsize(ip, iattr);
+		return xfs_setattr_nonsize(mnt_userns, ip, iattr);
 	}
 
 	/*
@@ -1037,6 +1043,7 @@ xfs_setattr_size(
 
 int
 xfs_vn_setattr_size(
+	struct user_namespace	*mnt_userns,
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
@@ -1045,10 +1052,10 @@ xfs_vn_setattr_size(
 
 	trace_xfs_setattr(ip);
 
-	error = xfs_vn_change_ok(dentry, iattr);
+	error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
 	if (error)
 		return error;
-	return xfs_setattr_size(ip, iattr);
+	return xfs_setattr_size(mnt_userns, ip, iattr);
 }
 
 STATIC int
@@ -1073,14 +1080,14 @@ xfs_vn_setattr(
 			return error;
 		}
 
-		error = xfs_vn_setattr_size(dentry, iattr);
+		error = xfs_vn_setattr_size(mnt_userns, dentry, iattr);
 		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
 	} else {
 		trace_xfs_setattr(ip);
 
-		error = xfs_vn_change_ok(dentry, iattr);
+		error = xfs_vn_change_ok(mnt_userns, dentry, iattr);
 		if (!error)
-			error = xfs_setattr_nonsize(ip, iattr);
+			error = xfs_setattr_nonsize(mnt_userns, ip, iattr);
 	}
 
 	return error;
@@ -1156,7 +1163,7 @@ xfs_vn_tmpfile(
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return xfs_generic_create(dir, dentry, mode, 0, true);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, true);
 }
 
 static const struct inode_operations xfs_inode_operations = {
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 99ca745c1071..278949056048 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -14,6 +14,7 @@ extern const struct file_operations xfs_dir_file_operations;
 extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
 
 extern void xfs_setattr_time(struct xfs_inode *ip, struct iattr *iattr);
-extern int xfs_vn_setattr_size(struct dentry *dentry, struct iattr *vap);
+int xfs_vn_setattr_size(struct user_namespace *mnt_userns,
+		struct dentry *dentry, struct iattr *vap);
 
 #endif /* __XFS_IOPS_H__ */
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index 16ca97a7ff00..ca310a125d1e 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -54,10 +54,12 @@ struct xfs_bstat_chunk {
 STATIC int
 xfs_bulkstat_one_int(
 	struct xfs_mount	*mp,
+	struct user_namespace	*mnt_userns,
 	struct xfs_trans	*tp,
 	xfs_ino_t		ino,
 	struct xfs_bstat_chunk	*bc)
 {
+	struct user_namespace	*sb_userns = mp->m_super->s_user_ns;
 	struct xfs_icdinode	*dic;		/* dinode core info pointer */
 	struct xfs_inode	*ip;		/* incore inode pointer */
 	struct inode		*inode;
@@ -86,8 +88,8 @@ xfs_bulkstat_one_int(
 	 */
 	buf->bs_projectid = ip->i_d.di_projid;
 	buf->bs_ino = ino;
-	buf->bs_uid = i_uid_read(inode);
-	buf->bs_gid = i_gid_read(inode);
+	buf->bs_uid = from_kuid(sb_userns, i_uid_into_mnt(mnt_userns, inode));
+	buf->bs_gid = from_kgid(sb_userns, i_gid_into_mnt(mnt_userns, inode));
 	buf->bs_size = dic->di_size;
 
 	buf->bs_nlink = inode->i_nlink;
@@ -173,7 +175,8 @@ xfs_bulkstat_one(
 	if (!bc.buf)
 		return -ENOMEM;
 
-	error = xfs_bulkstat_one_int(breq->mp, NULL, breq->startino, &bc);
+	error = xfs_bulkstat_one_int(breq->mp, breq->mnt_userns, NULL,
+				     breq->startino, &bc);
 
 	kmem_free(bc.buf);
 
@@ -194,9 +197,10 @@ xfs_bulkstat_iwalk(
 	xfs_ino_t		ino,
 	void			*data)
 {
+	struct xfs_bstat_chunk	*bc = data;
 	int			error;
 
-	error = xfs_bulkstat_one_int(mp, tp, ino, data);
+	error = xfs_bulkstat_one_int(mp, bc->breq->mnt_userns, tp, ino, data);
 	/* bulkstat just skips over missing inodes */
 	if (error == -ENOENT || error == -EINVAL)
 		return 0;
@@ -239,6 +243,11 @@ xfs_bulkstat(
 	};
 	int			error;
 
+	if (breq->mnt_userns != &init_user_ns) {
+		xfs_warn_ratelimited(breq->mp,
+			"bulkstat not supported inside of idmapped mounts.");
+		return -EINVAL;
+	}
 	if (xfs_bulkstat_already_done(breq->mp, breq->startino))
 		return 0;
 
diff --git a/fs/xfs/xfs_itable.h b/fs/xfs/xfs_itable.h
index 96a1e2a9be3f..7078d10c9b12 100644
--- a/fs/xfs/xfs_itable.h
+++ b/fs/xfs/xfs_itable.h
@@ -8,6 +8,7 @@
 /* In-memory representation of a userspace request for batch inode data. */
 struct xfs_ibulk {
 	struct xfs_mount	*mp;
+	struct user_namespace   *mnt_userns;
 	void __user		*ubuffer; /* user output buffer */
 	xfs_ino_t		startino; /* start with this inode */
 	unsigned int		icount;   /* number of elements in ubuffer */
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index c134eb4aeaa8..1b7b1393cab2 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -787,7 +787,8 @@ xfs_qm_qino_alloc(
 		return error;
 
 	if (need_alloc) {
-		error = xfs_dir_ialloc(&tp, NULL, S_IFREG, 1, 0, 0, ipp);
+		error = xfs_dir_ialloc(&init_user_ns, &tp, NULL, S_IFREG, 1, 0,
+				       0, ipp);
 		if (error) {
 			xfs_trans_cancel(tp);
 			return error;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 813be879a5e5..e95c1eff95e0 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1912,7 +1912,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("xfs");
 
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 1f43fd7f3209..77c8ea3229f1 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -134,6 +134,7 @@ xfs_readlink(
 
 int
 xfs_symlink(
+	struct user_namespace	*mnt_userns,
 	struct xfs_inode	*dp,
 	struct xfs_name		*link_name,
 	const char		*target_path,
@@ -223,8 +224,8 @@ xfs_symlink(
 	/*
 	 * Allocate an inode for the symlink.
 	 */
-	error = xfs_dir_ialloc(&tp, dp, S_IFLNK | (mode & ~S_IFMT), 1, 0,
-			       prid, &ip);
+	error = xfs_dir_ialloc(mnt_userns, &tp, dp, S_IFLNK | (mode & ~S_IFMT),
+			       1, 0, prid, &ip);
 	if (error)
 		goto out_trans_cancel;
 
diff --git a/fs/xfs/xfs_symlink.h b/fs/xfs/xfs_symlink.h
index b1fa091427e6..2586b7e393f3 100644
--- a/fs/xfs/xfs_symlink.h
+++ b/fs/xfs/xfs_symlink.h
@@ -7,8 +7,9 @@
 
 /* Kernel only symlink definitions */
 
-int xfs_symlink(struct xfs_inode *dp, struct xfs_name *link_name,
-		const char *target_path, umode_t mode, struct xfs_inode **ipp);
+int xfs_symlink(struct user_namespace *mnt_userns, struct xfs_inode *dp,
+		struct xfs_name *link_name, const char *target_path,
+		umode_t mode, struct xfs_inode **ipp);
 int xfs_readlink_bmap_ilocked(struct xfs_inode *ip, char *link);
 int xfs_readlink(struct xfs_inode *ip, char *link);
 int xfs_inactive_symlink(struct xfs_inode *ip);
-- 
2.30.0

