Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADF6115B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGFO7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 10:59:18 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34144 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfGFO7S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:59:18 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A17F3A01A1;
        Sat,  6 Jul 2019 16:59:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id U_6b85_iy2Pe; Sat,  6 Jul 2019 16:59:05 +0200 (CEST)
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
Subject: [PATCH v9 03/10] open: O_EMPTYPATH: procfs-less file descriptor re-opening
Date:   Sun,  7 Jul 2019 00:57:30 +1000
Message-Id: <20190706145737.5299-4-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-1-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
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
 fs/fcntl.c                       |  2 +-
 fs/namei.c                       | 27 +++++++++++++++++++++++++++
 fs/open.c                        |  7 ++++++-
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  5 +++++
 5 files changed, 40 insertions(+), 3 deletions(-)

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
index 4ec6168762db..4895717d2760 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3605,6 +3605,31 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	return error;
 }
 
+static int do_o_emptypath(struct nameidata *nd, struct file *newfile)
+{
+	int error;
+	struct fd f;
+
+	/* We don't support AT_FDCWD since O_PATH cannot be set here. */
+	f = fdget_raw(nd->dfd);
+	if (!f.file)
+		return -EBADF;
+
+	/* Update opath_mask as though we went through trailing_symlink(). */
+	if (!(f.file->f_mode & (FMODE_READ | FMODE_PATH_READ)))
+		nd->opath_mask &= ~FMODE_PATH_READ;
+	if (!(f.file->f_mode & (FMODE_WRITE | FMODE_PATH_WRITE)))
+		nd->opath_mask &= ~FMODE_PATH_WRITE;
+
+	/* Obey the same restrictions as magic-links. */
+	error = may_open_magiclink(f.file->f_mode, nd->acc_mode);
+	if (!error)
+		error = vfs_open(&f.file->f_path, newfile);
+
+	fdput(f);
+	return error;
+}
+
 static struct file *path_openat(struct nameidata *nd,
 			const struct open_flags *op, unsigned flags)
 {
@@ -3620,6 +3645,8 @@ static struct file *path_openat(struct nameidata *nd,
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file);
+	} else if (unlikely(file->f_flags & O_EMPTYPATH)) {
+		error = do_o_emptypath(nd, file);
 	} else if (unlikely(file->f_flags & O_PATH)) {
 		error = do_o_path(nd, flags, file);
 	} else {
diff --git a/fs/open.c b/fs/open.c
index ab20eae39df7..bdca45528524 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -996,6 +996,8 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_EMPTYPATH)
+		lookup_flags |= LOOKUP_EMPTY;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
@@ -1057,14 +1059,17 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
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
index 9dc0bf0c5a6e..307f7c414a51 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,11 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH 040000000
+#endif
+
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.22.0

