Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB295566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 05:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfHTDfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 23:35:31 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:62272 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfHTDfb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:35:31 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 284FBA0C2B;
        Tue, 20 Aug 2019 05:35:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id iPNXPGgi2zto; Tue, 20 Aug 2019 05:35:18 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH RESEND v11 3/8] open: O_EMPTYPATH: procfs-less file descriptor re-opening
Date:   Tue, 20 Aug 2019 13:34:01 +1000
Message-Id: <20190820033406.29796-4-cyphar@cyphar.com>
In-Reply-To: <20190820033406.29796-1-cyphar@cyphar.com>
References: <20190820033406.29796-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userspace has made use of /proc/self/fd very liberally to allow for
descriptors to be re-opened. There are a wide variety of uses for this
feature, but it has always required constructing a pathname and could
not be done without procfs mounted. The obvious solution for this is to
extend openat(2) to have an AT_EMPTY_PATH-equivalent -- O_EMPTYPATH.

Now that descriptor re-opening has been made safe through the new
magic-link resolution restrictions, we can replicate these restrictions
for O_EMPTYPATH. In particular, we only allow "upgrading" the file
descriptor if the corresponding FMODE_PATH_* bit is set (or the
FMODE_{READ,WRITE} cases for non-O_PATH file descriptors).

When doing openat(O_EMPTYPATH|O_PATH), O_PATH takes precedence and
O_EMPTYPATH is ignored. Very few users ever have a need to O_PATH
re-open an existing file descriptor, and so accommodating them at the
expense of further complicating O_PATH makes little sense. Ultimately,
if users ask for this we can always add RESOLVE_EMPTY_PATH to
resolveat(2) in the future.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/alpha/include/uapi/asm/fcntl.h  |  1 +
 arch/parisc/include/uapi/asm/fcntl.h | 39 ++++++++++++++--------------
 arch/sparc/include/uapi/asm/fcntl.h  |  1 +
 fs/fcntl.c                           |  2 +-
 fs/namei.c                           | 20 ++++++++++++++
 fs/open.c                            |  7 ++++-
 include/linux/fcntl.h                |  2 +-
 include/uapi/asm-generic/fcntl.h     |  4 +++
 8 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..1f879bade68b 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define O_EMPTYPATH	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03ce20e5ad7d..5d709058a76f 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -2,26 +2,27 @@
 #ifndef _PARISC_FCNTL_H
 #define _PARISC_FCNTL_H
 
-#define O_APPEND	000000010
-#define O_BLKSEEK	000000100 /* HPUX only */
-#define O_CREAT		000000400 /* not fcntl */
-#define O_EXCL		000002000 /* not fcntl */
-#define O_LARGEFILE	000004000
-#define __O_SYNC	000100000
+#define O_APPEND	0000000010
+#define O_BLKSEEK	0000000100 /* HPUX only */
+#define O_CREAT		0000000400 /* not fcntl */
+#define O_EXCL		0000002000 /* not fcntl */
+#define O_LARGEFILE	0000004000
+#define __O_SYNC	0000100000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_NONBLOCK	000200004 /* HPUX has separate NDELAY & NONBLOCK */
-#define O_NOCTTY	000400000 /* not fcntl */
-#define O_DSYNC		001000000 /* HPUX only */
-#define O_RSYNC		002000000 /* HPUX only */
-#define O_NOATIME	004000000
-#define O_CLOEXEC	010000000 /* set close_on_exec */
-
-#define O_DIRECTORY	000010000 /* must be a directory */
-#define O_NOFOLLOW	000000200 /* don't follow links */
-#define O_INVISIBLE	004000000 /* invisible I/O, for DMAPI/XDSM */
-
-#define O_PATH		020000000
-#define __O_TMPFILE	040000000
+#define O_NONBLOCK	0000200004 /* HPUX has separate NDELAY & NONBLOCK */
+#define O_NOCTTY	0000400000 /* not fcntl */
+#define O_DSYNC		0001000000 /* HPUX only */
+#define O_RSYNC		0002000000 /* HPUX only */
+#define O_NOATIME	0004000000
+#define O_CLOEXEC	0010000000 /* set close_on_exec */
+
+#define O_DIRECTORY	0000010000 /* must be a directory */
+#define O_NOFOLLOW	0000000200 /* don't follow links */
+#define O_INVISIBLE	0004000000 /* invisible I/O, for DMAPI/XDSM */
+
+#define O_PATH		0020000000
+#define __O_TMPFILE	0040000000
+#define O_EMPTYPATH	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..dc86c9eaf950 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define O_EMPTYPATH	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..4cf05a2fd162 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 54d57dad0f91..e39b573fcc4d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3571,6 +3571,24 @@ static int trailing_magiclink(struct nameidata *nd, int acc_mode,
 	return may_open_magiclink(upgrade_mask, acc_mode);
 }
 
+static int do_emptypath(struct nameidata *nd, const struct open_flags *op,
+			struct file *file)
+{
+	int error;
+	/* We don't support AT_FDCWD (since O_PATH is disallowed here). */
+	struct fd f = fdget_raw(nd->dfd);
+
+	if (!f.file)
+		return -EBADF;
+
+	/* Apply trailing_magiclink()-like restrictions. */
+	error = may_open_magiclink(f.file->f_mode, op->acc_mode);
+	if (!error)
+		error = vfs_open(&f.file->f_path, file);
+	fdput(f);
+	return error;
+}
+
 static struct file *path_openat(struct nameidata *nd,
 			const struct open_flags *op, unsigned flags)
 {
@@ -3583,6 +3601,8 @@ static struct file *path_openat(struct nameidata *nd,
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file);
+	} else if (unlikely(file->f_flags & O_EMPTYPATH)) {
+		error = do_emptypath(nd, op, file);
 	} else if (unlikely(file->f_flags & O_PATH)) {
 		/* Inlined path_lookupat() with a trailing_magiclink() check. */
 		fmode_t opath_mask = op->opath_mask;
diff --git a/fs/open.c b/fs/open.c
index 806a75d685e1..310b896eecf0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1015,6 +1015,8 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_EMPTYPATH)
+		lookup_flags |= LOOKUP_EMPTY;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
@@ -1076,14 +1078,17 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
 	int fd = build_open_flags(flags, mode, &op);
+	int empty = 0;
 	struct filename *tmp;
 
 	if (fd)
 		return fd;
 
-	tmp = getname(filename);
+	tmp = getname_flags(filename, op.lookup_flags, &empty);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
+	if (!empty)
+		op.open_flag &= ~O_EMPTYPATH;
 
 	fd = get_unused_fd_flags(flags);
 	if (fd >= 0) {
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index d019df946cb2..2868ae6c8fc1 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..ae6862f69cc2 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH 040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.22.0

