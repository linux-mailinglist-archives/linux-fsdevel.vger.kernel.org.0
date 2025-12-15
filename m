Return-Path: <linux-fsdevel+bounces-71360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEECBF2FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3324230B7703
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6733E376;
	Mon, 15 Dec 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BmiTTWlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F333859E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818574; cv=none; b=Rc88NB83NPm3Cr4EG2z/48C2Xcx04W4SzubCuBjpvEAxCVwAeKdLs1YoIH4bKya3/mvGiepfbN3YI691yp+G4cYXF8pGLAbP1+TYtgnFde+QdRecpurg3rIU3s41qFWSIpXzG0AriyM2U8zqFgMSTuRU5c5BtU3rVINwjBo3rkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818574; c=relaxed/simple;
	bh=EcLUN7JsuZp7IcMNJG274sRBHNSkKP3j5R3furYhVP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIlH1cU5Y/g4WPRW25A/xjWW2fuonCxwCgGc2VCWB8mg6gVqHQAQCX0KpzKBgo3GdQm0Pgzfi/DDKF3cntc12+Wt9qDZNmcXObtPgxPDOlNWmfNy2ninPwkTpJYgDvEtslsdajTd95QA33bb+XeY6VQrOMXn93SBZTyl3A4c5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BmiTTWlC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c6f6566a7so358151a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765818570; x=1766423370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASVvbfD82BAL0H1TKwt6lpQuFeFB3qVzeqINvcQI01o=;
        b=BmiTTWlCnffKlzzgdIbd1cT//WPSNybkhLcgt5aGUN3ZeVb2Uw2gC/GaGIHvEj6b7H
         0omRCVajqmDG9MaHmtERqNo2DhE4FH91kV/DL9BMugjMt9Ke3LmHPS/TJjnB0l+A/uH2
         ipAzXQk2MqB6FoPG/hIm1EJkVQRmOkTG06ZwyON6ZQPJkz/qRUzKW6Ejfhj9DCka+o1M
         pNs9uw3qRt+j+HlGekUDvZZOu7NyEUq/eXJqwTRdB2vUMN0X4G57s6qC+lYL/0B8nUAz
         m7w4cOus4fBDXWi38rtHSZVG/kXu8a6Mczc7tTU0AE8gRbJ+01dBYwox2nfSpMKxXJdQ
         7cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818570; x=1766423370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ASVvbfD82BAL0H1TKwt6lpQuFeFB3qVzeqINvcQI01o=;
        b=BFzEnOsRgxjCLICgm61UUld5isGDl9t9wFmnml6N0wvJ/U0uO/C82rQZX+1/LC/vlZ
         lpraJW1/98TVXBE8c//Xtc94bFiuG7SRFNrs8v8HqKtO0Lv2HGfpAkd3gbdsIKmx9hHn
         zI1OSMw2hroMDDlD/s9KQ48bkpeJbaDU47/eHX6YwS0SYxwx/QrZ7v0akORf95f6Z6us
         4Iox9vpfdO7JMozHCPktU14zFPTvIlT3vw8U49fQ2Gi8uhw7YAIO9ps3VwJNW6uHaUxA
         D9D5IF6Z6zugNb1RwMtOz0sW0JIo59tP1e8QL59bJ1v36p1f/PR8Fjjymx6F/HxiVTSy
         15sg==
X-Forwarded-Encrypted: i=1; AJvYcCVY7NEA2JcEAY/8Lwp9Vr6OCVb+/4wRJnHEEdCI7yqmFsYWGx9UIgjsz/gEdMRzmivrwvyaaj0JNan/BOVT@vger.kernel.org
X-Gm-Message-State: AOJu0YykbzDyxBX0PSyO3pzmPDIxgcEZKB8EGP1x1FojC78+Da6JCcMJ
	blI3OY1qwp0M839KDV9uLjOR+kfyHQB3rFn6l8z0a1UnW4eV6BIBScknNZGUIOj4e8oUiXQpWqk
	sKDfmI2gfvQgQ3aE4DVBbRwkh2q+mCVOmM0JpL9CXfQ==
