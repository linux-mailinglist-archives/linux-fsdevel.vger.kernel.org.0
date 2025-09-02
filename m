Return-Path: <linux-fsdevel+bounces-60026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460CAB40F55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD4F7A94AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F334A316;
	Tue,  2 Sep 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSkqr0MP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95E20311;
	Tue,  2 Sep 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848264; cv=none; b=c4t/MG+Pmg67R544oIYNbJBi5U6kp4KsRGc2ALoFY4bDEXUZPfrZn0KoqhPtodAFR0km4Vvk+YMnnXPWOZD2Iz/kbHAx696B62DSCWELYAvNUGlnje5Hvl3hmvFYY2fms4/y42GFeLCTji37ZVU+pT9ns9n27fcNjMNHRuPPoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848264; c=relaxed/simple;
	bh=Ptw6KvMj+N1tLqVtHclYDwcBvmH/pB3WHd5b4j8iO0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pE0tMtrSi1hHGV/ZX+WvZKw5vt6Q9oM2pBwJKRs8NZGUN60EF3J1kkbRY92BdURJ9WjDHMflYQv36ZctcCbcHaPZCexaYqE25W9+UlcyHLhDu3/ykf1Ec8W7cWIqtBfN/vmFUqQV6A5aaTmVaHUyK144DsjavBkjoEJjDDQnOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSkqr0MP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d47fa9dso6471161cf.0;
        Tue, 02 Sep 2025 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848262; x=1757453062; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctCQQe8xMPTdhD2y8+e8frNhv5BnY1zrZjKG8v0F/6s=;
        b=BSkqr0MP9kiQOAymV4DRDYdvoX0Ohl5j8RyM9T8nswLydQuRX/1vrOJEVJvZmRNq+J
         bCRewpRaI0zlMsYfNmbfz0sNTLZzY0a4xCYxc8gQ+jyb7Ln5adDnw9ai2DcDwnluirki
         pHsZnQNi97E7Fr4An6n/GqsF3+Xsth9DluPasIUms84SQ5oLGaddL/cdoSA+znplaAPO
         mIxvA47avxemFH1a52DaLkBqopQvGMhJQc2kr9JVg64/SUtOKzGYCPaCzqEYsG1O+UaB
         tdONA8OQxRNKOh8IepRhRCk4ww6m8bk/JzsAidg+Dcx5hdat9Fer0CYH9UJs6R40/R3L
         /s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848262; x=1757453062;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctCQQe8xMPTdhD2y8+e8frNhv5BnY1zrZjKG8v0F/6s=;
        b=vX99LvGI4TTFfHvO1OMOm0L3FqKc9h9pnNAJ6KtO6rErXKUxrIBx00o0LLRsPrRsPl
         mEz+OTYorrHevMM9fWFoIm/5dY9eWsBbbFDgemvTWP/8HfugvuvJRdJ40Gm0Y0gBvLIj
         ysw2jWFOnKTyJPlTip/LctBpbdy4MVPmtTCjC5cbki9t0zplQ+I7G97KDWhiupE69MZc
         cg99tJDLNp1ZiED4CJkqoew2THUnfksUNPZ46QoaWQLM//IzcTyUkWUL6tg0iRtY9bcq
         26/aKlRYvCJEwe1OEJRsJnPP4Y63izeX6b3RI97ywAZC/35tazBoBlLAg7P/4oSHO0AQ
         gCcg==
