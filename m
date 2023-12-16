Return-Path: <linux-fsdevel+bounces-6289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76614815706
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20011F22379
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420D63BC;
	Sat, 16 Dec 2023 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIJ50rps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C46A7
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T038932wuCXACMWNvPFPITs/R+VZVZByTEI0/A5A1Vw=;
	b=JIJ50rpsZ9uBQHu6mf0+OX7hWyAU2OKOxh3pe82ZPLtO3xtyCSvUwTvxLYPWZ06u2p6gjg
	3B6hiQVH0q/IzecEJ/lXJr5jyu9gn1ur+9K8hANGj9s4B3Exs0aHhuasM4I0XYPP61AcWl
	peQqnrAdGbrXRWcdu9vReGmtVDWuBoY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 45/50] rseq: Split out rseq.h from sched.h
Date: Fri, 15 Dec 2023 22:35:46 -0500
Message-ID: <20231216033552.3553579-2-kent.overstreet@linux.dev>
In-Reply-To: <20231216033552.3553579-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We're trying to get sched.h down to more or less just types only, not
code - rseq can live in its own header.

This helps us kill the dependency on preempt.h in sched.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/kernel/signal.c         |   1 +
 fs/exec.c                        |   1 +
 include/linux/resume_user_mode.h |   1 +
 include/linux/rseq.h             | 131 +++++++++++++++++++++++++++++++
 include/linux/sched.h            | 125 +----------------------------
 kernel/fork.c                    |   1 +
 kernel/sched/core.c              |   1 +
 7 files changed, 137 insertions(+), 124 deletions(-)
 create mode 100644 include/linux/rseq.h

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 65fe2094da59..31b6f5dddfc2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -27,6 +27,7 @@
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
 #include <linux/syscalls.h>
+#include <linux/rseq.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
diff --git a/fs/exec.c b/fs/exec.c
index 4aa19b24f281..41773af7e3dc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -66,6 +66,7 @@
 #include <linux/coredump.h>
 #include <linux/time_namespace.h>
 #include <linux/user_events.h>
+#include <linux/rseq.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
index f8f3e958e9cf..e0135e0adae0 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/task_work.h>
 #include <linux/memcontrol.h>
+#include <linux/rseq.h>
 #include <linux/blk-cgroup.h>
 
 /**
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
new file mode 100644
index 000000000000..bc8af3eb5598
--- /dev/null
+++ b/include/linux/rseq.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _LINUX_RSEQ_H
+#define _LINUX_RSEQ_H
+
+#ifdef CONFIG_RSEQ
+
+#include <linux/preempt.h>
+#include <linux/sched.h>
+
+/*
+ * Map the event mask on the user-space ABI enum rseq_cs_flags
+ * for direct mask checks.
+ */
+enum rseq_event_mask_bits {
+	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
+	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
+	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
+};
+
+enum rseq_event_mask {
+	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
+	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
+	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
+};
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+	if (t->rseq)
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
+{
+	if (current->rseq)
+		__rseq_handle_notify_resume(ksig, regs);
+}
+
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
+{
+	preempt_disable();
+	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+	preempt_enable();
+	rseq_handle_notify_resume(ksig, regs);
+}
+
+/* rseq_preempt() requires preemption to be disabled. */
+static inline void rseq_preempt(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/* rseq_migrate() requires preemption to be disabled. */
+static inline void rseq_migrate(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/*
+ * If parent process has a registered restartable sequences area, the
+ * child inherits. Unregister rseq for a clone with CLONE_VM set.
+ */
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+{
+	if (clone_flags & CLONE_VM) {
+		t->rseq = NULL;
+		t->rseq_len = 0;
+		t->rseq_sig = 0;
+		t->rseq_event_mask = 0;
+	} else {
+		t->rseq = current->rseq;
+		t->rseq_len = current->rseq_len;
+		t->rseq_sig = current->rseq_sig;
+		t->rseq_event_mask = current->rseq_event_mask;
+	}
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	t->rseq = NULL;
+	t->rseq_len = 0;
+	t->rseq_sig = 0;
+	t->rseq_event_mask = 0;
+}
+
+#else
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+}
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
+{
+}
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
+{
+}
+static inline void rseq_preempt(struct task_struct *t)
+{
+}
+static inline void rseq_migrate(struct task_struct *t)
+{
+}
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+{
+}
+static inline void rseq_execve(struct task_struct *t)
+{
+}
+
+#endif
+
+#ifdef CONFIG_DEBUG_RSEQ
+
+void rseq_syscall(struct pt_regs *regs);
+
+#else
+
+static inline void rseq_syscall(struct pt_regs *regs)
+{
+}
+
+#endif
+
+#endif /* _LINUX_RSEQ_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec739277c39b..d528057c99e4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,7 +34,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
-#include <linux/rseq.h>
+#include <uapi/linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
@@ -2180,129 +2180,6 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_RSEQ
-
-/*
- * Map the event mask on the user-space ABI enum rseq_cs_flags
- * for direct mask checks.
- */
-enum rseq_event_mask_bits {
-	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
-	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
-	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
-};
-
-enum rseq_event_mask {
-	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
-	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
-	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
-};
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-	if (t->rseq)
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-}
-
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
-
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
-}
-
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
-	rseq_handle_notify_resume(ksig, regs);
-}
-
-/* rseq_preempt() requires preemption to be disabled. */
-static inline void rseq_preempt(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/* rseq_migrate() requires preemption to be disabled. */
-static inline void rseq_migrate(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/*
- * If parent process has a registered restartable sequences area, the
- * child inherits. Unregister rseq for a clone with CLONE_VM set.
- */
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
-{
-	if (clone_flags & CLONE_VM) {
-		t->rseq = NULL;
-		t->rseq_len = 0;
-		t->rseq_sig = 0;
-		t->rseq_event_mask = 0;
-	} else {
-		t->rseq = current->rseq;
-		t->rseq_len = current->rseq_len;
-		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_mask = current->rseq_event_mask;
-	}
-}
-
-static inline void rseq_execve(struct task_struct *t)
-{
-	t->rseq = NULL;
-	t->rseq_len = 0;
-	t->rseq_sig = 0;
-	t->rseq_event_mask = 0;
-}
-
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
-
-#endif
-
-#ifdef CONFIG_DEBUG_RSEQ
-
-void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
-
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/kernel/fork.c b/kernel/fork.c
index 319e61297bfb..53816393995b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -100,6 +100,7 @@
 #include <linux/stackprotector.h>
 #include <linux/user_events.h>
 #include <linux/iommu.h>
+#include <linux/rseq.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..d04cf3c47899 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -57,6 +57,7 @@
 #include <linux/profile.h>
 #include <linux/psi.h>
 #include <linux/rcuwait_api.h>
+#include <linux/rseq.h>
 #include <linux/sched/wake_q.h>
 #include <linux/scs.h>
 #include <linux/slab.h>
-- 
2.43.0


