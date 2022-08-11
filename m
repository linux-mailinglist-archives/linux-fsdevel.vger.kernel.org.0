Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E859060E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiHKRnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiHKRns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:43:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE4792F0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 10:43:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso154685287b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=JwCtX3H6nms0PlfLhp/gNy4lWyXGbhPmKBMEgPVPK5U=;
        b=tPYw9ijUkd/XmrDWQddq9WhxVgKKWtUTUi8gfSzp8mvF1SxkeiqRo930vkpXTR4Pfy
         XKb8US/4PA17ySIZp0GJuCvvMYcAQ8YXhJ/YiupwcucfMN1A5+pLsaeXbdN10VOlQw6K
         V835Hx9nGPVIB/oShy2adWvzV0isHn8Zso0pYql8tUSqXkkGzENyyak+f6hFcqqwExuf
         k7Bqk0xcUW5tZWk4o4jNL+DDYGdIjtkMJKfC8LpUR/rsxg+WvQeD5LO/AsCmh9X4uIDN
         uPfLHesYOAynXSlB0mKvTB5kk3hdB+LXjYuiqFFlqDzseY8CZd6WxaphK9NOLx3lCrh3
         0h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=JwCtX3H6nms0PlfLhp/gNy4lWyXGbhPmKBMEgPVPK5U=;
        b=iED3YS8HlFGnIAefDFFz9UghKf1SvlIb4ZIna0CJjP0Zau/2x8/9/0wsmmfzuT+opw
         9FwbnPDnGL2VY9lo1/cmqWozV3eef3jV3yBs6mVjeHQWsxiI3w+Ig+cPuVWzUNRAR2PX
         NhjDepyOVjTrH84x45IQ3nfrSXU3z+8Z7psLwIC2kCfB2A6JuH4GZKFAL33dixmwocWF
         CnLB1746TMk8eVM5da8dLKThaDR7mg0q+6yquA2h7q6FyelLQRsY6f6NGPlz8HGfsNQE
         jNhgp2ZbdjAuYI9eMlUG+PdEQcJT7r3G89Vr9bCgC5Cn4ZsaTd117BmicgeS/M36yR72
         DGDg==
X-Gm-Message-State: ACgBeo1cVcoMmU5NDzHU5Pf4+cEheqFJlBZhIwFTyrxu1ZFVOYeGbHmW
        /MpNtxiu47rNu+8L1InvZ/M85diNfS8=
X-Google-Smtp-Source: AA6agR7Cswb/IDFwgM6iCMznMfLJ7BnBZwfFd+jFF6PraOi7i3vGuZUvUJ2MbvI9iOFvwqVDmYqUSLo7NIQ=
X-Received: from fmayer.svl.corp.google.com ([2620:15c:2ce:200:8736:2c19:630b:7991])
 (user=fmayer job=sendgmr) by 2002:a81:71c6:0:b0:318:38d5:37f3 with SMTP id
 m189-20020a8171c6000000b0031838d537f3mr344963ywc.268.1660239826342; Thu, 11
 Aug 2022 10:43:46 -0700 (PDT)
Date:   Thu, 11 Aug 2022 10:43:34 -0700
Message-Id: <20220811174334.292259-1-fmayer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] Add sicode to /proc/<PID>/stat.
From:   Florian Mayer <fmayer@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Florian Mayer <fmayer@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to enable additional debugging features, Android init needs a
way to distinguish MTE-related SEGVs (with si_code of SEGV_MTEAERR)
from other SEGVs. This is not possible with current APIs, neither by
the existing information in /proc/<pid>/stat, nor via waitpid.

Tested with the following program

int main(int argc, char** argv) {
  int pid = fork();
  if (!pid) {
    if (strcmp(argv[1], "sigqueue") == 0) {
    union sigval value;
    value.sival_int = 0;
    sigqueue(getpid(), SIGSEGV, value);
    } else if (strcmp(argv[1], "raise") == 0) {
     raise(SIGSEGV);
    } else if (strcmp(argv[1], "kill") == 0) {
      kill(getpid(), SIGSEGV);
    } else if (strcmp(argv[1], "raisestop") == 0) {
      raise(SIGSTOP);
    } else if (strcmp(argv[1], "crash") == 0) {
      volatile int* x = (int*)(0x23);
      *x = 1;
    } else if (strcmp(argv[1], "mte") == 0) {
      volatile char* y = malloc(1);
      y += 100;
      *y = 1;
    }
  } else {
    printf("%d\n", pid);
    sleep(5);
    char buf[1024];
    sprintf(buf, "/proc/%d/stat", pid);
    int fd = open(buf, O_RDONLY);
    char statb[1024];
    read(fd, statb, sizeof(statb));
    printf("%s\n", statb);
  }
}

