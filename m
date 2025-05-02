Return-Path: <linux-fsdevel+bounces-47949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70260AA7A97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A173ACF07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E81F5433;
	Fri,  2 May 2025 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv864FeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023701F30DD;
	Fri,  2 May 2025 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216665; cv=none; b=syiHbkXRBRCKwXIfrm8i8QeVKSuwNYJPLw60uaEovVlrsiuPEhK/yK6hnJ6lgvZlt4pnLwRTSm7jOHM3s2xr7sDrPdkAOqRmlfcX3Z05qDWMTfQstFQWepwm8s8XS4DVffbELeiMqrTPWFp9MTFzevonOHCvA4kugQwW5RgvFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216665; c=relaxed/simple;
	bh=iTuW9YI+dyuT02HLYxJyyxkPKnlk5po8c12xAAkhwpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btc08IcTIyLS9U84eH3vCOneQY6L9JG0mkqXvQ0xYWKLOTjlLIkJPVj4MHj4KQxVxuagrjCHFrzct9JjulRHUz4UHaERCntiMELbL5/+sUZ/yjVKJxYkq89WfJJvAbsC9vsuMguzMaDmx4jKcE4l4W3QxQjVRRTxd2IN3lJ69Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv864FeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB5C4CEE4;
	Fri,  2 May 2025 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216664;
	bh=iTuW9YI+dyuT02HLYxJyyxkPKnlk5po8c12xAAkhwpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sv864FeBd9KxTRdvKgOZ+axY1H8VJH6iQ6cUVIomlzaF8Tt9DU1hTss3RaV0GZGw0
	 RKet8XeU2WIeWeupCA3Z9iHmv84YHtpKjuDx2zS50DsC7PFGE3b0m1BzZhn6cqY0iw
	 ZiOVbf4T5FM1pJ38MSl5brA85uW6PChKkKaCJiMldiQgECJympibLARyoEuarBSxjo
	 Jp9rOnCwV3RTUZJmrxWtRmwna1eihF+o7ly+2lZSOrU06Jk4AfecpZXmte8Y09CbPd
	 6lzKD8lSPHAJyJbSj9PDcRHDM5i4A1KjJtHmmESVkhFiw/Tp+pLNeiEVbXUFW6hF8c
	 G56Lo/9mbOmqw==
Date: Fri, 2 May 2025 22:10:57 +0200
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
Message-ID: <20250502-fanden-unbeschadet-89973225255f@brauner>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
 <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
 <CAG48ez1w+25tbSPPU6=z1rWRm3ZXuGq0ypq4jffhzUva9Bwazw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1w+25tbSPPU6=z1rWRm3ZXuGq0ypq4jffhzUva9Bwazw@mail.gmail.com>

On Fri, May 02, 2025 at 04:04:32PM +0200, Jann Horn wrote:
> On Fri, May 2, 2025 at 2:42 PM Christian Brauner <brauner@kernel.org> wrote:
> > diff --git a/fs/coredump.c b/fs/coredump.c
> [...]
> > @@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >                 }
> >                 break;
> >         }
> > +       case COREDUMP_SOCK: {
> > +               struct file *file __free(fput) = NULL;
> > +#ifdef CONFIG_UNIX
> > +               ssize_t addr_size;
> > +               struct sockaddr_un unix_addr = {
> > +                       .sun_family = AF_UNIX,
> > +               };
> > +               struct sockaddr_storage *addr;
> > +
> > +               /*
> > +                * TODO: We need to really support core_pipe_limit to
> > +                * prevent the task from being reaped before userspace
> > +                * had a chance to look at /proc/<pid>.
> > +                *
> > +                * I need help from the networking people (or maybe Oleg
> > +                * also knows?) how to do this.
> > +                *
> > +                * IOW, we need to wait for the other side to shutdown
> > +                * the socket/terminate the connection.
> > +                *
> > +                * We could just read but then userspace could sent us
> > +                * SCM_RIGHTS and we just shouldn't need to deal with
> > +                * any of that.
> > +                */
> 
> I don't think userspace can send you SCM_RIGHTS if you don't do a
> recvmsg() with a control data buffer?

Oh hm, then maybe just a regular read at the end would work. As soon as
userspace send us anything or we get a close event we just disconnect.

But btw, I think we really need a recvmsg() flag that allows a receiver
to refuse SCM_RIGHTS/file descriptors from being sent to it. IIRC, right
now this is a real issue that systemd works around by always calling its
cmsg_close_all() helper after each recvmsg() to ensure that no one sent
it file descriptors it didn't want. The problem there is that someone
could have sent it an fd to a hanging NFS server or something and then
it would hang in close() even though it never even wanted any file
descriptors in the first place.

> 
> > +               if (WARN_ON_ONCE(core_pipe_limit)) {
> > +                       retval = -EINVAL;
> > +                       goto close_fail;
> > +               }
> > +
> > +               retval = strscpy(unix_addr.sun_path, cn.corename, sizeof(unix_addr.sun_path));
> > +               if (retval < 0)
> > +                       goto close_fail;
> > +               addr_size = offsetof(struct sockaddr_un, sun_path) + retval + 1,
> > +
> > +               file = __sys_socket_file(AF_UNIX, SOCK_STREAM, 0);
> > +               if (IS_ERR(file))
> > +                       goto close_fail;
> > +
> > +               /*
> > +                * It is possible that the userspace process which is
> > +                * supposed to handle the coredump and is listening on
> > +                * the AF_UNIX socket coredumps. This should be fine
> > +                * though. If this was the only process which was
> > +                * listen()ing on the AF_UNIX socket for coredumps it
> > +                * obviously won't be listen()ing anymore by the time it
> > +                * gets here. So the __sys_connect_file() call will
> > +                * often fail with ECONNREFUSED and the coredump.
> 
> Why will the server not be listening anymore? Have the task's file
> descriptors already been closed by the time we get here?

No, the file descriptors are still open.

> 
> (Maybe just get rid of this comment, I agree with the following
> comment saying we should let userspace deal with this.)

Good idea.

> 
> > +                * In general though, userspace should just mark itself
> > +                * non dumpable and not do any of this nonsense. We
> > +                * shouldn't work around this.
> > +                */
> > +               addr = (struct sockaddr_storage *)(&unix_addr);
> > +               retval = __sys_connect_file(file, addr, addr_size, O_CLOEXEC);
> 
> Have you made an intentional decision on whether you want to connect
> to a unix domain socket with a path relative to current->fs->root (so
> that containers can do their own core dump handling) or relative to
> the root namespace root (so that core dumps always reach the init
> namespace's core dumping even if a process sandboxes itself with
> namespaces or such)? Also, I think this connection attempt will be

Fsck no. :) I just jotted this down as an RFC. Details below.

