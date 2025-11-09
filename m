Return-Path: <linux-fsdevel+bounces-67595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A53C443AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D1974E6C2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DD304967;
	Sun,  9 Nov 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+b0gojw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418663002A0
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708569; cv=none; b=a2guYi0WYmO0yMyvEDE52K86MpCbif6xJnduEsjGRYJDgmw1y/gwNEKBuveWdlmYVEjhvDHiUo8xGwrnFLX0Aa5Gt4g6hNBp7tUGD3txwgGXV31XTIFdiISZ95lhdIG/10AtsSW7pXWcjIwVGfnclfg4zTt4tl2ZH/tveR6habs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708569; c=relaxed/simple;
	bh=L6ysw+L+L42xnpW6WvSt4PSj4ekZmlFISdDng/+cCO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KttSR78PC4fdM2hYhHrTqTffn2XKPNqa6H38RledX6KMffC84xwpFf9cXzOSlZjLSdUj0xOgTumg8RLd+j+6HwB+9AvYRFM9Vm/mFoEX4AcfAwsOmenxiNFJ6r+aOFreM1apQQxVHPGLWPGLYW12IuWdBGvUysDcE310OLX9RuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+b0gojw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762708566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJT6y1GDlaasTCIPvbrA0Yxc9LFx5w+afKdTXNnGcpk=;
	b=f+b0gojwB3HoRMR1VLV2oqy77H330K6reoaH0TVPnViH4G+YBXbDbRT167G2R353B6kOVA
	HRKfHCuPDbO/f8krw+MdZIb47+XmldDQhzyKspWwmhCe4SyO2SY994rxD5ALe0RLkSOaG9
	uCbjMTzbASLMfGs+DugDKCrhq/dhz+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-ftEFn_sbMku-0ty6xr4nTQ-1; Sun,
 09 Nov 2025 12:16:01 -0500
X-MC-Unique: ftEFn_sbMku-0ty6xr4nTQ-1
X-Mimecast-MFC-AGG-ID: ftEFn_sbMku-0ty6xr4nTQ_1762708556
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EFD419560A2;
	Sun,  9 Nov 2025 17:15:55 +0000 (UTC)
