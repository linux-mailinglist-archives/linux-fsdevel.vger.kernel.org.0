Return-Path: <linux-fsdevel+bounces-69276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E987AC76663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 401B228CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4D31AF3C;
	Thu, 20 Nov 2025 21:42:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73A239E8B;
	Thu, 20 Nov 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674930; cv=none; b=BOswSSwNZCT5VSPay0meYTHO73aQHqzIAAtbasBJZMvkDW3f+NhlJAueZVT/Rmn4nt8aFBWvHxF3x/eKJn+BfZgvvNNTregFf60S8alXJdwekTKHFUnCxo2Jnc7qyjZKsjvtQf7xNoZWTRYJMhQfpqcIOkeZhcOSeWR4yXbm7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674930; c=relaxed/simple;
	bh=xFH6A0g728Dk7eYdvrGoI8hrsMpXegdWlly+ZmhE14c=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=pTE86ASu4xvoMR/8Q5aWfsAKH5hEQkJ5/9+f0g6OftHWRUlX3+dvifI6x7SglJlGYJ0/Z5oS8RdEOWsB6+g6TsrwFPhFRqdC9Op+U9n2AV9AHiZxnNLXW9XbDKSxOIhOQsbZyHvLfaAxVZPa7KGiLALxGtBPZ9OjM1DrBd2ysGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46344)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMBik-00C0Xc-GI; Thu, 20 Nov 2025 13:57:38 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:45204 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMBii-00Bjcg-Ml; Thu, 20 Nov 2025 13:57:38 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Alexey Dobriyan
 <adobriyan@gmail.com>,  Oleg Nesterov <oleg@redhat.com>,  Kees Cook
 <kees@kernel.org>,  Andy Lutomirski <luto@amacapital.net>,  Will Drewry
 <wad@chromium.org>,  Christian Brauner <brauner@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Michal Hocko <mhocko@suse.com>,
  Serge Hallyn <serge@hallyn.com>,  James Morris
 <jamorris@linux.microsoft.com>,  Randy Dunlap <rdunlap@infradead.org>,
  Suren Baghdasaryan <surenb@google.com>,  Yafang Shao
 <laoar.shao@gmail.com>,  Helge Deller <deller@gmx.de>,  Adrian Reber
 <areber@redhat.com>,  Thomas Gleixner <tglx@linutronix.de>,  Jens Axboe
 <axboe@kernel.dk>,  Alexei Starovoitov <ast@kernel.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  linux-security-module@vger.kernel.org,  tiozhang
 <tiozhang@didiglobal.com>,  Luis Chamberlain <mcgrof@kernel.org>,  "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Frederic Weisbecker <frederic@kernel.org>,
  YueHaibing <yuehaibing@huawei.com>,  Paul Moore <paul@paul-moore.com>,
  Aleksa Sarai <cyphar@cyphar.com>,  Stefan Roesch <shr@devkernel.io>,
  Chao Yu <chao@kernel.org>,  xu xin <xu.xin16@zte.com.cn>,  Jeff Layton
 <jlayton@kernel.org>,  Jan Kara <jack@suse.cz>,  David Hildenbrand
 <david@redhat.com>,  Dave Chinner <dchinner@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  Elena Reshetova <elena.reshetova@intel.com>,  David
 Windsor <dwindsor@gmail.com>,  Mateusz Guzik <mjguzik@gmail.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  "Joel Fernandes (Google)"
 <joel@joelfernandes.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Hans Liljestrand <ishkamiel@gmail.com>,  Penglei
 Jiang <superman.xpt@gmail.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Adrian Ratiu <adrian.ratiu@collabora.com>,
  Ingo Molnar <mingo@kernel.org>,  "Peter Zijlstra (Intel)"
 <peterz@infradead.org>,  Cyrill Gorcunov <gorcunov@gmail.com>,  Eric
 Dumazet <edumazet@google.com>
In-Reply-To: <87wm3ky5n9.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Thu, 20 Nov 2025 11:29:14 -0600")
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
Date: Thu, 20 Nov 2025 14:57:29 -0600
Message-ID: <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vMBii-00Bjcg-Ml;;;mid=<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/yI+0jxd75r+xV/noKUQQ5aYKsGTMf/70=
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4998]
	*  1.5 TR_Symld_Words too many words that have symbols inside
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1042 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.5 (0.4%), b_tie_ro: 3.1 (0.3%), parse: 2.3
	(0.2%), extract_message_metadata: 9 (0.8%), get_uri_detail_list: 6
	(0.6%), tests_pri_-2000: 3.7 (0.4%), tests_pri_-1000: 8 (0.7%),
	tests_pri_-950: 1.03 (0.1%), tests_pri_-900: 0.93 (0.1%),
	tests_pri_-90: 94 (9.0%), check_bayes: 93 (8.9%), b_tokenize: 29
	(2.7%), b_tok_get_all: 16 (1.6%), b_comp_prob: 3.9 (0.4%),
	b_tok_touch_all: 41 (3.9%), b_finish: 0.63 (0.1%), tests_pri_0: 903
	(86.6%), check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 2.5
	(0.2%), poll_dns_idle: 1.10 (0.1%), tests_pri_10: 1.72 (0.2%),
	tests_pri_500: 7 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] exec: Move cred computation under exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false


