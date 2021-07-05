Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830C3BBEC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGEPUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 11:20:24 -0400
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119]:45134 "EHLO
        esa1.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhGEPUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:20:24 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 11:20:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1625498266; x=1657034266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Fv4GFMwYhb4ep+MHmeVtDCo6iMucTolv6inuiaafz4=;
  b=eVu+VR5t0mA0bAEmLvDTi5uRz7BRU7BQ7dkcOuoDAVvyLSgq4fHFYY5N
   WQexuuRZ5ZakCr525yOelEOQ3rMZO0KHTW+P6ca4DzeLvtgK2zEzHz42c
   T1nE7irDVKTg7S2TWQyQb7XnQ0SsWqVrsJoPyKzOCht/PgVMlHPTmszto
   4=;
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 05 Jul 2021 17:10:36 +0200
Received: from esabb5.muc ([160.50.100.47])  by esagw5.muc with ESMTP/TLS;
 05 Jul 2021 17:10:35 +0200
Received: from smucm08j.bmwgroup.net (HELO smucm08j.europe.bmw.corp) ([160.48.96.38])
 by esabb5.muc with ESMTP/TLS; 05 Jul 2021 17:10:35 +0200
Received: from cmucw916504.de-cci.bmwgroup.net (192.168.221.43) by
 smucm08j.europe.bmw.corp (160.48.96.38) with Microsoft SMTP Server (TLS;
 Mon, 5 Jul 2021 17:10:35 +0200
From:   Vladimir Divjak <vladimir.divjak@bmw.de>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <mcgrof@kernel.org>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>
CC:     Vladimir Divjak <vladimir.divjak@bmw.de>
Subject: [PATCH] coredump: allow PTRACE_ATTACH to coredump user mode helper
Date:   Mon, 5 Jul 2021 17:10:19 +0200
Message-ID: <20210705151019.989929-1-vladimir.divjak@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm17l.europe.bmw.corp (160.48.96.76) To
 smucm08j.europe.bmw.corp (160.48.96.38)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows the coredump user mode helper process,
if one is configured (in core_pattern),
to perform ptrace operations on the dying process
whose cordump it's handling.

The user mode helper process is expected to do so
before consuming the coredump data from the pipe,
and thereby, before the dying process is reaped by kernel.

Issuing a PTRACE_ATTACH request will pause the coredumping
for that task until ptrace operation is finished.

The user mode helper process is also expected to
issue a PTRACE_CONT request to the dying process,
when it is done ptracing it, signaling the dying process
coredumping can be resumed.

* Problem description / Rationale:
In automotive and/or embedded environments,
the storage capacity to store, and/or
network capabilities to upload
a complete core file can easily be a limiting factor,
making offline issue analysis difficult.

* Solution:
Allow the user mode coredump helper process
to perform ptrace on the dying process in order to obtain
useful information such as user mode stacktrace, and
thereby greatly improve the offline debugging possibilities
for such environments.

* Impact / Risk:
The user mode helper process is already entrusted
with handling the coredump data, so allowing it to read or even change
the dying process memory should not pose an additional risk.

Furthermore, this change makes coredump emission somewhat slower
due to the additional step of iterating over the core dump helper list
and checking if ptrace completion needs to be awaited,
during coredump emission.

Signed-off-by: Vladimir Divjak <vladimir.divjak@bmw.de>
---
 fs/coredump.c            | 150 ++++++++++++++++++++++++++++++++++++++-
 include/linux/coredump.h |  35 +++++++++
 include/linux/umh.h      |   1 +
 kernel/ptrace.c          |  19 +++++
 kernel/umh.c             |   7 +-
 5 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2868e3e171ae..ee8f816cc643 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -41,6 +41,7 @@
 #include <linux/fs.h>
 #include <linux/path.h>
 #include <linux/timekeeping.h>
+#include <linux/jiffies.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -62,6 +63,64 @@ struct core_name {
 	int used, size;
 };
 
