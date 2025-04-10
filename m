Return-Path: <linux-fsdevel+bounces-46190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128AA84104
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0051B61401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D27281368;
	Thu, 10 Apr 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtdUtN8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EF280CF5;
	Thu, 10 Apr 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281801; cv=none; b=O7WcZMPMTasjzJF6d7ZU7p+KXT4cHye7cgF3+lghR5Miusa9SOC/G2FDlEqVFPkaAQvDWD42Ng4Qb6+dP/Qdlr8epDcRpei2UxmWE3qNF1ZU7o1oj7V58Oe1XL1rRKS4hs9xeWXOqG7Zr+9EM+3fWHeCKzICVWxury4LOg2XgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281801; c=relaxed/simple;
	bh=fO12BmA5JGZJ0a/09O+FMjxB+Lf4TKa7uC+u44wx1e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6SEnHDkOqhTY0/3kxEn/LFdE4HPWETP84TQ8F1gfztHQ9454I6DnpgoXvBKP/qVBKymqH2yrVzRV1f+BVbEQ5grbp1zpwtwLmwb9hN10Fg31RDB+/hcnVmG1CiLKOJ8508hjKY9XXNaLFhz2zoO0woTAKqeAVTYubiN0ggxXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtdUtN8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DD1C4CEDD;
	Thu, 10 Apr 2025 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744281799;
	bh=fO12BmA5JGZJ0a/09O+FMjxB+Lf4TKa7uC+u44wx1e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtdUtN8vsdalGLWxoa2QelKR/UBek09CdFsGshGvUvuHyoUMCnahrj0xJmIIgj56k
	 H4CsRkYzdOMe20rq5ADTpaUui9Vg7StqzQe0NKO1pfAGPw6I7m84V5EyMc5sY7IpXm
	 XAR5gnunwXGL5QvN+VVP98z9q6p+QYzXdaoZF6OgtB9Kryk0tAnMCJqK7WttgKSbCV
	 sMSLPFgFfh88CSWJ/duJFJGlyyK74CpKeKa9oe9y3y6ADttYkyYhLjj2c6jY6oH2b+
	 epZj53gwzfo59TuvouxNGJc/jgdNzhQiy6Ccy4epDBO9hrzOl/q4sHj4TsYEk7Ko+g
	 odY0Kuc4uBVXQ==
Date: Thu, 10 Apr 2025 12:43:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410101801.GA15280@redhat.com>

On Thu, Apr 10, 2025 at 12:18:01PM +0200, Oleg Nesterov wrote:
> On 04/09, Oleg Nesterov wrote:
> >
> > Christian,
> >
> > I will actually read your patch tomorrow, but at first glance
> >
> > On 04/09, Christian Brauner wrote:
> > >
> > > The seqcounter might be
> > > useful independent of pidfs.
> >
> > Are you sure? ;) to me the new pid->pid_seq needs more justification...

Yeah, pretty much. I'd make use of this in other cases where we need to
detect concurrent changes to struct pid without having to take any
locks. Multi-threaded exec in de_exec() comes to mind as well.

> > Again, can't we use pid->wait_pidfd->lock if we want to avoid the
> > (minor) problem with the wrong ENOENT?
> 
> I mean
> 
> 	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> 	{
> 		int err = 0;
> 
> 		spin_lock_irq(&pid->wait_pidfd->lock);
> 
> 		if (!pid_has_task(pid, PIDTYPE_PID))
> 			err = -ESRCH;
> 		else if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
> 			err = -ENOENT;
> 
> 		spin_lock_irq(&pid->wait_pidfd->lock);
> 
> 		return err ?: __pidfd_prepare(pid, flags, ret);
> 	}
> 
> To remind, detach_pid(pid, PIDTYPE_PID) does wake_up_all(&pid->wait_pidfd) and
> takes pid->wait_pidfd->lock.
> 
> So if pid_has_task(PIDTYPE_PID) succeeds, __unhash_process() -> detach_pid(TGID)
> is not possible until we drop pid->wait_pidfd->lock.
> 
> If detach_pid(PIDTYPE_PID) was already called and have passed wake_up_all(),
> pid_has_task(PIDTYPE_PID) can't succeed.

I know. I was trying to avoid having to take the lock and just make this
lockless. But if you think we should use this lock here instead I'm
willing to do this. I just find the sequence counter more elegant than
the spin_lock_irq().

And note that it doesn't grow struct pid. There's a 4 byte hole I would
place it into just before struct dentry *. So there's no downside to
this imho and it would give pidfds a reliable way to detect relevant
concurrent changes locklessly without penalizing other critical paths
(e.g., under tasklist_lock) in the kernel.

