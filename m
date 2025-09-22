Return-Path: <linux-fsdevel+bounces-62435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B12B937D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AF4445695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647D2F8BF4;
	Mon, 22 Sep 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGkB4bt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403027F018
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580410; cv=none; b=a/DkJFGHVxFdMAIlA+eNVQITqiz580oqbVOZRoAzlzFHXJ4RoU1qsf3mh1z5GL1y+hpk0diOgwqvpvIVAADBsLpJlRkKtZzfKdCcae7DKAYCG26Wwkyk1vf3lt70xfcqMS3TZAvi1W0tkzIZEimIfqng99QSUVhwvsVwi6f/oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580410; c=relaxed/simple;
	bh=9gUnRWW1xSW7v428HK8QOTPfOJyiCrOBtECJftbi3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWISGzbdKgB66N+OHbglYczsWxgsTVc1zJn05wTnGXg81kg+TZLkCtB6dc7NyONJdauH7QhpZb+Bk0gfoliVOOHQ7Fui6ATfh3AoVLkH+bvGRvjxaM8dC6pw09zHhWNST9ozOcYIQsVCYYXSiamUca8YSPhzsW1iA9xSBQa2wRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGkB4bt6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b61161dd37so32385401cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580407; x=1759185207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYsm3gMuZ6zP5BwF7VSAmryD1NVeBQnXrzftMRUOM78=;
        b=VGkB4bt6fwlT+rLFgq6zfTZ4Anb2xkb3iZ4i6emZzxhqOeNvAhwV19ORGowL+uWkER
         6lwJLevFjnLc4dR/RdHEdsvQEz9BpbIlUeIjro2sd+U7sE6rr5gZHE6pVhFeh9gr/ak1
         HgHA4MRua+PM49qcZ20TgdKYMqWfh/VRODq5DeA3tICR/IhU1dYRFN/VtZTjo4ku3O7B
         z6LSCb0FsnOyIrrVxG8wvWpFjgc2dyNXyzFl45/hGFe6Kv5+8LBzZYgipEFSfyKTQyek
         P+TyI6VlG3DNrLj9x43xy0JLB8j1m4dZGWGuP1SUUxfFW/IF9ZEDXxebhx7vjqNguDjB
         EtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580407; x=1759185207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYsm3gMuZ6zP5BwF7VSAmryD1NVeBQnXrzftMRUOM78=;
        b=l7xwjeGnASCXN7ATvEF/ioG3CHCfnGkkn+xS6OgFxKTcjFnVCGRkoCduMBin3gFkc+
         mOYH47mbpY5kMf0/ehJpzkMDuQgqEI1VLWMMmMjMiXtjbeukVAdXZXV/u6BW4IjKSnEY
         qfEVUWsNHSCai5wfIxtUPQ2ZGFj9ylgKahFMLp1P5xb0LDLaCyr46VFi7zYDsaqySTZN
         qQ47tpfjQTz8e7asgLw1S8UotALLIpIsQv/Bt6k4zH+9dzAFm33GwkRdlihkRCMNDyr/
         hr4adrsb8oWH/Ajl6kell3sOJjSobghfEfYW1IANebHmRYvZFATpIhXUhRISh0lw4VHB
         PJNg==
X-Forwarded-Encrypted: i=1; AJvYcCUwBGgQjk6nrApavAMmZY/7BmdCPnaENMwK+DPrJj5qfp8igd/Inq+AeXF56i87cATtOXN+gG3RBiD83grI@vger.kernel.org
X-Gm-Message-State: AOJu0YwbksGuUe3FiMDi7a5zvdN8/CQNG8f6qHKlO+Bz+vm6eosMkYeF
	+geu/RGsEDRcwQykd+yHonkAlP4QFSub6aMWe62MuPmEo+jVpGMnUa5qjK3xTy50q28nFxrlj0C
	vCX9eF2Y6meUeRHDsLNfGtWS+1aNS7bc1Ewgu
X-Gm-Gg: ASbGncvOvAJc6AG3uu/JpfPTsEzaJ+tfdWhTGKmb6noGAScSBy37nDZOUaj21T/VS4Q
	qBxGROK98teaUR3x5Cq+Co/u6mCq6a5fKre/J/sZee92FQ+tKyP3sAnVqTKwGBzEARdpGBATnm1
	7PGb8J/vEgCWZnJMUoXs1KRcZdWGcWtISGijp7TzwCxVXifMwmFT+igD146HihymhldRuLPtKmq
	r280hZOQxVEBuhk69xpE/dn+6I/ctJXG7T1vPxRty3YOphF/vA=
X-Google-Smtp-Source: AGHT+IF59spwoCjoNevIOS6EB4EogkJR/RYbcHdd3SU92QEm1R4zLwhxuNE22b2ZQB4jX2aAaCOjGDoVHvUFM8Uxyuo=
X-Received: by 2002:a05:622a:5490:b0:4b5:e856:2b6 with SMTP id
 d75a77b69052e-4d368a7f582mr6104971cf.27.1758580406619; Mon, 22 Sep 2025
 15:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <20250916234425.1274735-5-joannelkoong@gmail.com>
