Return-Path: <linux-fsdevel+bounces-72962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C7D0696F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CCD3027A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 00:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D15249EB;
	Fri,  9 Jan 2026 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OScpBk39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCF946A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917250; cv=none; b=Q0PJ95pYG4sBjO7uHBxKk8y4tqi8szXB6S6K2Vv0blBjzcrNUS+OkY1zeTjgZ4yPHwq6w8OniQnCAVUrzF3f2gv4ymFTHY50YjAY76rDdUoeL6dWb840ldOf1pOcecQfwJWecUE1SvUF4oGWSnQ3aVgd4zYaA2qMfLtlMMmr/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917250; c=relaxed/simple;
	bh=At+ejiUVooGrDxCu7H9tDtKCxVkgAhpAMSZ/XVnNRH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Abnz4+EPasDSqzorN+VJz3/pkjAnKYOggAxs7Dno1ygPMx22evswZ19xxrjCXRKojafVYFYwjhgTx66xvPJd6QqQAQtNbzi3dF9Y+4e+vNhINOVgUFvJKyVRya6yLWhLlDIcvqHKx9RQAZHz1ysqwZmfWJeJMrLke2h2jq20H7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OScpBk39; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4fc42188805so39268741cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767917248; x=1768522048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwcHH9y0yBhD7jk8OUEheUU1VNvpy74uQAsTiO0wLZw=;
        b=OScpBk39KtESYlUHQSkkwzMaG+U06j7sJn3qtB565ezxRtcXvYK/SizKE6ft+Z4sui
         Jp/yyJmgR4bJHSgga8wce2VRrSzJjvEjBOm7j/OJ8eoRc8hbo/GtCX/qY6IejlKg4aKT
         q6cHMXvkW8MgGxXBsxxIgNQ9Q1v5z7lt/yLLJQWY9Yc13WkAIkKo3XXsLMPHYnLUo3YH
         ioNL0o75T7/iaYwqc5FUalvK8kdhDSscGkzwZyPWlMvi8yImNmDRclUFc9HQgylLuVG/
         n8Fij3I+gDAvBEQQZQ6eES76+q7YGUsAoCDnQXh98xTL2ljkzTzFqeA8frvbET1oQjJ7
         A0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917248; x=1768522048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwcHH9y0yBhD7jk8OUEheUU1VNvpy74uQAsTiO0wLZw=;
        b=Vbth61RcZ4TWbkjvAdd2J1/fWhPSOLeVSxqY4MLnY4DLRcaENYZiiMAoSgYFJ0OOYC
         HsyYovBwvyNS/UWi3Jr3H43jwpil4RGNf+LXE7Kr4QkktoqPJ+An66cGnMvnaTGjv387
         nJlYh57bxfhJW9yAWOMjZb2qknjLLYmwLvTSoNMytTw12e4YllC50HVYlvnqrQIZixGW
         QFCGAh7cuBxlyaeD4rxlf6SOOmXgIijQ5aUppEJCCgUAAC+bnA2aP8BEuoG6rIv2JT1G
         gDA0hf4+vk1qDb5IpbePTIRIdCJWnyz75dBWVt5AtH9cOlfTrdYMWAWsa8c7LkZkeyx2
         3gLg==
X-Forwarded-Encrypted: i=1; AJvYcCU2gmnRe3WM22GVo3On1NayoBwLztqnPHqYKI5GmDfxiH/hVRlHTQxoMY3EN1/VSemEsB/hk0kDAML9U+Z7@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT/9zx13hgnUrWE+G1KIRWs8GOjhxeJQ795DDiYvJ1pvAawyi
	E0nkAcGOf5aiZkJblKrmLTKqW3HwwLtV0sihKlwIRPZplqLSRKGjmMlLMQVzLp2GbrcZiNOIxW+
	WlALaSkD35ZZ8aGoAtx6XWxlMw0Ycg1OlIC4U
X-Gm-Gg: AY/fxX5lIUJLo9BTl58Ghfz7dRfXeTvDXz9MZW66x3AaP2lbAUgtiTEMI8LcpFEi9N7
	gAeZ7AJ5A+Wriqz17zXadjZ+j4DDSGQ9H6F9/HLXFce4QFOdTzrZV5KaiPEI3cGWC/ijddg/HCB
	BCxOVj9KrmjlipQ3CTPdSO1VVXFKtSzPyEPmbTHowVsjgdyTlBlmJY4hp8hrct+tN7kaQ1TA89N
	RgaQ28bmddUrs5Bn6S2oa2siiauExSgZj2eUtaEtjBXxcemjPP7quaEJplz+ZWrnqBxDA==
