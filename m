Return-Path: <linux-fsdevel+bounces-29047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843699740C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C011C253CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6E361FE1;
	Tue, 10 Sep 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8oddE/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150F2AD13
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989900; cv=none; b=ix+XIsQOmVmRUUVKHOkDFPIpPy8x7mfFReZE+OSi5p1CN0sEMBkG3wRpUe1eB/6qtIE3EGjwmzqhl0Vwv4nVqQenw6AzmZkIoRneV0FB1HrvLhLqq5zSONrZd5Do+Fh9EdnQAtUwzznKS1a2N6vW4CNxtHSnNPRAFaWJWPRpyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989900; c=relaxed/simple;
	bh=2rx6Hfc+frRxNBhT0D7c59KT8lzz8bb1H81DwQ4sdoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqergqI7BtlXQqH3707+HICSxaGW3oSCaI7qCSH9z1fciFkJihBG8EjlGNzdFj82iB3Sa0yKZLlDZFtme05rZTEYgib9StneiS68/qxn8l+M65+aRQBq04K4W7a1bw/DdibLMU8Jmzuc0GMjltxXA3PVI8kosl80nWKVvpbBKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8oddE/c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so3789630a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725989898; x=1726594698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfZkMogBmlO5vX1pX/8139y0uEZmgq0jZStPR2KvxB8=;
        b=l8oddE/cIKpP+6t4FRy1Ks7NaRT2WrAAqCT64NF3dG3UFJfrvpd70hw6+dKE63M9Ly
         3K0U0CmxTFUSu17szr33K7NS8o42bGyQPeglZVx8mE8/1JRvtrrWnsgbSiDJTuDHhSvS
         1SytKTp5TRLldQn+ZR8s8SYcB5cHfj6vxregx1UuNes0g1uogQc6yeAOQo7V7vrh3S0M
         EX4ZTxLO4aJWPmMf8PVxt1SJV9LxLjRfTrkVWJyj0p2y68Y/ytmUhHhqdibBxXoR/+dh
         gOgsvc/8L7ydavlP51yAYMhSjLsLgElS1cKlpMi6d+O98cuqHgzABGChYGYlJ4UWr6oB
         deMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989898; x=1726594698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfZkMogBmlO5vX1pX/8139y0uEZmgq0jZStPR2KvxB8=;
        b=HBiy8TGI/HGzVFAOSdf3dbS/HWmz7zT7UiLS7TWFDIi5JlNr//ltHbElz/iGRY6hH5
         aVjFiut9ZFGaEhgMYEdsqJPji08qG6N8tOFQqv7wnXIQ1JFOYOozRbJXljQX1O/POEzW
         LZWwRFMn03/QAjQ+OctbRdJ/GhvjUuAdju35n6swBQcTRQQHzcPznVi/izLVRbfZm/gL
         0QGBTsXziMjGKD1pAVsJcWJ8zvnJgmoShq8GDusCB1wuRdgU6b8sctAuAWZpzD6wQqUY
         LvLVY+IL7yQGU9JeQrcvxlJRvF3dS0qSgIjTsK4RD/WwKJe6qmFCb/Bf3amjAC8df21q
         WLmQ==
X-Gm-Message-State: AOJu0Yy63ysYIu8aoO/s05fYXJe/C4A/DakWcLHQOMSzBCLgnQgbe/51
	nRQ13IATqZXgB1w0S3luwSb6X1ogNuQ35YkqjrJMiOEnO3jmHtgtpPEnAvFrXIOsCJFMz2prXkT
	8KBV4xk0OQho0uRFmUNiD8PfnBI8=
X-Google-Smtp-Source: AGHT+IF2tY6fGN3JSx1FKpFl5EjmCDJzlo7pCitvboGNJMFQwHjOi9pF4LcBIdsnAK7eu7R9ObX2R3YEhbAOa3B+jDk=
X-Received: by 2002:a17:90a:b013:b0:2d8:9040:d170 with SMTP id
 98e67ed59e1d1-2dad50fcfaamr14119612a91.31.1725989897929; Tue, 10 Sep 2024
 10:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