X-Gm-Gg: AY/fxX5XpCYG/SKw8WEKFmnQnxOjGYu3+6v1rPhuUVOou3sIhd3Dn8bDsrdGzOJSPUZ
	+sicOLQz+s+nAUJ2023JIXMTlw+goW5NzGBcUgYr+IL2C/91zDLIHuFXjFYq3YigfoljQSWv4WJ
	ApDieM1/XjVh0ftoyuIkBoCql8laS3nKsiu9I4Z17RBYCgPri0Y5xyhMgTjYPTB4LmwbEWHsTDm
	/w2ppYfdBVojFww0OQ3N3WZfZLpQebGnXrdFUIBzERyjabOZoNMDxBIUg+X82w00CarQs6n
X-Google-Smtp-Source: AGHT+IFAqA4DZWkfxFs7HDuQy/beTvT/9R8F/vzjf8WRuDj3pqoLZEG3Ynp2bNIFaQ/hH8W0/m7XZc3gfoRsz9HC97k=
X-Received: by 2002:a05:7022:b8a:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11f34bd3b7bmr5659494c88.2.1765818570356; Mon, 15 Dec 2025
 09:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-24-joannelkoong@gmail.com> <CADUfDZp9u8D8shxK1BQ=O4cMWeE7w4wrvfY7Xdr0=_vAEgvJZQ@mail.gmail.com>
 <CAJnrk1ZKX+0Zph-aEOnRL0MmCxyEvt4u6EOUyiHVOhv98wUU8A@mail.gmail.com>
In-Reply-To: <CAJnrk1ZKX+0Zph-aEOnRL0MmCxyEvt4u6EOUyiHVOhv98wUU8A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 15 Dec 2025 09:09:18 -0800
X-Gm-Features: AQt7F2o6V9vQv6iy3w5K0zgefvD2AAxYh1f0UEk1VHO2v_l5z2UZUqonvq5ymWg
Message-ID: <CADUfDZqNqqwfKVNx4M+jjfovTb8Vy5ohFQdRB39_tN+B2_ZhBw@mail.gmail.com>
Subject: Re: [PATCH v1 23/30] io_uring/rsrc: split io_buffer_register_request()
 logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 9:24=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sun, Dec 7, 2025 at 5:42=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Tue, Dec 2, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > Split the main initialization logic in io_buffer_register_request() i=
