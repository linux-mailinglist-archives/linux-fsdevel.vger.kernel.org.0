Return-Path: <linux-fsdevel+bounces-39922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C0A19CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 03:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B467A23C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2720330;
	Thu, 23 Jan 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe8Z/lJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD131BC4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737599437; cv=none; b=MvjhHcWNhzyT9YX0JZMAxUY0gVkVwOoyI+68lX0flZSTsgDYqc3HmJghf/mKOXHYedNxdGcTiOf5E6jZsbuiOyEARCt7dOQ2XOWO3jekWpJIrv/+0+zU90Odt+sUQpoqfPt5P5SxRdKpcvNwVI2ZUG+am+iLfGyJPisRtAH/v/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737599437; c=relaxed/simple;
	bh=gqe6+tUvlgiA5WAVDGBG+jVZTf1qMlIHO1BeDjGGE78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGC3h1jzZew9MIpyJiqMNjVX/aBYv7o66ge42moOjzx/N5mk9nU0SKjbm06f4TVy0EL804dMBMvhZjZWMKfysc96ou12mVOWSJbvc9HwZWS/Sx/wN295jatkKMbj0yX5gBPs3JL+fg/mukfAKAaPvf/0n0vlG5rCJD0Jx6mHRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe8Z/lJi; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e479e529ebcso569998276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 18:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737599435; x=1738204235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf5z4qvfdvU6nYVXzAALOV2+7A8UF6d6VzXqSVe9XX8=;
        b=Fe8Z/lJidxmL89bZAlHFu1phdNPLk2DZCROAm4RH4AE13od4MeYUvve7qntmBFHAuH
         o9eXfxgqlm11mFG5oXH0Lze18TeF40EX/qWThJnryeQlhEMpHVQ/7uvJ+UMzrTcDn5x0
         1dCXHKllF3tDzGjXgvD5W25jADXXNOGKpDCbRMLj8WgBRbGyP9Xa+37tCCung1SVGReg
         /mykBzehg00HqefLTh24owywUobu1aW/nY+3dOsptasn5o7fmdmfOd2ZSku43Yv5R7wu
         PgC+zAI8zoDhgsDL4h/c1mjysdcfEM8E2GSptpt3fmSz0RxBbxc4GRft+7GVxvj1O0Dq
         s+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737599435; x=1738204235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wf5z4qvfdvU6nYVXzAALOV2+7A8UF6d6VzXqSVe9XX8=;
        b=NP+OTGRrBhS/7bWMCKk0ENm25Xl6Gwks/XIFouN7FXcwr7AZ4oj10wOtBEJn5UeiIo
         wJbLBipLAIldGUqxLToubIwKhDKBC9155B+Uh1C7d97VGdpnTl7rDnwi+nV7CwzrrmmL
         qDG83EgYTj9UNC03EHUQtan8WeRluzUC5mEKAWkyvKxramK6w9QG51eLzcBSMeh8rKKY
         Qhn9bEt+U+EUxkMsrK8elzY98HWz1fuy23yF6gshtVGiefledlidkIjQIhL1MqHgQDl/
         vhlQB+EnHag+KBmeIBYAZWpkXOJWPC5R3Zn+paV+fY3NQ69vEB7lpiZsYLnSzOzBN/7z
         0R8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbcC2SsLinX5/kRo7GRwMo65dAYtYwyoiR8CAGbFB3iI3vZ/gPkcDX2yq2UmgBp+u5CB9H7o3rtqyYZM0B@vger.kernel.org
X-Gm-Message-State: AOJu0YynySudZtGebfN0xlUmpuJmLIn8dyfxsUe7l7S3rc7o0lDLunEl
	nX7Vp7ruR8T4H6B8H6s6zBCANCxTBbU2Mz0gGAEGSYkbdo/E/SRGjNVc7ERowXXu1TAq1TC2eLv
	kpjp1rSq17Eqnu9b0+QrQ3pxP1CI=
X-Gm-Gg: ASbGncvB/i9mrytapEnYwRCTZ6D+RMCkkccPFM2TwxPEdy8raHyvN6DNEp5E1PTDIhJ
	b7YfHYearKb3ygERC1pQ0epxtZgUPKwE5QkZzPJPb2wiEY7O4SM5S/U3eL+Lc7/Q=
