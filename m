Return-Path: <linux-fsdevel+bounces-49238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A3AB9A45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F98550072B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26823642E;
	Fri, 16 May 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuymrrxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C174235340;
	Fri, 16 May 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391661; cv=none; b=HD7NGSVUvWJ0Yr8m6CyFxXJmM5dHaU47D2oYbfsjG3qX81bbAy7GcvSm6beS89nzMKuzm9xH9NpF30XXN9cAexdz0VIQQEo0gJ/uJ+sanCpozZFgQZON7b5KNzzxWXvjf7Lax5bhVWh48PTxxGy8ZJK/ruPE2mVX8MSHh2+noOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391661; c=relaxed/simple;
	bh=OLawM77/pj4I/rWOm9zcrUGjJDrRfHM+96CF1DvxGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOgncdb6HKyYU3XDs0mUD+sevSA+eIIo26TKBdhBzd1ny4q1NEGYtd5vgMitezXo64X9iZuf5xJzT0GxQcsKZhW4afHtoR9kKfEoD7eGU7KeSyrXIbB+1XJHP3J+q2NHMVrgo1ABUIU24xcOqZMv5saq7Dl7PdL0naWrCAFldJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cuymrrxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129F2C4CEE4;
	Fri, 16 May 2025 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747391660;
	bh=OLawM77/pj4I/rWOm9zcrUGjJDrRfHM+96CF1DvxGgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuymrrxnrYD7Ka9ndiuRflWUEVaTAgCxSrx9m0FttyMA/0+bEBf6qUQ6FPX+Hz6Aq
	 CF4eK0pP8zob9s6zmluMBPjGdN74rEWgBFe78tKoE4uziB7Qlz8wwji1Z0ce0okA7s
	 ZsnpJnqhnQR89Sq+fvfoB9AT8cfcKM0PeX8onZ/Bkw51RHSvBM0V4ak7GeW5DOWCxe
	 0Ar0E4GowdLJ3hv0z34NBPzPSu1WP2ohiNGtE+NiKgI6crDJwRr7PNBPwBAczlVOVD
	 pNEg9Y18vGKbkgArlgswDlLjhowyQVQkUIlze6UwPRZcjT2nOeWYhOpmkhiZis/0Cf
	 3rCsO6VLK7Z8Q==
Date: Fri, 16 May 2025 12:34:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
Message-ID: <20250516-anfliegen-mausklick-adf097dad304@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
 <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>

On Thu, May 15, 2025 at 10:56:26PM +0200, Jann Horn wrote:
> On Thu, May 15, 2025 at 12:04 AM Christian Brauner <brauner@kernel.org> wrote:
> > Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> > mask flag. This adds the fields @coredump_mask and @coredump_cookie to
> > struct pidfd_info.
> 
> FWIW, now that you're using path-based sockets and override_creds(),
> one option may be to drop this patch and say "if you don't want
> untrusted processes to directly connect to the coredumping socket,
> just set the listening socket to mode 0000 or mode 0600"...
> 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> [...]
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index e1256ebb89c1..bfc4a32f737c 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> [...]
> > @@ -876,8 +880,34 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >                         goto close_fail;
> >                 }
> >
> > +               /*
> > +                * Set the thread-group leader pid which is used for the
> > +                * peer credentials during connect() below. Then
> > +                * immediately register it in pidfs...
> > +                */
> > +               cprm.pid = task_tgid(current);
> > +               retval = pidfs_register_pid(cprm.pid);
> > +               if (retval) {
> > +                       sock_release(socket);
> > +                       goto close_fail;
> > +               }
> > +
> > +               /*
> > +                * ... and set the coredump information so userspace
> > +                * has it available after connect()...
> > +                */
> > +               pidfs_coredump(&cprm);
> > +
> > +               /*
> > +                * ... On connect() the peer credentials are recorded
> > +                * and @cprm.pid registered in pidfs...
> 
> I don't understand this comment. Wasn't "@cprm.pid registered in
> pidfs" above with the explicit `pidfs_register_pid(cprm.pid)`?

I'll answer both questions in one go below...

> 
> > +                */
> >                 retval = kernel_connect(socket, (struct sockaddr *)(&addr),
> >                                         addr_len, O_NONBLOCK | SOCK_COREDUMP);
> > +
> > +               /* ... So we can safely put our pidfs reference now... */
> > +               pidfs_put_pid(cprm.pid);
> 
> Why can we safely put the pidfs reference now but couldn't do it
> before the kernel_connect()? Does the kernel_connect() look up this
> pidfs entry by calling something like pidfs_alloc_file()? Or does that
> only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?

AF_UNIX sockets support SO_PEERPIDFD as you know. Users such as dbus or
systemd want to be able to retrieve a pidfd for the peer even if the
peer has already been reaped. To support this AF_UNIX ensures that when
the peer credentials are set up (connect(), listen()) the corresponding
@pid will also be registered in pidfs. This ensures that exit
information is stored in the inode if we hand out a pidfd for a reaped
task. IOW, we only hand out pidfds for reaped task if at the time of
reaping a pidfs entry existed for it.

Since we're setting coredump information on the pidfd here we're calling
pidfs_register_pid() even before connect() sets up the peer credentials
so we're sure that the coredump information is stored in the inode.

Then we delay our pidfs_put_pid() call until the connect() took it's own
reference and thus continues pinning the inode. IOW, connect() will also
call pidfs_register_pid() but it will ofc just increment the reference
count ensuring that our pidfs_put_pid() doesn't drop the inode.

If we immediately did a pidfs_put_pid() before connect() we'd loose the
coredump information.

> 
> >                 if (retval) {
> >                         if (retval == -EAGAIN)
> >                                 coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
> [...]
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 3b39e471840b..d7b9a0dd2db6 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> [...]
> > @@ -280,6 +299,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
> >                 }
> >         }
> >
> > +       if (mask & PIDFD_INFO_COREDUMP) {
> > +               kinfo.mask |= PIDFD_INFO_COREDUMP;
> > +               smp_rmb();
> 
> I assume I would regret it if I asked what these barriers are for,
> because the answer is something terrifying about how we otherwise
> don't have a guarantee that memory accesses can't be reordered between
> multiple subsequent syscalls or something like that?

No, not really. It's just so that when someone calls PIDFD_GET_INFO with
PIDFD_INFO_COREDUMP but one gotten from the coredump socket that they
don't see half-initialized information. I can just use WRITE_ONCE() for
that.

> 
> checkpatch complains about the lack of comments on these memory barriers.

I'll just use WRITE_ONCE().

> 
> > +               kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
> > +               kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
> > +       }
> > +
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> >                 /*
> [...]
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index a9d1c9ba2961..053d2e48e918 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> [...]
> > @@ -742,6 +743,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
> >
> >  struct unix_peercred {
> >         struct pid *peer_pid;
> > +       u64 cookie;
> 
> Maybe add a comment here documenting that for now, this is assumed to
> be used exclusively for coredump sockets.

I think we should just drop it.