nto
> > > a helper function.
> > >
> > > This is a preparatory patch for supporting kernel-populated buffers i=
n
> > > fuse io-uring, which will be reusing this logic.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  io_uring/rsrc.c | 80 +++++++++++++++++++++++++++++------------------=
--
> > >  1 file changed, 48 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > index 59cafe63d187..18abba6f6b86 100644
> > > --- a/io_uring/rsrc.c
> > > +++ b/io_uring/rsrc.c
> > > @@ -941,63 +941,79 @@ int io_sqe_buffers_register(struct io_ring_ctx =
*ctx, void __user *arg,
> > >         return ret;
> > >  }
> > >
> > > -int io_buffer_register_request(struct io_ring_ctx *ctx, struct reque=
st *rq,
> > > -                              void (*release)(void *), unsigned int =
index,
> > > -                              unsigned int issue_flags)
> > > +static int io_buffer_init(struct io_ring_ctx *ctx, unsigned int nr_b=
vecs,
> >
> > Consider adding "kernel" somewhere in the name to distinguish this
> > from the userspace registered buffer initialization
>
> I can rename this to io_kernel_buffer_init().

Sounds good.

Thanks,
Caleb

>
> >
> > > +                         unsigned int total_bytes, u8 dir,
> > > +                         void (*release)(void *), void *priv,
> > > +                         unsigned int index)
> > >  {
> > >         struct io_rsrc_data *data =3D &ctx->buf_table;
> > > -       struct req_iterator rq_iter;
> > >         struct io_mapped_ubuf *imu;
> > >         struct io_rsrc_node *node;
> > > -       struct bio_vec bv;
> > > -       unsigned int nr_bvecs =3D 0;
> > > -       int ret =3D 0;
> > >
> > > -       io_ring_submit_lock(ctx, issue_flags);
> > > -       if (index >=3D data->nr) {
> > > -               ret =3D -EINVAL;
> > > -               goto unlock;
> > > -       }
> > > +       if (index >=3D data->nr)
> > > +               return -EINVAL;
> > >         index =3D array_index_nospec(index, data->nr);
> > >
> > > -       if (data->nodes[index]) {
> > > -               ret =3D -EBUSY;
> > > -               goto unlock;
> > > -       }
> > > +       if (data->nodes[index])
> > > +               return -EBUSY;
> > >
> > >         node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> > > -       if (!node) {
> > > -               ret =3D -ENOMEM;
> > > -               goto unlock;
> > > -       }
> > > +       if (!node)
> > > +               return -ENOMEM;
> > >
> > > -       /*
> > > -        * blk_rq_nr_phys_segments() may overestimate the number of b=
vecs
> > > -        * but avoids needing to iterate over the bvecs
> > > -        */
> > > -       imu =3D io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
> > > +       imu =3D io_alloc_imu(ctx, nr_bvecs);
> > >         if (!imu) {
> > >                 kfree(node);
> > > -               ret =3D -ENOMEM;
> > > -               goto unlock;
> > > +               return -ENOMEM;
> > >         }
> > >
> > >         imu->ubuf =3D 0;
> > > -       imu->len =3D blk_rq_bytes(rq);
> > > +       imu->len =3D total_bytes;
> > >         imu->acct_pages =3D 0;
> > >         imu->folio_shift =3D PAGE_SHIFT;
> > > +       imu->nr_bvecs =3D nr_bvecs;
> > >         refcount_set(&imu->refs, 1);
> > >         imu->release =3D release;
> > > -       imu->priv =3D rq;
> > > +       imu->priv =3D priv;
> > >         imu->is_kbuf =3D true;
> > > -       imu->dir =3D 1 << rq_data_dir(rq);
> > > +       imu->dir =3D 1 << dir;
> > > +
> > > +       node->buf =3D imu;
> > > +       data->nodes[index] =3D node;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int io_buffer_register_request(struct io_ring_ctx *ctx, struct reque=
st *rq,
> > > +                              void (*release)(void *), unsigned int =
index,
> > > +                              unsigned int issue_flags)
> > > +{
> > > +       struct req_iterator rq_iter;
> > > +       struct io_mapped_ubuf *imu;
> > > +       struct bio_vec bv;
> > > +       unsigned int nr_bvecs;
> > > +       unsigned int total_bytes;
> > > +       int ret;
> > > +
> > > +       io_ring_submit_lock(ctx, issue_flags);
> > > +
> > > +       /*
> > > +        * blk_rq_nr_phys_segments() may overestimate the number of b=
vecs
> > > +        * but avoids needing to iterate over the bvecs
> > > +        */
> > > +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> > > +       total_bytes =3D blk_rq_bytes(rq);
> >
> > These could be initialized before io_ring_submit_lock()
> >
> > > +       ret =3D io_buffer_init(ctx, nr_bvecs, total_bytes, rq_data_di=
r(rq), release, rq,
> > > +                            index);
> > > +       if (ret)
> > > +               goto unlock;
> > >
> > > +       imu =3D ctx->buf_table.nodes[index]->buf;
> >
> > It would be nice to avoid all these additional dereferences. Could
> > io_buffer_init() return the struct io_mapped_ubuf *, using ERR_PTR()
> > to return any error code?
>
> I'll make this change for v2.
>
> Thanks,
> Joanne
> >
> > Best,
> > Caleb

