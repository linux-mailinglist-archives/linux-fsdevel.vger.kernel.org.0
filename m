Return-Path: <linux-fsdevel+bounces-14043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598AB876F8F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763E01C20D05
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58B374EF;
	Sat,  9 Mar 2024 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnH6jWGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38414374CB
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970811; cv=none; b=AuMKPBJvPVWXQ+DZf+j/kGQn4r1V4WV9I771p8Wy1BvUkN2pnTF28+lllU64kkFIBM1+covdZf+Q73aM0M4QI4roZEFMOm7vqcoSyWdAmrKNJ20fd5AHG+W/Qv2ttufNNuv5aYv0jDYRmFWcm4yp6YNpGebf3XBpbRL71224Xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970811; c=relaxed/simple;
	bh=JBv0CKC61uVUxO4D9yRzCL2222gy1h0jRsw5TGJxmDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWGLfwnrT6SNeZGbgHqiltLKJVFKXYRiH2BjIC8zvjrwjQWpLZhiOiVqp2gLinmQhDttBmpQf5hj6IGZga/9A3imre/bd76e2Od3Xqy90+FmN5BRkDTZg2eodmIZlkkk2t3l4s088f/nhorazowQ7FsX5aukRiMHzWmYvnhWT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnH6jWGN; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a4601871727so14341266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970807; x=1710575607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jATtGk1IqW9zkJU7m3Bn1lFjX0fb9etunp774c+XeqQ=;
        b=PnH6jWGN11dl2IN1vAyTi0xpxUcsOUjqmPbuoQk09UlOw/GobkLoGXOTVya0Pfp1Sc
         vtaKH3zVGwxB7sLyLfgiDP6wBoNx1wtOgfmjOa/jyXKJhncZweDuTmau6AdY42q6O+VL
         0E/G5wSHqcTqwYotRcVSs5/RfzMa9EeKVsvYjDXlKDk9ZS8dCyW0zwvX92WratXPPE0j
         brzFSM1VhAU/sCYqnJbRQwdFHYrAv3GYSNVp4jb/Vnb97VvBePhD3xDXGxHYOzT+Fhum
         JxNe81jljb3JFqG0wTZh/84DuOYC94p4uWHYS5bbd8dBLNKMH5X3oOP59d3sxJjhKLky
         ViFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970807; x=1710575607;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jATtGk1IqW9zkJU7m3Bn1lFjX0fb9etunp774c+XeqQ=;
        b=QmdTbDtnPYz+hf+Rp9yWYApQBQX9dATsqPv49uduehg/3VHugaXmcEQOF3FaqQtmem
         Wq2qgtcvC6+SBipqh965dYxzzRmeiYUsO9YFDtzQMtlnEjHfYiQoxmPWvBFDKM8jQ1i6
         oeOPdcGPR+4TocW0pc2Xyn2xQKbl3BoE3TqfyrgPs5u9+GvOH/DmVNoaztmAUdkLjj7f
         lmMhbch2/fH0Uov1dDsR6wET8ENrVKHW9zaQEMgjDzhTpQdQVYU3JEyY0Te32+/x4NwO
         e0V0QZbN4ES6XLpEDlL1Qnxtmt3HQDbvBqZfjlm6euwXxuY2xruwDbxmKXbllBoz6RZY
         HXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCPZ8WmkpyU0KfQkrZTFwMna9lO536Ar3eHftBkgQQfBmG2RBXja65dHjP9oMR6EaSmk/oECIMi0rOBq3yRRNtDTFjUi+TV6aVBmL63g==
X-Gm-Message-State: AOJu0YzMkiSarAQlVnCC8P3IUpyEX9+MncGwy+DSuUhai8d+j72Rxoe7
	GoK3ByC8J1DdjI2Z/ry/QbzzEZKf+HxfZpEfVt69+lOF9lzS3WyxJ7CsZDlyEtGEi2GIFfMGg6x
	49g==
X-Google-Smtp-Source: AGHT+IGZGv5WCrNTmbT0r7trdGDMvxq3sD+PnYOLejyqPwQMPJhFX74hvRdaAreQCCAnTjLS5K01DZVz1PY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:99d6:b0:a3f:40ab:7677 with SMTP id
 s22-20020a17090699d600b00a3f40ab7677mr1653ejn.12.1709970807232; Fri, 08 Mar
 2024 23:53:27 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:12 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-2-gnoack@google.com>
Subject: [PATCH v10 1/9] security: Create security_file_vfs_ioctl hook
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This LSM hook gets called just before the fs/ioctl.c logic delegates
the requested IOCTL command to the file-specific implementation as
implemented by f_op->unlocked_ioctl (or f_op->ioctl_compat).

