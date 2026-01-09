Return-Path: <linux-fsdevel+bounces-73020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E1D080CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3761230155AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A184330333;
	Fri,  9 Jan 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc0keE12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C972C0F8E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949344; cv=none; b=gPteVfSbekSyMmaB9Lac2sOmuOztpopljG1J+at/2GtOI4YYYkX5tPuCjfIwCd8YsYsCuqkOtjwlP0y4tb8fC9QjWkvuEVftqk4oU0Xi8lnIjqWTRlaOxAonTg/fbmKvRmsYejqh9l49yGynp8NDIQVqINdTKMu8nY2JUz493xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949344; c=relaxed/simple;
	bh=YtKupLIBJ9j000by1XXP7xXeK81yHBpalRt99DY2eK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIig3RicDmDcdz2bc4mVAO0IbE2JzTwd/yywNjZJf0PVjkDVe6Gw8PWRpBMTn7tSjlyauT+fZ1V2/CR5Yf0qwUVUtgnN2eKI2DJkiuFTSTBEZlvoaqtFh+Nr+51dVKiQYR0MiYefAFAxED38Uu7E4MyKnDEL+vbLAbECL1oqNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc0keE12; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso8286056a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767949338; x=1768554138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4UEUK1qEdNz6L+bs7NXPJHFHW8lZNZC50cs9JtRGuI=;
        b=Yc0keE12jJwH5bUYOPLDkfUOs6qqW/wsaWpYSG9kVtE/32cogN70DVu6cX1efQFvpn
         nJfHm8O5MKY6Zx3ctUodm5AGSW/5CzYCvhVUWeOifI1dhYJuMNsA/ul5npulDvioxq1x
         C4AVeesjT4+PYtDgJih2PDuKTulOXy09eFlHwTwnQbXeNtnOgELg96qpCYwib6ifvqnb
         9RzUcbyhzFk9VlxCuD0mxqQcn9dwNZfRlUj+E1wWrXeBqv0xSXMm/Q6UaeRO0X952yoY
         I/DCJWJhwHFmCADiD5OWkr4ji5o/T4UMWnYqwHD5eyE/e3Lmj3kLHJ00Jg2HRZPU+H0H
         BsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949338; x=1768554138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4UEUK1qEdNz6L+bs7NXPJHFHW8lZNZC50cs9JtRGuI=;
        b=iZe1Z9U4fFMDatTLZvqITah+F0Sn+9t6Er1Jxw/+8g75BlIeSv4cfZMr5P6ORNjQHM
         1Tmdv+Aijqrpf7VBgSEfHrln4GZJRByNBsmlOGu3kUWP+j1vpz0AND9yFgMls1Nf0zxW
         YYqbN2SUtpEwaILnjUVsRYqWvr9bAPl1b+kKGwHY0uCTrK66DP8Jn4PIHaIoyUqXGVN4
         m+ZCS10lUVJI4HH3Z3hNP9fyHB9nV/L9YRIh5i7/8W62LaRGBLpYXuKTPEemSQN9W1br
         y/GbSg45bFWkiwdeEhioQQnP8nf20vhFz44jHCPK2lrd/uJWnzJuv1s9U431G6JgNskE
         Nx0g==
X-Gm-Message-State: AOJu0YypfifZ4c9DRgRzuuXZoM5wmvVqMkASXZttTNC0GNzZBNgJZzHA
	+vQvgeO0GXNOSaPt+Fb+Ai1qCdf/MaF26ARDBYy3R2QtR5611EZm0kZ3hKmS3uIuoSHD2pbUg+a
	Hfz738OZ7Svd0I9CnILnVfRseFy1Bh7o=
X-Gm-Gg: AY/fxX5eGxdsvULXbq2do+8WmEm4vH50+DYRt/kwcRgbGlTeRUnI3m6vNT+ueSJo0ol
	nZ93AJmGpnLn9KIXO8ElHQBrh5pC+oLCpKRcNekVJK/e1l7lMgFtDq55qh7cr4HUhNVgjZ6Cb6Q
	favXCO4HDt6ctt0/qcUxms99z2A0IQpRY8tBVtThxRiV6mYkH3uyj7AVzRKUOY68babwm7pHBUI
	Llv8atO/c6Nd8ljrLQYRENkbu+CPZ3Aa/j8+8oSh8IOJhMmk8U7VzTWMuF+q5yHOC2o
