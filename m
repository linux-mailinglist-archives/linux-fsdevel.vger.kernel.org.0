Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874489F3F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfH0UVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 16:21:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbfH0UVX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:21:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BCD0B626;
        Tue, 27 Aug 2019 20:21:20 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] powerpc: move common register copy functions from signal_32.c to signal.c
Date:   Tue, 27 Aug 2019 22:21:07 +0200
Message-Id: <281030dd1e4d5a9650546a4beaf519eef3617de3.1566936688.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566936688.git.msuchanek@suse.de>
References: <cover.1566936688.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions are required for 64bit as well.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/signal.c    | 141 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c | 140 -------------------------------
 2 files changed, 141 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e6c30cee6abf..60436432399f 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -18,12 +18,153 @@
 #include <linux/syscalls.h>
 #include <asm/hw_breakpoint.h>
 #include <linux/uaccess.h>
+#include <asm/switch_to.h>
 #include <asm/unistd.h>
 #include <asm/debug.h>
 #include <asm/tm.h>
 
 #include "signal.h"
 
+#ifdef CONFIG_VSX
+unsigned long copy_fpr_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_FPR(i);
+	buf[i] = task->thread.fp_state.fpscr;
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_fpr_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_FPR(i) = buf[i];
+	task->thread.fp_state.fpscr = buf[i];
+
+	return 0;
+}
+
+unsigned long copy_vsx_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_vsx_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+unsigned long copy_ckfpr_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_CKFPR(i);
+	buf[i] = task->thread.ckfp_state.fpscr;
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_ckfpr_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_CKFPR(i) = buf[i];
+	task->thread.ckfp_state.fpscr = buf[i];
+
+	return 0;
+}
+
+unsigned long copy_ckvsx_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_ckvsx_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#else
+inline unsigned long copy_fpr_to_user(void __user *to,
+				      struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.fp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_fpr_from_user(struct task_struct *task,
+					void __user *from)
+{
+	return __copy_from_user(task->thread.fp_state.fpr, from,
+			      ELF_NFPREG * sizeof(double));
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+inline unsigned long copy_ckfpr_to_user(void __user *to,
+					 struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.ckfp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
+						 void __user *from)
+{
+	return __copy_from_user(task->thread.ckfp_state.fpr, from,
+				ELF_NFPREG * sizeof(double));
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#endif
+
 /* Log an error when sending an unhandled signal to a process. Controlled
  * through debug.exception-trace sysctl.
  */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 98600b276f76..c93c937ea568 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -235,146 +235,6 @@ struct rt_sigframe {
 	int			abigap[56];
 };
 
-#ifdef CONFIG_VSX
-unsigned long copy_fpr_to_user(void __user *to,
-			       struct task_struct *task)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		buf[i] = task->thread.TS_FPR(i);
-	buf[i] = task->thread.fp_state.fpscr;
-	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
-}
-
-unsigned long copy_fpr_from_user(struct task_struct *task,
-				 void __user *from)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		task->thread.TS_FPR(i) = buf[i];
-	task->thread.fp_state.fpscr = buf[i];
-
-	return 0;
-}
-
-unsigned long copy_vsx_to_user(void __user *to,
-			       struct task_struct *task)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < ELF_NVSRHALFREG; i++)
-		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
-}
-
-unsigned long copy_vsx_from_user(struct task_struct *task,
-				 void __user *from)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	return 0;
-}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-unsigned long copy_ckfpr_to_user(void __user *to,
-				  struct task_struct *task)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		buf[i] = task->thread.TS_CKFPR(i);
-	buf[i] = task->thread.ckfp_state.fpscr;
-	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
-}
-
-unsigned long copy_ckfpr_from_user(struct task_struct *task,
-					  void __user *from)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		task->thread.TS_CKFPR(i) = buf[i];
-	task->thread.ckfp_state.fpscr = buf[i];
-
-	return 0;
-}
-
-unsigned long copy_ckvsx_to_user(void __user *to,
-				  struct task_struct *task)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < ELF_NVSRHALFREG; i++)
-		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
-	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
-}
-
-unsigned long copy_ckvsx_from_user(struct task_struct *task,
-					  void __user *from)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	return 0;
-}
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-#else
-inline unsigned long copy_fpr_to_user(void __user *to,
-				      struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.fp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_fpr_from_user(struct task_struct *task,
-					void __user *from)
-{
-	return __copy_from_user(task->thread.fp_state.fpr, from,
-			      ELF_NFPREG * sizeof(double));
-}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-inline unsigned long copy_ckfpr_to_user(void __user *to,
-					 struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.ckfp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
-						 void __user *from)
-{
-	return __copy_from_user(task->thread.ckfp_state.fpr, from,
-				ELF_NFPREG * sizeof(double));
-}
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-#endif
-
 /*
  * Save the current user registers on the user stack.
  * We only save the altivec/spe registers if the process has used
-- 
2.22.0

