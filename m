Return-Path: <linux-fsdevel+bounces-62437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6CB938F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E15044858C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE62F1FD3;
	Mon, 22 Sep 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMvz6R8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC163283FE2
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583193; cv=none; b=iNZa5cor+zCPP+iBqqdHHgRV2fJWDB/UHC8daJDmWjNO5WrIUQLkJ8xrWvMGf9AjpScU9MIooICTHKbp715au2iyzTz2R7Vj7QHY23ovOWMBbWdzcgN8twtWl8VdWrYb8QWAST2s5gIp1UC2GjW37GNbCkyG+PiM+rRczCodPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583193; c=relaxed/simple;
	bh=/ZGhEdHxAf5En7VuJLPdUgSdRXXJT79QW6EW69v6ge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djm8q/Ahh8fl1ysdq2JGfugD2nkePQcaaVuXDRhv0+N36h/PUeujW84BnR2ntk2IxBqJTM1Hj7ouBEFMDA9AyIOtXuGQSowCvdOFFfBZbLR6qY5J4VdQk1JQ8q1VuC6Rl60Q9PemeihbnURdKyG9Wvd+ozhHr0jeCUToCorvVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMvz6R8e; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4c88e79866aso14052001cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583190; x=1759187990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5DMISbR66sU4eakY+Mp7FN3sykHlkCNyCvZ3g2bpqQ=;
        b=IMvz6R8e+adAhzNBIeY3Pu/q+vjscyECu7hdBuFYwqqlT1L7e/gRM4uSZPjPs2Px48
         2h0h/in+1gq3IgC+rsst+0ovb68qPWb2Y8/QXaNmWauiF6fu2dS/pJcOkAoyv+JlL3wi
         bAKodXcT8X4gb0rP8v5KeMIp2KBsczPhVh8A2bfqmssQbZDm25ByM27WWADLCKn+yekX
         pptrTJRBF9QU+O9ygxC3lr4ln/rSXgl5j1mxZig5bfwg4wffXC/0osUz1H8wtp1sHcoT
         tFV3GrVnLGxFOQmOWq8CPV++tSOkinNHyfZFwbCHzGFd+8QAII32Odv4d2eYmDNCh4+C
         oZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583190; x=1759187990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5DMISbR66sU4eakY+Mp7FN3sykHlkCNyCvZ3g2bpqQ=;
        b=GwafpZxvy+2oLg15ZDI8EAqKvXQ9DfM6v0oyar3J7frL0CUpK+tzoHdPf+B+YSkB6/
         Rk3ABPv8mHZ6T4pMjhjUA5ofXYbAsElYWBD5D8GiJemdJAU+i/sDgPaR6KpCtZQlF+hs
         68iXEznQShMw6lz4Jr+JGu+D2AfgBGg4hPnCGvzA8qkQG/lB6/1bBJHlXyC6STl7gAcJ
         ymhE/nmLOG362QkG9uGGsu37VvYcv3UEClFVd+oo/NjAzmhxgjRhpBonTSjs4qu9UQeL
         7IGN1NR8sW/y8HWyKi0YPqsuPtcZWFTtZUI2pwnjY9fLlf7+xnFQQfh4s7HWQlJZhy6Y
         ZkHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOLWHqKrQDSfOaeqaPZNPN80LbvkMUtWpcttd0VCCpCvmwoZE3FHfbBjX/VrvOY+2PChRUqldSWwSTwa0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kFZr3vZamLVj6UYPFyjsVonJz6/+iIYDyAekSekHtadbhCwr
	yQs3YfA73Y22e3IZ2Km2/p8d8k+nubX5S4cfUfygQu7AAoPFhCHaYKkeKkMW1Jg2dLmxGuKUEv9
	weEIxBGKBApLKYvEva0Ob1XKe4XMs6x8=
X-Gm-Gg: ASbGncsZ13n/Rnqs5Zyx6F2nMXI3ce16ZMq5whl55nKnQ8fnXutL+huQYK0sOSUTcdB
	4Nh6Krvv5bLmPzuxlvZmFAiwJsaSJ4k82i/McNhqhyDEbwcIgLAQKLaDABLuKBwo1AV7L4prd1o
	BDilnHwMI0p/JoaRjNb5LgLbLHoI+WzFULwwaWIlaIL+cm6g7H/0WmEGSkcctlutVe4p4S5OYa3
	sGCI1nhKvQa1ZRSga+Kx8LZ7i/YfeWTEsPt+QV7
X-Google-Smtp-Source: AGHT+IFNuzLvdXFomfA1KkmfecMlzvBTRMKqvNIwaHSdYbK7o03YrrosbHbAe4IFOO+/WLrkvS0LLAwLdqLBhZ8+gqc=
X-Received: by 2002:a05:622a:1496:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4d368f50c9fmr8453981cf.26.1758583189669; Mon, 22 Sep 2025
 16:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <20250916234425.1274735-11-joannelkoong@gmail.com>
