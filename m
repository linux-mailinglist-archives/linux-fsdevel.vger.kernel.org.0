Return-Path: <linux-fsdevel+bounces-34756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449B9C87A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807751F22FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15501FA824;
	Thu, 14 Nov 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPC+fwQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C811F8187;
	Thu, 14 Nov 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580187; cv=none; b=dTzxww/YrLnTpRcQd1wuAj/1ZPWgelrPfXnaj/Hxj9Ggrv285n0+Ihy96jihrCwPSSyKwV6DujNcijR0rLB7FH81Cf1DDly2Nvx1M6c6Qfs9uvDiazQI7/vMfL/LsFIbOCr4raIDMyaEc2lHMcct+FMezqMgfMH2C23vvMcUUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580187; c=relaxed/simple;
	bh=+Wl+UWTPCs1wkmx7v8OmQJiJQ9iDLhGqUaf6mi2Sol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUSQuR4B3GLEVdlE884m4ummr0OQA8juFn8DtP+oy0aEQjDWuemL5tjni7jleTibCZSYHag4j231n/QbZcnTLUXgJ5aN9BQhZ4cwfoRP4qbiQ3VwmGcqdplxzJbvC/s5hRGtI4tr/n+K2EsHp12HywZbKqPjeOLbDyMmBZkvm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPC+fwQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED45C4CECD;
	Thu, 14 Nov 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731580186;
	bh=+Wl+UWTPCs1wkmx7v8OmQJiJQ9iDLhGqUaf6mi2Sol8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPC+fwQg+ztYuZDmK9w/D1YSDCNWb2+6z4DAifAPI90OxRDQY7BDtJU9gRdYSlMsa
	 FzxTLucPR2WKSYOGR+eHZDIfLLIsSP8jE6RTsPDrbeVP89p0OmjEw6V+rewYl8Qkgi
	 IphxwphadVi9wuD9rqIudWhNlk4piQLvijoLVI0/xXci5Ocanu5b5jrZDCfoil26y4
	 NEbcUw/btuhyq9jhzurU/a1VZ759J3vwn6JEFwh3rxo2Ff+huxMfld4WslUoUXpikh
	 0KrmcA6qfamzaRkn39jDWEuXZ6+ODMoUlSGrDf1sA8ZJMdtY9NMgZRp627UbYjX/5v
	 UdE3RA2jMU3ww==
Date: Thu, 14 Nov 2024 11:29:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Message-ID: <20241114-minigolf-merkmal-613de487cfbb@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
 <65e22368-d4f8-45f5-adcb-4d8c297ae293@e43.eu>
 <20241113-entnimmt-weintrauben-3b0b4a1a18b7@brauner>
 <d71126d4-68e5-491a-be2d-3212636e7b60@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d71126d4-68e5-491a-be2d-3212636e7b60@e43.eu>

On Wed, Nov 13, 2024 at 02:48:43PM +0100, Erin Shepherd wrote:
> On 13/11/2024 14:26, Christian Brauner wrote:
> 
> > On Wed, Nov 13, 2024 at 02:06:56PM +0100, Erin Shepherd wrote:
> >> On 13/11/2024 13:09, Christian Brauner wrote:
> >>
> >>> Hm, a pidfd comes in two flavours:
> >>>
> >>> (1) thread-group leader pidfd: pidfd_open(<pid>, 0)
> >>> (2) thread pidfd:              pidfd_open(<pid>, PIDFD_THREAD)
> >>>
> >>> In your current scheme fid->pid = pid_nr(pid) means that you always
> >>> encode a pidfs file handle for a thread pidfd no matter if the provided
> >>> pidfd was a thread-group leader pidfd or a thread pidfd. This is very
> >>> likely wrong as it means users that use a thread-group pidfd get a
> >>> thread-specific pid back.
> >>>
> >>> I think we need to encode (1) and (2) in the pidfs file handle so users
> >>> always get back the correct type of pidfd.
> >>>
> >>> That very likely means name_to_handle_at() needs to encode this into the
> >>> pidfs file handle.
> >> I guess a question here is whether a pidfd handle encodes a handle to a pid
> >> in a specific mode, or just to a pid in general? The thought had occurred
> >> to me while I was working on this initially, but I felt like perhaps treating
> >> it as a property of the file descriptor in general was better.
> >>
> >> Currently open_by_handle_at always returns a thread-group pidfd (since
> >> PIDFD_THREAD) isn't set, regardless of what type of pidfd you passed to
> >> name_to_handle_at. I had thought that PIDFD_THREAD/O_EXCL would have been
> > I don't think you're returning a thread-groupd pidfd from
> > open_by_handle_at() in your scheme. After all you're encoding the tid in
> > pid_nr() so you'll always find the struct pid for the thread afaict. If
> > I'm wrong could you please explain how you think this works? I might
> > just be missing something obvious.
> 
> Moudlo namespaces, the pid in fid->pid is the same one passed to pidfd_open().
> In the root namespace, you could replace name_to_handle_at(...) with
> pidfd_open(fid->pid, 0) and get the same result (if both are successful, at least).
> 
> The resulting pidfd points to the same struct pid. The only thing that should differ
> is whether PIDFD_THREAD is set in f->f_flags.

I see what you mean but then there's another problem afaict.

Two cases:

(1) @pidfd_thread_group = pidfd_open(1234, 0)

    The pidfd_open() will succeed if the struct pid that 1234 resolves
    to is used as a thread-group leader.

(2) @pidfd_thread = pidfd_open(5678, PIDFD_THREAD)

    The pidfd_open() will succeed even if the struct pid that 5678
    resolves to isn't used as a thread-group leader.

    The resulting struct file will be marked as being a thread pidfd by
    raising O_EXCL.

(1') If (1) is passed to name_to_handle_at() a pidfs file handle is
     encoded for 1234. If later open_by_hande_at() is called then by
     default a thread-group leader pidfd is created. This is fine

(2') If (2) is passed to name_to_handle_at() a pidfs file handle is
     encoded for 5678. If later open_by_handle_at() is called then a
     thread-group leader pidfd will be created again.

So in (2') the caller has managed to create a thread-group leader pidfd
even though the struct pid isn't used as a thread-group leader pidfd.
Consequently, that pidfd is useless when passed to any of the pidfd_*()
system calls.

So basically, you need to verify that if O_EXCL isn't specified with
open_by_handle_at() that the struct pid that is resolved is used as a
thread-group leader and if not, refuse to create a pidfd.

Am I making sense?

> 
> >> I feel like leaving it up to the caller of open_by_handle_at might be better
> >> (because they are probably better informed about whether they want poll() to
> >> inform them of thread or process exit) but I could lean either way.
> > So in order to decode a pidfs file handle you want the caller to have to
> > specify O_EXCL in the flags argument of open_by_handle_at()? Is that
> > your idea?
> 
> If they want a PIDFD_THREAD pidfd, yes. I see it as similar to O_RDONLY, where its a
> flag that applies to the file descriptor but not to the underlying file.

This is probably fine.

> 
> While ideally we'd implement it from an API completeness perspective, practically I'm
> not sure how often the option would ever be used. While there are hundreds of reasons
> why you might want to track the state of another process, I struggle to think of cases
> where Process A needs to track Process B's threads besides a debugger (and a debugger
> is probably better off using ptrace), and it can happily track its own threads by just
> holding onto the pidfd.

We recently imlemented PIDFD_THREAD support because it is used inside
Netflix. I forgot the details thought tbh. So it's actually used. We
only implemented it once people requested it.

