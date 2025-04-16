Return-Path: <linux-fsdevel+bounces-46562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D064A905A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683A08E0AA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B044217679;
	Wed, 16 Apr 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/gEdZmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE271F869E;
	Wed, 16 Apr 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811753; cv=none; b=SvdGrZ+dXt2DaHb9JpGY84Fa84mpoo6MU2gFRNNcnuF7wVdVdBoClBtGiSignWw0Y4825ea2oKMqU+v3wsowiPC7E6focU1drty1Me7hw6ACyoEMRbWZbcABIuIVN6lNrkkANaIsdjmvAr9yX8+gp8HIXJyfcA4fRyhq4NxxXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811753; c=relaxed/simple;
	bh=tH8k6GT4PVqHZGn4P37rTxSYFe3E560jTJrVVxgDSaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCwKGOslZdR3hyhJ1VTxfJh1YBm0CEbWQNzDCh+FXuYCRga1PG1XU/uy4GAwyPpMfk5EsDhh8qS2hjkFBe0MONQHKRHx2m1dfWMiUMQR29jxOw7zWSWoSCdljsA2m/ZSnu9/YSAvhHFxgXb1gG3X4ftRbLWiMUzv6l23xp3ZQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/gEdZmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2628DC4CEE2;
	Wed, 16 Apr 2025 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744811753;
	bh=tH8k6GT4PVqHZGn4P37rTxSYFe3E560jTJrVVxgDSaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/gEdZmOEwbknNnQNDpg58yVSh4xxLkG4Vreehky9nZ6Lun3ewRXw52TL7XW0n/98
	 F53GbC2EG7MldrrbsIe9OQmhlrKekAvWcSTwosBryj07ms8Q59nPN1wcPsnSakEwD3
	 IxPhv6h1qQTQKkY/QUMpatw8F97awTTDwCwk/gs8ZgW5d//Q5KNWU2THZJzOvLC+e1
	 tXePCu1bg3qepXKmMEu0kDclau+tIyzLsqo/xBbs7jA3efd5jf2N91ioj4co8g5xAy
	 jOXwgPmrKN/Vc8tl5gM59y8LNJDPwIrA+uxH27+jmK5+S2QxMiCHhX38X/WUqf9tEY
	 ztyzfakUYXMLQ==
Date: Wed, 16 Apr 2025 15:55:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250416-befugnis-seemeilen-4622c753525b@brauner>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
 <20250415223454.GA1852104@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415223454.GA1852104@ax162>

On Tue, Apr 15, 2025 at 03:34:54PM -0700, Nathan Chancellor wrote:
> Hi Christian,
> 
> On Fri, Apr 11, 2025 at 03:22:43PM +0200, Christian Brauner wrote:
> > In a prior patch series we tried to cleanly differentiate between:
> > 
> > (1) The task has already been reaped.
> > (2) The caller requested a pidfd for a thread-group leader but the pid
> > actually references a struct pid that isn't used as a thread-group
> > leader.
> > 
> > as this was causing issues for non-threaded workloads.
> > 
> > But there's cases where the current simple logic is wrong. Specifically,
> > if the pid was a leader pid and the check races with __unhash_process().
> > Stabilize this by using the pidfd waitqueue lock.
> 
> After the recent work in vfs-6.16.pidfs (I tested at
> a9d7de0f68b79e5e481967fc605698915a37ac13), I am seeing issues with using
> 'machinectl shell' to connect to a systemd-nspawn container on one of my
> machines running Fedora 41 (the container is using Rawhide).
> 
>   $ machinectl shell -q nathan@$DEV_IMG $SHELL -l
>   Failed to get shell PTY: Connection timed out
> 
> My initial bisect attempt landed on the merge of the first series
> (1e940fff9437), which does not make much sense because 4fc3f73c16d was
> allegedly good in my test, but I did not investigate that too hard since
> I have lost enough time on this as it is heh. It never reproduces at
> 6.15-rc1 and it consistently reproduces at a9d7de0f68b so I figured I
> would report it here since you mention this series is a fix for the
> first one. If there is any other information I can provide or patches I
> can test (either as fixes or for debugging), I am more than happy to do
> so.

Does the following patch make a difference for you?:

diff --git a/kernel/fork.c b/kernel/fork.c
index f7403e1fb0d4..dd30f7e09917 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2118,7 +2118,7 @@ int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
        scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
                /* Task has already been reaped. */
                if (!pid_has_task(pid, PIDTYPE_PID))
-                       return -ESRCH;
+                       return -EINVAL;
                /*
                 * If this struct pid isn't used as a thread-group
                 * leader but the caller requested to create a

If it did it would be weird if the first merge is indeed marked as good.
What if you used a non-rawhide version of systemd? Because this might
also be a regression on their side.

