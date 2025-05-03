Return-Path: <linux-fsdevel+bounces-47985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B5DAA7E87
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 07:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D95A62EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 05:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE8198E77;
	Sat,  3 May 2025 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbmSolHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC683CA52;
	Sat,  3 May 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746249441; cv=none; b=E0HysUQz+ERx9i6cMH5M7aWUwQfpUtKz072GkzIiTNAoQIOlSTBDxCf1xQQmugkvbSe15Gj06gP4xEKeHvLaKUce5yB8DR4iRK9/bB74eVu1EJ0qFenl9Gtv/kOgYSbfObOA77vvVPLxE+mPeywuH3Ekdsn7/xj05L7zaNRIud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746249441; c=relaxed/simple;
	bh=NtXY30Dv3krCspHEC8zJop5QFtGlbok9AAUJlq8WnMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOx6M/J3BocwBC7JJ3GUsvvOzXszwLwDaPwkdVCbedD33DMNxphrrroTlvvPTG0vLmurC49VOz2M6EOeNtybhAZMmOHxih8neNn11fWsShYOUYPPSpOG7YtKIt4m28DSgZ+r80TqL2iWwVGXvJ1NErhjxm9IKzuLp9xO7VoEXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbmSolHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3CEC4CEE3;
	Sat,  3 May 2025 05:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746249438;
	bh=NtXY30Dv3krCspHEC8zJop5QFtGlbok9AAUJlq8WnMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbmSolHzbX8X8Q9P93OoIefr1VBlhzYs10usZIXCJRyF0uBajG+j1EKC3Hzn4wwum
	 KYZy7hqU3okWnRIxV/NAlKR5bLpZ2xariTDwbybcFZ6Q2Kb/vHYGdOn0p2g+Ub4WIb
	 VAev/trvylZqJmbxMGpI7uL3rVAkGy1D7FyMd8as7mufis5ejcleW9jkxk/RNQG+Hy
	 9X8DxkbS/B1e+1JHqUeK21XXYqpv1JrrMIkFCXbQvsI+7ZUzFG4iUf2LHxt454JUPa
	 2zvNwbKDuC+HGMTsehdtOix/mh9BV7CvAg34rnDDCI1+gYOoUzk7H28ISrMXnrpZKY
	 m9m6ReTklKNAA==
Date: Sat, 3 May 2025 07:17:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/6] coredump: support AF_UNIX sockets
Message-ID: <20250503-gegessen-trugen-6474e70e59df@brauner>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
 <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
 <CAG48ez1w+25tbSPPU6=z1rWRm3ZXuGq0ypq4jffhzUva9Bwazw@mail.gmail.com>
 <20250502-fanden-unbeschadet-89973225255f@brauner>
 <CAG48ez3xYzzazbxcHKEFzj9DDMOrnVf1cfjNpwE_FAY-YhtHmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3xYzzazbxcHKEFzj9DDMOrnVf1cfjNpwE_FAY-YhtHmw@mail.gmail.com>

