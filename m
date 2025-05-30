Return-Path: <linux-fsdevel+bounces-50186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487ACAC8B05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4653D1889FB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044722D4E2;
	Fri, 30 May 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U7jWFD62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE222A81F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597632; cv=none; b=Sg/wmsJtCDBDYm6P+XddRWUXI41zZfiT7kQbhaOKCXqhX3sgfk4L63GOOGmZvr2uNjYc+J9PbvJe8ynyq8cg8F8m0cSz3ggoa3+MPUaaEi3DtmIyQuU+/v7JJBUmSWmQsw4LwBwkoJGDMhljZxwhIkEKL6yDko7JCZ5I/4+Spok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597632; c=relaxed/simple;
	bh=s8bvP/o1nUrwW7KF0DJ/pHvc3b43enUVUs73szJcvsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiVr5QKQDimoOPKqjeKaO1sRME6qUTVVgl5MhGrHYGtspNu53feOQqNtcpcZO5W6PnJsXJjQeVKW/jYF+LSKVIGH2PCKYqLKNv6UE/fmLXxf1ldygwu2VpF7SuAI5TtFeYgTwS9KunUyMxlyjEA6Eu1J7zi4b2QpxQ/gIkT49GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U7jWFD62; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23508d30142so18602825ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597629; x=1749202429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2NFrx3BFqUZITaGnYPssFKiBOpe/dz6IJRWesRURms=;
        b=U7jWFD62nxS8TfhhmrTlMIbWjZGLXbkA3Q1GVDdMyhiibiNlV0l5YWrgI+JavnBPpb
         Gxq6GuT3tq2RN7mnaF9YyNih9RiSM57U7umDgRMf9gzCA7z4SZVNodtbn4WIDsRDWvcb
         BDTiIIyLlwNpb72o/C/BqOfI6mMv++FKB0YtlMAqTK7QUP77Ct2MzDCe56gVPo2RnuIa
         ybkovV0jXidA3NGQGQtlHGZDDaLJjNDCp8qJlsHjNJN6dALtCaW3w29v1/hm4x3Bs6B1
         T6boHJn4kXyByPOr22bDDLKGgZ4JH8Z/S43M/bOkjz2DaPNk11bLJojgqn7XecTnHmd1
         803g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597629; x=1749202429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2NFrx3BFqUZITaGnYPssFKiBOpe/dz6IJRWesRURms=;
        b=Rfc0zkIOmsTMUlyL9gdFiIt1uxeDKHN2wQpK7S8DTr31qQ1XaoM04PB9eFzD+Wjc3o
         lcKYG0XiSV7pY3sdggcCfhqgg5HTc+OziVSHwcqZc2iFxcsnN7AH6uNlEkhzsWNyDRlI
         vdQO4oWZG17cSYCvtX1sh46/x8W8re8+L8rztlhMtH3EamY/o/Yg5XKQXcCPrxUrbxqC
         9kHJJaIPwb3XL09YfMH/nVVObFlTosfAu1ZlCWuRlLY6DdPBUbnpodjhxilKDPrntsQ3
         30D2cvScqW9k8adBRojVON8tcZugmoGsk4AMDaTkzXPFAwVXjHgx4g4aij22je5sU6b+
         Bruw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJXk6mxFq5u1MbDx+KnZZzf9+JP9FfzofNj2OOSDSd99wabTxM1C4e6kHv448jLR5h58DCG6qom+Jx3vX@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEc6XHgRVJBzgCZ2AZPRgu+Olv6sWk4vQg9Wy39X5kMz3UtzJ
	6NLhPK5T1krLa3Phj/0aJjnQfKAsGmHL6iXCrTYA6uJDlO9ZYco2uU9NP0x3y9mn3kI=
