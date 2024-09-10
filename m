Return-Path: <linux-fsdevel+bounces-29062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4D974556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F09DB24905
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69C1AAE2C;
	Tue, 10 Sep 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFkzy2Ol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1018DF94
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005843; cv=none; b=DcbEi4JyGLpDcy+k+Jku6tcwBg4XJz1edSALer3aW+z46rOS5o+X2ujk75sly7wS3Fjge4tGnmvraWZCdp1vDsNtP5Bsw/YCUeUgKS8fTAJpk2JKQ3IEsVF3bFKzUKJUUCSqA5Htr2NrY78M5jvHIJx0NLPoFYDkhiG88/lvGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005843; c=relaxed/simple;
	bh=vAgcJrtgoxr5VaJydBiKydO7l3Kq2ukqx+Yg7RtPJlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSDZt+Ombh3k6IU9Pdlc5MEI8KgUBI1JmnEZm/JD3LtPedM/kRoEH7zpHWWUZay8XBre9TxxDQc4fqZWHKr3bTXI/mH91p+0qbhf9AL/OM4LjkKxTNa1niPn8WVw+hLEsKD5saHmNi3CmSLjV4PB32B35BpTa+w5vSGFGBBbww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFkzy2Ol; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-457ce5fda1aso49076401cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726005841; x=1726610641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHY1zNhEQXnvSlK41T13VTvywOvMqaARHTfiUMByQUk=;
        b=DFkzy2OlHiIHVQojVnZU3HSXRzZbY0hhwzXgxfl6H+iZwcvu+DYpqlVCsaNjYnUD51
         P0lKC/G2OvsPauxALowOWb1KAtL0gDCZ5SK93x9NqJZ9+lRFWtt8JOoq1bvrXZ3fiy1M
         cokdRTB3iz3Z6eu8fflY7mtbFk7/n/euB9N03wz9qFTUu/N/C6WJ1tQsEi1wx++KUc5T
         wmPN4ABtX94cu+TojL9ny7fAzG+yaf9SMCmaB5Sfad+wJjgwM4E2L8R1zqIrHWaiqJoL
         0fr/rEisNi0RYfIjK2kXefJ3b4QM/aBT0xtnmbPeWPSO9sjDJf4CeMwyeLF3fRVIDRIs
         f9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005841; x=1726610641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHY1zNhEQXnvSlK41T13VTvywOvMqaARHTfiUMByQUk=;
        b=oXi/ox9+0vSc5huZHH7eTkAMhmjuKVM46ih9loyAJ7tpOD5g1QUuw5hN16eLTSaq8/
         dbelY6/NNVZf/vNMwmJRqWfXWXWXdrFDDD/XpUxWU2cuednqVQyKU0SC5oGgGMAZxSkx
         c4Rq1hGzqw94pveOEbyJO0GtCgq/CCGrjSddLSu/FwORvtgAUTHL5wvxWpn4FzrHcM2C
         2PiWim6ZgUl3wfooDlhvJhx2XAMuiVUJylOMeCv1OknTuKnc4MJdapCuA+z2pGv00AQW
         xDyQ/xVDPGURl4qGYN0tHwPDwSO2Uuyv71fWmcZ/J2ybCNTAFN3HwJboPrNitcghr0G6
         bf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMqsng1jYX/keXzjepF5zYL4L0m9q+ULlRjB+sWpN2iF5EeCmtY9HI6grZeeLXD2kQSSTckgcUBIt/kWYi@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFwK850YVDVhkyzT/bqmka0mhUmMS2cRCLX/+BLKJ13moc9eV
	2fL1dRB8w/dznyVib+LX7ao5eSJ/BC/CDGksF7Hk9kjLGFBCI/lp3f6XN2rnDF/eexciKYx0YFA
	Z95bEms0lxLHX7bzThXunOUPfd2o=
X-Google-Smtp-Source: AGHT+IE7OOjXFVKyPny9seeKARcV+7bRyJ2m2nNPcTdZXIBwkt8tkEEe+8RBiqk66+MWasWwTWKa8nLd+AD9mjxwOQU=
X-Received: by 2002:ac8:5843:0:b0:458:4b8b:1517 with SMTP id
 d75a77b69052e-4584b8b21a0mr36075431cf.18.1726005841105; Tue, 10 Sep 2024
 15:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
In-Reply-To: <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Sep 2024 15:03:49 -0700
Message-ID: <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:44=E2=80=AFAM Han-Wen Nienhuys <hanwenn@gmail.co=
m> wrote:
>
> On Tue, Sep 10, 2024 at 5:58=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> > > I have noticed Go-FUSE test failures of late, that seem to originate
> > > in (changed?) kernel behavior. The problems looks like this:
> > >
> > > 12:54:13.385435 rx 20: OPENDIR n1  p330882
> > > 12:54:13.385514 tx 20:     OK, {Fh 1 }
> > > 12:54:13.385838 rx 22: READDIRPLUS n1 {Fh 1 [0 +4096)  L 0 LARGEFILE}=
  p330882
