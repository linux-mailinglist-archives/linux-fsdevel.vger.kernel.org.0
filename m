Return-Path: <linux-fsdevel+bounces-49218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC1AB97BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8876DA20D10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB9922F17A;
	Fri, 16 May 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnnsxrcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF022DA05;
	Fri, 16 May 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384238; cv=none; b=SlO55Nup/HaHsErmhK59EaQzFm6nXkKK0ePFeJzAOwWBS3yjAshb+lxniEPYaBG/pnCjRfVnHAUKY/aYL9uem20fUnvL6NLqn0d4k9rOeCqik8o2FrYglqYnj1xVQ5Cn6pa9x9WI/gbQR5k7bmTwY/ympbEk1aJT1aGQ3i2BSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384238; c=relaxed/simple;
	bh=Obpuu85rw8MwIhSk9pEs4zIR3h424zXxa3ZCsMP5iO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsg4Z930CNY1/pcX9tW160o9jqmrOKvDTwpogaEauXcZvIINrcvGXADybf0AeQMzsM6nzLtDpglm9c+aYb/z8loUuKesJ7WaNGOrsm5AsGj2r8s6VKEHhnQ8ek29D4ULz51M/fcJbJXPLHg+YdUmCk223fWoMUePZdkFMRGivwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnnsxrcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC23DC4CEF4;
	Fri, 16 May 2025 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747384237;
	bh=Obpuu85rw8MwIhSk9pEs4zIR3h424zXxa3ZCsMP5iO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnnsxrcPnlQtGMwSl/UceeS0C1BwehF28mmgUJJ+/JnZPxQDgdO7+ACD59mw9E/rQ
	 JDtTrdYgkvN0NMY/VcZOP2RrhsQlBUHp6QZaD1JezZWsLuzNHB2sLb6xfKtYNzK7KA
	 ThOh9FxoSc4UbJwvTej9fZnBJcpKifL58PBw4ZFKb2tA2gbSNDS2YE/Cd6Vi+bpCWY
	 fLMdA6MrSuU6cbw5GKKZOvmwDuUiN13e5QnqE+EcX/VBnRnNXoaRL6HCyu8xDb7MCj
	 +1QJNjOyabmSPgfJmkjWXE3KKJPngBG8etStfvc70n+17D38OG0wDOEZ3X/3lMFXVj
	 3WjpRZ0a0m1JQ==
Date: Fri, 16 May 2025 10:30:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
Message-ID: <20250516-verplanen-bewaffnen-85a3b0a1e941@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
 <CAJqdLrpjoUQERfbRfxUNC=WN8iQQySPNBUAvvTiub=8p_iJTuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLrpjoUQERfbRfxUNC=WN8iQQySPNBUAvvTiub=8p_iJTuA@mail.gmail.com>