In-Reply-To: <20250916234425.1274735-5-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Sep 2025 15:33:15 -0700
X-Gm-Features: AS18NWANWqkKm48EgUYQpSCL1ismSoNPpJ2JmzDLzkmpUdQ92ZSUKuvOZrXN2QY
Message-ID: <CAJnrk1btMBosbCsvfG+jCJCoqQ8zrkjSrqhqp8XSSLU=Es64FQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_iter()
To: brauner@kernel.org, miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:50=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Iterate over all non-uptodate ranges in a single call to
> iomap_readpage_iter() instead of leaving the partial folio iteration to
> the caller.
>
> This will be useful for supporting caller-provided async folio read
> callbacks (added in later commit) because that will require tracking
> when the first and last async read request for a folio is sent, in order
> to prevent premature read completion of the folio.
>
> This additionally makes the iomap_readahead_iter() logic a bit simpler.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 69 ++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a1709e0757b..0c4ba2a63490 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,7 @@ static int iomap_readpage_iter(struct iomap_iter *ite=
r,
>         loff_t length =3D iomap_length(iter);
>         struct folio *folio =3D ctx->cur_folio;
>         size_t poff, plen;
> +       loff_t count;
>         int ret;
>
>         if (iomap->type =3D=3D IOMAP_INLINE) {
> @@ -431,39 +432,33 @@ static int iomap_readpage_iter(struct iomap_iter *i=
ter,
>
>         /* zero post-eof blocks as the page may be mapped */
>         ifs_alloc(iter->inode, folio, iter->flags);
> -       iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, =
&plen);
> -       if (plen =3D=3D 0)
> -               goto done;
>
> -       if (iomap_block_needs_zeroing(iter, pos)) {
> -               folio_zero_range(folio, poff, plen);
> -               iomap_set_range_uptodate(folio, poff, plen);
> -       } else {
> -               iomap_bio_read_folio_range(iter, ctx, pos, plen);
> -       }
> +       length =3D min_t(loff_t, length,
> +                       folio_size(folio) - offset_in_folio(folio, pos));
> +       while (length) {
> +               iomap_adjust_read_range(iter->inode, folio, &pos, length,=
 &poff,
> +                               &plen);
>
> -done:
> -       /*
> -        * Move the caller beyond our range so that it keeps making progr=
ess.
> -        * For that, we have to include any leading non-uptodate ranges, =
but
> -        * we can skip trailing ones as they will be handled in the next
> -        * iteration.
> -        */
> -       length =3D pos - iter->pos + plen;
> -       return iomap_iter_advance(iter, &length);
> -}
> +               count =3D pos - iter->pos + plen;
> +               if (WARN_ON_ONCE(count > length))
> +                       return -EIO;
>
> -static int iomap_read_folio_iter(struct iomap_iter *iter,
> -               struct iomap_readpage_ctx *ctx)
> -{
> -       int ret;
> +               if (plen =3D=3D 0)
> +                       return iomap_iter_advance(iter, &count);
>
> -       while (iomap_length(iter)) {
> -               ret =3D iomap_readpage_iter(iter, ctx);
> +               if (iomap_block_needs_zeroing(iter, pos)) {
> +                       folio_zero_range(folio, poff, plen);
> +                       iomap_set_range_uptodate(folio, poff, plen);
> +               } else {
> +                       iomap_bio_read_folio_range(iter, ctx, pos, plen);
> +               }
> +
> +               length -=3D count;
> +               ret =3D iomap_iter_advance(iter, &count);
>                 if (ret)
>                         return ret;
> +               pos =3D iter->pos;
>         }
> -
>         return 0;
>  }
>
> @@ -482,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struc=
t iomap_ops *ops)
>         trace_iomap_readpage(iter.inode, 1);
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
> -               iter.status =3D iomap_read_folio_iter(&iter, &ctx);
> +               iter.status =3D iomap_readpage_iter(&iter, &ctx);
>
>         iomap_bio_submit_read(&ctx);
>
> @@ -504,16 +499,16 @@ static int iomap_readahead_iter(struct iomap_iter *=
iter,
>         int ret;
>
>         while (iomap_length(iter)) {
> -               if (ctx->cur_folio &&
> -                   offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) =
{
> -                       if (!ctx->cur_folio_in_bio)
> -                               folio_unlock(ctx->cur_folio);
> -                       ctx->cur_folio =3D NULL;
> -               }
> -               if (!ctx->cur_folio) {
> -                       ctx->cur_folio =3D readahead_folio(ctx->rac);
> -                       ctx->cur_folio_in_bio =3D false;
> -               }
> +               if (ctx->cur_folio && !ctx->cur_folio_in_bio)
> +                       folio_unlock(ctx->cur_folio);
> +               ctx->cur_folio =3D readahead_folio(ctx->rac);

Unfortunately, this logic simplification here doesn't work. It still
needs to check "offset_in_folio() =3D=3D 0" because the iomap mapping may
only map in part of the folio, in which case the next round of
iomap_iter() should still operate on the same folio. I'll make this
change in v4.

> +               /*
> +                * We should never in practice hit this case since the it=
er
> +                * length matches the readahead length.
> +                */
> +               if (WARN_ON_ONCE(!ctx->cur_folio))
> +                       return -EINVAL;
> +               ctx->cur_folio_in_bio =3D false;
>                 ret =3D iomap_readpage_iter(iter, ctx);
>                 if (ret)
>                         return ret;
> --
> 2.47.3
>

