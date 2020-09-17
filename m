Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3409526D6A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIQIbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQIba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB2C06174A;
        Thu, 17 Sep 2020 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cc06p2BxoywswAJioubUiCZ1fLeFXdznz+FEzVubHRM=; b=c62RFStpjYOoUbZOLbzVBcZXQH
        CP6h9nBf+VzK6thMzY/OxTfZd7Nt9o6+Vzv6hafUm1iByTW4wHLrt8PZcxCcE7V8jbJHyC7OlxUo6
        /kP7vbINZ5O/rM+HGpPnXTg3GTXmYbEOsOCjAsszvdzUdy17Z1fjg3E6PLeMYGdxjmkKBvPgJzRiR
        g63UjFJe+SOGT54e7pecWJ3k7+6uxfwikQFcwmaqf+xD0CcJHhDLz1rk/TBtxpn6hb8V7Qi2mGFML
        yvLMKROcSgRBY3nBNqHAP1SW6InnZct9HMGgCKFjGXmlzINAS63BgGFvnx8nBgoG3WMInh4ZQw2G7
        TACxrl2Q==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIpK6-0001aH-6b; Thu, 17 Sep 2020 08:31:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] fs: remove compat_sys_mount
Date:   Thu, 17 Sep 2020 10:22:34 +0200
Message-Id: <20200917082236.2518236-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917082236.2518236-1-hch@lst.de>
References: <20200917082236.2518236-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

compat_sys_mount is identical to the regular sys_mount now, so remove it
and use the native version everywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/unistd32.h             |  2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl     |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl       |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl         |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl        |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |  2 +-
 fs/Makefile                                   |  1 -
 fs/compat.c                                   | 57 -------------------
 fs/internal.h                                 |  3 -
 fs/namespace.c                                |  4 +-
 include/linux/compat.h                        |  6 --
 include/uapi/asm-generic/unistd.h             |  2 +-
 tools/include/uapi/asm-generic/unistd.h       |  2 +-
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  2 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
 17 files changed, 14 insertions(+), 81 deletions(-)
 delete mode 100644 fs/compat.c

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 734860ac7cf9d5..5fd095d6545022 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -53,7 +53,7 @@ __SYSCALL(__NR_lseek, compat_sys_lseek)
 #define __NR_getpid 20
 __SYSCALL(__NR_getpid, sys_getpid)
 #define __NR_mount 21
-__SYSCALL(__NR_mount, compat_sys_mount)
+__SYSCALL(__NR_mount, sys_mount)
 			/* 22 was sys_umount */
 __SYSCALL(22, sys_ni_syscall)
 #define __NR_setuid 23
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f9df9edb67a407..61fa9e7013cbc1 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -167,7 +167,7 @@
 157	n32	sync				sys_sync
 158	n32	acct				sys_acct
 159	n32	settimeofday			compat_sys_settimeofday
-160	n32	mount				compat_sys_mount
+160	n32	mount				sys_mount
 161	n32	umount2				sys_umount
 162	n32	swapon				sys_swapon
 163	n32	swapoff				sys_swapoff
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 195b43cf27c848..b992e89be7ff8a 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -29,7 +29,7 @@
 18	o32	unused18			sys_ni_syscall
 19	o32	lseek				sys_lseek
 20	o32	getpid				sys_getpid
-21	o32	mount				sys_mount			compat_sys_mount
+21	o32	mount				sys_mount
 22	o32	umount				sys_oldumount
 23	o32	setuid				sys_setuid
 24	o32	getuid				sys_getuid
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index def64d221cd4fb..07efd978182fea 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 18	common	stat			sys_newstat			compat_sys_newstat
 19	common	lseek			sys_lseek			compat_sys_lseek
 20	common	getpid			sys_getpid
-21	common	mount			sys_mount			compat_sys_mount
+21	common	mount			sys_mount
 22	common	bind			sys_bind
 23	common	setuid			sys_setuid
 24	common	getuid			sys_getuid
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c2d737ff2e7bec..a36ad4fec73c19 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -34,7 +34,7 @@
 18	spu	oldstat				sys_ni_syscall
 19	common	lseek				sys_lseek			compat_sys_lseek
 20	common	getpid				sys_getpid
-21	nospu	mount				sys_mount			compat_sys_mount
+21	nospu	mount				sys_mount
 22	32	umount				sys_oldumount
 22	64	umount				sys_ni_syscall
 22	spu	umount				sys_ni_syscall
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 10456bc936fb09..4b803dfbee2be9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -26,7 +26,7 @@
 16   32		lchown			-				sys_lchown16
 19   common	lseek			sys_lseek			compat_sys_lseek
 20   common	getpid			sys_getpid			sys_getpid
-21   common	mount			sys_mount			compat_sys_mount
+21   common	mount			sys_mount			sys_mount
 22   common	umount			sys_oldumount			sys_oldumount
 23   32		setuid			-				sys_setuid16
 24   32		getuid			-				sys_getuid16
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4af114e84f2022..d5ff798fa08f80 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -201,7 +201,7 @@
 164	64	utrap_install		sys_utrap_install
 165	common	quotactl		sys_quotactl
 166	common	set_tid_address		sys_set_tid_address
-167	common	mount			sys_mount			compat_sys_mount
+167	common	mount			sys_mount
 168	common	ustat			sys_ustat			compat_sys_ustat
 169	common	setxattr		sys_setxattr
 170	common	lsetxattr		sys_lsetxattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 9d11028736661b..5a40b226fb7b7a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -32,7 +32,7 @@
 18	i386	oldstat			sys_stat
 19	i386	lseek			sys_lseek			compat_sys_lseek
 20	i386	getpid			sys_getpid
