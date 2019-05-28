Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49DC2C3F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE1KKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 06:10:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbfE1KKV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 06:10:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 613D9AE16;
        Tue, 28 May 2019 10:10:17 +0000 (UTC)
From:   Cyril Hrubis <chrubis@suse.cz>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH] [RFC] Remove bdflush syscall stub
Date:   Tue, 28 May 2019 12:10:12 +0200
Message-Id: <20190528101012.11402-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing LTP testcases I've found that we still carry workaround
for 17 years old distributions that attempted to start bdflush from
userspace. I guess it's about the time to remove it.

I've tested the patch on i386. Before the patch calling bdflush() with
attempt to tune a variable returned 0 and after the patch the syscall
fails with EINVAL. You can use the now deleted LTP bdflush testcase for
testing:

https://github.com/linux-test-project/ltp/commit/53ede74305ff7f6498d7456b6e3ea3053ed4b7dd

Also I'm not 100% sure that I patched all the syscall tables correctly,
so this needs a proper review from arch maintainers.

CC: linux-alpha@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-ia64@vger.kernel.org
CC: linux-m68k@lists.linux-m68k.org
CC: Michal Simek <monstr@monstr.eu>
CC: linux-mips@vger.kernel.org
CC: linux-parisc@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-s390@vger.kernel.org
CC: linux-sh@vger.kernel.org
CC: sparclinux@vger.kernel.org
CC: linux-xtensa@linux-xtensa.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-api@vger.kernel.org
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 arch/alpha/kernel/syscalls/syscall.tbl        |  2 +-
 arch/arm/tools/syscall.tbl                    |  2 +-
 arch/arm64/include/asm/unistd32.h             |  3 +--
 arch/ia64/kernel/syscalls/syscall.tbl         |  2 +-
 arch/m68k/kernel/syscalls/syscall.tbl         |  2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl   |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl       |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl         |  2 +-
 arch/sh/include/uapi/asm/unistd_64.h          |  2 +-
 arch/sh/kernel/syscalls/syscall.tbl           |  2 +-
 arch/sh/kernel/syscalls_64.S                  |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl        |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |  2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl       |  2 +-
 fs/buffer.c                                   | 27 -------------------
 include/linux/syscalls.h                      |  1 -
 kernel/sys_ni.c                               |  1 -
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  2 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
 21 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 9e7704e44f6d..3a08a2708a8a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -230,7 +230,7 @@
 259	common	osf_swapctl			sys_ni_syscall
 260	common	osf_memcntl			sys_ni_syscall
 261	common	osf_fdatasync			sys_ni_syscall
-300	common	bdflush				sys_bdflush
+# 300 was sys_bdflush
 301	common	sethae				sys_sethae
 302	common	mount				sys_mount
 303	common	old_adjtimex			sys_old_adjtimex
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..3f247c627b5f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -147,7 +147,7 @@
 131	common	quotactl		sys_quotactl
 132	common	getpgid			sys_getpgid
 133	common	fchdir			sys_fchdir
-134	common	bdflush			sys_bdflush
+# 134 was sys_bdflush
 135	common	sysfs			sys_sysfs
 136	common	personality		sys_personality
 # 137 was sys_afs_syscall
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c39e90600bb3..fd23e4db9d76 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -289,8 +289,7 @@ __SYSCALL(__NR_quotactl, sys_quotactl)
 __SYSCALL(__NR_getpgid, sys_getpgid)
 #define __NR_fchdir 133
 __SYSCALL(__NR_fchdir, sys_fchdir)
-#define __NR_bdflush 134
-__SYSCALL(__NR_bdflush, sys_bdflush)
+			/* 134 was sys_bdflush */
 #define __NR_sysfs 135
 __SYSCALL(__NR_sysfs, sys_sysfs)
 #define __NR_personality 136
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e01df3f2f80d..9cd63d82de53 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -123,7 +123,7 @@
 # 1135 was get_kernel_syms
 # 1136 was query_module
 113	common	quotactl			sys_quotactl
-114	common	bdflush				sys_bdflush
+# 114 was bdflush
 115	common	sysfs				sys_sysfs
 116	common	personality			sys_personality
 117	common	afs_syscall			sys_ni_syscall
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7e3d0734b2f3..0c44ee777964 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+# 134 was bdflush
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 # 137 was afs_syscall
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..1f1288d6212d 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+# 134 was bdflush
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 137	common	afs_syscall			sys_ni_syscall
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3cc1374e02d0..537a3828b9a0 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -145,7 +145,7 @@
 131	o32	quotactl			sys_quotactl
 132	o32	getpgid				sys_getpgid
 133	o32	fchdir				sys_fchdir
-134	o32	bdflush				sys_bdflush
+# 134 was sys_bdflush
 135	o32	sysfs				sys_sysfs
 136	o32	personality			sys_personality			sys_32_personality
 137	o32	afs_syscall			sys_ni_syscall
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c9e377d59232..3ab53f3ed358 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -147,7 +147,7 @@
 131	common	quotactl		sys_quotactl
 132	common	getpgid			sys_getpgid
 133	common	fchdir			sys_fchdir
