Return-Path: <linux-fsdevel+bounces-70700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC8CA4FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A0531731F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B481198E91;
	Thu,  4 Dec 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJY9BPV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FA86337
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873709; cv=none; b=DWvFFHiXKmfttzvrbzIDCW9ptz9u/F08U3x/BiqXEr1/mMV6EN842AMPqfssi2U5dq0uwCHazroDw4S4oOB759SaoeQGXXAFxCQifY17RvF7gJaaLoP8hXLoAiDN2isUQppLcBQta9ocFtW1BZcddI1hKCyDfhgroe5MBiaaysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873709; c=relaxed/simple;
	bh=oMxtseEHZHa9YPb72NIgSljc1Ghrok0Q/j2CLZ8SOwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reNUVb4siAmkPdmKRvzn5R7xiILWC0WaFkaBFXLd0TSSNRGWCE6nRbj3+7RpHEN6WYQeFYwSyY5XrSJFh7ZoE99H4/sXKbqj4N0mBHUZQbB60rgWIaWjL0CI5KAgzGFC3mVXp/NmJ4YaTtMVPonGTNQUF1D0my3mbl3YlHtgAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJY9BPV4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed9c19248bso10721611cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764873707; x=1765478507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHUuZbyhOsjTm6zi6UjvRRrq0uw47xR4EWsXhEDK7YA=;
        b=eJY9BPV4MMQ4u73bVzr3ZG7umpc3SE9dOxfAEkHUoA4BTQ/lJOyywbra8fdZtABvbm
         EPcBRPftz/MoKPwXLc8l+1Xahy9CZo/50NqVCKCS+X59vVEtySxxZ4K/CSmhVp+LwRiQ
         3q+lCLw5NG6r6GmAhBGI/0s+vi4l0WkYGTNhESE46svvCHW2Z5uh3eoCaLqgEdnDhhC9
         20Yi5IYPRpnq10azRdjcVuf7RMNeU6yDnOkEPP1am90HyHEcUyUtM/42ta492Jt20iLA
         s7hbc16zmAJHRnNPbFLltzXhQE66CC1fkHQ08ZoZY04VqPMMxoGkLKD1vp4tIndO6rN6
         IL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873707; x=1765478507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHUuZbyhOsjTm6zi6UjvRRrq0uw47xR4EWsXhEDK7YA=;
        b=jHAfz2nOP9iO0CLqwTE/5A6TGR0jb2BLa1CQKaqs0UgXEfPeFsHI8lGIhS8WzjEaFT
         E5EldV0hDyAEpUrUOohpYrNvvtdC3+IkKw0pOEJs1imJlfcMwnFf8/sll9068vzUyjEh
         pRdgHDhJh142I96DjOmZiFhftxaUfGs2LCeeNHM//HgQAPqzv2BcPY0kvV0Hyjx2k3BF
         f+wlsMGuaq7P/V33f2rNmonOPNOUTrxtcZAOoAwgGrfmu0PWz8hfKvBkfotx76lCrvtN
         1NyTu7V02gc+HS5YeTuW4TQ9faHC1M5koENBXa8UTe1P7SK5xuCJOi2z2lEIoOYi0+4A
         X8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVppxQtRg+jEALnrWMqI2w1ulknP7lM/yxvR3pF3i07h/jza13uPMqHAcCi5QoW9xcRmBWw+b9MRb2BiRnm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ka1HsFXhf86NRqcmQrp9n3H5IKRPL9l+O9GO9P81AJgUhJJX
	/BF/DEsnE087OAKh01jAtfQXhpAiMjmmIbVQQwK11r5Z7wedwWAh3mvDis0q96wS9a++AfoeApI
	hon0Z+6wTWqxHsLvebshbt4D5BftYK18=
X-Gm-Gg: ASbGncvZDo67aFPFAsKhScg1M9baia/JJPiklblZzwBs5fCZNbGDgJH4Ug6knBrk/Rf
	9XtAeE4etXJD6s7t7weiEkz0aNb2X3PILkP/Ni8JYAS2VHs+gAIS+EY/+Ncjs4E4GvgmAfHiP9B
	kCRCpUF+iuPe24VzdCVeCCSoL/rEpdEV19hmMs+juH4wB6ugrgHEhGpvhmW8wTLjyJxXruT35Tj
	LcsguEKuvVdqxd7KTCiVBDy8EeOD9UIjmmX/BmZD9ZrKEpBIUzQiatSdujyq4+R+HE+Xw==