-21	i386	mount			sys_mount			compat_sys_mount
+21	i386	mount			sys_mount
 22	i386	umount			sys_oldumount
 23	i386	setuid			sys_setuid16
 24	i386	getuid			sys_getuid16
diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa11..d72ee2ce7af080 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
-obj-$(CONFIG_COMPAT)		+= compat.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
diff --git a/fs/compat.c b/fs/compat.c
deleted file mode 100644
index 9b00523d7fa571..00000000000000
--- a/fs/compat.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/fs/compat.c
- *
- *  Kernel compatibililty routines for e.g. 32 bit syscall support
- *  on 64 bit kernels.
- *
- *  Copyright (C) 2002       Stephen Rothwell, IBM Corporation
- *  Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- *  Copyright (C) 1998       Eddie C. Dost  (ecd@skynet.be)
- *  Copyright (C) 2001,2002  Andi Kleen, SuSE Labs 
- *  Copyright (C) 2003       Pavel Machek (pavel@ucw.cz)
- */
-
-#include <linux/compat.h>
-#include <linux/nfs4_mount.h>
-#include <linux/syscalls.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include "internal.h"
-
-COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
-		       const char __user *, dir_name,
-		       const char __user *, type, compat_ulong_t, flags,
-		       const void __user *, data)
-{
-	char *kernel_type;
-	void *options;
-	char *kernel_dev;
-	int retval;
-
-	kernel_type = copy_mount_string(type);
-	retval = PTR_ERR(kernel_type);
-	if (IS_ERR(kernel_type))
-		goto out;
-
-	kernel_dev = copy_mount_string(dev_name);
-	retval = PTR_ERR(kernel_dev);
-	if (IS_ERR(kernel_dev))
-		goto out1;
-
-	options = copy_mount_options(data);
-	retval = PTR_ERR(options);
-	if (IS_ERR(options))
-		goto out2;
-
-	retval = do_mount(kernel_dev, dir_name, kernel_type, flags, options);
-
- out3:
-	kfree(options);
- out2:
-	kfree(kernel_dev);
- out1:
-	kfree(kernel_type);
- out:
-	return retval;
-}
diff --git a/fs/internal.h b/fs/internal.h
index 10517ece45167f..a7cd0f64faa4ab 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -82,9 +82,6 @@ int may_linkat(struct path *link);
 /*
  * namespace.c
  */
-extern void *copy_mount_options(const void __user *);
-extern char *copy_mount_string(const void __user *);
-
 extern struct vfsmount *lookup_mnt(const struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713a3..12b431b61462b9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3072,7 +3072,7 @@ static void shrink_submounts(struct mount *mnt)
 	}
 }
 
-void *copy_mount_options(const void __user * data)
+static void *copy_mount_options(const void __user * data)
 {
 	char *copy;
 	unsigned size;
@@ -3097,7 +3097,7 @@ void *copy_mount_options(const void __user * data)
 	return copy;
 }
 
-char *copy_mount_string(const void __user *data)
+static char *copy_mount_string(const void __user *data)
 {
 	return data ? strndup_user(data, PATH_MAX) : NULL;
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index b354ce58966e2d..92db17cc5c5e33 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -522,12 +522,6 @@ asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
 asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
 				 compat_ulong_t arg);
 
-/* fs/namespace.c */
-asmlinkage long compat_sys_mount(const char __user *dev_name,
-				 const char __user *dir_name,
-				 const char __user *type, compat_ulong_t flags,
-				 const void __user *data);
-
 /* fs/open.c */
 asmlinkage long compat_sys_statfs(const char __user *pathname,
 				  struct compat_statfs __user *buf);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 995b36c2ea7d8a..fc98c943760976 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -140,7 +140,7 @@ __SYSCALL(__NR_renameat, sys_renameat)
 #define __NR_umount2 39
 __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
-__SC_COMP(__NR_mount, sys_mount, compat_sys_mount)
+__SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 995b36c2ea7d8a..fc98c943760976 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -140,7 +140,7 @@ __SYSCALL(__NR_renameat, sys_renameat)
 #define __NR_umount2 39
 __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
-__SC_COMP(__NR_mount, sys_mount, compat_sys_mount)
+__SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 3ca6fe057a0b1f..c2866c65965061 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -32,7 +32,7 @@
 18	spu	oldstat				sys_ni_syscall
 19	common	lseek				sys_lseek			compat_sys_lseek
 20	common	getpid				sys_getpid
-21	nospu	mount				sys_mount			compat_sys_mount
+21	nospu	mount				sys_mount
 22	32	umount				sys_oldumount
 22	64	umount				sys_ni_syscall
 22	spu	umount				sys_ni_syscall
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 6a0bbea225db0d..8e0806f6c38eb0 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -26,7 +26,7 @@
 16   32		lchown			-				compat_sys_s390_lchown16
 19   common	lseek			sys_lseek			compat_sys_lseek
 20   common	getpid			sys_getpid			sys_getpid
-21   common	mount			sys_mount			compat_sys_mount
+21   common	mount			sys_mount
 22   common	umount			sys_oldumount			compat_sys_oldumount
 23   32		setuid			-				compat_sys_s390_setuid16
 24   32		getuid			-				compat_sys_s390_getuid16
-- 
2.28.0