-134	common	bdflush			sys_bdflush
+# 134 was sys_bdflush
 135	common	sysfs			sys_sysfs
 136	32	personality		parisc_personality
 136	64	personality		sys_personality
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 103655d84b4b..5ce016e6122c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -176,7 +176,7 @@
 131	nospu	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+# 134 was bdflush
 135	common	sysfs				sys_sysfs
 136	32	personality			sys_personality			ppc64_personality
 136	64	personality			ppc64_personality
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e822b2964a83..3364da213530 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -122,7 +122,7 @@
 131  common	quotactl		sys_quotactl			sys_quotactl
 132  common	getpgid			sys_getpgid			sys_getpgid
 133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_bdflush			sys_bdflush
+# 134 was bdflush
 135  common	sysfs			sys_sysfs			sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index 75da54851f02..5bd0f0c29a95 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -149,7 +149,7 @@
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
-#define __NR_bdflush		134
+				/* 134 was sys_bdflush */
 #define __NR_sysfs		135
 #define __NR_personality	136
 				/* 137 was sys_afs_syscall */
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 016a727d4357..328edef02905 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+# 134 was bdflush
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 # 137 was afs_syscall
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
index 1bcb86f0b728..1b7ad08f5d2f 100644
--- a/arch/sh/kernel/syscalls_64.S
+++ b/arch/sh/kernel/syscalls_64.S
@@ -151,7 +151,7 @@ sys_call_table:
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
-	.long sys_bdflush
+	.long sys_ni_syscall		/* 134 old bdflush */
 	.long sys_sysfs			/* 135 */
 	.long sys_personality
 	.long sys_ni_syscall	/* for afs_syscall */
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e047480b1605..e199062c38c7 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -270,7 +270,7 @@
 222	common	delete_module		sys_delete_module
 223	common	get_kernel_syms		sys_ni_syscall
 224	common	getpgid			sys_getpgid
-225	common	bdflush			sys_bdflush
+225	common	bdflush			sys_ni_syscall
 226	common	sysfs			sys_sysfs
 227	common	afs_syscall		sys_nis_syscall
 228	common	setfsuid		sys_setfsuid16
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..b699144d52fc 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -145,7 +145,7 @@
 131	i386	quotactl		sys_quotactl			__ia32_compat_sys_quotactl32
 132	i386	getpgid			sys_getpgid			__ia32_sys_getpgid
 133	i386	fchdir			sys_fchdir			__ia32_sys_fchdir
-134	i386	bdflush			sys_bdflush			__ia32_sys_bdflush
+134	i386	bdflush			sys_ni_syscall			sys_ni_syscall
 135	i386	sysfs			sys_sysfs			__ia32_sys_sysfs
 136	i386	personality		sys_personality			__ia32_sys_personality
 137	i386	afs_syscall
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..6b9fdddd7994 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -223,7 +223,7 @@
 # 205 was old nfsservctl
 205	common	nfsservctl			sys_ni_syscall
 206	common	_sysctl				sys_sysctl
-207	common	bdflush				sys_bdflush
+207	common	bdflush				sys_ni_syscall
 208	common	uname				sys_newuname
 209	common	sysinfo				sys_sysinfo
 210	common	init_module			sys_init_module
diff --git a/fs/buffer.c b/fs/buffer.c
index e450c55f6434..6f052ada051c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3307,33 +3307,6 @@ int try_to_free_buffers(struct page *page)
 }
 EXPORT_SYMBOL(try_to_free_buffers);
 
-/*
- * There are no bdflush tunables left.  But distributions are
- * still running obsolete flush daemons, so we terminate them here.
- *
- * Use of bdflush() is deprecated and will be removed in a future kernel.
- * The `flush-X' kernel threads fully replace bdflush daemons and this call.
- */
-SYSCALL_DEFINE2(bdflush, int, func, long, data)
-{
-	static int msg_count;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (msg_count < 5) {
-		msg_count++;
-		printk(KERN_INFO
-			"warning: process `%s' used the obsolete bdflush"
-			" system call\n", current->comm);
-		printk(KERN_INFO "Fix your initscripts?\n");
-	}
-
-	if (func == 1)
-		do_exit(0);
-	return 0;
-}
-
 /*
  * Buffer-head allocation
  */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..3ede2f17a044 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1104,7 +1104,6 @@ asmlinkage long sys_ustat(unsigned dev, struct ustat __user *ubuf);
 asmlinkage long sys_vfork(void);
 asmlinkage long sys_recv(int, void __user *, size_t, unsigned);
 asmlinkage long sys_send(int, void __user *, size_t, unsigned);
-asmlinkage long sys_bdflush(int func, long data);
 asmlinkage long sys_oldumount(char __user *name);
 asmlinkage long sys_uselib(const char __user *library);
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..5bab44795a17 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -405,7 +405,6 @@ COND_SYSCALL(epoll_wait);
 COND_SYSCALL(recv);
 COND_SYSCALL_COMPAT(recv);
 COND_SYSCALL(send);
-COND_SYSCALL(bdflush);
 COND_SYSCALL(uselib);
 
 
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index db3bbb8744af..56b5567de7ff 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -169,7 +169,7 @@
 131	nospu	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+134	common	bdflush				sys_ni_syscall
 135	common	sysfs				sys_sysfs
 136	32	personality			sys_personality			ppc64_personality
 136	64	personality			ppc64_personality
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index b38d48464368..a83eba11c877 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -122,7 +122,7 @@
 131  common	quotactl		sys_quotactl			compat_sys_quotactl
 132  common	getpgid			sys_getpgid			sys_getpgid
 133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_bdflush			compat_sys_bdflush
+134  common	bdflush			-				-
 135  common	sysfs			sys_sysfs			compat_sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
-- 
2.21.0

