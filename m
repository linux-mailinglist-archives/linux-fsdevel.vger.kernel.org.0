Return-Path: <linux-fsdevel+bounces-48072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42349AA93A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C725189A791
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3424E4A6;
	Mon,  5 May 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP5jo9iE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2A2046A6
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449759; cv=none; b=tZi7XMAttmByJaXZRh3CkDPTZggkeD8UP06tlacmwj/4E4s6gdYBPc7z2XSfzM7ykj0MJfoo7N7ps0GLyZzkm253MqL1ycGjYZG20o/lYxrwMlVHPAiJ3kn8vjZyH2rCa+DgWnZraQn/3zD3wKbBrN5x7+yMlkkUK5YgQ2ZsL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449759; c=relaxed/simple;
	bh=ha3hM5hJO182TbjUhK7+X+VuqzY17tSzdBYRbfS5Syk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3e70mz8aRtW0ALx94+JKiNez7Bd8QQvCS5Nhu5CBmFV7wy6Z4pCMDB53UkUqR69m6a9J8Hkp+245mhdSZct/y1wTchq5TLB4cyppN21zJFaoXV63loDHD3Qe6TGgZJvaZHcsK5Sla3wNa5ZQNbHs2WFxQtiOCk/dgBCgJO9Nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP5jo9iE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso11846a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746449755; x=1747054555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK30GaJKRsJN1zNstlRvdioukqoLjIMOsgIH+IDi/us=;
        b=KP5jo9iEeBUWGVt6D3X9AKvUdEOrOpWZnNuUdwGxOQdaMwtsmKbYEu/buM3hlsMqlG
         yNOnFRC8DB943PdBK5jEUm3w2fywp0rxpyT559LhChzwnK2FKIf+fcouqQOz8MkqHJEq
         /2Fjn/4z65CI7YuHrIzvzUITAusPYNyVdgBo+NCocI1dVFz1rgdt3lsj9jkWxCyf1Ujl
         lEjhHGO06b6hDdheJALUsA6Qw0yk6PXARVz7g6RE1pPI8LnbQ6exlK/IvpCo9yC0StD4
         Go3KuRRtNuC4lOiRjipF6mJQDZA3AHtJG84SBvRhFpF2axPTaifCQA+qbxZWgEjodMHp
         lYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449755; x=1747054555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK30GaJKRsJN1zNstlRvdioukqoLjIMOsgIH+IDi/us=;
        b=Jy26dqGMFi+UVOjotkCBrOo8fSavbr/FsJjjoMgOjyxVTfgSlinbi63qTQCsOrHfKA
         XqKZOowg7NttzVs/QvqULa616509CncfFAGm3cKeI286GqBcXSWFwTQUj6BM/PW3xDxz
         B24VzMTRYluHSwr0wKKfSTlF0zujfGG5dItLYT8in8uw7vm5hfe5H+bxOGi4s38mUyK3
         WvRHGFebjz1rQG65aKKxeL88lseICJUDpqNt9qYeKi45HKyU9r7P37XEmfgzeWCiIvZD
         ln3WUtoZ54mGuHgvSlYyO+8rpoAKtmcrKZA6kRYf5phBblkiS8Dgemg9OuAA2x0mr5xc
         Ht0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+xRgFUVjNIYzdOx3HvIxW4mcwRuqMUBpQMnwOtI4dFsxbsY2K1JhhrxLgx04UsktK+CSr3lgFtuSiyage@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+LWBHH4zjkreB/jRdUX4pHpmGd1CmDIeK76ZknXZad4y8kTk
	UTCvmU1JXq7Gpuri9a9b52FiqFtyu30vMMHjvQMEyfXcTyLlJzVDX2FDwVxcGW4ozyoHdguzhwV
	VA9WXwSe47IUXkFe1NKxpFnsMhpZGHVRLGB51
X-Gm-Gg: ASbGnculLinzytEzCSjpqE/jAHHAa47ggi1y0Ain1pCtCH+NhW0gyaszqBMLgFhxilq
	scZZucmv9d89w/1qin7bqQkgJ2oAF0jz0L0eCLwwswvLPz007Gca/+MfIpm3RToy1QG2zVzTa+h
	DFdmeECm4T2KcQZ2nL7lIIqjfJs1IkZEWNbE88/z9XjFPdcT3Jlg==