On Thu, May 15, 2025 at 03:47:33PM +0200, Alexander Mikhalitsyn wrote:
> Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
> <brauner@kernel.org>:
> >
> > Coredumping currently supports two modes:
> >
> > (1) Dumping directly into a file somewhere on the filesystem.
> > (2) Dumping into a pipe connected to a usermode helper process
> >     spawned as a child of the system_unbound_wq or kthreadd.
> >
> > For simplicity I'm mostly ignoring (1). There's probably still some
> > users of (1) out there but processing coredumps in this way can be
> > considered adventurous especially in the face of set*id binaries.
> >
> > The most common option should be (2) by now. It works by allowing
> > userspace to put a string into /proc/sys/kernel/core_pattern like:
> >
> >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> >
> > The "|" at the beginning indicates to the kernel that a pipe must be
> > used. The path following the pipe indicator is a path to a binary that
> > will be spawned as a usermode helper process. Any additional parameters
> > pass information about the task that is generating the coredump to the
> > binary that processes the coredump.
> >
> > In the example core_pattern shown above systemd-coredump is spawned as a
> > usermode helper. There's various conceptual consequences of this
> > (non-exhaustive list):
> >
> > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> >   connected to the read-end of the pipe. All other file descriptors are
> >   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
> >   already caused bugs because userspace assumed that this cannot happen
> >   (Whether or not this is a sane assumption is irrelevant.).
> >
> > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> >   it is not a child of any userspace process and specifically not a
> >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> >   upcall which are difficult for userspace to control correctly.
> >
> > - systemd-coredump is spawned with full kernel privileges. This
> >   necessitates all kinds of weird privilege dropping excercises in
> >   userspace to make this safe.
> >
> > - A new usermode helper has to be spawned for each crashing process.
> >
> > This series adds a new mode:
> >
> > (3) Dumping into an AF_UNIX socket.
> >
> > Userspace can set /proc/sys/kernel/core_pattern to:
> >
> >         @/path/to/coredump.socket
> >
> > The "@" at the beginning indicates to the kernel that an AF_UNIX
> > coredump socket will be used to process coredumps.
> >
> > The coredump socket must be located in the initial mount namespace.
> > When a task coredumps it opens a client socket in the initial network
> > namespace and connects to the coredump socket.
> >
> > - The coredump server uses SO_PEERPIDFD to get a stable handle on the
> >   connected crashing task. The retrieved pidfd will provide a stable
> >   reference even if the crashing task gets SIGKILLed while generating
> >   the coredump.
> >
> > - By setting core_pipe_limit non-zero userspace can guarantee that the
> >   crashing task cannot be reaped behind it's back and thus process all
> >   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
> >   detect whether /proc/<pid> still refers to the same process.
> >
> >   The core_pipe_limit isn't used to rate-limit connections to the
> >   socket. This can simply be done via AF_UNIX sockets directly.
> >
> > - The pidfd for the crashing task will grow new information how the task
> >   coredumps.
> >
> > - The coredump server should mark itself as non-dumpable.
> >
> > - A container coredump server in a separate network namespace can simply
> >   bind to another well-know address and systemd-coredump fowards
> >   coredumps to the container.
> >
> > - Coredumps could in the future also be handled via per-user/session
> >   coredump servers that run only with that users privileges.
> >
> >   The coredump server listens on the coredump socket and accepts a
> >   new coredump connection. It then retrieves SO_PEERPIDFD for the
> >   client, inspects uid/gid and hands the accepted client to the users
> >   own coredump handler which runs with the users privileges only
> >   (It must of coure pay close attention to not forward crashing suid
> >   binaries.).
> >
> > The new coredump socket will allow userspace to not have to rely on
> > usermode helpers for processing coredumps and provides a safer way to
> > handle them instead of relying on super privileged coredumping helpers
> > that have and continue to cause significant CVEs.
> >
> > This will also be significantly more lightweight since no fork()+exec()
> > for the usermodehelper is required for each crashing process. The
> > coredump server in userspace can e.g., just keep a worker pool.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> 
> > ---
> >  fs/coredump.c       | 133 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/net.h |   1 +
> >  net/unix/af_unix.c  |  53 ++++++++++++++++-----
> >  3 files changed, 166 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index a70929c3585b..e1256ebb89c1 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -44,7 +44,11 @@
> >  #include <linux/sysctl.h>
> >  #include <linux/elf.h>
> >  #include <linux/pidfs.h>
> > +#include <linux/net.h>
> > +#include <linux/socket.h>
> > +#include <net/net_namespace.h>
> >  #include <uapi/linux/pidfd.h>
> > +#include <uapi/linux/un.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -79,6 +83,7 @@ unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
> >  enum coredump_type_t {
> >         COREDUMP_FILE = 1,
> >         COREDUMP_PIPE = 2,
> > +       COREDUMP_SOCK = 3,
> >  };
> >
> >  struct core_name {
> > @@ -232,13 +237,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
> >         cn->corename = NULL;
> >         if (*pat_ptr == '|')
> >                 cn->core_type = COREDUMP_PIPE;
> > +       else if (*pat_ptr == '@')
> > +               cn->core_type = COREDUMP_SOCK;
> >         else
> >                 cn->core_type = COREDUMP_FILE;
> >         if (expand_corename(cn, core_name_size))
> >                 return -ENOMEM;
> >         cn->corename[0] = '\0';
> >
> > -       if (cn->core_type == COREDUMP_PIPE) {
> > +       switch (cn->core_type) {
> > +       case COREDUMP_PIPE: {
> >                 int argvs = sizeof(core_pattern) / 2;
> >                 (*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
> >                 if (!(*argv))
> > @@ -247,6 +255,33 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
> >                 ++pat_ptr;
> >                 if (!(*pat_ptr))
> >                         return -ENOMEM;
> > +               break;
> > +       }
> > +       case COREDUMP_SOCK: {
> > +               /* skip the @ */
> > +               pat_ptr++;
> 
> nit: I would do
> if (!(*pat_ptr))
>    return -ENOMEM;
> as we do for the COREDUMP_PIPE case above.
> just in case if something will change in cn_printf() to eliminate any
> chance of crashes in there.

Ok.

