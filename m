Return-Path: <linux-fsdevel+bounces-12044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964485AB8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7B1C215DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF40482F1;
	Mon, 19 Feb 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oDYpv9Hr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A344C93
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368739; cv=none; b=TE4hRvH4UBg4aPE1KVsM56PIrePZfECn4Ql1g2I0HRq9B6hqjgMT+9h6K+vHsBfRiXqJlWO1tz47NzzNxY7SSNt5VlOHMG3BRyt2lRiF6XkZ21yAXm/JGIBYg4WhcQlHAH8SMzjMkAF8nUfe92M+CAw9+l7ZD67vwx2x/P4/ioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368739; c=relaxed/simple;
	bh=LtcUU6QoB2T9dk2U3zzhOx/I7nbRYfllmXSBBlqQlWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reoShVjf3HTvToaUiaWps2jRjZAvEzPFOiONjhwhlWZiKagkRTunb9cfKXLbU/eY3eLrUkjWlTttvY32adqaKjQrKwKtnQHmRA35NCtdwIXN4o8E8bYf+97KGYMZVLqxAnwTpw2ABcZQTo44pLnTNy78xfYaKYk+FcasdW6EyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oDYpv9Hr; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tdrnw1cTpzMq2RS;
	Mon, 19 Feb 2024 19:35:48 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tdrnv4WF3zFC7;
	Mon, 19 Feb 2024 19:35:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708367748;
	bh=LtcUU6QoB2T9dk2U3zzhOx/I7nbRYfllmXSBBlqQlWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDYpv9HrNEoRL82LANtI9ExuvweHqhPn9MPAX+6qpbYyYxnvn1gD9rICI2Y5vQpN7
	 pvjKlSv2QK70bm/LN9SGl8u+Eb45RBGPPogR688MM+2qoSdq5HWWg6JQ5l4bECSflg
	 W4uzYm8ie/INPXIpE+Au4awoM+2/J5unKfc2Mi0Y=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Date: Mon, 19 Feb 2024 19:35:39 +0100
Message-ID: <20240219183539.2926165-1-mic@digikod.net>
In-Reply-To: <20240219.chu4Yeegh3oo@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
to differenciate between device driver IOCTL implementations and
filesystem ones.  The goal is to be able to filter well-defined IOCTLs
from per-device (i.e. namespaced) IOCTLs and control such access.

Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
compat_ioctl() calls and handle error conversions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
---
 fs/ioctl.c         | 101 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  12 ++++++
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..f72c8da47d21 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -763,6 +763,38 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
+/*
+ * Safeguard to maintain a list of valid IOCTLs handled by do_vfs_ioctl()
+ * instead of def_blk_fops or def_chr_fops (see init_special_inode).
+ */
+__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd)
+{
+	switch (cmd) {
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+	case FIOQSIZE:
+	case FIFREEZE:
+	case FITHAW:
+	case FS_IOC_FIEMAP:
+	case FIGETBSZ:
+	case FICLONE:
+	case FICLONERANGE:
+	case FIDEDUPERANGE:
+	/* FIONREAD is forwarded to device implementations. */
+	case FS_IOC_GETFLAGS:
+	case FS_IOC_SETFLAGS:
+	case FS_IOC_FSGETXATTR:
+	case FS_IOC_FSSETXATTR:
+	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(vfs_masked_device_ioctl);
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -858,6 +890,8 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 {
 	struct fd f = fdget(fd);
 	int error;
+	const struct inode *inode;
+	bool is_device;
 
 	if (!f.file)
 		return -EBADF;
@@ -866,9 +900,18 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 	if (error)
 		goto out;
 
+	inode = file_inode(f.file);
+	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
+	if (is_device && !vfs_masked_device_ioctl(cmd)) {
+		error = vfs_ioctl(f.file, cmd, arg);
+		goto out;
+	}
+
 	error = do_vfs_ioctl(f.file, fd, cmd, arg);
-	if (error == -ENOIOCTLCMD)
+	if (error == -ENOIOCTLCMD) {
+		WARN_ON_ONCE(is_device);
 		error = vfs_ioctl(f.file, cmd, arg);
+	}
 
 out:
 	fdput(f);
@@ -911,11 +954,49 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(compat_ptr_ioctl);
 
+static long ioctl_compat(struct file *filp, unsigned int cmd,
+			 compat_ulong_t arg)
+{
+	int error = -ENOTTY;
+
+	if (!filp->f_op->compat_ioctl)
+		goto out;
+
+	error = filp->f_op->compat_ioctl(filp, cmd, arg);
+	if (error == -ENOIOCTLCMD)
+		error = -ENOTTY;
+
+out:
+	return error;
+}
+
+__attribute_const__ bool vfs_masked_device_ioctl_compat(const unsigned int cmd)
+{
+	switch (cmd) {
+	case FICLONE:
+#if defined(CONFIG_X86_64)
+	case FS_IOC_RESVSP_32:
+	case FS_IOC_RESVSP64_32:
+	case FS_IOC_UNRESVSP_32:
+	case FS_IOC_UNRESVSP64_32:
+	case FS_IOC_ZERO_RANGE_32:
+#endif
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_SETFLAGS:
+		return true;
+	default:
+		return vfs_masked_device_ioctl(cmd);
+	}
+}
+EXPORT_SYMBOL(vfs_masked_device_ioctl_compat);
+
 COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		       compat_ulong_t, arg)
 {
 	struct fd f = fdget(fd);
 	int error;
+	const struct inode *inode;
+	bool is_device;
 
 	if (!f.file)
 		return -EBADF;
@@ -924,6 +1005,13 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (error)
 		goto out;
 
+	inode = file_inode(f.file);
+	is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
+	if (is_device && !vfs_masked_device_ioctl_compat(cmd)) {
+		error = ioctl_compat(f.file, cmd, arg);
+		goto out;
+	}
+
 	switch (cmd) {
 	/* FICLONE takes an int argument, so don't use compat_ptr() */
 	case FICLONE:
@@ -964,13 +1052,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	default:
 		error = do_vfs_ioctl(f.file, fd, cmd,
 				     (unsigned long)compat_ptr(arg));
-		if (error != -ENOIOCTLCMD)
-			break;
-
-		if (f.file->f_op->compat_ioctl)
-			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
-		if (error == -ENOIOCTLCMD)
-			error = -ENOTTY;
+		if (error == -ENOIOCTLCMD) {
+			WARN_ON_ONCE(is_device);
+			error = ioctl_compat(f.file, cmd, arg);
+		}
 		break;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..b620d0c00e16 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1902,6 +1902,18 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 #define compat_ptr_ioctl NULL
 #endif
 
+extern __attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd);
+#ifdef CONFIG_COMPAT
+extern __attribute_const__ bool
+vfs_masked_device_ioctl_compat(const unsigned int cmd);
+#else /* CONFIG_COMPAT */
+static inline __attribute_const__ bool
+vfs_masked_device_ioctl_compat(const unsigned int cmd)
+{
+	return vfs_masked_device_ioctl(cmd);
+}
+#endif /* CONFIG_COMPAT */
+
 /*
  * VFS file helper functions.
  */
-- 
2.43.0


