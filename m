Return-Path: <linux-fsdevel+bounces-14475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4C87CFAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B56E1C2258F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4093C680;
	Fri, 15 Mar 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Lyfx3weT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A73E498
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514788; cv=none; b=ogBi67H2jcgS2Llx0LfHE6v9zDLxpY1RJkwjexZu3Rf9IF/escB6pBZMTuY8Yy1ULIeEhxGFXYtvVSbfxv4Q3PdcRxGO+w+Av2LM8fW3z/k1cnM5WflcslvShoXVIY7T0ow4QExKJvuk9YHpqoOIWjg1chrNmB0R6grUN45vChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514788; c=relaxed/simple;
	bh=wo/rwevH6BBPxAwOVWPsa+Y6SrIThf8W4tKxO+X738w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf7yQanLCG3+MPTehg9+WU97upwtNAnglCkci8DaawNTg1ScZ0QtVqnNYZEjpEKLOy2+9+ByyCmDeIaXwPZWJVYTvV9LYYs9Apm0YFtDafa0oEKzHQRVxFAsU+RCWqB0/8eZR5xhXrxCRpMtIrPnFmFDFkT05aR+Mmv/qmpjEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Lyfx3weT; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tx6pr53W6zVyn;
	Fri, 15 Mar 2024 15:59:32 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tx6pq5t2vzMpnPs;
	Fri, 15 Mar 2024 15:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710514772;
	bh=wo/rwevH6BBPxAwOVWPsa+Y6SrIThf8W4tKxO+X738w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lyfx3weTwSVYSBsYSCVKOZdIsnm/GsUf9IiSMJAWxNdJWw1koe4/C0+1JkKU5HxrZ
	 7FYN3laSL/4Eokd+jknWDTkA9PlclUo3SqbY1dt3rbggiJ94rwWSoiHqhTLxAMXMpN
	 C5kHJ21v57VucvhbaWBLqK7FWreH55oi2i+I8UXc=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH] fs: Add an use vfs_get_ioctl_handler()
Date: Fri, 15 Mar 2024 15:58:38 +0100
Message-ID: <20240315145848.1844554-1-mic@digikod.net>
In-Reply-To: <CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=tL1XhVdyg@mail.gmail.com>
References: <CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=tL1XhVdyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new vfs_get_ioctl_handler() helper to identify if an IOCTL command
is handled by the first IOCTL layer.  Each IOCTL command is now handled
by a dedicated function, and all of them use the same signature.

Apart from the VFS, this helper is also intended to be used by Landlock
to cleanly categorize VFS IOCTLs and create appropriate security
policies.

This is an alternative to a first RFC [1] and a proposal for a new LSM
hook [2].

By dereferencing some pointers only when required, this should also
slightly improve do_vfs_ioctl().

Remove (double) pointer castings on put_user() calls.

Remove potential double vfs_ioctl() call for FIONREAD.

Fix ioctl_file_clone_range() return type from long to int.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/r/20240219183539.2926165-1-mic@digikod.net [1]
Link: https://lore.kernel.org/r/20240309075320.160128-2-gnoack@google.com [2]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 fs/ioctl.c         | 213 +++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |   6 ++
 2 files changed, 155 insertions(+), 64 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..d2b6691ded16 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -56,8 +56,9 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(vfs_ioctl);
 
-static int ioctl_fibmap(struct file *filp, int __user *p)
+static int ioctl_fibmap(struct file *filp, unsigned int fd, unsigned long arg)
 {
+	int __user *p = (void __user *)arg;
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	int error, ur_block;
@@ -197,11 +198,12 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 }
 EXPORT_SYMBOL(fiemap_prep);
 
-static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
+static int ioctl_fiemap(struct file *filp, unsigned int fd, unsigned long arg)
 {
 	struct fiemap fiemap;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
+	struct fiemap __user *ufiemap = (void __user *)arg;
 	int error;
 
 	if (!inode->i_op->fiemap)
@@ -228,6 +230,18 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	return error;
 }
 
