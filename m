Return-Path: <linux-fsdevel+bounces-15424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9288E67E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7076F1C2DE96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932B156C5F;
	Wed, 27 Mar 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIA8GOSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAE156994
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545051; cv=none; b=TCeCC0t3PrFekfWNW72Z0ozO2D73asJEyp4irkaj22x6EbarUh8FCAcJUo40hp/iPHgI9KVQXu9wZyNhOf02SX23C6qMp7efMZZrK47GhnTkEDVwXVK7I2SbFFah18iOevIqILjvl85uqKp2Y/nv/WgPYh+7XTTSqPMay5c5qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545051; c=relaxed/simple;
	bh=e8AuXRMMhuytj5m0cUx5XlNPWIF0P2eUw69ggjRLH8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IfMr2gFDeCENgX0rtEwy/uEeXUAvPXn0zlq2cWY56A/OmLy8tvyLkOzQ+zwydFOGG0UQlMbDRv73BcxAiuSVteufQLiQ3SveAVvGpdxi+TVr5wnzEcSifhhwZSRz4WfhDft6DZrhliTnIsLYctqM9e6l4P/Fnmf34CrGLxXHM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIA8GOSu; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a4747f29e19so169455166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545047; x=1712149847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYFjz37D9E1WxZSi56iT/Gju9E3eLiEhVJ4Dps9Ts6M=;
        b=hIA8GOSuG4jK7RZl1IgguY9NpWG2tfF7Is+A1eFScwK0TqMr15/u/cNWgPfkPdi54K
         bzGnO1/8tMVMgOknyt/VcnNo+Zo9KiELG7MDuch3LFiXG0/RW+j59Bv6dZArQ+/I4C6t
         1X4Dj9T0M+8hgDZ9DxHRq9L/Ai3j02HW8lEaDfgI0sLOD44Rr2TrQCCE7iegus57zD5D
         N71dIGcYg8bs68CnSUehkxnZHCW0ZNQjD1IKKa/z5SyI0OcpvxY1v7xVcGG234985uKb
         dWHqwTuFmSAAd3nf5IZlHQ7rwodyMRgEMRSwnLjTIzKcVKldX5/kMa6WZZUXlBzz0yQy
         sHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545047; x=1712149847;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYFjz37D9E1WxZSi56iT/Gju9E3eLiEhVJ4Dps9Ts6M=;
        b=mFLugMb4f0fEvWV5Ou0/6lu4/AoDypcOhcEbc4OGEQ6/G84iZsNghMmXfsCGT4+Xlb
         fl09AJiucUh4jeRUpzaTjYYuAWcShxd2+2MN6h2JWK6f12h0Q5G0YrVisBwgcxAe5yP3
         r64r8PG5c9zYQssOXiRUOtTD4V1lZGWfCgy4TweEZvys6GxElActZiNM3E2sdd6Ly+Bq
         k9JgUSkujGPPW7qBkDQ8R2ujZjW7mQ9fHEVhr+K80E6yPWCNt3HbHzHtft2KW/H++d5A
         U1j8APbyvLZWJRBzgxSn/psRHSdlecUMQA1VnF+AfFwPzI7cJa3gqyaGz6OkYI6JggvQ
         vzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQudhC4UoR5JIPSMvfLY+Q0rcWVoOaDs43rwd6/kjCXUmNpwm1OU5TFmwyDz9fTOePwzsD8LfstmHecSUaciGmx6gxcbj8KI8ja7BqQw==
X-Gm-Message-State: AOJu0YxJq+UKJFXXIbsE3SRWeD3mMiojSgXU6Zks57pPKdwQ+1aO1fXc
	fsiUi7ipqgO1ansEBcyUjqHzOArADZOHu33J/qer2rM9dzdc59oh8a7DpZe6KumNHEhAFAajKyB
	Rqg==
X-Google-Smtp-Source: AGHT+IESYPfVMjkUvF8sf+RiHrC+Eb0dnL9SZaIk6KOm1c6UFh6VfaEJi1Ik5ztZ4i0dakHZ32FHweSg/dI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:970f:b0:a47:4828:4131 with SMTP id
 jg15-20020a170907970f00b00a4748284131mr55875ejc.8.1711545046854; Wed, 27 Mar
 2024 06:10:46 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:31 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-2-gnoack@google.com>
Subject: [PATCH v13 01/10] landlock: Add IOCTL access right for character and
 block devices
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
and increments the Landlock ABI version to 5.

This access right applies to device-custom IOCTL commands
when they are invoked on block or character device files.