X-Google-Smtp-Source: AGHT+IGBDSt4Rc+CRQCQY6JXfMy3gLM+0zqVVmSkOCRpqDwk+CHAoizNQK6AhncYcO9l6U1JD5dpnvTNqepNL947k40=
X-Received: by 2002:a17:907:d09:b0:b72:ddfd:bca7 with SMTP id
 a640c23a62f3a-b84453385d8mr890272666b.35.1767949337438; Fri, 09 Jan 2026
 01:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
 <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
 <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
 <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com>
 <CAJnrk1a1aT77GugkAVtUixypPpAwx7vUd92cMd3XWHgmHXjYCA@mail.gmail.com>
 <CAGmFzSc3hidao0aSD9nDT50J4a9ZY053MdEPRF-x_Xfkb730-g@mail.gmail.com>
 <CAGmFzSdmGLSC59vUjd=3d3bng+SQSHL=DMUQ+fpzAM2S12DcuA@mail.gmail.com>
 <CAJnrk1Z_1LO0uS=J5uca2tXUp_4Zc+O5D6XN-hdGEJFxTKyvyw@mail.gmail.com>
 <CAGmFzSci7dC5Fq77umzrCQVaKqDPiJ4NgMGTycjvMCnPXv6-zQ@mail.gmail.com>
 <CAJnrk1ZA2eAnV8tJMnCpaBphRXh3A+XtAYk_gRZ1ohKjaRhPyA@mail.gmail.com> <CAGmFzSdcPH1Q3x342YWgA-08578YSLB0iEY6KoAyapmEULd=VA@mail.gmail.com>
In-Reply-To: <CAGmFzSdcPH1Q3x342YWgA-08578YSLB0iEY6KoAyapmEULd=VA@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Fri, 9 Jan 2026 17:02:05 +0800
X-Gm-Features: AZwV_QgG4LhjxHnTYAIYEx6TSrNqDjg8ymzwygrqJILWTs_bkEuD_oe3iGybZl4
Message-ID: <CAGmFzSd9gMCDYQR2u2NkrKArRA1rQKRWca93qwZ5ykjKSxc0Ew@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

Sorry for more information.
it looks the root cause is "io-uring queue depth must be specified"
In the past, I usually use the default value for this parameters.

Thanks
Gang

Gang He <dchg2000@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=94 15:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Joanne,
>
> I applied your V3 25
> patches(https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-jo=
annelkoong@gmail.com/T/#t)
> in the kernel v6.19-rc3. I removed the existing liburing2 package
> (dpkg --remove  --force-depends liburing2), and installed your
> liburing2 (make install).
> Then, built your libfuse code and example.
> there was still a hanged problem when ls the related fuse mount directory=
.
> the ls command back traces are as follows,
> [<0>] fuse_get_req+0x1fb/0x2e0
> [<0>] __fuse_simple_request+0x41/0x320
> [<0>] fuse_do_getattr+0x101/0x240
> [<0>] fuse_update_get_attr+0x19a/0x1c0
> [<0>] fuse_getattr+0x96/0xe0
> [<0>] vfs_getattr_nosec+0xc4/0x110
> [<0>] vfs_statx+0xa7/0x160
> [<0>] do_statx+0x63/0xb0
> [<0>] __x64_sys_statx+0xad/0x100
> [<0>] x64_sys_call+0x10c9/0x2360
> [<0>] do_syscall_64+0x81/0x500
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The hang problems are related to your new parameters(-o
> io_uring_bufring -o io_uring_zero_copy).
> If without these two parameters, the example binary files do work.
> But there was not any kernel message printed.
>
> Thanks
> Gang
>
> Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=B8=89 05:12=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Jan 5, 2026 at 6:14=E2=80=AFPM Gang He <dchg2000@gmail.com> wro=
te:
> > >
> > > Hi Joanne,
> > >
> > > Yes, I enabled /sys/module/fuse/parameters/enable_uring before doing
> > > the testing.
> > > I verified my libfuse include/fuse_kernel.h, the code looks like,
> > > struct fuse_uring_cmd_req {
> > >     uint64_t flags;
> > >
> > >     /* entry identifier for commits */
> > >     uint64_t commit_id;
> > >
> > >     /* queue the command is for (queue index) */
> > >     uint16_t qid;
> > >
> > >     union {
> > >         struct {
> > >             uint16_t flags;
> > >             uint16_t queue_depth;
> > >         } init;
> > >     };
> > >
> > >     uint8_t padding[2];
> > > };
> > >
> > > But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
> > > detailed code lines are as follows,
> > > 1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
> > > 1519                    unsigned int issue_flags, struct fuse_conn *f=
c)
> > > 1520 {
> > > 1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_cm=
d(cmd->sqe);
> > > 1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);  =
  <<=3D=3D here
> > > 1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
> > > 1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> > > 1525     struct fuse_ring_queue *queue;
> > >
> > > The problem looks like the user space side does not pass the right
> > > data structure to the kernel space side.
> >
> > Hi Gang,
> >
> > Are you sure the patches you applied were the ones from v3 [1]? I
> > think you may have applied a previous version, as that 1522 line
> > ("bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);") does not
> > exist in v3. v3 uses the init flags (" bool use_bufring =3D init_flags =
&
> > FUSE_URING_BUF_RING;").
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joan=
nelkoong@gmail.com/
> > >
> > > Thanks
> > > Gang

