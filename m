Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9E611A1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGFPAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 11:00:37 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:36890 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfGFPAh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:00:37 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CF45FA0211;
        Sat,  6 Jul 2019 17:00:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id F_spb3gDdDok; Sat,  6 Jul 2019 17:00:26 +0200 (CEST)
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
Subject: [PATCH v9 08/10] open: openat2(2) syscall
Date:   Sun,  7 Jul 2019 00:57:35 +1000
Message-Id: <20190706145737.5299-9-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-1-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The most obvious syscall to add support for the new LOOKUP_* scoping
flags would be openat(2). However, there are a few reasons to not do
this:

 * The new LOOKUP_* flags are intended to be security features, and
   openat(2) will silently ignore all unknown flags. This means that
   users would need to avoid foot-gunning themselves constantly when
   using this interface if it were part of openat(2).

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
there is no UPGRADE_NOEXEC.

Co-developed-by: Christian Brauner <christian@brauner.io>
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
 fs/open.c                                   | 136 ++++++++++++++------
 include/linux/fcntl.h                       |  15 ++-
 include/linux/fs.h                          |   4 +-
 include/linux/syscalls.h                    |  14 +-
 include/uapi/asm-generic/unistd.h           |   5 +-
 include/uapi/linux/fcntl.h                  |  38 ++++++
 24 files changed, 186 insertions(+), 46 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 9e7704e44f6d..1703d048c141 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -461,6 +461,7 @@
 530	common	getegid				sys_getegid
 531	common	geteuid				sys_geteuid
 532	common	getppid				sys_getppid