Like the truncate right, this right is associated with a file
descriptor at the time of open(2), and gets respected even when the
file descriptor is used outside of the thread which it was originally
opened in.

Therefore, a newly enabled Landlock policy does not apply to file
descriptors which are already open.

If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
number of safe IOCTL commands will be permitted on newly opened device
files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
as other IOCTL commands for regular files which are implemented in
fs/ioctl.c.

Noteworthy scenarios which require special attention:

TTY devices are often passed into a process from the parent process,
and so a newly enabled Landlock policy does not retroactively apply to
them automatically.  In the past, TTY devices have often supported
IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
letting callers control the TTY input buffer (and simulate
keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
modern kernels though.

Known limitations:

The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
control over IOCTL commands.

Landlock users may use path-based restrictions in combination with
their knowledge about the file system layout to control what IOCTLs
can be done.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                |  33 +++-
 security/landlock/fs.c                       | 183 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   8 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 6 files changed, 216 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..5d90e9799eb5 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -128,7 +128,7 @@ struct landlock_net_port_attr {
  * files and directories.  Files or directories opened before the sandboxi=
ng
  * are not subject to these restrictions.
  *
- * A file can only receive these access rights:
+ * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
@@ -138,12 +138,13 @@ struct landlock_net_port_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -198,13 +199,28 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
+ * The following access right applies both to files and directories:
+ *
+ * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on=
 an opened
+ *   character or block device.
+ *
+ *   This access right applies to all `ioctl(2)` commands implemented by d=
evice
+ *   drivers.  However, the following common IOCTL commands continue to be
+ *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
+ *
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIFREEZE``,
+ *   ``FITHAW``, ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPA=
TH``
+ *
+ *   This access right is available since the fifth version of the Landloc=
k
+ *   ABI.
+ *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -223,6 +239,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c15559432d3d..2ef6c57fa20b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -7,6 +7,7 @@
  * Copyright =C2=A9 2021-2022 Microsoft Corporation
  */
=20
+#include <asm/ioctls.h>
 #include <kunit/test.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
@@ -14,6 +15,7 @@
 #include <linux/compiler_types.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -29,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
=20
 #include "common.h"
@@ -84,6 +87,141 @@ static const struct landlock_object_underops landlock_f=
s_underops =3D {
 	.release =3D release_inode
 };
=20
+/* IOCTL helpers */
+
+/**
+ * get_required_ioctl_dev_access(): Determine required access rights for I=
OCTLs
+ * on device files.
+ *
+ * @cmd: The IOCTL command that is supposed to be run.
+ *
+ * By default, any IOCTL on a device file requires the
+ * LANDLOCK_ACCESS_FS_IOCTL_DEV right.  We make exceptions for commands, i=
f:
+ *
+ * 1. The command is implemented in fs/ioctl.c's do_vfs_ioctl(),
+ *    not in f_ops->unlocked_ioctl() or f_ops->compat_ioctl().
+ *
+ * 2. The command can be reasonably used on a device file at all.
+ *
+ * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioct=
l()
+ * should be considered for inclusion here.
+ *
+ * Returns: The access rights that must be granted on an opened file in or=
der to
+ * use the given @cmd.
+ */
+static __attribute_const__ access_mask_t
+get_required_ioctl_dev_access(const unsigned int cmd)
+{
+	switch (cmd) {
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+		/*
+		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
+		 * close-on-exec and the file's buffered-IO and async flags.
+		 * These operations are also available through fcntl(2), and are
+		 * unconditionally permitted in Landlock.
+		 */
+		return 0;
+	case FIOQSIZE:
+		/*
+		 * FIOQSIZE queries the size of a regular file or directory.
+		 *
+		 * This IOCTL command only applies to regular files and
+		 * directories.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	case FIFREEZE:
+	case FITHAW:
+		/*
+		 * FIFREEZE and FITHAW freeze and thaw the file system which the
+		 * given file belongs to.  Requires CAP_SYS_ADMIN.
+		 *
+		 * These commands operate on the file system's superblock rather
+		 * than on the file itself.  The same operations can also be
+		 * done through any other file or directory on the same file
+		 * system, so it is safe to permit these.
+		 */
+		return 0;
+	case FS_IOC_FIEMAP:
+		/*
+		 * FS_IOC_FIEMAP queries information about the allocation of
+		 * blocks within a file.
+		 *
+		 * This IOCTL command only applies to regular files.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	case FIGETBSZ:
+		/*
+		 * FIGETBSZ queries the file system's block size for a file or
+		 * directory.
+		 *
+		 * This command operates on the file system's superblock rather
+		 * than on the file itself.  The same operation can also be done
+		 * through any other file or directory on the same file system,
+		 * so it is safe to permit it.
+		 */
+		return 0;
+	case FICLONE:
+	case FICLONERANGE:
+	case FIDEDUPERANGE:
+		/*
+		 * FICLONE, FICLONERANGE and FIDEDUPERANGE make files share
+		 * their underlying storage ("reflink") between source and
+		 * destination FDs, on file systems which support that.
+		 *
+		 * These IOCTL commands only apply to regular files.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	case FIONREAD:
+		/*
+		 * FIONREAD returns the number of bytes available for reading.
+		 *
+		 * We require LANDLOCK_ACCESS_FS_IOCTL_DEV for FIONREAD, because
+		 * devices implement it in f_ops->unlocked_ioctl().  The
+		 * implementations of this operation have varying quality and
+		 * complexity, so it is hard to reason about what they do.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	case FS_IOC_GETFLAGS:
+	case FS_IOC_SETFLAGS:
+	case FS_IOC_FSGETXATTR:
+	case FS_IOC_FSSETXATTR:
+		/*
+		 * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
+		 * FS_IOC_FSSETXATTR do not apply for devices.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	case FS_IOC_GETFSUUID:
+	case FS_IOC_GETFSSYSFSPATH:
+		/*
+		 * FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH both operate on
+		 * the file system superblock, not on the specific file, so
+		 * these operations are available through any other file on the
+		 * same file system as well.
+		 */
+		return 0;
+	case FIBMAP:
+	case FS_IOC_RESVSP:
+	case FS_IOC_RESVSP64:
+	case FS_IOC_UNRESVSP:
+	case FS_IOC_UNRESVSP64:
+	case FS_IOC_ZERO_RANGE:
+		/*
+		 * FIBMAP, FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP,
+		 * FS_IOC_UNRESVSP64 and FS_IOC_ZERO_RANGE only apply to regular
+		 * files (as implemented in file_ioctl()).
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	default:
+		/*
+		 * Other commands are guarded by the catch-all access right.
+		 */
+		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	}
+}
+
 /* Ruleset management */
=20
 static struct landlock_object *get_inode_object(struct inode *const inode)
@@ -148,7 +286,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
=20
 /*
@@ -1335,8 +1474,10 @@ static int hook_file_alloc_security(struct file *con=
st file)
 static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
-	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	access_mask_t open_access_request, full_access_request, allowed_access,
+		optional_access;
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
 	const struct landlock_ruleset *const dom =3D
 		get_fs_domain(landlock_cred(file->f_cred)->domain);
=20
@@ -1354,6 +1495,10 @@ static int hook_file_open(struct file *const file)
 	 * We look up more access than what we immediately need for open(), so
 	 * that we can later authorize operations on opened files.
 	 */
+	optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	if (is_device)
+		optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 	full_access_request =3D open_access_request | optional_access;
=20
 	if (is_access_to_paths_allowed(
@@ -1410,6 +1555,36 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
+	access_mask_t required_access, allowed_access;
+
+	if (!is_device)
+		return 0;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether IOCTL can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	required_access =3D get_required_ioctl_dev_access(cmd);
+	allowed_access =3D landlock_file(file)->allowed_access;
+	if ((allowed_access & required_access) =3D=3D required_access)
+		return 0;
+
+	return -EACCES;
+}
+
+static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	return hook_file_ioctl(file, cmd, arg);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1432,6 +1607,8 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 93c9c6f91556..20fdb5ff3514 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 #define LANDLOCK_SHIFT_ACCESS_FS	0
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6788e73b6681..9ae3dfa47443 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -149,7 +149,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 4
+#define LANDLOCK_ABI_VERSION 5
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -321,7 +321,11 @@ static int add_rule_path_beneath(struct landlock_rules=
et *const ruleset,
 	if (!path_beneath_attr.allowed_access)
 		return -ENOMSG;
=20
-	/* Checks that allowed_access matches the @ruleset constraints. */
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints and only
+	 * consists of publicly visible access rights (as opposed to synthetic
+	 * ones).
+	 */
 	mask =3D landlock_get_raw_fs_access_mask(ruleset, 0);
 	if ((path_beneath_attr.allowed_access | mask) !=3D mask)
 		return -EINVAL;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index a6f89aaea77d..3c1e9f35b531 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 9a6036fbf289..418ad745a5dd 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -529,9 +529,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.44.0.396.g6e790dbe36-goog


