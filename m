Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88602450157
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhKOJ3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 04:29:55 -0500
Received: from esa8.hc324-48.eu.iphmx.com ([207.54.65.242]:24153 "EHLO
        esa8.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236489AbhKOJ0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:26:19 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 04:26:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1636968204; x=1668504204;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jtoQR8wy0LIbv3M96BIxO7zMobX3lohEgxe1SyDHY7o=;
  b=GT4yGAeeOgkc8WbTgKffWiquGJIXdeFvl11qaHs+w90c3zmkTfyqshOA
   FitGATqTZGhK9kUT9AAZDDr2DOnwUJ3NjkRoaglqRaREjxkPYegRvbBIc
   cEgti3fFdxK4CT9/YqW5yUpsP9uEAVkN/xhZujgNddl090cejxlEvGMc2
   A=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 15 Nov 2021 10:15:50 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw1.muc with ESMTP/TLS;
 15 Nov 2021 10:15:50 +0100
Received: from smucm08j.bmwgroup.net (HELO smucm08j.europe.bmw.corp) ([160.48.96.38])
 by esabb6.muc with ESMTP/TLS; 15 Nov 2021 10:15:48 +0100
Received: from cmucw916504.de-cci.bmwgroup.net (192.168.221.38) by
 smucm08j.europe.bmw.corp (160.48.96.38) with Microsoft SMTP Server (TLS;
 Mon, 15 Nov 2021 10:15:46 +0100
From:   Vladimir Divjak <vladimir.divjak@bmw.de>
To:     <vladimir.divjak@bmw.de>, <viro@zeniv.linux.org.uk>,
        <mcgrof@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <will@kernel.org>,
        <yuzhao@google.com>, <hannes@cmpxchg.org>, <fenghua.yu@intel.com>,
        <guro@fb.com>, <jgg@ziepe.ca>, <hughd@google.com>,
        <axboe@kernel.dk>, <ebiederm@xmission.com>, <pcc@google.com>,
        <tglx@linutronix.de>, <elver@google.com>, <jannh@google.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] coredump-ptrace: Delayed delivery of SIGSTOP
Date:   Mon, 15 Nov 2021 10:15:40 +0100
Message-ID: <20211115091540.3806073-1-vladimir.divjak@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm26l.europe.bmw.corp (160.46.167.28) To
 smucm08j.europe.bmw.corp (160.48.96.38)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow SIGSTOP to be delivered to the dying process,
if it is coming from coredump user mode helper (umh)
process, but delay it until coredump is finished,
at which point it will be re-triggered in coredump_finish().

When processing this signal, set the tasks of the dying process
directly to TASK_TRACED state during complete_signal(),
instead of attempting signal_wake_up().

Do so to allow the umh process to ptrace(PTRACE_ATTACH,...)
to the dying process, whose coredump it's handling.

* Problem description:
In automotive and/or embedded environments,
the storage capacity to store, and/or
network capabilities to upload
a complete core file can easily be a limiting factor,
making offline crash analysis difficult.

* Solution:
Allow the user mode coredump helper process
to perform ptrace on the dying process in order to obtain
useful information such as user mode stacktrace,
thereby improving the offline debugging possibilities
for such environments.

Signed-off-by: Vladimir Divjak <vladimir.divjak@bmw.de>
---
 fs/coredump.c            | 18 +++++++++--
 include/linux/mm_types.h |  2 ++
 include/linux/umh.h      |  1 +
 kernel/signal.c          | 64 +++++++++++++++++++++++++++++++++++++---
 kernel/umh.c             |  7 +++--
 5 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2868e3e171ae..9a51a1a2168d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -487,6 +487,20 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 {
 	struct core_thread *curr, *next;
 	struct task_struct *task;
+	int signr;
+	struct ksignal ksig;
+
+	current->mm->core_state->core_dumped = true;
+
+	/*
+	 * Check if there is a SIGSTOP pending, and if so, re-trigger its delivery
+	 * allowing the coredump umh process to do a ptrace on this one.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	signr = next_signal(&current->pending, &current->blocked);
+	spin_unlock_irq(&current->sighand->siglock);
+	if (signr == SIGSTOP)
+		get_signal(&ksig);
 
 	spin_lock_irq(&current->sighand->siglock);
 	if (core_dumped && !__fatal_signal_pending(current))
@@ -601,7 +615,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		.mm_flags = mm->flags,
 	};
-
+	core_state.core_dumped = false;
 	audit_core_dumps(siginfo->si_signo);
 
 	binfmt = mm->binfmt;
@@ -695,7 +709,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
-
+		core_state.umh_pid = sub_info->pid;
 		kfree(helper_argv);
 		if (retval) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..475b3d8cd399 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -381,6 +381,8 @@ struct core_state {
 	atomic_t nr_threads;
 	struct core_thread dumper;
 	struct completion startup;
+	bool core_dumped;
+	pid_t umh_pid;
 };
 
 struct kioctx_table;
diff --git a/include/linux/umh.h b/include/linux/umh.h
index 244aff638220..b2bbcafe7c98 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -24,6 +24,7 @@ struct subprocess_info {
 	char **envp;
 	int wait;
 	int retval;
+	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
diff --git a/kernel/signal.c b/kernel/signal.c
index 66e88649cf74..5e7812644c8a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -943,8 +943,22 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 	sigset_t flush;
 
 	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
-		if (!(signal->flags & SIGNAL_GROUP_EXIT))
-			return sig == SIGKILL;
+		if (!(signal->flags & SIGNAL_GROUP_EXIT)) {
+			/*
+			 * If the signal is for the process being core-dumped
+			 * and the signal is SIGSTOP sent by the coredump umh process
+			 * let it through (in addition to SIGKILL)
+			 * allowing the coredump umh process to ptrace the dying process.
+			 */
+			bool sig_from_umh = false;
+
+			if (unlikely(p->mm && p->mm->core_state &&
+				p->mm->core_state->umh_pid == current->tgid)) {
+				sig_from_umh = true;
+			}
+			return sig == SIGKILL || (sig == SIGSTOP && sig_from_umh);
+		}
+
 		/*
 		 * The process is in the middle of dying, nothing to do.
 		 */
@@ -1014,8 +1028,18 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	if (sigismember(&p->blocked, sig))
 		return false;
 
-	if (p->flags & PF_EXITING)
+	if (p->flags & PF_EXITING) {
+		/*
+		 * Ignore the fact the process is exiting,
+		 * if it's being core-dumped, and the signal is SIGSTOP
+		 * allowing the coredump umh process to ptrace the dying process.
+		 * See prepare_signal().
+		 */
+		if (unlikely(p->mm && p->mm->core_state && sig == SIGSTOP))
+			return true;
+
 		return false;
+	}
 
 	if (sig == SIGKILL)
 		return true;
@@ -1094,6 +1118,22 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 		}
 	}
 
