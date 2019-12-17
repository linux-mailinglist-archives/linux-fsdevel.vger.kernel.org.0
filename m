Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86884123945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLQWRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:59431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLQWRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:45 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYeZB-1iClIj1FHX-00VjN7; Tue, 17 Dec 2019 23:17:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 07/27] compat: provide compat_ptr() on all architectures
Date:   Tue, 17 Dec 2019 23:16:48 +0100
Message-Id: <20191217221708.3730997-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JQSrPBZB1v54Yak8eCxwsTN2osR5c2EDNvd2k/ZMRPAcktmSN0p
 0fdwV7ZLRKeFe22G22lsYhOVb7fG8iMrKpNMhA31Ai70EsIcBqiwRSIRz0TaOov3uJNwpM8
 E7OhyP/EXJFunAt6QnSJpCwKkqFNH7+wrY2aODNXbKUqkd+b5BPWLaLHXbThNqv5JMiq4NG
 Im68FZLXOCLcTEu9dIi/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SU+7KpO9Vlo=:IymVgWc94KXwaMyZQlHkxU
 BOOd8tlE2cnTW2MvLxOion+33s57k6FjyPd7rKinV0H3dz+KmdD/evvVKhnUMABxn+b00xCuu
 o/npD4lIIJI4P/kYPC43N0VqKYay/3o1lR6k8gVP4B8BsCGE34HJUOeqMDPvGw2aXU+HaPgVY
 EZ9F+sG1CluLGd5DLGKDpqEQ9kseqCkQHkxHP4ZoqbTuM+25Im3fouqTeqYgQeNs690gOTXHH
 x0fnsDxJcFxMpsmhSVWfDw4ONU77MlG692O1y4OjYs2Tvp5a68CsW9vftGnhm94l4dEL/l5bT
 EWeKpphlgJgYsHcM3bHOXp9MSEc8GyeREGfPcFiGVvXuVAaO7tLlqxTirbh/c/JoLcf7l9yER
 l7mqFc9qjeWIk5nHLsHKQEBGYTdliY6ouRe5YNNel4VuiNqz9mBhvb42Q5n+PdnPyXgK8w+/h
 8S8bzNO9XoOQSGFzDaz9DvBmFMft5VI/Cc0QkPIZOxB8iSDr+NYsfEzkOR2Y97RlTBNpyw0vU
 iMP3UoVKuxRkIB+2D7XTPvcDh1WJGvjg3yT3UZNaSW86f4seyz0vd0sGVDLNEInJgRadp8VeG
 YGx4A8+q4/WdWRn9lL06Kami1FMJda5mm350WsvKTFT8Xm3yHDpVh9mKA7k3lF0ZQfaAh76qs
 PS5g5Rd7T75Z8i5NmvHEKkS8q7PMBzsvMicAg4x7rxxsH7/KDB5sn/7kOuMV1Wpc/6wMgg0xE
 vm5TLPMfcGfm8wnQ76w09fCVRt6AFS9lsNRTynMX8kM6yTvIOJmiE4h8qXpAFCbKAJCLs/wXg
 q/KyMKqUtjSx/JJ4+dp90OW3lcafIOkTUavcY+uXgYS9XKscy11asz0jREQHu5j2AowzaVJav
 4WLifMKTsbfDkjC9gOMQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to avoid needless #ifdef CONFIG_COMPAT checks,
move the compat_ptr() definition to linux/compat.h
where it can be seen by any file regardless of the
architecture.

Only s390 needs a special definition, this can use the
self-#define trick we have elsewhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h   | 17 -----------------
 arch/mips/include/asm/compat.h    | 18 ------------------
 arch/parisc/include/asm/compat.h  | 17 -----------------
 arch/powerpc/include/asm/compat.h | 17 -----------------
 arch/powerpc/oprofile/backtrace.c |  2 +-
 arch/s390/include/asm/compat.h    |  6 +-----
 arch/sparc/include/asm/compat.h   | 17 -----------------
 arch/x86/include/asm/compat.h     | 17 -----------------
 include/linux/compat.h            | 18 ++++++++++++++++++
 9 files changed, 20 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 7b4172ce497c..935d2aa231bf 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -114,23 +114,6 @@ typedef u32		compat_sigset_word;
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	return (void __user *)(unsigned long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
 #define COMPAT_MINSIGSTKSZ	2048
 
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index c99166eadbde..255afcdd79c9 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -100,24 +100,6 @@ typedef u32		compat_sigset_word;
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	/* cast to a __user pointer via "unsigned long" makes sparse happy */
-	return (void __user *)(unsigned long)(long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = (struct pt_regs *)
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index e03e3c849f40..2f4f66a3bac0 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -173,23 +173,6 @@ struct compat_shmid64_ds {
 #define COMPAT_ELF_NGREG 80
 typedef compat_ulong_t compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	return (void __user *)(unsigned long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 static __inline__ void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = &current->thread.regs;
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 74d0db511099..3e3cdfaa76c6 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -96,23 +96,6 @@ typedef u32		compat_sigset_word;
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	return (void __user *)(unsigned long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current->thread.regs;
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index 43245f4a9bcb..6ffcb80cf844 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -9,7 +9,7 @@
 #include <linux/sched.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
-#include <asm/compat.h>
+#include <linux/compat.h>
 #include <asm/oprofile_impl.h>
 
 #define STACK_SP(STACK)		*(STACK)
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 63b46e30b2c3..9547cd5d6cdc 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -177,11 +177,7 @@ static inline void __user *compat_ptr(compat_uptr_t uptr)
 {
 	return (void __user *)(unsigned long)(uptr & 0x7fffffffUL);
 }
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
+#define compat_ptr(uptr) compat_ptr(uptr)
 
 #ifdef CONFIG_COMPAT
 
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 30b1763580b1..40a267b3bd52 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -125,23 +125,6 @@ typedef u32		compat_sigset_word;
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	return (void __user *)(unsigned long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 #ifdef CONFIG_COMPAT
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 22c4dfe65992..52e9f3480f69 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -177,23 +177,6 @@ typedef struct user_regs_struct compat_elf_gregset_t;
 	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
 #endif
 
-/*
- * A pointer passed in from user mode. This should not
- * be used for syscall parameters, just declare them
- * as pointers because the syscall entry code will have
- * appropriately converted them already.
- */
-
-static inline void __user *compat_ptr(compat_uptr_t uptr)
-{
-	return (void __user *)(unsigned long)uptr;
-}
-
-static inline compat_uptr_t ptr_to_compat(void __user *uptr)
-{
-	return (u32)(unsigned long)uptr;
-}
-
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	compat_uptr_t sp;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 68f79d855c3d..11083d84eb23 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -958,4 +958,22 @@ static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately converted them already.
+ */
+#ifndef compat_ptr
+static inline void __user *compat_ptr(compat_uptr_t uptr)
+{
+	return (void __user *)(unsigned long)uptr;
+}
+#endif
+
+static inline compat_uptr_t ptr_to_compat(void __user *uptr)
+{
+	return (u32)(unsigned long)uptr;
+}
+
 #endif /* _LINUX_COMPAT_H */
-- 
2.20.0

