Return-Path: <linux-fsdevel+bounces-50180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82223AC8AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19873AFAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9432248A6;
	Fri, 30 May 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TkX8S0ml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2ED224225
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597539; cv=none; b=vEON6Cdl+8ucFR09nAWCbd/hdhyLfwfownix4lpSDJOS6aEuadVOcHS16N6D6f8FF5gBBUzjOMdh85dMB3CVBuXZloh4VBkkogYPnZF3nuN6uryYwGPpRw6mtreEMlWEHO24nqGRbHRpNVxQhRPmi5vjskrEDvm3lj7hFntR5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597539; c=relaxed/simple;
	bh=Vo5W68+B44KDyLABkBRZQtt4MP6EbodSR8b0dyMCe9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHd8sfS7quk3L1P9o2/5z6dqGgekkBUQQvFjyvt7rreiMz/cmadxIzZQ4Hj8IJSV4rySMpEB0GC5s/yUMN8hu5EXNxYWc6CEz1vhg6/bSOcHB3sWsj2dD8JTRjlifV/LLDg5WW2nE+JwU626wfdGkrhgMItXyjM1iTIkl5gOiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TkX8S0ml; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1315673a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597537; x=1749202337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgdxFQILtv1ZFBwGDlokBNLY9DZwyLg+1V8wfJcAxqs=;
        b=TkX8S0mlzQALs9Xd5nJpstems/lEQiViliadNUqZ4Vy8VoDCAE5kciPed4kmjZLKad
         n8hB45Jt3bYVFXCyFT5oyZz4lK1WLpSj5Fc4MxtiO2L4EGIFb8jmcYRiccXd2tLquT7B
         BRHHWEKNw6hlh2CQoq2nyx+qZm+F00Y9/x74H99SsxNixZDyvF13Fhp+iLENW8YOIwKO
         Ki8SkEP9Qe9OTkoCcdoZKTBKAAzCdYnz06HFG8XOP7N+0ymzkVd9OGk3pnex18I7Vq9Y
         TyxCukQA/nk4bq6n4UCJ9LJ8de/svHiuUk4FzIYNo4r0Aj0tiwYsGugLD0GS90z1O7Kb
         GdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597537; x=1749202337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgdxFQILtv1ZFBwGDlokBNLY9DZwyLg+1V8wfJcAxqs=;
        b=Wme31eRywmnM8daKV5T/ZPvc0MlOGgUXsVzsZoufWxh1eQsbKMCN39PF6ub6m93sYr
         E8ernGyj/GPb5jX5Z/UzaTqLFEcbCCLgjQ2OKVfF60b3daqtn8UR1pMi5HtG6UwtdVHy
         09VGsRQzPm7MuRe/ky+FxjEmoI8ClZkjtveEF0y32PF0f0U7IJqoVRv3kBKhLj/xeA0H
         6ZNl8dpQ0ZfqC36/3l7zGlViKKomx8s8sXMnfz9m2jM7BYsvfOq0UL0A7EEoMgecTPDN
         HV76jJKkY1rFAJYimKV3RjoPwF6OEmX0kzP7gxZyqCVOlbZK5dBdrKp64+HGqumN5P6r
         YtoA==
X-Forwarded-Encrypted: i=1; AJvYcCX0UXaw+8zJfnpN58wdtdM3ZwEkKsHdjVVdTQHFnWukFksxiAfFlepd9+kWRmrdqPnOYgvouPXxcsNdX6n1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03n92Y0w0PzOI6VtYoT4f+uYroEaShKP7dTi1ahb7Ai3NbSEG
	zdFVI1em9a4XsUKviFYKYEERHJNb8dbnaR+vKOzl4HyF8OLyfHcXu/ghYwNl+lOjgPI=
