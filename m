Return-Path: <linux-fsdevel+bounces-49236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970EAB99FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70A73AFE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB007233D9C;
	Fri, 16 May 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEKYrKeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343021348;
	Fri, 16 May 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390867; cv=none; b=XWMUJAwu9U4Waj/KwADwt5TRqNm2KHwq24F1VWKG4P3U84anp+PeHnaAGC8hXDVwZeVViQ55lvpQQhyyo4ZmqtflNQRT8bKA1HbiRYWOyawzVUOk8G533yMCT1Be4p14fEO0M4JFyDgzbp42t0T6mP//Edi11QHezwS1dBdr1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390867; c=relaxed/simple;
	bh=50zQ4xLe1xiqPGkdBNxYxOt+Jl2j/TcHSWkfc/1bHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDlOzy9AxDE17XDJNLN9LPm2sq1CKHHkCfnlP6bilbiC9DQRCaetZsVLg9Y1o0xB2t1IRrqpGTqdbdeW91XlqahSQMoJ98oFAAeAlWbkdm6LT6jhD3FBJkaDDh7wjJXMc4I6VcRYVi3gDF8CleZTwOC36bEZx7bBVMUUGizZmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEKYrKeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E7FC4CEE4;
	Fri, 16 May 2025 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747390866;
	bh=50zQ4xLe1xiqPGkdBNxYxOt+Jl2j/TcHSWkfc/1bHwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEKYrKeEcTtOMqCk5j8WWya9f+7kphGp2s1XXQfMcRWC0dg5e2UhoDGpCmG8gZf10
	 C9z6HDVfj0+vn7wonTnDoxiSR056Zl5Ob5J4Ym4AOAVRSWAAaTej1y6aQx3pXIHo9P
	 ieu0WqU+fhGL9ORsi3ze8SXZaYsdODGOHq5ysfqybZSFrXs374KfgG5O/G3tTqSS2I
	 KaQWAwTtMmjA8ydk34+Prj49ItMN/WMpS+eINVWbTpEg09qa0MvGbhmCS+IB0MRkbK
	 cUJgq9F7FMWvKJBHPksW01vfx3zqRRvGGZNJiwvsLbuKrelq21zOoat/FTrpCv883/
	 yU/GVbOHGGBbg==
Date: Fri, 16 May 2025 12:20:59 +0200
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
Message-ID: <20250516-gedeihen-loslegen-9c0b89ad57ff@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
 <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>
 <20250516-daneben-knebel-f9ec5dc8ee8c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ypeikxfokj67vpcf"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516-daneben-knebel-f9ec5dc8ee8c@brauner>


