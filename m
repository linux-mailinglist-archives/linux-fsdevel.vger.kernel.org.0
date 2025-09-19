Return-Path: <linux-fsdevel+bounces-62260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1DB8AED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CE51CC3270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2152571BC;
	Fri, 19 Sep 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLRv59a/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAF233727
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306859; cv=none; b=qbGN0rwCm5OPAK6im4D5de+Hs6W5iomzy1xj8DBUiIuuDGHbOdD1cdI7TnWmHe/bOI6SpaOhkhjb3j1WegX6fwBZM3Y5LwmcJhGnoYOeKm8xROhkDBPSoLI9UsqFSNUem4w5odO9Mnnu3FkKgqISwAblDikuXzAE1MOP29CBmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306859; c=relaxed/simple;
	bh=7uX0BeiPsvWw8q8A4083nVg+t12ANac5Jycw2LTy1oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRrTZYbO4cUJtvPAHhoGV0qxnziEeRNY0I1WQrq99YnwosdWbmSo+CG61LCbYYZ7qmhZmLh0crlp1Z/Cb4aVVP18TolcwuhxzINTmjEzT1HY8g4P4DX8hERhoLNgFomw26Q1/X69hksyivUZkRQETAZc+AOsWoo4KisTnYP6nGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLRv59a/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b548745253so39218571cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306854; x=1758911654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhRHN77jwmvAE0x3y6aKKQENztc6fTFsJqlfUz+6jDw=;
        b=GLRv59a/rTvS4bvW43r7Ii6vk7K8DBPLFhRNBMr9CAnlo2Q0gEijjt9U8vukfU3RgC
         eQ6/eKyLGpzGLkQHTzdSRIJOzVw0M4elOd06F0zGmVuyRp+ia5SXD1WyQz4GL5oRiLsX
         opBj/+dM8b49MQTJcGS4mx4Eck+3mesnqmgjnxR4kHntly+mwyOwcD6Ezrlo+OPnlArT
         uYaVU8T1kwtf7sb6l9Ocsz5rCGf3+udu8r7I4RRAfLZxncnE53WAdPY9ULAnVC8ZkvDU
         nun7+8TvubmV71s+Iqe8p+qQ/iUBNwXXEWBLRt43hMkyi6/c+PI73KzfmiZtXkLIZt31
         +Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306854; x=1758911654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhRHN77jwmvAE0x3y6aKKQENztc6fTFsJqlfUz+6jDw=;
        b=fhi6KgbEuMC7nR0N0gPr5FZg6uDBEyk7CGRbf6VO+fAIm/1nqdTYz5tGeXtmoFuIVG
         qg9CO8iKg0VtXbzZjbQSur+9AHZcUydFljl/8IK3auFrqM5R9Ec9pkWlaLbFurjVbGn8
         Hmc3+KRevJ9A9s3RJWVzYHHkL4IetLfl9eWek75UIyg16ewSvWSSq4IuzjbxbXk05FVD
         VG9rJLoKbF+H3ExFY6K4yV1jwXMdb/WZkvJsbZ0zoc+fVWdruASiC14ou7yyA6EjtZnZ
         m19oKZxLYQmHTb4tpLsCYlkeyokLe31PAqoYV7+vtFimoE6Wd1deEwMEIQRa/zH/KCr+
         c68g==
X-Forwarded-Encrypted: i=1; AJvYcCVzPC7Rp7/qdeOS6H7mJGwXgXsaX7VE4M4XB4QejrIFfytbutHGpfvBK5HqkiPK5sjVVH+xOOTFyKTifrGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxemBYNSuv0fPZgMFmLamIrP7dpUsbcD5ziHT1TctlBy79sHN4T
	TkaYBYtI6OieoQQczOeM2+BgujK5pYHZZGajCJ50srw2ZLhGuadDmBBoMfHQ5+h4EyEejTtTaQc
	/uuEobFiLIvxVUfWPCEAW5HtYVYkX09s=
