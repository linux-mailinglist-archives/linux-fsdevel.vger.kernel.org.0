Return-Path: <linux-fsdevel+bounces-49200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47AAB91D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C4D4E8019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB284288C8C;
	Thu, 15 May 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjb/opsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15725A349
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345098; cv=none; b=YhK37bfXqgll1E9LriC66Z/yAU5lXEE33PTGkBb28DaI766riYFm3+tXjqTzoAno6iJAibYTcxBzBRbqHFRQiqtFzr0mXhB+DVzLFdtMn6Oqke0eR3vgLqlWdwji9Qhe629zAg/VtAbvJ+yqhGDcZ6QKQZU7oXrr9GoH+tet5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345098; c=relaxed/simple;
	bh=2r6+XSECKcWKaO/VXv4v+3bUhNwHwFwv90RIeKI6JnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQ5G2+CCZqeGIiGRXOyNNV9BvXauOtsSGuucxXRvco2/fPT2nUz3cYnfXGFiOhanNa+Q2xT0YNOzuxeuw26zTdxJuzz+vCNF7BviFtPk2qrcNkX8pPitLhqldc3m/QIGGnve080MYd0d4Zvsvj4D9lY20pS1e4Xgotz1Z/qvMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjb/opsi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3970a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747345094; x=1747949894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LVA8CfjDfm+VSCeyGlJaAgYMUBeRaQEtemdua5k1qM=;
        b=mjb/opsiTW2Pjl2MDNYLSP98lR+wzh1ls9TCH2OwBIDZ1EtNxiIyo7ShTYSo8+XtOU
         n6E00AIWc++oIbh3vydgH8+2gk042JwsnY5bmczwKjzEIs7kc8His9u6gr1FdEG656By
         Wp219ZRXEVJQ+kdOjwYD22SiXzYMZ83FgRKTsYWDVdlZFzXkj73D0Mq2B2UnOFzvxGtz
         zNBy8cs/z6aQdT/IncGqSK+sNkO8m6rGZi+mVTY4rYfH/04vmDyXtMb9tx7ZaP2I9wiU
         vu/M8ifM2JiJgrcf0clbt+MC30XGJtBJfuj8Q6Tyi9RUHsVe34uEXxw2rv+s+2FVE5QB
         6b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747345094; x=1747949894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LVA8CfjDfm+VSCeyGlJaAgYMUBeRaQEtemdua5k1qM=;
        b=YxRWXUdIM75SKmdL9eKdvkbfM+eX+4taUW8MjW/679zGOHAHywfEJ0DEaO165vi0ys
         RLhxEvmVG8KDP7BtTMA6+nA6yOyc4aTMfx0wq3mqLsfoYgNBqipOycm6jbib+uhdc3rG
         k38dKMdtVgaYseOtf8fMJIG+6yDwcmiRveJkLuHPQfklu6L2fJ5omcH+QQOWH0Sfv9pl
         No71esO9OcGqLJcWMd774isjFWebyKeNyLcEHYrPAFebTZRCUQa6sLQ1RcqDEGpXqESk
         oLIl4TUXOR7e96Yfy03nIrYJPwTxbqdrOViqYN6d87JGZGlWMNcqnF9+/ZAZnY3ZUAT2
         0xhQ==
X-Gm-Message-State: AOJu0Yzi5YoXqcxA2yoNx0cP5mfe//aUgssOpagCbIMBRcepqpnZfj/C
	1LLQxHhCLkwZ6UJOAr+qBwUyoVcvkljiJLvEJBLrB4I0y0s24r/tJ39N4tDTmFDa8eiQzqjAydN
	l2Nk8I9fTu+mSq8ibjSUEja1JZhFwBbVVsveG9hs8
X-Gm-Gg: ASbGncsqDWF0Z+6FdwFxRahmrmxZQJVXeAbWtQmDln2TDwC4SkTAKPQRg/V5IUqV2dw
	n4rs3loY3OEcf78AIn3v0YlTOCZAVfHV4e1Z15UDzOCTUhE7cvhtfQO37bX1gKHHoiev0mQQHLU
	sZh2A5hlZVFhklC4kEcjyFBkPqKzISdyfR8LKmEJr/cmDI7zPS2vA8qpJD/6rG
