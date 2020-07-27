Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854DE22FB03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgG0VGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 17:06:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42960 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgG0VGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:06:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0AK9-0002Qp-P3; Mon, 27 Jul 2020 15:06:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0AK8-0003Gh-Ej; Mon, 27 Jul 2020 15:06:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-fsdevel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-pm@vger.kernel.org
Date:   Mon, 27 Jul 2020 16:03:11 -0500
Message-ID: <87h7tsllgw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0AK8-0003Gh-Ej;;;mid=<87h7tsllgw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18XJZVsYriqcoy56MYXkT789GfN3SckVAk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 777 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 11 (1.4%), parse: 1.98
        (0.3%), extract_message_metadata: 21 (2.7%), get_uri_detail_list: 7
        (0.9%), tests_pri_-1000: 16 (2.0%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 112 (14.5%), check_bayes:
        111 (14.3%), b_tokenize: 17 (2.1%), b_tok_get_all: 53 (6.8%),
        b_comp_prob: 4.3 (0.5%), b_tok_touch_all: 33 (4.3%), b_finish: 0.77
        (0.1%), tests_pri_0: 598 (77.0%), check_dkim_signature: 0.77 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        1.82 (0.2%), tests_pri_500: 5 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Many of the challenges of implementing a simple version of exec come
from the fact the code handles execing multi-thread processes.

To the best of my knowledge processes with more than one thread
calling exec are not common, and as all of the threads will be killed
by exec there does not appear to be any useful work a thread can
reliably do during exec.

Therefore make it simpler to get exec correct by freezing the other
threads at the beginning of exec.  This removes an entire class of
races, and makes it tractable to fix some of the long standing
issues with exec.

One issue that this change makes it easier to solve is the issue of
deailing with the file table.  Today exec unshares the file table at
the beginning to ensure there are no weird races with file
descriptors.  Unfortunately this unsharing can unshare the file table
when only threads of the current process share it.  Which results in
unnecessary unsharing and posix locks being inappropriately dropped by
a multi-threaded exec.  With all of the threads frozen the thread
count is stable and it is easy to tell if the if the file table really
needs to be unshared by exec.

Further this changes allows seccomp to stop taking cred_guard_mutex,
as the seccomp code takes cred_guard_mutex to protect against another
thread that is in the middle of calling exec and this change
guarantees that if one threads is calling exec all of the other threads
have stopped running.  So this problematic kind of concurrency between
threads can no longer happen.

As this change reuses the generic freezer code interactions with
signal group stop, ptrace stop, the cgroup freezer, fatal signals, and
SIGCONT are already well defined and inherited from the freezer code.
In short other threads will not wake up to participate in signal group
stop, ptrace stop, the cgroup freezer, to handle fatal signals.  As
SIGCONT is handled by the caller that is still processed as usual.
Fatal signals while not processed by other threads are still processed
by the thread calling exec so they take effect as usual.

The code in de_thread was modified to unfreeze the threads at the same
time as it is killing them ensuring that code continues to work as it
does today, and without introducing any races where a thread might
perform any problematic work in the middle of de_thread.

The code in fork is optimized to set TIF_SIGPENDING if the new task
needs to freeze.  This makes it more likely that a new task will
freeze immediately instead of proceeding to userspace to execute some
code, where the next freezing loop will need to tell it to freeze.

A new function exec_freezing is added and called from the refrigerator
so that the freezer code will actually ensure threads called from
exec are frozen as well.

A new function exec_freeze_threads based upon
kernel/power/process.c:try_to_freeze_tasks is added.  To play well
with other uses of the kernel freezer it uses a killable sleep wrapped
with freezer_do_not_count/freezer_count.  So that it will not lock out
the global freezer when it is simply waiting for it's threads to
freeze.  This new function also ensures that only one thread of a
thread group can enter exec at a time.

While this does now allow every process to touch system_freezing_cnt
which is an int.  This should be fine as the maximum number of tasks
is PID_MAX_LIMIT which has an upper bound of 4 * 1024 * 1024.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 99 +++++++++++++++++++++++++++++++++++-
 include/linux/sched/signal.h | 10 ++++
 kernel/fork.c                |  3 ++
 kernel/freezer.c             |  2 +-
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3698252719a3..cce6b700c3bb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/freezer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1145,6 +1146,94 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
+static void unfreeze_threads(struct signal_struct *signal)
+{
+	if (signal->group_execing_task) {
+		signal->group_execing_task = NULL;
+		atomic_dec(&system_freezing_cnt);
+	}
+}
+
+/*
+ * Freeze all other threads in the group for exec
+ */
+static int exec_freeze_threads(void)
+{
+	struct task_struct *p = current, *t;
+	struct signal_struct *signal = p->signal;
+	spinlock_t *lock = &p->sighand->siglock;
+	unsigned long sleep = msecs_to_jiffies(1);
+	unsigned int todo;
+	int ret;
+
+	if (thread_group_empty(p))
+		return 0;
+
+	spin_lock_irq(lock);
+	if (signal_pending(p) || signal_group_exit(signal) ||
+	    signal->group_execing_task) {
+		spin_unlock(lock);
+		return -ERESTARTNOINTR;
+	}
+
+	signal->group_execing_task = p;
+	atomic_inc(&system_freezing_cnt);
+	for (;;) {
+		todo = 0;
+		__for_each_thread(signal, t) {
+			if ((t == p) || !freeze_task(p))
+				continue;
+
+			if (!freezer_should_skip(p))
+				todo++;
+		}
+
+		if (!todo || __fatal_signal_pending(p) ||
+		    (sleep > msecs_to_jiffies(8)))
+			break;
+
+		/*
+		 * We need to retry, but first give the freezing tasks some
+		 * time to enter the refrigerator.  Start with an initial
+		 * 1 ms sleep followed by exponential backoff until 8 ms.
+		 */
+		spin_unlock_irq(lock);
+
+		freezer_do_not_count();
+		schedule_timeout_killable(sleep);
+		freezer_count();
+		sleep *= 2;
+
+		spin_lock_irq(lock);
+	}
+	ret = 0;
+	if (todo)
+		ret = -EBUSY;
+	if (__fatal_signal_pending(p))
+		ret = -ERESTARTNOINTR;
+	if (ret)
+		unfreeze_threads(signal);
+	spin_unlock_irq(lock);
+	return ret;
+}
+
+static void exec_thaw_threads(void)
+{
+	struct task_struct *p = current, *t;
+	struct signal_struct *signal = p->signal;
+	spinlock_t *lock = &p->sighand->siglock;
+
+	spin_lock_irq(lock);
+	if (signal->group_execing_task) {
+		unfreeze_threads(signal);
+		__for_each_thread(signal, t) {
+			if (t != p)
+				__thaw_task(t);
+		}
+	}
+	spin_unlock_irq(lock);
+}
+
 static int de_thread(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
@@ -1167,6 +1256,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
+	unfreeze_threads(sig);
 	sig->group_exit_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
@@ -1885,10 +1975,15 @@ static int bprm_execve(struct linux_binprm *bprm,
 	struct files_struct *displaced;
 	int retval;
 
-	retval = unshare_files(&displaced);
+	/* If the process is multi-threaded stop the other threads */
+	retval = exec_freeze_threads();
 	if (retval)
 		return retval;
 
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out_ret;
+
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
 		goto out_files;
@@ -1949,6 +2044,8 @@ static int bprm_execve(struct linux_binprm *bprm,
 out_files:
 	if (displaced)
 		reset_files_struct(displaced);
+out_ret:
+	exec_thaw_threads();
 
 	return retval;
 }
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1bad18a1d8ba..bbf53fcd913b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -106,6 +106,9 @@ struct signal_struct {
 	int			notify_count;
 	struct task_struct	*group_exit_task;
 
+	/* Task that is performing exec */
+	struct task_struct	*group_execing_task;
+
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
 	unsigned int		flags; /* see SIGNAL_* flags below */
@@ -269,6 +272,13 @@ static inline int signal_group_exit(const struct signal_struct *sig)
 		(sig->group_exit_task != NULL);
 }
 
+static inline bool exec_freezing(struct task_struct *p)
+{
+	struct task_struct *execing = READ_ONCE(p->signal->group_execing_task);
+
+	return execing && (execing != p);
+}
+
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
diff --git a/kernel/fork.c b/kernel/fork.c
index bf215af7a904..d3a0f914231c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2299,6 +2299,9 @@ static __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
+	/* Ensure a process that should freeze exits on the slow path */
+	if (freezing(p))
+		set_tsk_thread_flag(p, TIF_SIGPENDING);
 	proc_fork_connector(p);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..97c6f69b832e 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -42,7 +42,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (test_tsk_thread_flag(p, TIF_MEMDIE))
 		return false;
 
-	if (pm_nosig_freezing || cgroup_freezing(p))
+	if (pm_nosig_freezing || cgroup_freezing(p) || exec_freezing(p))
 		return true;
 
 	if (pm_freezing && !(p->flags & PF_KTHREAD))
-- 
2.25.0


