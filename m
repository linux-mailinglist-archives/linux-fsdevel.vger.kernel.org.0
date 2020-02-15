Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB61A15FF00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgBOPhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:37:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53064 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgBOPhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:37:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C15A48EE302;
        Sat, 15 Feb 2020 07:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781074;
        bh=g1xQnKvgTT/Bp3YFWXKHmacREUxY5RF57sqz/uo5Hy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceaIPTZst+klnMBYIeE2D4KTbAb9VZBgxvTJl7JDpeV4Aii/gB2jU3WA16NVnPt0u
         ou6svuHnosTDS8/OQxALydBFDU1QR37LzfYqZ+yy3e9+PwAgT/g/SzgMwT6a/+cwGk
         V0oHAZwF1yUQlEDVjWFtCu6HoRaaJf5/8dApvuRA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1vLRYk4ZX36h; Sat, 15 Feb 2020 07:37:54 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 87DB78EE121;
        Sat, 15 Feb 2020 07:37:53 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 3/6] configfd: syscall: wire up configfd syscalls
Date:   Sat, 15 Feb 2020 10:36:06 -0500
Message-Id: <20200215153609.23797-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: Changed numbering to avoid clash with pidfd calls
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 ++
 arch/arm/tools/syscall.tbl                  | 2 ++
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 4 ++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl       | 2 ++
 arch/sh/kernel/syscalls/syscall.tbl         | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 ++
 arch/x86/entry/syscalls/syscall_32.tbl      | 2 ++
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 ++
 include/linux/syscalls.h                    | 5 +++++
 include/uapi/asm-generic/unistd.h           | 9 +++++++--
 20 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 36d42da7466a..657c9cd71307 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -477,3 +477,5 @@
 # 545 reserved for clone3
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
+549	common	configfd_open			configfd_open
+550	common	configfd_action			configfd_action
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 4d1cf74a2caa..43cbcfe14e38 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -451,3 +451,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 1dd22da1c3a9..bc0f923e0e04 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		439
+#define __NR_compat_syscalls		441
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c1c61635f89c..46881451186e 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -883,6 +883,10 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_configfd_open 439
+__SYSCALL(__NR_configfd_open, sys_configfd_open)
+#define __NR_configfd_action 440
+__SYSCALL(__NR_configfd_action, sys_configfd_action)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 042911e670b8..e9c143d99b96 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -358,3 +358,5 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f4f49fcb76d0..d9b54e720918 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -437,3 +437,5 @@
 435	common	clone3				__sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4c67b11f9c9e..4431f66cb9a6 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -443,3 +443,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1f9e8ad636cc..51523527fe88 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -376,3 +376,5 @@
 435	n32	clone3				__sys_clone3
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
+439	n32	configfd_open			sys_configfd_open
+440	n32	configfd_action			sys_configfd_action
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c0b9d802dbf6..eae82af997c2 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -352,3 +352,5 @@
 435	n64	clone3				__sys_clone3
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
+439	n64	configfd_open			sys_configfd_open
+440	n64	configfd_action			sys_configfd_action
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ac586774c980..d813d89521a3 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -425,3 +425,5 @@
 435	o32	clone3				__sys_clone3
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
+439	o32	configfd_open			sys_configfd_open
+440	o32	configfd_action			sys_configfd_action
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 52a15f5cd130..f24f48b7123a 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -435,3 +435,5 @@
 435	common	clone3				sys_clone3_wrapper
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 35b61bfc1b1a..4586f9c5a76c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -519,3 +519,5 @@
 435	nospu	clone3				ppc_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bd7bd3581a0f..a047a75ed6e7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -440,3 +440,5 @@
 435  common	clone3			sys_clone3			sys_clone3
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
+439  common	configfd_open		sys_configfd_open		sys_configfd_open
+440  common	configfd_action		sys_configfd_action		sys_configfd_action
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c7a30fcd135f..435bf5ce7be0 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -440,3 +440,5 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index f13615ecdecc..4f73a7d80c4a 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -483,3 +483,5 @@
 # 435 reserved for clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..fc5101e9e6c4 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,5 @@
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+436	i386	configfd_open		sys_configfd_open		__ia32_sys_configfd_open
+437	i386	configfd_action		sys_configfd_action		__ia32_sys_configfd_action
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..3dc52c1329dc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,8 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+439	common	configfd_open		__x64_sys_configfd_open
+440	common	configfd_action		__x64_sys_configfd_action
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 85a9ab1bc04d..b023e36c4964 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -408,3 +408,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	configfd_open			sys_configfd_open
+440	common	configfd_action			sys_configfd_action
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..298d56120470 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,11 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_configfd_open(const char __user *config_name,
+				  unsigned int flags, unsigned int op);
+asmlinkage long sys_configfd_action(int fd, unsigned int cmd,
+				    const char __user *key, void __user *value,
+				    int aux);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..29c55ef11fb1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -849,15 +849,20 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
-#endif
 
+#endif
 #define __NR_openat2 437
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_configfd_open 439
+__SYSCALL(__NR_configfd_open, sys_configfd_open)
+#define __NR_configfd_action 440
+__SYSCALL(__NR_configfd_action, sys_configfd_action)
+
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
-- 
2.16.4