+static int ioctl_figetbsz(struct file *file, unsigned int fd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	int __user *argp = (void __user *)arg;
+
+	/* anon_bdev filesystems may not have a block size */
+	if (!inode->i_sb->s_blocksize)
+		return -EINVAL;
+
+	return put_user(inode->i_sb->s_blocksize, argp);
+}
+
 static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 			     u64 off, u64 olen, u64 destoff)
 {
@@ -249,9 +263,15 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	return ret;
 }
 
-static long ioctl_file_clone_range(struct file *file,
-				   struct file_clone_range __user *argp)
+static int ioctl_ficlone(struct file *file, unsigned int fd, unsigned long arg)
+{
+	return ioctl_file_clone(file, arg, 0, 0, 0);
+}
+
+static int ioctl_file_clone_range(struct file *file, unsigned int fd,
+				  unsigned long arg)
 {
+	struct file_clone_range __user *argp = (void __user *)arg;
 	struct file_clone_range args;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -292,6 +312,27 @@ static int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
 			sr.l_len);
 }
 
+static int ioctl_resvsp(struct file *filp, unsigned int fd, unsigned long arg)
+{
+	int __user *p = (void __user *)arg;
+
+	return ioctl_preallocate(filp, 0, p);
+}
+
+static int ioctl_unresvsp(struct file *filp, unsigned int fd, unsigned long arg)
+{
+	int __user *p = (void __user *)arg;
+
+	return ioctl_preallocate(filp, FALLOC_FL_PUNCH_HOLE, p);
+}
+
+static int ioctl_zero_range(struct file *filp, unsigned int fd, unsigned long arg)
+{
+	int __user *p = (void __user *)arg;
+
+	return ioctl_preallocate(filp, FALLOC_FL_ZERO_RANGE, p);
+}
+
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined CONFIG_COMPAT && defined(CONFIG_X86_64)
 /* just account for different alignment */
@@ -321,28 +362,41 @@ static int compat_ioctl_preallocate(struct file *file, int mode,
 }
 #endif
 
-static int file_ioctl(struct file *filp, unsigned int cmd, int __user *p)
+static ioctl_handler_t file_ioctl(unsigned int cmd)
 {
 	switch (cmd) {
 	case FIBMAP:
-		return ioctl_fibmap(filp, p);
+		return ioctl_fibmap;
 	case FS_IOC_RESVSP:
 	case FS_IOC_RESVSP64:
-		return ioctl_preallocate(filp, 0, p);
+		return ioctl_resvsp;
 	case FS_IOC_UNRESVSP:
 	case FS_IOC_UNRESVSP64:
-		return ioctl_preallocate(filp, FALLOC_FL_PUNCH_HOLE, p);
+		return ioctl_unresvsp;
 	case FS_IOC_ZERO_RANGE:
-		return ioctl_preallocate(filp, FALLOC_FL_ZERO_RANGE, p);
+		return ioctl_zero_range;
 	}
 
-	return -ENOIOCTLCMD;
+	return NULL;
+}
+
+static int ioctl_fioclex(struct file *file, unsigned int fd, unsigned long arg)
+{
+	set_close_on_exec(fd, 1);
+	return 0;
+}
+
+static int ioctl_fionclex(struct file *file, unsigned int fd, unsigned long arg)
+{
+	set_close_on_exec(fd, 0);
+	return 0;
 }
 
-static int ioctl_fionbio(struct file *filp, int __user *argp)
+static int ioctl_fionbio(struct file *filp, unsigned int fd, unsigned long arg)
 {
 	unsigned int flag;
 	int on, error;
+	int __user *argp = (void __user *)arg;
 
 	error = get_user(on, argp);
 	if (error)
@@ -362,11 +416,11 @@ static int ioctl_fionbio(struct file *filp, int __user *argp)
 	return error;
 }
 
