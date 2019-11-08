Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF67F5999
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfKHVQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 16:16:12 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfKHVQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:16:11 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCsDe-1ic1JZ3Rz6-008poH; Fri, 08 Nov 2019 22:16:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/23] y2038: elfcore: Use __kernel_old_timeval for process times
Date:   Fri,  8 Nov 2019 22:12:14 +0100
Message-Id: <20191108211323.1806194-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jJojK3GiEOpLM7nwlbXZNSOESRosCVwj5pL0X9lm4+C8cBKFL1S
 Dgm24ZnjpoaIvukTU6X4jJfn96PXIzcY6MP6bjF62TfoHkAeQgzH49ROujOrn1fpIsoM09/
 HKTa02uW1U4TPcKiz4g9gPFN0Fa+heEeG/9P/EZq+4emvnDDomoY5uqxCtc8uZ30umxaNar
 ZBjGfTscleMnAJ5MoAZEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4ZvUmxYbvk=:tdMp3SjJI1NixeGmYbfJi1
 FjhwWRH2/gb/09RHbThSA8EWr9HJj33qjeVhZwnt/bGUO7te3W9PkAy2rOO5/fyC6ObdbEytF
 tXdZ/OglNAHLMt+mdK5/3ayYW7Wo1VlFf1X7+bUshD0Gg8vRXSjPvhYJXxCg42V0rgb4DSK+P
 9pw6S6Pz4T+fsw5ArKd1S97W3cpScnh8YItd65tyvbQV6cqqgUMQB3o2I3/P2NrzW8TKy21yT
 GIkNg6cnTALOmJgixhpr60A0W3V0LokMsZhOFFhlipifv63toB2cLBgC2S+0+rWBby3B429GJ
 FBMQCmgQ4xpvBVswkV+AVCVJ22DbC+4aWihAwqH1kmJbK0dXsH/YC/kjO6V2Ld8P8uBx+VWaU
 Sv0pg9mh8S2EdoailtDfaPxIP08cryt5pbM1jSFUUnA5NzRN0x0Dx1cHV3BxZnimCvE/4lfWy
 gMUF2olUoIIRGg9DKSXyyRa9/CC2Qo4sB3owLaZoa90zbnXwPvIUy1xkqCA4+M3w176fA7j19
 HnMbSCB5fHJwkAzND9qhijd9AZgGIAFHsCyZRk0QboVJQAqaPDlHlIiLIo89U2aaCv4a3aBlA
 7cvcsSV2v+KYGc8EPn0ffryoObhQT/u7aRhYQnPLKo/vsRw/bfb2reWRad7eGbY7D+rhz+x9Z
 f6px8k300Q4cNH/UFOQO9GJoyTknzJEIlnGjwhgsXU4+gabUlKojJU/BnPL3IyHucwiXq1bde
 JZyBcT2IxQJTiY9RnxAE3vi15RScKIqutA0/jGROBiyrxYrJMsxOxIucHd+bg7/xsiC2B96Bl
 SammEu9W73fW1aNQrtZJkaDfe8mm2Vk/HDHulH9O8C96BQQT1YXlj3adbprjoTCK7mTq2lbKX
 xk7TJfpJIXabV0bRrP4Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We store elapsed time for a crashed process in struct elf_prstatus using
'timeval' structures. Once glibc starts using 64-bit time_t, this becomes
incompatible with the kernel's idea of timeval since the structure layout
no longer matches on 32-bit architectures.

This changes the definition of the elf_prstatus structure to use
__kernel_old_timeval instead, which is hardcoded to the currently used
binary layout. There is no risk of overflow in y2038 though, because
the time values are all relative times, and can store up to 68 years
of process elapsed time.