Instead of computing the new cred before we pass the point of no
return compute the new cred just before we use it.

This allows the removal of fs_struct->in_exec and cred_guard_mutex.

I am not certain why we wanted to compute the cred for the new
executable so early.  Perhaps I missed something but I did not see any
common errors being signaled.   So I don't think we loose anything by
computing the new cred later.

We gain a lot.

We stop holding the cred_guard_mutex over places where the code sleeps
and waits for userspace.  These places include the waiting for the
tracer in PTRACE_EVENT_EXIT, "put_user(0, tsk->clear_child_tid)" in
mm_release, and "get_user(futex_offset, ...") in exit_robust_mutex.

We can remove fs_struct->in_exec.  The case where it was used simply
never comes up, when we compute the cred after de_thread completes.

We remove the possibility of a hang between a tracer calling
PTRACE_ATTACH/PTRACE_SIEZE and the kernel waiting for the tracer
in PTRACE_EVENT_EXIT.

---
Oleg, Kees, Bernd, Can you see anything I am missing?

The code compiles but I haven't test it yet.

I thought I was going to move commit_creds before de_thread, but that
would have taken commit_cred out of exec_update_lock (which introduces
races).

However I can't see any drawbacks of going the other direction.


 fs/exec.c                    | 88 ++++++++++++++----------------------
 fs/fs_struct.c               |  1 -
 fs/proc/base.c               |  4 +-
 include/linux/fs_struct.h    |  1 -
 include/linux/sched/signal.h |  6 ---
 init/init_task.c             |  1 -
 kernel/cred.c                |  2 +-
 kernel/fork.c                |  8 +---
 kernel/ptrace.c              |  4 +-
 kernel/seccomp.c             | 12 ++---
 10 files changed, 45 insertions(+), 82 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e08d5d..5ae96584dab0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1090,6 +1090,9 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	perf_event_comm(tsk, exec);
 }
 
+static int prepare_bprm_creds(struct linux_binprm *bprm);
+static void check_unsafe_exec(struct linux_binprm *bprm);
+
 /*
  * Calling this is the point of no return. None of the failures will be
  * seen by userspace since either the process is already taking a fatal
@@ -1101,10 +1104,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
-	/* Once we are committed compute the creds */
-	retval = bprm_creds_from_file(bprm);
-	if (retval)
-		return retval;
 
 	/*
 	 * This tracepoint marks the point before flushing the old exec where
@@ -1123,8 +1122,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	retval = de_thread(me);
 	if (retval)
 		goto out;
-	/* see the comment in check_unsafe_exec() */
-	current->fs->in_exec = 0;
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1251,6 +1248,25 @@ int begin_new_exec(struct linux_binprm * bprm)
 	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
 	flush_signal_handlers(me, 0);
 
+	retval = prepare_bprm_creds(bprm);
+	if (retval)
+		goto out_unlock;
+
+	/*
+	 * Check for unsafe execution states before exec_binprm(), which
+	 * will call back into begin_new_exec(), into bprm_creds_from_file(),
+	 * where setuid-ness is evaluated.
+	 */
+	check_unsafe_exec(bprm);
+
+	/* Set the unchanging part of bprm->cred */
+	retval = security_bprm_creds_for_exec(bprm);
+
+	/* Once we are committed compute the creds */
+	retval = bprm_creds_from_file(bprm);
+	if (retval)
+		goto out_unlock;
+
 	retval = set_cred_ucounts(bprm->cred);
 	if (retval < 0)
 		goto out_unlock;
@@ -1272,9 +1288,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (get_dumpable(me->mm) != SUID_DUMP_USER)
 		perf_event_exit_task(me);
 	/*
-	 * cred_guard_mutex must be held at least to this point to prevent
+	 * exec_update_lock must be held at least to this point to prevent
 	 * ptrace_attach() from altering our determination of the task's
-	 * credentials; any time after this it may be unlocked.
+	 * credentials.
 	 */
 	security_bprm_committed_creds(bprm);
 
@@ -1291,8 +1307,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 out_unlock:
 	up_write(&me->signal->exec_update_lock);
-	if (!bprm->cred)
-		mutex_unlock(&me->signal->cred_guard_mutex);
 
 out:
 	return retval;
@@ -1336,7 +1350,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	me->mm->task_size = TASK_SIZE;
 	up_write(&me->signal->exec_update_lock);
