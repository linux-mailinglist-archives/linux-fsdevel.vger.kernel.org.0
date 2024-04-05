Return-Path: <linux-fsdevel+bounces-16231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E4489A628
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C4E1F22778
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22217555D;
	Fri,  5 Apr 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl3pP5aR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A37172BCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353276; cv=none; b=ZlTUy/5mPgTO6lIyfOki1NNaNRZrHWLLnQ50kE+ve9we/GVgaLGRencTui5XGQrtzyDSjJmgJpEXnNK5HmYf/V7weUxw5RXjWU3zLixef1kVRbvlF5iPrBiAd0zLPi6t2ZZu8Id0Ee4LWcWDPRNkQdHUT81dpBTdqHb/saIDkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353276; c=relaxed/simple;
	bh=XuBIkyWwbTtTyw6M5o6+QiYGw8z0vJIXI+0LylK4dZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUA4f3huIoarz8T2VMpHBRvuk896ihwQTMEFES3IE0cuiiWdj1QQD9k62hOVAlqS/MHA9dZFgXnOsx2kt2f0KfiHcgXDzd/sP8/InW2CFe2kXqJe9DXJ2DKK5ZyczeF1zIovEXIOUJ1M3pxWmaZsvBWUo1cjD0Vwv+qAm10vzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl3pP5aR; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so1778081a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353272; x=1712958072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFyUKhBygtgE4pYgKKMK5lI239GRM14OwFhWnA6nKf8=;
        b=kl3pP5aRHf198sp59VVoD/s8gmtgGgANHHiGPnqG2G+/F24A/mH4DVhYvyZejQI/Lj
         WtrBSb4NLwOUPGSwzrh0Q9RiB2ciUYRJOOf5XL7tltVMgShz40W8bBd1m3cedNWH7aR2
         v3Ojm+FQhLRRKqDOod5niQdy/l+WQWux6ATXX0a2lKDdWZ0IW6c4ngOJ7nKvW+IRPmRi
         3DK51tgK65sMdHeILZ4mmnG+vKFu1nIBb3o+SNcQ5ULfu1DKCHMg/XTuMLXFJOAwQAHK
         gDhmHiV1vQXviaoZTmaXpVdTkewUlm5EJ+FgVuDDZ13N+3F/Eiz5jUKGd/FkkfAbkxVs
         4cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353272; x=1712958072;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFyUKhBygtgE4pYgKKMK5lI239GRM14OwFhWnA6nKf8=;
        b=xTGn46u/CwolXJiyCTuVexajF7ZnmmW2ZhDEAvbyc28CzZeyBswGa6+ZgpWbN6D4wT
         5DZTEUG5mcDncLrGdAn3elhUZBuJmLwslgH5z1IfecFWqzT6ru+4P4l0T99k7NYW7hb1
         oLpKcFyqvnB/dSkFmOgfR2ehGG0uyuGX2p7xnC0ObOJG3ivr4e6XHfz9UDWd/QyuDEr/
         d+NhGjd99vUq4hPKdkT1GyPsZS5Yk+gGIHaL1b8/9DnH9RP3hxbNioP00eNLGS990Pcb
         VNStEvSJV+QakTjlrXnAplegz5AtsNG1tBejwTKds8QxlihB9Hgac22gUSqYEINpP6qC
         Gkjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpw+DhFUpJbmcmnffZS8Lk2R5tE9q7/pcKOJe4F1hEyo4nQYBaCsfqi7sSW4qnq9W9i5FGlN9dZgL1zycQa7Ov+z3mI/iy3DmkeBPczw==
X-Gm-Message-State: AOJu0YzQE6bM7/WYw3WH+fnXckhUo4H31PnIK4TJAMvNqXin2QWiaRay
	draB8Rz7ivhZoGYtqMg5Q2Eee6+36FxpN+ImW/8qy76okM3o01vXn6V0SR6pS9HpuWWadr7pWBW
	/7A==
X-Google-Smtp-Source: AGHT+IGf3/8eK6g5sM5NdvoAMYrM++pY+SALiClD49dEz17X4GvmHc1K63YbLKs0xekY0i5mDzBTq8V7mOA=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:6a13:b0:a4e:6489:388d with SMTP id
 qw19-20020a1709066a1300b00a4e6489388dmr3556ejc.4.1712353272260; Fri, 05 Apr
 2024 14:41:12 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:30 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-3-gnoack@google.com>