Received: from fedora (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 60B861800361;
	Sun,  9 Nov 2025 17:15:35 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Nov 2025 18:15:55 +0100 (CET)
Date: Sun, 9 Nov 2025 18:15:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Levin <ldv@strace.io>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRDMNWx-69fL_gf-@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDL3HOB21pMVMWC@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This simple program

    #include <unistd.h>
    #include <signal.h>
    #include <sys/ptrace.h>
    #include <pthread.h>

    void *thread(void *arg)
    {
	    ptrace(PTRACE_TRACEME, 0,0,0);
	    return NULL;
    }

    int main(void)
    {
	    int pid = fork();

	    if (!pid) {
		    pthread_t pt;
		    pthread_create(&pt, NULL, thread, NULL);
		    pthread_join(pt, NULL);
		    execlp("echo", "echo", "passed", NULL);
	    }

	    sleep(1);
	    ptrace(PTRACE_ATTACH, pid, 0,0);
	    kill(pid, SIGCONT);

	    return 0;
    }

hangs because de_thread() waits for debugger which should release the killed
thread with cred_guard_mutex held, while the debugger sleeps waiting for the
same mutex. Not really that bad, the tracer can be killed, but still this is
a bug and people hit it in practice.

With this patch:

	- de_thread() waits until all the sub-threads pass exit_notify() and
	  become zombies.

	- setup_new_exec() waits until all the sub-threads are reaped without
	  cred_guard_mutex held.

	- unshare_sighand() and flush_signal_handlers() are moved from
	  begin_new_exec() to setup_new_exec(), we can't call them until all
	  sub-threads go away.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c       | 140 +++++++++++++++++++++++-------------------------
 kernel/exit.c   |   9 ++--
 kernel/signal.c |   2 +-
 3 files changed, 71 insertions(+), 80 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 136a7ab5d91c..2bac7deb9a98 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -905,42 +905,56 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-static int de_thread(struct task_struct *tsk)
+static int kill_sub_threads(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
-	struct sighand_struct *oldsighand = tsk->sighand;
-	spinlock_t *lock = &oldsighand->siglock;
-
-	if (thread_group_empty(tsk))
-		goto no_thread_group;
+	int err = -EINTR;
 
-	/*
-	 * Kill all other threads in the thread group.
-	 */
-	spin_lock_irq(lock);
-	if ((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task) {
-		/*
-		 * Another group action in progress, just
-		 * return so that the signal is processed.
-		 */
-		spin_unlock_irq(lock);
-		return -EAGAIN;
+	read_lock(&tasklist_lock);
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
+		sig->group_exec_task = tsk;
+		sig->notify_count = -zap_other_threads(tsk);
+		err = 0;
 	}
+	spin_unlock_irq(&tsk->sighand->siglock);
+	read_unlock(&tasklist_lock);
 
-	sig->group_exec_task = tsk;
-	sig->notify_count = zap_other_threads(tsk);
-	if (!thread_group_leader(tsk))
-		sig->notify_count--;
+	return err;
+}
 
-	while (sig->notify_count) {
-		__set_current_state(TASK_KILLABLE);
-		spin_unlock_irq(lock);
-		schedule();
+static int wait_for_notify_count(struct task_struct *tsk)
+{
+	for (;;) {
 		if (__fatal_signal_pending(tsk))
-			goto killed;
-		spin_lock_irq(lock);
+			return -EINTR;
+		set_current_state(TASK_KILLABLE);
+		if (!tsk->signal->notify_count)
+			break;
+		schedule();
 	}
-	spin_unlock_irq(lock);
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void clear_group_exec_task(struct task_struct *tsk)
+{
+	struct signal_struct *sig = tsk->signal;
+
+	/* protects against exit_notify() and __exit_signal() */
+	read_lock(&tasklist_lock);
+	sig->group_exec_task = NULL;
+	sig->notify_count = 0;
+	read_unlock(&tasklist_lock);
+}
+
+static int de_thread(struct task_struct *tsk)
+{
+	if (thread_group_empty(tsk))
+		goto no_thread_group;
+
+	if (kill_sub_threads(tsk) || wait_for_notify_count(tsk))
+		return -EINTR;
 
 	/*
 	 * At this point all other threads have exited, all we have to
@@ -948,26 +962,10 @@ static int de_thread(struct task_struct *tsk)
 	 * and to assume its PID:
 	 */
 	if (!thread_group_leader(tsk)) {
-		struct task_struct *leader = tsk->group_leader;
-
-		for (;;) {
-			cgroup_threadgroup_change_begin(tsk);
-			write_lock_irq(&tasklist_lock);
-			/*
-			 * Do this under tasklist_lock to ensure that
-			 * exit_notify() can't miss ->group_exec_task
-			 */
-			sig->notify_count = -1;
-			if (likely(leader->exit_state))
-				break;
-			__set_current_state(TASK_KILLABLE);
-			write_unlock_irq(&tasklist_lock);
-			cgroup_threadgroup_change_end(tsk);
-			schedule();
-			if (__fatal_signal_pending(tsk))
-				goto killed;
-		}
+		struct task_struct *leader = tsk->group_leader, *t;
 
+		cgroup_threadgroup_change_begin(tsk);
+		write_lock_irq(&tasklist_lock);
 		/*
 		 * The only record we have of the real-time age of a
 		 * process, regardless of execs it's done, is start_time.
@@ -1000,8 +998,8 @@ static int de_thread(struct task_struct *tsk)
 		list_replace_rcu(&leader->tasks, &tsk->tasks);
 		list_replace_init(&leader->sibling, &tsk->sibling);
 
-		tsk->group_leader = tsk;
-		leader->group_leader = tsk;
+		for_each_thread(tsk, t)
+			t->group_leader = tsk;
 
 		tsk->exit_signal = SIGCHLD;
 		leader->exit_signal = -1;
@@ -1021,23 +1019,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
-	sig->group_exec_task = NULL;
-	sig->notify_count = 0;
-
 no_thread_group:
 	/* we have changed execution domain */
 	tsk->exit_signal = SIGCHLD;
-
 	BUG_ON(!thread_group_leader(tsk));
 	return 0;
-
-killed:
-	/* protects against exit_notify() and __exit_signal() */
-	read_lock(&tasklist_lock);
-	sig->group_exec_task = NULL;
-	sig->notify_count = 0;
-	read_unlock(&tasklist_lock);
-	return -EAGAIN;
 }
 
 
@@ -1171,13 +1157,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_itimer_signals();
 #endif
 
-	/*
-	 * Make the signal table private.
-	 */
-	retval = unshare_sighand(me);
-	if (retval)
-		goto out_unlock;
-
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
@@ -1249,7 +1228,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
 	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
-	flush_signal_handlers(me, 0);
 
 	retval = set_cred_ucounts(bprm->cred);
 	if (retval < 0)
@@ -1293,8 +1271,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	up_write(&me->signal->exec_update_lock);
 	if (!bprm->cred)
 		mutex_unlock(&me->signal->cred_guard_mutex);
-
 out:
+	if (me->signal->group_exec_task == me)
+		clear_group_exec_task(me);
 	return retval;
 }
 EXPORT_SYMBOL(begin_new_exec);
@@ -1325,6 +1304,8 @@ int setup_new_exec(struct linux_binprm * bprm)
 {
 	/* Setup things that can depend upon the personality */
 	struct task_struct *me = current;
+	struct signal_struct *sig = me->signal;
+	int err = 0;
 
 	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
 
@@ -1335,10 +1316,23 @@ int setup_new_exec(struct linux_binprm * bprm)
 	 * some architectures like powerpc
 	 */
 	me->mm->task_size = TASK_SIZE;
-	up_write(&me->signal->exec_update_lock);
-	mutex_unlock(&me->signal->cred_guard_mutex);
+	up_write(&sig->exec_update_lock);
+	mutex_unlock(&sig->cred_guard_mutex);
 
-	return 0;
+	if (sig->group_exec_task) {
+		spin_lock_irq(&me->sighand->siglock);
+		sig->notify_count = sig->nr_threads - 1;
+		spin_unlock_irq(&me->sighand->siglock);
+
+		err = wait_for_notify_count(me);
+		clear_group_exec_task(me);
+	}
+
+	if (!err)
+		err = unshare_sighand(me);
+	if (!err)
+		flush_signal_handlers(me, 0);
+	return err;
 }
 EXPORT_SYMBOL(setup_new_exec);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index f041f0c05ebb..bcde78c97253 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -178,10 +178,7 @@ static void __exit_signal(struct release_task_post *post, struct task_struct *ts
 		tty = sig->tty;
 		sig->tty = NULL;
 	} else {
-		/*
-		 * If there is any task waiting for the group exit
-		 * then notify it:
-		 */
+		/* mt-exec, setup_new_exec() -> wait_for_notify_count() */
 		if (sig->notify_count > 0 && !--sig->notify_count)
 			wake_up_process(sig->group_exec_task);
 
@@ -766,8 +763,8 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		list_add(&tsk->ptrace_entry, &dead);
 	}
 
-	/* mt-exec, de_thread() is waiting for group leader */
-	if (unlikely(tsk->signal->notify_count < 0))
+	/* mt-exec, de_thread() -> wait_for_notify_count() */
+	if (tsk->signal->notify_count < 0 && !++tsk->signal->notify_count)
 		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index fe9190d84f28..334212044940 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1343,13 +1343,13 @@ int zap_other_threads(struct task_struct *p)
 
 	for_other_threads(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		count++;
 
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
 		sigaddset(&t->pending.signal, SIGKILL);
 		signal_wake_up(t, 1);
+		count++;
 	}
 
 	return count;
-- 
2.25.1.362.g51ebf55