-	mutex_unlock(&me->signal->cred_guard_mutex);
 }
 EXPORT_SYMBOL(setup_new_exec);
 
@@ -1351,21 +1364,15 @@ void finalize_exec(struct linux_binprm *bprm)
 EXPORT_SYMBOL(finalize_exec);
 
 /*
- * Prepare credentials and lock ->cred_guard_mutex.
- * setup_new_exec() commits the new creds and drops the lock.
- * Or, if exec fails before, free_bprm() should release ->cred
- * and unlock.
+ * Prepare credentials.  begin_new_exec() commits the new creds.
+ * Or, if exec fails before, free_bprm() should release ->cred.
  */
 static int prepare_bprm_creds(struct linux_binprm *bprm)
 {
-	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
-		return -ERESTARTNOINTR;
-
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
 
-	mutex_unlock(&current->signal->cred_guard_mutex);
 	return -ENOMEM;
 }
 
@@ -1386,9 +1393,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
-		/* in case exec fails before de_thread() succeeds */
-		current->fs->in_exec = 0;
-		mutex_unlock(&current->signal->cred_guard_mutex);
+		/* in case exec fails before commit_creds succeeds */
 		abort_creds(bprm->cred);
 	}
 	do_close_execat(bprm->file);
@@ -1486,13 +1491,12 @@ EXPORT_SYMBOL(bprm_change_interp);
 
 /*
  * determine how safe it is to execute the proposed program
- * - the caller must hold ->cred_guard_mutex to protect against
+ * - the caller must hold ->exec_update_lock to protect against
  *   PTRACE_ATTACH or seccomp thread-sync
  */
 static void check_unsafe_exec(struct linux_binprm *bprm)
 {
-	struct task_struct *p = current, *t;
-	unsigned n_fs;
+	struct task_struct *p = current;
 
 	if (p->ptrace)
 		bprm->unsafe |= LSM_UNSAFE_PTRACE;
@@ -1509,25 +1513,9 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * suid exec because the differently privileged task
 	 * will be able to manipulate the current directory, etc.
 	 * It would be nice to force an unshare instead...
-	 *
-	 * Otherwise we set fs->in_exec = 1 to deny clone(CLONE_FS)
-	 * from another sub-thread until de_thread() succeeds, this
-	 * state is protected by cred_guard_mutex we hold.
 	 */
-	n_fs = 1;
-	read_seqlock_excl(&p->fs->seq);
-	rcu_read_lock();
-	for_other_threads(p, t) {
-		if (t->fs == p->fs)
-			n_fs++;
-	}
-	rcu_read_unlock();
-
-	/* "users" and "in_exec" locked for copy_fs() */
-	if (p->fs->users > n_fs)
+	if (p->fs->users > 1)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
-	else
-		p->fs->in_exec = 1;
 	read_sequnlock_excl(&p->fs->seq);
 }
 
