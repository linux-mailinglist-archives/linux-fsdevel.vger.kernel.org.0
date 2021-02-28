Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8255326FBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 01:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhB1AZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 19:25:48 -0500
Received: from out2.migadu.com ([188.165.223.204]:41451 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhB1AZs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 19:25:48 -0500
X-Greylist: delayed 35812 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Feb 2021 19:25:45 EST
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614471903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q8Y+vHhsGDbZpvB3gPEp+L9CqDH/Hm1OQHl6L3oqGnQ=;
        b=DEKSXuSgwXOOAzD1goJ24T/oHmXjv3PpqoOK6LQeZ3A4pLfPez7ouQPMfdLDibe2xW9upC
        P3g3KTigBjvaAYpYIlpeO2oP/Y8LEd20rwJXyB/u+r7dZ5pOtPwTekAoMmxAaGnV4BYkgz
        lFYkJCvdiDx375nanWQqJFZvdf8WZhFfrihA5CG/C8Clp4b39kyxKiSRyyKAEL2bawsvLW
        eAhKhsT61IS9uFFT3DP8hizz6HZg4EelJujlUC7MF/jvnOLk6AtHn1ZkG+0L956ciZWXaw
        8oOJqW96zcHj5Sc9DonmoTPEeMt4fWH+1t6rpPpO7nrbqoOFBP9PcYQKhk3OYA==
From:   Drew DeVault <sir@cmpwn.com>
To:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, "Aleksa Sarai" <cyphar@cyphar.com>
Subject: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Date:   Sat, 27 Feb 2021 19:25:00 -0500
Message-Id: <20210228002500.11483-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mkdir and mkdirat syscalls both return 0 on success, and use of the
newly-created directory requires a separate open or openat (or openat2)
call. The time between these syscalls is an opportunity for a race
condition. It is thus desirable to establish a means of creating a
directory and returning an open dirfd for it in one atomic operation.

The possibility of using open(at(2)) with O_CREAT | O_DIRECTORY suggests
itself. The present behavior for this flag combination is quite
certainly wrong: it returns ENOTDIR, but creates a file with the desired
name. We could explicitly support this combination of flags, but we are
loathe to expand an already over-burdened syscall with additional flag
combinations.

This introduces mkdirat2, along with the requisite flag argument, which
presently accepts the same flags as open - allowing the caller to
specify, say, O_CLOEXEC - and leaving us room to expand the next time an
unforeseeable addition to mkdir is called for. Otherwise, it behaves
identically to mkdirat, but returns an open file descriptor for the new
directory.
---
This is my first foray into the fs bits, and first syscall addition as
well; the reader's patience with the many obvious errors this is certain
to include is much appreciated.

I am pretty sure that this is actually atomic - gated between
user_path_create and done_path_create - but I admit that I don't grok
the inode locking bits. Otherwise, this was basically made by splicing
together relevant-looking bits of mkdir and openat until a syscall which
appeared to work under testing emerged.

 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/namei.c                                  | 46 ++++++++++++++++++---
 include/linux/syscalls.h                    |  1 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 19 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ee7b01bb7346..c621fa5aaccf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -480,3 +480,4 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
+551	common	mkdirat2			sys_mkdirat2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d056a548358e..8ad43ac853b4 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -454,3 +454,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b3b2019f8d16..86a9d7b3eabe 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		441
+#define __NR_compat_syscalls		442
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 107f08e03b9f..b9ae6fbba839 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -889,6 +889,8 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_mkdirat2 441
+__SYSCALL(__NR_mkdirat2, sys_mkdirat2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b96ed8b8a508..e71ee20bf3da 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -361,3 +361,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 625fb6d32842..a64bc3463b48 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index aae729c95cf9..199f4a6df658 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -446,3 +446,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 32817c954435..6fab6f6e9b0f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -379,3 +379,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
+441	n32	mkdirat2			sys_mkdirat2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9e4ea3c31b1c..f9c672d00e75 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -355,3 +355,4 @@
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
+441	n64	mkdirat2			sys_mkdirat2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index f375ea528e59..a1f433044a7c 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1275daec7fec..1c73b34517d1 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 28c168000483..2cc370736912 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
+441  common	mkdirat2		sys_mkdirat2			sys_mkdirat2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 783738448ff5..e0e15828c19f 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 78160260991b..57bee5e64645 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -486,3 +486,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+441	common	mkdirat2			sys_mkdirat2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 379819244b91..8bb125749d7b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,7 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
+441	common	mkdirat2		sys_mkdirat2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index b070f272995d..07f1ddc8092f 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -411,3 +411,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+440	common	mkdirat2			sys_mkdirat2
diff --git a/fs/namei.c b/fs/namei.c
index d4a6dd772303..6bd296d929d7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3654,13 +3654,27 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
+static long do_mkdirat2(int dfd, const char __user *pathname, umode_t mode,
+			int flags, bool open)
 {
+	struct open_flags op;
 	struct dentry *dentry;
+	struct filename *tmp;
 	struct path path;
 	int error;
+	int fd;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 
+	if (open) {
+		tmp = getname(pathname);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		fd = get_unused_fd_flags(flags);
+		if (fd < 0)
+			return fd;
+	}
+
 retry:
 	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
 	if (IS_ERR(dentry))
@@ -3669,24 +3683,46 @@ static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
+	if (!error) {
 		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
+		if (open) {
+			struct file *f = do_filp_open(dfd, tmp, &op);
+			if (IS_ERR(f)) {
+				put_unused_fd(fd);
+				error = PTR_ERR(f);
+				goto out;
+			} else {
+				fsnotify_open(f);
+				fd_install(fd, f);
+			}
+		}
+	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-	return error;
+out:
+	if (open)
+		putname(tmp);
+	if (error < 0 || !open)
+		return error;
+	return fd;
+}
+
+SYSCALL_DEFINE4(mkdirat2, int, dfd, const char __user *, pathname, umode_t, mode, int, flags)
+{
+	return do_mkdirat2(dfd, pathname, mode, flags, true);
 }
 
 SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 {
-	return do_mkdirat(dfd, pathname, mode);
+	return do_mkdirat2(dfd, pathname, mode, 0, false);
 }
 
 SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 {
-	return do_mkdirat(AT_FDCWD, pathname, mode);
+	return do_mkdirat2(AT_FDCWD, pathname, mode, 0, false);
 }
 
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index aea0ce9f3b74..8dd5d7acc333 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -417,6 +417,7 @@ asmlinkage long sys_flock(unsigned int fd, unsigned int cmd);
 asmlinkage long sys_mknodat(int dfd, const char __user * filename, umode_t mode,
 			    unsigned dev);
 asmlinkage long sys_mkdirat(int dfd, const char __user * pathname, umode_t mode);
+asmlinkage long sys_mkdirat2(int dfd, const char __user * pathname, umode_t mode, int flags);
 asmlinkage long sys_unlinkat(int dfd, const char __user * pathname, int flag);
 asmlinkage long sys_symlinkat(const char __user * oldname,
 			      int newdfd, const char __user * newname);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..5a4604461ede 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_process_madvise 441
+__SYSCALL(__NR_mkdirat2, sys_mkdirat2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
-- 
2.30.1

