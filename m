Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455B334AA3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCZOkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhCZOje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:39:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D2C0613AA;
        Fri, 26 Mar 2021 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6jlR96Bja85cZ4zOznb+/jf1P/fJoF5N9yRzmSctE5Y=; b=1NlqbA3gzCmslnyfiJxhXVnEID
        rgvcgZhzIccQS44pCL75M0bmSHX7YpYD1wxIKhCNO9V1uWfYgVRQ4OFZcFpKxeqO9A3zkZKo/ENfr
        tdmvRLbROexrV0Z5qO0FoiJ6tMYPhVmWXaIZtowkPnl1KIC4omD1xQawWXSnHpW5WKuGWyscfLpAO
        ptmD1mljwBVHWeZhU9WVzOVyww6XAKSvov/77EKN8O0vaqSl5joZCQf8nnFSSebCaR/nBh3S9QAUU
        W4Wx1mhEiAxn5img72Hn7zLEDt9XFQYPoaJX4hW6sX3e+c6WXc+2cMHYiVF3b6WNzVDmrAwId7S17
        s1KmGlWA==;
Received: from [213.208.157.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPncA-005U7N-9e; Fri, 26 Mar 2021 14:39:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] exec: simplify the compat syscall handling
Date:   Fri, 26 Mar 2021 15:38:30 +0100
Message-Id: <20210326143831.1550030-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326143831.1550030-1-hch@lst.de>
References: <20210326143831.1550030-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only differenence betweeen the compat exec* syscalls and their
native versions is the compat_ptr sign extension, and the fact that
the pointer arithmetics for the two dimensional arrays needs to use
the compat pointer size.  Instead of the compat wrappers and the
struct user_arg_ptr machinery just use in_compat_syscall() to do the
right thing for the compat case deep inside get_user_arg_ptr().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/unistd32.h             |   4 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   4 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   4 +-
 arch/parisc/kernel/syscalls/syscall.tbl       |   4 +-
 arch/powerpc/kernel/syscalls/syscall.tbl      |   4 +-
 arch/s390/kernel/syscalls/syscall.tbl         |   4 +-
 arch/sparc/kernel/syscalls.S                  |   4 +-
 arch/x86/entry/syscall_x32.c                  |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   4 +-
 arch/x86/entry/syscalls/syscall_64.tbl        |   4 +-
 fs/exec.c                                     | 101 ++++--------------
 include/linux/compat.h                        |   7 --
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/include/uapi/asm-generic/unistd.h       |   4 +-
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   4 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   4 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 17 files changed, 48 insertions(+), 118 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 3d874f624056b1..34360760773201 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -33,7 +33,7 @@ __SYSCALL(__NR_link, sys_link)
 #define __NR_unlink 10
 __SYSCALL(__NR_unlink, sys_unlink)
 #define __NR_execve 11
-__SYSCALL(__NR_execve, compat_sys_execve)
+__SYSCALL(__NR_execve, sys_execve)
 #define __NR_chdir 12
 __SYSCALL(__NR_chdir, sys_chdir)
 			/* 13 was sys_time */
@@ -785,7 +785,7 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 386
 __SYSCALL(__NR_bpf, sys_bpf)
 #define __NR_execveat 387
-__SYSCALL(__NR_execveat, compat_sys_execveat)
+__SYSCALL(__NR_execveat, sys_execveat)
 #define __NR_userfaultfd 388
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 389
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 8fd8c1790941c6..4da26b7f95d172 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -64,7 +64,7 @@
 54	n32	getsockopt			sys_getsockopt
 55	n32	clone				__sys_clone
 56	n32	fork				__sys_fork
-57	n32	execve				compat_sys_execve
+57	n32	execve				sys_execve
 58	n32	exit				sys_exit
 59	n32	wait4				compat_sys_wait4
 60	n32	kill				sys_kill
@@ -328,7 +328,7 @@
 317	n32	getrandom			sys_getrandom
 318	n32	memfd_create			sys_memfd_create
 319	n32	bpf				sys_bpf
-320	n32	execveat			compat_sys_execveat
+320	n32	execveat			sys_execveat
 321	n32	userfaultfd			sys_userfaultfd
 322	n32	membarrier			sys_membarrier
 323	n32	mlock2				sys_mlock2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 090d29ca80ff8f..33818dd2462090 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -18,7 +18,7 @@
 8	o32	creat				sys_creat
 9	o32	link				sys_link
 10	o32	unlink				sys_unlink
