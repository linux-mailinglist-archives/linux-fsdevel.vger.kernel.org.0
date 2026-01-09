Return-Path: <linux-fsdevel+bounces-73076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84CD0BC48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE31F30D3936
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722626ED3D;
	Fri,  9 Jan 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmMiyex7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F378F2B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981249; cv=none; b=lnxIzuI4quPnguWxPhzEE7T6m0p9CllqTKpoKsscUd9Y14lL0JYdYP64qDzhGkC1nYOMdrhqg2JRcdi1/2HusRUR2l9jKH1mPcGyes+hoKpoY8dGPd5jhC+C2cDfnbRlUTWfVRRPttSCCRGa17Aw0lzn8WRWp/hxqc4ZzvtfkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981249; c=relaxed/simple;
	bh=oE2yuL+VdpeXfKbPjSVLMZAtd0izhUO7G8T8jGkmodA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbY8ojJyMe/42BfzdWkFwQwdV7fuIYqd7wgvfCZr8xMr9OLx0XJw1PHx8wpncpUmPXLdTn3eDb20LOmLvO3gNqeOorsX3Zj/Ri6pqxJ4OewKBCPkQZpDw8Qv42YTGNDcD8mJWPyN4ySE5fK1Oq2xfb3DWXpBQOXXHPeqeL2u8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmMiyex7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f822b2df7aso59469531cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767981246; x=1768586046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XAX5LQe5CbKlnamQpcMWVzZizJhQQOWhrLd8b9KWMU=;
        b=mmMiyex7s0ohdy9RtnZnwsMZS4pm4vJhGnKnRrLEt0bOWrTcTvqj2ipJY8q2jtP4SO
         E47Xp9CS2y8JIzuckwNEEbNXoCWi2V7vdxxuDnrTEI3Ou+Hr8C1Y4mvlRQRNJZQoCGf7
         WyDFpdLoDqDbKNIpdAZ937OgwTPTQHSgXOTlfHpohAtsGRBoqsFA0HYioS2Bzp/kb5GX
         41Q7Hhx9OaLo1+uo52mPs+LVLfbZ33nyoisB1U7MTr6I3C9gnRYRNCA4JBjTrBcGDwSy
         aXleB1yREnz8VITvvBQrSOYZAr4md/NgGXvpqdQvEDWEwKl3vknnaVjYHpbUw9aHB0Ht
         PomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767981246; x=1768586046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XAX5LQe5CbKlnamQpcMWVzZizJhQQOWhrLd8b9KWMU=;
        b=mw9knS9CfFxCPNYZb88mIZjzsodPIANGvX2xl/0jsj1gqEAmgD9y47I3sRGfe5c+Qo
         zQuSojMbWMZ5vYkcumKfGogU6HxqoNNokkgG8goBY5T5e5WtVmssN2gUHTFHL0M8/kSz
         pX/5dybCvENfBGaF0uphUR0+Ew1grlMZIn8s81AtW9pTaOUK3ptMfUnU7SFiBs1wMBBW
         FbUqCaTni9dQVpoP/uGxUIO3vc9pWMYdyYcL47uMUADLxmlzcGMX5jH+yVwXwJb2O4St
         sLDmEAoR1QwADelQBlHrBpc1NRoNhfSmJqLBprRgPaKiW2CGyXX9oVAX3W+tr2LBfNjK
         C7cA==
X-Gm-Message-State: AOJu0YxwxKJ36UVg62iqjOdGg1Mccm+FpelIWAnjVJnytuN8PZH+fqw5
	Y0sGfN3mcSorZG1ma1dsItX1O1gU9pAPk3nNrYqjNEEbBR0H4l+84wLOpjkxCeeX0Egscxs9bEN
	r212QUe779ky7j/TQNU9dX2kLaEP8Do0=
X-Gm-Gg: AY/fxX4ffoZI24rNlyyBxpMHH7QsP9NrnSbZC1SPrfdwYB5uGtrEuRrWL5CyUifSS6k
	rLHxzT1sX4Ho73JF7ObF8+CgUAsQHoCSeEIOKjDZuREmTD55FHR6RidRvhruI47Kw5qn+tuNXiI
	CPJe8BlVyNRcyHsYPk3x9Zn0BAuVQ6urHwAh0FfchQ8X9rHbZDvzjEJMc91TV/lykRxVGhXDLVI
	oxnC0pWccW25hLCR6OaopG3wnGPzgBIvfBkt+9+ZKXxpnXO91n8AG4/zEzcsu73QX7Z6w==
X-Google-Smtp-Source: AGHT+IHIVrE8kOB+3oqB+/bjGMbjWqvgMsUy7i9a06nhGRC+hZXEYboxtzuZVb7Icb5FpDzIIL5wJVr2ZdC4J+FsRho=
X-Received: by 2002:a05:622a:1342:b0:4f4:d29a:40e7 with SMTP id
 d75a77b69052e-4ffb4a622e3mr163113011cf.74.1767981246386; Fri, 09 Jan 2026
 09:54:06 -0800 (PST)
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
 <CAGmFzSdcPH1Q3x342YWgA-08578YSLB0iEY6KoAyapmEULd=VA@mail.gmail.com> <CAGmFzSd9gMCDYQR2u2NkrKArRA1rQKRWca93qwZ5ykjKSxc0Ew@mail.gmail.com>
