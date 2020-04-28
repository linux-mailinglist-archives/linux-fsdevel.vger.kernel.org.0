Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17BB1BBD76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD1MWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 08:22:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52196 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgD1MWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:22:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPFy-0003Ok-26; Tue, 28 Apr 2020 06:22:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPFx-0001RA-3Z; Tue, 28 Apr 2020 06:22:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
Date:   Tue, 28 Apr 2020 07:19:18 -0500
In-Reply-To: <87sggnajpv.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 07:16:44 -0500")
Message-ID: <87h7x3ajll.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTPFx-0001RA-3Z;;;mid=<87h7x3ajll.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xBeyjONRsiGZZw00Q0+732yg+SgZZji8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 523 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.8%), parse: 0.94 (0.2%),
         extract_message_metadata: 12 (2.2%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 13 (2.5%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 70 (13.4%), check_bayes:
        69 (13.1%), b_tokenize: 11 (2.0%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 42 (8.1%), b_finish: 0.79
        (0.2%), tests_pri_0: 386 (73.9%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.40 (0.1%), tests_pri_10:
        3.6 (0.7%), tests_pri_500: 21 (4.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 2/2] proc: Ensure we see the exit of each process tid exactly once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When the thread group leader changes during exec and the old leaders
thread is reaped proc_flush_pid will flush the dentries for the entire
process because the leader still has it's original pid.

Fix this by exchanging the pids in an rcu safe manner,
and wrapping the code to do that up in a helper exchange_tids.

When I removed switch_exec_pids and introduced this behavior
in d73d65293e3e ("[PATCH] pidhash: kill switch_exec_pids") there
really was nothing that cared as flushing happened with
the cached dentry and de_thread flushed both of them on exec.

This lack of fully exchanging pids became a problem a few months later
when I introduced 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry
flush on exit optimization").  Which overlooked the de_thread case
was no longer swapping pids, and I was looking up proc dentries
by task->pid.

The current behavior isn't properly a bug as everything in proc will
continue to work correctly just a little bit less efficiently.  Fix
this just so there are no little surprise corner cases waiting to bite
people.

-- Oleg points out this could be an issue in next_tgid in proc where
   has_group_leader_pid is called, and reording some of the assignments
   should fix that.

-- Oleg points out this will break the 10 year old hack in __exit_signal.c
>	/*
>	 * This can only happen if the caller is de_thread().
>	 * FIXME: this is the temporary hack, we should teach
>	 * posix-cpu-timers to handle this case correctly.
>	 */
>	if (unlikely(has_group_leader_pid(tsk)))
>		posix_cpu_timers_exit_group(tsk);

The code in next_tgid has been changed to use PIDTYPE_TGID,
and the posix cpu timers code has been fixed so it does not
need the 10 year old hack, so this should be safe to merge
now.

Fixes: 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry flush on exit optimization").
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/exec.c           |  5 +----
 include/linux/pid.h |  1 +
 kernel/pid.c        | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..9b60f927afd7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1186,11 +1186,8 @@ static int de_thread(struct task_struct *tsk)
 
 		/* Become a process group leader with the old leader's pid.
 		 * The old leader becomes a thread of the this thread group.
-		 * Note: The old leader also uses this pid until release_task
-		 *       is called.  Odd but simple and correct.
 		 */
-		tsk->pid = leader->pid;
-		change_pid(tsk, PIDTYPE_PID, task_pid(leader));
+		exchange_tids(tsk, leader);
 		transfer_pid(leader, tsk, PIDTYPE_TGID);
 		transfer_pid(leader, tsk, PIDTYPE_PGID);
 		transfer_pid(leader, tsk, PIDTYPE_SID);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index cc896f0fc4e3..2159ffca63fc 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -102,6 +102,7 @@ extern void attach_pid(struct task_struct *task, enum pid_type);
 extern void detach_pid(struct task_struct *task, enum pid_type);
 extern void change_pid(struct task_struct *task, enum pid_type,
 			struct pid *pid);
+extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index c835b844aca7..6d5d0a5bda82 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -363,6 +363,25 @@ void change_pid(struct task_struct *task, enum pid_type type,
 	attach_pid(task, type);
 }
 
+void exchange_tids(struct task_struct *left, struct task_struct *right)
+{
+	struct pid *pid1 = left->thread_pid;
+	struct pid *pid2 = right->thread_pid;
+	struct hlist_head *head1 = &pid1->tasks[PIDTYPE_PID];
+	struct hlist_head *head2 = &pid2->tasks[PIDTYPE_PID];
+
+	/* Swap the single entry tid lists */
+	hlists_swap_heads_rcu(head1, head2);
+
+	/* Swap the per task_struct pid */
+	rcu_assign_pointer(left->thread_pid, pid2);
+	rcu_assign_pointer(right->thread_pid, pid1);
+
+	/* Swap the cached value */
+	WRITE_ONCE(left->pid, pid_nr(pid2));
+	WRITE_ONCE(right->pid, pid_nr(pid1));
+}
+
 /* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
 void transfer_pid(struct task_struct *old, struct task_struct *new,
 			   enum pid_type type)
-- 
2.20.1