> > > 12:54:13.385844 rx 23: INTERRUPT n0 {ix 22}  p0
> > > 12:54:13.386114 tx 22:     OK,  4000b data "\x02\x00\x00\x00\x00\x00\=
x00\x00"...
> > > 12:54:13.386642 rx 24: READDIRPLUS n1 {Fh 1 [1 +4096)  L 0 LARGEFILE}=
  p330882
> > > 12:54:13.386849 tx 24:     95=3Doperation not supported
> > >
> > > As you can see, the kernel attempts to interrupt the READDIRPLUS
> >
> > do you where the interrupt comes from? Is your test interrupting
> > interrupting readdir?
>
> I did not write code to issue interrupts, but it is possible that the
> Go runtime does something behind my back. The debug output lists "p0";
> is there a reason that the INTERRUPT opcode does not provide an
> originating PID ? How would I discover who or what is generating the
> interrupts? Will they show up if I run strace on the test binary?
>
> I straced the test binary, below is a section where an interrupt
> happens just before a directory seek. Could tgkill(SIGURG) cause an
> interrupt? It happens just before the READDIRPLUS op (',') and the
> INTERRUPT operation ('$') are read.
>
> [pid 371933] writev(10,
> [{iov_base=3D"\260\17\0\0\0\0\0\0\20\0\0\0\0\0\0\0", iov_len=3D16},
> {iov_base=3D"\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\0\
> 0\0\0"..., iov_len=3D4000}], 2 <unfinished ...>
> [pid 371931] <... nanosleep resumed>NULL) =3D 0
> [pid 371933] <... writev resumed>)      =3D 4016
> [pid 371931] nanosleep({tv_sec=3D0, tv_nsec=3D20000},  <unfinished ...>
> [pid 371933] read(10,  <unfinished ...>
> [pid 371934] <... getdents64 resumed>0xc0002ee000 /* 25 entries */, 8192)=
 =3D 800
> [pid 371931] <... nanosleep resumed>NULL) =3D 0
> [pid 371934] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
> [pid 371931] getpid( <unfinished ...>
> [pid 371934] <... futex resumed>)       =3D 1
> [pid 371932] <... futex resumed>)       =3D 0
> [pid 371931] <... getpid resumed>)      =3D 371930
> [pid 371934] getdents64(7,  <unfinished ...>
> [pid 371932] futex(0xc000059148, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished =
...>
> [pid 371931] tgkill(371930, 371934, SIGURG <unfinished ...>
> [pid 371935] <... read
> resumed>"P\0\0\0,\0\0\0\22\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
> 131200) =3D 80
>     # , =3D readdirplus
> [pid 371933] <... read
> resumed>"0\0\0\0$\0\0\0\23\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
> 131200) =3D 48
>     # $ =3D interrupt.
> [pid 371931] <... tgkill resumed>)      =3D 0
> [pid 371933] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
> [pid 371931] nanosleep({tv_sec=3D0, tv_nsec=3D20000},  <unfinished ...>
> [pid 371933] <... futex resumed>)       =3D 1
> [pid 371932] <... futex resumed>)       =3D 0
> [pid 371933] write(2, "19:24:40.813294 doInterrupt\n", 28 <unfinished ...=
>
> 19:24:40.813294 doInterrupt
>
> A bit of browsing through the Go source code suggests that SIGURG is
> used to preempt long-running goroutines, so it could be issued more or
> less at random.
>
> Nevertheless, FUSE should also not be reissuing the reads, even if
> there were interrupts, right?

Is there a link to the test? Is it easy to repro this issue?

If I'm understanding your post correctly, the issue you are seeing is
that if your go-fuse server returns 25 entries to an interrupted
READDIRPLUS request, the kernel's next READDIRPLUS request is at
offset 1 instead of at offset 25?


Thanks,
Joanne

>
> > > operation, but go-fuse ignores the interrupt and returns 25 entries.
> > > The kernel somehow thinks that only 1 entry was consumed, and issues
> > > the next READDIRPLUS at offset 1. If go-fuse ignores the faulty offse=
t
> > > and continues the listing (ie. continuing with entry 25), the test
> > > passes.
> > >
> > > Is this behavior of the kernel expected or a bug?
> > >
> > > I am redoing the API for directory listing to support cacheable and
> > > seekable directories, and in the new version, this looks like a
> > > directory seek. If the file system does not support seekable
> > > directories, I must return some kind of error (which is the ENOTSUP
> > > you can see in the log above).
> >
> > Is this with or without FOPEN_CACHE_DIR? Would be helpful to know
> > if FOPEN_CACHE_DIR - fuse kernel code is quite different when this
> > is set.
>
> without FOPEN_CACHE_DIR.
>
> > > I started seeing this after upgrading to Fedora 40. My kernel is
> > > 6.10.7-200.fc40.x86_64
> > >
> >
> > Would be interesting to know your kernel version before? There is
> > commit cdf6ac2a03d2, which removes a readdir lock. Although the
> > commit message explains why it is not needed anymore.
>
> The failure happens in single threaded loads, so a race condition
> seems unlikely.
>
> Let me try with other kernel versions.
>
> Also, I realize that Fedora 40 also upgraded the Go compiler, and may
> have made SIGURG be triggered more frequently?
>
> --
> Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
>