X-Google-Smtp-Source: AGHT+IFCObH1TO6RokL/nIp1pjbMm4X5GUEMkBOO3FcBtTiYKMJLwOG2STBqmQItOJ0LEg2SIm9DihdW20fZGLnObKg=
X-Received: by 2002:a05:690c:3749:b0:6ef:61b9:dfca with SMTP id
 00721157ae682-6f6eb6a1805mr192007027b3.20.1737599434855; Wed, 22 Jan 2025
 18:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122020850.2175427-1-kolyshkin@gmail.com> <20250122-lenkung-gasthaus-faf0b8609790@brauner>
In-Reply-To: <20250122-lenkung-gasthaus-faf0b8609790@brauner>
From: Kirill Kolyshkin <kolyshkin@gmail.com>
Date: Wed, 22 Jan 2025 18:30:23 -0800
X-Gm-Features: AWEUYZmrnbSpbHf3aUOE976p9ffcuqY0GfGoYFl-9KMTyVdVQwil95EnCkJHFqU
Message-ID: <CAGmPdrwB6MrEuVim+7ve3ZoOTmT2gDim-gJi6dCNVNhM0WHGvw@mail.gmail.com>
Subject: Re: Bug with splice to a pipe preventing a process exit
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:31=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jan 21, 2025 at 06:08:41PM -0800, Kir Kolyshkin wrote:
> > While checking if the tool I'm co-maintaining [1] works OK when compile=
d
> > with the future release of golang (1.24, tested with go1.24rc2), I foun=
d
> > out it's not [2], and the issue is caused by Go using sendfile more [3]=
.
> >
> > I came up with the following simple reproducer:
> >
> > #define _GNU_SOURCE
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/sendfile.h>
> > #include <sys/wait.h>
> > #include <sys/socket.h>
> > #include <sys/un.h>
> >
> > int main() {
> >       int sks[2];
> >       int pipefd[2];
> >       if (pipe(pipefd) =3D=3D -1) {
> >               perror("pipe");
> >               exit(1);
> >       }
> >
> >       pid_t pid =3D fork();
> >       if (pid =3D=3D -1) {
> >               perror("fork");
> >               exit(1);
> >       }
> >
> >       if (pid =3D=3D 0) {
> >               // Child process.
> >               close(pipefd[1]); // Close write end.
> >
> >               // Minimal process that just exits after some time.
> >               sleep(1);
> >
> >               _exit(0); // <-- The child hangs here.
> >       }
> >
> >       // Parent process.
> >       close(pipefd[0]);  // Close read end.
> >
> >       printf("PID1=3D%d\n", getpid());
> >       printf("PID2=3D%d\n", pid);
> >       printf("ps -f  -p $PID1,$PID2\n");
> >       printf("sudo tail /proc/{$PID1,$PID2}/{stack,syscall}\n");
> >
> > #ifdef TEST_USE_STDIN
> >       int in_fd =3D STDIN_FILENO;
> > #else
> >       socketpair(AF_UNIX, SOCK_STREAM, 0, sks);
> >       int in_fd =3D sks[0];
> > #endif
> >       // Copy from in_fd to pipe.
> >       ssize_t ret =3D sendfile(pipefd[1], in_fd, 0, 1 << 22);
> >       if (ret =3D=3D -1) {
> >               perror("sendfile");
> >       }
> >
> >       // Wait for child
> >       int status;
> >       waitpid(pid, &status, 0);
> >
> >       close(pipefd[1]); // Close write end.
> >       return 0;
> > }
> >
> > To reproduce, compile and run the above code, and when it hangs (instea=
d
> > of exiting), copy its output to a shell in another terminal. Here's wha=
t
> > I saw:
> >
> > [kir@kir-tp1 linux]$ PID1=3D2174401
> > PID2=3D2174402
> > ps -f  -p $PID1,$PID2
> > sudo tail /proc/{$PID1,$PID2}/{stack,syscall}
> > UID          PID    PPID  C STIME TTY          TIME CMD
> > kir      2174401   63304  0 17:34 pts/1    00:00:00 ./repro
> > kir      2174402 2174401  0 17:34 pts/1    00:00:00 [repro]
> > =3D=3D> /proc/2174401/stack <=3D=3D
> > [<0>] unix_stream_read_generic+0x792/0xc90
> > [<0>] unix_stream_splice_read+0x6f/0xb0
> > [<0>] splice_file_to_pipe+0x65/0xd0
> > [<0>] do_sendfile+0x176/0x440
> > [<0>] __x64_sys_sendfile64+0xb3/0xd0
> > [<0>] do_syscall_64+0x82/0x160
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > =3D=3D> /proc/2174401/syscall <=3D=3D
> > 40 0x4 0x3 0x0 0x400000 0x64 0xfffffff9 0x7fff2ab3fc58 0x7f265ed6ca3e
> >
> > =3D=3D> /proc/2174402/stack <=3D=3D
> > [<0>] pipe_release+0x1f/0x100
> > [<0>] __fput+0xde/0x2a0
> > [<0>] task_work_run+0x59/0x90
> > [<0>] do_exit+0x309/0xab0
> > [<0>] do_group_exit+0x30/0x80
> > [<0>] __x64_sys_exit_group+0x18/0x20
> > [<0>] x64_sys_call+0x14b4/0x14c0
> > [<0>] do_syscall_64+0x82/0x160
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > =3D=3D> /proc/2174402/syscall <=3D=3D
> > 231 0x0 0xffffffffffffff88 0xe7 0x0 0x0 0x7f265eea01a0 0x7fff2ab3fc58 0=
x7f265ed43acd
> >
> > Presumably, what happens here is the child process is stuck in the
> > exit_group syscall, being blocked by parent's splice which holds the
> > lock to the pipe (in splice_file_to_pipe).
>
> Splice is notoriously problematic when interacting with pipes due to how
> it holds the pipe lock. We've had handwavy discussions how to improve
> this but nothing ever materialized.
>
> The gist here seems to me that unix_stream_read_generic() is waiting on
> data to read from the write-side of the socketpair(). Until you close
> that fd or provide data you'll simply hang forever.