-11	o32	execve				sys_execve			compat_sys_execve
+11	o32	execve				sys_execve
 12	o32	chdir				sys_chdir
 13	o32	time				sys_time32
 14	o32	mknod				sys_mknod
@@ -367,7 +367,7 @@
 353	o32	getrandom			sys_getrandom
 354	o32	memfd_create			sys_memfd_create
 355	o32	bpf				sys_bpf
-356	o32	execveat			sys_execveat			compat_sys_execveat
+356	o32	execveat			sys_execveat
 357	o32	userfaultfd			sys_userfaultfd
 358	o32	membarrier			sys_membarrier
 359	o32	mlock2				sys_mlock2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 271a9251968345..81085f10db4777 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8	common	creat			sys_creat
 9	common	link			sys_link
 10	common	unlink			sys_unlink
-11	common	execve			sys_execve			compat_sys_execve
+11	common	execve			sys_execve
 12	common	chdir			sys_chdir
 13	32	time			sys_time32
 13	64	time			sys_time
@@ -385,7 +385,7 @@
 339	common	getrandom		sys_getrandom
 340	common	memfd_create		sys_memfd_create
 341	common	bpf			sys_bpf
-342	common	execveat		sys_execveat			compat_sys_execveat
+342	common	execveat		sys_execveat
 343	common	membarrier		sys_membarrier
 344	common	userfaultfd		parisc_userfaultfd
 345	common	mlock2			sys_mlock2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 0b2480cf3e4793..97e20641366d94 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8	common	creat				sys_creat
 9	common	link				sys_link
 10	common	unlink				sys_unlink
-11	nospu	execve				sys_execve			compat_sys_execve
+11	nospu	execve				sys_execve
 12	common	chdir				sys_chdir
 13	32	time				sys_time32
 13	64	time				sys_time
@@ -452,7 +452,7 @@
 359	common	getrandom			sys_getrandom
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
+362	nospu	execveat			sys_execveat
 363	32	switch_endian			sys_ni_syscall
 363	64	switch_endian			sys_switch_endian
 363	spu	switch_endian			sys_ni_syscall
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3abef2144dac79..8d9f3ab509d583 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8    common	creat			sys_creat			sys_creat
 9    common	link			sys_link			sys_link
 10   common	unlink			sys_unlink			sys_unlink
-11   common	execve			sys_execve			compat_sys_execve
+11   common	execve			sys_execve			sys_execve
 12   common	chdir			sys_chdir			sys_chdir
 13   32		time			-				sys_time32
 14   common	mknod			sys_mknod			sys_mknod
@@ -361,7 +361,7 @@
 351  common	bpf			sys_bpf				sys_bpf
 352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
 353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
-354  common	execveat		sys_execveat			compat_sys_execveat
+354  common	execveat		sys_execveat			sys_execveat
 355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
 356  common	membarrier		sys_membarrier			sys_membarrier
 357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 0e8ab0602c360b..554a0dedc80ce5 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -16,12 +16,12 @@ sys64_execveat:
 sunos_execv:
 	mov	%g0, %o2
 sys32_execve:
-	set	compat_sys_execve, %g1
+	set	sys_execve, %g1
 	jmpl	%g1, %g0
 	 flushw
 
 sys32_execveat:
-	set	compat_sys_execveat, %g1
+	set	sys_execveat, %g1
 	jmpl	%g1, %g0
 	 flushw
 #endif
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index f2fe0a33bcfdd5..510918355ea10a 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -12,6 +12,8 @@
  * Reuse the 64-bit entry points for the x32 versions that occupy different
  * slots in the syscall table.
  */
+#define __x32_sys_execve	__x64_sys_execve
+#define __x32_sys_execveat	__x64_sys_execveat
 #define __x32_sys_readv		__x64_sys_readv
 #define __x32_sys_writev	__x64_sys_writev
 #define __x32_sys_getsockopt	__x64_sys_getsockopt
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index a1c9f496fca6a2..539ab7d46a3d35 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -22,7 +22,7 @@
 8	i386	creat			sys_creat
 9	i386	link			sys_link
 10	i386	unlink			sys_unlink
-11	i386	execve			sys_execve			compat_sys_execve
+11	i386	execve			sys_execve
 12	i386	chdir			sys_chdir
 13	i386	time			sys_time32
 14	i386	mknod			sys_mknod