In-Reply-To: <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 10 Sep 2024 19:38:06 +0200
Message-ID: <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:58=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> > I have noticed Go-FUSE test failures of late, that seem to originate
> > in (changed?) kernel behavior. The problems looks like this:
> >
> > 12:54:13.385435 rx 20: OPENDIR n1  p330882
> > 12:54:13.385514 tx 20:     OK, {Fh 1 }
> > 12:54:13.385838 rx 22: READDIRPLUS n1 {Fh 1 [0 +4096)  L 0 LARGEFILE}  =
p330882
> > 12:54:13.385844 rx 23: INTERRUPT n0 {ix 22}  p0
> > 12:54:13.386114 tx 22:     OK,  4000b data "\x02\x00\x00\x00\x00\x00\x0=
0\x00"...
> > 12:54:13.386642 rx 24: READDIRPLUS n1 {Fh 1 [1 +4096)  L 0 LARGEFILE}  =
p330882
> > 12:54:13.386849 tx 24:     95=3Doperation not supported
> >
> > As you can see, the kernel attempts to interrupt the READDIRPLUS
>
> do you where the interrupt comes from? Is your test interrupting
> interrupting readdir?

I did not write code to issue interrupts, but it is possible that the
Go runtime does something behind my back. The debug output lists "p0";
is there a reason that the INTERRUPT opcode does not provide an
originating PID ? How would I discover who or what is generating the
interrupts? Will they show up if I run strace on the test binary?

I straced the test binary, below is a section where an interrupt
happens just before a directory seek. Could tgkill(SIGURG) cause an
interrupt? It happens just before the READDIRPLUS op (',') and the
INTERRUPT operation ('$') are read.

[pid 371933] writev(10,
[{iov_base=3D"\260\17\0\0\0\0\0\0\20\0\0\0\0\0\0\0", iov_len=3D16},
{iov_base=3D"\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\0\
0\0\0"..., iov_len=3D4000}], 2 <unfinished ...>
[pid 371931] <... nanosleep resumed>NULL) =3D 0
[pid 371933] <... writev resumed>)      =3D 4016
[pid 371931] nanosleep({tv_sec=3D0, tv_nsec=3D20000},  <unfinished ...>
[pid 371933] read(10,  <unfinished ...>
[pid 371934] <... getdents64 resumed>0xc0002ee000 /* 25 entries */, 8192) =
=3D 800
[pid 371931] <... nanosleep resumed>NULL) =3D 0
[pid 371934] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
[pid 371931] getpid( <unfinished ...>
[pid 371934] <... futex resumed>)       =3D 1
[pid 371932] <... futex resumed>)       =3D 0
[pid 371931] <... getpid resumed>)      =3D 371930
[pid 371934] getdents64(7,  <unfinished ...>
[pid 371932] futex(0xc000059148, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ..=
.>
[pid 371931] tgkill(371930, 371934, SIGURG <unfinished ...>
[pid 371935] <... read
resumed>"P\0\0\0,\0\0\0\22\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..=
.,
131200) =3D 80
    # , =3D readdirplus
[pid 371933] <... read
resumed>"0\0\0\0$\0\0\0\23\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..=
.,
131200) =3D 48
    # $ =3D interrupt.
[pid 371931] <... tgkill resumed>)      =3D 0
[pid 371933] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
[pid 371931] nanosleep({tv_sec=3D0, tv_nsec=3D20000},  <unfinished ...>
[pid 371933] <... futex resumed>)       =3D 1
[pid 371932] <... futex resumed>)       =3D 0
[pid 371933] write(2, "19:24:40.813294 doInterrupt\n", 28 <unfinished ...>
19:24:40.813294 doInterrupt

A bit of browsing through the Go source code suggests that SIGURG is
used to preempt long-running goroutines, so it could be issued more or
less at random.

Nevertheless, FUSE should also not be reissuing the reads, even if
there were interrupts, right?

> > operation, but go-fuse ignores the interrupt and returns 25 entries.
> > The kernel somehow thinks that only 1 entry was consumed, and issues
> > the next READDIRPLUS at offset 1. If go-fuse ignores the faulty offset
> > and continues the listing (ie. continuing with entry 25), the test
> > passes.
> >
> > Is this behavior of the kernel expected or a bug?
> >
> > I am redoing the API for directory listing to support cacheable and
> > seekable directories, and in the new version, this looks like a
> > directory seek. If the file system does not support seekable
> > directories, I must return some kind of error (which is the ENOTSUP
> > you can see in the log above).
>
> Is this with or without FOPEN_CACHE_DIR? Would be helpful to know
> if FOPEN_CACHE_DIR - fuse kernel code is quite different when this
> is set.

without FOPEN_CACHE_DIR.

> > I started seeing this after upgrading to Fedora 40. My kernel is
> > 6.10.7-200.fc40.x86_64
> >
>
> Would be interesting to know your kernel version before? There is
> commit cdf6ac2a03d2, which removes a readdir lock. Although the
> commit message explains why it is not needed anymore.

The failure happens in single threaded loads, so a race condition
seems unlikely.

Let me try with other kernel versions.

Also, I realize that Fedora 40 also upgraded the Go compiler, and may
have made SIGURG be triggered more frequently?

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