-static int ioctl_fioasync(unsigned int fd, struct file *filp,
-			  int __user *argp)
+static int ioctl_fioasync(struct file *filp, unsigned int fd, unsigned long arg)
 {
 	unsigned int flag;
 	int on, error;
+	int __user *argp = (void __user *)arg;
 
 	error = get_user(on, argp);
 	if (error)
@@ -384,7 +438,22 @@ static int ioctl_fioasync(unsigned int fd, struct file *filp,
 	return error < 0 ? error : 0;
 }
 
-static int ioctl_fsfreeze(struct file *filp)
+static int ioctl_fioqsize(struct file *file, unsigned int fd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	void __user *argp = (void __user *)arg;
+
+	if (S_ISDIR(inode->i_mode) || S_ISREG(inode->i_mode) ||
+	    S_ISLNK(inode->i_mode)) {
+		loff_t res = inode_get_bytes(inode);
+
+		return copy_to_user(argp, &res, sizeof(res)) ? -EFAULT : 0;
+	}
+
+	return -ENOTTY;
+}
+
+static int ioctl_fsfreeze(struct file *filp, unsigned int fd, unsigned long arg)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
 
@@ -401,7 +470,7 @@ static int ioctl_fsfreeze(struct file *filp)
 	return freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
-static int ioctl_fsthaw(struct file *filp)
+static int ioctl_fsthaw(struct file *filp, unsigned int fd, unsigned long arg)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
 
@@ -414,9 +483,9 @@ static int ioctl_fsthaw(struct file *filp)
 	return thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
-static int ioctl_file_dedupe_range(struct file *file,
-				   struct file_dedupe_range __user *argp)
+static int ioctl_file_dedupe_range(struct file *file, unsigned int fd, unsigned long arg)
 {
+	struct file_dedupe_range __user *argp = (void __user *)arg;
 	struct file_dedupe_range *same = NULL;
 	int ret;
 	unsigned long size;
@@ -454,6 +523,14 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
 
+static int ioctl_fionread(struct file *filp, unsigned int fd, unsigned long arg)
+{
+	int __user *argp = (void __user *)arg;
+	struct inode *inode = file_inode(filp);
+
+	return put_user(i_size_read(inode) - filp->f_pos, argp);
+}
+
 /**
  * fileattr_fill_xflags - initialize fileattr with xflags
  * @fa:		fileattr pointer
@@ -702,8 +779,9 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
 
-static int ioctl_getflags(struct file *file, unsigned int __user *argp)
+static int ioctl_getflags(struct file *file, unsigned int fd, unsigned long arg)
 {
+	unsigned int __user *argp = (void __user *)arg;
 	struct fileattr fa = { .flags_valid = true }; /* hint only */
 	int err;
 
@@ -713,8 +791,9 @@ static int ioctl_getflags(struct file *file, unsigned int __user *argp)
 	return err;
 }
 
-static int ioctl_setflags(struct file *file, unsigned int __user *argp)
+static int ioctl_setflags(struct file *file, unsigned int fd, unsigned long arg)
 {
+	unsigned int __user *argp = (void __user *)arg;
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct fileattr fa;
@@ -733,8 +812,9 @@ static int ioctl_setflags(struct file *file, unsigned int __user *argp)
 	return err;
 }
 
-static int ioctl_fsgetxattr(struct file *file, void __user *argp)
+static int ioctl_fsgetxattr(struct file *file, unsigned int fd, unsigned long arg)
 {
+	struct fsxattr __user *argp = (void __user *)arg;
 	struct fileattr fa = { .fsx_valid = true }; /* hint only */
 	int err;
 
@@ -745,8 +825,9 @@ static int ioctl_fsgetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
-static int ioctl_fssetxattr(struct file *file, void __user *argp)
+static int ioctl_fssetxattr(struct file *file, unsigned int fd, unsigned long arg)
 {
+	struct fsxattr __user *argp = (void __user *)arg;
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct fileattr fa;
@@ -764,94 +845,98 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 }
 
 /*
- * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
- * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
+ * Return NULL when no handler exists for @cmd, or the appropriate function
+ * otherwise.  This means that these handlers should never return -ENOIOCTLCMD.
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
  */
-static int do_vfs_ioctl(struct file *filp, unsigned int fd,
-			unsigned int cmd, unsigned long arg)
+ioctl_handler_t vfs_get_ioctl_handler(struct file *filp, unsigned int cmd)
 {
-	void __user *argp = (void __user *)arg;
-	struct inode *inode = file_inode(filp);
-
 	switch (cmd) {
 	case FIOCLEX:
-		set_close_on_exec(fd, 1);
-		return 0;
+		return ioctl_fioclex;
 
 	case FIONCLEX:
-		set_close_on_exec(fd, 0);
-		return 0;
+		return ioctl_fionclex;
 
 	case FIONBIO:
-		return ioctl_fionbio(filp, argp);
+		return ioctl_fionbio;
 
 	case FIOASYNC:
-		return ioctl_fioasync(fd, filp, argp);
+		return ioctl_fioasync;
 
 	case FIOQSIZE:
-		if (S_ISDIR(inode->i_mode) || S_ISREG(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode)) {
-			loff_t res = inode_get_bytes(inode);
-			return copy_to_user(argp, &res, sizeof(res)) ?
-					    -EFAULT : 0;
-		}
-
-		return -ENOTTY;
+		return ioctl_fioqsize;
 
 	case FIFREEZE:
-		return ioctl_fsfreeze(filp);
+		return ioctl_fsfreeze;
 
 	case FITHAW:
-		return ioctl_fsthaw(filp);
+		return ioctl_fsthaw;
 
 	case FS_IOC_FIEMAP:
-		return ioctl_fiemap(filp, argp);
+		return ioctl_fiemap;
 
 	case FIGETBSZ:
-		/* anon_bdev filesystems may not have a block size */
-		if (!inode->i_sb->s_blocksize)
-			return -EINVAL;
-
-		return put_user(inode->i_sb->s_blocksize, (int __user *)argp);
+		return ioctl_figetbsz;
 
 	case FICLONE:
-		return ioctl_file_clone(filp, arg, 0, 0, 0);
+		return ioctl_ficlone;
 
 	case FICLONERANGE:
-		return ioctl_file_clone_range(filp, argp);
+		return ioctl_file_clone_range;
 
 	case FIDEDUPERANGE:
-		return ioctl_file_dedupe_range(filp, argp);
+		return ioctl_file_dedupe_range;
 
 	case FIONREAD:
-		if (!S_ISREG(inode->i_mode))
-			return vfs_ioctl(filp, cmd, arg);
+		if (!S_ISREG(file_inode(filp)->i_mode))
+			break;
 
-		return put_user(i_size_read(inode) - filp->f_pos,
-				(int __user *)argp);
+		return ioctl_fionread;
 
 	case FS_IOC_GETFLAGS:
-		return ioctl_getflags(filp, argp);
+		return ioctl_getflags;
 
 	case FS_IOC_SETFLAGS:
-		return ioctl_setflags(filp, argp);
+		return ioctl_setflags;
 
 	case FS_IOC_FSGETXATTR:
-		return ioctl_fsgetxattr(filp, argp);
+		return ioctl_fsgetxattr;
 
 	case FS_IOC_FSSETXATTR:
-		return ioctl_fssetxattr(filp, argp);
+		return ioctl_fssetxattr;
 
 	default:
-		if (S_ISREG(inode->i_mode))
-			return file_ioctl(filp, cmd, argp);
+		if (S_ISREG(file_inode(filp)->i_mode))
+			return file_ioctl(cmd);
 		break;
 	}
 
-	return -ENOIOCTLCMD;
+	/* Forwards call to vfs_ioctl(filp, cmd, arg) */
+	return NULL;
+}
+
+/*
+ * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
+ * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
+ */
+static int do_vfs_ioctl(struct file *filp, unsigned int fd,
+			unsigned int cmd, unsigned long arg)
+{
+	ioctl_handler_t handler = vfs_get_ioctl_handler(filp, cmd);
+	int ret;
+
+	if (!handler)
+		return -ENOIOCTLCMD;
+
+	ret = (*handler)(filp, fd, arg);
+	/* Makes sure handle() really handles this command. */
+	if (WARN_ON_ONCE(ret == -ENOIOCTLCMD))
+		return -ENOTTY;
+
+	return ret;
 }
 
 SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..92bf421aae83 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1904,6 +1904,12 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 #define compat_ptr_ioctl NULL
 #endif
 
+typedef int (*ioctl_handler_t)(struct file *file, unsigned int fd,
+			       unsigned long arg);
+
+extern ioctl_handler_t vfs_get_ioctl_handler(struct file *filp,
+					     unsigned int cmd);
+
 /*
  * VFS file helper functions.
  */
-- 
2.44.0


