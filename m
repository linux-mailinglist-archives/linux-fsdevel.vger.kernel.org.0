Return-Path: <linux-fsdevel+bounces-73104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28799D0CCAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9453033D52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94D23B62B;
	Sat, 10 Jan 2026 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3VSSTSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EE27472
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011069; cv=none; b=p+bCaes2EeU3LKux8W2IBCgB3IHy/lrgc9JO9NG9oGxxnBbwM5w12VOZijZmkC7S7GLQ9i7+n+GiPnRdhkB4dYKq3r+nXBemxmf5K+J4EJIo1zkdvtJjw3THJKxsu8Zbjz4fFrQjhQn0pDsLOpbJhDyfC6tSmQl/7cEf9fAl9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011069; c=relaxed/simple;
	bh=Bq4pTKjEYuku46KI3wktenAHkqJo3NJX2uGYLxkaIic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlbK/hVAQE34qO65v9Y8Fs5VEt/hSvvCPYdyg5zELY5aDvOhLvGMVCb1FV9AO/GEQu7lg5XEzXQyx3x4xwf5HRVO+Mg8QNFlXmmRGCcsD054TlcumnexvMxpJ0sPHuUf/6lXZjAn2SHzSrD72rN5UJbaEPZZdS270E32LCIG/aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3VSSTSO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so7326134a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011066; x=1768615866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1O4iNL/WdvILBwUD9G7bTMHGlKihYOyzPD6WOzzW1k=;
        b=O3VSSTSOy13Y3A/xLiAOmLim4Q7BprtZMQtdk0piicn9qgFxdigpWfTpESaffX/+e5
         jQkaGXDX12zZuu3dn7Oz0cdBs+dMiuYlwm9vqn6vArXeUpFgVLDAW3BLjubawkDXaV48
         J4gprNUQVhaFx0lbZ3NKoknbIGnvQ+ZVtkhUVD9+nqeU0sNNK3KNBHjTZZusSxCLn1Th
         E9RcCT8rhbli7PmZiR4cXU1oLJmjhyxoV+fV9oeOz5ug+7QRw77+fMFwIfih6Y4VUYbf
         fjnXQpVu1VunDsnJuOUfwyKvqz1ImodBGHZ22VAbDxpE53twlFKK2+W+/UhX/n2ouw7V
         QkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011066; x=1768615866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1O4iNL/WdvILBwUD9G7bTMHGlKihYOyzPD6WOzzW1k=;
        b=cH9ZQca88RWKlzvDEpSkUnupZOmc/P0NFMGpF0bJKqUIM5eWz1z7DoQf8CNvKNBKm1
         O0yuE8JGQ4CihRLZfwQBO/4kWk8MhlzZ4+3/xXVNubeXxkwYkF617YAbqw3OpdJvoVWT
         C1+igxyo1EtQNVurCoDDhR9ba6Dra3xSFvwHn5k9JKQwzqvbhRRkgKJXoXs96uByQWV5
         Sz0EjAXazdd3B8U/wFeimueUGvQ3HwNuiZByQqpvRiJsRcRvYhRkqJoCXIQeeBSmK0jp
         uqvrhhU8aD3SXfXmoP8BKy8rD54PwC4MUE74wgqzJ/wew+mSRyqSPOM7Z4VyNZ5AnR+d
         br+A==
X-Gm-Message-State: AOJu0YzsqmO6IsUNd+bHIg/Q/u9/Pp9tsAX2GI/x0AwCjrmkgqnS27Bk
	1AxGq0EJIpLDqSM4BoYpTGAlMHY3/v60ZgEQxuDbT1CfrJkexZ7KbhmNAfDnZThWsn9fd+F8DhK
	0URCc7YuQXz3WlAcwPDDIQB+kVjPx5oZ1DcK2yl0=
X-Gm-Gg: AY/fxX74NHe73Ws42n9+eojLU4gmkk32abVTUOc1uy9PRzbwj3bp2Axkoxk35aPlO8D
	ndUPzW4cwoaxTfBMRNCOEZaGTmJx226N0SMQl1R7O5OhXo48Qj83XEtqbYiPIwQLVpT0tH4KD5S
	Vx84tbPMg90JDTuvOf+gszJQAdpX/zwix4eAY7j8x8xbZTyhJVG9S+e5fff79vdLk6l5ELU9nBc
	ZYBz0R02/NJjz/NHbnkbtkW98So9/IDLc4UpwGTEMm69LJexgQCFQKwJf3O+6oMUrjpris=
X-Google-Smtp-Source: AGHT+IFi5uqk2v3jSihg3QJQwVZ8JONGf1c8T/PIkxdfEPLEQMvKADu/rqEIvmmevlELfnLk9opWMSMJnMPhIQmyOvg=
X-Received: by 2002:a17:906:6a06:b0:b83:1400:482c with SMTP id
 a640c23a62f3a-b84453fecbemr1204265066b.64.1768011065654; Fri, 09 Jan 2026
 18:11:05 -0800 (PST)
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
 <CAJnrk1ZA2eAnV8tJMnCpaBphRXh3A+XtAYk_gRZ1ohKjaRhPyA@mail.gmail.com>
 <CAGmFzSdcPH1Q3x342YWgA-08578YSLB0iEY6KoAyapmEULd=VA@mail.gmail.com>
 <CAGmFzSd9gMCDYQR2u2NkrKArRA1rQKRWca93qwZ5ykjKSxc0Ew@mail.gmail.com> <CAJnrk1ar28itDLueXtXxS9kjKNc=frBhpcsRXK8+M-ahBRD2EQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ar28itDLueXtXxS9kjKNc=frBhpcsRXK8+M-ahBRD2EQ@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Sat, 10 Jan 2026 10:10:54 +0800
