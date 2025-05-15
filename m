Return-Path: <linux-fsdevel+bounces-49193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D4CAB910B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E478A7B2F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CE29B791;
	Thu, 15 May 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2E4TkUI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53F19CCEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342627; cv=none; b=KWw+EVisYk7qAcsRkTO1gipUsJyyYMGK5CquNkIaFL+5qfctQNPOrTAO7oka52vvO7ioQgloWnjFcbVWInXbQkSDr8Bvdqj9YbwqGxiFGghGgFwfvirpBh1K134Fpf3Tu25o8FbVpOgyrk+x16td3PxxTx7mLszf+uYgRz3S1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342627; c=relaxed/simple;
	bh=WAuojBQeTYGID0V8nfyJqR75i/8ljPBUHbmJ6zl0Hyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC5c4sUe4ruot3FBwj4pqmVpY8kqky0UzwpADzz2UH13AqULrGAkMeka0C+F/jJu01IE1j4a/lMdmd7rUHFfiPHkx26Z0V1UtowJDhQs752qvwsw98GZYe/8utiV1YLUFjMBmIyggq4ZDQab56nK9gjXNa0z0t0O7IGpHsQQtvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2E4TkUI+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3611a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342623; x=1747947423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6d1ws3HBhNK42TBISsMf1OSa89s2CwS14owdyho6Rk=;
        b=2E4TkUI+CkbZkAlnC250Mxe9/xitNISCbm+s0arngzN0SxILB4dg3HqI1BK5I2zKgR
         7GvKDcylgzK2pQ8eohgxuiqSAqXPEBBRpOLErS9ShOHKJzGF9hlw+W3Qusq8Kh0RKJRH
         1uv9KbqG70Pudhl5fpsuzWxkf9fEHohYHWmoF1/VcMn9aB4uWARWkKn0F0C7lU75gr9I
         NN31mT6E32bLzayS0b299ZgICa992MhsyXDwmx0w0rOrghswTtNGP4OOYvHhd+MDzOzh
         s2i8n7hfxoOkW8mB1+ej/yFWZc5FpQg8COHGEr0eu5XYG8ry1xBhWe9Wt1aIp4x5KIqv
         5rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342623; x=1747947423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6d1ws3HBhNK42TBISsMf1OSa89s2CwS14owdyho6Rk=;
        b=mJ1a/iowhDcdvVF0boI9/4HXWj8CG0k3iRFzj5/ECBNNqPNIkV/Ah88H2oNOZEGfH4
         sunc+j5GS32cBF2WzWbWt72aiypqMGmU3tCJhHhNRpfxSC85hH42hzH5gxqxuUTBe0dF
         +IHpnLuYZI/NpwyQxMFAxB1kDER8bDBsvBT1FE3wk7SoZETFQ7nTOmVR3ce36lb1wuKy
         +6AWnQgDxMmgH1Zmgn2oJkNunyGLW9WAyND0GXsxzoQmcsuIumrACnR7lQILXhh/hS7T
         NKAcVOqA4TE2+JelN/NS/vS2g+VN4L6YjqpZRnPV8YjLCtFcvqSrlH0FYyolznKvC45C
         Hfuw==
X-Gm-Message-State: AOJu0Yyhn9T/3cYXPh4WPQUm55yjAruqY3X9XGv30p/JJk0eNV3yJ767
	22nt0DkHJGE2SOi6WhnINhXG1+N06hAf2HmXugPVvRQZqra1nPX/9awRqDvgHDDqHr1GmckhGPN
	Os+m903hW3Q36OniZU2tuoWXgnKzeJsekPLDjg95I
X-Gm-Gg: ASbGncv3dKRRL2vlYiL8YdTJq2MQ68P3kJMuqhEPuXrYC/4L2AYnPNWdejiE15fCokx
	yjrMtphbcAEubrmh7CexH5kkx4I/VOPxJfLG1Iqoh+VBoVzu1lh1GgJFjhIkYEgywk/rTL18Jgo
	NOCgXB8eh5SFO+s5ykVRAvMVYwmhQi1N5nLWvSsg9kmnfQH+KKmePL7dMnRyNQ