In-Reply-To: <20250916234425.1274735-11-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Sep 2025 16:19:38 -0700
X-Gm-Features: AS18NWAQg0BFCZgWl1vhaunaCTNOq8KGV147wLJZI9ev6DW1qua4YY9D4BQheHU
Message-ID: <CAJnrk1Y7_P=LzzgeZS9tga4XhEhChrKOYPVZd+D8n69zJ7HXDA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
To: brauner@kernel.org, miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:50=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Non-block-based filesystems will be using iomap read/readahead. If they
> handle reading in ranges asynchronously and fulfill those read requests
> on an ongoing basis (instead of all together at the end), then there is
> the possibility that the read on the folio may be prematurely ended if
> earlier async requests complete before the later ones have been issued.
>
> For example if there is a large folio and a readahead request for 16
> pages in that folio, if doing readahead on those 16 pages is split into
> 4 async requests and the first request is sent off and then completed
> before we have sent off the second request, then when the first request
> calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> which would end the read and unlock the folio prematurely.
>
> To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> the first range is forwarded to the caller and removed after the last
> range has been forwarded.
>
> iomap writeback does this with their async requests as well to prevent
> prematurely ending writeback.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 55 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 561378f2b9bb..667a49cb5ae5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,38 @@ const struct iomap_read_ops iomap_bio_read_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
>
> +/*
> + * Add a bias to ifs->read_bytes_pending to prevent the read on the foli=
o from
> + * being ended prematurely.
> + *
> + * Otherwise, if the ranges are read asynchronously and read requests ar=
e
> + * fulfilled on an ongoing basis, there is the possibility that the read=
 on the
> + * folio may be prematurely ended if earlier async requests complete bef=
ore the
> + * later ones have been issued.
> + */
> +static void iomap_read_add_bias(struct folio *folio)
> +{
> +       iomap_start_folio_read(folio, 1);
> +}
> +
> +static void iomap_read_remove_bias(struct folio *folio, bool *cur_folio_=
owned)
> +{
> +       struct iomap_folio_state *ifs =3D folio->private;
> +       bool finished, uptodate;
> +
> +       if (ifs) {
> +               spin_lock_irq(&ifs->state_lock);
> +               ifs->read_bytes_pending -=3D 1;
> +               finished =3D !ifs->read_bytes_pending;
> +               if (finished)
> +                       uptodate =3D ifs_is_fully_uptodate(folio, ifs);
> +               spin_unlock_irq(&ifs->state_lock);
> +               if (finished)
> +                       folio_end_read(folio, uptodate);
> +               *cur_folio_owned =3D true;
> +       }
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>                 struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
>  {
> @@ -429,7 +461,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         struct folio *folio =3D ctx->cur_folio;
>         size_t poff, plen;
>         loff_t delta;
> -       int ret;
> +       int ret =3D 0;
>
>         if (iomap->type =3D=3D IOMAP_INLINE) {
>                 ret =3D iomap_read_inline_data(iter, folio);
> @@ -441,6 +473,8 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         /* zero post-eof blocks as the page may be mapped */
>         ifs_alloc(iter->inode, folio, iter->flags);
>
> +       iomap_read_add_bias(folio);

Same here, it's not guaranteed that the whole folio is parsed here
because the current iomap mapping may only have part of the folio
mapped. The bias needs to be added before the first iomap_iter() call
and removed after all iomap_iter() calls are complete. I'll make this
change for v4.

> +
>         length =3D min_t(loff_t, length,
>                         folio_size(folio) - offset_in_folio(folio, pos));
>         while (length) {
> @@ -448,16 +482,18 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>                                 &plen);
>
>                 delta =3D pos - iter->pos;
> -               if (WARN_ON_ONCE(delta + plen > length))
> -                       return -EIO;
> +               if (WARN_ON_ONCE(delta + plen > length)) {
> +                       ret =3D -EIO;
> +                       break;
> +               }
>                 length -=3D delta + plen;
>
>                 ret =3D iomap_iter_advance(iter, &delta);
>                 if (ret)
> -                       return ret;
> +                       break;
>
>                 if (plen =3D=3D 0)
> -                       return 0;
> +                       break;
>
>                 if (iomap_block_needs_zeroing(iter, pos)) {
>                         folio_zero_range(folio, poff, plen);
> @@ -466,16 +502,19 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>                         *cur_folio_owned =3D true;
>                         ret =3D ctx->ops->read_folio_range(iter, ctx, ple=
n);
>                         if (ret)
> -                               return ret;
> +                               break;
>                 }
>
>                 delta =3D plen;
>                 ret =3D iomap_iter_advance(iter, &delta);
>                 if (ret)
> -                       return ret;
> +                       break;
>                 pos =3D iter->pos;
>         }
> -       return 0;
> +
> +       iomap_read_remove_bias(folio, cur_folio_owned);
> +
> +       return ret;
>  }
>
>  int iomap_read_folio(const struct iomap_ops *ops,
> --
> 2.47.3
>