Signed-off-by: Florian Mayer <fmayer@google.com>
---
 Documentation/filesystems/proc.rst |  2 ++
 fs/coredump.c                      | 17 ++++++++++-------
 fs/proc/array.c                    | 12 ++++++++----
 include/linux/sched/signal.h       |  1 +
 include/linux/sched/task.h         |  2 +-
 kernel/exit.c                      |  5 +++--
 kernel/pid_namespace.c             |  4 +++-
 kernel/signal.c                    | 29 +++++++++++++++++++----------
 8 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..12ad5ecd7434 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -381,6 +381,8 @@ It's slow but very precise.
   env_end       address below which program environment is placed
   exit_code     the thread's exit_code in the form reported by the waitpid
 		system call
+  exit_sicode   if the process was stopped or terminated by a signal, the
+		signal's si_code. 0 otherwise
   ============= ===============================================================
 
 The /proc/PID/maps file contains the currently mapped memory regions and
diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..61e9f27d2bf8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -349,7 +349,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	return ispipe;
 }
 
-static int zap_process(struct task_struct *start, int exit_code)
+static int zap_process(struct task_struct *start, int exit_code, int sicode)
 {
 	struct task_struct *t;
 	int nr = 0;
@@ -357,6 +357,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	/* ignore all signals except SIGKILL, see prepare_signal() */
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_exit_code = exit_code;
+	start->signal->group_exit_sicode = sicode;
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
@@ -371,8 +372,8 @@ static int zap_process(struct task_struct *start, int exit_code)
 	return nr;
 }
 
-static int zap_threads(struct task_struct *tsk,
-			struct core_state *core_state, int exit_code)
+static int zap_threads(struct task_struct *tsk, struct core_state *core_state,
+		       int exit_code, int sicode)
 {
 	struct signal_struct *signal = tsk->signal;
 	int nr = -EAGAIN;
@@ -380,7 +381,7 @@ static int zap_threads(struct task_struct *tsk,
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
 		signal->core_state = core_state;
-		nr = zap_process(tsk, exit_code);
+		nr = zap_process(tsk, exit_code, sicode);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
 		atomic_set(&core_state->nr_threads, nr);
@@ -389,7 +390,8 @@ static int zap_threads(struct task_struct *tsk,
 	return nr;
 }
 
-static int coredump_wait(int exit_code, struct core_state *core_state)
+static int coredump_wait(int exit_code, int sicode,
+			 struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
 	int core_waiters = -EBUSY;
@@ -398,7 +400,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	core_state->dumper.task = tsk;
 	core_state->dumper.next = NULL;
 
-	core_waiters = zap_threads(tsk, core_state, exit_code);
+	core_waiters = zap_threads(tsk, core_state, exit_code, sicode);
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
@@ -560,7 +562,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		need_suid_safe = true;
 	}
 
-	retval = coredump_wait(siginfo->si_signo, &core_state);
+	retval =
+		coredump_wait(siginfo->si_signo, siginfo->si_code, &core_state);
 	if (retval < 0)
 		goto fail_creds;
 
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 99fcbfda8e25..23553460627c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -474,6 +474,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long rsslim = 0;
 	unsigned long flags;
 	int exit_code = task->exit_code;
+	int exit_sicode = 0;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -538,8 +539,10 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
 
-			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
+			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED)) {
 				exit_code = sig->group_exit_code;
+				exit_sicode = sig->group_exit_sicode;
+			}
 		}
 
 		sid = task_session_nr_ns(task, ns);
@@ -638,10 +641,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	} else
 		seq_puts(m, " 0 0 0 0 0 0 0");
 