X-Google-Smtp-Source: AGHT+IEiPEyQfDySwTy9SsBwxSCnKD2PVSILjI8FfeBmXbXJ7D+eTcn9H4IrXF2AjWjkV81BizTwpGdZKU0k+pe0kz8=
X-Received: by 2002:a50:cd09:0:b0:5e0:eaa6:a2b0 with SMTP id
 4fb4d7f45d1cf-5faaa1fde1dmr119409a12.5.1746449754786; Mon, 05 May 2025
 05:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org> <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 14:55:18 +0200
X-Gm-Features: ATxdqUHK9cXCrMZGNMaUFfQvUc7rbV1_uTVHeasQZf2qygiBJA0xLtS9b4cdJoA
Message-ID: <CAG48ez2PNFmaMCg9u7febjDgYytxi5eB-261sZBHrfBcTgavfA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Coredumping currently supports two modes:
>
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
>
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
>
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
>
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
>
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
>
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
>
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
>
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
>
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
>
> - A new usermode helper has to be spawned for each crashing process.
>
> This series adds a new mode:
>
> (3) Dumping into an abstract AF_UNIX socket.
>
> Userspace can set /proc/sys/kernel/core_pattern to:
>
>         @linuxafsk/coredump_socket
>
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps.
>
> The coredump socket uses the fixed address "linuxafsk/coredump.socket"
> for now.
>
> The coredump socket is located in the initial network namespace. To bind
> the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> user namespace. Listening and reading can happen from whatever
> unprivileged context is necessary to safely process coredumps.
>
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket. For now only tasks that
> are acctually coredumping are allowed to connect to the initial coredump
> socket.
>
> - The coredump server should use SO_PEERPIDFD to get a stable handle on
>   the connected crashing task. The retrieved pidfd will provide a stable
>   reference even if the crashing task gets SIGKILLed while generating
>   the coredump.
>
> - By setting core_pipe_limit non-zero userspace can guarantee that the
>   crashing task cannot be reaped behind it's back and thus process all
>   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
>   detect whether /proc/<pid> still refers to the same process.
>
>   The core_pipe_limit isn't used to rate-limit connections to the
>   socket. This can simply be done via AF_UNIX socket directly.
>
> - The pidfd for the crashing task will contain information how the task
>   coredumps. The PIDFD_GET_INFO ioctl gained a new flag
>   PIDFD_INFO_COREDUMP which can be used to retreive the coredump
>   information.
>
>   If the coredump gets a new coredump client connection the kernel
>   guarantees that PIDFD_INFO_COREDUMP information is available.
>   Currently the following information is provided in the new
>   @coredump_mask extension to struct pidfd_info:
>
>   * PIDFD_COREDUMPED is raised if the task did actually coredump.
>   * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
>     undumpable).
>   * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
>     doesn't need special care by the coredump server.
>   * IDFD_COREDUMP_ROOT is raised if the generated coredump should be
>     treated as sensitive and the coredump server should restrict to the
>     generated coredump to sufficiently privileged users.
>
> - Since unix_stream_connect() runs bpf programs during connect it's
>   possible to even redirect or multiplex coredumps to other sockets.

Or change the userspace protocol used for containers such that the
init-namespace coredumping helper forwards the FD it accept()ed into a
container via SCM_RIGHTS...

> - The coredump server should mark itself as non-dumpable.
>   To capture coredumps for the coredump server itself a bpf program
>   should be run at connect to redirect it to another socket in
>   userspace. This can be useful for debugging crashing coredump servers.
>
> - A container coredump server in a separate network namespace can simply
>   bind to linuxafsk/coredump.socket and systemd-coredump fowards
>   coredumps to the container.
>
> - Fwiw, one idea is to handle coredumps via per-user/session coredump
>   servers that run with that users privileges.
>
>   The coredump server listens on the coredump socket and accepts a
>   new coredump connection. It then retrieves SO_PEERPIDFD for the
>   client, inspects uid/gid and hands the accepted client to the users
>   own coredump handler which runs with the users privileges only.

