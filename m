Return-Path: <linux-fsdevel+bounces-58251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D6B2B862
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D975523F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EF2C2363;
	Tue, 19 Aug 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP8v1DiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CE25A331;
	Tue, 19 Aug 2025 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755578188; cv=none; b=R/jL/1hqLvzOxHo4OgP2eh28x88S8+Kd8odJsIX/qpqAt4cb7ixP1NkreO3BCBhdkHNGuoaKv+mKNWL5FlAYFMA5GEy9qMxN2JqUT8am/FEO3q059Ckeh9+vhKmP3j6PUMONwyzaCDIE58HtMgR26rk4HllJ6rLQkPy3vaUYfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755578188; c=relaxed/simple;
	bh=1oIKRJK5HTQsWAX91rizsH6S8xP04JRAB50afAWQCJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFJvkWY+f1+VCmumxv52Q1nmNdsr+d5de1WUnoc56lMBw160fD1/ukiseveQebQ+43soAvjif2ntt5kAp1xzhiZwR7UXKq0S7jvE3Hc6XTkCwLW39VKTl9aV5cJvlZthhNf9U9X6p20qeQr5HvYzZb5tONu4yPYKaCN8qrD0SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP8v1DiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF514C4CEF4;
	Tue, 19 Aug 2025 04:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755578187;
	bh=1oIKRJK5HTQsWAX91rizsH6S8xP04JRAB50afAWQCJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UP8v1DiL3tOnE7Ki4JlzVuvxNqtSh46rTWE91G7TcgWW5o/+TA49SmxnQ0MspeEeO
	 aRxWTXriwFR1zScWgVM9tAUTbClB1NbFcbGNHShr11ZdTKsHAPlXT1vZdtL2cT2Mkw
	 xQaYeC8Teia1Id6A3SjoeKa81IDKHXtTwp1BqrSOwzekFY8BHdZzNwgPG1QtKn+G/8
	 hfrTmBIWnxvnTJTQbj2/W4EeVLkPM2oefuohIup06aoi6nw7NMVnm8XYYGjwCLURII
	 XoI0M6Xtlst1glypt8p7qBiOOlMVa8TiJl9Ln7i6CY3rLzo02bs4WVDdhQhjVBuFSH
	 iK2FWi6K41M+Q==
Date: Mon, 18 Aug 2025 21:36:27 -0700
From: Kees Cook <kees@kernel.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
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
	Zheng Yejian <zhengyejian1@huawei.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>
Subject: Re: [PATCH v16] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <202508182113.63CF4DA866@keescook>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>

