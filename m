Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736E81FF58A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgFROrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgFROqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D98BC06174E;
        Thu, 18 Jun 2020 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D8aZ6GxtfZtr1jrS4CUVjEbYibNmMhFL+kZpE87P9Hg=; b=nj86niidDTcv9vmYHItdypi6vZ
        Tn9ft87/NOGqjr2OAeLS7xnXQqokyIXUMvaUfOOfgMsy7vYhE+DaK8WlgW1yWXP+NCcIfVqli0TEB
        ItLV5acnqMRaCioC8t2hMKrh6c+67zFxK41wzTVUP/lFUx5P/kNJFfYGRhM/BKv57fcPewl8uI84o
        XOiaj5I9N/Fttd8iIgXxs/J7GdYTonXh2cBnxXqv2VHYdV2QB4d8/s/hiZWM69vQ1oA2lkgwYvgeM
        OFBduVWdqYASy3ya4g1N5uWzUSqlKNdbkBhHHG7EF8TVO/k010Gzzt5m+S1wqvUu3TLTgP6SHl/kb
        ge4zdILQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvoK-0006KN-4u; Thu, 18 Jun 2020 14:46:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] exec: simplify the compat syscall handling
Date:   Thu, 18 Jun 2020 16:46:23 +0200
Message-Id: <20200618144627.114057-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618144627.114057-1-hch@lst.de>
References: <20200618144627.114057-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only differenence betweeen the compat exec* syscalls and their
native versions is that compat_ptr sign extension, and the fact that
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
 arch/x86/entry/syscall_x32.c                  |   7 ++
 arch/x86/entry/syscalls/syscall_32.tbl        |   4 +-
 arch/x86/entry/syscalls/syscall_64.tbl        |   4 +-
 fs/exec.c                                     | 103 ++++--------------
 include/linux/compat.h                        |   7 --
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/include/uapi/asm-generic/unistd.h       |   4 +-
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   4 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   4 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 17 files changed, 56 insertions(+), 117 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6d95d0c8bf2f47..141f5d2ff1c34f 100644
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
index f777141f52568f..e861b5ab7179c9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -64,7 +64,7 @@
 54	n32	getsockopt			compat_sys_getsockopt
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
index 13280625d312e9..bba80f74e9968e 100644
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
index 5a758fa6ec5242..23fa0d0edf3384 100644
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
 344	common	userfaultfd		sys_userfaultfd
 345	common	mlock2			sys_mlock2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f833a319082247..c52cdab89dc0ae 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -20,7 +20,7 @@
 8	common	creat				sys_creat
 9	common	link				sys_link
 10	common	unlink				sys_unlink
-11	nospu	execve				sys_execve			compat_sys_execve
+11	nospu	execve				sys_execve
 12	common	chdir				sys_chdir
 13	32	time				sys_time32
 13	64	time				sys_time
@@ -460,7 +460,7 @@
 359	common	getrandom			sys_getrandom
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
+362	nospu	execveat			sys_execveat
 363	32	switch_endian			sys_ni_syscall
 363	64	switch_endian			sys_switch_endian
 363	spu	switch_endian			sys_ni_syscall
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bfdcb763395735..bd2275db2026ea 100644
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
index db42b4fb370844..70463972152a92 100644
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
index 3d8d70d3896c87..c9f39900a93b96 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,6 +8,13 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
+/*
+ * Reuse the 64-bit entry points for the x32 versions that occupy different
+ * slots in the syscall table.
+ */
+#define __x32_sys_execve	__x64_sys_execve
+#define __x32_sys_execveat	__x64_sys_execveat
+
 #define __SYSCALL_64(nr, sym)
 
 #define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed11f..2b1eccd3f8f697 100644
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
index 78847b32e1370f..cb3fce6ed63ebf 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,7 +375,7 @@
 517	x32	recvfrom		compat_sys_recvfrom
 518	x32	sendmsg			compat_sys_sendmsg
 519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve
+520	x32	execve			sys_execve
 521	x32	ptrace			compat_sys_ptrace
 522	x32	rt_sigpending		compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
@@ -400,6 +400,6 @@
 542	x32	getsockopt		compat_sys_getsockopt
 543	x32	io_setup		compat_sys_io_setup
 544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat
+545	x32	execveat		sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
diff --git a/fs/exec.c b/fs/exec.c
index 354fdaa536ae7d..4e5db0e35797a5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -386,47 +386,34 @@ static int bprm_mm_init(struct linux_binprm *bprm)
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
 
