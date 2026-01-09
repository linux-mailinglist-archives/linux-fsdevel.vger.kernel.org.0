Return-Path: <linux-fsdevel+bounces-73012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D96D07990
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62843010CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 07:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BCD2ED164;
	Fri,  9 Jan 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKLdcX5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4622ECD2A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944076; cv=none; b=U//t9R+Rq5UQSLSjPThz7zaYTzWll9RajROa5OZyMmATCXmBNylQ6V8XMXMymc7yg8xRAsuysFag3fajMiZ8S6ae/3fuF2u06NrphJNkKtkVzZfOhyucF7xPGYbOnGQr9Eslsyh9KuqrfYl1lx8lMJ5zjf/hr2ZJTm8HNFfduyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944076; c=relaxed/simple;
	bh=Z9J23ivZXahhWLup0V2TxdMKDJ+z5ulO6wfRlIR2uXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwMHvDBd1IfKDuaifZFyrQERsufyoKtPUnea0SOmYaLGAXfG8yNYf6oMS+GxH9VthUWNmxe17qXC7l5firk46JLXqRTsyAT9a3VAmLG+e76HAfFY51QJfqWs0LVm5LZgoNohahcoo1ePSw58XLdbXXUQKzg56v2iM1oKP8bHvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKLdcX5/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso6002686a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 23:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767944073; x=1768548873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sgokN+5HlF2/9BFBU/rtMDJRTISzbAaykTVJVt4Ufo=;
        b=WKLdcX5/wg1jUDW52PJ9wPGNLgWq/Xu0fayaSkG1Lbeib8ANkNe8L4FjiCRNmQZy2W
         Pbqp7H5NYMfbEwWR5PFq/dQ3VS0zJdfKBAMJSPzrIyAzV8890tm0MySqGeDSSy0Hv2fv
         jpu+IvVjP6M9ZQX2fSM3P1MSS1hWhRSWeVmTL7GnUiScoxJVCnxymi2UNbTu4nj5fP9M
         JFOzPE1UCIlnZ12SCak5GwZg4glQLZeaFWMQckX4kEn8aFwPpSLspk7+qTNZpiysgn9M
         h5kSq4LKrqOWaiDvXtEPkOdVoNniLaaOBHO1ltdpXBRl3mmLZrANQvVDpOo3oRph90G8
         4P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767944073; x=1768548873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2sgokN+5HlF2/9BFBU/rtMDJRTISzbAaykTVJVt4Ufo=;
        b=gIYBFWGnX5ysnMsr9Lu7GJGLdc9ooyoYMcFjBMlZWDPNe59rngGH9WU4rJM7krPySo
         gQXV3twnN04d3kCIUyEQwONnkzymFjZapZK4w8ieFHJN84pSVTqDyeTx+Ng09Rnnuu50
         /p8c/Cz/mrBtNi+VIIx2FgF5HnTZ0HmrwcF6BKJ+84BiGNKzQKy+VH68KB62+SD/ursZ
         RdwDy9ZLnxYcN9MHOsKohBgJN+Amh2PpM+izzZwRkbax1TqGAO5e9cHpBKrWE5UqeJYR
         rkkqQBOcx5kXqGHYCAAJ661bFnf+HOFC2LQOMQktZP3OORdmLxmjhxc/cz0Vh5lUg3R5
         GImg==
X-Gm-Message-State: AOJu0YxQmgHgrPJrXxtBe0VhjPNID1BPhx6zQTip9ziOJwyibfJeh3SJ
	+tw90r3xQH31gAICl1end7kb3apQ5EcGC+pVYOSgHD42l7JQ7hT0jbqNy8Ae+P543J5RJE2m8EK
	4GEzYa5loHn5BYcwYmHAntO+GD5mW0oc=
X-Gm-Gg: AY/fxX4GFKuPBnMCwI4ZYvELiB4teGvHwRsuh/NVi3PrfR8Sap5uJHZ/pBvayOJlZvr
	kchqJCMpd6Td0KTt0Qgh66RX1OCXe6eGpKQqVGOXoOUzEfsDmjdwXp3VYVwQG09NkFFOGyGy7JM
	OBgJlNZg8tq46bGSEJok0i0GP6ZF1LQBNyIZoMCmfnudG6YT9TsOhUT1mGbJu8QfJAnh+30oVEa
	QD2adeAMaoDhf4k9VbJ+KawlIKpfDYZFdPjjXbb8GXmSvkXlQ1GkqkrZT2pLAjwutiuDkeiAg==