X-Google-Smtp-Source: AGHT+IEXqmdYq7NWbh0lEr3OP77o/zq7hwCM7BW2t0yMD4BoTcUEH86kyL1ZuT11ypXZ6uf7smMqiiOGZjm6B2OqvIM=
X-Received: by 2002:a05:622a:1a11:b0:4ef:bd18:e20f with SMTP id
 d75a77b69052e-4f0176cf76cmr90222301cf.82.1764873706906; Thu, 04 Dec 2025
 10:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-7-joannelkoong@gmail.com> <CADUfDZqzpfnq8zfYNT7qQdauMmQQ=z6xi9Am-KyQc148oxwAxA@mail.gmail.com>
In-Reply-To: <CADUfDZqzpfnq8zfYNT7qQdauMmQQ=z6xi9Am-KyQc148oxwAxA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Dec 2025 10:41:35 -0800
X-Gm-Features: AWmQ_blFgkVmktTumcbh6U6UTiyBFhMQS1VT4QDoCvoJxMOw5ECuYMNLnDE3VQ8
Message-ID: <CAJnrk1aNWCNJw9C0TpNysnfg64fQjg06OSE+GYy6Eh0BMfiPDA@mail.gmail.com>
Subject: Re: [PATCH v1 06/30] io_uring/kbuf: add buffer ring pinning/unpinning
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:13=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > Add kernel APIs to pin and unpin buffer rings, preventing userspace fro=
m
> > unregistering a buffer ring while it is pinned by the kernel.
> >
> > This provides a mechanism for kernel subsystems to safely access buffer
> > ring contents while ensuring the buffer ring remains valid. A pinned
> > buffer ring cannot be unregistered until explicitly unpinned. On the
> > userspace side, trying to unregister a pinned buffer will return -EBUSY=
.
> > Pinning an already-pinned bufring is acceptable and returns 0.
> >
> > The API accepts a "struct io_ring_ctx *ctx" rather than a cmd pointer,
> > as the buffer ring may need to be unpinned in contexts where a cmd is
> > not readily available.
> >
> > This is a preparatory change for upcoming fuse usage of kernel-managed
> > buffer rings. It is necessary for fuse to pin the buffer ring because
> > fuse may need to select a buffer in atomic contexts, which it can only
> > do so by using the underlying buffer list pointer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/buf.h | 28 +++++++++++++++++++++++
> >  io_uring/kbuf.c              | 43 ++++++++++++++++++++++++++++++++++++
> >  io_uring/kbuf.h              |  5 +++++
> >  3 files changed, 76 insertions(+)
> >  create mode 100644 include/linux/io_uring/buf.h
> >
> > diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > index 00ab17a034b5..ddda1338e652 100644
> > --- a/io_uring/kbuf.c
> > +++ b/io_uring/kbuf.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/poll.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/io_uring.h>
> > +#include <linux/io_uring/buf.h>
> >
> >  #include <uapi/linux/io_uring.h>
> >
> > @@ -237,6 +238,46 @@ struct io_br_sel io_buffer_select(struct io_kiocb =
*req, size_t *len,
> >         return sel;
> >  }
> >
> > +int io_uring_buf_ring_pin(struct io_ring_ctx *ctx, unsigned buf_group,
> > +                         unsigned issue_flags, struct io_buffer_list *=
*bl)
> > +{
> > +       struct io_buffer_list *buffer_list;
> > +       int ret =3D -EINVAL;
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       buffer_list =3D io_buffer_get_list(ctx, buf_group);
> > +       if (likely(buffer_list) && (buffer_list->flags & IOBL_BUF_RING)=
) {
>
> Since there's no reference-counting of pins, I think it might make
> more sense to fail io_uring_buf_ring_pin() if the buffer ring is
> already pinned. Otherwise, the buffer ring will be unpinned in the
> first call to io_uring_buf_ring_unpin(), when it might still be in use
> by another caller of io_uring_buf_ring_pin().

That makes sense, I'll change this to return -EALREADY then if it's
already pinned.

Thanks,
Joanne
>
> Best,
> Caleb
>

