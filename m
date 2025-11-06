Return-Path: <linux-fsdevel+bounces-67356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687AC3CCDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFFC6613E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E89350297;
	Thu,  6 Nov 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9mpI372"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D232E135
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449437; cv=none; b=dxwNHylO65IEywLuI9y3tJS8l8E8jQWfi+cy3BQ8OjnOjhHkVMLZaZEJ5VG0pm/UypDwm/cdccisakBwq+9iSTKisUUGaBlzntQ8aGvXr1Wx1Nan0xxdMDv6110UC4SnI4+vBYUcMeCqjenzQzk6Mr2BNL7zpgzbCrlIOAlZqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449437; c=relaxed/simple;
	bh=Kb0xCCSilazZ/+mUpILFAKuAAykAuExsNjSlRInz8No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgofPrHYIs/tsOEKG1IcaAznn5dcD+A0XYAKsBUXA2Ep/T6tT8EMKys4gp5KTwQ+iWWOEuaEI87bAoSQI0JIrpXzIq85vn2JYAN0Sw3LJd94uvdeEvKRjeY9vSKBDFBE1ir78+jUBDNCkTZM86tIX3+Vhj0G72RnBCf9ZvLJGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9mpI372; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e89c433c00so12209671cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762449433; x=1763054233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx8P5FUeVJGxl9c0y6Zf3qT67jGlSyjXi22KOtbz0tE=;
        b=e9mpI372zSyf6IiQuD8pxTaDUHw0vhFGQWPxwWDU1iii68vB1K4FMylCKdiwqGsY1b
         wvK+dOyCjA+IOHZqDi7goxwa2mELQy95Qz22S0pSaQw9MmZWoHRI+Fce500w+By+jWtt
         x+pIU2PPe3INvZyDqYNil5HENCj9Hu82ocBz0OldUcl1WYYO6JWbJ68tKHkAwbUHUDi5
         wchWFVUEMrvzgjOJrHib1hNHTqRE7amdAgNqN7pgG2XkJA5K8ZsluhO5CTdJOnJ5I94q
         wRpXd5zAebfFVgRGUg8CXwW3vmsdf90MmpBUU/ASRZJQsd1uFY7babn9GrOdpd7NxdJk
         eSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449433; x=1763054233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx8P5FUeVJGxl9c0y6Zf3qT67jGlSyjXi22KOtbz0tE=;
        b=g/wdNjUDG6nWtKsi3qyF3Ci4lSZ0mbPBCvfqjvCHFOI1/4x8H0TKOqlwrdb3soJEFl
         cJ1bz2PN6Unu9COY3iMuyn6xepb9YJGNFvruUt/v+TABgIILaN5AdZHDGq4psg+MiFtM
         fUh72vVvDgq+pUCr4b+v+d8WhXKaD4EF/bMnRIJ41ShB5AkPda30sZ5Y2zWA0dfSpGPn
         SHptjAPiWogowbyACQ9QPgbYNHyOKAAU/66ow8PvCOyMfCqiVkAC21f5ycpGn7nx9dbH
         KbY0ydW1PLv6MK2KH3siyCOnT/F50gfaPnAZprZ8haPt1+ZZh0YI0aqClNPaW1Lqw07K
         zAYw==
X-Forwarded-Encrypted: i=1; AJvYcCWa/w6KMLTuGtTBakKV5AgmLMqu30+wMpHprO3Q5xlBAVZzXluHR3zjHrElc2ILqPFESECPhM/MOgp5j+m6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KMfwlSt+sp6gXz5mvwIaRkArHLVNsXBpXDnbR5UvcfOCWUQo
	0TPsI6bTkhpMsdafciKvc2OAg7vJ3b/vMqyJ3IDiqqBYuE0TRR+Xrb6+Ak1J9OKCy7Y8FgaABLA
	bEZ+dZtAMJ0QOgUXeUNEGbw+VqfP2c7w=
X-Gm-Gg: ASbGncu7buepmcl/NJ/nlITtljaqxjy4Nxz7AvfWtwjhMLAhAKqMeQP9Q5EM6zkxoS6
	HRuuR2Q6Xw4xq8aRuaKM24wbH3m3QJtUUaQZG0s+bgD1maYxiVzUurhaYZZlFZ1UhBRpNQ8wvku
	R/RLZtyqDGTm8MkSdRqTbvbXkhOJnskWEKQxCT8iXBh6YF4qB3qu6/bOgT1pYUInVfUE3nqnktS
	6KGyKnQK98pyn+KmUfj09lw1GesiZNiOhXZsi8lxZXjx8BxeM1P3sBvnZi7r87RF0sBT6xpppsI
	zNoOETLOpEGXmpWLNFXK7Ta3Tg==
X-Google-Smtp-Source: AGHT+IGeaQLgFwQTOw+mDbfA2s8cBZE+yprlg1qhZ5tLZ35NcmcyihJFA+0p8oVeTYC6jDFSw0TBwec5TG7jP41miO4=
X-Received: by 2002:a05:622a:1886:b0:4ed:64ee:b946 with SMTP id
 d75a77b69052e-4ed72333348mr84795831cf.9.1762449433003; Thu, 06 Nov 2025
 09:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-5-joannelkoong@gmail.com> <20251105015058.GJ196362@frogsfrogsfrogs>
In-Reply-To: <20251105015058.GJ196362@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 09:17:02 -0800
X-Gm-Features: AWmQ_bn6Fh9Vjo2iqfQ_tTbgGdSzC1iRJCbLWdsAcT8hytWSB0Cqq8Ac4mWS0EQ
Message-ID: <CAJnrk1Zqj0TNpJcrGLhSvTaK48=8iHW-58y3HXH=YgHs_or0tA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] iomap: simplify ->read_folio_range() error
 handling for reads
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:50=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Nov 04, 2025 at 12:51:15PM -0800, Joanne Koong wrote:
> > Instead of requiring that the caller calls iomap_finish_folio_read()
> > even if the ->read_folio_range() callback returns an error, account for
> > this internally in iomap instead, which makes the interface simpler and
> > makes it match writeback's ->read_folio_range() error handling
> > expectations.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  .../filesystems/iomap/operations.rst          |  7 +++--
> >  fs/fuse/file.c                                | 10 ++-----
> >  fs/iomap/buffered-io.c                        | 27 +++++++++----------
> >  include/linux/iomap.h                         |  5 ++--
> >  4 files changed, 20 insertions(+), 29 deletions(-)
> >
> > @@ -498,10 +497,10 @@ static int iomap_read_folio_iter(struct iomap_ite=
r *iter,
> >               } else {
> >                       if (!*bytes_submitted)
> >                               iomap_read_init(folio);
> > -                     *bytes_submitted +=3D plen;
> >                       ret =3D ctx->ops->read_folio_range(iter, ctx, ple=
n);
> >                       if (ret)
> >                               return ret;
> > +                     *bytes_submitted +=3D plen;
>
> Hrmm.  Is this the main change of this patch?  We don't increment
> bytes_submitted if ->read_folio_range returns an error, which then means
> that fuse doesn't have to call iomap_finish_folio_read to decrement
> *bytes_submitted?
>
> (and apparently the bio read_folio_range can't fail so no changes are
> needed there)

Yes, that is the motivation for the change. And to make the interface
consistent with how the ->read_folio_iter() callback for writeback
handles errors.

Thanks,
Joanne

>
> --D