X-Gm-Gg: ASbGnctw2Ih0glyPJsEXa42vetK8tk4p1HxS0m/r38VQ0QAmwtqhBuldmOkdxi2Bbuc
	16aXyTR9F5RHMAffVwvDu6iJpQNFHoI3AZmRdOmcnm4dre94U+jWCIBm/jQvZuRvCtEux39x5By
	IgDUAs9205coDm8u6HSiQ5yaCk9HHRnbemet6loL91ml19zhwGzyfx3+gKh+NzfDxyn8zkkm09O
	dnSHOrunhJGZRK/SWF+/yQjUWGQq8cY4wpjJ5LFvKDTJsqj1h/wflSeaTokGb9CsDH3iWkDsaTk
	dRSoiyC/g55pcI+PyrwIB513DDLdsHFBBcmy8zyd4h2Hsyj1m5LuJ98a2g/C4fV3Bs/jXQPlauv
	JJnCqXZ0YaA==
X-Google-Smtp-Source: AGHT+IHkejFlF7JacpAFc31d67Aa0abDbDTBPS+AvGZCJTX8xpAHAqZtwkMExSrIMlmiA7Dd0bS1gw==
X-Received: by 2002:a17:90b:3ec3:b0:310:cea4:e3b9 with SMTP id 98e67ed59e1d1-31250452c5fmr1772636a91.34.1748597629413;
        Fri, 30 May 2025 02:33:49 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.33.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:33:49 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 21/35] RPAL: add kernel entry handling for lazy switch
Date: Fri, 30 May 2025 17:27:49 +0800
Message-Id: <924aa7959502c4c3271cb311632eb505e894e26e.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the kernel entry point, RPAL performs a lazy switch. Therefore, it is
necessary to hook all kernel entry points to execute the logic related to
the lazy switch. At the kernel entry, apart from some necessary operations
related to the lazy switch (such as ensuring that the general-purpose
registers remain unchanged before and after the lazy switch), the task
before the lazy switch will lose its user mode context (which is passed to
the task after the lazy switch). Therefore, the kernel entry also needs to
handle the issue of the previous task losing its user mode context.

This patch hooks all locations where the transition from user mode to
kernel mode occurs, including entry_SYSCALL_64, error_entry, and
asm_exc_nmi. When the kernel detects a mismatch between the kernel-mode and
user mode contexts, it executes the logic related to the lazy switch.
Taking the switch from the sender to the receiver as an example, the
receiver thread is first locked to the CPU where the sender is located.
Then, the receiver thread in the CALL state is woken up through
rpal_try_to_wake_up(). The general purpose register state (pt_regs) of the
sender is copied to the receiver, and rpal_schedule() is executed to
complete the lazy switch. Regarding the issue of the sender losing its
context, the kernel loads the pre-saved user mode context of the sender
into the sender's pt_regs and constructs the kernel stack frame of the
sender in a manner similar to the fork operation.

The handling of the switch from the receiver to the sender is similar,
except that the receiver will be unlocked from the current CPU, and the
receiver can only return to the user mode through the kernel return method.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/entry/entry_64.S     | 137 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/asm-offsets.c |   3 +
 arch/x86/rpal/core.c          | 137 ++++++++++++++++++++++++++++++++++
 include/linux/rpal.h          |   6 ++
 4 files changed, 283 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 13b4d0684575..59c38627510d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -118,6 +118,20 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	UNTRAIN_RET
 	CLEAR_BRANCH_HISTORY
 
+#ifdef CONFIG_RPAL
+	/*
+	 * We first check if it is a RPAL sender/receiver with
+	 * current->rpal_cd. For non-RPAL task, we just skip it.
+	 * For rpal task, We may need to check if it needs to do
+	 * lazy switch.
+	 */
+	movq	PER_CPU_VAR(current_task), %r13
+	movq	TASK_rpal_cd(%r13), %rax
+	testq	%rax, %rax
+	jz		_do_syscall
+	jmp 	do_rpal_syscall
+_do_syscall:
+#endif
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
@@ -190,6 +204,101 @@ SYM_CODE_START(rpal_ret_from_lazy_switch)
 	jmp	swapgs_restore_regs_and_return_to_usermode
 #endif
 SYM_CODE_END(rpal_ret_from_lazy_switch)