On Mon, Aug 18, 2025 at 10:53:43PM +0200, Bernd Edlinger wrote:
> This introduces signal->exec_bprm, which is used to
> fix the case when at least one of the sibling threads
> is traced, and therefore the trace process may dead-lock
> in ptrace_attach, but de_thread will need to wait for the
> tracer to continue execution.
> 
> The problem happens when a tracer tries to ptrace_attach
> to a multi-threaded process, that does an execve in one of
> the threads at the same time, without doing that in a forked
> sub-process.  That means: There is a race condition, when one
> or more of the threads are already ptraced, but the thread
> that invoked the execve is not yet traced.  Now in this
> case the execve locks the cred_guard_mutex and waits for
> de_thread to complete.  But that waits for the traced
> sibling threads to exit, and those have to wait for the
> tracer to receive the exit signal, but the tracer cannot
> call wait right now, because it is waiting for the ptrace
> call to complete, and this never does not happen.
> The traced process and the tracer are now in a deadlock
> situation, and can only be killed by a fatal signal.
> 
> The solution is to detect this situation and allow
> ptrace_attach to continue by temporarily releasing the
> cred_guard_mutex, while de_thread() is still waiting for
> traced zombies to be eventually released by the tracer.
> In the case of the thread group leader we only have to wait
> for the thread to become a zombie, which may also need
> co-operation from the tracer due to PTRACE_O_TRACEEXIT.
> 
> When a tracer wants to ptrace_attach a task that already
> is in execve, we simply retry the ptrace_may_access
> check while temporarily installing the new credentials
> and dumpability which are about to be used after execve
> completes.  If the ptrace_attach happens on a thread that
> is a sibling-thread of the thread doing execve, it is
> sufficient to check against the old credentials, as this
> thread will be waited for, before the new credentials are
> installed.
> 
> Other threads die quickly since the cred_guard_mutex is
> released, but a deadly signal is already pending.  In case
> the mutex_lock_killable misses the signal, the non-zero
> current->signal->exec_bprm makes sure they release the
> mutex immediately and return with -ERESTARTNOINTR.
> 
> This means there is no API change, unlike the previous
> version of this patch which was discussed here:
> 
> https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/
> 
> See tools/testing/selftests/ptrace/vmaccess.c
> for a test case that gets fixed by this change.
> 
> Note that since the test case was originally designed to
> test the ptrace_attach returning an error in this situation,
> the test expectation needed to be adjusted, to allow the
> API to succeed at the first attempt.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c                                 |  69 ++++++++---
>  fs/proc/base.c                            |   6 +
>  include/linux/cred.h                      |   1 +
>  include/linux/sched/signal.h              |  18 +++
>  kernel/cred.c                             |  30 ++++-
>  kernel/ptrace.c                           |  31 +++++
>  kernel/seccomp.c                          |  12 +-
>  tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
>  8 files changed, 265 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..31c6ceaa5f69 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -905,11 +905,13 @@ static int exec_mmap(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -static int de_thread(struct task_struct *tsk)
> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>  {
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	struct task_struct *t;
> +	bool unsafe_execve_in_progress = false;
>  
>  	if (thread_group_empty(tsk))
>  		goto no_thread_group;
> @@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
>  	if (!thread_group_leader(tsk))
>  		sig->notify_count--;
>  
> +	for_other_threads(tsk, t) {
> +		if (unlikely(t->ptrace)
> +		    && (t != tsk->group_leader || !t->exit_state))
> +			unsafe_execve_in_progress = true;
> +	}
> +
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		spin_unlock_irq(lock);
> +		sig->exec_bprm = bprm;
> +		mutex_unlock(&sig->cred_guard_mutex);
> +		spin_lock_irq(lock);
> +	}
> +

cred_guard_mutex has a comment about it being deprecated and shouldn't
be used in "new code"... Regardless, what cred_guard_mutex is trying to
protect is changing to credentials.

But what we want to stop is having new threads appear, which
spin_lock_irq(lock) should stop, yes?

>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> @@ -1021,6 +1036,11 @@ static int de_thread(struct task_struct *tsk)
>  		release_task(leader);
>  	}
>  
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}
> +
>  	sig->group_exec_task = NULL;
>  	sig->notify_count = 0;
>  
> @@ -1032,6 +1052,11 @@ static int de_thread(struct task_struct *tsk)
>  	return 0;
>  
>  killed:
> +	if (unlikely(unsafe_execve_in_progress)) {
> +		mutex_lock(&sig->cred_guard_mutex);
> +		sig->exec_bprm = NULL;
> +	}

I think we need to document that cred_guard_mutex now protects
sig->exec_bprm.

> +
>  	/* protects against exit_notify() and __exit_signal() */
>  	read_lock(&tasklist_lock);
>  	sig->group_exec_task = NULL;
> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 */
>  	trace_sched_prepare_exec(current, bprm);
>  
> +	/* If the binary is not readable then enforce mm->dumpable=0 */
> +	would_dump(bprm, bprm->file);
> +	if (bprm->have_execfd)
> +		would_dump(bprm, bprm->executable);
> +
> +	/*
> +	 * Figure out dumpability. Note that this checking only of current
> +	 * is wrong, but userspace depends on it. This should be testing
> +	 * bprm->secureexec instead.
> +	 */
> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
> +	    !(uid_eq(current_euid(), current_uid()) &&
> +	      gid_eq(current_egid(), current_gid())))
> +		set_dumpable(bprm->mm, suid_dumpable);
> +	else
> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
> +