+	/*
+	 * If the signal is completed for a process being core-dumped,
+	 * and the signal is SIGSTOP, there is no point in waking up its tasks,
+	 * as they are either dumping the core, or in uninterruptible state,
+	 * so skip the wake up if core-dump is not yet completed.
+	 * Instead, if the core-dump has been completed, see coredump_finish()
+	 * set the task state directly to TASK_TRACED,
+	 * allowing the coredump umh process to ptrace the dying process.
+	 */
+	if (unlikely(t->mm && t->mm->core_state) && sig == SIGSTOP) {
+		if (t->mm->core_state->core_dumped)
+			t->state = TASK_TRACED;
+
+		return;
+	}
+
 	/*
 	 * The signal is already in the shared-pending queue.
 	 * Tell the chosen thread to wake up and dequeue it.
@@ -2586,6 +2626,7 @@ bool get_signal(struct ksignal *ksig)
 	struct sighand_struct *sighand = current->sighand;
 	struct signal_struct *signal = current->signal;
 	int signr;
+	bool sigstop_pending = false;
 
 	if (unlikely(current->task_works))
 		task_work_run();
@@ -2651,8 +2692,23 @@ bool get_signal(struct ksignal *ksig)
 		goto relock;
 	}
 
+
+	/*
+	 * If this task is being core-dumped,
+	 * and the next signal is SIGSTOP, allow its delivery
+	 * to enable the coredump umh process to ptrace the dying one.
+	 */
+	if (unlikely(current->mm && current->mm->core_state)) {
+		int nextsig = 0;
+
+		nextsig = next_signal(&current->pending, &current->blocked);
+		if (nextsig == SIGSTOP) {
+			sigstop_pending = true;
+		}
+	}
+
 	/* Has this task already been marked for death? */
-	if (signal_group_exit(signal)) {
+	if (signal_group_exit(signal) && !sigstop_pending) {
 		ksig->info.si_signo = signr = SIGKILL;
 		sigdelset(&current->pending.signal, SIGKILL);
 		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
diff --git a/kernel/umh.c b/kernel/umh.c
index 36c123360ab8..8ac027c75d70 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -107,6 +107,7 @@ static int call_usermodehelper_exec_async(void *data)
 	}
 
 	commit_creds(new);
+	sub_info->pid = task_pid_nr(current);
 
 	wait_for_initramfs();
 	retval = kernel_execve(sub_info->path,
@@ -133,10 +134,12 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
 	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
-	if (pid < 0)
+	if (pid < 0) {
 		sub_info->retval = pid;
-	else
+	} else {
+		sub_info->pid = pid;
 		kernel_wait(pid, &sub_info->retval);
+	}
 
 	/* Restore default kernel sig handler */
 	kernel_sigaction(SIGCHLD, SIG_IGN);
-- 
2.25.1

