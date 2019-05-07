Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4AD16842
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEGQoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 12:44:38 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:36094 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfEGQoi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 12:44:38 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A3289A10AF;
        Tue,  7 May 2019 18:44:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id hJ64cGgf98uT; Tue,  7 May 2019 18:44:29 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
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
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v7 5/5] namei: resolveat(2) syscall
Date:   Wed,  8 May 2019 02:43:17 +1000
Message-Id: <20190507164317.13562-6-cyphar@cyphar.com>
In-Reply-To: <20190507164317.13562-1-cyphar@cyphar.com>
References: <20190507164317.13562-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The most obvious syscall to add support for the new LOOKUP_* scoping
flags would be openat(2) (along with the required execveat(2) change
included in this series). However, there are a few reasons to not do
this:

 * The new LOOKUP_* flags are intended to be security features, and
   openat(2) will silently ignore all unknown flags. This means that
   users would need to avoid foot-gunning themselves constantly when
   using this interface if it were part of openat(2).

 * Resolution scoping feels like a different operation to the existing
   O_* flags. And since openat(2) has limited flag space, it seems to be
   quite wasteful to clutter it with 5 flags that are all
   resolution-related. Arguably O_NOFOLLOw is also a resolution flag but
   its entire purpose is to error out if you encounter a trailing
   symlink not to scope resolution.

 * Other systems would be able to reimplement this syscall allowing for
   cross-OS standardisation rather than being hidden amongst O_* flags
   which may result in it not being used by all the parties that might
   want to use it (file servers, web servers, container runtimes, etc).

 * It gives us the opportunity to iterate on the O_PATH interface in the
   future. There are some potential security improvements that can be
   made to O_PATH (handling /proc/self/fd re-opening of file descriptors
   much more sanely) which could be made even better with some other
   bits (such as ACC_MODE bits which work for O_PATH).

To this end, we introduce the resolveat(2) syscall. At the moment it's
effectively another way of getting a bog-standard O_PATH descriptor but
with the ability to use the new LOOKUP_* flags.

Because resolveat(2) only provides the ability to get O_PATH
descriptors, users will need to get creative with /proc/self/fd in order
to get a usable file descriptor for other uses. However, in future we
can add O_EMPTYPATH support to openat(2) which would allow for
re-opening without procfs (though as mentioned above there are some
security improvements that should be made to the interfaces).

NOTE: This patch adds the syscall to all architectures using the new
      unified syscall numbering, but several architectures are missing
      newer (nr > 423) syscalls -- hence the uneven gaps in the syscall
      tables.

Cc: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/namei.c                                  | 46 +++++++++++++++++++++
 include/uapi/linux/fcntl.h                  | 13 ++++++
 18 files changed, 75 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 63ed39cbd3bd..72f431b1dc9c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -461,5 +461,6 @@
 530	common	getegid				sys_getegid
 531	common	geteuid				sys_geteuid
 532	common	getppid				sys_getppid
+533	common	resolveat			sys_resolveat
 # all other architectures have common numbers for new syscall, alpha
 # is the exception.
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 9016f4081bb9..1bc0282a67f7 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -437,3 +437,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index ab9cda5f6136..d3ae73ffaf48 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -344,3 +344,4 @@
 332	common	pkey_free			sys_pkey_free
 333	common	rseq				sys_rseq
 # 334 through 423 are reserved to sync up with other architectures
+428	common	resolveat			sys_resolveat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 125c14178979..81b7389e9e58 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 8ee3a8c18498..626aed10e2b5 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -429,3 +429,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 15f4117900ee..8cbd6032d6bf 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -362,3 +362,4 @@
 421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
 422	n32	futex_time64			sys_futex
 423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	n32	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c85502e67b44..234923a1fc88 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -338,3 +338,4 @@
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
+428	n64	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2e063d0f837e..7b4586acf35d 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -411,3 +411,4 @@
 421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	o32	futex_time64			sys_futex			sys_futex
 423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+428	o32	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b26766c6647d..19a9a92dc5f8 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -420,3 +420,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b18abb0c3dae..bfcd75b928de 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -505,3 +505,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 02579f95f391..084e51f02e65 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -426,3 +426,4 @@
 421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64		-				sys_futex
 423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+428	common	resolveat		sys_resolveat			-
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bfda678576e4..e9115c5cec72 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -426,3 +426,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b9a5a04b2d2c..2d3fdd913d89 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..101feef22473 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	resolveat		sys_resolveat			__ia32_sys_resolveat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..c7c197bf07bc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	resolveat		__x64_sys_resolveat
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6af49929de85..86c44f15dfa4 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -394,3 +394,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+428	common	resolveat			sys_resolveat
diff --git a/fs/namei.c b/fs/namei.c
index 2b6a1bf4e745..2cc5b171f6ec 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3656,6 +3656,52 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 	return filp;
 }
 
+SYSCALL_DEFINE3(resolveat, int, dfd, const char __user *, path,
+		unsigned long, flags)
+{
+	int fd;
+	struct filename *tmp;
+	struct open_flags op = {
+		.open_flag = O_PATH,
+	};
+
+	if (flags & ~VALID_RESOLVE_FLAGS)
+		return -EINVAL;
+
+	if (flags & RESOLVE_CLOEXEC)
+		op.open_flag |= O_CLOEXEC;
+	if (!(flags & RESOLVE_NOFOLLOW))
+		op.lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & RESOLVE_BENEATH)
+		op.lookup_flags |= LOOKUP_BENEATH;
+	if (flags & RESOLVE_XDEV)
+		op.lookup_flags |= LOOKUP_XDEV;
+	if (flags & RESOLVE_NO_MAGICLINKS)
+		op.lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	if (flags & RESOLVE_NO_SYMLINKS)
+		op.lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (flags & RESOLVE_IN_ROOT)
+		op.lookup_flags |= LOOKUP_IN_ROOT;
+
+	tmp = getname(path);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	fd = get_unused_fd_flags(op.open_flag);
+	if (fd >= 0) {
+		struct file *f = do_filp_open(dfd, tmp, &op);
+		if (IS_ERR(f)) {
+			put_unused_fd(fd);
+			fd = PTR_ERR(f);
+		} else {
+			fsnotify_open(f);
+			fd_install(fd, f);
+		}
+	}
+	putname(tmp);
+	return fd;
+}
+
 struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 		const char *name, const struct open_flags *op)
 {
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..c57245a21281 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -94,4 +94,17 @@
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
 
+/* Bottom 3 bits of RESOLVE_* are reserved for future ACC_MODE extensions. */
+#define RESOLVE_CLOEXEC		0x008 /* Set O_CLOEXEC on the returned fd. */
+#define RESOLVE_NOFOLLOW	0x010 /* Don't follow trailing symlinks. */
+
+#define RESOLVE_RESOLUTION_TYPE	0x3E0 /* Type of path-resolution scoping we are applying. */
+#define RESOLVE_BENEATH		0x020 /* - Block "lexical" trickery like "..", symlinks, absolute paths, etc. */
+#define RESOLVE_XDEV		0x040 /* - Block mount-point crossings (includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x080 /* - Block procfs-style "magic" symlinks. */
+#define RESOLVE_NO_SYMLINKS	0x100 /* - Block all symlinks (implies AT_NO_MAGICLINKS). */
+#define RESOLVE_IN_ROOT		0x200 /* - Scope ".." resolution to dirfd (like chroot(2)). */
+
+#define VALID_RESOLVE_FLAGS	(RESOLVE_CLOEXEC | RESOLVE_NOFOLLOW | RESOLVE_RESOLUTION_TYPE)
+
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.21.0