X-Gm-Gg: ASbGncsWlEH/Vbw822u8JPREuzO96iJgemyVfpX6MWYg0Wkb7Wn4p3nMTv4usM3qwPl
	vOAMhPaNT1GHjU5Cchwb+9ilBZfxEVqUoYZZ8J1akh6j8gzHazYTTKO1CC+joZhZDoZc7+gM7zj
	t81nKxkDx4IVUk5IyI0N8/rCPdO53i9iJQ0tVBuRlOElpslEvvNbcDc0cLdfKwSUF3UtuAM9NGU
	t8vEzLvQjZzBoeXU/QBm+/T3zKKERiHchNXEhWnOi2e9L0I9EqluCo7VFAA4qmyYpeTYoG3AbJk
	oZciDiXTPJIbnFEhUTQzOeYZTlcoSwafuQhauL/mLYYZrHisUhDuFMAwSAVfQWcvT8Sxfu3Q21z
	0OvSkOqWuJw==
X-Google-Smtp-Source: AGHT+IEJreThnxFmdrlfjlpwKZv59IFtRtCaH2wQICekYkicVpLMTveAapFUeJrWIU6RsHlorrZhig==
X-Received: by 2002:a17:90b:314d:b0:311:c1ec:7d0c with SMTP id 98e67ed59e1d1-312504437b2mr2132223a91.27.1748597536883;
        Fri, 30 May 2025 02:32:16 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.32.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:32:16 -0700 (PDT)
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
Subject: [RFC v2 15/35] RPAL: add sender/receiver state
Date: Fri, 30 May 2025 17:27:43 +0800
Message-Id: <6582d600063dd2176558bdf2b62a6a143bd594e2.1748594840.git.libo.gcs85@bytedance.com>
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

The lazy switch defines six receiver states, and their state transitions
are as follows:

   |<--->READY<----> WAIT <----> CALL ----> LAZY_SWITCH ---> KERNEL_RET
   |                                             |               |
RUNNING <----------------------------------------|---------------|

The receiver thread initially starts in the RUNNING state and can
transition to the WAIT state voluntarily. The READY state is a temporary
state before entering WAIT state.  For a receiver in the WAIT state, it
must be in the TASK_INTERRUPTIBLE state. If the receiver thread is woken
up, the WAIT state can transition to the RUNNING state.

Once the receiver is in the WAIT state, the sender thread can
initiate an RPAL call, causing the receiver to enter the CALL state. A
receiver thread in the CALL state cannot be awakened until a lazy switch
occurs or its state changes. The call state carries additional service_id
and sender_id information.

If the sender completes executing the receiver's code without entering the
kernel after issuing the RPAL call, the receiver transitions back from the
CALL state to the WAIT state. Conversely, if the sender enters the kernel
during the RPAL call, the receiver's state changes to LAZY_SWITCH.

From the LAZY_SWITCH state, the receiver thread has two possible state
transitions: When the receiver thread finishes execution and switches back
to the sender via a lazy switch, it first enters the KERNEL_RET state and
then transitions to the RUNNING state. If the receiver thread runs for too
long and the scheduler resumes the sender, the receiver directly
transitions to the RUNNING state. Transitions to the RUNNING state can be
done in userspace.

The lazy switch mechanism defines three states for the sender thread:

 - RUNNING: The sender starts in this state. When the sender initiates
   an RPAL call to switch from user mode to the receiver, it transitions
   to the CALL state.

 - CALL: The sender remains in this state while the receiver is executing
   the code triggered by the RPAL call. When the receiver switches back to
   the sender from user mode, the sender returns to the RUNNING state.

 - KERNEL_RET: If the receiver takes an extended period to switch back to
   the sender after a lazy switch, the scheduler may preempt the sender to
   run other tasks. In this case, the sender enters the KERNEL_RET state
   while in the kernel. Once the sender resumes execution in user mode, it
   transitions back to the RUNNING state.

This patch implements the handling and transition of the receiver's state.
When a receiver leaves the run queue in the READY state, its state
transitions to the WAIT state; otherwise, it transitions to the RUNNING
state. The patch also modifies try_to_wake_up() to handling different
states: for the READY and WAIT states, try_to_wake_up() causes the state
to change to the RUNNING state. For the CALL state, try_to_wake_up() cannot
wake up the task. The patch provides a special interface,
rpal_try_to_wake_up(), to wake up tasks in the CALL state, which can be
used for lazy switches.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/process_64.c |  43 ++++++++++++
 arch/x86/rpal/internal.h     |   7 ++
 include/linux/rpal.h         |  50 ++++++++++++++
 kernel/sched/core.c          | 130 +++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index f39ff02e498d..4830e9215de7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -40,6 +40,7 @@
 #include <linux/ftrace.h>
 #include <linux/syscalls.h>
 #include <linux/iommu.h>
