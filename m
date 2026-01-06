Return-Path: <linux-fsdevel+bounces-72545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BBCFB0F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2DE1303F9A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82F2C1595;
	Tue,  6 Jan 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6/Asie4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD3280CE5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767733974; cv=none; b=HBYejZHpqkN0yOao0hy0LkSIaVt4bHQKZ3GZ9zygaXadCWFc7RLviFibpRX0LFAMhVDN7NOv8T96tTXU3D1DyplnPDOBzaX6+UrQ4XFj+tH9bl933JT/N3ZkHLsrMEvMnFUX0Hr6DVZnQ+jT7k66AvNrccmKumx/MVbqhYy/H5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767733974; c=relaxed/simple;
	bh=cLEs9u8d/lxsdck+P8ds7tOyPHyBqrvJd2Ug0jJPwXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7ha9cLJAbogNHaRGMne0KDnonHQmyJmkCzb5H20ky/Q2i1/TltIuIYOE7+0eX10ZQxbnEfEK+T2DD6mxip9Luqii3P6oH+8PA4IpJWPsnOYoJGx2m303fd2zDWqmVTYU+tR3MmqnL8JRgEaUmhjI3CM9FlnxWAICiH7YoaYJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6/Asie4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c0f13e4424so133206285a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 13:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767733972; x=1768338772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C64DcBKzl/vxA+vX0OfRCvhlEq+0ZM6zTRETc4awXWQ=;
        b=d6/Asie4co/uo7eLsk0/4Nsz/MqYn6eQ4QY/H2F8YKA9oAkkfkQFp8eqRFShYOJK6x
         IVoiAlOqYgzyrntRHfy6LfzXhUKPPF5bDMFyfWJQKVoXBB0aMO15hrS1/JHMUVSzB1nX
         6NDw6dIciRj7S6Bfluf7IFaOB0B8epqo2fI7VSfpfewpqOYGGtb3UuL4XZ3UKhFB2mTr
         D8CQ0uKhGYSdJ3/3dzTpRqnJeNnvl/DPVBFJzHqnxSaXtYKjkOO5q7uD89UgQr/bLK++
         Ipmwk8sz1iI1At23FKHpHkhsqAQFcOBuDkQfnInNuQsu9FJ01fG2fawj7HVFnR4v87go
         EH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767733972; x=1768338772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C64DcBKzl/vxA+vX0OfRCvhlEq+0ZM6zTRETc4awXWQ=;
        b=HvKTbn/5lHzxjQUndEVX5UBOkxV0Y2Zh9DVRcUxPu9VpEH1pFtTtb0/ziAaj8pbl8g
         lcdL2J2UOXSt13wNSDGxDYmdJserJ/nfV83M3QELcwdI38nhaNEgiI8FmhoeJfO1GLcl
         a5wKffOnADUUSoSiyK+Nmcx2r4T3Mn4BeMC/m7iXdnybE17UNSBvKb16PxRQVNRwmmo0
         nfDLu5sdYjc0BFddP2EW1H93KlTw/XsCwoYHPMUI/7COnsk0HxlNhJGdWPmOFo2vJysm
         H0H7hLkAzLjlfnbZbuzO510jB5vGKYv20MNxCrpf2MpvTr11lv8Cy6KUkGzQP0InnVwQ
         w14Q==
X-Gm-Message-State: AOJu0YyDHC2GyqnzPj7UjwM2gvu9+uGY+9At/7VDJln8WVfgUkrBn+hB
	uPr382PsbMye+QmLmQEyrfR0WBKvVK7wozb+2F5E6cBlFooJALBJY644EkN/d2tE1hgm2iSaB9F
	PgTXG3OOAeR+z2nEwyBJwLvH3b6TAgzo=
X-Gm-Gg: AY/fxX4xthgj9wyZ/ANtKZqL0/AwYHOQ/usBROutGQcqYytYZwRo8knF3vZ2b9FeV8h
	suhtLw0b1EAKP07DtXPzzWJcfRq/q0IBbkWH995joBnPrcfJE10uTKGtGDi1d5PuOaqkbgqMIs5
	cPG01slVWALFpT6+IKYUek/xOdbhOsxKZWIBRhtOsWBGGTOlSHqD/kH182Y2t9apSWxADPtq/Yn
	AjA7RARcY5oTzDo9z4oFnK8nFND9+KVRQLtU5w2I/a0P0B5vOeTwrCqGyh2Qy37VC+3F8Xee7zG
	wbtHhpPAjCI=
X-Google-Smtp-Source: AGHT+IGA0meR5omsKK96Bp0k+alq1yXWnQtMsN8iGUHIZalQuAPQf5SfcVtjw4L+qPlz9qhhDVeonen+vcR42SUbsJU=
X-Received: by 2002:a05:622a:4d8d:b0:4ee:1b0e:861d with SMTP id
 d75a77b69052e-4ffb4923ae9mr5575221cf.26.1767733971690; Tue, 06 Jan 2026
 13:12:51 -0800 (PST)
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
 <CAJnrk1Z_1LO0uS=J5uca2tXUp_4Zc+O5D6XN-hdGEJFxTKyvyw@mail.gmail.com> <CAGmFzSci7dC5Fq77umzrCQVaKqDPiJ4NgMGTycjvMCnPXv6-zQ@mail.gmail.com>
In-Reply-To: <CAGmFzSci7dC5Fq77umzrCQVaKqDPiJ4NgMGTycjvMCnPXv6-zQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Jan 2026 13:12:40 -0800
X-Gm-Features: AQt7F2oFToqTG5bWtdTMLiIYU28Vx-C_qpyX4VejiCqRuvmoVKp5kiDommh-qzc
Message-ID: <CAJnrk1ZA2eAnV8tJMnCpaBphRXh3A+XtAYk_gRZ1ohKjaRhPyA@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Gang He <dchg2000@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:14=E2=80=AFPM Gang He <dchg2000@gmail.com> wrote:
>
> Hi Joanne,
>
> Yes, I enabled /sys/module/fuse/parameters/enable_uring before doing
> the testing.
> I verified my libfuse include/fuse_kernel.h, the code looks like,
> struct fuse_uring_cmd_req {
>     uint64_t flags;
>
>     /* entry identifier for commits */
>     uint64_t commit_id;
>
>     /* queue the command is for (queue index) */
>     uint16_t qid;
>
>     union {
>         struct {
>             uint16_t flags;
>             uint16_t queue_depth;
>         } init;
>     };
>
>     uint8_t padding[2];
> };
>
> But, for my kernel source code fs/fuse/dev_uring.c:1522:21, the
> detailed code lines are as follows,
> 1518 static int fuse_uring_register(struct io_uring_cmd *cmd,
> 1519                    unsigned int issue_flags, struct fuse_conn *fc)
> 1520 {
> 1521     const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_cmd(cm=
d->sqe);
> 1522     bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);    <<=
=3D=3D here
> 1523     bool zero_copy =3D READ_ONCE(cmd_req->init.zero_copy);
> 1524     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> 1525     struct fuse_ring_queue *queue;
>
> The problem looks like the user space side does not pass the right
> data structure to the kernel space side.

Hi Gang,

Are you sure the patches you applied were the ones from v3 [1]? I
think you may have applied a previous version, as that 1522 line
("bool use_bufring =3D READ_ONCE(cmd_req->init.use_bufring);") does not
exist in v3. v3 uses the init flags (" bool use_bufring =3D init_flags &
FUSE_URING_BUF_RING;").

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joannelk=
oong@gmail.com/
>
> Thanks
> Gang