X-Forwarded-Encrypted: i=1; AJvYcCWVioax83OpDcXL+FAYErpOAgfqFJ/vO8UD/ihbZPMg0oY+01xbO+kYLFMQF2qn4ttwIa1PH44rVGw=@vger.kernel.org, AJvYcCXARYCi2wO8JWoTBIuFUrbAjFz/pacPv6eOLYLbiv8IW9lTzLEB8uD3uK6ucBn/nynlmWlfiBknLSuQ4xQmtw==@vger.kernel.org, AJvYcCXB2HbUqnOdmI2YtXqjHw0VK3JLiUjKuuKttmZUk6LM7kWtwTWufVyQ0Py5IPsWvNAUPYNZh4vLMeDx@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDwhud/GwFq6yY31wY83QFO3uXlRXEmTZVfhSkJWcKcSlrdHr
	IHpbmwzYCYPVAfLsxk36b0v4NGCBkDiPm56xxeoEYtFXlDQ9uqBZWtffVvUiwcLnh3kpVNeBELM
	totJ2TSAeHINo8Q2GBPExIK994Y6LsXaRsjUw
X-Gm-Gg: ASbGncs9AbzKEm0occZpEco9NWrv9lmU51tqxaKphgI6BiW4VPIdx6hRpoNl52IB1Yo
	mxydxz4nvMx3dKoePBbOdbxBa6R7k0uBzExOMWCTUFf2zc6E7iT2tGb9XkS/2VwvEhj71BpZHJp
	Bxm66Yn0QuFnpZ+4UhQJ3j9cmN6MdEIZcEyQiYxMhXC1kNJcsPhm7UHHqEVEaXDjVymUsmqWWp8
	EhvhY1/
X-Google-Smtp-Source: AGHT+IHO4yZd+l6QbE05WzNI8lFc/7IgGSFcyraONIe9p4gsK6xt1x12pEjpIcJ81c2/R4594+5RwwtORgDgg9oowdQ=
X-Received: by 2002:a05:622a:594:b0:4ab:63f7:9a80 with SMTP id
 d75a77b69052e-4b31d844926mr169420101cf.13.1756848262114; Tue, 02 Sep 2025
 14:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com> <aLJZv5L6q0FH5F8a@debian>
In-Reply-To: <aLJZv5L6q0FH5F8a@debian>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:24:11 -0700
X-Gm-Features: Ac12FXwMlAwgMq0GxN84xQr2p6Ion3rYFLU52dRfL8taTTCzOhZc0nIr_9YrJL4
Message-ID: <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org, miklos@szeredi.hu, 
	hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:54=E2=80=AFPM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Joanne,
>
> On Fri, Aug 29, 2025 at 04:56:24PM -0700, Joanne Koong wrote:
> > Add a void *private arg for read and readahead which filesystems that
> > pass in custom read callbacks can use. Stash this in the existing
> > private field in the iomap_iter.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  block/fops.c           | 4 ++--
> >  fs/erofs/data.c        | 4 ++--
> >  fs/gfs2/aops.c         | 4 ++--
> >  fs/iomap/buffered-io.c | 8 ++++++--
> >  fs/xfs/xfs_aops.c      | 4 ++--
> >  fs/zonefs/file.c       | 4 ++--
> >  include/linux/iomap.h  | 4 ++--
> >  7 files changed, 18 insertions(+), 14 deletions(-)
> >
>
> ...
>
> >  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> > -             const struct iomap_read_ops *read_ops)
> > +             const struct iomap_read_ops *read_ops, void *private)
> >  {
> >       struct iomap_iter iter =3D {
> >               .inode          =3D folio->mapping->host,
> >               .pos            =3D folio_pos(folio),
> >               .len            =3D folio_size(folio),
> > +             .private        =3D private,
> >       };
>
> Will this whole work be landed for v6.18?
>
> If not, may I ask if this patch can be shifted advance in this
> patchset for applying separately (I tried but no luck).
>
> Because I also need some similar approach for EROFS iomap page
> cache sharing feature since EROFS uncompressed I/Os go through
> iomap and extra information needs a proper way to pass down to
> iomap_{begin,end} with extra pointer `.private` too.

Hi Gao,

I'm not sure whether this will be landed for v6.18 but I'm happy to
shift this patch to the beginning of the patchset for applying
separately.

Thanks,
Joanne
>
> Thanks,
> Gao Xiang

