Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9D32D35A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbhCDMhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 07:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbhCDMhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:37:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2FC061763
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 04:36:04 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lHnD1-0006w1-63; Thu, 04 Mar 2021 13:36:03 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lHnD0-00044H-12; Thu, 04 Mar 2021 13:36:02 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] quota: wire up quotactl_path
Date:   Thu,  4 Mar 2021 13:35:40 +0100
Message-Id: <20210304123541.30749-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304123541.30749-1-s.hauer@pengutronix.de>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the quotactl_path syscall added in the previous patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/linux/syscalls.h                    | 2 ++
 include/uapi/asm-generic/unistd.h           | 4 +++-
 kernel/sys_ni.c                             | 1 +
 21 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 02f0244e005c..c5f7e595adab 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -482,3 +482,4 @@
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
 552	common	mount_setattr			sys_mount_setattr
+553	common	quotactl_path			sys_quotactl_path
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index dcc1191291a2..90cbe207cf3e 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -456,3 +456,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 949788f5ba40..d1f7d35f986e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		443
+#define __NR_compat_syscalls		444
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 3d874f624056..8361c5138e5f 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,6 +893,8 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
+#define __NR_quotactl_path 443
+__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index d89231166e19..c072cd459bb5 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -363,3 +363,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 72bde6707dd3..5e9f81073ff4 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index d603a5ec9338..8e74d690c64d 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -448,3 +448,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 8fd8c1790941..6f397e56926f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -381,3 +381,4 @@
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
 442	n32	mount_setattr			sys_mount_setattr
+443	n32	quotactl_path			sys_quotactl_path
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 169f21438065..ab85a357c4fa 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -357,3 +357,4 @@
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
 442	n64	mount_setattr			sys_mount_setattr
+443	n64	quotactl_path			sys_quotactl_path
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 090d29ca80ff..9c4cd2b40b38 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -430,3 +430,4 @@
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	o32	mount_setattr			sys_mount_setattr
+443	o32	quotactl_path			sys_quotactl_path
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 271a92519683..80fba3f7d47b 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 0b2480cf3e47..f66f9c9b9d6c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -522,3 +522,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3abef2144dac..4aeaa89fa774 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
+443  common	quotactl_path		sys_quotactl_path
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index d08eebad6b7f..f68517aaa4f1 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 84403a99039c..3ee82321504d 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -488,3 +488,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index a1c9f496fca6..f52a443eede0 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,3 +447,4 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	mount_setattr		sys_mount_setattr
+443	i386	quotactl_path		sys_quotactl_path
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7bf01cbe582f..7eb007b8cab5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,6 +364,7 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
+443	common	quotactl_path		sys_quotactl_path
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 365a9b849224..c71cc45633de 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -413,3 +413,4 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_path			sys_quotactl_path
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2839dc9a7c01..a672bbe28577 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -483,6 +483,8 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
 /* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
+asmlinkage long sys_quotactl_path(unsigned int cmd, const char __user *mountpoint,
+				  qid_t id, void __user *addr);
 
 /* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index ce58cff99b66..739c839d28fe 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,11 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
+#define __NR_quotactl_path 443
+__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 444
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 19aa806890d5..d24431782414 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -99,6 +99,7 @@ COND_SYSCALL(flock);
 
 /* fs/quota.c */
 COND_SYSCALL(quotactl);
+COND_SYSCALL(quotactl_path);
 
 /* fs/readdir.c */
 
-- 
2.29.2

