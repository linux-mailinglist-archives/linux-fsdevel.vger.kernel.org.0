Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F192826BE2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIPHgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 03:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIPHgd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:36:33 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B6B208E4;
        Wed, 16 Sep 2020 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600241791;
        bh=se3Udbx91kNx1a0A8t/3JeMzdCutyr/VzpYxqejei5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/7Ndhwb8T/7mwniL4+A8fFh1KQZWPRB9LA4W4iBk8F4+A0xFk+/0A28K4FtsgJ7i
         BONZWt7kNcocO19oDk0+aaQ+TDVjGVsmesrmN1056AYjjBznPD74DQfYrPlsZSWWeL
         qz7wwxRI3qqZunT6fvNqJjx+AaxjzDlpcvn9rXAg=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 4/5] arch, mm: wire up memfd_secret system call were relevant
Date:   Wed, 16 Sep 2020 10:35:38 +0300
Message-Id: <20200916073539.3552-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916073539.3552-1-rppt@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Wire up memfd_secret system call on architectures that define
ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd.h        | 2 +-
 arch/arm64/include/asm/unistd32.h      | 2 ++
 arch/arm64/include/uapi/asm/unistd.h   | 1 +
 arch/riscv/include/asm/unistd.h        | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/linux/syscalls.h               | 1 +
 include/uapi/asm-generic/unistd.h      | 7 ++++++-
 8 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3b859596840d..b3b2019f8d16 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		441
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 734860ac7cf9..ce0838fc7a5c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -887,6 +887,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_memfd_secret 440
+__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index f83a70e07df8..ce2ee8f1e361 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -20,5 +20,6 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 #define __ARCH_WANT_SYS_CLONE3
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 977ee6181dab..6c316093a1e5 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -9,6 +9,7 @@
  */
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 9d1102873666..e7a58a360732 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -444,3 +444,4 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	memfd_secret		sys_memfd_secret
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a688..635d7aa2bb9a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,6 +361,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	memfd_secret		sys_memfd_secret
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8ae93c..78afb99c6892 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1006,6 +1006,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_memfd_secret(unsigned long flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 995b36c2ea7d..d063e37dbb4a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -860,8 +860,13 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 
+#ifdef __ARCH_WANT_MEMFD_SECRET
+#define __NR_memfd_secret 440
+__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
-- 
2.28.0