+DEFINE_MUTEX(cdh_mutex);
+LIST_HEAD(cdh_list);
+
+/**
+ * struct cdh_entry - core dump helper (cdh) entry
+ * @cdh_list_link: cdh linked list reference
+ * @task_being_dumped: pointer to a task being core-dumped
+ * @ptrace_done: completion used to wait for ptrace operation by cdh to be done
+ * @helper_pid: PID of the core dump user-space helper process
+ */
+struct cdh_entry {
+	struct list_head cdh_list_link;
+	struct task_struct *task_being_dumped;
+	struct completion ptrace_done;
+	pid_t helper_pid;
+};
+
+/**
+ * cdh_link_current_locked() - Adds a new entry for the current task
+ *                             to the cdh linked list.
+ * @pid: PID of the core dump user-space helper process.
+ *
+ * If a core dump user-space helper process is configured in core_pattern,
+ * a cdh_entry, used to track the user-space helper PID,
+ * so it can be allowed to ptrace the task being core-dumped,
+ * and enable the task being core-dumped to await a potential ptrace operation
+ * by the user-space helper to finish,
+ * is created when the user-space helper process is started by kernel.
+ *
+ * Context: Expects the cdh_mutex to be held when called.
+ */
+static void cdh_link_current_locked(pid_t pid);
+
+/**
+ * cdh_unlink_current() - Removes the current task's cdh_entry from the list.
+ *
+ * When the core dump of the current task is finished,
+ * its corresponding cdh_entry is removed by calling this function.
+ *
+ * Context: Takes and releases the cdh_mutex.
+ */
+static void cdh_unlink_current(void);
+
+/**
+ * cdh_get_entry_for_current() - Returns a pointer to the cdh_entry
+ *                               for the current task.
+ *
+ * Called by __dump_emit to get the current task's cdh_entry
+ * and sleep on the ptrace_done completion object therein,
+ * waiting for ptrace to complete, if ptrace operation for it
+ * was started by the core dump user-space helper tracer.
+ *
+ * Context: Iterates over cdh_entry list without taking the cdh_mutex,
+ *          as it is safe to assume the cdh_entry it will return, if any,
+ *          is stably in the list at the time of calling.
+ */
+static struct cdh_entry *cdh_get_entry_for_current(void);
+
 /* The maximal length of core_pattern is also specified in sysctl.c */
 
 static int expand_corename(struct core_name *cn, int size)
@@ -692,9 +751,14 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
 						umh_pipe_setup, NULL, &cprm);
-		if (sub_info)
+		if (sub_info) {
+			mutex_lock(&cdh_mutex);
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
+			if (!retval)
+				cdh_link_current_locked(sub_info->pid);
+			mutex_unlock(&cdh_mutex);
+		}
 
 		kfree(helper_argv);
 		if (retval) {
@@ -833,6 +897,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(mm, core_dumped);
+	cdh_unlink_current();
 	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);
@@ -850,6 +915,11 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	struct file *file = cprm->file;
 	loff_t pos = file->f_pos;
 	ssize_t n;
+	struct cdh_entry *entry;
+
+	entry = cdh_get_entry_for_current();
+	if (entry)
+		wait_for_completion_timeout(&(entry->ptrace_done, msecs_to_jiffies(5 * 60 * 1000));
 	if (cprm->written + nr > cprm->limit)
 		return 0;
 
@@ -1133,3 +1203,81 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
 	*vma_data_size_ptr = vma_data_size;
 	return 0;
 }
+
+void cdh_link_current_locked(pid_t pid)
+{
+	struct cdh_entry *entry;
+
+	entry = kzalloc(sizeof(struct cdh_entry), GFP_KERNEL);
+	if (!entry)
+		return;
+	entry->task_being_dumped = current;
+	entry->helper_pid = pid;
+	init_completion(&(entry->ptrace_done));
+	/*
+	 * Instantly complete_all the ptrace_done completion,
+	 * as it should only be awaited if and when the ptrace
+	 * operation by the core dump user-space helper has been started,
+	 * in which case the completion object will be reinited.
+	 */
+	complete_all(&(entry->ptrace_done));
+	list_add(&entry->cdh_list_link, &cdh_list);
+}
+
+void cdh_unlink_current(void)
+{
+	struct cdh_entry *entry, *next;
+
+	mutex_lock(&cdh_mutex);
+	list_for_each_entry_safe(entry, next, &cdh_list, cdh_list_link) {
+		if (entry->task_being_dumped == current) {
+			list_del(&entry->cdh_list_link);
+			kfree(entry);
+			break;
+		}
+	}
+	mutex_unlock(&cdh_mutex);
+}
+
+bool cdh_ptrace_allowed(struct task_struct *task)
+{
+	struct cdh_entry *entry;
+
+	mutex_lock(&cdh_mutex);
+	list_for_each_entry(entry, &cdh_list, cdh_list_link) {
+		if (task_tgid_nr(entry->task_being_dumped) == task_tgid_nr(task)
+		    && entry->helper_pid == task_tgid_nr(current)) {
+			reinit_completion(&(entry->ptrace_done));
+			wait_task_inactive(entry->task_being_dumped, 0);
+			mutex_unlock(&cdh_mutex);
+			return true;
+		}
+	}
+	mutex_unlock(&cdh_mutex);
+	return false;
+}
+
+void cdh_signal_continue(struct task_struct *task)
+{
+	struct cdh_entry *entry;
+
+	mutex_lock(&cdh_mutex);
+	list_for_each_entry(entry, &cdh_list, cdh_list_link) {
+		if (task_tgid_nr(entry->task_being_dumped) == task_tgid_nr(task)) {
+			complete_all(&(entry->ptrace_done));
+			break;
+		}
+	}
+	mutex_unlock(&cdh_mutex);
+}
+
+struct cdh_entry *cdh_get_entry_for_current(void)
+{
+	struct cdh_entry *entry;
+
+	list_for_each_entry(entry, &cdh_list, cdh_list_link) {
+		if (entry->task_being_dumped == current)
+			return entry;
+	}
+	return NULL;
+}
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 78fcd776b185..dc801631a70b 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -18,6 +18,41 @@ extern int core_uses_pid;
 extern char core_pattern[];
 extern unsigned int core_pipe_limit;
 