+#include <linux/rpal.h>
 
 #include <asm/processor.h>
 #include <asm/pkru.h>
@@ -596,6 +597,36 @@ void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
 }
 #endif
 
+#ifdef CONFIG_RPAL
+static void rpal_receiver_enter_wait(struct task_struct *prev_p)
+{
+	if (READ_ONCE(prev_p->__state) == TASK_INTERRUPTIBLE) {
+		atomic_cmpxchg(&prev_p->rpal_rd->rcc->receiver_state,
+			       RPAL_RECEIVER_STATE_READY,
+			       RPAL_RECEIVER_STATE_WAIT);
+	} else {
+		/*
+		 * Simply check RPAL_RECEIVER_STATE_READY is not enough. It is
+		 * possible task's state is TASK_RUNNING. Consider following case:
+		 *
+		 * CPU 0(prev_p)            CPU 1(waker)
+		 * set TASK_INTERRUPTIBLE
+		 * set RPAL_RECEIVER_STATE_READY
+		 *                          check TASK_INTERRUPTIBLE
+		 * clear RPAL_RECEIVER_STATE_READY
+		 * clear TASK_INTERRUPTIBLE
+		 * set TASK_INTERRUPTIBLE
+		 * set RPAL_RECEIVER_STATE_READY
+		 *                          ttwu_runnable()
+		 * schedule()
+		 */
+		atomic_cmpxchg(&prev_p->rpal_rd->rcc->receiver_state,
+			       RPAL_RECEIVER_STATE_READY,
+			       RPAL_RECEIVER_STATE_RUNNING);
+	}
+}
+#endif
+
 /*
  *	switch_to(x,y) should switch tasks from x to y.
  *
@@ -704,6 +735,18 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 			loadsegment(ss, __KERNEL_DS);
 	}
 
+#ifdef CONFIG_RPAL
+	/*
+	 * When we come to here, the stack switching is finished. Therefore,
+	 * the receiver thread is prepared for a lazy switch. We then change
+	 * the receiver_state from RPAL_RECEIVER_STATE_REAY to
+	 * RPAL_RECEIVER_STATE_WAIT and other thread is able to call it with
+	 * RPAL call.
+	 */
+	if (rpal_test_task_thread_flag(prev_p, RPAL_RECEIVER_BIT))
+		rpal_receiver_enter_wait(prev_p);
+#endif
+
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index cf6d608a994a..6256172bb79e 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -47,3 +47,10 @@ int rpal_unregister_sender(void);
 int rpal_register_receiver(unsigned long addr);
 int rpal_unregister_receiver(void);
 void exit_rpal_thread(void);
