Return-Path: <linux-fsdevel+bounces-46287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AAA86182
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC7E3AF6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4070320CCE8;
	Fri, 11 Apr 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+3fPpCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF451F3BA2;
	Fri, 11 Apr 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384481; cv=none; b=YWBzhVyDYrIEvii6AZZyUQSGKav9sQUtcg4sSD3AcLOulks6AopExKbSRcrb6Z1kD/irVkzDug6QV6A6YMahcpcW74XV5zKp2u/XCEMHC16KMucblvz6fmKSKnNdbORIYMRKopaUrpyLK7XqWN4yBAt4vQuhMsVuNc01O0qm9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384481; c=relaxed/simple;
	bh=gmBY25FRzaUixYh0G1dDKVBQRxr2w2r5aRoTTgcp2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWJn9FJbZFhzXTuuDFiiwBOtpxG5gPnMSI8SnT4hr+vMddXRQbeBSd0QrkGe6C86WEM+0uVu19YeWoIMc0wUnw8vvM+Qhatx0gmUE6z+mH/c92a7gPxoc+U8zun2Y6w+1oLYUkbweYB7ocjSqynDRiW5Gjzomh8SJWUWkophRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+3fPpCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE23C4CEE2;
	Fri, 11 Apr 2025 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744384481;
	bh=gmBY25FRzaUixYh0G1dDKVBQRxr2w2r5aRoTTgcp2+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+3fPpCi/CDANgwrbccX92QDrQF2CJRkW58ZclYe9dBOso6Fsm3+5m1zt0KEZIZFQ
	 iqauIAri4PjH5TbX674tVfDC+TaZNDeqMlIkjlS0rMlZ1xes6LVfKRfzvHhBbS57eq
	 1yb4ncdXEoEgQgGvqZIyAgZ2rP+FhlkbMNzf7CPhQbtkZ28bvkHkWh2IBCGGpqqFwr
	 HeLQfvRQnrOBC6982MmtbzV55eev66GJ3EFUmokbrTPR9EKovFAI+TXQKo1R49aG1O
	 1GH9b4lBK1d1dQWt7RqXx+soS5jY4wnL0b9hSAzZRdYFkjRDjBa5PDbA+gfJthgX97
	 7s+AM9LDmeWdg==
Date: Fri, 11 Apr 2025 17:14:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250411-abbitten-caravan-ec53428b33e0@brauner>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
 <20250411-work-pidfs-enoent-v2-2-60b2d3bb545f@kernel.org>
 <20250411135445.GF5322@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411135445.GF5322@redhat.com>

On Fri, Apr 11, 2025 at 03:54:45PM +0200, Oleg Nesterov wrote:
> For both patches:
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> a minor nit below...
> 
> On 04/11, Christian Brauner wrote:
> >
> >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> >  {
> > -	int err = 0;
> > -
> > -	if (!(flags & PIDFD_THREAD)) {
> > +	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
> > +		/*
> > +		 * If this wasn't a thread-group leader struct pid or
> > +		 * the task already been reaped report ESRCH to
> > +		 * userspace.
> > +		 */
> > +		if (!pid_has_task(pid, PIDTYPE_PID))
> > +			return -ESRCH;
> 
> The "If this wasn't a thread-group leader struct pid" part of the
> comment looks a bit confusing to me, as if pid_has_task(PIDTYPE_PID)
> should return false in this case.

Ok.

> 
> OTOH, perhaps it makes sense to explain scoped_guard(wait_pidfd.lock)?
> Something like "see unhash_process -> wake_up_all(), detach_pid(TGID)
> isn't possible if pid_has_task(PID) succeeds".

I'm verbose. I hope you can live with it:

        /*
         * While holding the pidfd waitqueue lock removing the task
         * linkage for the thread-group leader pid (PIDTYPE_TGID) isn't
         * possible. Thus, if there's still task linkage for PIDTYPE_PID
         * not having thread-group leader linkage for the pid means it
         * wasn't a thread-group leader in the first place.
         */

:)

