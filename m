Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCD77D03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbfG1BJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 21:09:24 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:55686 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfG1BJY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 21:09:24 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A33E4A1C0F;
        Sun, 28 Jul 2019 03:09:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id TuVfRFvZMo2r; Sun, 28 Jul 2019 03:09:07 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
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
Subject: [PATCH v11 7/8] open: openat2(2) syscall
Date:   Sun, 28 Jul 2019 11:02:06 +1000
Message-Id: <20190728010207.9781-8-cyphar@cyphar.com>
In-Reply-To: <20190728010207.9781-1-cyphar@cyphar.com>
References: <20190728010207.9781-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The most obvious syscall to add support for the new LOOKUP_* scoping
flags would be openat(2). However, there are a few reasons why this is
not the best course of action:

 * The new LOOKUP_* flags are intended to be security features, and
   openat(2) will silently ignore all unknown flags. This means that
   users would need to avoid foot-gunning themselves constantly when
   using this interface if it were part of openat(2). This can be fixed
   by having userspace libraries handle this for users[1], but should be
   avoided if possible.

 * Resolution scoping feels like a different operation to the existing
   O_* flags. And since openat(2) has limited flag space, it seems to be
   quite wasteful to clutter it with 5 flags that are all
   resolution-related. Arguably O_NOFOLLOW is also a resolution flag but
   its entire purpose is to error out if you encounter a trailing
   symlink -- not to scope resolution.

 * Other systems would be able to reimplement this syscall allowing for
   cross-OS standardisation rather than being hidden amongst O_* flags
   which may result in it not being used by all the parties that might
   want to use it (file servers, web servers, container runtimes, etc).

 * It gives us the opportunity to iterate on the O_PATH interface. In
   particular, the new @how->upgrade_mask field for fd re-opening is
   only possible because we have a clean slate without needing to re-use
   the ACC_MODE flag design nor the existing openat(2) @mode semantics.

To this end, we introduce the openat2(2) syscall. It provides all of the
features of openat(2) through the @how->flags argument, but also
also provides a new @how->resolve argument which exposes RESOLVE_* flags
that map to our new LOOKUP_* flags. It also eliminates the long-standing
ugliness of variadic-open(2) by embedding it in a struct.

In order to allow for userspace to lock down their usage of file
descriptor re-opening, openat2(2) has the ability for users to disallow
certain re-opening modes through @how->upgrade_mask. At the moment,
there is no UPGRADE_NOEXEC. The open_how struct is padded to 64 bytes
for future extensions (all of the reserved bits must be zeroed).

[1]: https://github.com/openSUSE/libpathrs

Suggested-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/open.c                                   | 106 ++++++++++++++++----
 include/linux/fcntl.h                       |  15 ++-
 include/linux/fs.h                          |   4 +-
 include/linux/syscalls.h                    |  17 +++-
 include/uapi/asm-generic/unistd.h           |   5 +-
 include/uapi/linux/fcntl.h                  |  42 ++++++++
 24 files changed, 179 insertions(+), 30 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 728fe028c02c..9f374f7d9514 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
 # 545 reserved for clone3
+547	common	openat2				sys_openat2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 6da7dc4d79cc..4ba54bc7e19a 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -449,3 +449,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 2629a68b8724..8aa00ccb0b96 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		436
+#define __NR_compat_syscalls		438
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 94ab29cf4f00..57f6f592d460 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -879,6 +879,8 @@ __SYSCALL(__NR_fspick, sys_fspick)
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 36d5faf4c86c..8d36f2e2dc89 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -356,3 +356,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2				sys_openat2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index a88a285a0e5f..2559925f1924 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2				sys_openat2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 09b0cd7dab0a..c04385e60833 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index c9c879ec9b6d..ba06cae655c6 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -374,3 +374,4 @@
 433	n32	fspick				sys_fspick
 434	n32	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	n32	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index bbce9159caa1..0f3de320ae51 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -350,3 +350,4 @@
 433	n64	fspick				sys_fspick
 434	n64	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	n64	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 9653591428ec..f108464d09a3 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -423,3 +423,4 @@
 433	o32	fspick				sys_fspick
 434	o32	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	o32	openat2				sys_openat2			sys_openat2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 670d1371aca1..45ddc4485844 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -432,3 +432,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3_wrapper