Why is this move needed? While it's writing to bprm, I see it's reading
from "current". Is this safe to do before de_thread() has happened?
Can't a sibling thread manipulate things here? What lock am I missing?

>  	/*
>  	 * Ensure all future errors are fatal.
>  	 */
>  	bprm->point_of_no_return = true;
>  
>  	/* Make this the only thread in the thread group */
> -	retval = de_thread(me);
> +	retval = de_thread(me, bprm);
>  	if (retval)
>  		goto out;
>  	/* see the comment in check_unsafe_exec() */
> @@ -1144,11 +1187,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> -	/* If the binary is not readable then enforce mm->dumpable=0 */
> -	would_dump(bprm, bprm->file);
> -	if (bprm->have_execfd)
> -		would_dump(bprm, bprm->executable);
> -
>  	/*
>  	 * Release all of the old mmap stuff
>  	 */
> @@ -1210,18 +1248,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	me->sas_ss_sp = me->sas_ss_size = 0;
>  
> -	/*
> -	 * Figure out dumpability. Note that this checking only of current
> -	 * is wrong, but userspace depends on it. This should be testing
> -	 * bprm->secureexec instead.
> -	 */
> -	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> -	    !(uid_eq(current_euid(), current_uid()) &&
> -	      gid_eq(current_egid(), current_gid())))
> -		set_dumpable(current->mm, suid_dumpable);
> -	else
> -		set_dumpable(current->mm, SUID_DUMP_USER);
> -
>  	perf_event_exec();
>  
>  	/*
> @@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>  		return -ERESTARTNOINTR;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	bprm->cred = prepare_exec_creds();
>  	if (likely(bprm->cred))
>  		return 0;
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 62d35631ba8c..e5bcf812cee0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2838,6 +2838,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		rv = -ERESTARTNOINTR;
> +		goto out_free;
> +	}
> +
>  	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index a102a10f833f..fb0361911489 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
>  extern struct cred *cred_alloc_blank(void);
>  extern struct cred *prepare_creds(void);
>  extern struct cred *prepare_exec_creds(void);
> +extern bool is_dumpability_changed(const struct cred *, const struct cred *);
>  extern int commit_creds(struct cred *);
>  extern void abort_creds(struct cred *);
>  extern struct cred *prepare_kernel_cred(struct task_struct *);
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1ef1edbaaf79..3c47d8b55863 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -237,9 +237,27 @@ struct signal_struct {
>  	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
>  					 * killed by the oom killer */
>  
> +	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
> +					 * against new credentials while
> +					 * de_thread is waiting for other
> +					 * traced threads to terminate.
> +					 * Set while de_thread is executing.
> +					 * The cred_guard_mutex is released
> +					 * after de_thread() has called
> +					 * zap_other_threads(), therefore
> +					 * a fatal signal is guaranteed to be
> +					 * already pending in the unlikely
> +					 * event, that
> +					 * current->signal->exec_bprm happens
> +					 * to be non-zero after the
> +					 * cred_guard_mutex was acquired.
> +					 */
> +
>  	struct mutex cred_guard_mutex;	/* guard against foreign influences on
>  					 * credential calculations
>  					 * (notably. ptrace)
> +					 * Held while execve runs, except when
> +					 * a sibling thread is being traced.
>  					 * Deprecated do not use in new code.
>  					 * Use exec_update_lock instead.
>  					 */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 9676965c0981..0b2822c762df 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>  	return false;
>  }
>  
> +/**
> + * is_dumpability_changed - Will changing creds affect dumpability?
> + * @old: The old credentials.
> + * @new: The new credentials.
> + *
> + * If the @new credentials have no elevated privileges compared to the
> + * @old credentials, the task may remain dumpable.  Otherwise we have
> + * to mark the task as undumpable to avoid information leaks from higher
> + * to lower privilege domains.
> + *
> + * Return: True if the task will become undumpable.
> + */
> +bool is_dumpability_changed(const struct cred *old, const struct cred *new)

This should be "static", I think?

