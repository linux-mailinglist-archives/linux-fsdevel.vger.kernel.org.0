Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324171AC635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgDPOfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 10:35:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728551AbgDPOfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587047738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mOJ9kmDKiVnV3a7Y16W/iKQ6cpMDxJKcLsNdQiBKNwM=;
        b=ah1Inv9KswGWkDjGK0DoTQcU45ugbkw5qsuTOh/VcMHW4sVex05j5AL7jQMHQD74zWXqwH
        W+m28oxrQqYvDHPK8Iu+kCeQF9ceVm+S9YbJko7CPVSxeeMyQwF55xsLfHSmbxdhzDseBl
        8LV8Wpv/Gt3wqrclCHrUQerpRzJT9IU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-o4j34fHmMCy62hy1ZF6qRA-1; Thu, 16 Apr 2020 10:35:37 -0400
X-MC-Unique: o4j34fHmMCy62hy1ZF6qRA-1
Received: by mail-wr1-f72.google.com with SMTP id j22so1822287wrb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOJ9kmDKiVnV3a7Y16W/iKQ6cpMDxJKcLsNdQiBKNwM=;
        b=kk0veUBaEIhWF/3EL4S2ESZhDxl4NUqzt80K/XchNnUYPAkdHJdE8A73Vd4vhhcSn7
         3dPTntO82QWidG+nUGUO//PKxn+/B+1IGVF8282rrRxsKl7epuiIv89ODQOcBp4BPxXN
         KTwwDQWpY4nELijzwXGBGfsL6F3MyYNKfxJlwP/O/TV7q27E92u8W9LnzmLAliRhfWRC
         GcHDd55JNjM4DB2y7COEbiAo0UM7IpCr6hH9pM20MFNMdSX7rH/8+ZIi80AO7xt9bYVq
         Auj3gTlrTSqO0z895oTO8qZgL5jL9hVXqO0Lm8BmxT21VDW9AgZYo3iQtcVuZRQlNlZe
         WdRQ==
X-Gm-Message-State: AGi0PuZXTl4jLuQCRNXcQ47EbtC/QYP2a3r3nDjuIPg2ksgJV10E4Wtx
        VE7qFHMOkq9gxis3W4TouwLqYmW/BnAqHXIX9RAcGaswH9Z0WsRZZ5hBX6yaoJnfAbwwH0FtrdZ
        btbGxgHO6mvJTcBlqfjdaz5s4iQ==
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr5449264wmb.79.1587047735533;
        Thu, 16 Apr 2020 07:35:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypILmvXZjHsEMyYfTHeL5GkyREpiFhTmsQOFgCr1ncefGwfzylEh2GRXdLWY3CGLbRVw/F37fA==
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr5449215wmb.79.1587047735024;
        Thu, 16 Apr 2020 07:35:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 1sm4057533wmi.0.2020.04.16.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:35:34 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] vfs: add faccessat2 syscall
Date:   Thu, 16 Apr 2020 16:35:32 +0200
Message-Id: <20200416143532.11743-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
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
 fs/open.c                                   | 56 ++++++++++++++++-----
 include/linux/syscalls.h                    |  7 ++-
 include/uapi/asm-generic/unistd.h           |  4 +-
 include/uapi/linux/fcntl.h                  | 10 ++++
 23 files changed, 80 insertions(+), 18 deletions(-)

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
index 719b320ede52..f30cd5d46ac1 100644
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
@@ -394,6 +387,36 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
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
+	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW))
+		return -EINVAL;
+
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
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
@@ -435,19 +458,26 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
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