X-Google-Smtp-Source: AGHT+IH49Y6US4taITWDU1pbVlF4yC0gcI/8Nb0THiwVU/n/87BUmOnKPci4gt5tadLxk2qZ0VReEuyaOguZv9aRoAQ=
X-Received: by 2002:a50:951d:0:b0:5fd:d62b:a68d with SMTP id
 4fb4d7f45d1cf-5ffce28c7cemr138026a12.3.1747345094235; Thu, 15 May 2025
 14:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org> <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>
In-Reply-To: <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 23:37:37 +0200
X-Gm-Features: AX0GCFsPTOBbbM97nj_zGvtiFNH08JEBWZLvjPj801SQAX6rk9ubric3xqIPWGc
Message-ID: <CAG48ez33kd=KFKfxNN1Z-xwrCvrHSNumJ-YbDmke0GM2a3tv0g@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
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

On Thu, May 15, 2025 at 10:56=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> > mask flag. This adds the fields @coredump_mask and @coredump_cookie to
> > struct pidfd_info.
>
> FWIW, now that you're using path-based sockets and override_creds(),
> one option may be to drop this patch and say "if you don't want
> untrusted processes to directly connect to the coredumping socket,
> just set the listening socket to mode 0000 or mode 0600"...

Er, forget I said that, of course we'd still want to have at least the
@coredump_mask.

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
> > +                * Set the thread-group leader pid which is used for th=
e
> > +                * peer credentials during connect() below. Then
> > +                * immediately register it in pidfs...
> > +                */
> > +               cprm.pid =3D task_tgid(current);
> > +               retval =3D pidfs_register_pid(cprm.pid);
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
>
> > +                */
> >                 retval =3D kernel_connect(socket, (struct sockaddr *)(&=
addr),
> >                                         addr_len, O_NONBLOCK | SOCK_COR=
EDUMP);
> > +
> > +               /* ... So we can safely put our pidfs reference now... =
*/
> > +               pidfs_put_pid(cprm.pid);
>
> Why can we safely put the pidfs reference now but couldn't do it
> before the kernel_connect()? Does the kernel_connect() look up this
> pidfs entry by calling something like pidfs_alloc_file()? Or does that
> only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?
>
> >                 if (retval) {
> >                         if (retval =3D=3D -EAGAIN)
> >                                 coredump_report_failure("Coredump socke=
t %s receive queue full", addr.sun_path);
> [...]
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 3b39e471840b..d7b9a0dd2db6 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> [...]
> > @@ -280,6 +299,13 @@ static long pidfd_info(struct file *file, unsigned=
 int cmd, unsigned long arg)
> >                 }
> >         }
> >
> > +       if (mask & PIDFD_INFO_COREDUMP) {
> > +               kinfo.mask |=3D PIDFD_INFO_COREDUMP;
> > +               smp_rmb();
>
> I assume I would regret it if I asked what these barriers are for,
> because the answer is something terrifying about how we otherwise
> don't have a guarantee that memory accesses can't be reordered between
> multiple subsequent syscalls or something like that?
>
> checkpatch complains about the lack of comments on these memory barriers.
>
> > +               kinfo.coredump_cookie =3D READ_ONCE(pidfs_i(inode)->__p=
ei.coredump_cookie);
> > +               kinfo.coredump_mask =3D READ_ONCE(pidfs_i(inode)->__pei=
.coredump_mask);
> > +       }
> > +
> >         task =3D get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> >                 /*
> [...]
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index a9d1c9ba2961..053d2e48e918 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> [...]
> > @@ -742,6 +743,7 @@ static void unix_release_sock(struct sock *sk, int =
embrion)
> >
> >  struct unix_peercred {
> >         struct pid *peer_pid;
> > +       u64 cookie;
>
> Maybe add a comment here documenting that for now, this is assumed to
> be used exclusively for coredump sockets.
>
>
> >         const struct cred *peer_cred;
> >  };
> >