X-Google-Smtp-Source: AGHT+IGm0pehBU9WUo3/DHrokFLlwZzifUkFF7XpoBvhIiVos5IV5yyyfmUq9NAtdQQZzIiuWLk1tbv0L7Xbo7sDGZE=
X-Received: by 2002:a17:907:2d9f:b0:b4c:137d:89bb with SMTP id
 a640c23a62f3a-b8444d4eb3fmr837729866b.29.1767944072991; Thu, 08 Jan 2026
 23:34:32 -0800 (PST)
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
 <CAGmFzSci7dC5Fq77umzrCQVaKqDPiJ4NgMGTycjvMCnPXv6-zQ@mail.gmail.com> <CAJnrk1ZA2eAnV8tJMnCpaBphRXh3A+XtAYk_gRZ1ohKjaRhPyA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZA2eAnV8tJMnCpaBphRXh3A+XtAYk_gRZ1ohKjaRhPyA@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Fri, 9 Jan 2026 15:34:20 +0800
X-Gm-Features: AZwV_QjWJ18X49YhmamrnQmf_zjumTvdNG2SJgVXkr-qLeAcnY8kUvpEqJ-4Dhg
Message-ID: <CAGmFzSdcPH1Q3x342YWgA-08578YSLB0iEY6KoAyapmEULd=VA@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

I applied your V3 25
patches(https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joan=
nelkoong@gmail.com/T/#t)
in the kernel v6.19-rc3. I removed the existing liburing2 package
(dpkg --remove  --force-depends liburing2), and installed your
liburing2 (make install).
Then, built your libfuse code and example.
there was still a hanged problem when ls the related fuse mount directory.
the ls command back traces are as follows,
[<0>] fuse_get_req+0x1fb/0x2e0
[<0>] __fuse_simple_request+0x41/0x320
[<0>] fuse_do_getattr+0x101/0x240
[<0>] fuse_update_get_attr+0x19a/0x1c0
[<0>] fuse_getattr+0x96/0xe0
[<0>] vfs_getattr_nosec+0xc4/0x110
[<0>] vfs_statx+0xa7/0x160
[<0>] do_statx+0x63/0xb0
[<0>] __x64_sys_statx+0xad/0x100
[<0>] x64_sys_call+0x10c9/0x2360
[<0>] do_syscall_64+0x81/0x500
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

The hang problems are related to your new parameters(-o
io_uring_bufring -o io_uring_zero_copy).
If without these two parameters, the example binary files do work.
But there was not any kernel message printed.

Thanks
Gang

Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 05:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 5, 2026 at 6:14=E2=80=AFPM Gang He <dchg2000@gmail.com> wrote=
:
> >
> > Hi Joanne,
> >
> > Yes, I enabled /sys/module/fuse/parameters/enable_uring before doing
> > the testing.
> > I verified my libfuse include/fuse_kernel.h, the code looks like,
> > struct fuse_uring_cmd_req {
> >     uint64_t flags;
> >
> >     /* entry identifier for commits */
> >     uint64_t commit_id;
> >
> >     /* queue the command is for (queue index) */
> >     uint16_t qid;
> >
> >     union {
> >         struct {
> >             uint16_t flags;
> >             uint16_t queue_depth;
> >         } init;
> >     };
> >
> >     uint8_t padding[2];
> > };
> >
> > But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
> > detailed code lines are as follows,
> > 1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
> > 1519                    unsigned int issue_flags, struct fuse_conn *fc)
> > 1520 {
> > 1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_cmd(=
cmd->sqe);
> > 1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);    =
<<=3D=3D here
> > 1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
> > 1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> > 1525     struct fuse_ring_queue *queue;
> >
> > The problem looks like the user space side does not pass the right
> > data structure to the kernel space side.
>
> Hi Gang,
>
> Are you sure the patches you applied were the ones from v3 [1]? I
> think you may have applied a previous version, as that 1522 line
> ("bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);") does not
> exist in v3. v3 uses the init flags (" bool use_bufring =3D init_flags &
> FUSE_URING_BUF_RING;").
>
> Thanks,
> Joanne
>
> [1] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joanne=
lkoong@gmail.com/
> >
> > Thanks
> > Gang

