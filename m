Return-Path: <linux-fsdevel+bounces-42927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC652A4BEAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C271889BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A31FBCB1;
	Mon,  3 Mar 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSyAtEgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95741FBCB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001550; cv=none; b=K2DBahO8dAl4cSjrJ+MfejZD/+CRtdgwqWnXUZHx+QmPnMCEgblyiT3jclys6XIFCfe7M8Ti4CJttYuodsSFFavFcJmg+jozV7r54TinaMEWtLQHbwWWYXnJjRubD82rbeDDdMnzd7vthVG1tutmeLSr6ixbGvP7rFVbuqJtJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001550; c=relaxed/simple;
	bh=eS58c/1t+9uIydxu4DozEEpxlXPSZE67uvmjYwTb7HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgx5QanTIbDrS9V4FOTOsQC8KEbEGVgy29Nw/g3xOeATy5LTLa/2rVv3EyNvyzSLXImJ3J2acQRes3qMHX2/rSSHnramKXRvjOA2Tg33bJWFY+wCjBzYtKi298rgJYCgLTgcRbG8OA5JJBV4dB3u38MMr42C2prHA/w/OyIZ7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSyAtEgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D80C4CEE6;
	Mon,  3 Mar 2025 11:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741001550;
	bh=eS58c/1t+9uIydxu4DozEEpxlXPSZE67uvmjYwTb7HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSyAtEgoGRUcuVv+hVk8kF9G1a6EB0rDAN76uALiQabgzCsGOJNPH4olzVzUYxFe5
	 9/sDWJJK2Q69kjatxtCfTs6s/0N5jappUxrqSPIcam4Z5dvZfPwqfgZzU5OQQE+QGv
	 gVGy3sqWa5yyEhmaQ0dvA6lWwnmyJHYsqZEaUPcIDtFvDClreF4nE8cwLcfXwWBKV3
	 pB6WeXC8wy75qq/1o+zz0lEFMbGxMRwHdn1FDjLsTcR0z8dyU0/ZsNfEgLVKHxaeLW
	 XmfB4tD2WmcSiPsuPWI2EgmFKvYXCC/HjeWYpMrKAVYlFmOvtB2TQmwCHT8jPCNzfj
	 YMSe/kHhI9EjQ==
Date: Mon, 3 Mar 2025 12:32:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Lennart Poettering <lennart@poettering.net>, 
	Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250303-zyklen-ausgaben-c665e134a963@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
 <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
 <20250302172149.GF2664@redhat.com>
 <20250302-eilzug-inkognito-b5c8447a7f34@brauner>
 <20250302202428.GG2664@redhat.com>
 <Z8VxF1N7G1XZOTQy@gardel-login>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8VxF1N7G1XZOTQy@gardel-login>

On Mon, Mar 03, 2025 at 10:06:31AM +0100, Lennart Poettering wrote:
> On So, 02.03.25 21:24, Oleg Nesterov (oleg@redhat.com) wrote:
> 
> > This will fix the problem with mt-exec, but this won't help to discriminate
> > the leader-exit and the-whole-group-exit cases...
> >
> > With this this (or something like this) change pidfd_info() can only report
> > the exit code of the already reaped thread/process, leader or not.

Yes, that's fine. I don't think we need to report exit status
information right after the task has exited. It's fine to only provide
it once it has been reaped and it makes things simpler afaict.

Pidfd polling allows waiting on either task exit or for a task to have
been reaped. So the contract for PIDFD_INFO_EXIT is simply that EPOLLHUP
must be observed before exit information can be retrieved.

This aligns with wait() as well, where reaping of a thread-group leader
that exited before the thread-group was empty is delayed until the
thread-group is empty.

I think that with PIDFD_INFO_EXIT autoreaping might actually become
usable because it means a parent can ignore SIGCHLD or set SA_NOCLDWAIT
and simply use pidfd polling and PIDFD_INFO_EXIT to get get status
information from its children. But the kernel will autocleanup right
away instead of delaying. If it's a subreaper there's probably some
wrinkle with grand-children that get reparented to it? But for the
non-subreaper case it should be very useful.

> > I mean... If the leader L exits using sys_exit() and it has the live sub-
> > threads, release_task(L) / __unhash_process(L) will be only called when
> > the last sub-thread exits and it (or debugger) does "goto repeat;" in
> > release_task() to finally reap the leader.
> >
> > IOW. If someone does sys_pidfd_create(group-leader-pid, PIDFD_THREAD),
> > pidfd_info() won't report PIDFD_INFO_EXIT if the leader has exited using
> > sys_exit() before other threads.
> >
> > But perhaps this is fine?
> 
> I think this is fine, but I'd really like a way how userspace can
> determine this state reliably. i.e. a zombie state where the exit
> status is not available yet is a bit strange by classic UNIX
> standards on some level, no?
> 
> But I guess that might not be a pidfd specific issue. i.e. I figure
> classic waitid() with WNOHANG failing on a zombie process that is set
> up like that is a bit weird too, no? Or how does that work there?
> (pretty sure some userspace might not be expecting that...)

Yes, how I read the code WNOHANG exhibits the same behavior (so does WNOWAIT):

        if (exit_state == EXIT_ZOMBIE) {
                /* we don't reap group leaders with subthreads */
                if (!delay_group_leader(p)) {
                        /*
                         * A zombie ptracee is only visible to its ptracer.
                         * Notification and reaping will be cascaded to the
                         * real parent when the ptracer detaches.
                         */
                        if (unlikely(ptrace) || likely(!p->ptrace))
                                return wait_task_zombie(wo, p);
                }