On Fri, May 02, 2025 at 10:23:44PM +0200, Jann Horn wrote:
> On Fri, May 2, 2025 at 10:11 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, May 02, 2025 at 04:04:32PM +0200, Jann Horn wrote:
> > > On Fri, May 2, 2025 at 2:42 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > [...]
> > > > @@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> > > >                 }
> > > >                 break;
> > > >         }
> > > > +       case COREDUMP_SOCK: {
> > > > +               struct file *file __free(fput) = NULL;
> > > > +#ifdef CONFIG_UNIX
> > > > +               ssize_t addr_size;
> > > > +               struct sockaddr_un unix_addr = {
> > > > +                       .sun_family = AF_UNIX,
> > > > +               };
> > > > +               struct sockaddr_storage *addr;
> > > > +
> > > > +               /*
> > > > +                * TODO: We need to really support core_pipe_limit to
> > > > +                * prevent the task from being reaped before userspace
> > > > +                * had a chance to look at /proc/<pid>.
> > > > +                *
> > > > +                * I need help from the networking people (or maybe Oleg
> > > > +                * also knows?) how to do this.
> > > > +                *
> > > > +                * IOW, we need to wait for the other side to shutdown
> > > > +                * the socket/terminate the connection.
> > > > +                *
> > > > +                * We could just read but then userspace could sent us
> > > > +                * SCM_RIGHTS and we just shouldn't need to deal with
> > > > +                * any of that.
> > > > +                */
> > >
> > > I don't think userspace can send you SCM_RIGHTS if you don't do a
> > > recvmsg() with a control data buffer?
> >
> > Oh hm, then maybe just a regular read at the end would work. As soon as
> > userspace send us anything or we get a close event we just disconnect.
> >
> > But btw, I think we really need a recvmsg() flag that allows a receiver
> > to refuse SCM_RIGHTS/file descriptors from being sent to it. IIRC, right
> > now this is a real issue that systemd works around by always calling its
> > cmsg_close_all() helper after each recvmsg() to ensure that no one sent
> > it file descriptors it didn't want. The problem there is that someone
> > could have sent it an fd to a hanging NFS server or something and then
> > it would hang in close() even though it never even wanted any file
> > descriptors in the first place.
> 
> Would a recvmsg() flag really solve that aspect of NFS hangs? By the
> time you read from the socket, the file is already attached to an SKB
> queued up on the socket, and cleaning up the file is your task's
> responsibility either way (which will either be done by the kernel for
> you if you don't read it into a control message, or by userspace if it
> was handed off through a control message). The process that sent the
> file to you might already be gone, it can't be on the hook for
> cleaning up the file anymore.

Hm, I guess the unix_gc() runs in task context? I had thought that it
might take care of that.

> 
> I think the thorough fix would probably be to introduce a socket
> option (controlled via setsockopt()) that already blocks the peer's
> sendmsg().

Yes, I had considered that as well.

> 
> > > > +                * In general though, userspace should just mark itself
> > > > +                * non dumpable and not do any of this nonsense. We
> > > > +                * shouldn't work around this.
> > > > +                */
> > > > +               addr = (struct sockaddr_storage *)(&unix_addr);
> > > > +               retval = __sys_connect_file(file, addr, addr_size, O_CLOEXEC);
> > >
> > > Have you made an intentional decision on whether you want to connect
> > > to a unix domain socket with a path relative to current->fs->root (so
> > > that containers can do their own core dump handling) or relative to
> > > the root namespace root (so that core dumps always reach the init
> > > namespace's core dumping even if a process sandboxes itself with
> > > namespaces or such)? Also, I think this connection attempt will be
> >
> > Fsck no. :) I just jotted this down as an RFC. Details below.
> >
> > > subject to restrictions imposed by (for example) Landlock or AppArmor,
> > > I'm not sure if that is desired here (since this is not actually a
> > > connection that the process in whose context the call happens decided
> > > to make, it's something the system administrator decided to do, and
> > > especially with Landlock, policies are controlled by individual
> > > applications that may not know how core dumps work on the system).
> > >
> > > I guess if we keep the current behavior where the socket path is
> > > namespaced, then we also need to keep the security checks, since an
> > > unprivileged user could probably set up a namespace and chroot() to a
> > > place where the socket path (indirectly, through a symlink) refers to
> > > an arbitrary socket...
> > >
> > > An alternative design might be to directly register the server socket
> > > on the userns/mountns/netns or such in some magic way, and then have
> > > the core dumping walk up the namespace hierarchy until it finds a
> > > namespace that has opted in to using its own core dumping socket, and
> > > connect to that socket bypassing security checks. (A bit like how
> > > namespaced binfmt_misc works.) Like, maybe userspace with namespaced
> >
> > Yeah, I namespaced that thing. :)
> 
> Oh, hah, sorry, I forgot that was you.
> 
> > > CAP_SYS_ADMIN could bind() to some magic UNIX socket address, or use
> > > some new setsockopt() on the socket or such, to become the handler of
> > > core dumps? This would also have the advantage that malicious
> > > userspace wouldn't be able to send fake bogus core dumps to the
> > > server, and the server would provide clear consent to being connected
> > > to without security checks at connection time.
> >
> > I think that's policy that I absolute don't want the kernel to get
> > involved in unless absolutely necessary. A few days ago I just discussed
> > this at length with Lennart and the issue is that systemd would want to
> > see all coredumps on the system independent of the namespace they're
> > created in. To have a per-namespace (userns/mountns/netns) coredump
> > socket would invalidate that one way or the other and end up hiding
> > coredumps from the administrator unless there's some elaborate scheme
> > where it doesn't.
> >
> > systemd-coredump (and Apport fwiw) has infrastructure to forward
> > coredumps to individual services and containers and it's already based
> > on AF_UNIX afaict. And I really like that it's the job of userspace to
> > deal with this instead of the kernel having to get involved in that
> > mess.
> >
> > So all of this should be relative to the initial namespace. I want a
> 
> Ah, sounds good.
> 
> > separate security hook though so an LSMs can be used to prevent
> > processes from connecting to the coredump socket.
> >
> > My idea has been that systemd-coredump could use a bpf lsm program that
> > would allow to abort a coredump before the crashing process connects to
> > the socket and again make this a userspace policy issue.
> 
> I don't understand this part. Why would you need an LSM to prevent a
> crashing process from connecting, can't the coredumping server process
> apply whatever filtering it wants in userspace?

Coredumping is somewhat asynchronous in that the crash-dumping process
already starts writing by the time userspace could've made a decision
whether it should bother in the first place. Then userspace would need
to terminate the connection so that the kernel stops writing.

With a bpf LSM you could make a decision right when the connect happens
whether the task is even allowed to connect to the coredump socket in
the first place. This would also allow-rate limiting a reapeatedly
coredumping service/container.