--ypeikxfokj67vpcf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 16, 2025 at 12:09:21PM +0200, Christian Brauner wrote:
> On Thu, May 15, 2025 at 10:54:14PM +0200, Jann Horn wrote:
> > On Thu, May 15, 2025 at 12:04 AM Christian Brauner <brauner@kernel.org> wrote:
> > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > index a70929c3585b..e1256ebb89c1 100644
> > > --- a/fs/coredump.c
> > > +++ b/fs/coredump.c
> > [...]
> > > @@ -393,11 +428,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
> > >          * If core_pattern does not include a %p (as is the default)
> > >          * and core_uses_pid is set, then .%pid will be appended to
> > >          * the filename. Do not do this for piped commands. */
> > > -       if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
> > > -               err = cn_printf(cn, ".%d", task_tgid_vnr(current));
> > > -               if (err)
> > > -                       return err;
> > > +       if (!pid_in_pattern && core_uses_pid) {
> > > +               switch (cn->core_type) {
> > > +               case COREDUMP_FILE:
> > > +                       return cn_printf(cn, ".%d", task_tgid_vnr(current));
> > > +               case COREDUMP_PIPE:
> > > +                       break;
> > > +               case COREDUMP_SOCK:
> > > +                       break;
> > 
> > This branch is dead code, we can't get this far down with
> > COREDUMP_SOCK. Maybe you could remove the "break;" and fall through to
> > the default WARN_ON_ONCE() here. Or better, revert this hunk and
> > instead just change the check to check for "cn->core_type ==
> > COREDUMP_FILE" (in patch 1), since this whole block is legacy logic
> > specific to dumping into files (COREDUMP_FILE).
> 
> Ok, folded:
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 368751d98781..45725465c299 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -393,11 +393,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>          * If core_pattern does not include a %p (as is the default)
>          * and core_uses_pid is set, then .%pid will be appended to
>          * the filename. Do not do this for piped commands. */
> -       if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
> -               err = cn_printf(cn, ".%d", task_tgid_vnr(current));
> -               if (err)
> -                       return err;
> -       }
> +       if (cn->core_type == COREDUMP_FILE && !pid_in_pattern && core_uses_pid)
> +               return cn_printf(cn, ".%d", task_tgid_vnr(current));
>         return 0;
>  }
> 
> into the first patch.
> 
> > 
> > > +               default:
> > > +                       WARN_ON_ONCE(true);
> > > +                       return -EINVAL;
> > > +               }
> > >         }
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -801,6 +845,55 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> > >                 }
> > >                 break;
> > >         }
> > > +       case COREDUMP_SOCK: {
> > > +#ifdef CONFIG_UNIX
> > > +               struct file *file __free(fput) = NULL;
> > > +               struct sockaddr_un addr = {
> > > +                       .sun_family = AF_UNIX,
> > > +               };
> > > +               ssize_t addr_len;
> > > +               struct socket *socket;
> > > +
> > > +               retval = strscpy(addr.sun_path, cn.corename, sizeof(addr.sun_path));
> > 
> > nit: strscpy() explicitly supports eliding the last argument in this
> > case, thanks to macro magic:
> > 
> >  * The size argument @... is only required when @dst is not an array, or
> >  * when the copy needs to be smaller than sizeof(@dst).
> 
> Ok.
> 
> > 
> > > +               if (retval < 0)
> > > +                       goto close_fail;
> > > +               addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
> > 
> > nit: On a 64-bit system, strscpy() returns a 64-bit value, and
> > addr_len is also 64-bit, but retval is 32-bit. Implicitly moving
> > length values back and forth between 64-bit and 32-bit is slightly
> > dodgy and might generate suboptimal code (it could force the compiler
> > to emit instructions to explicitly truncate the value if it can't
> > prove that the value fits in 32 bits). It would be nice to keep the
> > value 64-bit throughout by storing the return value in a ssize_t.
> > 
> > And actually, you don't have to compute addr_len here at all; that's
> > needed for abstract unix domain sockets, but for path-based unix
> > domain socket, you should be able to just use sizeof(struct
> > sockaddr_un) as addrlen. (This is documented in "man 7 unix".)
> 
> Ok, folded:
> 
> @@ -845,10 +845,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 ssize_t addr_len;
>                 struct socket *socket;
> 
> -               retval = strscpy(addr.sun_path, cn.corename);
> -               if (retval < 0)
> +               addr_len = strscpy(addr.sun_path, cn.corename);
> +               if (addr_len < 0)
>                         goto close_fail;
> -               addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
> +               addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
> 
> > 
> > > +
> > > +               /*
> > > +                * It is possible that the userspace process which is
> > > +                * supposed to handle the coredump and is listening on
> > > +                * the AF_UNIX socket coredumps. Userspace should just
> > > +                * mark itself non dumpable.
> > > +                */
> > > +
> > > +               retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> > > +               if (retval < 0)
> > > +                       goto close_fail;
> > > +
> > > +               file = sock_alloc_file(socket, 0, NULL);
> > > +               if (IS_ERR(file)) {
> > > +                       sock_release(socket);
> > 
> > I think you missed an API gotcha here. See the sock_alloc_file() documentation:
> > 
> >  * On failure @sock is released, and an ERR pointer is returned.
> 
> Thanks, fixed.
> 
> > 
> > So I think basically sock_alloc_file() always consumes the socket
> > reference provided by the caller, and the sock_release() in this
> > branch is a double-free?
> 
> > 
> > > +                       goto close_fail;
> > > +               }
> > [...]
> > > diff --git a/include/linux/net.h b/include/linux/net.h
> > > index 0ff950eecc6b..139c85d0f2ea 100644
> > > --- a/include/linux/net.h
> > > +++ b/include/linux/net.h
> > > @@ -81,6 +81,7 @@ enum sock_type {
> > >  #ifndef SOCK_NONBLOCK
> > >  #define SOCK_NONBLOCK  O_NONBLOCK
> > >  #endif
> > > +#define SOCK_COREDUMP  O_NOCTTY
> > 
> > Hrrrm. I looked through all the paths from which the ->connect() call
> > can come, and I think this is currently safe; but I wonder if it would
> 
> Yes, I made sure that unknown bits are excluded.

See the appended updated version for completeness sake.

--ypeikxfokj67vpcf
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-coredump-add-coredump-socket.patch"

From f365092f4cb84af265b3f8134802f625e68d6da0 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:37 +0200
Subject: [PATCH] coredump: add coredump socket

Coredumping currently supports two modes:

(1) Dumping directly into a file somewhere on the filesystem.
(2) Dumping into a pipe connected to a usermode helper process
    spawned as a child of the system_unbound_wq or kthreadd.

For simplicity I'm mostly ignoring (1). There's probably still some
users of (1) out there but processing coredumps in this way can be
considered adventurous especially in the face of set*id binaries.

The most common option should be (2) by now. It works by allowing
userspace to put a string into /proc/sys/kernel/core_pattern like:

        |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h

The "|" at the beginning indicates to the kernel that a pipe must be
used. The path following the pipe indicator is a path to a binary that
will be spawned as a usermode helper process. Any additional parameters
pass information about the task that is generating the coredump to the
binary that processes the coredump.

In the example core_pattern shown above systemd-coredump is spawned as a
usermode helper. There's various conceptual consequences of this
(non-exhaustive list):

- systemd-coredump is spawned with file descriptor number 0 (stdin)
  connected to the read-end of the pipe. All other file descriptors are
  closed. That specifically includes 1 (stdout) and 2 (stderr). This has
  already caused bugs because userspace assumed that this cannot happen
  (Whether or not this is a sane assumption is irrelevant.).

- systemd-coredump will be spawned as a child of system_unbound_wq. So
  it is not a child of any userspace process and specifically not a
  child of PID 1. It cannot be waited upon and is in a weird hybrid
  upcall which are difficult for userspace to control correctly.

- systemd-coredump is spawned with full kernel privileges. This
  necessitates all kinds of weird privilege dropping excercises in
  userspace to make this safe.

- A new usermode helper has to be spawned for each crashing process.

This series adds a new mode:

(3) Dumping into an AF_UNIX socket.

Userspace can set /proc/sys/kernel/core_pattern to:

        @/path/to/coredump.socket

The "@" at the beginning indicates to the kernel that an AF_UNIX
coredump socket will be used to process coredumps.

The coredump socket must be located in the initial mount namespace.
When a task coredumps it opens a client socket in the initial network
namespace and connects to the coredump socket.

- The coredump server uses SO_PEERPIDFD to get a stable handle on the
  connected crashing task. The retrieved pidfd will provide a stable
  reference even if the crashing task gets SIGKILLed while generating
  the coredump.

- By setting core_pipe_limit non-zero userspace can guarantee that the
  crashing task cannot be reaped behind it's back and thus process all
  necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
  detect whether /proc/<pid> still refers to the same process.

  The core_pipe_limit isn't used to rate-limit connections to the
  socket. This can simply be done via AF_UNIX sockets directly.

- The pidfd for the crashing task will grow new information how the task
  coredumps.

- The coredump server should mark itself as non-dumpable.

- A container coredump server in a separate network namespace can simply
  bind to another well-know address and systemd-coredump fowards
  coredumps to the container.

- Coredumps could in the future also be handled via per-user/session
  coredump servers that run only with that users privileges.

  The coredump server listens on the coredump socket and accepts a
  new coredump connection. It then retrieves SO_PEERPIDFD for the
  client, inspects uid/gid and hands the accepted client to the users
  own coredump handler which runs with the users privileges only
  (It must of coure pay close attention to not forward crashing suid
  binaries.).

The new coredump socket will allow userspace to not have to rely on
usermode helpers for processing coredumps and provides a safer way to
handle them instead of relying on super privileged coredumping helpers
that have and continue to cause significant CVEs.

This will also be significantly more lightweight since no fork()+exec()
for the usermodehelper is required for each crashing process. The
coredump server in userspace can e.g., just keep a worker pool.

Link: https://lore.kernel.org/20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org
Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c       | 117 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/net.h |   1 +
 net/unix/af_unix.c  |  54 +++++++++++++++-----
 3 files changed, 155 insertions(+), 17 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4b9ea455a59c..22c1730e8eaf 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -44,7 +44,11 @@
 #include <linux/sysctl.h>
 #include <linux/elf.h>
 #include <linux/pidfs.h>
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <net/net_namespace.h>
 #include <uapi/linux/pidfd.h>
+#include <uapi/linux/un.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -79,6 +83,7 @@ unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 enum coredump_type_t {
 	COREDUMP_FILE = 1,
 	COREDUMP_PIPE = 2,
+	COREDUMP_SOCK = 3,
 };
 
 struct core_name {
@@ -232,13 +237,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	cn->corename = NULL;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
+	else if (*pat_ptr == '@')
+		cn->core_type = COREDUMP_SOCK;
 	else
 		cn->core_type = COREDUMP_FILE;
 	if (expand_corename(cn, core_name_size))
 		return -ENOMEM;
 	cn->corename[0] = '\0';
 
-	if (cn->core_type == COREDUMP_PIPE) {
+	switch (cn->core_type) {
+	case COREDUMP_PIPE: {
 		int argvs = sizeof(core_pattern) / 2;
 		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
 		if (!(*argv))
@@ -247,6 +255,35 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		++pat_ptr;
 		if (!(*pat_ptr))
 			return -ENOMEM;
+		break;
+	}
+	case COREDUMP_SOCK: {
+		/* skip the @ */
+		pat_ptr++;
+		if (!(*pat_ptr))
+			return -ENOMEM;
+		err = cn_printf(cn, "%s", pat_ptr);
+		if (err)
+			return err;
+
+		/* Require absolute paths. */
+		if (cn->corename[0] != '/')
+			return -EINVAL;
+
+		/*
+		 * Currently no need to parse any other options.
+		 * Relevant information can be retrieved from the peer
+		 * pidfd retrievable via SO_PEERPIDFD by the receiver or
+		 * via /proc/<pid>, using the SO_PEERPIDFD to guard
+		 * against pid recycling when opening /proc/<pid>.
+		 */
+		return 0;
+	}
+	case COREDUMP_FILE:
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -395,6 +432,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	 * the filename. Do not do this for piped commands. */
 	if (cn->core_type == COREDUMP_FILE && !pid_in_pattern && core_uses_pid)
 		return cn_printf(cn, ".%d", task_tgid_vnr(current));
+
 	return 0;
 }
 
@@ -798,6 +836,53 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+#ifdef CONFIG_UNIX
+		struct file *file __free(fput) = NULL;
+		struct sockaddr_un addr = {
+			.sun_family = AF_UNIX,
+		};
+		ssize_t addr_len;
+		struct socket *socket;
+
+		addr_len = strscpy(addr.sun_path, cn.corename);
+		if (addr_len < 0)
+			goto close_fail;
+		addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
+
+		/*
+		 * It is possible that the userspace process which is
+		 * supposed to handle the coredump and is listening on
+		 * the AF_UNIX socket coredumps. Userspace should just
+		 * mark itself non dumpable.
+		 */
+
+		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
+		if (retval < 0)
+			goto close_fail;
+
+		file = sock_alloc_file(socket, 0, NULL);
+		if (IS_ERR(file))
+			goto close_fail;
+
+		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
+					addr_len, O_NONBLOCK | SOCK_COREDUMP);
+		if (retval) {
+			if (retval == -EAGAIN)
+				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
+			else
+				coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
+			goto close_fail;
+		}
+
+		cprm.limit = RLIM_INFINITY;
+		cprm.file = no_free_ptr(file);
+#else
+		coredump_report_failure("Core dump socket support %s disabled", cn.corename);
+		goto close_fail;
+#endif
+		break;
+	}
 	default:
 		WARN_ON_ONCE(true);
 		goto close_fail;
@@ -835,8 +920,32 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
 	}
