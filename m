Return-Path: <linux-fsdevel+bounces-45763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FDAA7BE0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D853B4ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655091EF0BA;
	Fri,  4 Apr 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5kWHoLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112E12DD95;
	Fri,  4 Apr 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773941; cv=none; b=pyXwLSdf+UXrffRyiXHUgSRDc2LbR1qgUhlppR1WJCrRKNMTQ5/Ujnbc3AFRAIXL4005h5+ErxhtoftWZwKcyRrO2Ma9HuVsQdPlshbKQZteUwsd5YvkBuTnUcFNf1biQvp3/ALy6Pz3s2O3U5VCYTcfXf2njUQfoNgJZILSsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773941; c=relaxed/simple;
	bh=vfUq5U/Wla4KrjDkPf/VZz2suucaLJQCY5wq0GYGuOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eow9GYeazypvjEkdTZ6EF//ZkqkcIuzGrWotuSn8zwNWWp0a0MPNEL+aracsXFDzb70M++jVAd3FdhZm4Y4ViCEAR7YzZphx/CLHRwxJyxGc9qltLBHwZx1z87l8V3nWiX9B1kNfwoYV/5/TgyCiu+wWCnRwcyduR2E+3brdGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5kWHoLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA97C4CEDD;
	Fri,  4 Apr 2025 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743773941;
	bh=vfUq5U/Wla4KrjDkPf/VZz2suucaLJQCY5wq0GYGuOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5kWHoLkv8Hzchwhgfg7XaHhfqEZaE+y8xF0+F1Qy2rFmRYc6O4sJKbRSWBwkz1r9
	 quhm1jcQt2MhQUF3cOlItQncHt6ar6873ruxeMxefX92AWcTNYp+e+Yfu01jktiqnN
	 ZMrVjWCi3vh3bp3UT2WFWzGVor6FPJL2gHfujlMlrAkhJkYkZ8Nn1KHMSmPZe79Fp6
	 K9LHbgthndN/6hzhBA0KoNO++DF+wAysLzgD6w0FJcGqakRAXk11LtWhfyLOC7w/SS
	 VNezrdSjrN+JQoQGLzW9YJ8V8T5etwhJZqUs/0aoBCouOcL1oi5Mhz30DdK7hSb2uw
	 hg2a3rCH1PeWw==
Date: Fri, 4 Apr 2025 15:38:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] pidfd: improve uapi when task isn't found
Message-ID: <20250404-roben-zoodirektor-13cb8d1acefe@brauner>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
 <20250403-work-pidfd-fixes-v1-3-a123b6ed6716@kernel.org>
 <20250404123737.GC3720@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404123737.GC3720@redhat.com>

On Fri, Apr 04, 2025 at 02:37:38PM +0200, Oleg Nesterov wrote:
> On 04/03, Christian Brauner wrote:
> >
> > We currently report EINVAL whenever a struct pid has no tasked attached
> > anymore thereby conflating two concepts:
> >
> > (1) The task has already been reaped.
> > (2) The caller requested a pidfd for a thread-group leader but the pid
> >     actually references a struct pid that isn't used as a thread-group
> >     leader.
> >
> > This is causing issues for non-threaded workloads as in [1].
> >
> > This patch tries to allow userspace to distinguish between (1) and (2).
> > This is racy of course but that shouldn't matter.
> >
> > Link: https://github.com/systemd/systemd/pull/36982 [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> For this series:
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> But I have a couple of cosmetic nits...
> 
> >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> >  {
> > -	bool thread = flags & PIDFD_THREAD;
> > +	int err = 0;
> >
> > -	if (!pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
> > -		return -EINVAL;
> > +	if (!(flags & PIDFD_THREAD)) {
> > +		/*
> > +		 * If this is struct pid isn't used as a thread-group
> > +		 * leader pid but the caller requested to create a
> > +		 * thread-group leader pidfd then report ENOENT to the
> > +		 * caller as a hint.
> > +		 */
> > +		if (!pid_has_task(pid, PIDTYPE_TGID))
> > +			err = -ENOENT;
> > +	}
> > +
> > +	/*
> > +	 * If this wasn't a thread-group leader struct pid or the task
> > +	 * got reaped in the meantime report -ESRCH to userspace.
> > +	 *
> > +	 * This is racy of course. This could've not been a thread-group
> > +	 * leader struct pid and we set ENOENT above but in the meantime
> > +	 * the task got reaped. Or there was a multi-threaded-exec by a
> > +	 * subthread and we were a thread-group leader but now got
> > +	 * killed.
> 
> The comment about the multi-threaded-exec looks a bit misleading to me.
> If this pid is a group-leader-pid and we race with de_thread() which does
> 
> 		exchange_tids(tsk, leader);
> 		transfer_pid(leader, tsk, PIDTYPE_TGID);
> 
> nothing "bad" can happen, both pid_has_task(PIDTYPE_PID) or
> pid_has_task(PIDTYPE_TGID) can't return NULL during (or after) this
> transition.
> 
> hlists_swap_heads_rcu() or hlist_replace_rcu() can't make
> hlist_head->first == NULL during this transition...

Good point.

> 
> Or I misunderstood the comment?
> 
> And... the code looks a bit overcomplicated to me, why not simply
> 
> 	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> 	{
> 		if (!pid_has_task(pid, PIDTYPE_PID))
> 			return -ESRCH;
> 
> 		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
> 			return -ENOENT;

I thought that checking PIDTYPE_PID first could cause misleading results
where we report ENOENT where we should report ESRCH: If the task was
released after the successful PIDTYPE_PID check for a pid that was never
a thread-group leader we report ENOENT. That's what I reversed the
check. But I can adapt that to you scheme. I mostly wanted a place to
put the comments.

> 
> 		return __pidfd_prepare(pid, flags, ret);
> 	}
> 
> ? Of course, the comments should stay.
> 
> But again, this is cosmetic/subjective, please do what you like more.
> 
> Oleg.
> 