> +{
> +	if (!uid_eq(old->euid, new->euid) ||
> +	    !gid_eq(old->egid, new->egid) ||
> +	    !uid_eq(old->fsuid, new->fsuid) ||
> +	    !gid_eq(old->fsgid, new->fsgid) ||
> +	    !cred_cap_issubset(old, new))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * commit_creds - Install new credentials upon the current task
>   * @new: The credentials to be assigned
> @@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
>  	get_cred(new); /* we will require a ref for the subj creds too */
>  
>  	/* dumpability changes */
> -	if (!uid_eq(old->euid, new->euid) ||
> -	    !gid_eq(old->egid, new->egid) ||
> -	    !uid_eq(old->fsuid, new->fsuid) ||
> -	    !gid_eq(old->fsgid, new->fsgid) ||
> -	    !cred_cap_issubset(old, new)) {
> +	if (is_dumpability_changed(old, new)) {
>  		if (task->mm)
>  			set_dumpable(task->mm, suid_dumpable);
>  		task->pdeath_signal = 0;
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 75a84efad40f..deacdf133f8b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -20,6 +20,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/ptrace.h>
>  #include <linux/security.h>
> +#include <linux/binfmts.h>
>  #include <linux/signal.h>
>  #include <linux/uio.h>
>  #include <linux/audit.h>
> @@ -453,6 +454,27 @@ static int ptrace_attach(struct task_struct *task, long request,
>  				return retval;
>  		}
>  
> +		if (unlikely(task->in_execve)) {

Urgh, we're trying to get rid of this bit too.
https://lore.kernel.org/all/72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp/

Can we find a better indicator?

> +			retval = down_write_killable(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +
> +			scoped_guard (task_lock, task) {
> +				struct linux_binprm *bprm = task->signal->exec_bprm;
> +				const struct cred __rcu *old_cred = task->real_cred;
> +				struct mm_struct *old_mm = task->mm;
> +				rcu_assign_pointer(task->real_cred, bprm->cred);
> +				task->mm = bprm->mm;
> +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +				rcu_assign_pointer(task->real_cred, old_cred);
> +				task->mm = old_mm;
> +			}
> +
> +			up_write(&task->signal->exec_update_lock);
> +			if (retval)
> +				return retval;
> +		}
> +
>  		scoped_guard (write_lock_irq, &tasklist_lock) {
>  			if (unlikely(task->exit_state))
>  				return -EPERM;
> @@ -488,6 +510,14 @@ static int ptrace_traceme(void)
>  {
>  	int ret = -EPERM;
>  
> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> +		return -ERESTARTNOINTR;
> +
> +	if (unlikely(current->signal->exec_bprm)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}

I mention this hunk below...

> +
>  	write_lock_irq(&tasklist_lock);
>  	/* Are we already being traced? */
>  	if (!current->ptrace) {
> @@ -503,6 +533,7 @@ static int ptrace_traceme(void)
>  		}
>  	}
>  	write_unlock_irq(&tasklist_lock);
> +	mutex_unlock(&current->signal->cred_guard_mutex);
>  
>  	return ret;
>  }
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 41aa761c7738..d61fc275235a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1994,9 +1994,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	 * Make sure we cannot change seccomp or nnp state via TSYNC
>  	 * while another thread is in the middle of calling exec.
>  	 */
> -	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> -		goto out_put_fd;
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
> +		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
> +			goto out_put_fd;
> +
> +		if (unlikely(current->signal->exec_bprm)) {
> +			mutex_unlock(&current->signal->cred_guard_mutex);
> +			goto out_put_fd;
> +		}

This updated test and the hunk noted above are _almost_ identical
(interruptible vs killable). Could a helper with a descriptive name be
used here instead? (And does the former hunk need interruptible, or
could it use killable?) I'd just like to avoid having repeated dependent
logic created ("we have to get the lock AND check for exec_bprm") when
something better named than "lock_if_not_racing_exec(...)" could be
used.

> +	}
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  
> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
> index 4db327b44586..5d4a65eb5a8d 100644
> --- a/tools/testing/selftests/ptrace/vmaccess.c
> +++ b/tools/testing/selftests/ptrace/vmaccess.c
> @@ -14,6 +14,7 @@
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sys/ptrace.h>
> +#include <sys/syscall.h>
>  
>  static void *thread(void *arg)
>  {
> @@ -23,7 +24,7 @@ static void *thread(void *arg)
>  
>  TEST(vmaccess)
>  {
> -	int f, pid = fork();
> +	int s, f, pid = fork();
>  	char mm[64];
>  
>  	if (!pid) {
> @@ -31,19 +32,42 @@ TEST(vmaccess)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("true", "true", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
>  	sprintf(mm, "/proc/%d/mem", pid);
> +	/* deadlock did happen here */
>  	f = open(mm, O_RDONLY);
>  	ASSERT_GE(f, 0);
>  	close(f);
> -	f = kill(pid, SIGCONT);
> -	ASSERT_EQ(f, 0);
> +	f = waitpid(-1, &s, WNOHANG);
> +	ASSERT_NE(f, -1);
> +	ASSERT_NE(f, 0);
> +	ASSERT_NE(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	f = waitpid(-1, &s, 0);
> +	ASSERT_EQ(f, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(f, -1);
> +	ASSERT_EQ(errno, ECHILD);
>  }
>  
> -TEST(attach)
> +/*
> + * Same test as previous, except that
> + * we try to ptrace the group leader,
> + * which is about to call execve,
> + * when the other thread is already ptraced.
> + * This exercises the code in de_thread
> + * where it is waiting inside the
> + * while (sig->notify_count) {
> + * loop.
> + */
> +TEST(attach1)
>  {
>  	int s, k, pid = fork();
>  
> @@ -52,19 +76,76 @@ TEST(attach)
>  
>  		pthread_create(&pt, NULL, thread, NULL);
>  		pthread_join(pt, NULL);
> -		execlp("sleep", "sleep", "2", NULL);
> +		execlp("false", "false", NULL);
> +		return;
>  	}
>  
>  	sleep(1);
> +	/* deadlock may happen here */
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(errno, EAGAIN);
> -	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, WNOHANG);
>  	ASSERT_NE(k, -1);
>  	ASSERT_NE(k, 0);
>  	ASSERT_NE(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
>  	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFEXITED(s), 1);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
> +	k = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(errno, ECHILD);
> +}
> +
> +/*
> + * Same test as previous, except that
> + * the group leader is ptraced first,
> + * but this time with PTRACE_O_TRACEEXIT,
> + * and the thread that does execve is
> + * not yet ptraced.  This exercises the
> + * code block in de_thread where the
> + * if (!thread_group_leader(tsk)) {
> + * is executed and enters a wait state.
> + */
> +static long thread2_tid;
> +static void *thread2(void *arg)
> +{
> +	thread2_tid = syscall(__NR_gettid);
> +	sleep(2);
> +	execlp("false", "false", NULL);
> +	return NULL;
> +}
> +
> +TEST(attach2)
> +{
> +	int s, k, pid = fork();
> +
> +	if (!pid) {
> +		pthread_t pt;
> +
> +		pthread_create(&pt, NULL, thread2, NULL);
> +		pthread_join(pt, NULL);
> +		return;
> +	}
> +
>  	sleep(1);
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
> @@ -72,12 +153,46 @@ TEST(attach)
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFSTOPPED(s), 1);
>  	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
> +	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
> +	ASSERT_EQ(k, 0);
> +	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
> +	ASSERT_NE(thread2_tid, -1);
> +	ASSERT_NE(thread2_tid, 0);
> +	ASSERT_NE(thread2_tid, pid);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	sleep(2);
> +	/* deadlock may happen here */
> +	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> +	k = waitpid(-1, &s, WNOHANG);
> +	ASSERT_EQ(k, 0);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, 0);
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
> -	ASSERT_EQ(WEXITSTATUS(s), 0);
> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>  	k = waitpid(-1, NULL, 0);
>  	ASSERT_EQ(k, -1);
>  	ASSERT_EQ(errno, ECHILD);

Thank you for adding tests! This will be a nice deadlock to get fixed.

-Kees

-- 
Kees Cook