+533	common	openat2				sys_openat2
 # all other architectures have common numbers for new syscall, alpha
 # is the exception.
 534	common	pidfd_send_signal		sys_pidfd_send_signal
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..4ad262698396 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -447,3 +447,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index c9f8dd421c5f..0d4aa3e5389e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -33,7 +33,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		434
+#define __NR_compat_syscalls		435
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index aa995920bd34..b134419c0421 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -875,6 +875,8 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_openat2 434
+__SYSCALL(__NR_openat2, sys_openat2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e01df3f2f80d..28d954acf214 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -354,3 +354,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7e3d0734b2f3..b744b1a1c80e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..bee07b73a898 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0e2dd68ade57..a3ec5e27630a 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -372,3 +372,4 @@
 431	n32	fsconfig			sys_fsconfig
 432	n32	fsmount				sys_fsmount
 433	n32	fspick				sys_fspick
+434	n32	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 5eebfa0d155c..3503ac6ef482 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -348,3 +348,4 @@
 431	n64	fsconfig			sys_fsconfig
 432	n64	fsmount				sys_fsmount
 433	n64	fspick				sys_fspick
+434	n64	openat2				sys_openat2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3cc1374e02d0..e901367371c4 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -421,3 +421,4 @@
 431	o32	fsconfig			sys_fsconfig
 432	o32	fsmount				sys_fsmount
 433	o32	fspick				sys_fspick
+434	o32	openat2				sys_openat2			sys_openat2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c9e377d59232..5758b0826e4d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 103655d84b4b..9e8377d5b2f6 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e822b2964a83..d6e8eaa20d44 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431  common	fsconfig		sys_fsconfig			sys_fsconfig
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
+434  common	openat2			sys_openat2			sys_openat2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 016a727d4357..dc38733d264b 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e047480b1605..cfeb24ac5299 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2			sys_openat2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..1d76a0e84f42 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	openat2			sys_openat2			__ia32_sys_openat2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..828bade2e505 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	openat2			__x64_sys_openat2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..78ed6e97d3ae 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -404,3 +404,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	openat2				sys_openat2
diff --git a/fs/open.c b/fs/open.c
index bdca45528524..63278294d1d4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -928,24 +928,32 @@ struct file *open_with_fake_path(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(open_with_fake_path);
 
-static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
+static inline int build_open_flags(struct open_how how, struct open_flags *op)
 {
 	int lookup_flags = 0;
-	int acc_mode = ACC_MODE(flags);
+	int opath_mask = 0;
+	int acc_mode = ACC_MODE(how.flags);
+
+	if (how.resolve & ~VALID_RESOLVE_FLAGS)
+		return -EINVAL;
+	if (!(how.flags & (O_PATH | O_CREAT | __O_TMPFILE)) && how.mode != 0)
+		return -EINVAL;
+	if (memchr_inv(how.reserved, 0, sizeof(how.reserved)))
+		return -EINVAL;
 
 	/*
 	 * Clear out all open flags we don't know about so that we don't report
 	 * them in fcntl(F_GETFD) or similar interfaces.
 	 */
-	flags &= VALID_OPEN_FLAGS;
+	how.flags &= VALID_OPEN_FLAGS;
 
-	if (flags & (O_CREAT | __O_TMPFILE))
-		op->mode = (mode & S_IALLUGO) | S_IFREG;
+	if (how.flags & (O_CREAT | __O_TMPFILE))
+		op->mode = (how.mode & S_IALLUGO) | S_IFREG;
 	else
 		op->mode = 0;
 
 	/* Must never be set by userspace */
-	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
+	how.flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
 
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
@@ -953,51 +961,70 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 	 * always set instead of having to deal with possibly weird behaviour
 	 * for malicious applications setting only __O_SYNC.
 	 */
-	if (flags & __O_SYNC)
-		flags |= O_DSYNC;
+	if (how.flags & __O_SYNC)
+		how.flags |= O_DSYNC;
 
-	if (flags & __O_TMPFILE) {
-		if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
+	if (how.flags & __O_TMPFILE) {
+		if ((how.flags & O_TMPFILE_MASK) != O_TMPFILE)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
-	} else if (flags & O_PATH) {
+	} else if (how.flags & O_PATH) {
 		/*
 		 * If we have O_PATH in the open flag. Then we
 		 * cannot have anything other than the below set of flags
 		 */
-		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
+		how.flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
 		acc_mode = 0;
+
+		/* Allow userspace to restrict the re-opening of O_PATH fds. */
+		if (how.upgrade_mask & ~VALID_UPGRADE_FLAGS)
+			return -EINVAL;
+		if (!(how.upgrade_mask & UPGRADE_NOREAD))
+			opath_mask |= FMODE_PATH_READ;
+		if (!(how.upgrade_mask & UPGRADE_NOWRITE))
+			opath_mask |= FMODE_PATH_WRITE;
 	}
 
-	op->open_flag = flags;
+	op->open_flag = how.flags;
 
 	/* O_TRUNC implies we need access checks for write permissions */
-	if (flags & O_TRUNC)
+	if (how.flags & O_TRUNC)
 		acc_mode |= MAY_WRITE;
 
 	/* Allow the LSM permission hook to distinguish append
 	   access from general write access. */
-	if (flags & O_APPEND)
+	if (how.flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
 	op->acc_mode = acc_mode;
-	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
-	/* For O_PATH backwards-compatibility we default to an all-set mask. */
-	op->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
+	op->intent = how.flags & O_PATH ? 0 : LOOKUP_OPEN;
+	op->opath_mask = opath_mask;
 
-	if (flags & O_CREAT) {
+	if (how.flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
-		if (flags & O_EXCL)
+		if (how.flags & O_EXCL)
 			op->intent |= LOOKUP_EXCL;
 	}
 
-	if (flags & O_DIRECTORY)
+	if (how.flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
-	if (!(flags & O_NOFOLLOW))
+	if (!(how.flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
-	if (flags & O_EMPTYPATH)
+	if (how.flags & O_EMPTYPATH)
 		lookup_flags |= LOOKUP_EMPTY;
+
+	if (how.resolve & RESOLVE_NO_XDEV)
+		lookup_flags |= LOOKUP_XDEV;
+	if (how.resolve & RESOLVE_NO_MAGICLINKS)
+		lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	if (how.resolve & RESOLVE_NO_SYMLINKS)
+		lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (how.resolve & RESOLVE_BENEATH)
+		lookup_flags |= LOOKUP_BENEATH;
+	if (how.resolve & RESOLVE_IN_ROOT)
+		lookup_flags |= LOOKUP_IN_ROOT;
+
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
@@ -1016,8 +1043,14 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 struct file *file_open_name(struct filename *name, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
-	return err ? ERR_PTR(err) : do_filp_open(AT_FDCWD, name, &op);
+	struct open_how how = {
+		.flags = flags,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	int err = build_open_flags(how, &op);
+	if (err)
+		return ERR_PTR(err);
+	return do_filp_open(AT_FDCWD, name, &op);
 }
 
 /**
@@ -1048,17 +1081,22 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 			    const char *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
+	struct open_how how = {
+		.flags = flags,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	int err = build_open_flags(how, &op);
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
+	int fd = build_open_flags(*how, &op);
 	int empty = 0;
 	struct filename *tmp;
 
@@ -1071,7 +1109,7 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 	if (!empty)
 		op.open_flag &= ~O_EMPTYPATH;
 
-	fd = get_unused_fd_flags(flags);
+	fd = get_unused_fd_flags(how->flags);
 	if (fd >= 0) {
 		struct file *f = do_filp_open(dfd, tmp, &op);
 		if (IS_ERR(f)) {
@@ -1088,19 +1126,35 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 
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
+		.flags = flags,
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
@@ -1110,7 +1164,11 @@ SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
  */
 COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
+	struct open_how how = {
+		.flags = flags,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	return do_sys_open(AT_FDCWD, filename, &how);
 }
 
 /*
@@ -1119,7 +1177,11 @@ COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t,
  */
 COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return do_sys_open(dfd, filename, flags, mode);
+	struct open_how how = {
+		.flags = flags,
+		.mode = OPENHOW_MODE(flags, mode),
+	};
+	return do_sys_open(dfd, filename, &how);
 }
 #endif
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 2868ae6c8fc1..e59917292213 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -4,13 +4,26 @@
 
 #include <uapi/linux/fcntl.h>
 
-/* list of all valid flags for the open/openat flags argument: */
+/* Should open_how.mode be set for older syscalls wrappers? */
+#define OPENHOW_MODE(flags, mode) \
+	(((flags) | (O_CREAT | __O_TMPFILE)) ? (mode) : 0)
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
index f7df213405ea..a3aede2b3a91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2515,8 +2515,8 @@ extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
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
index 2bcef4c70183..227303532bb7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1369,15 +1369,21 @@ static inline int ksys_close(unsigned int fd)
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
+		.flags = flags,
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
index a87904daf103..67486188918b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -845,8 +845,11 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
 
+#define __NR_openat2 435
+__SYSCALL(__NR_openat2, sys_openat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..b7c904f0fca9 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -93,5 +93,43 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/**
+ * Arguments for how openat2(2) should open the target path. If @extra is zero,
+ * then openat2(2) is identical to openat(2).
+ *
+ * @flags: O_* flags (unknown flags ignored).
+ * @mode: O_CREAT file mode (ignored otherwise).
+ * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored otherwise).
+ * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
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