X-Gm-Features: AZwV_QhXRpV383A40NgO_2yoQFF3QI5aQacnG9QR-wVT-NrfX7JMpeXfN9wM0vE
Message-ID: <CAGmFzSdZ-ezwU5Wq9QUi0+hMBc8hhC_ucNc+TO6EQcovjqHYpw@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

With your command, now it works on my VM.


Thanks
Gang

Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=85=AD 01:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 9, 2026 at 1:02=E2=80=AFAM Gang He <dchg2000@gmail.com> wrote=
:
> >
> > Hi Joanne,
> >
> > Sorry for more information.
> > it looks the root cause is "io-uring queue depth must be specified"
> > In the past, I usually use the default value for this parameters.
> >
> > Thanks
> > Gang
>
> Hi Gang,
>
> Just to clarify, you are able to get it working now?
>
> In case it's helpful, this is the command I'm using to run the server on =
my VM:
>  sudo ~/libfuse/build/example/passthrough_hp ~/src ~/mounts/tmp
> --nopassthrough -o io_uring  -o io_uring_bufring -o io_uring_zero_copy
> -o io_uring_q_depth=3D8
>
> Please let me know if you're still running into any issues.
>
> Thanks,
> Joanne
>
> >
> > Gang He <dchg2000@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 15:34=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Joanne,
> > >
> > > I applied your V3 25
> > > patches(https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-=
1-joannelkoong@gmail.com/T/#t)
> > > in the kernel v6.19-rc3. I removed the existing liburing2 package
> > > (dpkg --remove  --force-depends liburing2), and installed your
> > > liburing2 (make install).
> > > Then, built your libfuse code and example.
> > > there was still a hanged problem when ls the related fuse mount direc=
tory.
> > > the ls command back traces are as follows,
> > > [<0>] fuse_get_req+0x1fb/0x2e0
> > > [<0>] __fuse_simple_request+0x41/0x320
> > > [<0>] fuse_do_getattr+0x101/0x240
> > > [<0>] fuse_update_get_attr+0x19a/0x1c0
> > > [<0>] fuse_getattr+0x96/0xe0
> > > [<0>] vfs_getattr_nosec+0xc4/0x110
> > > [<0>] vfs_statx+0xa7/0x160
> > > [<0>] do_statx+0x63/0xb0
> > > [<0>] __x64_sys_statx+0xad/0x100
> > > [<0>] x64_sys_call+0x10c9/0x2360
> > > [<0>] do_syscall_64+0x81/0x500
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > The hang problems are related to your new parameters(-o
> > > io_uring_bufring -o io_uring_zero_copy).
> > > If without these two parameters, the example binary files do work.
> > > But there was not any kernel message printed.
> > >
> > > Thanks
> > > Gang
> > >
> > > Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=89 05:12=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Mon, Jan 5, 2026 at 6:14=E2=80=AFPM Gang He <dchg2000@gmail.com>=
 wrote:
> > > > >
> > > > > Hi Joanne,
> > > > >
> > > > > Yes, I enabled /sys/module/fuse/parameters/enable_uring before do=
ing
> > > > > the testing.
> > > > > I verified my libfuse include/fuse_kernel.h, the code looks like,
> > > > > struct fuse_uring_cmd_req {
> > > > >     uint64_t flags;
> > > > >
> > > > >     /* entry identifier for commits */
> > > > >     uint64_t commit_id;
> > > > >
> > > > >     /* queue the command is for (queue index) */
> > > > >     uint16_t qid;
> > > > >
> > > > >     union {
> > > > >         struct {
> > > > >             uint16_t flags;
> > > > >             uint16_t queue_depth;
> > > > >         } init;
> > > > >     };
> > > > >
> > > > >     uint8_t padding[2];
> > > > > };
> > > > >
> > > > > But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
> > > > > detailed code lines are as follows,
> > > > > 1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
> > > > > 1519                    unsigned int issue_flags, struct fuse_con=
n *fc)
> > > > > 1520 {
> > > > > 1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sq=
e_cmd(cmd->sqe);
> > > > > 1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring=
);    <<=3D=3D here
> > > > > 1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
> > > > > 1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> > > > > 1525     struct fuse_ring_queue *queue;
> > > > >
> > > > > The problem looks like the user space side does not pass the righ=
t
> > > > > data structure to the kernel space side.
> > > >
> > > > Hi Gang,
> > > >
> > > > Are you sure the patches you applied were the ones from v3 [1]? I
> > > > think you may have applied a previous version, as that 1522 line
> > > > ("bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);") does=
 not
> > > > exist in v3. v3 uses the init flags (" bool use_bufring =3D init_fl=
ags &
> > > > FUSE_URING_BUF_RING;").
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-=
joannelkoong@gmail.com/
> > > > >
> > > > > Thanks
> > > > > Gang

