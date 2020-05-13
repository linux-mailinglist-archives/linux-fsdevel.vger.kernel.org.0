Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1041D0A0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEMHpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 03:45:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47548 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728905AbgEMHpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 03:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589355943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTVKEXTYKjX2gBNpEHYaccp5hXXk/IEh6T4/2VqJQSA=;
        b=Qz9tqxQZWALmKPIdeR8BV0k6IRYdMPaUv3ok24fvK3LhdBUigoKti/MLjfVPjypnhbcadF
        Pqy2ylLcWnOiAtrP3yruXNqv1bDHAHvO5lHr/AAz9aQHFz36DMQpOoBhcB4eieblQD8XmX
        J0ji57jt5FEtL5RT3QNyy9lyrl61TIc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-_PaYkC9fMgG5YxX7mNOa8A-1; Wed, 13 May 2020 03:45:41 -0400
X-MC-Unique: _PaYkC9fMgG5YxX7mNOa8A-1
Received: by mail-wr1-f69.google.com with SMTP id 37so5003099wrc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 00:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTVKEXTYKjX2gBNpEHYaccp5hXXk/IEh6T4/2VqJQSA=;
        b=M0yg4x/dRptSKGaQ5HCBsry007hAQQAG6r72ET9BkuwPEcL8GjpPZJu4cz/LdJik1G
         2Whe4MMZj02hbQHqK4ojaLJljikBuc+NIcJWrtFNCKSv79SjyCsP+8i04i80LOAnKvp7
         mrkCwKZ42qbyrOUKiyEZqTMXWW6BaFhFivmZlipMOq8btTfs8HSE7T9gG6lAzc32/QUz
         cnor8GydT/xXuXW7jUX1GlqGVfWtavfeCReGVtaVrKjRknJFioolEglMf4AqOdOLfPEZ
         BFnieYGaGGd7DUE6SIAXgWmvVSHjkB+KueBUKiUv9lcAvAA4pf7R3wgeiF5oBm1ZYJmb
         HnjQ==
X-Gm-Message-State: AGi0PuZl4t07Qo/UhHDENMsqAvys2oOig6cK69M+vygJi15KhN236wwQ
        OaHZr122Nl05o4tNn4ugjKyQWRAyonvjJ8keA9EfralifLGHtNQML+IPtaBLI9GYrfV0Vad6enU
        cnaDCGVdU0ZCSVHy8P5XqG3rcpg==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr27536476wrd.99.1589355939974;
        Wed, 13 May 2020 00:45:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZ1wT9JSuT4RqUZrDP8ZNWGpYezSo9HONWqRJ0VK/wO4e23prC3Z6S3c1ZSS4I36EWhZjObA==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr27536438wrd.99.1589355939464;
        Wed, 13 May 2020 00:45:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id c17sm26518798wrn.59.2020.05.13.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 00:45:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [13/12 PATCH] vfs: add faccessat2 syscall
Date:   Wed, 13 May 2020 09:45:37 +0200
Message-Id: <20200513074537.1617-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX defines faccessat() as having a fourth "flags" argument, while the
linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.

Add a new faccessat(2) syscall with the added flags argument and implement
both flags.

The value of AT_EACCESS is defined in glibc headers to be the same as
AT_REMOVEDIR.  Use this value for the kernel interface as well, together
with the explanatory comment.

