Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF5254843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgH0PBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgH0PAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:00:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A56C061239;
        Thu, 27 Aug 2020 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9L27YQ1TPyefQxTRY5L3HB3ezDjb1XN91QeXJxbd6ZI=; b=f8lIoJuKQotvfkFzBil2G7U/19
        R1QYHo+Y6/3sLKgfHXqPHytc1QNPQgmwYxPbk/LAOgRYqDhmzvD+So+xOYAyudYPsRvr7Q1wqvT2C
        VhTsyJGaJ2TzvOCQu/dcF8ISG/rYe3X/k174M8iR5BkktY5dz42zc3AUnuMmD+PwY3JFhvi3oBAta
        9PWnxwTkOP32j3hjBi0nmCwBL0uH8ks0NajtNndAd3TGj3dNQgtWEIkMhJa2dKHfv4oPNmU65XYUo
        II3IzN9ya++Dntv9sFpGvt6B4Yjv/BmaJnVmUI7s5Z6VsFFXGFrWaAHKfbsgr2Fn3M9LLtUvYggF/
        Awphnz3g==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJOQ-00046E-7N; Thu, 27 Aug 2020 15:00:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/10] powerpc: remove address space overrides using set_fs()
Date:   Thu, 27 Aug 2020 17:00:30 +0200
Message-Id: <20200827150030.282762-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827150030.282762-1-hch@lst.de>
References: <20200827150030.282762-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop providing the possibility to override the address space using
set_fs() now that there is no need for that any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig                   |  1 -
 arch/powerpc/include/asm/processor.h   |  7 ---
 arch/powerpc/include/asm/thread_info.h |  5 +--
 arch/powerpc/include/asm/uaccess.h     | 62 ++++++++------------------
 arch/powerpc/kernel/signal.c           |  3 --
 arch/powerpc/lib/sstep.c               |  6 +--
 6 files changed, 22 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3f09d6fdf89405..1f48bbfb3ce99d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -249,7 +249,6 @@ config PPC
 	select PCI_SYSCALL			if PCI
 	select PPC_DAWR				if PPC64
 	select RTC_LIB
-	select SET_FS
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ed0d633ab5aa42..f01e4d650c520a 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -83,10 +83,6 @@ struct task_struct;
 void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
 void release_thread(struct task_struct *);
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 #define TS_FPR(i) fp_state.fpr[i][TS_FPROFFSET]
 #define TS_CKFPR(i) ckfp_state.fpr[i][TS_FPROFFSET]
 
@@ -148,7 +144,6 @@ struct thread_struct {
 	unsigned long	ksp_vsid;
 #endif
 	struct pt_regs	*regs;		/* Pointer to saved register state */
-	mm_segment_t	addr_limit;	/* for get_fs() validation */
 #ifdef CONFIG_BOOKE
 	/* BookE base exception scratch space; align on cacheline */
 	unsigned long	normsave[8] ____cacheline_aligned;
@@ -295,7 +290,6 @@ struct thread_struct {
 #define INIT_THREAD { \
 	.ksp = INIT_SP, \
 	.ksp_limit = INIT_SP_LIMIT, \
-	.addr_limit = KERNEL_DS, \
 	.pgdir = swapper_pg_dir, \
 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
 	SPEFSCR_INIT \
@@ -303,7 +297,6 @@ struct thread_struct {
 #else
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
-	.addr_limit = KERNEL_DS, \
 	.fpexc_mode = 0, \
 }
 #endif
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ca6c9702570494..46a210b03d2b80 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -90,7 +90,6 @@ void arch_setup_new_exec(void);
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
 #define TIF_SYSCALL_EMU		4	/* syscall emulation active */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
@@ -130,7 +129,6 @@ void arch_setup_new_exec(void);
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_FSCHECK		(1<<TIF_FSCHECK)
 #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
@@ -138,8 +136,7 @@ void arch_setup_new_exec(void);
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
-				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_FSCHECK)
+				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 7fe3531ad36a77..39727537d39701 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -8,62 +8,36 @@
 #include <asm/extable.h>
 #include <asm/kup.h>
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- *
- * The fs/ds values are now the highest legal address in the "segment".
- * This simplifies the checking in the routines below.
- */
-
-#define MAKE_MM_SEG(s)  ((mm_segment_t) { (s) })
-
-#define KERNEL_DS	MAKE_MM_SEG(~0UL)
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE_USER64 - 1)
-#else
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE - 1)
-#endif
-
-#define get_fs()	(current->thread.addr_limit)
+#define TASK_SIZE_MAX		TASK_SIZE_USER64
 
-static inline void set_fs(mm_segment_t fs)
+static inline bool __access_ok(unsigned long addr, unsigned long size)
 {
-	current->thread.addr_limit = fs;
-	/* On user-mode return check addr_limit (fs) is correct */
-	set_thread_flag(TIF_FSCHECK);
+	if (addr >= TASK_SIZE_MAX)
+		return false;
+	/*
+	 * This check is sufficient because there is a large enough gap between
+	 * user addresses and the kernel addresses.
+	 */
+	return size <= TASK_SIZE_MAX;
 }
-
-#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
-#define user_addr_max()	(get_fs().seg)
-
-#ifdef __powerpc64__
-/*
- * This check is sufficient because there is a large enough
- * gap between user addresses and the kernel addresses
- */
-#define __access_ok(addr, size, segment)	\
-	(((addr) <= (segment).seg) && ((size) <= (segment).seg))
-
 #else
+#define TASK_SIZE_MAX		TASK_SIZE
 
-static inline int __access_ok(unsigned long addr, unsigned long size,
-			mm_segment_t seg)
+static inline bool __access_ok(unsigned long addr, unsigned long size)
 {
-	if (addr > seg.seg)
-		return 0;
-	return (size == 0 || size - 1 <= seg.seg - addr);
+	if (addr >= TASK_SIZE_MAX)
+		return false;
+	if (size == 0)
+		return false;
+	return size <= TASK_SIZE_MAX - addr;
 }
-
-#endif
+#endif /* __powerpc64__ */
 
 #define access_ok(addr, size)		\
 	(__chk_user_ptr(addr),		\
-	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
+	 __access_ok((unsigned long)(addr), (size)))
 
 /*
  * These are the main single-value transfer routines.  They automatically
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index d15a98c758b8b4..df547d8e31e49c 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -312,9 +312,6 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 {
 	user_exit();
 
-	/* Check valid addr_limit, TIF check is done there */
-	addr_limit_user_check();
-
 	if (thread_info_flags & _TIF_UPROBE)
 		uprobe_notify_resume(regs);
 
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index caee8cc77e1954..8342188ea1acd0 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -108,11 +108,11 @@ static nokprobe_inline long address_ok(struct pt_regs *regs,
 {
 	if (!user_mode(regs))
 		return 1;
-	if (__access_ok(ea, nb, USER_DS))
+	if (__access_ok(ea, nb))
 		return 1;
-	if (__access_ok(ea, 1, USER_DS))
+	if (__access_ok(ea, 1))
 		/* Access overlaps the end of the user region */
-		regs->dar = USER_DS.seg;
+		regs->dar = TASK_SIZE_MAX - 1;
 	else
 		regs->dar = ea;
 	return 0;
-- 
2.28.0