-	if (permitted)
+	if (permitted) {
 		seq_put_decimal_ll(m, " ", exit_code);
-	else
-		seq_puts(m, " 0");
+		seq_put_decimal_ll(m, " ", exit_sicode);
+	} else
+		seq_puts(m, " 0 0");
 
 	seq_putc(m, '\n');
 	if (mm)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cafbe03eed01..1631dba7a7db 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -109,6 +109,7 @@ struct signal_struct {
 
 	/* thread group exit support */
 	int			group_exit_code;
+	int			group_exit_sicode;
 	/* notify group_exec_task when notify_count is less or equal to 0 */
 	int			notify_count;
 	struct task_struct	*group_exec_task;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 81cab4b01edc..6ff4825fc88a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -82,7 +82,7 @@ static inline void exit_thread(struct task_struct *tsk)
 {
 }
 #endif
-extern __noreturn void do_group_exit(int);
+extern __noreturn void do_group_exit(int,int);
 
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b24f79e..278469d13433 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -897,7 +897,7 @@ SYSCALL_DEFINE1(exit, int, error_code)
  * as well as by sys_exit_group (below).
  */
 void __noreturn
-do_group_exit(int exit_code)
+do_group_exit(int exit_code, int sicode)
 {
 	struct signal_struct *sig = current->signal;
 
@@ -916,6 +916,7 @@ do_group_exit(int exit_code)
 			exit_code = 0;
 		else {
 			sig->group_exit_code = exit_code;
+			sig->group_exit_sicode = sicode;
 			sig->flags = SIGNAL_GROUP_EXIT;
 			zap_other_threads(current);
 		}
@@ -933,7 +934,7 @@ do_group_exit(int exit_code)
  */
 SYSCALL_DEFINE1(exit_group, int, error_code)
 {
-	do_group_exit((error_code & 0xff) << 8);
+	do_group_exit((error_code & 0xff) << 8, 0);
 	/* NOTREACHED */
 	return 0;
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..c80db136726d 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -248,8 +248,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	if (pid_ns->reboot)
+	if (pid_ns->reboot) {
 		current->signal->group_exit_code = pid_ns->reboot;
+		current->signal->group_exit_sicode = 0;
+	}
 
 	acct_exit_ns(pid_ns);
 	return;
diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda5e432..180310a9171c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -963,6 +963,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 			signal_set_stop_flags(signal, why | SIGNAL_STOP_CONTINUED);
 			signal->group_stop_count = 0;
 			signal->group_exit_code = 0;
+			signal->group_exit_sicode = 0;
 		}
 	}
 
@@ -994,7 +995,8 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
-static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
+static void complete_signal(int sig, int code, struct task_struct *p,
+			    enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
 	struct task_struct *t;
@@ -1051,6 +1053,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			 */
 			signal->flags = SIGNAL_GROUP_EXIT;
 			signal->group_exit_code = sig;
+			signal->group_exit_sicode = code;
 			signal->group_stop_count = 0;
 			t = p;
 			do {
@@ -1082,6 +1085,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	struct sigqueue *q;
 	int override_rlimit;
 	int ret = 0, result;
+	int code = 0;
 
 	lockdep_assert_held(&t->sighand->siglock);
 
@@ -1129,7 +1133,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
-			q->info.si_code = SI_USER;
+			code = q->info.si_code = SI_USER;
 			q->info.si_pid = task_tgid_nr_ns(current,
 							task_active_pid_ns(t));
 			rcu_read_lock();
@@ -1142,12 +1146,13 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
-			q->info.si_code = SI_KERNEL;
+			code = q->info.si_code = SI_KERNEL;
 			q->info.si_pid = 0;
 			q->info.si_uid = 0;
 			break;
 		default:
 			copy_siginfo(&q->info, info);
+			code = info->si_code;
 			break;
 		}
 	} else if (!is_si_special(info) &&
@@ -1186,7 +1191,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 		}
 	}
 
-	complete_signal(sig, t, type);
+	complete_signal(sig, code, t, type);
 ret:
 	trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
 	return ret;
@@ -1960,6 +1965,7 @@ void sigqueue_free(struct sigqueue *q)
 int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 {
 	int sig = q->info.si_signo;
+	int code = q->info.si_code;
 	struct sigpending *pending;
 	struct task_struct *t;
 	unsigned long flags;
@@ -1995,7 +2001,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
 	list_add_tail(&q->list, &pending->list);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type);
+	complete_signal(sig, code, t, type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
 	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
@@ -2380,7 +2386,7 @@ int ptrace_notify(int exit_code, unsigned long message)
  * %false if group stop is already cancelled or ptrace trap is scheduled.
  * %true if participated in group stop.
  */
-static bool do_signal_stop(int signr)
+static bool do_signal_stop(int signr, int sicode)
 	__releases(&current->sighand->siglock)
 {
 	struct signal_struct *sig = current->signal;
@@ -2415,8 +2421,10 @@ static bool do_signal_stop(int signr)
 		 * an intervening stop signal is required to cause two
 		 * continued events regardless of ptrace.
 		 */
-		if (!(sig->flags & SIGNAL_STOP_STOPPED))
+		if (!(sig->flags & SIGNAL_STOP_STOPPED)) {
 			sig->group_exit_code = signr;
+			sig->group_exit_sicode = sicode;
+		}
 
 		sig->group_stop_count = 0;
 
@@ -2701,7 +2709,7 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		if (unlikely(current->jobctl & JOBCTL_STOP_PENDING) &&
-		    do_signal_stop(0))
+		    do_signal_stop(0, 0))
 			goto relock;
 
 		if (unlikely(current->jobctl &
@@ -2806,7 +2814,8 @@ bool get_signal(struct ksignal *ksig)
 				spin_lock_irq(&sighand->siglock);
 			}
 
-			if (likely(do_signal_stop(ksig->info.si_signo))) {
+			if (likely(do_signal_stop(ksig->info.si_signo,
+						  ksig->info.si_code))) {
 				/* It released the siglock.  */
 				goto relock;
 			}
@@ -2854,7 +2863,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(ksig->info.si_signo);
+		do_group_exit(ksig->info.si_signo, ksig->info.si_code);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.37.1.559.g78731f0fdb-goog