@@ -449,7 +436,8 @@ static int count(struct user_arg_ptr argv, int max)
 }
 
 static int prepare_arg_pages(struct linux_binprm *bprm,
-			struct user_arg_ptr argv, struct user_arg_ptr envp)
+		const char __user *const __user *argv,
+		const char __user *const __user *envp)
 {
 	unsigned long limit, ptr_size;
 
@@ -497,7 +485,7 @@ static int prepare_arg_pages(struct linux_binprm *bprm,
  * processes's memory to the new process's stack.  The call to get_user_pages()
  * ensures the destination page is created and not swapped out.
  */
-static int copy_strings(int argc, struct user_arg_ptr argv,
+static int copy_strings(int argc, const char __user *const __user *argv,
 			struct linux_binprm *bprm)
 {
 	struct page *kmapped_page = NULL;
@@ -1815,10 +1803,10 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return 0;
 }
 
-static int __do_execveat(int fd, struct filename *filename,
-			    struct user_arg_ptr argv,
-			    struct user_arg_ptr envp,
-			    int flags, struct file *file)
+int do_execveat(int fd, struct filename *filename,
+		const char __user *const __user *argv,
+		const char __user *const __user *envp,
+		int flags, struct file *file)
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
@@ -1969,17 +1957,6 @@ static int __do_execveat(int fd, struct filename *filename,
 	return retval;
 }
 
-int do_execveat(int fd, struct filename *filename,
-		const char __user *const __user *__argv,
-		const char __user *const __user *__envp,
-		int flags, struct file *file)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-
-	return __do_execveat(fd, filename, argv, envp, flags, file);
-}
-
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
@@ -2023,41 +2000,3 @@ SYSCALL_DEFINE5(execveat,
 
 	return do_execveat(fd, name, argv, envp, flags, NULL);
 }
-
-#ifdef CONFIG_COMPAT
-static int do_compat_execve(int fd, struct filename *filename,
-		const compat_uptr_t __user *__argv,
-		const compat_uptr_t __user *__envp,
-		int flags)
-{
-	struct user_arg_ptr argv = {
-		.is_compat = true,
-		.ptr.compat = __argv,
-	};
-	struct user_arg_ptr envp = {
-		.is_compat = true,
-		.ptr.compat = __envp,
-	};
-
-	return __do_execveat(fd, filename, argv, envp, flags, NULL);
-}
-
-COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
-	const compat_uptr_t __user *, argv,
-	const compat_uptr_t __user *, envp)
-{
-	return do_compat_execve(AT_FDCWD, getname(filename), argv, envp, 0);
-}
-
-COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
-		       const char __user *, filename,
-		       const compat_uptr_t __user *, argv,
-		       const compat_uptr_t __user *, envp,
-		       int,  flags)
-{
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-	struct filename *name = getname_flags(filename, lookup_flags, NULL);
-
-	return do_compat_execve(fd, name, argv, envp, flags);
-}
-#endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index e90100c0de72e4..5e8f6a588e0d43 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -752,10 +752,6 @@ asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 asmlinkage long compat_sys_keyctl(u32 option,
 			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
 
-/* arch/example/kernel/sys_example.c */
-asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp);
-
 /* mm/fadvise.c: No generic prototype for fadvise64_64 */
 
 /* mm/, CONFIG_MMU only */
@@ -806,9 +802,6 @@ asmlinkage ssize_t compat_sys_process_vm_writev(compat_pid_t pid,
 		const struct compat_iovec __user *lvec,
 		compat_ulong_t liovcnt, const struct compat_iovec __user *rvec,
 		compat_ulong_t riovcnt, compat_ulong_t flags);
-asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
-		     const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp, int flags);
 asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
 		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a65c..c639d04a094b8b 100644
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
@@ -751,7 +751,7 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
 __SYSCALL(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
-__SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
+__SYSCALL(__NR_execveat, sys_execveat)
 #define __NR_userfaultfd 282
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 3a3201e4618ef8..a6dbc8af8bd577 100644
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
@@ -751,7 +751,7 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
 __SYSCALL(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
-__SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
+__SYSCALL(__NR_execveat, sys_execveat)
 #define __NR_userfaultfd 282
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 35b61bfc1b1ae9..42bf8b461a0ed6 100644
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
@@ -454,7 +454,7 @@
 359	common	getrandom			sys_getrandom
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
+362	nospu	execveat			sys_execveat			sys_execveat
 363	32	switch_endian			sys_ni_syscall
 363	64	switch_endian			ppc_switch_endian
 363	spu	switch_endian			sys_ni_syscall
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index b38d48464368dc..f3c16f2d9746ac 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -18,7 +18,7 @@
 8    common	creat			sys_creat			compat_sys_creat
 9    common	link			sys_link			compat_sys_link
 10   common	unlink			sys_unlink			compat_sys_unlink
-11   common	execve			sys_execve			compat_sys_execve
+11   common	execve			sys_execve			sys_execve
 12   common	chdir			sys_chdir			compat_sys_chdir
 13   32		time			-				compat_sys_time
 14   common	mknod			sys_mknod			compat_sys_mknod
@@ -361,7 +361,7 @@
 351  common	bpf			sys_bpf				compat_sys_bpf
 352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		compat_sys_s390_pci_mmio_write
 353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		compat_sys_s390_pci_mmio_read
-354  common	execveat		sys_execveat			compat_sys_execveat
+354  common	execveat		sys_execveat			sys_execveat
 355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
 356  common	membarrier		sys_membarrier			sys_membarrier
 357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc4f..8b88868e622d32 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,7 +374,7 @@
 517	x32	recvfrom		compat_sys_recvfrom
 518	x32	sendmsg			compat_sys_sendmsg
 519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve
+520	x32	execve			sys_execve
 521	x32	ptrace			compat_sys_ptrace
 522	x32	rt_sigpending		compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
@@ -399,6 +399,6 @@
 542	x32	getsockopt		compat_sys_getsockopt
 543	x32	io_setup		compat_sys_io_setup
 544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat
+545	x32	execveat		sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
-- 
2.26.2