+
+static inline unsigned long
+rpal_build_call_state(const struct rpal_sender_data *rsd)
+{
+	return ((rsd->rcd.service_id << RPAL_SID_SHIFT) |
+		(rsd->scc->sender_id << RPAL_ID_SHIFT) | RPAL_RECEIVER_STATE_CALL);
+}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 3310d222739e..4f4719bb7eae 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -87,6 +87,13 @@ enum {
 
 #define RPAL_ERROR_MAGIC 0x98CC98CC
 
+#define RPAL_SID_SHIFT 24
+#define RPAL_ID_SHIFT 8
+#define RPAL_RECEIVER_STATE_MASK ((1 << RPAL_ID_SHIFT) - 1)
+#define RPAL_SID_MASK (~((1 << RPAL_SID_SHIFT) - 1))
+#define RPAL_ID_MASK (~(0 | RPAL_RECEIVER_STATE_MASK | RPAL_SID_MASK))
+#define RPAL_MAX_ID ((1 << (RPAL_SID_SHIFT - RPAL_ID_SHIFT)) - 1)
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -94,6 +101,22 @@ enum rpal_task_flag_bits {
 	RPAL_RECEIVER_BIT,
 };
 
+enum rpal_receiver_state {
+	RPAL_RECEIVER_STATE_RUNNING,
+	RPAL_RECEIVER_STATE_KERNEL_RET,
+	RPAL_RECEIVER_STATE_READY,
+	RPAL_RECEIVER_STATE_WAIT,
+	RPAL_RECEIVER_STATE_CALL,
+	RPAL_RECEIVER_STATE_LAZY_SWITCH,
+	RPAL_RECEIVER_STATE_MAX,
+};
+
+enum rpal_sender_state {
+	RPAL_SENDER_STATE_RUNNING,
+	RPAL_SENDER_STATE_CALL,
+	RPAL_SENDER_STATE_KERNEL_RET,
+};
+
 /*
  * user_meta will be sent to other service when requested.
  */
@@ -215,6 +238,8 @@ struct rpal_task_context {
 struct rpal_receiver_call_context {
 	struct rpal_task_context rtc;
 	int receiver_id;
+	atomic_t receiver_state;
+	atomic_t sender_state;
 };
 
 /* recovery point for sender */
@@ -390,11 +415,35 @@ static inline bool rpal_test_current_thread_flag(unsigned long bit)
 {
 	return test_bit(bit, &current->rpal_flag);
 }
+
+static inline bool rpal_test_task_thread_flag(struct task_struct *tsk,
+					      unsigned long bit)
+{
+	return test_bit(bit, &tsk->rpal_flag);
+}
+
+static inline void rpal_set_task_thread_flag(struct task_struct *tsk,
+					     unsigned long bit)
+{
+	set_bit(bit, &tsk->rpal_flag);
+}
+
+static inline void rpal_clear_task_thread_flag(struct task_struct *tsk,
+					       unsigned long bit)
+{
+	clear_bit(bit, &tsk->rpal_flag);
+}
 #else
 static inline struct rpal_service *rpal_current_service(void) { return NULL; }
 static inline void rpal_set_current_thread_flag(unsigned long bit) { }
 static inline void rpal_clear_current_thread_flag(unsigned long bit) { }
 static inline bool rpal_test_current_thread_flag(unsigned long bit) { return false; }
+static inline bool rpal_test_task_thread_flag(struct task_struct *tsk,
+	unsigned long bit) { return false; }
+static inline void rpal_set_task_thread_flag(struct task_struct *tsk,
+					     unsigned long bit) { }
+static inline void rpal_clear_task_thread_flag(struct task_struct *tsk,
+					       unsigned long bit) { }
 #endif
 
 void rpal_unregister_service(struct rpal_service *rs);
@@ -414,4 +463,5 @@ struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild);
 
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
 	struct rlimit *rlim_stack);
+int rpal_try_to_wake_up(struct task_struct *p);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 62b3416f5e43..045e92ee2e3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,6 +67,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/rpal.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_ENTRY
@@ -3820,6 +3821,40 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	return ret;
 }
 
