Return-Path: <linux-fsdevel+bounces-48183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C93AABCAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAD1B61B44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A1221FD8;
	Tue,  6 May 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EylYSC+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C321D3C9;
	Tue,  6 May 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518795; cv=none; b=srPuEjqJGPjSK8bwHkJu2ApleERyRUx7eWQuAl1EArhA3kOsCW3fux1aVoGh1VDNC9ZdtItqgdS6PV5bKIiQR+N7oq4PmorFLRBNjPFtc6Wq1K89tsbK8nEErN2d5E4Rn8k63SR23zvREWmwSh+I24zDUyDlNna0+RyJRfdIDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518795; c=relaxed/simple;
	bh=xBVf+USjaN2b46y+i8ZxNLUPXMEkl18B42uMt5ZF8Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2rsF8hzvIoct9aSoQxDdyTklCgpJBWbf73Elh/cC9hi5xISesFAafXhc+kTxkIKowo19GkVu6WVdFRcjq3sgeyr5AS0kT2DnLHWcGecPbPsiG+3QTyOnIAhBktxhPV0x1iX+IheWdFNhdNF6i6EXQ/L4sJl7wIhC9TU1p6lJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EylYSC+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01620C4CEE4;
	Tue,  6 May 2025 08:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746518794;
	bh=xBVf+USjaN2b46y+i8ZxNLUPXMEkl18B42uMt5ZF8Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EylYSC+V8AWbshXqQqYtWI2wZCpFaPqMY0n3ALUAAWccDAiLeiB41bAfldq+XJFrE
	 FDzN0dGVB2gTFYKblVQsSmEg4SMZeQ37BVzEG0lymYgQKXOWTfW3/62o7dZ78SZPkR
	 5ZD/0ahDIeCQGKRSzfBTwTeQ1Tcko2+SAENZc4dxJcGV6d9UR30fVjOe6vvzybYKXh
	 IMY1VfckZ7w6GyMG5rjKGqDPltkbb6NXc22Y6zzqgLUG+nsNPfAco1MrZThALl+UPm
	 WWh0eI4vRIlJ7whfduueC5Am75ScxesnLyBmbfuIpUl8NoZ2AX1V/OV6nKbXN7FJus
	 umTUcrP5Zi2GA==
Date: Tue, 6 May 2025 10:06:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250506-zugabe-bezog-f688fbec72d3@brauner>
References: <20250505-dompteur-hinhalten-204b1e16bd02@brauner>
 <20250505184136.14852-1-kuniyu@amazon.com>
 <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>

On Mon, May 05, 2025 at 09:10:28PM +0200, Jann Horn wrote:
> On Mon, May 5, 2025 at 8:41 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Mon, 5 May 2025 16:06:40 +0200
> > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > Make sure that only tasks that actually coredumped may connect to the
> > > > > coredump socket. This restriction may be loosened later in case
> > > > > userspace processes would like to use it to generate their own
> > > > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > > > socket for that.
> > > >
> > > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > > could instead have a flag inside the af_unix client socket that says
> > > > "this is a special client socket for coredumping".
> > >
> > > Should be easily doable with a sock_flag().
> >
> > This restriction should be applied by BPF LSM.
> 
> I think we shouldn't allow random userspace processes to connect to
> the core dump handling service and provide bogus inputs; that
> unnecessarily increases the risk that a crafted coredump can be used
> to exploit a bug in the service. So I think it makes sense to enforce
> this restriction in the kernel.
> 
> My understanding is that BPF LSM creates fairly tight coupling between
> userspace and the kernel implementation, and it is kind of unwieldy
> for userspace. (I imagine the "man 5 core" manpage would get a bit
> longer and describe more kernel implementation detail if you tried to
> show how to write a BPF LSM that is capable of detecting unix domain
> socket connections to a specific address that are not initiated by
> core dumping.) I would like to keep it possible to implement core
> userspace functionality in a best-practice way without needing eBPF.
> 
> > It's hard to loosen such a default restriction as someone might
> > argue that's unexpected and regression.
> 
> If userspace wants to allow other processes to connect to the core
> dumping service, that's easy to implement - userspace can listen on a
> separate address that is not subject to these restrictions.

I think Kuniyuki's point is defensible. And I did discuss this with
Lennart when I wrote the patch and he didn't see a point in preventing
other processes from connecting to the core dump socket. He actually
would like this to be possible because there's some userspace programs
out there that generate their own coredumps (Python?) and he wanted them
to use the general coredump socket to send them to.

I just found it more elegant to simply guarantee that only connections
are made to that socket come from coredumping tasks.

But I should note there are two ways to cleanly handle this in
userspace. I had already mentioned the bpf LSM in the contect of
rate-limiting in an earlier posting:

(1) complex:

    Use a bpf LSM to intercept the connection request via
    security_unix_stream_connect() in unix_stream_connect().

    The bpf program can simply check:

    current->signal->core_state

    and reject any connection if it isn't set to NULL.

    The big downside is that bpf (and security) need to be enabled.
    Neither is guaranteed and there's quite a few users out there that
    don't enable bpf.

(2) simple (and supported in this series):

    Userspace accepts a connection. It has to get SO_PEERPIDFD anyway.
    It then needs to verify:

    struct pidfd_info info = {
            info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
    };

    ioctl(pidfd, PIDFD_GET_INFO, &info);
    if (!(info.mask & PIDFD_INFO_COREDUMP)) {
            // Can't be from a coredumping task so we can close the
	    // connection without reading.
	    close(coredump_client_fd);
	    return;
    }

    /* This has to be set and is only settable by do_coredump(). */
    if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
            // Can't be from a coredumping task so we can close the
	    // connection without reading.
	    close(coredump_client_fd);
	    return;
    }

    // Ok, this is a connection from a task that has coredumped, let's
    // handle it.

    The crux is that the series guarantees that by the time the
    connection is made the info whether the task/thread-group did
    coredump is guaranteed to be available via the pidfd.
 
I think if we document that most coredump servers have to do (2) then
this is fine. But I wouldn't mind a nod from Jann on this.

