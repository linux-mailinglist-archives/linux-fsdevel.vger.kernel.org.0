Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC47018B335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 13:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCSMTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 08:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSMTq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:19:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A898B1F6;
        Thu, 19 Mar 2020 12:19:43 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v11 2/8] powerpc: move common register copy functions from signal_32.c to signal.c
Date:   Thu, 19 Mar 2020 13:19:30 +0100
Message-Id: <52d53402f3f72114dde86654ad048dadac5d7cb0.1584620202.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1584620202.git.msuchanek@suse.de>
References: <20200225173541.1549955-1-npiggin@gmail.com> <cover.1584620202.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions are required for 64bit as well.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/signal.c    | 141 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c | 140 -------------------------------
 2 files changed, 141 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index d215f9554553..4b0152108f61 100644
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
index 1b090a76b444..4f96d29a22bf 100644
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
2.23.0

