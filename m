Return-Path: <linux-fsdevel+bounces-60296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F8B44698
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4901CC377A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4302727F5;
	Thu,  4 Sep 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtPnrA4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6425E469;
	Thu,  4 Sep 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014841; cv=none; b=iW4TYITtlcqlnOMhxUptFneFzMJYJEdogki0lPZ3p2cEOn7x1aBtWSWBnuyU3+S+TrmHvt7oLMXXADuCjo5TkHjyrvv9SPuymFkL31JgSwyq7B3dNz0px6akZObuXB7NyfG48E1KTuEUIf2wT7OpEVQ6Z/iYvjLAlOQMOS/8/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014841; c=relaxed/simple;
	bh=But6yFSXJD2S4pFLQsKbXcuuNX1JkCVO7C+ISR/VD8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZJgDkIPAAkeXRISsM+uENGaZjzH6ap7SdhEb8CCqdJHF2jcEP5O9jdOLEvctMB+tL1ibzOkI5SDIjt2PQemywvhQGXpgye5m3s4VlaeyUQLb1DHLOw88s5YoVnHlVzS4Mv6t3K8pdR+nJuu0z5+V9Vu5Alx0RomPBPUh7GW7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtPnrA4U; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b3319c3a27so11085071cf.0;
        Thu, 04 Sep 2025 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757014839; x=1757619639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL5EvzitXv89XkgWDtmbXmrQ61qOKXgiKtxFmnaYH2c=;
        b=dtPnrA4U0HJiNhmBQE8fRzycFWqa35BGv3OLlNUuFYE0Snxd/gb4bRW1qvzHOEPCLm
         rgMfGoEtqYBhZjyQtyOojD1epIDYFfHyLw4L0gwGZnOFfXupx7t6XoIO5RV7GYMBLeDF
         3wEHbc4cRy9JIEO04ZC9bOU93APP3di67FQwODtEtjUSP5Sa9PY9ykheoXwGg/HewfMr
         JToOgiu1tOTCp53gnNgrSGmfGQrNFAW+NPdqEy3agADT+gfFYQSEFRjxui3wYN5OnUZw
         MatnWzYAfRneHJjh8ncnRTRJBjrfikJg9odquphwS4Zm8CB3kZRavjVMnIolp2pfpLnF
         vR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014839; x=1757619639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL5EvzitXv89XkgWDtmbXmrQ61qOKXgiKtxFmnaYH2c=;
        b=VIrWKm9NpQQuAcH8164H0apxTVu2o88inFwonwShjApPSU0C3uzuypjZIu235iKfMH
         FEwrbfyZ97pml80vA6p0SILMzjNazpZru6PSud+QJz+VXSioXB6/byzzKDNiPP0aD6r8
         VvNuTW2NDmQ5FHwgBwJ3Xp9Spus9HXQ8XXp6YZqEKjuI6WosN/x60tZ0IG4vHfO5UN7w
         lWHi5lXBLycUW2cmOmXNxP0qvFTSND5VxXcOCfDQwOYNDtBzL3GSCruk03Lc39Y/yEuY
         H5QYaNbB+Slu2/i8OrOJ6231nI1np9dEfQWey72dE21ronLe6TyR7yLRP9VteYZ7gGa/
         L/8g==
X-Forwarded-Encrypted: i=1; AJvYcCXEiyvF9hBhxXISZ5tiILGKbVEW7AVOIDC8cGzFBFqLeTM6sk6VegVPXtJ1d32iSModmN3nmL7e651P@vger.kernel.org, AJvYcCXZQcUNYJ1IPuxus9v5HbObVusTtse3FvgEWtGteFZEUI8sm6uyBZwaZlfJQ3xtwyEPvVKeGG4pAf8=@vger.kernel.org, AJvYcCXvdDzeVAl1oJoPglqFkBRzoOJT9u1UNVj1sqrSsah2BjGJHwaLEHLownb3wG4x9cvtJjN3ulGhoUxjmhudcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFnGMXGQHQDemRIInOIr8NxP60b0LlpRu1V/NCsHzqPAlAX3Z
	8w1Rd81ELmxLnAmXpnUnhPlMdGeEq7ABeTZrSluPy5YPkwIJ21LgqW/elVmWA4QVVKUDFD9lWzi
	4rvI0ZfkKTbktxTwpXU8DVzqOKVZGNZE=
