Return-Path: <linux-fsdevel+bounces-58847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D481B3211D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3571E642268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE0320CC4;
	Fri, 22 Aug 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CL0DjqcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817831353E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882504; cv=none; b=iPnhpHYoOvRsh71XKUEa76OphePUUw93d4EEmop2+YVVKfAPX0TBTMHiw3fu98GRYSrkEIhe9kv8o1yy3CJzNvvSDaGGCaqwH3Z5LrE3PvhgXWPxT320DF2e2mOOwHUItGlr3yZmS3Lw78no5O6Oold1yyBjpXTq7DFlG1ps8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882504; c=relaxed/simple;
	bh=OVRFRLu8F4BN74Vc9MYDMSp8Mg+F6qqRLo8coEYach4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYqNoI02d6qAmiKvbCmjx0cn+C2fWIXTA6q4RO/u999CXbbhZni/QQ/ozjT6Yrrw+zAZVdrwHpYkgZWa43i/zpjyk13K95AdK0EcNKdqRZci0UgQGRgBAVc9D61AAOCY7sJKA3dQo7QNeSyKpjbWQJ7M2gf+xUBB78diYE4U970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CL0DjqcS; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c7mpz6rt0zxm0;
	Fri, 22 Aug 2025 19:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755882491;
	bh=5o2Snc62pQDeQeVLTbKOiBddxc56vMXJxU1FHFkA7Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL0DjqcSBYJJIhJfdzz2FzDPpC3tpbvLbbM6cbWkA+SacJfY8HFZa9H5ILY4C0yX3
	 mSOoJdW2r3Kz1QsaWiWAOjtQwd9VA1S2ej8RoBbm3ro1oxUHQvbx6B3O8FFn+XhHJV
	 /NxPrguHkgRpzlAPYrS502DKeqq/Jr4JEV/uGRCg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c7mpy695FznnJ;
	Fri, 22 Aug 2025 19:08:10 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Robert Waite <rowait@microsoft.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Date: Fri, 22 Aug 2025 19:07:59 +0200
Message-ID: <20250822170800.2116980-2-mic@digikod.net>
In-Reply-To: <20250822170800.2116980-1-mic@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
passed file descriptors).  This changes the state of the opened file by
making it read-only until it is closed.  The main use case is for script
interpreters to get the guarantee that script' content cannot be altered
while being read and interpreted.  This is useful for generic distros
that may not have a write-xor-execute policy.  See commit a5874fde3c08
("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")

Both execve(2) and the IOCTL to enable fsverity can already set this
property on files with deny_write_access().  This new O_DENY_WRITE make
it widely available.  This is similar to what other OSs may provide
e.g., opening a file with only FILE_SHARE_READ on Windows.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Reported-by: Robert Waite <rowait@microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250822170800.2116980-2-mic@digikod.net
---
 fs/fcntl.c                       | 26 ++++++++++++++++++++++++--
 fs/file_table.c                  |  2 ++
 fs/namei.c                       |  6 ++++++
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 5 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5598e4d57422..0c80c0fbc706 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -34,7 +34,8 @@
 
 #include "internal.h"
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | \
+	O_DENY_WRITE)
 
 static int setfl(int fd, struct file * filp, unsigned int arg)
 {
@@ -80,8 +81,29 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 			error = 0;
 	}
 	spin_lock(&filp->f_lock);
+
+	if (arg & O_DENY_WRITE) {
+		/* Only regular files. */
+		if (!S_ISREG(inode->i_mode)) {
+			error = -EINVAL;
+			goto unlock;
+		}
+
+		/* Only sets once. */
+		if (!(filp->f_flags & O_DENY_WRITE)) {
+			error = exe_file_deny_write_access(filp);
+			if (error)
+				goto unlock;
+		}
+	} else {
+		if (filp->f_flags & O_DENY_WRITE)
+			exe_file_allow_write_access(filp);
+	}
+
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
 	filp->f_iocb_flags = iocb_flags(filp);
+
+unlock:
 	spin_unlock(&filp->f_lock);
 
  out:
@@ -1158,7 +1180,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
diff --git a/fs/file_table.c b/fs/file_table.c
index 81c72576e548..6ba896b6a53f 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -460,6 +460,8 @@ static void __fput(struct file *file)
 	locks_remove_file(file);
 
 	security_file_release(file);
+	if (unlikely(file->f_flags & O_DENY_WRITE))
+		exe_file_allow_write_access(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..366530bf937d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3885,6 +3885,12 @@ static int do_open(struct nameidata *nd,
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
+	if (!error && (open_flag & O_DENY_WRITE)) {
+		if (S_ISREG(file_inode(file)->i_mode))
+			error = exe_file_deny_write_access(file);
+		else
+			error = -EINVAL;
+	}
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..dad14101686f 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_DENY_WRITE)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..facd9136f5af 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -91,6 +91,10 @@
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
+#ifndef O_DENY_WRITE
+#define O_DENY_WRITE	040000000
+#endif
+
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
 #endif
-- 
2.50.1


