Return-Path: <linux-fsdevel+bounces-49192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF6AB9106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9681B65E78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD929B78E;
	Thu, 15 May 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AbyqKQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03B19CCEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342495; cv=none; b=vDvOKdicyP9YNqYy2seMfI5GdByCW87f97POucrGZ6UuFcXIJ5AG7hV6NA1e3gXLK5ueGZMroWVj0epoSpNFfE48CaCtANKjyrOZDlNB3qRoRDul85FUwedBWWmFG2QeKv4nURLsCx4KVXEx4TbhoDYjMJl2RbTf/MwDxShfzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342495; c=relaxed/simple;
	bh=oRQyENZF1Onlxh9uzWXJhqzxk9+D6D3Cyir6/77ShfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Me8TGUJ6QAbLg3XrqgfedUNTEpLXj/0tnyOU+myFK0Mdofw19Ujm99jXH5KK2d4UNLYAA3TXTYWBiEswvfSkNKcgVjxeM9pon8Yo60Wlj8ov5sAk3aU9SgGEdSgrDHAw3tGRqD7pbMDFidgdA6MsLGNz1yk+i6SokIdBlObvWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AbyqKQK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3574a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342491; x=1747947291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K29QDxWunUV2J4iwHAujAQoKeEARlpiYiiesPId3k54=;
        b=1AbyqKQK60Uit+9glRMMspHVBVzVC81lVv7ExDjk4qrwuRkwxKRca6h6MCh9qnZt7M
         OTmImpKQd7NPJFL55SbbiEp0dMR72Vd4MefUzHLhEB8Y2nbonTWw77fSiK5Aqg+J0oST
         Pwlw5oBJLSZQgU/LKaQCqkFxX9Fx36783SyJjTt+MZwX6nh9EbyxFY2d3N+SHVGetoIT
         rTlkk4aD8wtgoMQZEttFFsmDarRMlqF50MWVa2ytyxt7imhkh8kYWuUHGwOVgeRKGe0M
         uBSe0mGBs4jTunCzs7OVOaabdERL31M/uDMG/KsmwBzVm/PWILnOatu9A0E/smCVqQTz
         y3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342491; x=1747947291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K29QDxWunUV2J4iwHAujAQoKeEARlpiYiiesPId3k54=;
        b=JfPdAfH3DC65B+6wprNBJjJ8RdF6hI0I46MxFGzRNs19f97KFb1caAWmNeXAqLWnmq
         aGdyNSPn5q9CydOflTO3T3/CyzacLpHxTUStHC5OklIgxaAO5tKGck72VNIBLfFot7fz
         Erjo0N3MaTgi4fSpGqIyphefyZvXKD9n8Cw+QSS9xhxYcIAkupjaF+QfD2Tn2JuqZcb9
         HJe3LPJcaeJVis/a0//qB0mZihaW5qX+qZ107ajMwhnliiPBL54LykRML0rO33T2FR8s
         rTESBhFw54XmHVcAPilRYyBxjMJ+Rkw/lBI/2lbMoW3Ipw5nPyKxpBCvwPF+KW/zh+0B
         dcpw==
X-Gm-Message-State: AOJu0YwZdZFq70V3f/MAwDvdh/Tez/uykHRPe9zfWJNfdA8hLezE/kn+
	wTe8s8YzrHtxpuaw87DqupifdI7G4xj154buCAmBMddFFW/LHns6D/ieQJgpK/3pCjbCf/ZZZEy
	O4mXD8C9lpz3XxoshOPthXQwOPy/Uq7ud+NEjQmVn
X-Gm-Gg: ASbGncsKHO817CzZMWoUWrGVwZRyo5Z4e5WhcQ4XWeNkeaFj+Wv4EM9yCWa5l28jRgk
	qFOduf0pmuqb26ynpIWles0tghVmzDM1ejG7e1CgqFAhOQ3bDIePJMCdyVsqlIEPuyxXsN0h32m
	p+BTigD+gxs8dq6g22tYalWL2M9eCpCp+BuR91RYZDpJvpJCcDA/2CThhV/iAx