-	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
-		wait_for_dump_helpers(cprm.file);
+
+	/*
+	 * When core_pipe_limit is set we wait for the coredump server
+	 * or usermodehelper to finish before exiting so it can e.g.,
+	 * inspect /proc/<pid>.
+	 */
+	if (core_pipe_limit) {
+		switch (cn.core_type) {
+		case COREDUMP_PIPE:
+			wait_for_dump_helpers(cprm.file);
+			break;
+		case COREDUMP_SOCK: {
+			/*
+			 * We use a simple read to wait for the coredump
+			 * processing to finish. Either the socket is
+			 * closed or we get sent unexpected data. In
+			 * both cases, we're done.
+			 */
+			__kernel_read(cprm.file, &(char){ 0 }, 1, NULL);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
@@ -1066,7 +1175,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "
diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..139c85d0f2ea 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -81,6 +81,7 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
+#define SOCK_COREDUMP	O_NOCTTY
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..59a64b2ced6e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -85,10 +85,13 @@
 #include <linux/file.h>
 #include <linux/filter.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/net.h>
+#include <linux/pidfs.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/signal.h>
@@ -100,7 +103,6 @@
 #include <linux/splice.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/pidfs.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -1146,7 +1148,7 @@ static int unix_release(struct socket *sock)
 }
 
 static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
-				  int type)
+				  int type, int flags)
 {
 	struct inode *inode;
 	struct path path;
@@ -1154,13 +1156,39 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	int err;
 
 	unix_mkname_bsd(sunaddr, addr_len);
-	err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
-	if (err)
-		goto fail;
 
-	err = path_permission(&path, MAY_WRITE);
-	if (err)
-		goto path_put;
+	if (flags & SOCK_COREDUMP) {
+		const struct cred *cred;
+		struct cred *kcred;
+		struct path root;
+
+		kcred = prepare_kernel_cred(&init_task);
+		if (!kcred) {
+			err = -ENOMEM;
+			goto fail;
+		}
+
+		task_lock(&init_task);
+		get_fs_root(init_task.fs, &root);
+		task_unlock(&init_task);
+
+		cred = override_creds(kcred);
+		err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
+				      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
+				      LOOKUP_NO_MAGICLINKS, &path);
+		put_cred(revert_creds(cred));
+		path_put(&root);
+		if (err)
+			goto fail;
+	} else {
+		err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
+		if (err)
+			goto fail;
+
+		err = path_permission(&path, MAY_WRITE);
+		if (err)
+			goto path_put;
+	}
 
 	err = -ECONNREFUSED;
 	inode = d_backing_inode(path.dentry);
@@ -1210,12 +1238,12 @@ static struct sock *unix_find_abstract(struct net *net,
 
 static struct sock *unix_find_other(struct net *net,
 				    struct sockaddr_un *sunaddr,
-				    int addr_len, int type)
+				    int addr_len, int type, int flags)
 {
 	struct sock *sk;
 
 	if (sunaddr->sun_path[0])
-		sk = unix_find_bsd(sunaddr, addr_len, type);
+		sk = unix_find_bsd(sunaddr, addr_len, type, flags);
 	else
 		sk = unix_find_abstract(net, sunaddr, addr_len, type);
 
@@ -1473,7 +1501,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		}
 
 restart:
-		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
+		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, 0);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out;
@@ -1620,7 +1648,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 restart:
 	/*  Find listening sock. */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
+	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
 		goto out_free_skb;
@@ -2089,7 +2117,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_namelen) {
 lookup:
 		other = unix_find_other(sock_net(sk), msg->msg_name,
-					msg->msg_namelen, sk->sk_type);
+					msg->msg_namelen, sk->sk_type, 0);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out_free;
-- 
2.47.2


--ypeikxfokj67vpcf--

