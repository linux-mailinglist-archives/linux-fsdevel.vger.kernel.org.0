Return-Path: <linux-fsdevel+bounces-44548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4162DA6A454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DAB3ABE93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F50224AFA;
	Thu, 20 Mar 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5Uc/G1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A7224AEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468270; cv=none; b=NP/4syLbYYeFYhmLDcbG1RgmT1i8xamBM0sibludLy+VWS6+sMUQSCjDticTimPHZExeZSqDEnqQb0NXTQpXk9Jl3t8ovg0mqlPrHj5U0Qrep2NaTkA0xs0Pgu/xSP9cke8YDJAdzpkYA2vDs+qBrED/WLLQpMQdHVPpw0EQmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468270; c=relaxed/simple;
	bh=Rx/lB1qMqdBznNerMqoOfYwpsD2GVIU+tJtmD0pFHgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0le8Fqq0XkUG7A6k/ppXWs1EH45+zPN01DBHq44Ucevl/jP8HBHQEK7ycT/2aINR4ZjjQ7+HmWn3p/NPbziw5PRWGwrXZS1iGbErQon6IzPF8y9ck3TbGaJOjBIOKZWO+uCY2C1KKC0r5sIsnWWUfHJsQFLcSySzN6HdhSFT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5Uc/G1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742468265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fP85BV6cc7YrAlKrJpr00XbGSPJ39Z+CtSaGKx2Upc=;
	b=Y5Uc/G1gwnlI/qpKswD1MGKnH6BHDU6234+ixSREVMr2NgdtunW0QJ4hYyNfXsSSkM2uN4
	d5yAtOVUaHqWdeFskyr7pvZnNKDWpZPJuuKAKH9lqFNSCr4ad8Xi1Bk7cyHKK3uirdYA8i
	FN06xcEFZrYOURdGNEDuFpYqBr7rmgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-TI8DNkkZMBedZxnYEMFsfw-1; Thu,
 20 Mar 2025 06:57:40 -0400
X-MC-Unique: TI8DNkkZMBedZxnYEMFsfw-1
X-Mimecast-MFC-AGG-ID: TI8DNkkZMBedZxnYEMFsfw_1742468259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9C8F1933B49;
	Thu, 20 Mar 2025 10:57:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A9381828A87;
	Thu, 20 Mar 2025 10:57:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Mar 2025 11:57:06 +0100 (CET)
Date: Thu, 20 Mar 2025 11:57:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320105701.GA11256@redhat.com>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Christian,

All the comments look misleading (and overcomplicated) to me.

See below, but first lets recall the commit 64bef697d33b75fc06c5789
("pidfd: implement PIDFD_THREAD flag for pidfd_open()") which says

    pidfd: implement PIDFD_THREAD flag for pidfd_open()

    With this flag:

            ....

            - pidfd_poll() succeeds when the task exits and becomes a
              zombie (iow, passes exit_notify()), even if it is a leader
              and thread-group is not empty.

This patch simply reverts this behaviour, the exiting leader will not
report the exit if it has sub-threads (alive or not). And afaics your
V1 tried to do the same. And this eliminates the

              This means that the behaviour of pidfd_poll(PIDFD_THREAD,
              pid-of-group-leader) is not well defined if it races with
              exec() from its sub-thread; ...

problem mentioned in the changelog. That is all.

IOW, with this change PIDFD_THREAD has no effect.

Except the pid_has_task() checks in sys_pidfd_open() paths, without
PIDFD_THREAD the target task must be a group leader.

On 03/20, Christian Brauner wrote:
>
> @@ -218,12 +218,32 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)

Your forgot to remove the no longer used

	bool thread = file->f_flags & PIDFD_THREAD;

above ;)

>  	/*
>  	 * Depending on PIDFD_THREAD, inform pollers when the thread
>  	 * or the whole thread-group exits.

See above (and below), this no longer depends on PIDFD_THREAD.

> +	else if (task->exit_state && !delay_group_leader(task))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;

So with this change:

If the exiting task is a sub-thread, report EPOLLIN as before.
delay_group_leader() can't be true. In this case PIDFD_THREAD
must be set.

If the exiting task is a leader, we do not care about PIDFD_THREAD.
We report EPOLLIN only if it is the last/only thread.

> diff --git a/kernel/exit.c b/kernel/exit.c
> index 9916305e34d3..ce5cdad5ba9c 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -271,6 +271,9 @@ void release_task(struct task_struct *p)
>  		 * If we were the last child thread and the leader has
>  		 * exited already, and the leader's parent ignores SIGCHLD,
>  		 * then we are the one who should release the leader.
> +		 *
> +		 * This will also wake PIDFD_THREAD pidfds for the
> +		 * thread-group leader that already exited.
>  		 */
>  		zap_leader = do_notify_parent(leader, leader->exit_signal);

Again, this doesn't depend on PIDFD_THREAD.

> @@ -743,10 +746,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>
>  	tsk->exit_state = EXIT_ZOMBIE;
>  	/*
> -	 * sub-thread or delay_group_leader(), wake up the
> -	 * PIDFD_THREAD waiters.
> +	 * Wake up PIDFD_THREAD waiters if this is a proper subthread
> +	 * exit. If this is a premature thread-group leader exit delay
> +	 * the notification until the last subthread exits. If a
> +	 * subthread should exec before then no notification will be
> +	 * generated.
>  	 */
> -	if (!thread_group_empty(tsk))
> +	if (!delay_group_leader(tsk))
>  		do_notify_pidfd(tsk);

The same...

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2180,8 +2180,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	WARN_ON_ONCE(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  	/*
> -	 * tsk is a group leader and has no threads, wake up the
> -	 * non-PIDFD_THREAD waiters.
> +	 * This is a thread-group leader without subthreads so wake up
> +	 * the non-PIDFD_THREAD waiters. This also wakes the
> +	 * PIDFD_THREAD waiters for the thread-group leader in case it
> +	 * exited prematurely from release_task().
>  	 */

This too.

Oleg.