+#ifdef CONFIG_RPAL
+static bool rpal_check_state(struct task_struct *p)
+{
+	bool ret = true;
+
+	if (rpal_test_task_thread_flag(p, RPAL_RECEIVER_BIT)) {
+		struct rpal_receiver_call_context *rcc = p->rpal_rd->rcc;
+		int state;
+
+retry:
+		state = atomic_read(&rcc->receiver_state) & RPAL_RECEIVER_STATE_MASK;
+		switch (state) {
+		case RPAL_RECEIVER_STATE_READY:
+		case RPAL_RECEIVER_STATE_WAIT:
+			if (state != atomic_cmpxchg(&rcc->receiver_state, state,
+						     RPAL_RECEIVER_STATE_RUNNING))
+				goto retry;
+			break;
+		case RPAL_RECEIVER_STATE_KERNEL_RET:
+		case RPAL_RECEIVER_STATE_LAZY_SWITCH:
+		case RPAL_RECEIVER_STATE_RUNNING:
+			break;
+		case RPAL_RECEIVER_STATE_CALL:
+			ret = false;
+			break;
+		default:
+			rpal_err("%s: invalid state: %d\n", __func__, state);
+			break;
+		}
+	}
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_SMP
 void sched_ttwu_pending(void *arg)
 {
@@ -3841,6 +3876,11 @@ void sched_ttwu_pending(void *arg)
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
+#ifdef CONFIG_RPAL
+		if (!rpal_check_state(p))
+			continue;
+#endif
+
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 	}
 
@@ -4208,6 +4248,17 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
+#ifdef CONFIG_RPAL
+		/*
+		 * For rpal thread, we need to check if it can be woken up. If not,
+		 * we do not wake it up here but wake it up later by kernel worker.
+		 *
+		 * For normal thread, nothing happens.
+		 */
+		if (!rpal_check_state(p))
+			goto out;
+#endif
+
 		trace_sched_waking(p);
 		ttwu_do_wakeup(p);
 		goto out;
@@ -4224,6 +4275,11 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (!ttwu_state_match(p, state, &success))
 			break;
 
+#ifdef CONFIG_RPAL
+		if (!rpal_check_state(p))
+			break;
+#endif
+
 		trace_sched_waking(p);
 
 		/*
@@ -4344,6 +4400,56 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	return success;
 }
 
+#ifdef CONFIG_RPAL
+int rpal_try_to_wake_up(struct task_struct *p)
+{
+	guard(preempt)();
+	int cpu, success = 0;
+	int wake_flags = WF_TTWU;
+
+	BUG_ON(READ_ONCE(p->__state) == TASK_RUNNING);
+
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
+		smp_mb__after_spinlock();
+		if (!ttwu_state_match(p, TASK_NORMAL, &success))
+			break;
+
+		trace_sched_waking(p);
+		/* see try_to_wake_up() */
+		smp_rmb();
+
+#ifdef CONFIG_SMP
+		smp_acquire__after_ctrl_dep();
+		WRITE_ONCE(p->__state, TASK_WAKING);
+		/* see try_to_wake_up() */
+		if (smp_load_acquire(&p->on_cpu) &&
+		    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
+			break;
+		smp_cond_load_acquire(&p->on_cpu, !VAL);
+
+		cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
+		if (task_cpu(p) != cpu) {
+			if (p->in_iowait) {
+				delayacct_blkio_end(p);
+				atomic_dec(&task_rq(p)->nr_iowait);
+			}
+
+			wake_flags |= WF_MIGRATED;
+			psi_ttwu_dequeue(p);
+			set_task_cpu(p, cpu);
+		}
+#else
+		cpu = task_cpu(p);
+#endif
+	}
+	ttwu_queue(p, cpu, wake_flags);
+	if (success)
+		ttwu_stat(p, task_cpu(p), wake_flags);
+
+	return success;
+}
+#endif
+
 static bool __task_needs_rq_lock(struct task_struct *p)
 {
 	unsigned int state = READ_ONCE(p->__state);
@@ -6574,6 +6680,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_PREEMPT		1
 #define SM_RTLOCK_WAIT		2
 
+#ifdef CONFIG_RPAL
+static inline void rpal_check_ready_state(struct task_struct *tsk, int state)
+{
+	if (rpal_test_task_thread_flag(tsk, RPAL_RECEIVER_BIT)) {
+		struct rpal_receiver_call_context *rcc = tsk->rpal_rd->rcc;
+
+		atomic_cmpxchg(&rcc->receiver_state, state,
+			       RPAL_RECEIVER_STATE_RUNNING);
+	}
+}
+#endif
+
 /*
  * Helper function for __schedule()
  *
@@ -6727,7 +6845,19 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
+#ifdef CONFIG_RPAL
+		if (!try_to_block_task(rq, prev, &prev_state)) {
+			/*
+			 * As the task enter TASK_RUNNING state, we should clean up
+			 * RPAL_RECEIVER_STATE_READY status. Therefore, the receiver's
+			 * state will not be change to RPAL_RECEIVER_STATE_WAIT. Thus,
+			 * there is no RPAL call when a receiver is at TASK_RUNNING state.
+			 */
+			rpal_check_ready_state(prev, RPAL_RECEIVER_STATE_READY);
+		}
+#else
 		try_to_block_task(rq, prev, &prev_state);
+#endif
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.20.1


