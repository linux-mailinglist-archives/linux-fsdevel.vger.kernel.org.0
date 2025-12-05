Return-Path: <linux-fsdevel+bounces-70826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF1CA8724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70FCE301D61E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291D3358B9;
	Fri,  5 Dec 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NIZJ+Wqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D62FFDC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953805; cv=none; b=ktc5blirU0jUg2rkOH6eazPz5Q1jNZN0hf+gQuWUvTGYBmo+USNZbagpvZRALTyBIsqVirDCqwKU4DUlmvk33wPl45kqeIGHuZS/2D4BnWR4Gc7g3xRR9hgTKBveMWwVRYVGGIv+gXRELfJdDVty4vjOJ3Zb4X0B1ZZBk2v8f0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953805; c=relaxed/simple;
	bh=M4oPY7GS9GpxI9PUNxyEN7UBwwAUyqzFlomAPU8Akvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcSx/O56cN7VA2dDQolPo8qeR4k+KhvjIshYjMs+8A7xWBn8w8MnbVGq1LtcL0LZvUrRxXRreQ5ehpLyLtIIF3c92z0C9T9FbSKrdBBlAFNlSXU+uWVEQwo+hDT+V/xxdrXxoeLotiJumdvBcaTj0fSNvIA3WBt7Eb7FwWovpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NIZJ+Wqh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295395ceda3so4012755ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 08:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764953796; x=1765558596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLkse+kxK2cpAjStUn6oi58P19wP2uA7EZcpaXApxz8=;
        b=NIZJ+Wqh9P1/hvOdnu2AtJzuUJgGvCSa1uvSKctfF9C67CbEtH6lm3DUJmRpvkBd3T
         7/xExcUM5JaW+H/7PhZYJlFlaCGzpx62PVNGQy62+cYMTMSBUDw/chR7zuLgqh8CqFHU
         jUMiSDAKWAqdQbvchyKW2m3yaRkiL2v+v4qbF1Xv4IJqVCco3aOfgpzkB8woipvfoj/V
         NXvbX1YMUB2aTS56qNeKkJ73R3+rnCgeSXdb67jJbtjVnLkST0PsIZPsPLTyR2mtXLK8
         bE8oH40/W73hswDe8+m+NIeF3Br/guF9XCqWPchKdOuvLPKHL+SqaHYUufndt+RWr/H6
         wb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764953796; x=1765558596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLkse+kxK2cpAjStUn6oi58P19wP2uA7EZcpaXApxz8=;
        b=DFp+wgbHp7aktmThFynQyrGqtv/wz+DH7PCKSSN2q14JHO4qqUw7pB2Qb7YbW292NX
         wkIKubjJjQXnxuli28uu2V/4H1e515x34EvvCJj8zYPE780WrjnNFBhiVozZJDuhUV00
         CLk7gAsSLDODySFv6rDBVvWpXuTHuA2b/SgcitSgsPidqmljeMiza6g68IOx5JkCG1pr
         4WfY7Zf1kjueRkThkr9C8PBhZWtaFDJXb+8de2ziSYRvrWXJxR9R+M2Nt1AIQSKt4hLR
         32RtJxV8uB1wBcqqvFh6CTIDpq4ZKfAtOkR1yydka/Fdw9AGImLTd1Zv6Rxylk5ka759
         zJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWrs1/z2i9jNKjko/LMhAHxxPFEI8I+KrGpXvrG6FrKajAJhO4WkH96+rYUEXwTVFZfO/0pItTnxi3VkSos@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Mw6aMGz+7wUvuT3BKrisaSFDPtgRxIAlplNJOeZK+kCb4q7I
	kuCzAia70ojD8784jwZmPtGPhL43IqLxnLjOi6WdzDn31kDRq7XENfhWMtKp2NcJuqbBYYx9w11
	dkJp+sj96JnmykwtPyOA5QP0yGIgzVWTGjGxhN+RxlQ==
X-Gm-Gg: ASbGncsrkZ988WZS5yn+DrfneTYEpFGGCFJGMsGrUc06gi81t0m7CCbIStS2ku2rei0
	Y1jhvzHCjxe7wuHdOflaJlQBgIssCzziu1shXbbyTkUik2Oauu9dGvf6pHhY5tlGrCSUPNxtqfG
	rDu7kzJCBRWkSv4DmDa6v7rcgm3t8z1u60txLNlGOcwwtMLfX8m82L1agSd4dwrVJkY5AsIUj3m
	4Xx+uWcTW+Es3EVEqv4x/+/PdJkSTpBJMVV8NVWo4mbqMnYoQjLc9yfIp5qla+Aw2c7v+JpSUzM
	KKQhGLQ=