+
+/* return address offset of stack frame */
+#define RPAL_FRAME_RET_ADDR_OFFSET -56
+
+SYM_CODE_START(do_rpal_syscall)
+	movq	%rsp, %r14
+	call	rpal_syscall_64_context_switch
+	testq   %rax, %rax
+	jz		1f
+
+	/*
+	 * When we come here, everything but stack switching is finished.
+	 * This makes current task use another task's kernel stack. Thus,
+	 * we need to do stack switching here.
+	 *
+	 * At the meanwhile, the previous task's stack content is corrupted,
+	 * we also need to rebuild its stack frames, so that it will jump to
+	 * rpal_ret_from_lazy_switch when it is scheduled in. This is inspired
+	 * by ret_from_fork.
+	 */
+	movq    TASK_threadsp(%rax), %rsp
+#ifdef CONFIG_STACKPROTECTOR
+	movq	TASK_stack_canary(%rax), %rbx
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
+#endif
+	/* rebuild src's frame */
+	movq	$rpal_ret_from_lazy_switch, -8(%r14)
+	leaq	RPAL_FRAME_RET_ADDR_OFFSET(%r14), %rbx
+	movq	%rbx, TASK_threadsp(%r13)
+
+	movq	%r13, %rdi
+	/*
+	 * Everything of task switch is done, but we still need to do
+	 * a little extra things for lazy switch.
+	 */
+	call	rpal_lazy_switch_tail
+
+1:
+	movq	ORIG_RAX(%rsp), %rsi
+	movq	%rsp, %rdi
+	jmp		_do_syscall
+SYM_CODE_END(do_rpal_syscall)
+
+SYM_CODE_START(do_rpal_error)
+	popq	%r12
+	movq	%rax, %rsp
+	movq	%rax, %r14
+	movq	%rax, %rdi
+	call	rpal_exception_context_switch
+	testq   %rax, %rax
+	jz		1f
+
+	movq	TASK_threadsp(%rax), %rsp
+	ENCODE_FRAME_POINTER
+#ifdef CONFIG_STACKPROTECTOR
+	movq	TASK_stack_canary(%rax), %rbx
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
+#endif
+	/* rebuild src's frame */
+	movq	$rpal_ret_from_lazy_switch, -8(%r14)
+	leaq	RPAL_FRAME_RET_ADDR_OFFSET(%r14), %rbx
+	movq	%rbx, TASK_threadsp(%r13)
+
+	movq	%r13, %rdi
+	call	rpal_lazy_switch_tail
+1:
+	movq	%rsp, %rax
+	pushq	%r12
+	jmp		_do_error
+SYM_CODE_END(do_rpal_error)
+
+SYM_CODE_START(do_rpal_nmi)
+	movq	%rsp, %r14
+	movq	%rsp, %rdi
+	call	rpal_nmi_context_switch
+	testq   %rax, %rax
+	jz		1f
+
+	movq    TASK_threadsp(%rax), %rsp
+	ENCODE_FRAME_POINTER
+#ifdef CONFIG_STACKPROTECTOR
+	movq	TASK_stack_canary(%rax), %rbx
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
+#endif
+	/* rebuild src's frame */
+	movq	$rpal_ret_from_lazy_switch, -8(%r14)
+	leaq	RPAL_FRAME_RET_ADDR_OFFSET(%r14), %rbx
+	movq	%rbx, TASK_threadsp(%r13)
+
+	movq	%r13, %rdi
+	call	rpal_lazy_switch_tail
+
+1:
+	jmp		_do_nmi
+SYM_CODE_END(do_rpal_nmi)
 #endif
 
 /*
@@ -1047,7 +1156,22 @@ SYM_CODE_START(error_entry)
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	/* Put us onto the real thread stack. */
+#ifdef CONFIG_RPAL
+	call sync_regs
+	/*
+	 * Check whether we need to perform lazy switch after we
+	 * switch to the real thread stack.
+	 */
+	movq	PER_CPU_VAR(current_task), %r13
+	movq	TASK_rpal_cd(%r13), %rdi
+	testq	%rdi, %rdi
+	jz		_do_error
+	jmp 	do_rpal_error
+_do_error:
+	RET
+#else
 	jmp	sync_regs
