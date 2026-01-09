Return-Path: <linux-fsdevel+bounces-72969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE2D06AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 02:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5A3630263DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325422135B8;
	Fri,  9 Jan 2026 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhppVu5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224C1632E7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920841; cv=none; b=LgK9D8LU3CkPnla64IFrL9JPQG2a3re7hzRz7wiuDxD/HZZo5wiUMTWkZBgaRHcFWNXW7F1LZVYX3Sh7BE3vvvYwneBNd3ifMSTeQywXDkZONR+0zRnFiPqsFxH4rbI/VUfRGeKaSgRavRV/A9IsIeNqIydaaSQIP7031Rt3Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920841; c=relaxed/simple;
	bh=cPwGCp046vgnz9li0QypCY9lKN+OYWmF9pomQJQU/Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/h9N6A8Eo+eU2y9Hapb1MBQNJ84iBR4skDfhu2hZvfsHnBW902fqumLHgXsud8UVRHvJjOcjm9CnkLM+pXE8JZPGQ9IZWI7mJ6LYargX1gUseg6E/4ozFFTudXg/DaQTBg2OjTqdxw1JAWl+aSjY452vFKhp5EMexYaiaUFNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhppVu5D; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso39543441cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920839; x=1768525639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUY6QZ6/qc1SNBM9OMRZTNYPdWEGtr5HxrTpsqE3o1w=;
        b=BhppVu5D29+nGmeVlVsstNB2PW1kQu4f0g4pmSrg73Q+S0qXzRtOOdmnIqfpe9jHVh
         vnIh9hcrJAfsj65AplkHkIjJkqEOeap/IF7tl2yuF9uDelCC08RW58aGZ3msldYdNhZF
         +TvIo200BVb9UU1cNMmcxsyV1Iv6m43n/9blV2bMryFoBZMrC0Id66FUILFcEGVgszDw
         w5kmj+HNlh7J4mz1mN/wkIRAnPjvMhzYAltW8k3WjzNH1ceLtUx8u9iiU6ugkpPwYsoS
         ACVOZV/D6FRkKvCsWOdFhWCoKaJvyh7tTNfpAWvP9KHIwAtNph2Yq3nCe8b5g6b/EUoB
         Ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920839; x=1768525639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUY6QZ6/qc1SNBM9OMRZTNYPdWEGtr5HxrTpsqE3o1w=;
        b=QB9TbuhMqjZ0Q/qvMFtm9WOQsV6FGpiQQRhYdATSkV3OQ295DIeYZ9ic4dF05eyFc9
         GHppe7YuNgh4qy5fcDpCLDTqldZdxLMi37fAt3MRseJAW9N2egCtFpdfxXG+c+ldD5Wb
         sqXASen1ARpvEFJuipWX04bArW1gb6GQNxSSFPOjqTP3P8AJJqFnJk2qYCTb/hYAW0mL
         tngkHwgFA2CTWKzH6m7anx4cv9bsTwkf0HkdmODfIc3xsGKzjHRqKb/Cc9uY06PxhVQN
         ypChNEkBrU+vHFoBAcR7WAsc6Utrzv7JcrqVlTHLMj6BjYk9nrDnWrtqTcSUMCqLygeB
         derA==
X-Forwarded-Encrypted: i=1; AJvYcCV+yKRfZ+LNT9pQi40dWRsR+9qAGfOI9hLUNaerBVIWAztuEq/+Dmewz73ffgCSw+YyiQJ+EMl/GsIcOmDF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oXtrhF+Qk8GYMcIjY/IlpeeoedlV4F4cW8R/KrJ4rjyEYGEG
	Naw7PDeDr65b8326GboFdvs8u2Dy7OuXcMMW2A/Dv6mZfhDXR2CCH6AaUIs3pD1U0drfpCjpEmB
	+olvakro6FWX7I54SsqMcXq9d3MNYass=
X-Gm-Gg: AY/fxX5jOui9xuXB/v/0P7QhgFfwufGdUOMtdnxF4tQ+++FT0QlMWfOmi+Sxeisu8oT
	ZvRBCf3RMe1N6voO4cM3I/XnXhURVp4VCEaWqDa8F4d8Gpja+7Go+GiSYffk8a5j19JJaMRYAiH
	JqvnDA779YiHnEFdNvpgW0+Tdx5hcXRva5mzFs2nm/a6XlKmehdxbb9eKopOg74D5C2PDBu2ow7
	/xs7/KHCm3A4HqM+SYYJ+H3lU0kXyfKsiqb/ROXA4WqwBm/KkIG4HQ08qfxSPT1hQhDag==
X-Google-Smtp-Source: AGHT+IGprYMyTKH2BtDLeCae5BovOomShXAo76wqEIXsalKIeWb37V0t18kfBmCMD7vtX1CCFr1larq8MjtKaw2CNsU=
X-Received: by 2002:ac8:7f86:0:b0:4ee:2984:7d93 with SMTP id
 d75a77b69052e-4ffb47d6c3dmr100857941cf.17.1767920839131; Thu, 08 Jan 2026
 17:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-8-joannelkoong@gmail.com> <CADUfDZqOsoBGAfkyj1BO2MqyjMxVnYxfim-szAXNsGwW29XrYA@mail.gmail.com>
