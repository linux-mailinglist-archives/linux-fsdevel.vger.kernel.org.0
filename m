Return-Path: <linux-fsdevel+bounces-15093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C5886F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580BBB2296E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4C4DA04;
	Fri, 22 Mar 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aD2x6u1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421F4D9FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120226; cv=none; b=ZCJJDC+2YJoTEqx3TEDV67SeY4Fc1HtI+K+MeMfNbJ/7M26nEw3TvJr/zropKDUgigg9vN/zfabFuGd5U8yOtdEvhzzOoMMWmeSNWo9vPtfuixuKz01dGRq6QVSzcdmHlVxYYnViMuPVk2g20Puc3rjuJM4bkt4gK46hvIaG9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120226; c=relaxed/simple;
	bh=+Hidl1ehKUSK8ydVzl55FyxdRreg3sym0kYT+TQBai8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rv2xGMa4wmlkYLB2SpwR89hVBeZFjpbnuuCvaiX7j5yZBJg+yl1i24ov48fwWyW4bTWkFUPWodT0e6HS5MJOcIAetob+ysCQOblwNzogtTOJVj2A25q4VFnlBfCt98W6vN+uzSMR+gIhsbsvc+wt28ubg2piQLDBoaHecdldrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aD2x6u1b; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609f2920b53so35231427b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120223; x=1711725023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrMfPjDTmime8VPkqMYXqjoi2kkgDssgVWNi4eoAsFo=;
        b=aD2x6u1b6VdYdGYiRrVrpmc1iOK2RVDAKOd0pSWe080t8eXDPvpdpSDSF/oAAf4Lwy
         qZYvTV45HnOxbj9A+PZVkJ0Z7H/NQYnzhNu0Rg5kk8D6KIuRJVEgk7nyaHNcTroduxVV
         4UdX4pJXlShqVOdbQGe7Nzom8Qbl3cIxuWgSoMKO2EZMJNasrGs9djN4NRXa1tbrHP8o
         Cb2pqxl/r4X07sH5UVFRjsrcXUBV8BqeVPEURl3Ru++KGo9eLDY7fS0d4uDu8+fMj9Mn
         GYQWDlDpHd9uJ75nO5LISCdx1o1yJoNqQFNz0IW3MAy2NGh5c/7WpYV7oE17bTWehFb7
         bhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120223; x=1711725023;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrMfPjDTmime8VPkqMYXqjoi2kkgDssgVWNi4eoAsFo=;
        b=jNVF26DPmmQCjZbkAdVaTCGRvqPo3VNgOftNpxkUoACIdDkD+id5jLXGIKnsAgHORk
         Y5xGKu4b4iRTE1KfYk1Mk8x7ym2bkeac4SXs6eJV+DoCOSR8pUVIsIPpc4uCLEIvQ226
         7xXaM157znj4JTLXxXY+a5id0ruDxvXCWTCrsARF1sawziyY8V5bL8YNKJ6LgpgGZMVY
         jt1B+fZ+saNgx+ffwkAmA+IiZRFsgyLyiIS1wm68hOr26+vKDFl5BaOk7IkZj1YGXYOk
         mlAQrvNRnAt2TstF7CcB3J6eVOOCbWi7c653jnAkD48lAKAKX9rt+Ffy9pEhZjU+SV9d
         OnlA==
X-Forwarded-Encrypted: i=1; AJvYcCVUddpun3fLOxo6nnH6nptaBcK31Z+Aq9u5IGvi2plkxaYzMmzwH5NgIBBQXGajLvCLnVrjLP8W0VdKgj/2krrJ29vLonVuAOcOpZga/A==
X-Gm-Message-State: AOJu0YzjS94wzqarKN8V81MwzkAD5NFaTCj+nsu9p6hIDVimkUZtN+G8
	wcalo5IsrxENvbEiVYLTz+mTLg1R4Cx5ByrhihZE6XHI/uTWKuMs6XIlRqv/WaFbIrkafMm9PpH
	C8A==