X-Google-Smtp-Source: AGHT+IGZLnwF0tDpkn3edeqhg9ZeHqIzzsVRGo4uINIDX8xdxWb0uuiMSqfiyFu8hygKQOl/TrJzZrqprCVvL/Q+15M=
X-Received: by 2002:aa7:c392:0:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-601233a4fc5mr3370a12.2.1747342490722; Thu, 15 May 2025 13:54:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:54:14 +0200
X-Gm-Features: AX0GCFsWRE5Q8pfmeO_D6ALNbCTD0QZWW_K-eXNovp5kcAGLVTZvVNgd7t1lOb4
Message-ID: <CAG48ez2iXeu7d8eu7L694n54qNi=_-frmBst36iuUTpq9GCFvg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> diff --git a/fs/coredump.c b/fs/coredump.c
> index a70929c3585b..e1256ebb89c1 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
[...]
> @@ -393,11 +428,20 @@ static int format_corename(struct core_name *cn, st=
ruct coredump_params *cprm,
>          * If core_pattern does not include a %p (as is the default)
>          * and core_uses_pid is set, then .%pid will be appended to
>          * the filename. Do not do this for piped commands. */
> -       if (!(cn->core_type =3D=3D COREDUMP_PIPE) && !pid_in_pattern && c=
ore_uses_pid) {
> -               err =3D cn_printf(cn, ".%d", task_tgid_vnr(current));
> -               if (err)
> -                       return err;
> +       if (!pid_in_pattern && core_uses_pid) {
> +               switch (cn->core_type) {
> +               case COREDUMP_FILE:
> +                       return cn_printf(cn, ".%d", task_tgid_vnr(current=
));
> +               case COREDUMP_PIPE:
> +                       break;
> +               case COREDUMP_SOCK:
> +                       break;

This branch is dead code, we can't get this far down with
COREDUMP_SOCK. Maybe you could remove the "break;" and fall through to
the default WARN_ON_ONCE() here. Or better, revert this hunk and
instead just change the check to check for "cn->core_type =3D=3D
COREDUMP_FILE" (in patch 1), since this whole block is legacy logic
specific to dumping into files (COREDUMP_FILE).

> +               default:
> +                       WARN_ON_ONCE(true);
> +                       return -EINVAL;
> +               }
>         }
> +
>         return 0;
>  }
>
> @@ -801,6 +845,55 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 }
>                 break;
>         }
> +       case COREDUMP_SOCK: {
> +#ifdef CONFIG_UNIX
> +               struct file *file __free(fput) =3D NULL;
> +               struct sockaddr_un addr =3D {
> +                       .sun_family =3D AF_UNIX,
> +               };
> +               ssize_t addr_len;
> +               struct socket *socket;
> +
> +               retval =3D strscpy(addr.sun_path, cn.corename, sizeof(add=
r.sun_path));

nit: strscpy() explicitly supports eliding the last argument in this
case, thanks to macro magic:

 * The size argument @... is only required when @dst is not an array, or
 * when the copy needs to be smaller than sizeof(@dst).

> +               if (retval < 0)
> +                       goto close_fail;
> +               addr_len =3D offsetof(struct sockaddr_un, sun_path) + ret=
val + 1;

nit: On a 64-bit system, strscpy() returns a 64-bit value, and
addr_len is also 64-bit, but retval is 32-bit. Implicitly moving
length values back and forth between 64-bit and 32-bit is slightly
dodgy and might generate suboptimal code (it could force the compiler
to emit instructions to explicitly truncate the value if it can't
prove that the value fits in 32 bits). It would be nice to keep the
value 64-bit throughout by storing the return value in a ssize_t.

And actually, you don't have to compute addr_len here at all; that's
needed for abstract unix domain sockets, but for path-based unix
domain socket, you should be able to just use sizeof(struct
sockaddr_un) as addrlen. (This is documented in "man 7 unix".)

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

I think you missed an API gotcha here. See the sock_alloc_file() documentat=
ion:

 * On failure @sock is released, and an ERR pointer is returned.

So I think basically sock_alloc_file() always consumes the socket
reference provided by the caller, and the sock_release() in this
branch is a double-free?

> +                       goto close_fail;
> +               }
[...]
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 0ff950eecc6b..139c85d0f2ea 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -81,6 +81,7 @@ enum sock_type {
>  #ifndef SOCK_NONBLOCK
>  #define SOCK_NONBLOCK  O_NONBLOCK
>  #endif
> +#define SOCK_COREDUMP  O_NOCTTY

Hrrrm. I looked through all the paths from which the ->connect() call
can come, and I think this is currently safe; but I wonder if it would
make sense to either give this highly privileged bit a separate value
that can never come from userspace, or explicitly strip it away in
__sys_connect_file() just to be safe.

