Return-Path: <linux-fsdevel+bounces-44453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B02A693E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398BB88407F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E01DD0DC;
	Wed, 19 Mar 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghghe3g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF321DA10C
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398795; cv=none; b=Izz7v8HT83MHQT9q3wAAx6P6unFHTMbzdqjl3Jh6NHxJdO1LHGFnYSX+I1ZPlCvuoOBGll7AnwhBoD/nbUTIytzWpNNX1NCVlmRweH1EJ+2rdeUtW/7UBqZnMU++JpjqqxKsf6egcYTKu15FS9cOgaNIDyC6v9LraXkFTsLGdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398795; c=relaxed/simple;
	bh=NKafdDFhvA+B0LDfrEObML9M32C3bsMtrBhdwT5NO8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEkxF6m6WB4EhcLUDCm3NDWI9GvmbPvf6JG8ZdJLhZieR4UThsvJCbe/ZtQ22Ahw1wfII0aITWH/8UxAuJzIfTERMeAX5BUiytB/lDW3ryTcfrI7vzVhswh9mktGJXJkL+6+Pfea1JQbbw0G/iYcJlxXDYkfYZS4nsyd253q4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghghe3g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3377C4CEE9;
	Wed, 19 Mar 2025 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398795;
	bh=NKafdDFhvA+B0LDfrEObML9M32C3bsMtrBhdwT5NO8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ghghe3g72e4MAuTgwAfCy3/rWuJv6lxs+DIYOCI5p/nRf07RD5iuGRqrbHYw+DOBC
	 5XVNeeXZ0/XxXNL0kmqWC3AM/DzcvrOQoMhDzYhh/WsJYyD8njaj84o4KEb5MALpAD
	 hRbxJIWid3Nb2toBb3nXYBux2rkUHc0UqW4YFqzLwNMeQ8q3wWUk6rmrpIEtNDdyZr
	 g+4gs5dcI1skACUsRbJyTIMUCna2oWhTikawm/4MKJ+JJGfI92fQiDu10/TvHR11gJ
	 HJ8B4wOoinPMGRwmgk8+KjT8SRc9AwgzwbWO6Ahp4degTy8MKJk91nauIhMK7EDH7h
	 F3hsAGw1cELZA==
Date: Wed, 19 Mar 2025 16:39:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC v2 1/3] pidfs: improve multi-threaded exec and
 premature thread-group leader exit polling
Message-ID: <20250319-zeitmanagement-beginnen-9a36392fb214@brauner>
References: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
 <20250318-work-pidfs-thread_group-v2-1-2677898ffa2e@kernel.org>
 <20250319140052.GC26879@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319140052.GC26879@redhat.com>

On Wed, Mar 19, 2025 at 03:00:52PM +0100, Oleg Nesterov wrote:
> On 03/18, Christian Brauner wrote:
> >
> > @@ -746,8 +751,23 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >  	 * sub-thread or delay_group_leader(), wake up the
> >  	 * PIDFD_THREAD waiters.
> >  	 */
> > -	if (!thread_group_empty(tsk))
> > -		do_notify_pidfd(tsk);
> > +	if (!thread_group_empty(tsk)) {
> > +		if (delay_group_leader(tsk)) {
> > +			struct pid *pid;
> > +
> > +			/*
> > +			 * This is a thread-group leader exiting before
> > +			 * all of its subthreads have exited allow pidfd
> > +			 * polling to detect this case and delay exit
> > +			 * notification until the last thread has
> > +			 * exited.
> > +			 */
> > +			pid = task_pid(tsk);
> > +			WRITE_ONCE(pid->delayed_leader, 1);
> 
> This is racy, tsk->exit_state is already set so pidfd_poll() can see
> task->exit_state && !pid->delayed_leader.

You're right. I had not considered that.

> But this is minor. I can't understand all these complications,
> probably because I barely slept tonight ;) I will re-read this patch
> again tomorrow, but could you explain why we can't simply use the
> trivial patch below?

Sure, if that works I'm more than happy if we run with this.

> 
> Oleg.
> ---
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index d980f779c213..8a95920aed98 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -210,7 +210,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  {
>  	struct pid *pid = pidfd_pid(file);
> -	bool thread = file->f_flags & PIDFD_THREAD;
>  	struct task_struct *task;
>  	__poll_t poll_flags = 0;
>  
> @@ -223,7 +222,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	task = pid_task(pid, PIDTYPE_PID);
>  	if (!task)
>  		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
> -	else if (task->exit_state && (thread || thread_group_empty(task)))
> +	else if (task->exit_state && !delay_group_leader(task))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;
>  
>  	return poll_flags;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 9916305e34d3..356ca41d313b 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -746,7 +746,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	 * sub-thread or delay_group_leader(), wake up the
>  	 * PIDFD_THREAD waiters.
>  	 */
> -	if (!thread_group_empty(tsk))
> +	if (!delay_group_leader(tsk))
>  		do_notify_pidfd(tsk);

Two cases we need to handle:

(1) thread-group leader exits prematurely and none of the subthreads
    ever exec. Once the last thread exits it'll notify the
    thread-specific and non-thread specific thread-group leader pidfd
    pollers from release_task().

(2) thread-group leader exits prematurely but one of the subthreads
    later execs. In this case we don't want any exit notification to
    be generated for thread-specific thread-group leaders.

I was concerned that handling (2) would be more complex but it passes
all the new tests so I won't complain about less code needed. ;)

Do you want me to just dump your draft and slap a Co-Developed-by on it?

Another idea I had that I would welcome your thoughts on:

When a task execs we could indicate this by generating a POLLPRI event
on the pidfd. If we wanted to be fine-grained we could generate
POLLPRI | POLLRDUP if a subthread execs. The latter would give userspace
a reliable way to detect this case and figure out that tasks changed
TIDs.

