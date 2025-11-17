Return-Path: <linux-fsdevel+bounces-68743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EFC64D0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54B0D362EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF133B97B;
	Mon, 17 Nov 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOB9Ng97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEB336EE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391738; cv=none; b=LObNIAGQZFQNzhQ5mdzSfuO6Gkmp5YcozCsQeuYHZow5NQ1mIiakSH3xKfQ8e+W3RDeJPyl/HZXs4X8HGJ59BL93wzSz9oMQEw3RN3WKAPV3Yp49UodaQidZ8tIy9zgNaxLpZLkxUBtReIuAvhyYcakYcyfG9miBnFrg0nUzuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391738; c=relaxed/simple;
	bh=V6fHlz8HT9iaeRZe6Hts1U21hfu7/7IRpYz4JuQDFPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlEnyfDUd01zQuYEffjwcoakw7kUve2YtdoWlncsUb6F6HhHmUrUpFk2lvki/60y1vRuzAhMQFIGJWIBGx/+hev6HUOEko9u6Xeweu8Dg5YFwzd3jx2jx1WXBQNC4HZMggxOZyKkEffZen7ZwtdmxggHL9OSiliMLeUYPMM7ZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOB9Ng97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763391735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+H138e7y6HCsaCtaTqIGyoW1ghuauULhTt5/nDa2Fg=;
	b=jOB9Ng97HRERKBKsNC3DPpkEVVXa7vLdg2e3bY/D276d957mATbk2YAYzoDitVYSbS88Bo
	Bd4pBaynITr1Rk+VzlRoKmavL6rt6BVzMYs37LMGK/VTf0nC7NiDlYBWnMSQ5cELiwyMZR
	P6fNXTJu2kIgBqJtJ2zIwIqpaa5oWrg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-EAqHuR5uO7aiC1gWSDGuug-1; Mon,
 17 Nov 2025 10:02:09 -0500
X-MC-Unique: EAqHuR5uO7aiC1gWSDGuug-1
X-Mimecast-MFC-AGG-ID: EAqHuR5uO7aiC1gWSDGuug_1763391715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63997180123A;
	Mon, 17 Nov 2025 15:01:53 +0000 (UTC)