@@ -1731,25 +1719,15 @@ static int bprm_execve(struct linux_binprm *bprm)
 {
 	int retval;
 
-	retval = prepare_bprm_creds(bprm);
-	if (retval)
-		return retval;
+	if (bprm->is_check)
+		return 0;
 
-	/*
-	 * Check for unsafe execution states before exec_binprm(), which
-	 * will call back into begin_new_exec(), into bprm_creds_from_file(),
-	 * where setuid-ness is evaluated.
-	 */
-	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 	sched_mm_cid_before_execve(current);
 
 	sched_exec();
 
-	/* Set the unchanging part of bprm->cred */
-	retval = security_bprm_creds_for_exec(bprm);
-	if (retval || bprm->is_check)
-		goto out;
+
 
 	retval = exec_binprm(bprm);
 	if (retval < 0)
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 28be762ac1c6..945bc0916f65 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -109,7 +109,6 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	/* We don't need to lock fs - think why ;-) */
 	if (fs) {
 		fs->users = 1;
-		fs->in_exec = 0;
 		seqlock_init(&fs->seq);
 		fs->umask = old->umask;
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6299878e3d97..7041fb4d1689 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2834,14 +2834,14 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	}
 
 	/* Guard against adverse ptrace interaction */
-	rv = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
+	rv = down_write_killable(&current->signal->exec_update_lock);
 	if (rv < 0)
 		goto out_free;
 
 	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
-	mutex_unlock(&current->signal->cred_guard_mutex);
+	up_write(&current->signal->exec_update_lock);
 out_free:
 	kfree(page);
 out:
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index baf200ab5c77..29d0f7d57743 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -10,7 +10,6 @@ struct fs_struct {
 	int users;
 	seqlock_t seq;
 	int umask;
-	int in_exec;
 	struct path root, pwd;
 } __randomize_layout;
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7d6449982822..7e9259c8fb2b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -241,12 +241,6 @@ struct signal_struct {
 	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
 					 * killed by the oom killer */
 
-	struct mutex cred_guard_mutex;	/* guard against foreign influences on
-					 * credential calculations
-					 * (notably. ptrace)
-					 * Deprecated do not use in new code.
-					 * Use exec_update_lock instead.
-					 */
 	struct rw_semaphore exec_update_lock;	/* Held while task_struct is
 						 * being updated during exec,
 						 * and may have inconsistent
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..4813bffe217e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,7 +30,6 @@ static struct signal_struct init_signals = {
 #ifdef CONFIG_CGROUPS
 	.cgroup_threadgroup_rwsem	= __RWSEM_INITIALIZER(init_signals.cgroup_threadgroup_rwsem),
 #endif
-	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
 	.posix_timers		= HLIST_HEAD_INIT,
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..80e376ce005f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -252,7 +252,7 @@ EXPORT_SYMBOL(prepare_creds);
 
 /*
  * Prepare credentials for current to perform an execve()
- * - The caller must hold ->cred_guard_mutex
+ * - The caller must hold ->exec_update_lock
  */
 struct cred *prepare_exec_creds(void)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..996c649b9a4c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1555,11 +1555,6 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
-		/* "users" and "in_exec" locked for check_unsafe_exec() */
-		if (fs->in_exec) {
-			read_sequnlock_excl(&fs->seq);
-			return -EAGAIN;
-		}
 		fs->users++;
 		read_sequnlock_excl(&fs->seq);
 		return 0;
@@ -1699,7 +1694,6 @@ static int copy_signal(u64 clone_flags, struct task_struct *tsk)
 	sig->oom_score_adj = current->signal->oom_score_adj;
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
-	mutex_init(&sig->cred_guard_mutex);
 	init_rwsem(&sig->exec_update_lock);
 
 	return 0;
@@ -1710,7 +1704,7 @@ static void copy_seccomp(struct task_struct *p)
 #ifdef CONFIG_SECCOMP
 	/*
 	 * Must be called with sighand->lock held, which is common to
-	 * all threads in the group. Holding cred_guard_mutex is not
+	 * all threads in the group. Holding exec_update_lock is not
 	 * needed because this new task is not yet running and cannot
 	 * be racing exec.
 	 */
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75a84efad40f..8140d4bfc279 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -444,8 +444,8 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * SUID, SGID and LSM creds get determined differently
 	 * under ptrace.
 	 */
-	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
-			   &task->signal->cred_guard_mutex) {
+	scoped_cond_guard (rwsem_read_intr, return -ERESTARTNOINTR,
+			   &task->signal->exec_update_lock) {
 
 		scoped_guard (task_lock, task) {
 			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 25f62867a16d..87de8d47d876 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -479,7 +479,7 @@ static int is_ancestor(struct seccomp_filter *parent,
 /**
  * seccomp_can_sync_threads: checks if all threads can be synchronized
  *
- * Expects sighand and cred_guard_mutex locks to be held.
+ * Expects sighand and exec_update_lock locks to be held.
  *
  * Returns 0 on success, -ve on error, or the pid of a thread which was
  * either not in the correct seccomp mode or did not have an ancestral
@@ -489,7 +489,7 @@ static inline pid_t seccomp_can_sync_threads(void)
 {
 	struct task_struct *thread, *caller;
 
-	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
+	BUG_ON(!rwsem_is_locked(&current->signal->exec_update_lock));
 	assert_spin_locked(&current->sighand->siglock);
 
 	/* Validate all threads being eligible for synchronization. */
@@ -590,7 +590,7 @@ void seccomp_filter_release(struct task_struct *tsk)
  *
  * @flags: SECCOMP_FILTER_FLAG_* flags to set during sync.
  *
- * Expects sighand and cred_guard_mutex locks to be held, and for
+ * Expects sighand and exec_update_lock locks to be held, and for
  * seccomp_can_sync_threads() to have returned success already
  * without dropping the locks.
  *
@@ -599,7 +599,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
 {
 	struct task_struct *thread, *caller;
 
-	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
+	BUG_ON(!rwsem_is_locked(&current->signal->exec_update_lock));
 	assert_spin_locked(&current->sighand->siglock);
 
 	/*
@@ -2011,7 +2011,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	 * while another thread is in the middle of calling exec.
 	 */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
-	    mutex_lock_killable(&current->signal->cred_guard_mutex))
+	    down_read_killable(&current->signal->exec_update_lock))
 		goto out_put_fd;
 
 	spin_lock_irq(&current->sighand->siglock);
@@ -2034,7 +2034,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
-		mutex_unlock(&current->signal->cred_guard_mutex);
+		up_read(&current->signal->exec_update_lock);
 out_put_fd:
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
 		if (ret) {
-- 
2.41.0