X-Gm-Gg: ASbGncucJkaECAmZU3LAeqLVagDOl0HQPB8GETPrB/LDvgpoYg4botoJ/BszrBCUKqB
	giLvOKzCSLQzf0q8Uj+ixlYH4TuNmxRFrD6tNqeycbQVPlUrqL62HJGR7GmHL6d/u+wyy5Ehrav
	ZXXRfA1la6tJlthuBaIfbHQDRgfW9H6RiFjH/Uz1g0lw0f2oUjehRtJHhn3DlF5XHMy2cJfeDS/
	mOnZCw6ma/ApGftqGdyQad0edgzaajRwUkPw0e5
X-Google-Smtp-Source: AGHT+IEl3EPErf3c09yltPELq1CrtgsMWd+b8acWGVirSfI9XbkQbByyu5P2kwwv0Ytvm0XcDlRHkOfSCgIJVsMlx8s=
X-Received: by 2002:a05:622a:1826:b0:4b0:7cb2:cec3 with SMTP id
 d75a77b69052e-4c07238f39dmr58025631cf.38.1758306854308; Fri, 19 Sep 2025
 11:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com> <20250918223018.GY1587915@frogsfrogsfrogs>
In-Reply-To: <20250918223018.GY1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 11:34:03 -0700
X-Gm-Features: AS18NWA5eATCQro2K3o3en9fIfjv9ya2PYZQVPmIDN-TkbTJuiFMxPoK5v0Ka7I
Message-ID: <CAJnrk1bB+=J5g5h+asx12SYMogiKSn9SpEvRg11-_N_xWodvSA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:30=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Sep 16, 2025 at 04:44:20PM -0700, Joanne Koong wrote:
> > Non-block-based filesystems will be using iomap read/readahead. If they
> > handle reading in ranges asynchronously and fulfill those read requests
> > on an ongoing basis (instead of all together at the end), then there is
> > the possibility that the read on the folio may be prematurely ended if
> > earlier async requests complete before the later ones have been issued.
> >
> > For example if there is a large folio and a readahead request for 16
> > pages in that folio, if doing readahead on those 16 pages is split into
> > 4 async requests and the first request is sent off and then completed
> > before we have sent off the second request, then when the first request
> > calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> > which would end the read and unlock the folio prematurely.
> >
> > To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> > the first range is forwarded to the caller and removed after the last
> > range has been forwarded.
> >
> > iomap writeback does this with their async requests as well to prevent
> > prematurely ending writeback.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 55 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 47 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 561378f2b9bb..667a49cb5ae5 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -420,6 +420,38 @@ const struct iomap_read_ops iomap_bio_read_ops =3D=
 {
> >  };
> >  EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
> >
> > +/*
> > + * Add a bias to ifs->read_bytes_pending to prevent the read on the fo=
lio from
> > + * being ended prematurely.
> > + *
> > + * Otherwise, if the ranges are read asynchronously and read requests =
are
> > + * fulfilled on an ongoing basis, there is the possibility that the re=
ad on the
> > + * folio may be prematurely ended if earlier async requests complete b=
efore the
> > + * later ones have been issued.
> > + */
> > +static void iomap_read_add_bias(struct folio *folio)
> > +{
> > +     iomap_start_folio_read(folio, 1);
>
> I wonder, could you achieve the same effect by elevating
> read_bytes_pending by the number of bytes that we think we have to read,
> and subtracting from it as the completions come in or we decide that no
> read is necessary?
>

This is an interesting idea and I think it works (eg we set
read_bytes_pending to the folio size, keep track of how many
non-uptodate bytes are read in, then at the end subtract
read_bytes_pending by folio_size - bytes_read_in). Personally I find
this bias incrementing/decrementing by 1 approach simplest and easier
to read and reason about, but maybe I'm just biased (pun intended, I
guess :P). I don't feel strongly about this so if you do, I'm happy to
change this.


> (That might just be overthinking the plumbing though)
>
> --D
>