+437	common	openat2				sys_openat2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 3331749aab20..a89952a4bc7f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2				sys_openat2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a90d3e945445..23a50a776a91 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437  common	openat2			sys_openat2			sys_openat2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index b5ed26c4c005..a7185cc18626 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2				sys_openat2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c8cc7537fb2..b11c19552022 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2			sys_openat2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c00019abd076..dfa1dc5c8587 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
+437	i386	openat2			sys_openat2			__ia32_sys_openat2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..9035647ef236 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+437	common	openat2			__x64_sys_openat2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 25f4de729a6d..f0a68013c038 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -406,3 +406,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
diff --git a/fs/open.c b/fs/open.c
index bdca45528524..062761136f21 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -928,19 +928,29 @@ struct file *open_with_fake_path(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(open_with_fake_path);
 
-static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
+static inline int build_open_flags(const struct open_how *how,
+				   struct open_flags *op)
 {
+	int flags = how->flags;
 	int lookup_flags = 0;
+	int opath_mask = 0;
 	int acc_mode = ACC_MODE(flags);
 
 	/*
-	 * Clear out all open flags we don't know about so that we don't report
-	 * them in fcntl(F_GETFD) or similar interfaces.
+	 * Older syscalls still clear these bits before calling
+	 * build_open_flags(), but openat2(2) checks all its arguments.
 	 */
-	flags &= VALID_OPEN_FLAGS;
+	if (flags & ~VALID_OPEN_FLAGS)
+		return -EINVAL;
+	if (how->resolve & ~VALID_RESOLVE_FLAGS)
+		return -EINVAL;
+	if (!(how->flags & (O_PATH | O_CREAT | __O_TMPFILE)) && how->mode != 0)
+		return -EINVAL;
+	if (memchr_inv(how->reserved, 0, sizeof(how->reserved)))
+		return -EINVAL;
 
 	if (flags & (O_CREAT | __O_TMPFILE))
-		op->mode = (mode & S_IALLUGO) | S_IFREG;
+		op->mode = (how->mode & S_IALLUGO) | S_IFREG;
 	else
 		op->mode = 0;
 
@@ -968,6 +978,14 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		 */
 		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
 		acc_mode = 0;
+
+		/* Allow userspace to restrict the re-opening of O_PATH fds. */
+		if (how->upgrade_mask & ~VALID_UPGRADE_FLAGS)
+			return -EINVAL;
+		if (!(how->upgrade_mask & UPGRADE_NOREAD))
+			opath_mask |= FMODE_PATH_READ;
+		if (!(how->upgrade_mask & UPGRADE_NOWRITE))
+			opath_mask |= FMODE_PATH_WRITE;
 	}
 
 	op->open_flag = flags;
@@ -983,8 +1001,7 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 
 	op->acc_mode = acc_mode;
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
-	/* For O_PATH backwards-compatibility we default to an all-set mask. */
-	op->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
+	op->opath_mask = opath_mask;
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
@@ -998,6 +1015,18 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_FOLLOW;
 	if (flags & O_EMPTYPATH)
 		lookup_flags |= LOOKUP_EMPTY;
+
+	if (how->resolve & RESOLVE_NO_XDEV)
+		lookup_flags |= LOOKUP_NO_XDEV;
+	if (how->resolve & RESOLVE_NO_MAGICLINKS)
+		lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	if (how->resolve & RESOLVE_NO_SYMLINKS)
+		lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (how->resolve & RESOLVE_BENEATH)
+		lookup_flags |= LOOKUP_BENEATH;
+	if (how->resolve & RESOLVE_IN_ROOT)
+		lookup_flags |= LOOKUP_IN_ROOT;
+
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
@@ -1016,8 +1045,14 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 struct file *file_open_name(struct filename *name, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
-	return err ? ERR_PTR(err) : do_filp_open(AT_FDCWD, name, &op);
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	int err = build_open_flags(&how, &op);
+	if (err)
+		return ERR_PTR(err);
+	return do_filp_open(AT_FDCWD, name, &op);
 }
 
 /**
@@ -1048,17 +1083,22 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 			    const char *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	int err = build_open_flags(&how, &op);
 	if (err)
 		return ERR_PTR(err);
 	return do_file_open_root(dentry, mnt, filename, &op);
 }
 EXPORT_SYMBOL(file_open_root);
 
-long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
+long do_sys_open(int dfd, const char __user *filename,
+		 struct open_how *how)
 {
 	struct open_flags op;
-	int fd = build_open_flags(flags, mode, &op);
+	int fd = build_open_flags(how, &op);
 	int empty = 0;
 	struct filename *tmp;
 
@@ -1071,7 +1111,7 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 	if (!empty)
 		op.open_flag &= ~O_EMPTYPATH;
 
-	fd = get_unused_fd_flags(flags);
+	fd = get_unused_fd_flags(how->flags);
 	if (fd >= 0) {
 		struct file *f = do_filp_open(dfd, tmp, &op);
 		if (IS_ERR(f)) {
@@ -1088,19 +1128,35 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 
 SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
-	if (force_o_largefile())
-		flags |= O_LARGEFILE;
-
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
+	return ksys_open(filename, flags, mode);
 }
 
 SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
 		umode_t, mode)
 {
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+
+	if (force_o_largefile())
+		how.flags |= O_LARGEFILE;
+
+	return do_sys_open(dfd, filename, &how);
+}
+
+SYSCALL_DEFINE3(openat2, int, dfd, const char __user *, filename,
+		const struct open_how __user *, how)
+{
+	struct open_how tmp;
+
+	if (copy_from_user(&tmp, how, sizeof(tmp)))
+		return -EFAULT;
+
 	if (force_o_largefile())
-		flags |= O_LARGEFILE;
+		tmp.flags |= O_LARGEFILE;
 
-	return do_sys_open(dfd, filename, flags, mode);
+	return do_sys_open(dfd, filename, &tmp);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1110,7 +1166,11 @@ SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
  */
 COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	return do_sys_open(AT_FDCWD, filename, &how);
 }
 
 /*
@@ -1119,7 +1179,11 @@ COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t,
  */
 COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return do_sys_open(dfd, filename, flags, mode);
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	return do_sys_open(dfd, filename, &how);
 }
 #endif
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 2868ae6c8fc1..f7f378e1f43c 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -4,13 +4,26 @@
 
 #include <uapi/linux/fcntl.h>
 