(Though that would only be okay if it's not done for suid dumping cases.)

> The new coredump socket will allow userspace to not have to rely on
> usermode helpers for processing coredumps and provides a safer way to
> handle them instead of relying on super privileged coredumping helpers.
>
> This will also be significantly more lightweight since no fork()+exec()
> for the usermodehelper is required for each crashing process. The
> coredump server in userspace can just keep a worker pool.

I mean, if coredumping is a performance bottleneck, something is
probably seriously wrong with the system... I don't think we need to
optimize for execution speed in this area.

> This is easy to test:
>
> (a) coredump processing (we're using socat):
>
>     > cat coredump_socket.sh
>     #!/bin/bash
>
>     set -x
>
>     sudo bash -c "echo '@linuxafsk/coredump.socket' > /proc/sys/kernel/co=
re_pattern"
>     sudo socat --statistics abstract-listen:linuxafsk/coredump.socket,for=
k FILE:core_file,create,append,trunc
>
> (b) trigger a coredump:
>
>     user1@localhost:~/data/scripts$ cat crash.c
>     #include <stdio.h>
>     #include <unistd.h>
>
>     int main(int argc, char *argv[])
>     {
>             fprintf(stderr, "%u\n", (1 / 0));
>             _exit(0);
>     }

This looks pretty neat overall!

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 107 insertions(+), 5 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 1779299b8c61..c60f86c473ad 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -44,7 +44,11 @@
>  #include <linux/sysctl.h>
>  #include <linux/elf.h>
>  #include <linux/pidfs.h>
> +#include <linux/net.h>
> +#include <linux/socket.h>
> +#include <net/net_namespace.h>
>  #include <uapi/linux/pidfd.h>
> +#include <uapi/linux/un.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -79,6 +83,7 @@ unsigned int core_file_note_size_limit =3D CORE_FILE_NO=
TE_SIZE_DEFAULT;
>  enum coredump_type_t {
>         COREDUMP_FILE =3D 1,
>         COREDUMP_PIPE =3D 2,
> +       COREDUMP_SOCK =3D 3,
>  };
>
>  struct core_name {
> @@ -232,13 +237,16 @@ static int format_corename(struct core_name *cn, st=
ruct coredump_params *cprm,
>         cn->corename =3D NULL;
>         if (*pat_ptr =3D=3D '|')
>                 cn->core_type =3D COREDUMP_PIPE;
> +       else if (*pat_ptr =3D=3D '@')
> +               cn->core_type =3D COREDUMP_SOCK;
>         else
>                 cn->core_type =3D COREDUMP_FILE;
>         if (expand_corename(cn, core_name_size))
>                 return -ENOMEM;
>         cn->corename[0] =3D '\0';
>
> -       if (cn->core_type =3D=3D COREDUMP_PIPE) {
> +       switch (cn->core_type) {
> +       case COREDUMP_PIPE: {
>                 int argvs =3D sizeof(core_pattern) / 2;
>                 (*argv) =3D kmalloc_array(argvs, sizeof(**argv), GFP_KERN=
EL);
>                 if (!(*argv))
> @@ -247,6 +255,32 @@ static int format_corename(struct core_name *cn, str=
uct coredump_params *cprm,
>                 ++pat_ptr;
>                 if (!(*pat_ptr))
>                         return -ENOMEM;
> +               break;
> +       }
> +       case COREDUMP_SOCK: {
> +               err =3D cn_printf(cn, "%s", pat_ptr);
> +               if (err)
> +                       return err;
> +
> +               /*
> +                * We can potentially allow this to be changed later but
> +                * I currently see no reason to.
> +                */
> +               if (strcmp(cn->corename, "@linuxafsk/coredump.socket"))
> +                       return -EINVAL;
> +
> +               /*
> +                * Currently no need to parse any other options.
> +                * Relevant information can be retrieved from the peer
> +                * pidfd retrievable via SO_PEERPIDFD by the receiver or
> +                * via /proc/<pid>, using the SO_PEERPIDFD to guard
> +                * against pid recycling when opening /proc/<pid>.
> +                */
> +               return 0;
> +       }
> +       default:
> +               WARN_ON_ONCE(cn->core_type !=3D COREDUMP_FILE);
> +               break;
>         }
>
>         /* Repeat as long as we have more pattern to process and more out=
put

I think the core_uses_pid logic at the end of this function needs to
be adjusted to also exclude COREDUMP_SOCK?

> @@ -583,6 +617,17 @@ static int umh_coredump_setup(struct subprocess_info=
 *info, struct cred *new)
>         return 0;
>  }
>
> +#ifdef CONFIG_UNIX
> +struct sockaddr_un coredump_unix_socket =3D {
> +       .sun_family =3D AF_UNIX,
> +       .sun_path =3D "\0linuxafsk/coredump.socket",
> +};

Nit: Please make that static and const.

> +/* Without trailing NUL byte. */
> +#define COREDUMP_UNIX_SOCKET_ADDR_SIZE            \
> +       (offsetof(struct sockaddr_un, sun_path) + \
> +        sizeof("\0linuxafsk/coredump.socket") - 1)
> +#endif
> +
>  void do_coredump(const kernel_siginfo_t *siginfo)
>  {
>         struct core_state core_state;
> @@ -801,6 +846,40 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 }
>                 break;
>         }
> +       case COREDUMP_SOCK: {
> +               struct file *file __free(fput) =3D NULL;
> +#ifdef CONFIG_UNIX
> +               struct socket *socket;
> +
> +               /*
> +                * It is possible that the userspace process which is
> +                * supposed to handle the coredump and is listening on
> +                * the AF_UNIX socket coredumps. Userspace should just
> +                * mark itself non dumpable.
> +                */
> +
> +               retval =3D sock_create_kern(&init_net, AF_UNIX, SOCK_STRE=
AM, 0, &socket);
> +               if (retval < 0)
> +                       goto close_fail;
> +
> +               file =3D sock_alloc_file(socket, 0, NULL);
> +               if (IS_ERR(file)) {
> +                       sock_release(socket);
> +                       retval =3D PTR_ERR(file);
> +                       goto close_fail;
> +               }
> +
> +               retval =3D kernel_connect(socket,
> +                                       (struct sockaddr *)(&coredump_uni=
x_socket),
> +                                       COREDUMP_UNIX_SOCKET_ADDR_SIZE, 0=
);
> +               if (retval)
> +                       goto close_fail;
> +
> +               cprm.limit =3D RLIM_INFINITY;
> +#endif

The non-CONFIG_UNIX case here should probably bail out?

> +               cprm.file =3D no_free_ptr(file);
> +               break;
> +       }
>         default:
>                 WARN_ON_ONCE(true);
>                 retval =3D -EINVAL;
> @@ -818,7 +897,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                  * have this set to NULL.
>                  */
>                 if (!cprm.file) {
> -                       coredump_report_failure("Core dump to |%s disable=
d", cn.corename);
> +                       if (cn.core_type =3D=3D COREDUMP_PIPE)
> +                               coredump_report_failure("Core dump to |%s=
 disabled", cn.corename);
> +                       else
> +                               coredump_report_failure("Core dump to @%s=
 disabled", cn.corename);

Are you actually truncating the initial "@" off of cn.corename, or is
this going to print two "@" characters?

>                         goto close_fail;
>                 }
>                 if (!dump_vma_snapshot(&cprm))
> @@ -839,8 +921,28 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 file_end_write(cprm.file);
>                 free_vma_snapshot(&cprm);
>         }
> -       if ((cn.core_type =3D=3D COREDUMP_PIPE) && core_pipe_limit)
> -               wait_for_dump_helpers(cprm.file);
> +
> +       if (core_pipe_limit) {
> +               switch (cn.core_type) {
> +               case COREDUMP_PIPE:
> +                       wait_for_dump_helpers(cprm.file);
> +                       break;
> +               case COREDUMP_SOCK: {
> +                       char buf[1];
> +                       /*
> +                        * We use a simple read to wait for the coredump
> +                        * processing to finish. Either the socket is
> +                        * closed or we get sent unexpected data. In
> +                        * both cases, we're done.
> +                        */
> +                       __kernel_read(cprm.file, buf, 1, NULL);
> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
> +       }
> +
>  close_fail:
>         if (cprm.file)
>                 filp_close(cprm.file, NULL);