X-Gm-Gg: ASbGncvE8mTydQlw72o8Ye9LzAr2D0SZcgUP4lP6FyGjw1qeo0fg0+rMqT/e3xfFdNJ
	d5IwqyNzZtmGMgBXLgtC4P52zBxDeZli5S7gpLUHs0FBzxR7l+As1R3MA+8MFQE6DI7YKQ4PJdV
	nc8sISCNDJvwIOG8O6LgtAQe9tJJC5wsrd5Oxbr8hrQNCIAk36B6YRqtzxxyRYJKdcW6+00UHfN
	BdkDa4W
X-Google-Smtp-Source: AGHT+IHJIffgq0DsxTjOYo/oBjCSEnCKgqUQW8LF/IZVRFcnhtvH7rYenJ6DvpBK2lfixcJeBcsbXFoRm0yFl55bc14=
X-Received: by 2002:a05:622a:38a:b0:4b3:75b:6f49 with SMTP id
 d75a77b69052e-4b5e7cd23c8mr14445721cf.9.1757014838933; Thu, 04 Sep 2025
 12:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-16-joannelkoong@gmail.com> <20250903211754.GW1587915@frogsfrogsfrogs>
In-Reply-To: <20250903211754.GW1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 12:40:26 -0700
X-Gm-Features: Ac12FXwn27nBrE8ZH7N2WgpDrGPfsAU5W2gw-BGJf9BnLiEnEgDTS6hwGhpdJn0
Message-ID: <CAJnrk1ZGQ7EYL0U0Q6m_V9O2pyMY40a=vu5XQEfcCCOEx3+qEw@mail.gmail.com>
Subject: Re: [PATCH v1 15/16] fuse: use iomap for readahead
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Aug 29, 2025 at 04:56:26PM -0700, Joanne Koong wrote:
> > Do readahead in fuse using iomap. This gives us granular uptodate
> > tracking for large folios, which optimizes how much data needs to be
> > read in. If some portions of the folio are already uptodate (eg through
> > a prior write), we only need to read in the non-uptodate portions.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 214 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 118 insertions(+), 96 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index bdfb13cdee4b..1659603f4cb6 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2176,10 +2187,21 @@ static ssize_t fuse_iomap_writeback_range(struc=
t iomap_writepage_ctx *wpc,
> >                       return -EIO;
> >       }
> >
> > -     if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
> > -             fuse_writepages_send(inode, data);
> > -             data->wpa =3D NULL;
> > -             data->nr_bytes =3D 0;
> > +     if (wpa) {
> > +             bool send =3D fuse_folios_need_send(fc, pos, len, ap, dat=
a->nr_bytes,
> > +                                               true);
> > +
> > +             if (!send) {
> > +                     /* Need to grow the pages array?  If so, did the =
expansion fail? */
> > +                     send =3D (ap->num_folios =3D=3D data->max_folios)=
 &&
> > +                             !fuse_pages_realloc(data, fc->max_pages);
> > +             }
>
> What purpose this code relocation serve?  I gather the idea here is that
> writes need to reallocate the pages array, whereas readahead can simply
> constrain to whatever's already allocated?
>

I think it's more that for readahead there's more guiding info about
what size array is needed (eg looking at readahead_count(rac)) whereas
that's more uncertain for writeback, especially since the folios can
only be part of the same request if they're contiguous. The writeback
array gets reallocated exponentially up on a per-need basis starting
at 1. imo it seems better to start the writeback array at 2 or 4
folios but I also don't really have empirical data to back this theory
up.


Thanks,
Joanne
> --D
>