@@ -369,7 +369,7 @@
 355	i386	getrandom		sys_getrandom
 356	i386	memfd_create		sys_memfd_create
 357	i386	bpf			sys_bpf
-358	i386	execveat		sys_execveat			compat_sys_execveat
+358	i386	execveat		sys_execveat
 359	i386	socket			sys_socket
 360	i386	socketpair		sys_socketpair
 361	i386	bind			sys_bind
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7bf01cbe582f03..b121013fdb806a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -379,7 +379,7 @@
 517	x32	recvfrom		compat_sys_recvfrom
 518	x32	sendmsg			compat_sys_sendmsg
 519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve
+520	x32	execve			sys_execve
 521	x32	ptrace			compat_sys_ptrace
 522	x32	rt_sigpending		compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
@@ -404,7 +404,7 @@
 542	x32	getsockopt		sys_getsockopt
 543	x32	io_setup		compat_sys_io_setup
 544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat
+545	x32	execveat		sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
 # This is the end of the legacy x32 range.  Numbers 548 and above are
diff --git a/fs/exec.c b/fs/exec.c
index 06e07278b456fa..b34c1eb9e7ad8e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -391,47 +391,34 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	return err;
 }
 
-struct user_arg_ptr {
-#ifdef CONFIG_COMPAT
-	bool is_compat;
-#endif
-	union {
-		const char __user *const __user *native;
-#ifdef CONFIG_COMPAT
-		const compat_uptr_t __user *compat;
-#endif
-	} ptr;
-};
-
-static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
+static const char __user *
+get_user_arg_ptr(const char __user *const __user *argv, int nr)
 {
-	const char __user *native;
-
-#ifdef CONFIG_COMPAT
-	if (unlikely(argv.is_compat)) {
+	if (in_compat_syscall()) {
+		const compat_uptr_t __user *compat_argv =
+			compat_ptr((unsigned long)argv);
 		compat_uptr_t compat;
 
-		if (get_user(compat, argv.ptr.compat + nr))
+		if (get_user(compat, compat_argv + nr))
 			return ERR_PTR(-EFAULT);
-
 		return compat_ptr(compat);
-	}
-#endif
-
-	if (get_user(native, argv.ptr.native + nr))
-		return ERR_PTR(-EFAULT);
+	} else {
+		const char __user *native;
 
-	return native;
+		if (get_user(native, argv + nr))
+			return ERR_PTR(-EFAULT);
+		return native;
+	}
 }
 
 /*
  * count() counts the number of strings in array ARGV.
  */
-static int count(struct user_arg_ptr argv, int max)
+static int count(const char __user *const __user *argv, int max)
 {
 	int i = 0;
 
-	if (argv.ptr.native != NULL) {
+	if (argv) {
 		for (;;) {
 			const char __user *p = get_user_arg_ptr(argv, i);
 
@@ -510,7 +497,7 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
  * processes's memory to the new process's stack.  The call to get_user_pages()
  * ensures the destination page is created and not swapped out.
  */
-static int copy_strings(int argc, struct user_arg_ptr argv,
+static int copy_strings(int argc, const char __user *const __user *argv,
 			struct linux_binprm *bprm)
 {
 	struct page *kmapped_page = NULL;
@@ -1856,10 +1843,9 @@ static int bprm_execve(struct linux_binprm *bprm,
 	return retval;
 }
 
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
+static int do_execveat(int fd, struct filename *filename,
+		const char __user *const __user *argv,
+		const char __user *const __user *envp, int flags)
 {
 	struct linux_binprm *bprm;
 	int retval;
@@ -1978,35 +1964,6 @@ int kernel_execve(const char *kernel_filename,
 	return retval;
 }
 
-static int do_execveat(int fd, struct filename *filename,
-		const char __user *const __user *__argv,
-		const char __user *const __user *__envp,
-		int flags)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-
-	return do_execveat_common(fd, filename, argv, envp, flags);
-}
-
-#ifdef CONFIG_COMPAT
-static int compat_do_execveat(int fd, struct filename *filename,
-			      const compat_uptr_t __user *__argv,
-			      const compat_uptr_t __user *__envp,
-			      int flags)
-{
-	struct user_arg_ptr argv = {
-		.is_compat = true,
-		.ptr.compat = __argv,
-	};
-	struct user_arg_ptr envp = {
-		.is_compat = true,
-		.ptr.compat = __envp,
-	};
-	return do_execveat_common(fd, filename, argv, envp, flags);
-}
-#endif
-
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
@@ -2051,25 +2008,3 @@ SYSCALL_DEFINE5(execveat,
 			   getname_flags(filename, lookup_flags, NULL),
 			   argv, envp, flags);
 }
-
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
-	const compat_uptr_t __user *, argv,
-	const compat_uptr_t __user *, envp)
-{
-	return compat_do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
-}
-
-COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
-		       const char __user *, filename,
-		       const compat_uptr_t __user *, argv,
-		       const compat_uptr_t __user *, envp,
-		       int,  flags)
-{
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-
-	return compat_do_execveat(fd,
-				  getname_flags(filename, lookup_flags, NULL),
-				  argv, envp, flags);
-}
-#endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be75360321..894dfcf2dd4590 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -766,10 +766,6 @@ asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 asmlinkage long compat_sys_keyctl(u32 option,
 			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
 
-/* arch/example/kernel/sys_example.c */
-asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp);
-
 /* mm/fadvise.c: No generic prototype for fadvise64_64 */
 
 /* mm/, CONFIG_MMU only */
@@ -812,9 +808,6 @@ asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
 					     int flags);
 asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags);
-asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
-		     const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp, int flags);
 asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
 		const struct iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index ce58cff99b6653..74e9bc4f0ce569 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -640,7 +640,7 @@ __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
 #define __NR_clone 220
 __SYSCALL(__NR_clone, sys_clone)
 #define __NR_execve 221
-__SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
+__SYSCALL(__NR_execve, sys_execve)
 
 #define __NR3264_mmap 222
 __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
@@ -749,7 +749,7 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
 __SYSCALL(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
-__SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
+__SYSCALL(__NR_execveat, sys_execveat)
 #define __NR_userfaultfd 282
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index ce58cff99b6653..74e9bc4f0ce569 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -640,7 +640,7 @@ __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
 #define __NR_clone 220
 __SYSCALL(__NR_clone, sys_clone)
 #define __NR_execve 221
-__SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
+__SYSCALL(__NR_execve, sys_execve)
 
 #define __NR3264_mmap 222
 __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
@@ -749,7 +749,7 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
 __SYSCALL(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
-__SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
+__SYSCALL(__NR_execveat, sys_execveat)
 #define __NR_userfaultfd 282
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 0b2480cf3e4793..44fec8c21082a4 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8	common	creat				sys_creat
 9	common	link				sys_link
 10	common	unlink				sys_unlink
-11	nospu	execve				sys_execve			compat_sys_execve
+11	nospu	execve				sys_execve			sys_execve
 12	common	chdir				sys_chdir
 13	32	time				sys_time32
 13	64	time				sys_time
@@ -452,7 +452,7 @@
 359	common	getrandom			sys_getrandom
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
+362	nospu	execveat			sys_execveat			sys_execveat
 363	32	switch_endian			sys_ni_syscall
 363	64	switch_endian			sys_switch_endian
 363	spu	switch_endian			sys_ni_syscall
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 3abef2144dac79..8d9f3ab509d583 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8    common	creat			sys_creat			sys_creat
 9    common	link			sys_link			sys_link
 10   common	unlink			sys_unlink			sys_unlink
-11   common	execve			sys_execve			compat_sys_execve
+11   common	execve			sys_execve			sys_execve
 12   common	chdir			sys_chdir			sys_chdir
 13   32		time			-				sys_time32
 14   common	mknod			sys_mknod			sys_mknod
@@ -361,7 +361,7 @@
 351  common	bpf			sys_bpf				sys_bpf
 352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
 353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
-354  common	execveat		sys_execveat			compat_sys_execveat
+354  common	execveat		sys_execveat			sys_execveat
 355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
 356  common	membarrier		sys_membarrier			sys_membarrier
 357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 7bf01cbe582f03..b121013fdb806a 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -379,7 +379,7 @@
 517	x32	recvfrom		compat_sys_recvfrom
 518	x32	sendmsg			compat_sys_sendmsg
 519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve
+520	x32	execve			sys_execve
 521	x32	ptrace			compat_sys_ptrace
 522	x32	rt_sigpending		compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
@@ -404,7 +404,7 @@
 542	x32	getsockopt		sys_getsockopt
 543	x32	io_setup		compat_sys_io_setup
 544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat
+545	x32	execveat		sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
 # This is the end of the legacy x32 range.  Numbers 548 and above are
-- 
2.30.1