My thinking is splice should also return upon closing the other end of
the pipe it should writes to (i.e. pipefd[0] which the child is supposed
to read from), as the pipe consumer is gone. The program above
does just that -- it tries to close the end of the pipe it's supposed to
read from (implicitly, upon exit) -- alas, the close is blocked by that
very splice.

The parent could also close the reading fd (in_fd), as per your
suggestion, but it makes sense to do so only once the child has
exited -- and again, it's not possible because splice causes it
to block during exit, and so the parent couldn't know the child
is done. Surely, we can add another mechanism so the child
can tell the parent that it's about done.

In real life, the parent is "runc exec" and the child is any binary
executed in a container. Splice is used to forward data from
runc's stdin to that container process. It looks like it's impossible
to use splice in this scenario.

From a (perhaps overly naive) userspace perspective, a pipe has
two ends (file descriptors), and using one should not block the other
from closing.

> Similar with STDIN_FILENO fwiw. If you never enter any character you
> simply hang forever waiting for input.
>
> So imho the way the program is written is buggy.

Alas, nothing in the splice(2) man page prepared me for this
(and I guess it is not an easy task to explain this limitation in there).

I thought about ways to make it work, while still using splice, and
taking into account the child execs an arbitrary binary, but could
not come up with anything not overly complicated.

I still hope this can be fixed in the kernel (by using some finer-grain
locking maybe), but for now, I guess, Go's io.Copy should stop using
sendfile if either file descriptor refers to a pipe.


> But Jens might be able to provide more details.
>
> >
> > To me, the code above looks valid, and the kernel behavior seems to
> > be a bug. In particular, if the process is exiting, the pipe it was
> > using is now being closed, and splice (or sendfile) should return.
> >
> > If this is not a kernel bug, then the code above is not correct; in
> > this case, please suggest how to fix it.
> >
> > Regards,
> >   Kir.
> >
> > ----
> > [1]: https://github.com/opencontainers/runc
> > [2]: https://github.com/opencontainers/runc/pull/4598
> > [3]: https://go-review.googlesource.com/c/go/+/603295