-/* list of all valid flags for the open/openat flags argument: */
+/* Should open_how.mode be set for older syscalls wrappers? */
+#define OPENHOW_MODE(flags, mode) \
+	(((flags) & (O_CREAT | __O_TMPFILE)) ? (mode) : 0)
+
+/* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
 
+/* List of all valid flags for the how->upgrade_mask argument: */
+#define VALID_UPGRADE_FLAGS \
+	(UPGRADE_NOWRITE | UPGRADE_NOREAD)
+
+/* List of all valid flags for the how->resolve argument: */
+#define VALID_RESOLVE_FLAGS \
+	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dc0f5660af43..88f51af9ecb6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2498,8 +2498,8 @@ extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
 		       struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
-			umode_t mode);
+extern long do_sys_open(int dfd, const char __user *filename,
+			struct open_how *how);
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 88145da7d140..a4f2f135001e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ struct rseq;
 union bpf_attr;
 struct io_uring_params;
 struct clone_args;
+struct open_how;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -439,6 +440,8 @@ asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   umode_t mode);
+asmlinkage long sys_openat2(int dfd, const char __user *filename,
+			    const struct open_how *how);
 asmlinkage long sys_close(unsigned int fd);
 asmlinkage long sys_vhangup(void);
 
@@ -1374,15 +1377,21 @@ static inline int ksys_close(unsigned int fd)
 	return __close_fd(current->files, fd);
 }
 
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
-			umode_t mode);
+extern long do_sys_open(int dfd, const char __user *filename,
+			struct open_how *how);
 
 static inline long ksys_open(const char __user *filename, int flags,
 			     umode_t mode)
 {
+	struct open_how how = {
+		.flags = flags & VALID_OPEN_FLAGS,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+
 	if (force_o_largefile())
-		flags |= O_LARGEFILE;
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
+		how.flags |= O_LARGEFILE;
+
+	return do_sys_open(AT_FDCWD, filename, &how);
 }
 
 extern long do_sys_truncate(const char __user *pathname, loff_t length);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1be0e798e362..b28c11b338ee 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -851,8 +851,11 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
 
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 438
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..ebfc97b3d8aa 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -93,5 +93,47 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/**
+ * Arguments for how openat2(2) should open the target path. If @resolve is
+ * zero, then openat2(2) operates identically to openat(2).
+ *
+ * However, unlike openat(2), unknown bits in @flags result in -EINVAL rather
+ * than being silently ignored. In addition, @mode (or @upgrade_mask) must be
+ * zero unless one of {O_CREAT, O_TMPFILE, O_PATH} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @upgrade_mask: UPGRADE_* flags (to restrict O_PATH re-opening).
+ * @resolve: RESOLVE_* flags.
+ * @reserved: reserved for future extensions, must be zeroed.
+ */
+struct open_how {
+	__u32 flags;
+	union {
+		__u16 mode;
+		__u16 upgrade_mask;
+	};
+	__u16 resolve;
+	__u64 reserved[7]; /* must be zeroed */
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+/* how->upgrade flags for openat2(2). */
+/* First bit is reserved for a future UPGRADE_NOEXEC flag. */
+#define UPGRADE_NOREAD		0x02 /* Block re-opening with MAY_READ. */
+#define UPGRADE_NOWRITE		0x04 /* Block re-opening with MAY_WRITE. */
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.22.0