+/**
+ * cdh_ptrace_allowed() - Checks whether ptrace of the task being core-dumped,
+ *                        is allowed to the caller.
+ * @task: Tracee task being core-dumped,
+ *        which the core dump user-space helper wants to ptrace.
+ *
+ * Called by ptrace when a process attempts to ptrace a task being core-dumped.
+ * If the caller is the core dump user-space helper process,
+ * it will be allowed to do so, after instructing the task being core-dumped to
+ * wait for the ptrace operation to complete,
+ * and waiting for that task to become inactive in waiting for ptrace to complete.
+ * Ptrace operation is considered complete when the tracer issues the PTRACE_CONT
+ * ptrace request to the tracee.
+ *
+ * Context: Takes and releases the cdh_mutex.
+ *          Sleeps waiting for the current task to become inactive
+ *          (due to waiting for ptrace to be done).
+ * Return: true if caller is core dump user-space helper, false otherwise.
+ */
+bool cdh_ptrace_allowed(struct task_struct *task);
+
+/**
+ * cdh_signal_continue() - Lets the specified task being core dumped know that
+ *                         ptrace operation for it is done and it can continue.
+ * @task: Tracee task being core-dumped, the caller wants to signal to continue.
+ *
+ * Called by ptrace when the tracer of the task being core dumped signals
+ * that ptrace operation for it is complete,
+ * by means of issuing a PTRACE_CONT request to the tracee.
+ * This makes the core dump of the tracee task continue.
+ *
+ * Context: Takes and releases the cdh_mutex.
+ */
+void cdh_signal_continue(struct task_struct *task);
+
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 76f09456ec4b..5b94a1b9e4ff 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/coredump.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -361,6 +362,8 @@ static int ptrace_attach(struct task_struct *task, long request,
 {
 	bool seize = (request == PTRACE_SEIZE);
 	int retval;
+	bool core_state = false;
+	bool core_trace_allowed = false;
 
 	retval = -EIO;
 	if (seize) {
@@ -392,10 +395,17 @@ static int ptrace_attach(struct task_struct *task, long request,
 
 	task_lock(task);
 	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+	if (unlikely(task->mm->core_state))
+		core_state = true;
 	task_unlock(task);
 	if (retval)
 		goto unlock_creds;
 
+	if (!seize && unlikely(core_state)) {
+		if (cdh_ptrace_allowed(task))
+			core_trace_allowed = true;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	retval = -EPERM;
 	if (unlikely(task->exit_state))
@@ -415,6 +425,13 @@ static int ptrace_attach(struct task_struct *task, long request,
 
 	spin_lock(&task->sighand->siglock);
 
+	/*
+	 * Core state process does not process signals normally.
+	 * set directly to TASK_TRACED if allowed by cdh_ptrace_allowed.
+	 */
+	if (core_trace_allowed)
+		task->state = TASK_TRACED;
+
 	/*
 	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
 	 * TRAPPING, and kick it so that it transits to TRACED.  TRAPPING
@@ -821,6 +838,8 @@ static int ptrace_resume(struct task_struct *child, long request,
 {
 	bool need_siglock;
 
+	cdh_signal_continue(child);
+
 	if (!valid_signal(data))
 		return -EIO;
 
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

