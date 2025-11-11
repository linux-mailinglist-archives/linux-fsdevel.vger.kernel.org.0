Return-Path: <linux-fsdevel+bounces-67869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FDC4CA4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981694F3379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E562F12BB;
	Tue, 11 Nov 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq/i8hPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72E2EDD72;
	Tue, 11 Nov 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852933; cv=none; b=H+kZANSjTbztwhag3Jq/FnuVwkZ8f77Tk6SNHX6JxN2MpAYlXefW8gEgpmVX+AeU+5felhayazQo8PuORLF6TGPkdWX6T7t89oxCnBYjCgjlxtTheT+fZZKvMh/S4yaKW43tichbnUxFg2GWgMeepqhU6yt25ouABgD0qIOqk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852933; c=relaxed/simple;
	bh=YKxB1Tk0c8PA5NVe6KSLcg4q1RUhiINUvY7b/ZMmRUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg+iqOb2Hbu/X4vfTdGV4HbZTyn6Ut0aPCXzCYA/4IXG2FoAcipgv6G782KoAmvgdZS1MQc7zHeGfVRsU4gjv8RPXI/NFjX41cbFln4B+YFFc2+n2zmKVinCaRNLfw0msQ0Xz04OJjuT6RGk/QbSWlVwMK/2iXLGm6AMBf9YFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq/i8hPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B43C19422;
	Tue, 11 Nov 2025 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762852932;
	bh=YKxB1Tk0c8PA5NVe6KSLcg4q1RUhiINUvY7b/ZMmRUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iq/i8hPWgHTwu435PI+UGZlLN/X3lyfBrrm+1OwNKieirVMDPmDCkCaFA5KX+Cpoo
	 jCY0uq+bKxbfSS/6qRug9ACZVWvSIG2hb05Nfywkq6thFqPc80S2JztzaJqBCtX5TK
	 6ankYgSWSaELPVPWooj+5cT1eMoRBXuIxw8R7wm0f3aC08zRAHgGqQPhTXlh+50TBr
	 zxjneSB775FAK9WKt6FxPW2yAZcqlXQ0OEYW8MPlkyO1msbbTBkJLfLsWoPQX0KMwY
	 2kPRjg5gUXXR3fF2VCX329Z0qynUJi5o5aKfiv7nNQoaN9iGP9xwUFoDOYr6HTaRw8
	 daoW/qmbnCCrQ==
Date: Tue, 11 Nov 2025 10:21:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Bernd Edlinger <bernd.edlinger@hotmail.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>, 
	James Morris <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Adrian Reber <areber@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, tiozhang <tiozhang@didiglobal.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Paulo Alcantara (SUSE)" <pc@manguebit.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
	YueHaibing <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>, 
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, 
	David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Hans Liljestrand <ishkamiel@gmail.com>, 
	Penglei Jiang <superman.xpt@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105143210.GA25535@redhat.com>

