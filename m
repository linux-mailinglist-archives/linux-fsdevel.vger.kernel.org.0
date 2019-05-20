Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35D23838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfETNf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 09:35:28 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:62706 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbfETNf2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 09:35:28 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 56C9750C9B;
        Mon, 20 May 2019 15:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 8It-CNw9qGUe; Mon, 20 May 2019 15:35:21 +0200 (CEST)
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
        containers@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RFC v8 08/10] namei: resolveat(2) syscall
Date:   Mon, 20 May 2019 23:33:03 +1000
Message-Id: <20190520133305.11925-9-cyphar@cyphar.com>
In-Reply-To: <20190520133305.11925-1-cyphar@cyphar.com>
References: <20190520133305.11925-1-cyphar@cyphar.com>
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

 * It gives us the opportunity to iterate on the O_PATH interface. In
   particular, the RESOLVE_UPGRADE_* flags are only possible because we
   have a clean slate without needing to re-use the ACC_MODE flag
   design.

To this end, we introduce the resolveat(2) syscall. At the moment it's
effectively another way of getting a bog-standard O_PATH descriptor but
with the ability to use the new LOOKUP_* flags. Following the example of
other new file-handle-creation syscalls (pidfds, seccomp notify fds) we
default to O_CLOEXEC and users can unset O_CLOEXEC using fcntl(2) if
they really want to.

Because resolveat(2) only provides the ability to get O_PATH
descriptors, users will need to get creative with /proc/self/fd in order
to get a usable file descriptor for other uses. However, the new
addition of O_EMPTYPATH shortcuts this problem and allows for easy usage
of the new LOOKUP_* flags with openat(2) without cluttering the open(2)
flag bits.

In order to allow for userspace to lock down their usage of file
descriptor re-opening, resolveat(2) has flags (RESOLVE_UPGRADE_*) which
allow users to disallow certain re-opening modes.

Co-developed-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  3 ++
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
 fs/namei.c                                  | 50 +++++++++++++++++++++
 include/linux/fcntl.h                       |  8 +++-
 include/uapi/asm-generic/unistd.h           |  5 ++-
 include/uapi/linux/fcntl.h                  | 10 +++++
 22 files changed, 91 insertions(+), 3 deletions(-)

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
index 9016f4081bb9..11f19c78185e 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -437,3 +437,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index d1dd93436e1e..d04eb26cfaeb 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		424
+#define __NR_compat_syscalls		436
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5590f2623690..9978234748a9 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -867,6 +867,9 @@ __SYSCALL(__NR_futex_time64, sys_futex)
 #define __NR_sched_rr_get_interval_time64 423
 __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 
+#define __NR_resolveat 435
+__SYSCALL(__NR_resolveat, sys_sched_rr_get_interval)
+
 /*
  * Please add new compat syscalls above this comment and update
  * __NR_compat_syscalls in asm/unistd.h.
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index ab9cda5f6136..26a3daab202e 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -344,3 +344,4 @@
 332	common	pkey_free			sys_pkey_free
 333	common	rseq				sys_rseq
 # 334 through 423 are reserved to sync up with other architectures
+435	common	resolveat			sys_resolveat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 125c14178979..3fdbd42077f1 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 8ee3a8c18498..6948436a939b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -429,3 +429,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 15f4117900ee..36795694e495 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -362,3 +362,4 @@
 421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
 422	n32	futex_time64			sys_futex
 423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	n32	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c85502e67b44..5fcde2d31fe7 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -338,3 +338,4 @@
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
+435	n64	resolveat			sys_resolveat
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2e063d0f837e..71152b788e37 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -411,3 +411,4 @@
 421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	o32	futex_time64			sys_futex			sys_futex
 423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+435	o32	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b26766c6647d..68e415658235 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -420,3 +420,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b18abb0c3dae..69b0bf1df8b1 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -505,3 +505,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 02579f95f391..9610f18eb2ea 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -426,3 +426,4 @@
 421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64		-				sys_futex
 423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+435	common	resolveat		sys_resolveat			-
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bfda678576e4..ed53ca7717cf 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -426,3 +426,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b9a5a04b2d2c..41778972430b 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+435 common	resolveat			sys_resolveat			sys_resolveat
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..f3cb515e52fb 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+435	i386	resolveat		sys_resolveat			__ia32_sys_resolveat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..5f4a988f3bc9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+435	common	resolveat		__x64_sys_resolveat
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6af49929de85..2d5b57ebd6c1 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -394,3 +394,4 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+435	common	resolveat			sys_resolveat
diff --git a/fs/namei.c b/fs/namei.c
index 6c3bbe627965..4b4eb6c624cb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3790,6 +3790,56 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 	return filp;
 }
 
+SYSCALL_DEFINE3(resolveat, int, dfd, const char __user *, path,
+		unsigned long, flags)
+{
+	int fd;
+	struct filename *tmp;
+	struct open_flags op = {
+		.open_flag = O_PATH | O_CLOEXEC,
+		.opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE,
+	};
+
+	if (flags & ~VALID_RESOLVE_FLAGS)
+		return -EINVAL;
+
+	if (flags & RESOLVE_UPGRADE_NOREAD)
+		op.opath_mask &= ~FMODE_PATH_READ;
+	if (flags & RESOLVE_UPGRADE_NOWRITE)
+		op.opath_mask &= ~FMODE_PATH_WRITE;
+
+	if (!(flags & RESOLVE_NO_FOLLOW))
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
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 2868ae6c8fc1..6356eb479765 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -4,13 +4,19 @@
 
 #include <uapi/linux/fcntl.h>
 
-/* list of all valid flags for the open/openat flags argument: */
+/* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
 
+/* List of all valid flags for resolveat(2). */
+#define VALID_RESOLVE_FLAGS \
+	(RESOLVE_UPGRADE_NOWRITE | RESOLVE_UPGRADE_NOREAD | \
+	 RESOLVE_NO_FOLLOW | RESOLVE_BENEATH | RESOLVE_XDEV | \
+	 RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | RESOLVE_IN_ROOT)
+
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..f788c9f7d374 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -833,8 +833,11 @@ __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
+#define __NR_resolveat 435
+__SYSCALL(__NR_resolveat, sys_resolveat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 436
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..185712fa9cc0 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -93,5 +93,15 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/* Bottom bit is reserved for RESOLVE_UPGRADE_NOEXEC. */
+#define RESOLVE_UPGRADE_NOWRITE	0x002 /* Disallow re-opening for write. */
+#define RESOLVE_UPGRADE_NOREAD	0x004 /* Disallow re-opening for read. */
+#define RESOLVE_NO_FOLLOW	0x008 /* Don't follow trailing symlinks. */
+
+#define RESOLVE_BENEATH		0x010 /* Block "lexical" trickery like "..", symlinks, absolute paths, etc. */
+#define RESOLVE_XDEV		0x020 /* Block mount-point crossings (includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x040 /* Block procfs-style "magic" symlinks. */
+#define RESOLVE_NO_SYMLINKS	0x080 /* Block all symlinks (implies AT_NO_MAGICLINKS). */
+#define RESOLVE_IN_ROOT		0x100 /* Scope ".." and "/" resolution to dirfd (like chroot(2)). */
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.21.0

