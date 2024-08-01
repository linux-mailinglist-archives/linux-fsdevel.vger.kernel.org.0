Return-Path: <linux-fsdevel+bounces-24737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6664944503
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD1C1F27D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12F15854D;
	Thu,  1 Aug 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkQQwUTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149A158554;
	Thu,  1 Aug 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495491; cv=none; b=jwaHASXCRTyhICRgJjCE0krLpCUWVsNMQ4oqXNAdF1YxmcjqmDSty7LG9VGRnSMaTVZOcdUJP1cqdbtfpocXZ6cTpGrlMskhtxyyB1jMaSHmFMQrSNZ+3xVitoBAtd8zrbSYBJwmJsnI+JJTYpJfV7VsDbMLTKcWGKIo3+TvLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495491; c=relaxed/simple;
	bh=X5/nIHI6eSt6inS+c/hwkA36ObfofUnYr2d5oV0hHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFIBCJqJMDdCJoXrNLsJD8YAJgm7QdFFLnI+owgB9ndF16kzW25Yr9REmVUwiQ432jnUP9DwmiwslrqUn+z2Zd9WoNnFyOmZzhhkOv7pnS9TfJnppcsc4/M6LHGYnjRwfJ6dHYRXt0/gm60hVxRAMpAb4laMcKe08HfWQp97C1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkQQwUTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD3BC4AF09;
	Thu,  1 Aug 2024 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722495491;
	bh=X5/nIHI6eSt6inS+c/hwkA36ObfofUnYr2d5oV0hHoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkQQwUTJverPhMso19gcLwM8l9Rx9EkzC3s2uCCB/DPdWMFXTMeXKBbK/+/2XB/KG
	 r3vF5BWys9vxHtQIWuTDi2eZVSerscTF3yhCbOchsnnYqGdFKgzdlAx2xG2lZ+Csza
	 zl65GC5CS9zYWEoqI4jKwNamzqq20LJ4eoR/k5MuYZ1HxkI5YEkbWWR0RhFlNnh0Vr
	 yn1An6LURyglPIQ7NhyBa1P+KfiJn5615IfCFw/vupWuCNr8dWwIpG5z4tKcZK8gc9
	 NnuRnKohHqlnQWoJL56lhueuhhCLl5iC+EbUA4DYdvHRSLp1Qu+TCRfiKSFjSZttfp
	 1TIdikt4VGn6A==
Date: Thu, 1 Aug 2024 08:58:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tandersen@netflix.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240801-report-strukturiert-48470c1ac4e8@brauner>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240731145132.GC16718@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731145132.GC16718@redhat.com>

On Wed, Jul 31, 2024 at 04:51:33PM GMT, Oleg Nesterov wrote:
> On 07/31, Christian Brauner wrote:
> >
> > It's currently possible to create pidfds for kthreads but it is unclear
> > what that is supposed to mean. Until we have use-cases for it and we
> > figured out what behavior we want block the creation of pidfds for
> > kthreads.
> 
> Hmm... could you explain your concerns? Why do you think we should disallow
> pidfd_open(pid-of-kthread) ?

It basically just works now and it's not intentional - at least not on
my part. You can't send signals to them, you may or may not get notified
via poll when a kthread exits. If we ever want this to be useful I would
like to enable it explicitly.

Plus, this causes confusion in userspace. When you have qemu running
with kvm support then kvm creates several kthreads (that inherit the
cgroup of the calling process). If you try to kill those instances via
systemctl kill or systemctl stop then pidfds for these kthreads are
opened but sending a signal to them is meaningless.

(So imho this causes more confusion then it is actually helpful. If we
add supports for kthreads I'd also like pidfs to gain a way to identify
them via statx() or fdinfo.)

> > @@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
> >  	if (clone_flags & CLONE_PIDFD) {
> >  		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
> >  
> > +		/* Don't create pidfds for kernel threads for now. */
> > +		if (args->kthread) {
> > +			retval = -EINVAL;
> > +			goto bad_fork_free_pid;
> 
> Do we really need this check? Userspace can't use args->kthread != NULL,
> the kernel users should not use CLONE_PIDFD.

Yeah, I know. That's really just proactive so that user of e.g.,
copy_process() such as vhost or so on don't start handing out pidfds for
stuff without requring changes to the helper itself.