It is impractical for LSMs to make security guarantees about these
f_op operations without having intimate knowledge of how they are
implemented.

Therefore, depending on the enabled Landlock policy, Landlock aims to
block the calls to filp->f_op->unlocked_ioctl(), but permit the calls
to the IOCTL commands which are already implemented in fs/ioctl.c.

The current call graph is:

  * ioctl syscall
    * security_file_ioctl() LSM hook
    * do_vfs_ioctl() - standard operations
      * file_ioctl() - standard file operations
    * vfs_ioctl() - delegate to file (if do_vfs_ioctl() is a no-op)
      * filp->f_op->unlocked_ioctl()

Why not use the existing security_file_ioctl() hook?

With the existing security_file_ioctl() hook, it is technically
feasible to prevent the call to filp->f_op->unlocked_ioctl(), but it
would be difficult to maintain: security_file_ioctl() gets called
further up the call stack, so an implementation of it would need to
predict whether the logic further below will decide to call
f_op->unlocked_ioctl().  That can only be done by mirroring the logic
in do_vfs_ioctl() to some extent, and keeping this in sync.

We therefore think that it is cleaner to add a new LSM hook, which
gets called closer to the security boundary which we actually want to
block, filp->f_op->unlocked_ioctl().

Why is it difficult to reason about f_op->unlocked_ioctl()?

The unlocked_ioctl() and ioctl_compat() operations generally do the
following things:

 1. Execute code depending on the IOCTL command number,
    to implement the IOCTL command.

 2. Execute code independent(!) of the IOCTL command number,
    usually to implement common locking and resource allocation
    behavior.

    Notably, this often happens before(!) the implementation looks
    at the command number.

Due to the number of device drivers in Linux, it is infeasible for LSM
maintainers to keep track of what these implementations do in detail.

Due to 2., even permitting selected IOCTL command numbers to be
implemented by devices would probably be a mistake, because even when
a device does not implement a given IOCTL command, it might still
execute code when you try to call it.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c                    | 14 ++++++++++++--
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 22 ++++++++++++++++++++++
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..e0a8ce300dcd 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -43,10 +43,16 @@
  */
 long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	int error =3D -ENOTTY;
+	int error;
+
+	error =3D security_file_vfs_ioctl(filp, cmd, arg);
+	if (error)
+		goto out;
=20
-	if (!filp->f_op->unlocked_ioctl)
+	if (!filp->f_op->unlocked_ioctl) {
+		error =3D -ENOTTY;
 		goto out;
+	}
=20
 	error =3D filp->f_op->unlocked_ioctl(filp, cmd, arg);
 	if (error =3D=3D -ENOIOCTLCMD)
@@ -967,6 +973,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsign=
ed int, cmd,
 		if (error !=3D -ENOIOCTLCMD)
 			break;
=20
+		error =3D security_file_vfs_ioctl(f.file, cmd, arg);
+		if (error !=3D 0)
+			break;
+
 		if (f.file->f_op->compat_ioctl)
 			error =3D f.file->f_op->compat_ioctl(f.file, cmd, arg);
 		if (error =3D=3D -ENOIOCTLCMD)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..d8a7c49b7eef 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -173,6 +173,8 @@ LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigne=
d int cmd,
 	 unsigned long arg)
 LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, file_vfs_ioctl, struct file *file, unsigned int cmd,
+	 unsigned long arg)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..05a2e1852f66 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -396,6 +396,8 @@ void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long=
 arg);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
+int security_file_vfs_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -1011,6 +1013,12 @@ static inline int security_file_ioctl_compat(struct =
file *file,
 	return 0;
 }
=20
+static inline int security_file_vfs_ioctl(struct file *file, unsigned int =
cmd,
+					  unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot=
,
 				     unsigned long flags)
 {
diff --git a/security/security.c b/security/security.c
index 7035ee35a393..15c635cd8366 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2745,6 +2745,28 @@ int security_file_ioctl_compat(struct file *file, un=
signed int cmd,
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
=20
+/**
+ * security_file_vfs_ioctl() - Check if a ioctl implemented by the file is=
 allowed
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Check permission for an ioctl operation on @file.  Note that @arg somet=
imes
+ * represents a user space pointer; in other cases, it may be a simple int=
eger
+ * value.  When @arg represents a user space pointer, it should never be u=
sed
+ * by the security module.
+ *
+ * This hook is checked just before calling f_op->unlocked_ioctl() or
+ * f_op->compat_ioctl().
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_vfs_ioctl(struct file *file, unsigned int cmd, unsigned =
long arg)
+{
+	return call_int_hook(file_vfs_ioctl, 0, file, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(security_file_vfs_ioctl);
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long pro=
t)
 {
 	/*
--=20
2.44.0.278.ge034bb2e1d-goog