X-Google-Smtp-Source: AGHT+IE5Rdo2+rJoO+MntkgAfh3AGDE0/YaYr5xKepwgWrPQCmQuQyp16WQnYIKaU4pJoL2XM+cnwZSzgGO0Z5SGp6I=
X-Received: by 2002:a50:cd19:0:b0:5fc:a9f0:3d15 with SMTP id
 4fb4d7f45d1cf-5ffce28bb43mr138842a12.1.1747342622880; Thu, 15 May 2025
 13:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:26 +0200
X-Gm-Features: AX0GCFsmCNdRDo8SbhgKUg3UIm_6Yt4H4myWdmQn9E_klnoqzxRp7OxxuDj2C0g
Message-ID: <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>
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

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> mask flag. This adds the fields @coredump_mask and @coredump_cookie to
> struct pidfd_info.

FWIW, now that you're using path-based sockets and override_creds(),
one option may be to drop this patch and say "if you don't want
untrusted processes to directly connect to the coredumping socket,
just set the listening socket to mode 0000 or mode 0600"...

> Signed-off-by: Christian Brauner <brauner@kernel.org>
[...]
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e1256ebb89c1..bfc4a32f737c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
[...]
> @@ -876,8 +880,34 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         goto close_fail;
>                 }
>
> +               /*
> +                * Set the thread-group leader pid which is used for the
> +                * peer credentials during connect() below. Then
> +                * immediately register it in pidfs...
> +                */
> +               cprm.pid =3D task_tgid(current);
> +               retval =3D pidfs_register_pid(cprm.pid);
> +               if (retval) {
> +                       sock_release(socket);
> +                       goto close_fail;
> +               }
> +
> +               /*
> +                * ... and set the coredump information so userspace
> +                * has it available after connect()...
> +                */
> +               pidfs_coredump(&cprm);
> +
> +               /*
> +                * ... On connect() the peer credentials are recorded
> +                * and @cprm.pid registered in pidfs...

I don't understand this comment. Wasn't "@cprm.pid registered in
pidfs" above with the explicit `pidfs_register_pid(cprm.pid)`?

> +                */
>                 retval =3D kernel_connect(socket, (struct sockaddr *)(&ad=
dr),
>                                         addr_len, O_NONBLOCK | SOCK_CORED=
UMP);
> +
> +               /* ... So we can safely put our pidfs reference now... */
> +               pidfs_put_pid(cprm.pid);

Why can we safely put the pidfs reference now but couldn't do it
before the kernel_connect()? Does the kernel_connect() look up this
pidfs entry by calling something like pidfs_alloc_file()? Or does that
only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?

>                 if (retval) {
>                         if (retval =3D=3D -EAGAIN)
>                                 coredump_report_failure("Coredump socket =
%s receive queue full", addr.sun_path);
[...]
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 3b39e471840b..d7b9a0dd2db6 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
[...]
> @@ -280,6 +299,13 @@ static long pidfd_info(struct file *file, unsigned i=
nt cmd, unsigned long arg)
>                 }
>         }
>
> +       if (mask & PIDFD_INFO_COREDUMP) {
> +               kinfo.mask |=3D PIDFD_INFO_COREDUMP;
> +               smp_rmb();

I assume I would regret it if I asked what these barriers are for,
because the answer is something terrifying about how we otherwise
don't have a guarantee that memory accesses can't be reordered between
multiple subsequent syscalls or something like that?

checkpatch complains about the lack of comments on these memory barriers.

> +               kinfo.coredump_cookie =3D READ_ONCE(pidfs_i(inode)->__pei=
.coredump_cookie);
> +               kinfo.coredump_mask =3D READ_ONCE(pidfs_i(inode)->__pei.c=
oredump_mask);
> +       }
> +
>         task =3D get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 /*
[...]
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a9d1c9ba2961..053d2e48e918 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
[...]
> @@ -742,6 +743,7 @@ static void unix_release_sock(struct sock *sk, int em=
brion)
>
>  struct unix_peercred {
>         struct pid *peer_pid;
> +       u64 cookie;

Maybe add a comment here documenting that for now, this is assumed to
be used exclusively for coredump sockets.


>         const struct cred *peer_cred;
>  };
>