+#endif
 
 	/*
 	 * There are two places in the kernel that can potentially fault with
@@ -1206,6 +1330,19 @@ SYM_CODE_START(asm_exc_nmi)
 	IBRS_ENTER
 	UNTRAIN_RET
 
+#ifdef CONFIG_RPAL
+	/*
+	 * Check whether we need to perform lazy switch only when
+	 * we come from userspace.
+	 */
+	movq	PER_CPU_VAR(current_task), %r13
+	movq	TASK_rpal_cd(%r13), %rax
+	testq	%rax, %rax
+	jz		_do_nmi
+	jmp 	do_rpal_nmi
+_do_nmi:
+#endif
+
 	/*
 	 * At this point we no longer need to worry about stack damage
 	 * due to nesting -- we're on the normal thread stack and we're
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6259b474073b..010202c31b37 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -46,6 +46,9 @@ static void __used common(void)
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TASK_stack_canary, task_struct, stack_canary);
 #endif
+#ifdef CONFIG_RPAL
+	OFFSET(TASK_rpal_cd, task_struct, rpal_cd);
+#endif
 
 	BLANK();
 	OFFSET(pbe_address, pbe, address);
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index ed4c11e6838c..c48df1ce4324 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/rpal.h>
+#include <linux/sched/task_stack.h>
 #include <asm/fsgsbase.h>
 
 #include "internal.h"
@@ -39,6 +40,20 @@ static inline void rpal_unlock_cpu_kernel_ret(struct task_struct *tsk)
 	rpal_set_cpus_allowed_ptr(tsk, false, true);
 }
 
+void rpal_lazy_switch_tail(struct task_struct *tsk)
+{
+	struct rpal_receiver_call_context *rcc;
+
+	if (rpal_test_task_thread_flag(current, RPAL_LAZY_SWITCHED_BIT)) {
+		rcc = current->rpal_rd->rcc;
+		atomic_cmpxchg(&rcc->receiver_state, rpal_build_call_state(tsk->rpal_sd),
+			       RPAL_RECEIVER_STATE_LAZY_SWITCH);
+	} else {
+		rpal_unlock_cpu(tsk);
+		rpal_unlock_cpu(current);
+	}
+}
+
 void rpal_kernel_ret(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
@@ -76,6 +91,87 @@ void rpal_kernel_ret(struct pt_regs *regs)
 	}
 }
 
+static inline void rebuild_stack(struct rpal_task_context *ctx,
+				 struct pt_regs *regs)
+{
+	regs->r12 = ctx->r12;
+	regs->r13 = ctx->r13;
+	regs->r14 = ctx->r14;
+	regs->r15 = ctx->r15;
+	regs->bx = ctx->rbx;
+	regs->bp = ctx->rbp;
+	regs->ip = ctx->rip;
+	regs->sp = ctx->rsp;
+}
+
+static inline void rebuild_sender_stack(struct rpal_sender_data *rsd,
+				 struct pt_regs *regs)
+{
+	rebuild_stack(&rsd->scc->rtc, regs);
+}
+
+static inline void rebuild_receiver_stack(struct rpal_receiver_data *rrd,
+				   struct pt_regs *regs)
+{
+	rebuild_stack(&rrd->rcc->rtc, regs);
+}
+
+static inline void update_dst_stack(struct task_struct *next,
+				    struct pt_regs *src)
+{
+	struct pt_regs *dst;
+
+	dst = task_pt_regs(next);
+	*dst = *src;
+	next->thread.sp = (unsigned long)dst;
+}
+
+/*
+ * rpal_do_kernel_context_switch - the main routine of RPAL lazy switch
+ * @next: task to switch to
+ * @regs: the user pt_regs saved in kernel entry
+ *
+ * This function performs the lazy switch. When switch from sender to
+ * receiver, we need to lock both task to current CPU to avoid double
+ * control flow when we perform lazy switch and after then.
+ */
+static struct task_struct *
+rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
+{
+	struct task_struct *prev = current;
+
+	if (rpal_test_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT)) {
+		current->rpal_sd->receiver = next;
+		rpal_lock_cpu(current);
+		rpal_lock_cpu(next);
+		rpal_try_to_wake_up(next);
+		update_dst_stack(next, regs);
+		/*
+		 * When a lazy switch occurs, we need to set the sender's
+		 * user-mode context to a predefined state by the sender.
+		 * Otherwise, sender's user context will be corrupted.
+		 */
+		rebuild_sender_stack(current->rpal_sd, regs);
+		rpal_schedule(next);
+	} else {
+		update_dst_stack(next, regs);
+		/*
+		 * When a lazy switch occurs, we need to set the receiver's
+		 * user-mode context to a predefined state by the receiver.
+		 * Otherwise, sender's user context will be corrupted.
+		 */
+		rebuild_receiver_stack(current->rpal_rd, regs);
+		rpal_schedule(next);
+		rpal_clear_task_thread_flag(prev, RPAL_LAZY_SWITCHED_BIT);
+		prev->rpal_rd->sender = NULL;
+	}
+	if (unlikely(!irqs_disabled())) {
+		local_irq_disable();
+		rpal_err("%s: irq is enabled\n", __func__);
+	}
+	return next;
+}
+
 static inline struct task_struct *rpal_get_sender_task(void)
 {
 	struct task_struct *next;
@@ -123,6 +219,18 @@ static inline struct task_struct *rpal_misidentify(void)
 	return next;
 }
 