There is a risk of applications breaking at build time when they
use the new kernel headers and expect the type to be exactly 'timeval'
rather than a structure that has the same fields as before. Those
applications have to be modified to deal with 64-bit time_t anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/binfmt_elfn32.c |  4 ++--
 arch/mips/kernel/binfmt_elfo32.c |  4 ++--
 fs/binfmt_elf.c                  | 12 ++++++------
 fs/binfmt_elf_fdpic.c            | 12 ++++++------
 fs/compat_binfmt_elf.c           |  4 ++--
 include/uapi/linux/elfcore.h     |  8 ++++----
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 7a12763d553a..6ee3f7218c67 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -100,7 +100,7 @@ jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_old_timeval32
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_old_timeval32
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index e6db06a1d31a..6dd103d3cebb 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -103,7 +103,7 @@ jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_old_timeval32
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_old_timeval32
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c5642bcb6b46..5372eabd276a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1489,18 +1489,18 @@ static void fill_prstatus(struct elf_prstatus *prstatus,
 		 * group-wide total, not its individual thread total.
 		 */
 		thread_group_cputime(p, &cputime);
-		prstatus->pr_utime = ns_to_timeval(cputime.utime);
-		prstatus->pr_stime = ns_to_timeval(cputime.stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(cputime.utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(cputime.stime);
 	} else {
 		u64 utime, stime;
 
 		task_cputime(p, &utime, &stime);
-		prstatus->pr_utime = ns_to_timeval(utime);
-		prstatus->pr_stime = ns_to_timeval(stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(stime);
 	}
 
-	prstatus->pr_cutime = ns_to_timeval(p->signal->cutime);
-	prstatus->pr_cstime = ns_to_timeval(p->signal->cstime);
+	prstatus->pr_cutime = ns_to_kernel_old_timeval(p->signal->cutime);
+	prstatus->pr_cstime = ns_to_kernel_old_timeval(p->signal->cstime);
 }
 
 static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index d86ebd0dcc3d..240f66663543 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,17 +1359,17 @@ static void fill_prstatus(struct elf_prstatus *prstatus,
 		 * group-wide total, not its individual thread total.
 		 */
 		thread_group_cputime(p, &cputime);
-		prstatus->pr_utime = ns_to_timeval(cputime.utime);
-		prstatus->pr_stime = ns_to_timeval(cputime.stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(cputime.utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(cputime.stime);
 	} else {
 		u64 utime, stime;
 
 		task_cputime(p, &utime, &stime);
-		prstatus->pr_utime = ns_to_timeval(utime);
-		prstatus->pr_stime = ns_to_timeval(stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(stime);
 	}
-	prstatus->pr_cutime = ns_to_timeval(p->signal->cutime);
-	prstatus->pr_cstime = ns_to_timeval(p->signal->cstime);
+	prstatus->pr_cutime = ns_to_kernel_old_timeval(p->signal->cutime);
+	prstatus->pr_cstime = ns_to_kernel_old_timeval(p->signal->cstime);
 
 	prstatus->pr_exec_fdpic_loadmap = p->mm->context.exec_fdpic_loadmap;
 	prstatus->pr_interp_fdpic_loadmap = p->mm->context.interp_fdpic_loadmap;
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index b7f9ffa1d5f1..aaad4ca1217e 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -48,8 +48,8 @@
 #define elf_prstatus	compat_elf_prstatus
 #define elf_prpsinfo	compat_elf_prpsinfo
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_old_timeval32
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_old_timeval32
 
 /*
  * To use this file, asm/elf.h must define compat_elf_check_arch.
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
index 0b2c9e16e345..baf03562306d 100644
--- a/include/uapi/linux/elfcore.h
+++ b/include/uapi/linux/elfcore.h
@@ -53,10 +53,10 @@ struct elf_prstatus
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct timeval pr_utime;	/* User time */
-	struct timeval pr_stime;	/* System time */
-	struct timeval pr_cutime;	/* Cumulative user time */
-	struct timeval pr_cstime;	/* Cumulative system time */
+	struct __kernel_old_timeval pr_utime;	/* User time */
+	struct __kernel_old_timeval pr_stime;	/* System time */
+	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
+	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
 #if 0
 	long	pr_instr;		/* Current instruction */
 #endif
-- 
2.20.0

