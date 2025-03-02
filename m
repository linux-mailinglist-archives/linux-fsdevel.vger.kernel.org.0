Return-Path: <linux-fsdevel+bounces-42905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4A3A4B323
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494AF3B0F47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5D1E9B23;
	Sun,  2 Mar 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ4Rt4gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3C339A8
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932959; cv=none; b=ZPvfrvaenepwkrKHjeYaBvLKR6JJJwCxieK+hdKVV0PmkPo1AF9lH8fKze+K1hfwcqGR8+4OP62nAlZ4LFTiGXMzMIQvdrUdWkZQJRfP+9qRun1AJ72IvoSetLMS/nhXjeAYo8nVJXbCk47nxHqzgZlR4is+mw6EFHz2Fd17oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932959; c=relaxed/simple;
	bh=/uMduYgRGJZbeZuj2qN3/8ZZ+jWRpBrqoZyAaJTMt6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdNK8tQN0aOqwnDsLXf6XCOZHwGOMu6sHoNvhsxEdqZjgw/pGsIWyACfXxAatK4RUAlEwg+lHf0BZo14aQ6SJuAzxvITiz/hU0xkevuu810fnWX7mbepwF/zCQKGtzNL3PCY6QhFo1B/QoWpmIPBHodcmTe8bA23QscULJjzAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ4Rt4gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47801C4CED6;
	Sun,  2 Mar 2025 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740932957;
	bh=/uMduYgRGJZbeZuj2qN3/8ZZ+jWRpBrqoZyAaJTMt6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQ4Rt4glRjtMlG3qxHyEfwNn/bBZnjY7cG8xDcMl+HTEMZbK6+rMlMAOlvlpcfM+0
	 Mhkmz+poSn4kR2S49NgqVtUCowvwdH+CkkfJnRFWaNd2mdjP61MBTSiWNf6LmjfIUS
	 TUkcicsC2l7nQKDHokhqlvP62tb/7AviJarHgwaRWeNLchaL0XoqZZKoiG5QTFWA9j
	 Mh/QLaTe6i8mNUt/5b/hMtvu8fPpoDBeVFtDpVHKtUIIqRfbFcQ1nA+ydz14b52hXG
	 AxHtjg+HEWv6wZ4+me4MtYM6okerzml+LYgEJhbEgm+qYgorXDIO4PmqJxQmLALERN
	 pPJGNrtFq5Y6Q==
Date: Sun, 2 Mar 2025 17:29:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250302155346.GD2664@redhat.com>

On Sun, Mar 02, 2025 at 04:53:46PM +0100, Oleg Nesterov wrote:
> On 02/28, Christian Brauner wrote:
> >
> > Some tools like systemd's jounral need to retrieve the exit and cgroup
> > information after a process has already been reaped.
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> But unless I am totally confused do_exit() calls pidfd_exit() even
> before exit_notify(), the exiting task is not even zombie yet. It
> will reaped only when it passes exit_notify() and its parent does
> wait().

The overall goal is that it's possible to retrieve exit status and
cgroupid even if the task has already been reaped.

It's intentionally placed before exit_notify(), i.e., before the task is
a zombie because exit_notify() wakes pidfd-pollers. Ideally, pidfd
pollers would be woken and then could use the PIDFD_GET_INFO ioctl to
retrieve the exit status.

It would however be fine to place it into exit_notify() if it's a better
fit there. If you have a preference let me know.

I don't see a reason why seeing the exit status before that would be an
issue. The only downside would be that some other task that just keeps
ioctl()ing in a loop would possible see the exit status before the
parent does. But I didn't think this would be a big issue.

> And what about the multi-threaded case? Suppose the main thread
> does sys_exit(0) and it has alive sub-threads.
> 
> In this case pidfd_info() will report kinfo.exit_code = 0.
> And this is probably fine if (file->f_flags & PIDFD_THREAD) != 0.

Yes.

> But what if this file was created without PIDFD_THREAD? If another
> thread does exit_group(1) after that, the process's exit code is
> 1 << 8, but it can't be retrieved.

Yes, I had raised that in an off-list discussion about this as well and
was unsure what the cleanest way of dealing with this would be.

My initial approach had been to not just have:

struct pidfs_exit_info {
        __u64 cgroupid;
        __s32 exit_code;
};


but to have:

struct pidfs_exit_info {
        __u64 cgroupid;
        __s32 exit_code;
	__u64 tg_cgroupid;
	__s32 tg_exit_code;
};

so that it would be possible to retrieve either depending on the type of
pidfd. Is that feasible?

> Finally, sys_execve(). Suppose we have a main thread L and a
> sub-thread T.
> 
> T execs and kill the leader L. L exits and populates
> pidfs_i(inode)->exit_info.
> 
> T calls exchange_tids() in de_thread() and becomes the new leader
> with the same (old) pid.
> 
> Now, T is very much alive, but pidfs_i(inode)->exit_info != NULL.

Yes, de_thread() is a good point. That nasty wrinkly I had really
ignored^wforgotten. We should not report an exit status in this case. I
think that's what you're agreeing with as well?

> Or I am totally confused?

No, you're right!

What's the best way of handling the de_thread() case? Would moving this
into exit_notify() be enough where we also handle
PIDFD_THREAD/~PIDFD_THREAD waking?

Thanks for the review!

> 
> 
> 
> > +	exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> > +	if (exit_info) {
> > +		/*
> > +		 * TODO: Oleg, I didn't see a reason for putting
> > +		 * retrieval of the exit status of a task behind some
> > +		 * form of permission check.
> 
> Neither me.
> 
> Oleg.
> 