+static inline struct task_struct *
+rpal_kernel_context_switch(struct pt_regs *regs)
+{
+	struct task_struct *next = NULL;
+
+	next = rpal_misidentify();
+	if (unlikely(next != NULL))
+		next = rpal_do_kernel_context_switch(next, regs);
+
+	return next;
+}
+
 struct task_struct *rpal_find_next_task(unsigned long fsbase)
 {
 	struct rpal_service *cur = rpal_current_service();
@@ -147,6 +255,35 @@ struct task_struct *rpal_find_next_task(unsigned long fsbase)
 	return tsk;
 }
 
+__visible struct task_struct *
+rpal_syscall_64_context_switch(struct pt_regs *regs, unsigned long nr)
+{
+	struct task_struct *next;
+
+	next = rpal_kernel_context_switch(regs);
+
+	return next;
+}
+
+__visible struct task_struct *
+rpal_exception_context_switch(struct pt_regs *regs)
+{
+	struct task_struct *next;
+
+	next = rpal_kernel_context_switch(regs);
+
+	return next;
+}
+
+__visible struct task_struct *rpal_nmi_context_switch(struct pt_regs *regs)
+{
+	struct task_struct *next;
+
+	next = rpal_kernel_context_switch(regs);
+
+	return next;
+}
+
 static bool check_hardware_features(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_FSGSBASE)) {
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 01b582fa821e..b24176f3f245 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -479,7 +479,13 @@ struct rpal_service *rpal_get_mapped_service_by_id(struct rpal_service *rs,
 int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 					 unsigned long addr, int error_code);
 struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild);
+__visible struct task_struct *
+rpal_syscall_64_context_switch(struct pt_regs *regs, unsigned long nr);
+__visible struct task_struct *
+rpal_exception_context_switch(struct pt_regs *regs);
+__visible struct task_struct *rpal_nmi_context_switch(struct pt_regs *regs);
 struct task_struct *rpal_find_next_task(unsigned long fsbase);
+void rpal_lazy_switch_tail(struct task_struct *tsk);
 void rpal_kernel_ret(struct pt_regs *regs);
 
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
-- 
2.20.1


