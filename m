Return-Path: <linux-fsdevel+bounces-46586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F3A90C92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 21:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1443A5716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8622579B;
	Wed, 16 Apr 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDQWrIDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB52253A8;
	Wed, 16 Apr 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832862; cv=none; b=UQZvOLOAsTPHcltcISfMFixOtw3AhEta7P9mO1QPjOLAyov+7MgrvAhKV0pIvqZcQ/vDWfmF1UgccCvjKxCdHk4Lh4mkjMNVr/RFEi82MUP2fSQXl/+7f9gdKOyB9yznzujpYJCS+vZKlO/BYuaY3dss+EFO34iioKU6KlOwWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832862; c=relaxed/simple;
	bh=Z/eZO17OmCOj8dOM8Nc0KzcxfYKJOjoYkwERAx7f3O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPoGHETQ/EYAX3eSWAqV3ksf7U25M9XtN926Vy3dM/Ygfr6XatH5zf+0Mz43Fsmwyb+jClO4IRqIv9/tCJzTZg/J0X2cgH1PKtaEc7lOyvZ8T3lbiKdyZaKM4TZCvGBpkPr7XZ6d2i5xgmja3yy2pfkmjnuzzTUriN3KacVvSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDQWrIDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EFFC4CEE2;
	Wed, 16 Apr 2025 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832859;
	bh=Z/eZO17OmCOj8dOM8Nc0KzcxfYKJOjoYkwERAx7f3O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDQWrIDgSfYJzIYuOLniEqTUrTnGpQLF4btKCCqXrdGVhMCYi7JomzvjucGCfO4mE
	 DEjnu1xV4ZOBVKoxZ+49Ayg5MjNyIwh2pJKcSs/J1LDmajhhq8bRVkorv1gkAtKpCG
	 JhKubVq8N6mVuh8OD76x6Jx+2hen0d1qpuFLmH05leBUMcA1+voELDCFWf8ttpXPWx
	 YukN6VFqjIst2tdK7HWqIQJ3Wt9y2HlzVgd6ZGXu/dET+yIVg0dOBymkADtGzn5jJW
	 XAMVxQ0bJwFaJFs9grh9sHFnwL57dvi5FOmsp/srELMdQ5mwXGxEr/kj4O39GD15Dp
	 JmNN0tiRD9oxA==
Date: Wed, 16 Apr 2025 21:47:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250416-tonlage-gesund-160868ceccc1@brauner>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
 <20250415223454.GA1852104@ax162>
 <20250416-befugnis-seemeilen-4622c753525b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416-befugnis-seemeilen-4622c753525b@brauner>

On Wed, Apr 16, 2025 at 03:55:48PM +0200, Christian Brauner wrote:
> On Tue, Apr 15, 2025 at 03:34:54PM -0700, Nathan Chancellor wrote:
> > Hi Christian,
> > 
> > On Fri, Apr 11, 2025 at 03:22:43PM +0200, Christian Brauner wrote:
> > > In a prior patch series we tried to cleanly differentiate between:
> > > 
> > > (1) The task has already been reaped.
> > > (2) The caller requested a pidfd for a thread-group leader but the pid
> > > actually references a struct pid that isn't used as a thread-group
> > > leader.
> > > 
> > > as this was causing issues for non-threaded workloads.
> > > 
> > > But there's cases where the current simple logic is wrong. Specifically,
> > > if the pid was a leader pid and the check races with __unhash_process().
> > > Stabilize this by using the pidfd waitqueue lock.
> > 
> > After the recent work in vfs-6.16.pidfs (I tested at
> > a9d7de0f68b79e5e481967fc605698915a37ac13), I am seeing issues with using
> > 'machinectl shell' to connect to a systemd-nspawn container on one of my
> > machines running Fedora 41 (the container is using Rawhide).
> > 
> >   $ machinectl shell -q nathan@$DEV_IMG $SHELL -l
> >   Failed to get shell PTY: Connection timed out
> > 
> > My initial bisect attempt landed on the merge of the first series
> > (1e940fff9437), which does not make much sense because 4fc3f73c16d was
> > allegedly good in my test, but I did not investigate that too hard since
> > I have lost enough time on this as it is heh. It never reproduces at
> > 6.15-rc1 and it consistently reproduces at a9d7de0f68b so I figured I
> > would report it here since you mention this series is a fix for the
> > first one. If there is any other information I can provide or patches I
> > can test (either as fixes or for debugging), I am more than happy to do
> > so.

I can't reproduce this issue at all with vfs-6.16.pidfs unfortunately.

> 
> Does the following patch make a difference for you?:
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f7403e1fb0d4..dd30f7e09917 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2118,7 +2118,7 @@ int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>         scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
>                 /* Task has already been reaped. */
>                 if (!pid_has_task(pid, PIDTYPE_PID))
> -                       return -ESRCH;
> +                       return -EINVAL;
>                 /*
>                  * If this struct pid isn't used as a thread-group
>                  * leader but the caller requested to create a
> 
> If it did it would be weird if the first merge is indeed marked as good.
> What if you used a non-rawhide version of systemd? Because this might
> also be a regression on their side.

