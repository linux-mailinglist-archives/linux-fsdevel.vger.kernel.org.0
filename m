Return-Path: <linux-fsdevel+bounces-48356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7CAADDCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B73AC4B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653582580F9;
	Wed,  7 May 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GM5+LqYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B142135D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618701; cv=none; b=NrYof3BbZUxmHDwgbVNBlK+TacxrVQXFi7BLrCYUyKfmlhtGlpaIb4AcMyLO3KLjnvQ23AsYmoAdtZxBKRlQh2/1SM1prtNBL/VbmX1zge7X3jciYz5D9fjbsyiK32hADTQLwXRgGrgm9owqIMpSI9q6UefmtqhfBjlQXnpZFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618701; c=relaxed/simple;
	bh=kIPJFzOybRVKUZttYLjyp0h855fjPHYRSmr7h4xhlBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8xU8ydgrhFiEh7CDGk9luAqZWqwTTnx95GsHxgP9xO1a+0JXbcAsp3kJcwmKv7NJ3py7lCnuKFreJRTpwyPzHM0O3DA/D9n1hqkGbosh2gmT4HIdKDl75w/VO8aFgN+Bbp9DfQl1KaN9Mhyn9L7j+PV+uQU16RnRKFkLIbBxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GM5+LqYg; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zstry50t6zt16;
	Wed,  7 May 2025 13:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746618690;
	bh=ukRcsiWioIJpQnZONA7OOVHLy1rF/BILBsY01ynF49o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM5+LqYgqtdWSoNl6eaQIrraLqbPVitAXzcP6S0KIDJ7OQKcfOHf3zC7G/3SwUJN3
	 7YDEkyhiS3lDk3BxovPVOnTNfOcMkWX9Qzdeef5kNZ8gCB/YDpPzq+HJaL7m/9YbT9
	 fCrJQlqK0c83g4qp/xga2NlY/X5iszJ0UFyvvCqg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zstrx6DJNzTf6;
	Wed,  7 May 2025 13:51:29 +0200 (CEST)
Date: Wed, 7 May 2025 13:51:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brauner@kernel.org, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, jannh@google.com, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250507.ohsaiQuoh3uo@digikod.net>
References: <20250506-zugabe-bezog-f688fbec72d3@brauner>
 <20250506191817.14620-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506191817.14620-1-kuniyu@amazon.com>
X-Infomaniak-Routing: alpha

On Tue, May 06, 2025 at 12:18:12PM -0700, Kuniyuki Iwashima wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Tue, 6 May 2025 10:06:27 +0200
> > On Mon, May 05, 2025 at 09:10:28PM +0200, Jann Horn wrote:
> > > On Mon, May 5, 2025 at 8:41 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > > From: Christian Brauner <brauner@kernel.org>
> > > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > > Make sure that only tasks that actually coredumped may connect to the
> > > > > > > coredump socket. This restriction may be loosened later in case
> > > > > > > userspace processes would like to use it to generate their own
> > > > > > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > > > > > socket for that.
> > > > > >
> > > > > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > > > > could instead have a flag inside the af_unix client socket that says
> > > > > > "this is a special client socket for coredumping".
> > > > >
> > > > > Should be easily doable with a sock_flag().
> > > >
> > > > This restriction should be applied by BPF LSM.
> > > 
> > > I think we shouldn't allow random userspace processes to connect to
> > > the core dump handling service and provide bogus inputs; that
> > > unnecessarily increases the risk that a crafted coredump can be used
> > > to exploit a bug in the service. So I think it makes sense to enforce
> > > this restriction in the kernel.
> > > 
> > > My understanding is that BPF LSM creates fairly tight coupling between
> > > userspace and the kernel implementation, and it is kind of unwieldy
> > > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > > longer and describe more kernel implementation detail if you tried to
> > > show how to write a BPF LSM that is capable of detecting unix domain
> > > socket connections to a specific address that are not initiated by
> > > core dumping.) I would like to keep it possible to implement core
> > > userspace functionality in a best-practice way without needing eBPF.
> > > 
> > > > It's hard to loosen such a default restriction as someone might
> > > > argue that's unexpected and regression.
> > > 
> > > If userspace wants to allow other processes to connect to the core
> > > dumping service, that's easy to implement - userspace can listen on a
> > > separate address that is not subject to these restrictions.
> > 
> > I think Kuniyuki's point is defensible. And I did discuss this with
> > Lennart when I wrote the patch and he didn't see a point in preventing
> > other processes from connecting to the core dump socket. He actually
> > would like this to be possible because there's some userspace programs
> > out there that generate their own coredumps (Python?) and he wanted them
> > to use the general coredump socket to send them to.
> > 
> > I just found it more elegant to simply guarantee that only connections
> > are made to that socket come from coredumping tasks.
> > 
> > But I should note there are two ways to cleanly handle this in
> > userspace. I had already mentioned the bpf LSM in the contect of
> > rate-limiting in an earlier posting:
> > 
> > (1) complex:
> > 
> >     Use a bpf LSM to intercept the connection request via
> >     security_unix_stream_connect() in unix_stream_connect().
> > 
> >     The bpf program can simply check:
> > 
> >     current->signal->core_state
> > 
> >     and reject any connection if it isn't set to NULL.
> > 
> >     The big downside is that bpf (and security) need to be enabled.
> >     Neither is guaranteed and there's quite a few users out there that
> >     don't enable bpf.

The kernel should indeed always have a minimal security policy in place,
LSM can tailored that but we should not assume that a specific LSM with
a specific policy is enabled/configured on the system.

> > 
> > (2) simple (and supported in this series):
> > 
> >     Userspace accepts a connection. It has to get SO_PEERPIDFD anyway.
> >     It then needs to verify:
> > 
> >     struct pidfd_info info = {
> >             info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
> >     };
> > 
> >     ioctl(pidfd, PIDFD_GET_INFO, &info);
> >     if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> >             // Can't be from a coredumping task so we can close the
> > 	    // connection without reading.
> > 	    close(coredump_client_fd);
> > 	    return;
> >     }
> > 
> >     /* This has to be set and is only settable by do_coredump(). */
> >     if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> >             // Can't be from a coredumping task so we can close the
> > 	    // connection without reading.
> > 	    close(coredump_client_fd);
> > 	    return;
> >     }
> > 
> >     // Ok, this is a connection from a task that has coredumped, let's
> >     // handle it.

What if the task send a "fake" coredump and just after that really
coredump?  There could be a race condition on the server side when
checking the coredump property of this pidfd.

Could we add a trusted header to the coredump payload that is always
written by the kernel?  This would enable to read a trusted flag
indicating if the following payload is a coredumped generated by the
kernel or not.

> > 
> >     The crux is that the series guarantees that by the time the
> >     connection is made the info whether the task/thread-group did
> >     coredump is guaranteed to be available via the pidfd.
> >  
> > I think if we document that most coredump servers have to do (2) then
> > this is fine. But I wouldn't mind a nod from Jann on this.
> 
> I like this approach (2) allowing users to filter the right client.
> This way we can extend the application flexibly for another coredump
> service.