X-Google-Smtp-Source: AGHT+IGbeCMLnueowPIoRrzPwuFgraW/b5AAoT5rWEdLqtgXZRw7M2hUo1Y4TmZqi7QNuKoRpruzJlYVuOmDSOOWv8Y=
X-Received: by 2002:a05:7022:529:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-11df259c23bmr6564324c88.4.1764953796295; Fri, 05 Dec 2025
 08:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-10-joannelkoong@gmail.com> <CADUfDZoUMRu=t3ELJ6yGt2FbcgW=WzHa_=xc4BNtEmPpA67VHw@mail.gmail.com>
 <CAJnrk1a9oifzg+7gtzxux+A0smUE-Hi3sfWU-VpnXZgvKg1ymQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a9oifzg+7gtzxux+A0smUE-Hi3sfWU-VpnXZgvKg1ymQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 5 Dec 2025 08:56:24 -0800
X-Gm-Features: AWmQ_bmHamkODTakaBnJQIc2zvf1nBWE4PbpBsybaPsg17oL8N-OXIplP9XG6pE
Message-ID: <CADUfDZoMNiJMoHJpKzF2E_xZ7U-2jitSfQJd=SZD57AxqN6O_Q@mail.gmail.com>
Subject: Re: [PATCH v1 09/30] io_uring: add io_uring_cmd_import_fixed_index()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 10:56=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Dec 3, 2025 at 1:44=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > Add a new helper, io_uring_cmd_import_fixed_index(). This takes in a
> > > buffer index. This requires the buffer table to have been pinned
> > > beforehand. The caller is responsible for ensuring it does not use th=
e
> > > returned iter after the buffer table has been unpinned.
> > >
> > > This is a preparatory patch needed for fuse-over-io-uring support, as
> > > the metadata for fuse requests will be stored at the last index, whic=
h
> > > will be different from the sqe's buffer index.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/io_uring/cmd.h | 10 ++++++++++
> > >  io_uring/rsrc.c              | 31 +++++++++++++++++++++++++++++++
> > >  io_uring/rsrc.h              |  2 ++
> > >  io_uring/uring_cmd.c         | 11 +++++++++++
> > >  4 files changed, 54 insertions(+)
> > >
> > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > index 67331cae0a5a..b6dd62118311 100644
> > > --- a/io_uring/rsrc.c
> > > +++ b/io_uring/rsrc.c
> > > @@ -1156,6 +1156,37 @@ int io_import_reg_buf(struct io_kiocb *req, st=
ruct iov_iter *iter,
> > >         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
> > >  }
> > >
> > > +int io_import_reg_buf_index(struct io_kiocb *req, struct iov_iter *i=
ter,
> > > +                           u16 buf_index, int ddir, unsigned issue_f=
lags)
> > > +{
> > > +       struct io_ring_ctx *ctx =3D req->ctx;
> > > +       struct io_rsrc_node *node;
> > > +       struct io_mapped_ubuf *imu;
> > > +
> > > +       io_ring_submit_lock(ctx, issue_flags);
> > > +
> > > +       if (buf_index >=3D req->ctx->buf_table.nr ||
> >
> > This condition is already checked in io_rsrc_node_lookup() below.
>
> I think we still need this check here to differentiate between -EINVAL
> if buf_index is out of bounds and -EFAULT if the buf index was not out
> of bounds but the lookup returned NULL.

Is there a reason you prefer EINVAL over EFAULT? EFAULT seems
consistent with the errors returned from registered buffer lookups in
other cases.

Best,
Caleb

>
> >
> > > +           !(ctx->buf_table.flags & IO_RSRC_DATA_PINNED)) {
> > > +               io_ring_submit_unlock(ctx, issue_flags);
> > > +               return -EINVAL;
> > > +       }
> > > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > > index 197474911f04..e077eba00efe 100644
> > > --- a/io_uring/uring_cmd.c
> > > +++ b/io_uring/uring_cmd.c
> > > @@ -314,6 +314,17 @@ int io_uring_cmd_import_fixed_vec(struct io_urin=
g_cmd *ioucmd,
> > >  }
> > >  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
> > >
> > > +int io_uring_cmd_import_fixed_index(struct io_uring_cmd *ioucmd, u16=
 buf_index,
> > > +                                   int ddir, struct iov_iter *iter,
> > > +                                   unsigned int issue_flags)
> > > +{
> > > +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> > > +
> > > +       return io_import_reg_buf_index(req, iter, buf_index, ddir,
> > > +                                      issue_flags);
> > > +}
> >
> > Probably would make sense to make this an inline function, since it
> > immediately defers to io_import_reg_buf_index().
>
> That makes sense to me, I'll make this change for v2.
>
> Thanks,
> Joanne
>
> >
> > Best,
> > Caleb