Subject: [PATCH v14 02/12] landlock: Add IOCTL access right for character and
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
 include/uapi/linux/landlock.h                |  38 +++-
 security/landlock/fs.c                       | 221 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   8 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 6 files changed, 259 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..68625e728f43 100644
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
@@ -198,13 +199,33 @@ struct landlock_net_port_attr {
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
+ *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX`=
`),
+ *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC=
``),
+ *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
+ *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
+ *   * Some IOCTL commands which do not make sense when used with devices,=
 but
+ *     whose implementations are safe and return the right error codes
+ *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE`=
`)
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
@@ -223,6 +244,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c15559432d3d..b0857541d5e0 100644
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
@@ -84,6 +87,158 @@ static const struct landlock_object_underops landlock_f=
s_underops =3D {
 	.release =3D release_inode
 };
=20
+/* IOCTL helpers */
+
+/**
+ * is_masked_device_ioctl(): Determine whether an IOCTL command is always
+ * permitted with Landlock for device files.  These commands can not be
+ * restricted on device files by enforcing a Landlock policy.
+ *
+ * @cmd: The IOCTL command that is supposed to be run.
+ *
+ * By default, any IOCTL on a device file requires the
+ * LANDLOCK_ACCESS_FS_IOCTL_DEV right.  However, we blanket-permit some
+ * commands, if:
+ *
+ * 1. The command is implemented in fs/ioctl.c's do_vfs_ioctl(),
+ *    not in f_ops->unlocked_ioctl() or f_ops->compat_ioctl().
+ *
+ * 2. The command is harmless when invoked on devices.
+ *
+ * We also permit commands that do not make sense for devices, but where t=
he
+ * do_vfs_ioctl() implementation returns a more conventional error code.
+ *
+ * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioct=
l()
+ * should be considered for inclusion here.
+ *
+ * Returns: true if the IOCTL @cmd can not be restricted with Landlock for
+ * device files.
+ */
+static __attribute_const__ bool is_masked_device_ioctl(const unsigned int =
cmd)
+{
+	switch (cmd) {
+	/*
+	 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
+	 * close-on-exec and the file's buffered-IO and async flags.  These
+	 * operations are also available through fcntl(2), and are
+	 * unconditionally permitted in Landlock.
+	 */
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+	/*
+	 * FIOQSIZE queries the size of a regular file, directory, or link.
+	 *
+	 * We still permit it, because it always returns -ENOTTY for
+	 * other file types.
+	 */
+	case FIOQSIZE:
+	/*
+	 * FIFREEZE and FITHAW freeze and thaw the file system which the
+	 * given file belongs to.  Requires CAP_SYS_ADMIN.
+	 *
+	 * These commands operate on the file system's superblock rather
+	 * than on the file itself.  The same operations can also be
+	 * done through any other file or directory on the same file
+	 * system, so it is safe to permit these.
+	 */
+	case FIFREEZE:
+	case FITHAW:
+	/*
+	 * FS_IOC_FIEMAP queries information about the allocation of
+	 * blocks within a file.
+	 *
+	 * This IOCTL command only makes sense for regular files and is
+	 * not implemented by devices. It is harmless to permit.
+	 */
+	case FS_IOC_FIEMAP:
+	/*
+	 * FIGETBSZ queries the file system's block size for a file or
+	 * directory.
+	 *
+	 * This command operates on the file system's superblock rather
+	 * than on the file itself.  The same operation can also be done
+	 * through any other file or directory on the same file system,
+	 * so it is safe to permit it.
+	 */
+	case FIGETBSZ:
+	/*
+	 * FICLONE, FICLONERANGE and FIDEDUPERANGE make files share
+	 * their underlying storage ("reflink") between source and
+	 * destination FDs, on file systems which support that.
+	 *
+	 * These IOCTL commands only apply to regular files
+	 * and are harmless to permit for device files.
+	 */
+	case FICLONE:
+	case FICLONERANGE:
+	case FIDEDUPERANGE:
+	/*
+	 * FIONREAD, FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
+	 * FS_IOC_FSSETXATTR are forwarded to device implementations.
+	 */
+
+	/*
+	 * FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH both operate on
+	 * the file system superblock, not on the specific file, so
+	 * these operations are available through any other file on the
+	 * same file system as well.
+	 */
+	case FS_IOC_GETFSUUID:
+	case FS_IOC_GETFSSYSFSPATH:
+		return true;
+
+	/*
+	 * file_ioctl() commands (FIBMAP, FS_IOC_RESVSP, FS_IOC_RESVSP64,
+	 * FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64 and FS_IOC_ZERO_RANGE) are
+	 * forwarded to device implementations, so not permitted.
+	 */
+
+	/* Other commands are guarded by the access right. */
+	default:
+		return false;
+	}
+}
+
+/*
+ * is_masked_device_ioctl_compat - same as the helper above, but checking =
the
+ * "compat" IOCTL commands.
+ *
+ * The IOCTL commands with special handling in compat-mode should behave t=
he
+ * same as their non-compat counterparts.
+ */
+static __attribute_const__ bool
+is_masked_device_ioctl_compat(const unsigned int cmd)
+{
+	switch (cmd) {
+	/* FICLONE is permitted, same as in the non-compat variant. */
+	case FICLONE:
+		return true;
+#if defined(CONFIG_X86_64)
+	/*
+	 * FS_IOC_RESVSP_32, FS_IOC_RESVSP64_32, FS_IOC_UNRESVSP_32,
+	 * FS_IOC_UNRESVSP64_32, FS_IOC_ZERO_RANGE_32: not blanket-permitted,
+	 * for consistency with their non-compat variants.
+	 */
+	case FS_IOC_RESVSP_32:
+	case FS_IOC_RESVSP64_32:
+	case FS_IOC_UNRESVSP_32:
+	case FS_IOC_UNRESVSP64_32:
+	case FS_IOC_ZERO_RANGE_32:
+#endif
+	/*
+	 * FS_IOC32_GETFLAGS, FS_IOC32_SETFLAGS are forwarded to their device
+	 * implementations.
+	 */
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_SETFLAGS:
+		return false;
+	default:
+		return is_masked_device_ioctl(cmd);
+	}
+}
+
 /* Ruleset management */
