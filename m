Return-Path: <linux-fsdevel+bounces-42442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31012A4270E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420461890AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFF261399;
	Mon, 24 Feb 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="VkZScC5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC18A6C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412266; cv=none; b=t9rurqug5PxQGPWaqLACwDJ1yZue2vgjXnIRY1sD0KC6OOuaDg5S3abGTkTSzNxgTv3MRmbZj4WkPlrE8Wq+Re3Y2O2wNKSpGTm+9BMN1bRrnvixRKGKWp73uxkm7h+hwRPny3lYpIw5K0a4vrxU+L8eWn79lyOj86obHVeISKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412266; c=relaxed/simple;
	bh=urNcMCOkBjYvvIoGcK0YzOhzgaamAKhLhgVqydGZQaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XchzdRdl3rPujqJjWZXSvabPN8F34/MPKYzD69Gzp/sPokOfo5s5jeFFNDNtX4Rg0koGZ8ovzaT6QJud6JYg7Bp6MMJRu5ts/2p8F/DrBj0EWsKnMoPRj4ydhuPNgNZSlH+KRRaFlGQ1uxq6wbq7NQsYrxSnc/UusFpzvTrLWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=VkZScC5I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2211cd4463cso91206625ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740412264; x=1741017064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVE5zIf7xhMQy/EVfU5iI/JQVcppTl6NRC/QrFSALCE=;
        b=VkZScC5IWVJVKLavnNA1FYU++DeOzmhtV3MApAyk2Bx5TJvvmq71HYzVShaixYtFP8
         hc9g4hO+JMp+eqR9qEDlCExqT5ZSQR6i7MKzUdOaXNjU2QgIsCJdrmJwySoQXUQKk+mG
         4rI28NBoBl95Q4nPH6ziK/y+FjYfD4Iy0ju16xIcB4y3gE0SjgYuQ0MEHGVICm5zzPKk
         jPoI2HQRrHtiEfvWzaObIsBX9qQwA9QFe4o1joZWPO8iy6ebDBHcR8XMgrammnfEXaWi
         Ba89cLXW1GDiGBAkJjRgnUrhsCvLF93yGBcvY304+g7HgpxHAssih9RIeR9q1zuSr4V0
         pxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412264; x=1741017064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVE5zIf7xhMQy/EVfU5iI/JQVcppTl6NRC/QrFSALCE=;
        b=Ma9hPcEuFWUs0Bc1dzjII1QjmAJSX/EzNNIRSaFnDDgq3K+kh6y9RIBjSNTKRRKap9
         s3cbfDa9R5GJUZP3D8mxl6D1AVl/EXRgS9NCN115VwHEXE3rRNOXFUNGyTCr+Ho4ImYz
         w1Vldqd2HrPIaBeZcfzrgS1ec1Dctd25zEZuoanuCaO0vVAzJ/jyc/rSzFBW0kyc8SbS
         LAfJID5gwS4F2j1qIImQd/X/rRch4a4o7EmeEGKz9cwluydswCiE7iIAikSiNinUForg
         3ESkOo/0G7UT6yyVWrES0xUdoOcNt50cQr08PbGUanwlr1bvBj/zoWDQCRk/WUxEGEzj
         QujA==
X-Forwarded-Encrypted: i=1; AJvYcCUvYXudfa9fOtcKbUpMlW1wsRIsi6ul8ITr9uveWbuMyOCWs2RIb/6k7X9F+bigEsuZ6BAw3yHmN/xX9Y3I@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiEx+oDmFvRmEeLD/n8BTM/QG0xSPH419BfJ4pKgEsDONuFr8
	oIa9i294EHvvEUxRwssIBfzvakscU/oqNOhGkHc+YM1Ultubgx9H0/7YO9e1k+BfOiIsjZSqDnr
	YUGljCRh9pqh+TAzLvzHgaHeib9MPuGx3QgWuyb6HCsIa2MeOy5na3YmuSb+2U09ifvA8VRSAF7
	NCXyTPUanbjScZuEYLZZus6Qx4p8iEyfzx+EZqDYYSjUShblEq3jVaEgZdGPQsdgsYzZEMeLsN0
	BHyxij35bK3QsOApEGLU7C7nh4hLVx2cwpXXAgDDmJ2wh6mGOi+i8acQJZ++RG7Ve5l9/RSE8Cm
	4830/h6DyhtDh32OYJAHt0/SR72aG0XJ7/+DaUhRo6M/5cXqZsGZDm8v0AFYfra+qkRHf+EweUv
	4U/dZXFVf+Q2S6UxGJj0fmly+
X-Gm-Gg: ASbGncsNGUMGIipBb43i/qEA7a44bz3g+1b3vuj1BUS2e7+b2xEZwPUJLwmG5Sb1Y/+
	ghvt9uvE4ugdHnoEYW/6ORV3Lzt1mNUkWQGFP8LOgqqWZ+fKMy7t8StuFjC0RtC9kNGI9UoH0Wz
	RaN0GYbLp6Q87ThguWd4gW1g==
X-Google-Smtp-Source: AGHT+IHsCvINcnxQOW+o8QVQCqF8jaKtkYNtzFqeavOaYusjaInUVxxswqCBiGDf3YmqmSw3z9D/HguiBZIpB3uQlwQ=
X-Received: by 2002:a17:90b:2252:b0:2ee:4513:f1d1 with SMTP id
 98e67ed59e1d1-2fce7b2caf9mr19601973a91.23.1740412264171; Mon, 24 Feb 2025
 07:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com> <Z7yVB0w7YoY_DrNz@casper.infradead.org>
In-Reply-To: <Z7yVB0w7YoY_DrNz@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:50:48 -0300
X-Gm-Features: AWEUYZmCaVei4AAfqe3vnNodRbnQHoRP0SLFpgUKuQd_na8KPtvHoJlGT8fEx1Y
Message-ID: <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:49=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 12:45:21PM -0300, Raphael S. Carvalho wrote:
> > On Mon, Feb 24, 2025 at 12:33=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> > > > On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote=
:
> > > > > +           if (err) {
> > > > > +                   /* Prevents -ENOMEM from escaping to user spa=
ce with FGP_NOWAIT */
> > > > > +                   if ((fgp_flags & FGP_NOWAIT) && err =3D=3D -E=
NOMEM)
> > > > > +                           err =3D -EAGAIN;
> > > > >                     return ERR_PTR(err);
> > > >
> > > > I don't think the comment is all that useful.  It's also overly lon=
g.
> > > >
> > > > I'd suggest this instead:
> > > >
> > > >                       /*
> > > >                        * When NOWAIT I/O fails to allocate folios t=
his could
> > > >                        * be due to a nonblocking memory allocation =
and not
> > > >                        * because the system actually is out of memo=
ry.
> > > >                        * Return -EAGAIN so that there caller retrie=
s in a
> > > >                        * blocking fashion instead of propagating -E=
NOMEM
> > > >                        * to the application.
> > > >                        */
> > >
> > > I don't think it needs a comment at all, but the memory allocation
> > > might be for something other than folios, so your suggested comment
> > > is misleading.
> >
> > Isn't it all in the context of allocating or adding folio? The reason
> > behind a comment is to prevent movements in the future that could
> > cause a similar regression, and also to inform the poor reader that
> > might be left wondering why we're converting -ENOMEM into -EAGAIN with
> > FGP_NOWAIT. Can it be slightly adjusted to make it more correct? Or
> > you really think it's better to remove it completely?
>
> I really don't think the comment is needed.  This is a common mistake
> when fixing a bug.

Ok, so I will proceed with v4 now, removing the comment.