X-Google-Smtp-Source: AGHT+IGlES/YNQ9UCh4CUNIF73oHCTUaMPNnteBer91iiVVUBqjuPX3EV2H6/jWDpiW9Dn/g7KKRRLWqLIA=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:5213:0:b0:610:ee9b:430c with SMTP id
 g19-20020a815213000000b00610ee9b430cmr627465ywb.5.1711120223243; Fri, 22 Mar
 2024 08:10:23 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:54 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-2-gnoack@google.com>
Subject: [PATCH v11 1/9] fs: Add and use vfs_get_ioctl_handler()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

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
Cc: G=C3=BCnther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/r/20240219183539.2926165-1-mic@digikod.net [1=
]
Link: https://lore.kernel.org/r/20240309075320.160128-2-gnoack@google.com [=
2]
Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---
 fs/ioctl.c         | 213 +++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |   6 ++
 2 files changed, 155 insertions(+), 64 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..d2b6691ded16 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -56,8 +56,9 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsig=
ned long arg)
 }
 EXPORT_SYMBOL(vfs_ioctl);
=20
-static int ioctl_fibmap(struct file *filp, int __user *p)
+static int ioctl_fibmap(struct file *filp, unsigned int fd, unsigned long =
arg)
 {
+	int __user *p =3D (void __user *)arg;
 	struct inode *inode =3D file_inode(filp);
 	struct super_block *sb =3D inode->i_sb;
 	int error, ur_block;
@@ -197,11 +198,12 @@ int fiemap_prep(struct inode *inode, struct fiemap_ex=
tent_info *fieinfo,
 }
 EXPORT_SYMBOL(fiemap_prep);
=20
-static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
+static int ioctl_fiemap(struct file *filp, unsigned int fd, unsigned long =
arg)
 {
 	struct fiemap fiemap;
 	struct fiemap_extent_info fieinfo =3D { 0, };
 	struct inode *inode =3D file_inode(filp);
+	struct fiemap __user *ufiemap =3D (void __user *)arg;
 	int error;
=20
 	if (!inode->i_op->fiemap)
@@ -228,6 +230,18 @@ static int ioctl_fiemap(struct file *filp, struct fiem=
ap __user *ufiemap)
 	return error;
 }
=20
+static int ioctl_figetbsz(struct file *file, unsigned int fd, unsigned lon=
g arg)
+{
+	struct inode *inode =3D file_inode(file);
+	int __user *argp =3D (void __user *)arg;
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
@@ -249,9 +263,15 @@ static long ioctl_file_clone(struct file *dst_file, un=
signed long srcfd,
 	return ret;
 }
=20
-static long ioctl_file_clone_range(struct file *file,
-				   struct file_clone_range __user *argp)
+static int ioctl_ficlone(struct file *file, unsigned int fd, unsigned long=
 arg)
+{
+	return ioctl_file_clone(file, arg, 0, 0, 0);
+}
+
+static int ioctl_file_clone_range(struct file *file, unsigned int fd,
+				  unsigned long arg)
 {
+	struct file_clone_range __user *argp =3D (void __user *)arg;
 	struct file_clone_range args;
=20
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -292,6 +312,27 @@ static int ioctl_preallocate(struct file *filp, int mo=
de, void __user *argp)
 			sr.l_len);
 }
=20
+static int ioctl_resvsp(struct file *filp, unsigned int fd, unsigned long =
arg)
+{
+	int __user *p =3D (void __user *)arg;
+
+	return ioctl_preallocate(filp, 0, p);
+}
+
+static int ioctl_unresvsp(struct file *filp, unsigned int fd, unsigned lon=
g arg)
+{
+	int __user *p =3D (void __user *)arg;
+
+	return ioctl_preallocate(filp, FALLOC_FL_PUNCH_HOLE, p);
+}
+
+static int ioctl_zero_range(struct file *filp, unsigned int fd, unsigned l=
ong arg)
+{
+	int __user *p =3D (void __user *)arg;
+
+	return ioctl_preallocate(filp, FALLOC_FL_ZERO_RANGE, p);
+}
+
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined CONFIG_COMPAT && defined(CONFIG_X86_64)
 /* just account for different alignment */
@@ -321,28 +362,41 @@ static int compat_ioctl_preallocate(struct file *file=
, int mode,
 }
 #endif
=20
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
=20
-	return -ENOIOCTLCMD;
+	return NULL;
+}
+
+static int ioctl_fioclex(struct file *file, unsigned int fd, unsigned long=
 arg)
