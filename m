Return-Path: <linux-fsdevel+bounces-15211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF888A83F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96096340657
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA033129E97;
	Mon, 25 Mar 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17uvGEPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532084D0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374017; cv=none; b=Wb1WUeephQrjwim1GNX1Sh6B/lgYjH11zgBPGpc2RLaN6ErO/buu5WccYdGYF62J/o6iOrQ2f5j9LZloNPtfkcj8zzB/q9gzJlGWueKz5gzHCf5nNsGztGEFslJOxxkLhfYU0QoQAU4WtQS6cuzayBuI/ZF7YOOCZsBNEBodQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374017; c=relaxed/simple;
	bh=GV4nFSew8ekv4a9e4VhZrVJKzdWaULUZLcqkf5eZGRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDTvwsQnNCPGq0aumyyzrUNhbcP0FcY4fg0Uf+aaZ+ubnTm62dZFO/+SL7wIUfbixWNmkhrUyMZy7yZxd2T/md+kznH5F38rWa8Ddj7Yiq5CaREjHlXCUD6eEYWS7TNftouOyUkxn8YPug20D+GOSbfSF2z6cL8MFD0CB8ie1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17uvGEPA; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a49962d268bso14270466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374013; x=1711978813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0gjA72WKYUtOlZXmUom7NcTr/CMjUSwx12kjmaeLGs=;
        b=17uvGEPA4gC3BYgavS17vOf9jlLm49NCVyEYqnvvWVkmYg3nbFmIdVUvtQf3oTTzP2
         VaP5XSNQ6XKpwMP3URIObUXZT1HZsKg5+cmeHvI+/39YCZ6JvfRgjSPAJi+/soLQUTxc
         g3hmeCOvbgHFWOTu2gE4ksOMDR5Zc2EdHGFca5JpU/VygdC8XN91EaqN6aD0pAZEfT1J
         Lk4L+2qc+tfecZ67S/H4wRre/VvkhlD/XZG3ML8wwbdzbTjMyeQLnbycDafHmXFCHQh/
         w5gBoI58Vtkg9+RowVuiRJPBGv6veMtU1+KULG8zFXREe7dGk11O1GQpXb33aFSuiTfA
         oe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374013; x=1711978813;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0gjA72WKYUtOlZXmUom7NcTr/CMjUSwx12kjmaeLGs=;
        b=NdMzUdKhq6qlvARctkJ3vnJaJewtM8XfHsGxSBfZHv1qmSrsmuDpi1cm/LO+V+3Etz
         HCZ47iW2GufF2JUBOpcAn8GVWQfCCEmNozl7sRGjXJzNzIAzd5SGjRWFko/LqVVo2Bld
         jnE/Qqum3A0VtFxIB8EqwBqfYcX0GvOz3NfTSdWknvBBbkYyFb3Paee1c/OSlfsQLIP8
         ksdLTbHRkYZ8ToMvZ5c2gsoRVzf7F10uZtlzrNmhbv+8ibh5hIcIHO/ACATrMhs/7xLm
         1SG+n5U8p1ahzslP48b20wNNIpk2Evl8jCvsSrlPgjOa12/qUjj8TlhJmrtmh3WdIINr
         gPlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxwd5b+kQQrIfT4UJqhWj+AQKaLFnHj1f0+ogR1IQaB97uV1YTF5GUQJj0VgAz+cqovG/unT8hO2VS/HIRpmVFNLGBvKYvqAyOiz303A==
X-Gm-Message-State: AOJu0Ywvp6anTtpxBVJ0HVyCqD8mwYCDnm/+1ffr0q2aifTENpgdh3RX
	LW+WJpPQp4sK+UeuhnnrkLXZ25nUN6rDmuwjXrbrLJZpD0vyYXDwLe9U83Evw75NQXeWH8mS1IA
	ywg==
X-Google-Smtp-Source: AGHT+IEBu2KnJUhSW3PcZm1HICARy9vi/GOfvLYBS3IDf+nCARFGQR5OcpkEru0F9zFHxWU1zgOPU37RVE8=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:228b:b0:a47:33f1:3d5 with SMTP id
 p11-20020a170906228b00b00a4733f103d5mr36094eja.9.1711374013436; Mon, 25 Mar
 2024 06:40:13 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:39:57 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-3-gnoack@google.com>
Subject: [PATCH v12 2/9] landlock: Add IOCTL access right for character and
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
 include/uapi/linux/landlock.h                | 35 +++++++++++----
 security/landlock/fs.c                       | 45 ++++++++++++++++++--
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  8 +++-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 ++-
 6 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..193733d833b1 100644
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
@@ -198,13 +199,30 @@ struct landlock_net_port_attr {
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
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIOQSIZE``,
+ *   ``FIFREEZE``, ``FITHAW``, ``FS_IOC_FIEMAP``, ``FIGETBSZ``, ``FICLONE`=
`,
+ *   ``FICLONERANGE``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
+ *   ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``
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
@@ -223,6 +241,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c15559432d3d..650ae498e9a1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -148,7 +148,8 @@ static struct landlock_object *get_inode_object(struct =
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
@@ -1335,8 +1336,10 @@ static int hook_file_alloc_security(struct file *con=
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
@@ -1354,6 +1357,10 @@ static int hook_file_open(struct file *const file)
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
@@ -1410,6 +1417,36 @@ static int hook_file_truncate(struct file *const fil=
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
+	required_access =3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	allowed_access =3D landlock_file(file)->allowed_access;
+	if ((allowed_access & required_access) =3D=3D required_access)
+		return 0;
+
+	return -ENOFILEOPS;
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
@@ -1432,6 +1469,8 @@ static struct security_hook_list landlock_hooks[] __r=
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
index 646f778dfb1e..d292b419ccba 100644
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
index 2d6d9b43d958..0bcbbf594fd7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -527,9 +527,10 @@ TEST_F_FORK(layout1, inval)
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