> subject to restrictions imposed by (for example) Landlock or AppArmor,
> I'm not sure if that is desired here (since this is not actually a
> connection that the process in whose context the call happens decided
> to make, it's something the system administrator decided to do, and
> especially with Landlock, policies are controlled by individual
> applications that may not know how core dumps work on the system).
> 
> I guess if we keep the current behavior where the socket path is
> namespaced, then we also need to keep the security checks, since an
> unprivileged user could probably set up a namespace and chroot() to a
> place where the socket path (indirectly, through a symlink) refers to
> an arbitrary socket...
> 
> An alternative design might be to directly register the server socket
> on the userns/mountns/netns or such in some magic way, and then have
> the core dumping walk up the namespace hierarchy until it finds a
> namespace that has opted in to using its own core dumping socket, and
> connect to that socket bypassing security checks. (A bit like how
> namespaced binfmt_misc works.) Like, maybe userspace with namespaced

Yeah, I namespaced that thing. :)

> CAP_SYS_ADMIN could bind() to some magic UNIX socket address, or use
> some new setsockopt() on the socket or such, to become the handler of
> core dumps? This would also have the advantage that malicious
> userspace wouldn't be able to send fake bogus core dumps to the
> server, and the server would provide clear consent to being connected
> to without security checks at connection time.

I think that's policy that I absolute don't want the kernel to get
involved in unless absolutely necessary. A few days ago I just discussed
this at length with Lennart and the issue is that systemd would want to
see all coredumps on the system independent of the namespace they're
created in. To have a per-namespace (userns/mountns/netns) coredump
socket would invalidate that one way or the other and end up hiding
coredumps from the administrator unless there's some elaborate scheme
where it doesn't.

systemd-coredump (and Apport fwiw) has infrastructure to forward
coredumps to individual services and containers and it's already based
on AF_UNIX afaict. And I really like that it's the job of userspace to
deal with this instead of the kernel having to get involved in that
mess.

So all of this should be relative to the initial namespace. I want a
separate security hook though so an LSMs can be used to prevent
processes from connecting to the coredump socket.

My idea has been that systemd-coredump could use a bpf lsm program that
would allow to abort a coredump before the crashing process connects to
the socket and again make this a userspace policy issue.

> 
> > +               if (retval)
> > +                       goto close_fail;
> > +
> > +               /* The peer isn't supposed to write and we for sure won't read. */
> > +               retval =  __sys_shutdown_sock(sock_from_file(file), SHUT_RD);
> > +               if (retval)
> > +                       goto close_fail;
> > +
> > +               cprm.limit = RLIM_INFINITY;
> > +#endif
> > +               cprm.file = no_free_ptr(file);
> > +               break;
> > +       }
> >         default:
> >                 WARN_ON_ONCE(true);
> >                 retval = -EINVAL;
> > @@ -818,7 +925,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >                  * have this set to NULL.
> >                  */
> >                 if (!cprm.file) {
> > -                       coredump_report_failure("Core dump to |%s disabled", cn.corename);
> > +                       if (cn.core_type == COREDUMP_PIPE)
> > +                               coredump_report_failure("Core dump to |%s disabled", cn.corename);
> > +                       else
> > +                               coredump_report_failure("Core dump to :%s disabled", cn.corename);
> >                         goto close_fail;
> >                 }
> >                 if (!dump_vma_snapshot(&cprm))
> > @@ -839,8 +949,25 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >                 file_end_write(cprm.file);
> >                 free_vma_snapshot(&cprm);
> >         }
> > -       if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
> > -               wait_for_dump_helpers(cprm.file);
> > +
> > +       if (core_pipe_limit) {
> > +               switch (cn.core_type) {
> > +               case COREDUMP_PIPE:
> > +                       wait_for_dump_helpers(cprm.file);
> > +                       break;
> > +               case COREDUMP_SOCK: {
> > +                       /*
> > +                        * TODO: Wait for the coredump handler to shut
> > +                        * down the socket so we prevent the task from
> > +                        * being reaped.
> > +                        */
> 
> Hmm, I'm no expert but maybe you could poll for the POLLRDHUP event...
> though that might require writing your own helper with a loop that
> does vfs_poll() and waits for a poll wakeup, since I don't think there
> is a kernel helper analogous to a synchronous poll() syscall yet.
> 
> > +                       break;
> > +               }
> > +               default:
> > +                       break;
> > +               }
> > +       }
> > +
> >  close_fail:
> >         if (cprm.file)
> >                 filp_close(cprm.file, NULL);