+{
+	set_close_on_exec(fd, 1);
+	return 0;
+}
+
+static int ioctl_fionclex(struct file *file, unsigned int fd, unsigned lon=
g arg)
+{
+	set_close_on_exec(fd, 0);
+	return 0;
 }
=20
-static int ioctl_fionbio(struct file *filp, int __user *argp)
+static int ioctl_fionbio(struct file *filp, unsigned int fd, unsigned long=
 arg)
 {
 	unsigned int flag;
 	int on, error;
+	int __user *argp =3D (void __user *)arg;
=20
 	error =3D get_user(on, argp);
 	if (error)
@@ -362,11 +416,11 @@ static int ioctl_fionbio(struct file *filp, int __use=
r *argp)
 	return error;
 }
=20
-static int ioctl_fioasync(unsigned int fd, struct file *filp,
-			  int __user *argp)
+static int ioctl_fioasync(struct file *filp, unsigned int fd, unsigned lon=
g arg)
 {
 	unsigned int flag;
 	int on, error;
+	int __user *argp =3D (void __user *)arg;
=20
 	error =3D get_user(on, argp);
 	if (error)
@@ -384,7 +438,22 @@ static int ioctl_fioasync(unsigned int fd, struct file=
 *filp,
 	return error < 0 ? error : 0;
 }
=20
-static int ioctl_fsfreeze(struct file *filp)
+static int ioctl_fioqsize(struct file *file, unsigned int fd, unsigned lon=
g arg)
+{
+	struct inode *inode =3D file_inode(file);
+	void __user *argp =3D (void __user *)arg;
+
+	if (S_ISDIR(inode->i_mode) || S_ISREG(inode->i_mode) ||
+	    S_ISLNK(inode->i_mode)) {
+		loff_t res =3D inode_get_bytes(inode);
+
+		return copy_to_user(argp, &res, sizeof(res)) ? -EFAULT : 0;
+	}
+
+	return -ENOTTY;
+}
+
+static int ioctl_fsfreeze(struct file *filp, unsigned int fd, unsigned lon=
g arg)
 {
 	struct super_block *sb =3D file_inode(filp)->i_sb;
=20
@@ -401,7 +470,7 @@ static int ioctl_fsfreeze(struct file *filp)
 	return freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 }
=20
-static int ioctl_fsthaw(struct file *filp)
+static int ioctl_fsthaw(struct file *filp, unsigned int fd, unsigned long =
arg)
 {
 	struct super_block *sb =3D file_inode(filp)->i_sb;
=20
@@ -414,9 +483,9 @@ static int ioctl_fsthaw(struct file *filp)
 	return thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 }
=20
-static int ioctl_file_dedupe_range(struct file *file,
-				   struct file_dedupe_range __user *argp)
+static int ioctl_file_dedupe_range(struct file *file, unsigned int fd, uns=
igned long arg)
 {
+	struct file_dedupe_range __user *argp =3D (void __user *)arg;
 	struct file_dedupe_range *same =3D NULL;
 	int ret;
 	unsigned long size;
@@ -454,6 +523,14 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
=20
+static int ioctl_fionread(struct file *filp, unsigned int fd, unsigned lon=
g arg)
+{
+	int __user *argp =3D (void __user *)arg;
+	struct inode *inode =3D file_inode(filp);
+
+	return put_user(i_size_read(inode) - filp->f_pos, argp);
+}
+
 /**
  * fileattr_fill_xflags - initialize fileattr with xflags
  * @fa:		fileattr pointer
@@ -702,8 +779,9 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct de=
ntry *dentry,
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
=20
-static int ioctl_getflags(struct file *file, unsigned int __user *argp)
+static int ioctl_getflags(struct file *file, unsigned int fd, unsigned lon=
g arg)
 {
+	unsigned int __user *argp =3D (void __user *)arg;
 	struct fileattr fa =3D { .flags_valid =3D true }; /* hint only */
 	int err;
=20
@@ -713,8 +791,9 @@ static int ioctl_getflags(struct file *file, unsigned i=
nt __user *argp)
 	return err;
 }
=20
-static int ioctl_setflags(struct file *file, unsigned int __user *argp)
+static int ioctl_setflags(struct file *file, unsigned int fd, unsigned lon=
g arg)
 {
+	unsigned int __user *argp =3D (void __user *)arg;
 	struct mnt_idmap *idmap =3D file_mnt_idmap(file);
 	struct dentry *dentry =3D file->f_path.dentry;
 	struct fileattr fa;
@@ -733,8 +812,9 @@ static int ioctl_setflags(struct file *file, unsigned i=
nt __user *argp)
 	return err;
 }
=20
-static int ioctl_fsgetxattr(struct file *file, void __user *argp)
+static int ioctl_fsgetxattr(struct file *file, unsigned int fd, unsigned l=
ong arg)
 {
+	struct fsxattr __user *argp =3D (void __user *)arg;
 	struct fileattr fa =3D { .fsx_valid =3D true }; /* hint only */
 	int err;
=20
@@ -745,8 +825,9 @@ static int ioctl_fsgetxattr(struct file *file, void __u=
ser *argp)
 	return err;
 }
=20
-static int ioctl_fssetxattr(struct file *file, void __user *argp)
+static int ioctl_fssetxattr(struct file *file, unsigned int fd, unsigned l=
ong arg)
 {
+	struct fsxattr __user *argp =3D (void __user *)arg;
 	struct mnt_idmap *idmap =3D file_mnt_idmap(file);
 	struct dentry *dentry =3D file->f_path.dentry;
 	struct fileattr fa;
@@ -764,94 +845,98 @@ static int ioctl_fssetxattr(struct file *file, void _=
_user *argp)
 }
=20
 /*
- * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL(=
)'d.
- * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
+ * Return NULL when no handler exists for @cmd, or the appropriate functio=
n
+ * otherwise.  This means that these handlers should never return -ENOIOCT=
LCMD.
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
  */
-static int do_vfs_ioctl(struct file *filp, unsigned int fd,
-			unsigned int cmd, unsigned long arg)
+ioctl_handler_t vfs_get_ioctl_handler(struct file *filp, unsigned int cmd)
 {
-	void __user *argp =3D (void __user *)arg;
-	struct inode *inode =3D file_inode(filp);
-
 	switch (cmd) {
 	case FIOCLEX:
-		set_close_on_exec(fd, 1);
-		return 0;
+		return ioctl_fioclex;
=20
 	case FIONCLEX:
-		set_close_on_exec(fd, 0);
-		return 0;
+		return ioctl_fionclex;
=20
 	case FIONBIO:
-		return ioctl_fionbio(filp, argp);
+		return ioctl_fionbio;
=20
 	case FIOASYNC:
-		return ioctl_fioasync(fd, filp, argp);
+		return ioctl_fioasync;
=20
 	case FIOQSIZE:
-		if (S_ISDIR(inode->i_mode) || S_ISREG(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode)) {
-			loff_t res =3D inode_get_bytes(inode);
-			return copy_to_user(argp, &res, sizeof(res)) ?
-					    -EFAULT : 0;
-		}
-
-		return -ENOTTY;
+		return ioctl_fioqsize;
=20
 	case FIFREEZE:
-		return ioctl_fsfreeze(filp);
+		return ioctl_fsfreeze;
=20
 	case FITHAW:
-		return ioctl_fsthaw(filp);
+		return ioctl_fsthaw;
=20
 	case FS_IOC_FIEMAP:
-		return ioctl_fiemap(filp, argp);
+		return ioctl_fiemap;
=20
 	case FIGETBSZ:
-		/* anon_bdev filesystems may not have a block size */
-		if (!inode->i_sb->s_blocksize)
-			return -EINVAL;
-
-		return put_user(inode->i_sb->s_blocksize, (int __user *)argp);
+		return ioctl_figetbsz;
=20
 	case FICLONE:
-		return ioctl_file_clone(filp, arg, 0, 0, 0);
+		return ioctl_ficlone;
=20
 	case FICLONERANGE:
-		return ioctl_file_clone_range(filp, argp);
+		return ioctl_file_clone_range;
=20
 	case FIDEDUPERANGE:
-		return ioctl_file_dedupe_range(filp, argp);
+		return ioctl_file_dedupe_range;
=20
 	case FIONREAD:
-		if (!S_ISREG(inode->i_mode))
-			return vfs_ioctl(filp, cmd, arg);
+		if (!S_ISREG(file_inode(filp)->i_mode))
+			break;
=20
-		return put_user(i_size_read(inode) - filp->f_pos,
-				(int __user *)argp);
+		return ioctl_fionread;
=20
 	case FS_IOC_GETFLAGS:
-		return ioctl_getflags(filp, argp);
+		return ioctl_getflags;
=20
 	case FS_IOC_SETFLAGS:
-		return ioctl_setflags(filp, argp);
+		return ioctl_setflags;
=20
 	case FS_IOC_FSGETXATTR:
-		return ioctl_fsgetxattr(filp, argp);
+		return ioctl_fsgetxattr;
=20
 	case FS_IOC_FSSETXATTR:
-		return ioctl_fssetxattr(filp, argp);
+		return ioctl_fssetxattr;
=20
 	default:
-		if (S_ISREG(inode->i_mode))
-			return file_ioctl(filp, cmd, argp);
+		if (S_ISREG(file_inode(filp)->i_mode))
+			return file_ioctl(cmd);
 		break;
 	}
=20
-	return -ENOIOCTLCMD;
+	/* Forwards call to vfs_ioctl(filp, cmd, arg) */
+	return NULL;
+}
+
+/*
+ * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL(=
)'d.
+ * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
+ */
+static int do_vfs_ioctl(struct file *filp, unsigned int fd,
+			unsigned int cmd, unsigned long arg)
+{
+	ioctl_handler_t handler =3D vfs_get_ioctl_handler(filp, cmd);
+	int ret;
+
+	if (!handler)
+		return -ENOIOCTLCMD;
+
+	ret =3D (*handler)(filp, fd, arg);
+	/* Makes sure handle() really handles this command. */
+	if (WARN_ON_ONCE(ret =3D=3D -ENOIOCTLCMD))
+		return -ENOTTY;
+
+	return ret;
 }
=20
 SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long,=
 arg)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..92bf421aae83 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1904,6 +1904,12 @@ extern long compat_ptr_ioctl(struct file *file, unsi=
gned int cmd,
 #define compat_ptr_ioctl NULL
 #endif
=20
+typedef int (*ioctl_handler_t)(struct file *file, unsigned int fd,
+			       unsigned long arg);
+
+extern ioctl_handler_t vfs_get_ioctl_handler(struct file *filp,
+					     unsigned int cmd);
+
 /*
  * VFS file helper functions.
  */
--=20
2.44.0.396.g6e790dbe36-goog


