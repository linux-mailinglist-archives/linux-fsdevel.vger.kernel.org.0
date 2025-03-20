Return-Path: <linux-fsdevel+bounces-44568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A674AA6A653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5083AF60C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531D38DDB;
	Thu, 20 Mar 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ4DOh4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448D63A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474181; cv=none; b=Qc1bab4hCaOXoZ6yv0La8u1N+JT3IefnOJ2YO4PTYdDN4lFCZA4UeV49FX/GvoK/xlqaK93kqDPGbJ7nYVErjhoFhNJIZ8f/OqTIAskr1VABJM+qE+7nobxLnh/bSAfIp7s2aSGr8kf/Y4fc71fpr3rpHJAgRA2SzzOFmiaOmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474181; c=relaxed/simple;
	bh=9qPm6fB6sWkfrTcNRefhHCZqDNS4AEnbGLe3DGGTM00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq8ke1a/VYYxvOo+mX+JdpB5QbaxDBBU9upZpOZxvn2N1k2x3L3FpSsls4DB2z0wfAMD3Xb3ubmJhApmsqSNZfxCIM5T76DfA4pAGbhN6obacIWOsF0ieIyS2jRl/RaXlms14xCXV+LWAa7V2NIzLGOgVW+a8Z2yCmaMo5zBitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ4DOh4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5F0C4CEDD;
	Thu, 20 Mar 2025 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742474179;
	bh=9qPm6fB6sWkfrTcNRefhHCZqDNS4AEnbGLe3DGGTM00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJ4DOh4SSO8LIh24pJApsl4iN2N0K8eeL3CqlC2Jb3D4CvCWLvVHZr2MCjiYqcMn1
	 VUe1HZ6Y8Q0QijWKAxBDIneht95Idti1jh6gav2H39hgJv+X7Y8ky3Tfhc/bC8i5It
	 +h0Jp3LE6CIR68bTmxqm0rKeHAXlnBL+ERdgjPJ1k5yaFl+puD2lbfihCwkcXZN/Iy
	 APlPZC9KKiAyWRcxoRNL2UTsefnkqs4B9VqmH8AASVGEqv7b93CcL8lyv4V7/LIRA1
	 2w9mtd+rAO9CU/Kke4AcYwJ4Hsmv7w2tnelTQTFOYF2MGI/XF2245g9FKHEJpEqDHt
	 CvdD0kyggKVjA==
Date: Thu, 20 Mar 2025 13:36:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320-erzwungen-adjektiv-6a73b88f5f30@brauner>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
 <20250320105701.GA11256@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320105701.GA11256@redhat.com>

On Thu, Mar 20, 2025 at 11:57:02AM +0100, Oleg Nesterov wrote:
> Christian,

Oleg!

> 
> All the comments look misleading (and overcomplicated) to me.
> 
> See below, but first lets recall the commit 64bef697d33b75fc06c5789
> ("pidfd: implement PIDFD_THREAD flag for pidfd_open()") which says
> 
>     pidfd: implement PIDFD_THREAD flag for pidfd_open()
> 
>     With this flag:
> 
>             ....
> 
>             - pidfd_poll() succeeds when the task exits and becomes a
>               zombie (iow, passes exit_notify()), even if it is a leader
>               and thread-group is not empty.
> 
> This patch simply reverts this behaviour, the exiting leader will not
> report the exit if it has sub-threads (alive or not). And afaics your
> V1 tried to do the same. And this eliminates the
> 
>               This means that the behaviour of pidfd_poll(PIDFD_THREAD,
>               pid-of-group-leader) is not well defined if it races with
>               exec() from its sub-thread; ...
> 
> problem mentioned in the changelog. That is all.
> 
> IOW, with this change PIDFD_THREAD has no effect.

But that's what I'm trying to say: This patch aligns the behavior of
thread-specific and non-thread-specific thread-group leader pidfds. IOW,
the behavior of:

pidfd_open(<thread-group-leader-pid>, 0)
pidfd_open(<thread-group-leader-pid>, PIDFD_THREAD)

