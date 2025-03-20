Return-Path: <linux-fsdevel+bounces-44597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57EEA6A8C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C862189F6E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC521D63DA;
	Thu, 20 Mar 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfJ82MWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EC1C5D77
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481126; cv=none; b=ZZNGYixvKsk/RcrBWQzhJRWqiNF1HmrCnla923YyXX0EhfJX6JYTilydndorLojkPTqkKCIiMAW65wPkL3hdSlHPA7UZg/OMMI/2Aidt+v3Bzw40dab2bk4KS+JY+Gtq0+E7yNuB5I0/dJZdl2TMTCejQk2AbG5ekghs+U5+kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481126; c=relaxed/simple;
	bh=x3rx5y5bS6zJzOBbuJmSeYptnEPVAOZxKshEmcDR6nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHvWquoTzsayv0FXHJlIwCxLsaq58/dnEvKFpe0UkqXlu9x/awR5Md7YVJK5s/P342ChMLdK55WBkD6Abe0fVf/E3pq/0y/eRyFUb1fFaGbSgad7SvqWXjeG8OIC2AA+3rXwlACpMqrG4BJTbSjfcDfvlUpwVPyDTzQJ0r7hV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfJ82MWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCAFC4CEDD;
	Thu, 20 Mar 2025 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481125;
	bh=x3rx5y5bS6zJzOBbuJmSeYptnEPVAOZxKshEmcDR6nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfJ82MWhMrObOKUHVJtj5af7iOQ6P+XHO0aBg/y0X9yZUPvYYBzTXsl0sDe/e8M9b
	 5jUltwJPOQsOmRz8NswCvHWeWZRJEfGWBZyyPE/JJ7Ifzqnt6uSf1DrHTUjQ5Gihyp
	 m6UUPc4G/vszx556mhBv+s34ZCdTQljMGKdo8ckfoeSduyuqPgrw/bN+utwiMyp2wo
	 fzwPe1Llw826fYrw9DiDyyjVCFzMw5T1HMaEFchfYXl1slwUrkF3f/HqozJa3No2kj
	 UocJjfzAo5aMuR+O8eAuj0Q387wIQVVWnMmDzwTOBtHAAB/QtypkO+XzFYepZskJ4E
	 u9Z5xXTlFdCrg==
Date: Thu, 20 Mar 2025 15:32:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320-amtsmissbrauch-wochen-97b5dd092bdf@brauner>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
 <20250320105701.GA11256@redhat.com>
 <20250320-erzwungen-adjektiv-6a73b88f5f30@brauner>
 <20250320140159.GD11256@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320140159.GD11256@redhat.com>

On Thu, Mar 20, 2025 at 03:02:00PM +0100, Oleg Nesterov wrote:
> On 03/20, Christian Brauner wrote:
> >
> > What you seem to be saying is that you want all references to
> > PIDFD_THREAD to be dropped in the comments because the behavior is now
> > identical.
> 
> yes, to me the references to PIDFD_THREAD look as if PIDFD_THREAD
> has some subtle differences in behavior.
> 
> With or without PIDFD_THREAD, do_notify_pidfd() is called and pidfd_poll()
> returns EPOLLIN when this thread (leader or not) is ready for wait() from
> the parent or debugger.
> 
> But!
> 
> > So I'm wiping the comments but I very much disagree that they are
> > misleading/useless.
> 
> No, if you don't agree than do not remove the comments ;)

No, it's fine. We always find some compromise and I've reworded the
comments substantially to not rely on PIDFD_THREAD at all. I always
appreciate the feedback, don't get me wrong!

> And... can you explain the motivation for this patch?

Yes, sure.

> 
> I mean... Again, the current PIDFD_THREAD/group-leader behavior is
> not well defined, this is clear.
> 
> But if user-space does sys_pidfd_open(group_leader_pid) and needs the
> "correct" EPOLLIN when the whole process exits, then it should not use
> PIDFD_THREAD ?
> 
> Just in case, I am not arguing, I am just trying to understand.

One driver is consistency. It's really weird to sometimes get exit
notifications and sometimes don't. It's easier to understand that we
delay notification until the thread-group is empty for a thread-based
pidfd for a thread-group leader rather than explaining de_thread()
timing issues for subthread exec.

But also remembering our earlier discussion on PIDFD_INFO_EXIT: If the
thread-group leader exits prematurely and userspace gets an exit
notification they end up with a Zombie they cannot (yet) reap.

I don't think we should carry that behavior over into the pidfd api. I'd
rather have it be so that if you get an exit notification it means that
you can may now reap the thing (I'm probably unaware of some ptrace
induced behavior that render this statement wrong.).