In-Reply-To: <CADUfDZqOsoBGAfkyj1BO2MqyjMxVnYxfim-szAXNsGwW29XrYA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 17:07:08 -0800
X-Gm-Features: AQt7F2qoMY6Kn7ekvWBZ4c-8Hi5uTVikWoZuD06fU-MrD7-vchbJINS7aDHKGGU
Message-ID: <CAJnrk1a904pJ_XjUtACBxQiYJ1whMWpxPG64=R_i1od6c-PQTA@mail.gmail.com>
Subject: Re: [PATCH v3 07/25] io_uring/kbuf: add recycling for kernel managed
 buffer rings
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:37=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Add an interface for buffers to be recycled back into a kernel-managed
> > buffer ring.
> >
> > This is a preparatory patch for fuse over io-uring.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 13 +++++++++++
> >  io_uring/kbuf.c              | 42 ++++++++++++++++++++++++++++++++++++
> >  io_uring/kbuf.h              |  3 +++
> >  io_uring/uring_cmd.c         | 11 ++++++++++
> >  4 files changed, 69 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 424f071f42e5..7169a2a9a744 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -88,6 +88,11 @@ int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *i=
oucmd, unsigned buf_group,
> >                               unsigned issue_flags, struct io_buffer_li=
st **bl);
> >  int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned =
buf_group,
> >                                 unsigned issue_flags);
> > +
> > +int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *cmd,
> > +                                 unsigned int buf_group, u64 addr,
> > +                                 unsigned int len, unsigned int bid,
> > +                                 unsigned int issue_flags);
> >  #else
> >  static inline int
> >  io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> > @@ -143,6 +148,14 @@ static inline int io_uring_cmd_buf_ring_unpin(stru=
ct io_uring_cmd *ioucmd,
> >  {
> >         return -EOPNOTSUPP;
> >  }
> > +static inline int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *c=
md,
> > +                                               unsigned int buf_group,
> > +                                               u64 addr, unsigned int =
len,
> > +                                               unsigned int bid,
> > +                                               unsigned int issue_flag=
s)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_r=
eq tw_req)
> > diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > index 03e05bab023a..f12d000b71c5 100644
> > --- a/io_uring/kbuf.c
> > +++ b/io_uring/kbuf.c
> > @@ -101,6 +101,48 @@ void io_kbuf_drop_legacy(struct io_kiocb *req)
> >         req->kbuf =3D NULL;
> >  }
> >
> > +int io_kmbuf_recycle(struct io_kiocb *req, unsigned int bgid, u64 addr=
,
> > +                    unsigned int len, unsigned int bid,
> > +                    unsigned int issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D req->ctx;
> > +       struct io_uring_buf_ring *br;
> > +       struct io_uring_buf *buf;
> > +       struct io_buffer_list *bl;
> > +       int ret =3D -EINVAL;
> > +
> > +       if (WARN_ON_ONCE(req->flags & REQ_F_BUFFERS_COMMIT))
> > +               return ret;
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       bl =3D io_buffer_get_list(ctx, bgid);
> > +
> > +       if (WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING)) ||
> > +           WARN_ON_ONCE(!(bl->flags & IOBL_KERNEL_MANAGED)))
> > +               goto done;
> > +
> > +       br =3D bl->buf_ring;
> > +
> > +       if (WARN_ON_ONCE((br->tail - bl->head) >=3D bl->nr_entries))
> > +               goto done;
> > +
> > +       buf =3D &br->bufs[(br->tail) & bl->mask];
> > +
> > +       buf->addr =3D addr;
> > +       buf->len =3D len;
> > +       buf->bid =3D bid;
> > +
> > +       req->flags &=3D ~REQ_F_BUFFER_RING;
> > +
> > +       br->tail++;
> > +       ret =3D 0;
> > +
> > +done:
> > +       io_ring_submit_unlock(ctx, issue_flags);
> > +       return ret;
> > +}
> > +
> >  bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags=
)
> >  {
> >         struct io_ring_ctx *ctx =3D req->ctx;
> > diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
> > index c4368f35cf11..4d8b7491628e 100644
> > --- a/io_uring/kbuf.h
> > +++ b/io_uring/kbuf.h
> > @@ -146,4 +146,7 @@ int io_kbuf_ring_pin(struct io_kiocb *req, unsigned=
 buf_group,
> >                      unsigned issue_flags, struct io_buffer_list **bl);
> >  int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
> >                        unsigned issue_flags);
> > +int io_kmbuf_recycle(struct io_kiocb *req, unsigned int bgid, u64 addr=
,
> > +                    unsigned int len, unsigned int bid,
> > +                    unsigned int issue_flags);
> >  #endif
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 8ac79ead4158..b6b675010bfd 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -416,3 +416,14 @@ int io_uring_cmd_buf_ring_unpin(struct io_uring_cm=
d *ioucmd, unsigned buf_group,
> >         return io_kbuf_ring_unpin(req, buf_group, issue_flags);
> >  }
> >  EXPORT_SYMBOL_GPL(io_uring_cmd_buf_ring_unpin);
> > +
> > +int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *ioucmd,
> > +                                 unsigned int buf_group, u64 addr,
> > +                                 unsigned int len, unsigned int bid,
> > +                                 unsigned int issue_flags)
> > +{
> > +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> > +
> > +       return io_kmbuf_recycle(req, buf_group, addr, len, bid, issue_f=
lags);
>
> Total nit, but is there a reason for the inconsistency between
> "kmbuffer" and "kmbuf"? I would prefer to use a single name for the
> concept.

Ah totally valid question. I'll stick with the kmbuf naming convention
and rename this for v4.

Thanks for taking a look at this patchset series.
>
> Best,
> Caleb
>
> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_kmbuffer_recycle);
> > --
> > 2.47.3
> >