is the same wrt to polling after this patch. That's also what the
selftests are designed to test and show.

> 
> Except the pid_has_task() checks in sys_pidfd_open() paths, without
> PIDFD_THREAD the target task must be a group leader.
> 
> On 03/20, Christian Brauner wrote:
> >
> > @@ -218,12 +218,32 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> 
> Your forgot to remove the no longer used
> 
> 	bool thread = file->f_flags & PIDFD_THREAD;
> 
> above ;)

Thanks, fixed.

> 
> >  	/*
> >  	 * Depending on PIDFD_THREAD, inform pollers when the thread
> >  	 * or the whole thread-group exits.
> 
> See above (and below), this no longer depends on PIDFD_THREAD.
> 
> > +	else if (task->exit_state && !delay_group_leader(task))
> >  		poll_flags = EPOLLIN | EPOLLRDNORM;
> 
> So with this change:
> 
> If the exiting task is a sub-thread, report EPOLLIN as before.
> delay_group_leader() can't be true. In this case PIDFD_THREAD
> must be set.
> 
> If the exiting task is a leader, we do not care about PIDFD_THREAD.
> We report EPOLLIN only if it is the last/only thread.
> 
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 9916305e34d3..ce5cdad5ba9c 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -271,6 +271,9 @@ void release_task(struct task_struct *p)
> >  		 * If we were the last child thread and the leader has
> >  		 * exited already, and the leader's parent ignores SIGCHLD,
> >  		 * then we are the one who should release the leader.
> > +		 *
> > +		 * This will also wake PIDFD_THREAD pidfds for the
> > +		 * thread-group leader that already exited.
> >  		 */
> >  		zap_leader = do_notify_parent(leader, leader->exit_signal);
> 
> Again, this doesn't depend on PIDFD_THREAD.

The comment is literally just saying that we delayed notification of
PIDFD_THREAD pidfds for a thread-group leader until now. After all its
subthreads are released instead of when the thread-group leader did
actually exit earlier.

> 
> > @@ -743,10 +746,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >
> >  	tsk->exit_state = EXIT_ZOMBIE;
> >  	/*
> > -	 * sub-thread or delay_group_leader(), wake up the
> > -	 * PIDFD_THREAD waiters.
> > +	 * Wake up PIDFD_THREAD waiters if this is a proper subthread
> > +	 * exit. If this is a premature thread-group leader exit delay
> > +	 * the notification until the last subthread exits. If a
> > +	 * subthread should exec before then no notification will be
> > +	 * generated.
> >  	 */
> > -	if (!thread_group_empty(tsk))
> > +	if (!delay_group_leader(tsk))
> >  		do_notify_pidfd(tsk);
> 
> The same...

What you seem to be saying is that you want all references to
PIDFD_THREAD to be dropped in the comments because the behavior is now
identical. But what I would like to have is comments in the code that
illustrate where and how we guarantee this behavioral equivalency.

Because where the notifications happen does differ.

The delayed thread-group leader stuff is literally only apparent to
anyone who has stared and lived with these horrible behavioral warts of
early thread-group leader exit and subthread exec for a really long
time. For anyone else this isn't self-explanatory at all and each time
one has to go look at it it requires jumping around all the locations
where and how exit notifications are generated and piece together the
whole picture. It is laughably complex to follow.

So I'm wiping the comments but I very much disagree that they are
misleading/useless.

> 
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2180,8 +2180,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  	WARN_ON_ONCE(!tsk->ptrace &&
> >  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
> >  	/*
> > -	 * tsk is a group leader and has no threads, wake up the
> > -	 * non-PIDFD_THREAD waiters.
> > +	 * This is a thread-group leader without subthreads so wake up
> > +	 * the non-PIDFD_THREAD waiters. This also wakes the
> > +	 * PIDFD_THREAD waiters for the thread-group leader in case it
> > +	 * exited prematurely from release_task().
> >  	 */
> 
> This too.

This one I agree is misplaced. It would be sufficient to have the
comment in release_task().

Christian

