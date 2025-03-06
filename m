Return-Path: <linux-fsdevel+bounces-43352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E20A54B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C0E1896210
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2120C027;
	Thu,  6 Mar 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf3FU9tx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAB201005
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265314; cv=none; b=ugvrTC0x/tmwfVuqg6eM1sNy3iPKcXxADGOaJlBEJTa0rjBtaIjePDAwVMU9ZyfbRLj3HBM5bNuBz6577qMZP88dwnz6eP/G2qd063TfGF+9GYGTcAHX4jkGWQ5V4ExzqWnR7LMQ742nWbuShEPpoC+dero8K9i+uLYCs/VVoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265314; c=relaxed/simple;
	bh=Er8kwftGuGEESe5a19eVdQDjc2pMBwERwQ4CCX7BlYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfZXaKTx1Jetls1U5JNI296tSNPc8T2bsXNmhBKCyqHLhxD9gwtjObzvXFteSQm+8Mw2oWin8Pb5kl9ZmVxwVOjkVhcuZij4Vqs3gfh5UUYA+Kfu4z7mqWdT/5R+MMI1Hf2p9SNREY25W3kYa1G/mV4CtD8O6ig6NepeXckJvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf3FU9tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F9BC4CEE4;
	Thu,  6 Mar 2025 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741265314;
	bh=Er8kwftGuGEESe5a19eVdQDjc2pMBwERwQ4CCX7BlYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cf3FU9tx59RiL/qMwCzikRIvsZT7Eeg7P3aPy4kbUOZXSkaoqgE9LSi1RngDj8uPe
	 nNstyOmevSUsiOuwQHuIKWO0Pcy/hT/vp5JnmWW3goTO+84jgH8Zbx2fxKKcHnJyc+
	 J0G+Icsqvqcy/5y2vtOPVAQrS85QR3heJEi1TyGgIM2OTIzUwq9oJMnGr0ulo/k8Zn
	 RgXo+nswQrxkVBxIgiYj8Wr3jBYJHT/3y2HGypnutSRLMo8bLquQcbJaUVHR3mnMsH
	 x8K8l34/eELa9L0R9xbdWjVmp+jyG3+2eDQCG/ZfJH0xuEjc094wZNwH8VUlFOjhkm
	 iyTSBWcdk6pbw==
Date: Thu, 6 Mar 2025 13:48:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: PIDFD_THREAD behavior for thread-group leaders
Message-ID: <20250306-geknebelt-affen-99bb08c92675@brauner>
References: <nhoaiykqnoid3df3ckmqqgycbjqtd2rutrpeat25j4bbm7tbjl@tpncnt7cp26n>
 <20250306121713.GC19868@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306121713.GC19868@redhat.com>

On Thu, Mar 06, 2025 at 01:17:13PM +0100, Oleg Nesterov wrote:
> On 03/06, Christian Brauner wrote:
> >
> > Back when we implemented support for PIDFD_THREAD we ended up with the
> > decision that if userspace holds:
> >
> > pidfd_leader_thread = pidfd_open(<thread-group-leader-pid>, PIDFD_THREAD)
> >
> > that exit notification is not strictly defined if a non-thread-group
> > leader thread execs:
> 
> Yes, this was even documented in commit 64bef697d33b ...

Yeah, I'm aware I was just revisiting this decision.

> 
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -745,8 +745,11 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >         /*
> >          * sub-thread or delay_group_leader(), wake up the
> >          * PIDFD_THREAD waiters.
> > +        *
> > +        * The thread-group leader will be taken over by the execing
> > +        * task so don't cause spurious wakeups.
> >          */
> > -       if (!thread_group_empty(tsk))
> > +       if (!thread_group_empty(tsk) && (tsk->signal->notify_count >= 0))
> >                 do_notify_pidfd(tsk);
> >
> >         if (unlikely(tsk->ptrace)) {
> 
> perhaps... but this won't help if the leader exits and that another
> thread does exec?
> 
> >From the changelog
> 
> 	Perhaps we can improve this behaviour later, pidfd_poll()
> 	can probably take sig->group_exec_task into account. But
> 	this doesn't really differ from the case when the leader
> 	exits before other threads (so pidfd_poll() succeeds) and
> 	then another thread execs and pidfd_poll() will block again.
> 
> so I am not sure what can we do.

I think early thread-group leader exit is a bug in the userspace
program whereas multi-threaded exec is well-defined (if ugly).

To detect early-thread-group leader exec userspace could do:

pidfd_leader_thread = pidfd_open(<thread-group-leader-pid>, 0)
pidfd_thread = pidfd_open(<thread-group-leader-pid>, PIDFD_THREAD)

and then they need to add both file descriptors to the poll instance.

If proper multi-threaded exec happens no notification will be generated
on either file descriptor.

However, if the thread-group leader exits prematurely then a
notification will be generated on pidfd_thread allowing detection of
malformed behavior.

So the premature thread-group leader exec thing is probably something we
can ignore as a real use-case.

> 
> I'll try to think more later, but I can't promise much :(
> 
> Oleg.
> 