In-Reply-To: <CAGmFzSd9gMCDYQR2u2NkrKArRA1rQKRWca93qwZ5ykjKSxc0Ew@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Jan 2026 09:53:54 -0800
X-Gm-Features: AQt7F2pkh896WlBxTcY0zLbuLJIkg-kq5MvchoW_iylagBN_9ARtLnAyXT5ZSsM
Message-ID: <CAJnrk1ar28itDLueXtXxS9kjKNc=frBhpcsRXK8+M-ahBRD2EQ@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Gang He <dchg2000@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:02=E2=80=AFAM Gang He <dchg2000@gmail.com> wrote:
>
> Hi Joanne,
>
> Sorry for more information.
> it looks the root cause is "io-uring queue depth must be specified"
> In the past, I usually use the default value for this parameters.
>
> Thanks
> Gang

Hi Gang,

Just to clarify, you are able to get it working now?

In case it's helpful, this is the command I'm using to run the server on my=
 VM:
 sudo ~/libfuse/build/example/passthrough_hp ~/src ~/mounts/tmp
--nopassthrough -o io_uring  -o io_uring_bufring -o io_uring_zero_copy
-o io_uring_q_depth=3D8

Please let me know if you're still running into any issues.

Thanks,
Joanne

>
> Gang He <dchg2000@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 15:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Joanne,
> >
> > I applied your V3 25
> > patches(https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-=
joannelkoong@gmail.com/T/#t)
> > in the kernel v6.19-rc3. I removed the existing liburing2 package
> > (dpkg --remove  --force-depends liburing2), and installed your
> > liburing2 (make install).
> > Then, built your libfuse code and example.
> > there was still a hanged problem when ls the related fuse mount directo=
ry.
> > the ls command back traces are as follows,
> > [<0>] fuse_get_req+0x1fb/0x2e0
> > [<0>] __fuse_simple_request+0x41/0x320
> > [<0>] fuse_do_getattr+0x101/0x240
> > [<0>] fuse_update_get_attr+0x19a/0x1c0
> > [<0>] fuse_getattr+0x96/0xe0
> > [<0>] vfs_getattr_nosec+0xc4/0x110
> > [<0>] vfs_statx+0xa7/0x160
> > [<0>] do_statx+0x63/0xb0
> > [<0>] __x64_sys_statx+0xad/0x100
> > [<0>] x64_sys_call+0x10c9/0x2360
> > [<0>] do_syscall_64+0x81/0x500
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > The hang problems are related to your new parameters(-o
> > io_uring_bufring -o io_uring_zero_copy).
> > If without these two parameters, the example binary files do work.
> > But there was not any kernel message printed.
> >
> > Thanks
> > Gang
> >
> > Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=B8=89 05:12=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Jan 5, 2026 at 6:14=E2=80=AFPM Gang He <dchg2000@gmail.com> w=
rote:
> > > >
> > > > Hi Joanne,
> > > >
> > > > Yes, I enabled /sys/module/fuse/parameters/enable_uring before doin=
g
> > > > the testing.
> > > > I verified my libfuse include/fuse_kernel.h, the code looks like,
> > > > struct fuse_uring_cmd_req {
> > > >     uint64_t flags;
> > > >
> > > >     /* entry identifier for commits */
> > > >     uint64_t commit_id;
> > > >
> > > >     /* queue the command is for (queue index) */
> > > >     uint16_t qid;
> > > >
> > > >     union {
> > > >         struct {
> > > >             uint16_t flags;
> > > >             uint16_t queue_depth;
> > > >         } init;
> > > >     };
> > > >
> > > >     uint8_t padding[2];
> > > > };
> > > >
> > > > But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
> > > > detailed code lines are as follows,
> > > > 1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
> > > > 1519                    unsigned int issue_flags, struct fuse_conn =
*fc)
> > > > 1520 {
> > > > 1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_=
cmd(cmd->sqe);
> > > > 1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);=
    <<=3D=3D here
> > > > 1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
> > > > 1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> > > > 1525     struct fuse_ring_queue *queue;
> > > >
> > > > The problem looks like the user space side does not pass the right
> > > > data structure to the kernel space side.
> > >
> > > Hi Gang,
> > >
> > > Are you sure the patches you applied were the ones from v3 [1]? I
> > > think you may have applied a previous version, as that 1522 line
> > > ("bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);") does n=
ot
> > > exist in v3. v3 uses the init flags (" bool use_bufring =3D init_flag=
s &
> > > FUSE_URING_BUF_RING;").
> > >
> > > Thanks,
> > > Joanne
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-jo=
annelkoong@gmail.com/
> > > >
> > > > Thanks
> > > > Gang

