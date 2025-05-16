Return-Path: <linux-fsdevel+bounces-49226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA7AB99C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC57C500170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88546233155;
	Fri, 16 May 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVgSnqhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BF381C4;
	Fri, 16 May 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390169; cv=none; b=FXEnDMC2293FPCB56mx4ZJdDlXDIj6V/uhTcJS+zAYgYlbRRrYesdKKTfrpnaEYr10q7T9JsBthnQGP3us1+tCHQWbh033ek0i8NNLQnO3Syax0CxSKAepx5vQB+zKyKQNgbHC0ipP9ipZckPvJpCMrnrUNPnFyYmbEuZHEtmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390169; c=relaxed/simple;
	bh=828AqPmF+LTs7KHi7/rDDJZ/Wqefq9Hs5IZ8JnUzVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG+rLfuH2nJlxnPhcWBPPGNRbTFE4TpGwff9WmYNMak0DepN0pMFJMW7Ab+0WsI5xOjmvkXgdni/8iJs2MjrI/90Boo/JCup64xKzJyaXs7imbsifsB5NCVEGL+v/7dvk3+RHqM3L7ryqXr4JO1QQoAXRxhJyf1sAYjEG0zN1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVgSnqhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC7C4CEE4;
	Fri, 16 May 2025 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747390168;
	bh=828AqPmF+LTs7KHi7/rDDJZ/Wqefq9Hs5IZ8JnUzVcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVgSnqhTytXU7NVwwS21fRCCbfybQbGjugR6IZwl/qg1q8etV90+WA11Chzebk4gy
	 sXShFHan8wAIwDwoQNF3KAHWENw/NcoMHR9OTXwGr7iYj9Eq/8QH82eqQsL3fhAusw
	 mkvWaTrdE4ESUCtio2JkR1P2Fe49YcYM/p0gjNnKex76CgX568A6rIPb5VBjoVdqTe
	 6fWM6Whngvdr6XpbkXk0Pm7SmLk6Y6sKGYJoJMr7cGv+BTuvlJoike1JUxfUj27QTi
	 F7mULIlTOH7+28aScxeLo179MY9SOr054LD/l5aO90dZpfVosAxUBRqbHs5+/w/g/O
	 0rkmSo3hMXzRQ==
Date: Fri, 16 May 2025 12:09:21 +0200
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
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
Message-ID: <20250516-daneben-knebel-f9ec5dc8ee8c@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
 <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>

On Thu, May 15, 2025 at 10:54:14PM +0200, Jann Horn wrote:
> On Thu, May 15, 2025 at 12:04 AM Christian Brauner <brauner@kernel.org> wrote:
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index a70929c3585b..e1256ebb89c1 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> [...]
> > @@ -393,11 +428,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
> >          * If core_pattern does not include a %p (as is the default)
> >          * and core_uses_pid is set, then .%pid will be appended to
> >          * the filename. Do not do this for piped commands. */
> > -       if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
> > -               err = cn_printf(cn, ".%d", task_tgid_vnr(current));
> > -               if (err)
> > -                       return err;
> > +       if (!pid_in_pattern && core_uses_pid) {
> > +               switch (cn->core_type) {
> > +               case COREDUMP_FILE:
> > +                       return cn_printf(cn, ".%d", task_tgid_vnr(current));
> > +               case COREDUMP_PIPE:
> > +                       break;
> > +               case COREDUMP_SOCK:
> > +                       break;
> 
> This branch is dead code, we can't get this far down with
> COREDUMP_SOCK. Maybe you could remove the "break;" and fall through to
> the default WARN_ON_ONCE() here. Or better, revert this hunk and
> instead just change the check to check for "cn->core_type ==
> COREDUMP_FILE" (in patch 1), since this whole block is legacy logic
> specific to dumping into files (COREDUMP_FILE).

Ok, folded:

diff --git a/fs/coredump.c b/fs/coredump.c
index 368751d98781..45725465c299 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -393,11 +393,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
         * If core_pattern does not include a %p (as is the default)
         * and core_uses_pid is set, then .%pid will be appended to
         * the filename. Do not do this for piped commands. */
-       if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
-               err = cn_printf(cn, ".%d", task_tgid_vnr(current));
-               if (err)
-                       return err;
-       }
+       if (cn->core_type == COREDUMP_FILE && !pid_in_pattern && core_uses_pid)
+               return cn_printf(cn, ".%d", task_tgid_vnr(current));
        return 0;
 }