Received: from fedora (unknown [10.44.32.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E78D13003776;
	Mon, 17 Nov 2025 15:01:34 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 17 Nov 2025 16:01:52 +0100 (CET)
Date: Mon, 17 Nov 2025 16:01:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
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
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <aRs4zYDhddBQFiXZ@redhat.com>
References: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/17, Bernd Edlinger wrote:
>
> On 11/11/25 10:21, Christian Brauner wrote:
> > On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
>
> >> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
> >> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
> >> unconditionally.
> >>
>
> I would not like to drop the mutex when no absolutely necessary for performance reasons.

OK, I won't insist... But I don't really understand how this can help to
improve the performance. If nothing else, this adds another for_other_threads()
loop.

And again, the unsafe_execve_in_progress == T case is unlikely. I'm afraid this
case (de_thread() without cred_guard_mutex) won't have enough testing.

In any case, why you dislike the suggestion to add this unsafe_execve_in_progress
logic in a separate patch?

> >>> +	if (unlikely(unsafe_execve_in_progress)) {
> >>> +		spin_unlock_irq(lock);
> >>> +		sig->exec_bprm = bprm;
> >>> +		mutex_unlock(&sig->cred_guard_mutex);
> >>> +		spin_lock_irq(lock);
> >>
> >> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
> >>
>
> Since the spin lock was acquired while holding the mutex, both should be
> unlocked in reverse sequence and the spin lock re-acquired after releasing
> the mutex.

Why?

> I'd expect the scheduler to do a task switch after the cred_guard_mutex is
> unlocked, at least in the RT-linux variant, while the spin lock is not yet
> unlocked.

I must have missed something, but I still don't understand why this would
be wrong...

> >>> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
> >>>  	 */
> >>>  	trace_sched_prepare_exec(current, bprm);
> >>>
> >>> +	/* If the binary is not readable then enforce mm->dumpable=0 */
> >>> +	would_dump(bprm, bprm->file);
> >>> +	if (bprm->have_execfd)
> >>> +		would_dump(bprm, bprm->executable);
> >>> +
> >>> +	/*
> >>> +	 * Figure out dumpability. Note that this checking only of current
> >>> +	 * is wrong, but userspace depends on it. This should be testing
> >>> +	 * bprm->secureexec instead.
> >>> +	 */
> >>> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> >>> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
> >>> +	    !(uid_eq(current_euid(), current_uid()) &&
> >>> +	      gid_eq(current_egid(), current_gid())))
> >>> +		set_dumpable(bprm->mm, suid_dumpable);
> >>> +	else
> >>> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
> >>> +
> >>
> >> OK, we need to do this before de_thread() drops cred_guard_mutex.
> >> But imo this too should be done in a separate patch, the changelog should
> >> explain this change.
> >>
>
> The dumpability need to be determined before de_thread, because ptrace_may_access
> needs this information to determine if the tracer is allowed to ptrace. That is
> part of the core of the patch, it would not work without that.

Yes,

> I will add more comments to make that more easy to understand.

But again, why this change can't come in a separate patch? Before the patch which
drops cred_guard_mutex in de_thread().

> >> 	int lock_current_cgm(void)
> >> 	{
> >> 		if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> >> 			return -ERESTARTNOINTR;
> >>
> >> 		if (!current->signal->group_exec_task)
> >> 			return 0;
> >>
> >> 		WARN_ON(!fatal_signal_pending(current));
> >> 		mutex_unlock(&current->signal->cred_guard_mutex);
> >> 		return -ERESTARTNOINTR;
> >> 	}
> >>
> >> ?
> >>
>
> Some use mutex_lock_interruptible and some use mutex_lock_killable here,
> so it wont work for all of them.  I would not consider this a new kind
> of dead-lock free mutex, but just an open-coded state machine, handling
> the state that the tasks have whild de_thread is running.

OK. and we don't have mutex_lock_state(). I think that all users could
use mutex_lock_killable(), but you are right anyway, and this is minor.

> >> Note that it checks ->group_exec_task, not ->exec_bprm. So this change can
> >> come in a separate patch too, but I won't insist.

Yes. Although this is minor too ;)

> >> This is the most problematic change which I can't review...
> >>
> >> Firstly, it changes task->mm/real_cred for __ptrace_may_access() and this
> >> looks dangerous to me.
> >
> > Yeah, that is not ok. This is effectively override_creds for real_cred
> > and that is not a pattern I want to see us establish at all! Temporary
> > credential overrides for the subjective credentials is already terrible
> > but at least we have the explicit split between real_cred and cred
> > expressely for that. So no, that's not an acceptable solution.
> >
>
> Okay I understand your point.
> I did this originally just to avoid to have to change the interface to all
> the security engines, but instead I could add a flag PTRACE_MODE_BPRMCREDS to
> the ptrace_may_access which must be handled in all security engines, to use
> child->signal->exec_bprm->creds instead of __task_cred(child).

Can't comment... I don't understand your idea, but this is my fault. I guess
this needs more changes, in particular __ptrace_may_access_mm_cred(), but
most probably I misunderstood your idea.

>
> >> Or. check_unsafe_exec() sets LSM_UNSAFE_PTRACE if ptrace. Is it safe to
> >> ptrace the execing task after that? I have no idea what the security hooks
> >> can do...
>
> That means the tracee is already ptraced before the execve, and SUID-bits
> do not work as usual, and are more or less ignored.  But in this patch
> the tracee is not yet ptraced.

Well. I meant that if LSM_UNSAFE_PTRACE is not set, then currently (say)
security_bprm_committing_creds() has all rights to assume that the execing
task is not ptraced. Yes, I don't see any potential problem right now, but
still.

And just in case... Lets look at this code

	+                               rcu_assign_pointer(task->real_cred, bprm->cred);
	+                               task->mm = bprm->mm;
	+                               retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
	+                               rcu_assign_pointer(task->real_cred, old_cred);
	+                               task->mm = old_mm;

again.

This is mostly theoretical, but what if begin_new_exec() fails after de_thread()
and before exec_mmap() and/or commit_creds(bprm->cred) ? In this case the execing
thread will report SIGSEGV to debugger which can (say) read old_mm.

No?

I am starting to think that ptrace_attach() should simply fail with -EWOULDBLOCK
if it detects "unsafe_execve_in_progress" ... And perhaps this is what you already
tried to do in the past, I can't recall :/

Oleg.