Also add AT_EMPTY_PATH support, which is not documented by POSIX, but can
be useful and is trivial to implement.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
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
 fs/internal.h                               |  1 -
 fs/open.c                                   | 58 ++++++++++++++++-----
 include/linux/syscalls.h                    |  7 ++-
 include/uapi/asm-generic/unistd.h           |  4 +-
 include/uapi/linux/fcntl.h                  | 10 ++++
 23 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 36d42da7466a..5ddd128d4b7a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -477,3 +477,4 @@
 # 545 reserved for clone3
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
+549	common	faccessat2			sys_faccessat2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 4d1cf74a2caa..d5cae5ffede0 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -451,3 +451,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 803039d504de..3b859596840d 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		439
+#define __NR_compat_syscalls		440
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c1c61635f89c..6d95d0c8bf2f 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_faccessat2 439
+__SYSCALL(__NR_faccessat2, sys_faccessat2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 042911e670b8..49e325b604b3 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -358,3 +358,4 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f4f49fcb76d0..f71b1bbcc198 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 435	common	clone3				__sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4c67b11f9c9e..edacc4561f2b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1f9e8ad636cc..f777141f5256 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -376,3 +376,4 @@
 435	n32	clone3				__sys_clone3
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
+439	n32	faccessat2			sys_faccessat2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c0b9d802dbf6..da8c76394e17 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -352,3 +352,4 @@
 435	n64	clone3				__sys_clone3
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
+439	n64	faccessat2			sys_faccessat2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ac586774c980..13280625d312 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -425,3 +425,4 @@
 435	o32	clone3				__sys_clone3
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
+439	o32	faccessat2			sys_faccessat2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 52a15f5cd130..5a758fa6ec52 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 435	common	clone3				sys_clone3_wrapper
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 220ae11555f2..f833a3190822 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -527,3 +527,4 @@
 435	spu	clone3				sys_ni_syscall
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bd7bd3581a0f..bfdcb7633957 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 435  common	clone3			sys_clone3			sys_clone3
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
+439  common	faccessat2		sys_faccessat2			sys_faccessat2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c7a30fcd135f..acc35daa1b79 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index f13615ecdecc..8004a276cb74 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -483,3 +483,4 @@
 # 435 reserved for clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 54581ac671b4..d8f8a1a69ed1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
+439	i386	faccessat2		sys_faccessat2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..78847b32e137 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			sys_clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
+439	common	faccessat2		sys_faccessat2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 85a9ab1bc04d..69d0d73876b3 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -408,3 +408,4 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
diff --git a/fs/internal.h b/fs/internal.h
index aa5d45524e87..0d467e32dd7e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -126,7 +126,6 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
-long do_faccessat(int dfd, const char __user *filename, int mode);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
diff --git a/fs/open.c b/fs/open.c
index 719b320ede52..6f3cdf109ec0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -345,21 +345,14 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-long do_faccessat(int dfd, const char __user *filename, int mode)
+static const struct cred *access_override_creds(void)
 {
 	const struct cred *old_cred;
 	struct cred *override_cred;
-	struct path path;
-	struct inode *inode;
-	int res;
-	unsigned int lookup_flags = LOOKUP_FOLLOW;
-
-	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
-		return -EINVAL;
 
 	override_cred = prepare_creds();
 	if (!override_cred)
-		return -ENOMEM;
+		return NULL;
 
 	override_cred->fsuid = override_cred->uid;
 	override_cred->fsgid = override_cred->gid;
@@ -394,6 +387,38 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 	override_cred->non_rcu = 1;
 
 	old_cred = override_creds(override_cred);
+
+	/* override_cred() gets its own ref */
+	put_cred(override_cred);
+
+	return old_cred;
+}
+
+long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
+{
+	const struct cred *old_cred = NULL;
+	struct path path;
+	struct inode *inode;
+	int res;
+	unsigned int lookup_flags = LOOKUP_FOLLOW;
+
+	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
+		return -EINVAL;
+
+	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
+		return -EINVAL;
+
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	if (!(flags & AT_EACCESS)) {
+		old_cred = access_override_creds();
+		if (!old_cred)
+			return -ENOMEM;
+	}
+
 retry:
 	res = user_path_at(dfd, filename, lookup_flags, &path);
 	if (res)
@@ -435,19 +460,26 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 		goto retry;
 	}
 out:
-	revert_creds(old_cred);
-	put_cred(override_cred);
+	if (old_cred)
+		revert_creds(old_cred);
+
 	return res;
 }
 
 SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 {
-	return do_faccessat(dfd, filename, mode);
+	return do_faccessat(dfd, filename, mode, 0);
+}
+
+SYSCALL_DEFINE4(faccessat2, int, dfd, const char __user *, filename, int, mode,
+		int, flags)
+{
+	return do_faccessat(dfd, filename, mode, flags);
 }
 
 SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 {
-	return do_faccessat(AT_FDCWD, filename, mode);
+	return do_faccessat(AT_FDCWD, filename, mode, 0);
 }
 
 int ksys_chdir(const char __user *filename)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..baec24782301 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -428,6 +428,8 @@ asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
 #endif
 asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
 asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
+asmlinkage long sys_faccessat2(int dfd, const char __user *filename, int mode,
+			       int flags);
 asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
@@ -1333,11 +1335,12 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-extern long do_faccessat(int dfd, const char __user *filename, int mode);
+extern long do_faccessat(int dfd, const char __user *filename, int mode,
+			 int flags);
 
 static inline long ksys_access(const char __user *filename, int mode)
 {
-	return do_faccessat(AT_FDCWD, filename, mode);
+	return do_faccessat(AT_FDCWD, filename, mode, 0);
 }
 
 extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..f4a01305d9a6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_faccessat2 439
+__SYSCALL(__NR_faccessat2, sys_faccessat2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ca88b7bce553..2f86b2ad6d7e 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -84,10 +84,20 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+/*
+ * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
+ * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
+ * unlinkat.  The two functions do completely different things and therefore,
+ * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
+ * faccessat would be undefined behavior and thus treating it equivalent to
+ * AT_EACCESS is valid undefined behavior.
+ */
 #define AT_FDCWD		-100    /* Special value used to indicate
                                            openat should use the current
                                            working directory. */
 #define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+#define AT_EACCESS		0x200	/* Test access permitted for
+                                           effective IDs, not real IDs.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
 #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
-- 
2.21.1