On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
> I am still thinking about another approach, will write another email.
> But let me take a closer look at your patch.
> 
> First of all, can you split it? See below.
> 
> On 08/21, Bernd Edlinger wrote:
> >
> > -static int de_thread(struct task_struct *tsk)
> > +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
> >  {
> >  	struct signal_struct *sig = tsk->signal;
> >  	struct sighand_struct *oldsighand = tsk->sighand;
> >  	spinlock_t *lock = &oldsighand->siglock;
> > +	struct task_struct *t;
> > +	bool unsafe_execve_in_progress = false;
> >
> >  	if (thread_group_empty(tsk))
> >  		goto no_thread_group;
> > @@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
> >  	if (!thread_group_leader(tsk))
> >  		sig->notify_count--;
> >
> > +	for_other_threads(tsk, t) {
> > +		if (unlikely(t->ptrace)
> > +		    && (t != tsk->group_leader || !t->exit_state))
> > +			unsafe_execve_in_progress = true;
> 
> you can add "break" into the "if ()" block...
> 
> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
> unconditionally.
> 
> If you really think it makes sense, please make another patch with the
> changelog.
> 
> I'd certainly prefer to avoid this boolean at least for the start. If nothing
> else to catch the potential problems earlier.
> 
> > +	if (unlikely(unsafe_execve_in_progress)) {
> > +		spin_unlock_irq(lock);
> > +		sig->exec_bprm = bprm;
> > +		mutex_unlock(&sig->cred_guard_mutex);
> > +		spin_lock_irq(lock);
> 
> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
> 
> > @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
> >  	 */
> >  	trace_sched_prepare_exec(current, bprm);
> >
> > +	/* If the binary is not readable then enforce mm->dumpable=0 */
> > +	would_dump(bprm, bprm->file);
> > +	if (bprm->have_execfd)
> > +		would_dump(bprm, bprm->executable);
> > +
> > +	/*
> > +	 * Figure out dumpability. Note that this checking only of current
> > +	 * is wrong, but userspace depends on it. This should be testing
> > +	 * bprm->secureexec instead.
> > +	 */
> > +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> > +	    is_dumpability_changed(current_cred(), bprm->cred) ||
> > +	    !(uid_eq(current_euid(), current_uid()) &&
> > +	      gid_eq(current_egid(), current_gid())))
> > +		set_dumpable(bprm->mm, suid_dumpable);
> > +	else
> > +		set_dumpable(bprm->mm, SUID_DUMP_USER);
> > +
> 
> OK, we need to do this before de_thread() drops cred_guard_mutex.
> But imo this too should be done in a separate patch, the changelog should
> explain this change.
> 
> > @@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
> >  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> >  		return -ERESTARTNOINTR;
> >
> > +	if (unlikely(current->signal->exec_bprm)) {
> > +		mutex_unlock(&current->signal->cred_guard_mutex);
> > +		return -ERESTARTNOINTR;
> > +	}
> 
> OK, if signal->exec_bprm != NULL, then current is already killed. But
> proc_pid_attr_write() and ptrace_traceme() do the same. So how about
> something like
> 
> 	int lock_current_cgm(void)
> 	{
> 		if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> 			return -ERESTARTNOINTR;
> 
> 		if (!current->signal->group_exec_task)
> 			return 0;
> 
> 		WARN_ON(!fatal_signal_pending(current));
> 		mutex_unlock(&current->signal->cred_guard_mutex);
> 		return -ERESTARTNOINTR;
> 	}
> 
> ?
> 
> Note that it checks ->group_exec_task, not ->exec_bprm. So this change can
> come in a separate patch too, but I won't insist.
> 
> > @@ -453,6 +454,28 @@ static int ptrace_attach(struct task_struct *task, long request,
> >  				return retval;
> >  		}
> >
> > +		if (unlikely(task == task->signal->group_exec_task)) {
> > +			retval = down_write_killable(&task->signal->exec_update_lock);
> > +			if (retval)
> > +				return retval;
> > +
> > +			scoped_guard (task_lock, task) {
> > +				struct linux_binprm *bprm = task->signal->exec_bprm;
> > +				const struct cred __rcu *old_cred = task->real_cred;
> > +				struct mm_struct *old_mm = task->mm;
> > +
> > +				rcu_assign_pointer(task->real_cred, bprm->cred);
> > +				task->mm = bprm->mm;
> > +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> > +				rcu_assign_pointer(task->real_cred, old_cred);
> > +				task->mm = old_mm;
> > +			}
> 
> This is the most problematic change which I can't review...
> 
> Firstly, it changes task->mm/real_cred for __ptrace_may_access() and this
> looks dangerous to me.

Yeah, that is not ok. This is effectively override_creds for real_cred
and that is not a pattern I want to see us establish at all! Temporary
credential overrides for the subjective credentials is already terrible
but at least we have the explicit split between real_cred and cred
expressely for that. So no, that's not an acceptable solution.

> 
> Say, current_is_single_threaded() called by another CLONE_VM process can
> miss group_exec_task and falsely return true. Probably not that bad, in
> this case old_mm should go away soon, but still...
> 
> And I don't know if this can fool the users of task_cred_xxx/__task_cred
> somehow.
> 
> Or. check_unsafe_exec() sets LSM_UNSAFE_PTRACE if ptrace. Is it safe to
> ptrace the execing task after that? I have no idea what the security hooks
> can do...
> 
> Again, can't review this part.
> 
> Oleg.
> 