into the first patch.

> 
> > +               default:
> > +                       WARN_ON_ONCE(true);
> > +                       return -EINVAL;
> > +               }
> >         }
> > +
> >         return 0;
> >  }
> >
> > @@ -801,6 +845,55 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >                 }
> >                 break;
> >         }
> > +       case COREDUMP_SOCK: {
> > +#ifdef CONFIG_UNIX
> > +               struct file *file __free(fput) = NULL;
> > +               struct sockaddr_un addr = {
> > +                       .sun_family = AF_UNIX,
> > +               };
> > +               ssize_t addr_len;
> > +               struct socket *socket;
> > +
> > +               retval = strscpy(addr.sun_path, cn.corename, sizeof(addr.sun_path));
> 
> nit: strscpy() explicitly supports eliding the last argument in this
> case, thanks to macro magic:
> 
>  * The size argument @... is only required when @dst is not an array, or
>  * when the copy needs to be smaller than sizeof(@dst).

Ok.

> 
> > +               if (retval < 0)
> > +                       goto close_fail;
> > +               addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
> 
> nit: On a 64-bit system, strscpy() returns a 64-bit value, and
> addr_len is also 64-bit, but retval is 32-bit. Implicitly moving
> length values back and forth between 64-bit and 32-bit is slightly
> dodgy and might generate suboptimal code (it could force the compiler
> to emit instructions to explicitly truncate the value if it can't
> prove that the value fits in 32 bits). It would be nice to keep the
> value 64-bit throughout by storing the return value in a ssize_t.
> 
> And actually, you don't have to compute addr_len here at all; that's
> needed for abstract unix domain sockets, but for path-based unix
> domain socket, you should be able to just use sizeof(struct
> sockaddr_un) as addrlen. (This is documented in "man 7 unix".)

Ok, folded:

@@ -845,10 +845,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
                ssize_t addr_len;
                struct socket *socket;

-               retval = strscpy(addr.sun_path, cn.corename);
-               if (retval < 0)
+               addr_len = strscpy(addr.sun_path, cn.corename);
+               if (addr_len < 0)
                        goto close_fail;
-               addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
+               addr_len += offsetof(struct sockaddr_un, sun_path) + 1;

> 
> > +
> > +               /*
> > +                * It is possible that the userspace process which is
> > +                * supposed to handle the coredump and is listening on
> > +                * the AF_UNIX socket coredumps. Userspace should just
> > +                * mark itself non dumpable.
> > +                */
> > +
> > +               retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> > +               if (retval < 0)
> > +                       goto close_fail;
> > +
> > +               file = sock_alloc_file(socket, 0, NULL);
> > +               if (IS_ERR(file)) {
> > +                       sock_release(socket);
> 
> I think you missed an API gotcha here. See the sock_alloc_file() documentation:
> 
>  * On failure @sock is released, and an ERR pointer is returned.

Thanks, fixed.

> 
> So I think basically sock_alloc_file() always consumes the socket
> reference provided by the caller, and the sock_release() in this
> branch is a double-free?

> 
> > +                       goto close_fail;
> > +               }
> [...]
> > diff --git a/include/linux/net.h b/include/linux/net.h
> > index 0ff950eecc6b..139c85d0f2ea 100644
> > --- a/include/linux/net.h
> > +++ b/include/linux/net.h
> > @@ -81,6 +81,7 @@ enum sock_type {
> >  #ifndef SOCK_NONBLOCK
> >  #define SOCK_NONBLOCK  O_NONBLOCK
> >  #endif
> > +#define SOCK_COREDUMP  O_NOCTTY
> 
> Hrrrm. I looked through all the paths from which the ->connect() call
> can come, and I think this is currently safe; but I wonder if it would

Yes, I made sure that unknown bits are excluded.