X-Google-Smtp-Source: AGHT+IFTYUm8TBceK9AEALjEwyZjb5Ut5LIBeavM//pAxXT9DFybKze1RR/noQoH4SgtuTVmLdr2SsdEJwT6JgLYpKk=
X-Received: by 2002:a05:622a:4ccd:b0:4ee:4a3a:bd00 with SMTP id
 d75a77b69052e-4ffb4a26f43mr112332621cf.71.1767917247775; Thu, 08 Jan 2026
 16:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-25-joannelkoong@gmail.com> <CADUfDZpbNHtT7pvnj8E-A+5_phNnCMieu4RghdVzM93d-6_vxg@mail.gmail.com>
In-Reply-To: <CADUfDZpbNHtT7pvnj8E-A+5_phNnCMieu4RghdVzM93d-6_vxg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 16:07:15 -0800
X-Gm-Features: AQt7F2qjPAgCG3Ln_ZTHShPRrioe3v7M09o9oZXMt6pLnMdHbfEXRGtKcs3LrCY
Message-ID: <CAJnrk1aC=mOexGtv=K2DenWCiBJnAbMfKxQGA-TY32YfxnMbXw@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] fuse: add zero-copy over io-uring
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:15=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Implement zero-copy data transfer for fuse over io-uring, eliminating
> > memory copies between kernel and userspace for read/write operations.
> >
> > This is only allowed on privileged servers and requires the server to
> > preregister the following:
> > a) a sparse buffer corresponding to the queue depth
> > b) a fixed buffer at index queue_depth (the tail of the buffers)
> > c) a kernel-managed buffer ring
> >
> > The sparse buffer is where the client's pages reside. The fixed buffer
> > at the tail is where the headers (struct fuse_uring_req_header) are
> > placed. The kernel-managed buffer ring is where any non-zero-copied arg=
s
> > reside (eg out headers).
> >
> > Benchmarks with bs=3D1M showed approximately the following differences =
in
> > throughput:
> > direct randreads: ~20% increase (~2100 MB/s -> ~2600 MB/s)
> > buffered randreads: ~25% increase (~1900 MB/s -> 2400 MB/s)
> > direct randwrites: no difference (~750 MB/s)
> > buffered randwrites: ~10% increase (950 MB/s -> 1050 MB/s)
> >
> > The benchmark was run using fio on the passthrough_hp server:
> > fio --name=3Dtest_run --ioengine=3Dsync --rw=3Drand{read,write} --bs=3D=
1M
> > --size=3D1G --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c             |   7 +-
> >  fs/fuse/dev_uring.c       | 176 +++++++++++++++++++++++++++++++-------
> >  fs/fuse/dev_uring_i.h     |  11 +++
> >  fs/fuse/fuse_dev_i.h      |   1 +
> >  include/uapi/linux/fuse.h |   6 +-
> >  5 files changed, 164 insertions(+), 37 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index ceb5d6a553c0..0f7f2d8b3951 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1229,8 +1229,11 @@ int fuse_copy_args(struct fuse_copy_state *cs, u=
nsigned numargs,
> >
> >         for (i =3D 0; !err && i < numargs; i++)  {
> >                 struct fuse_arg *arg =3D &args[i];
> > -               if (i =3D=3D numargs - 1 && argpages)
> > -                       err =3D fuse_copy_folios(cs, arg->size, zeroing=
);
> > +               if (i =3D=3D numargs - 1 && argpages) {
> > +                       if (cs->skip_folio_copy)
> > +                               return 0;
> > +                       return fuse_copy_folios(cs, arg->size, zeroing)=
;
> > +               }
> >                 else
> >                         err =3D fuse_copy_one(cs, arg->value, arg->size=
);
> >         }
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index e9905f09c3ad..d13fce2750e1 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -89,8 +89,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_que=
ue *queue)
> >         }
> >  }
> >
> > +static bool can_zero_copy_req(struct fuse_ring_ent *ent, struct fuse_r=
eq *req)
> > +{
> > +       return ent->queue->use_zero_copy &&
> > +               (req->args->in_pages || req->args->out_pages);
> > +}
> > +
> >  static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_=
req *req,
> > -                              int error)
> > +                              int error, unsigned issue_flags)
> >  {
> >         struct fuse_ring_queue *queue =3D ent->queue;
> >         struct fuse_ring *ring =3D queue->ring;
> > @@ -109,6 +115,12 @@ static void fuse_uring_req_end(struct fuse_ring_en=
t *ent, struct fuse_req *req,
> >
> >         spin_unlock(&queue->lock);
> >
> > +       if (ent->zero_copied) {
> > +               WARN_ON_ONCE(io_buffer_unregister(ent->cmd, ent->fixed_=
buf_id,
>
> io_buffer_unregister() can fail if the registered buffer index has
> been unregistered or updated with a userspace buffer since the call to
> io_buffer_register_bvec(). So this WARN_ON_ONCE() can be triggered
> from userspace. I think it would be preferable to ignore the error or
> report it to the fuse server.

Sounds good, this was a remnant from when registered buffers had been
pinned. I'll remove this WARN_ON in v4.

Thanks,
Joanne
>
> Best,
> Caleb
>