=20
 static struct landlock_object *get_inode_object(struct inode *const inode)
@@ -148,7 +303,8 @@ static struct landlock_object *get_inode_object(struct =
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
@@ -1332,11 +1488,18 @@ static int hook_file_alloc_security(struct file *co=
nst file)
 	return 0;
 }
=20
+static bool is_device(const struct file *const file)
+{
+	const struct inode *inode =3D file_inode(file);
+
+	return S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
+}
+
 static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
-	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	access_mask_t open_access_request, full_access_request, allowed_access,
+		optional_access;
 	const struct landlock_ruleset *const dom =3D
 		get_fs_domain(landlock_cred(file->f_cred)->domain);
=20
@@ -1354,6 +1517,10 @@ static int hook_file_open(struct file *const file)
 	 * We look up more access than what we immediately need for open(), so
 	 * that we can later authorize operations on opened files.
 	 */
+	optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	if (is_device(file))
+		optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 	full_access_request =3D open_access_request | optional_access;
=20
 	if (is_access_to_paths_allowed(
@@ -1410,6 +1577,52 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	access_mask_t allowed_access =3D landlock_file(file)->allowed_access;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether IOCTL can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	if (allowed_access & LANDLOCK_ACCESS_FS_IOCTL_DEV)
+		return 0;
+
+	if (!is_device(file))
+		return 0;
+
+	if (is_masked_device_ioctl(cmd))
+		return 0;
+
+	return -EACCES;
+}
+
+static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	access_mask_t allowed_access =3D landlock_file(file)->allowed_access;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether IOCTL can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	if (allowed_access & LANDLOCK_ACCESS_FS_IOCTL_DEV)
+		return 0;
+
+	if (!is_device(file))
+		return 0;
+
+	if (is_masked_device_ioctl_compat(cmd))
+		return 0;
+
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1432,6 +1645,8 @@ static struct security_hook_list landlock_hooks[] __r=
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
2.44.0.478.gd926399ef9-goog


