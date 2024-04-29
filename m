Return-Path: <linux-fsdevel+bounces-18182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293388B61F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC421F25243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A713AD3E;
	Mon, 29 Apr 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbI2AEXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07A12B73;
	Mon, 29 Apr 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418551; cv=none; b=GlOIVpjHpfLwAJZ237mj6OZN+dDu4rmCKi+GUtbdIgDdNcYyJzjmHzqk1cIvaYaGuZQjEMgSj8zSmoHWUy2dTeeGtUQyw1CPo3dKLayxTMwzrD1ddm3z2oGU8T6BxH3acoFIaa/Vd7dItchJjRjsCUrw9TQMZbBg90IFSo+Fz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418551; c=relaxed/simple;
	bh=6/2fDYkZ0Fc/sJSvHR4r/NMjtwcjsKhDUHRFLAmNtSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVtDbaA7FJJpdNLnF2zERXkU1VFcD2/Zmjv78YSlXEH9kwdgm7erf7CP+Wa1hEmrUPNQ6KHZFP+vbuCDvqmuofAZVROR5xis+yV7QYT8+fIuzS5/I8C6zGIqhb7KiUTgx1qp0nYZfWh/l3adVLO4tIizGLt0fYrkATa7AHI+bH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbI2AEXd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso14139841fa.2;
        Mon, 29 Apr 2024 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418548; x=1715023348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpd1WYildkuoLom26860P+BikCx3lu1sKsq7QDlDPG8=;
        b=QbI2AEXdTTDJQB662zdIT1aekFHJfEt14OcrX2kZOv0gw1Ud01Ziz3SalF24haOlrD
         Tr8icVrTMUs/6anFU1xd79it5Xvu+bNtzkIwNxa932qHaqJ/bJkc1ga9TBGixl7l4zk2
         xHEpSHMvbMvPNzPvh43d49hYzrIjrowKxvDux7DmHDiTc8T3VuaG5fGdkje5qvkTmaOJ
         U/4Zm0m9D6kK9NBxvYAFku74mDYhHLZRKwCMFod9sP/5OvHmT4NiLLDh1IyxOGGcSoZV
         lvNVjqaYIWw8g1BFkmjL7cqscEYqBF/ZrUd/dcFVA/N0a92do3mBm2PwXlt0YxyIYRBv
         Wlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418548; x=1715023348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpd1WYildkuoLom26860P+BikCx3lu1sKsq7QDlDPG8=;
        b=g2ELdxRPQQOldc+9tl49txyWOA/yp/AWCthINvOSZaGO43D5fEcXJZ/SLU3sIC/ume
         MHh5/zat8UTndih5KheO9+Q02yKowjuWfsqqlz1OnVRyBPJP7/OTPRh2guCEB7VNgdwX
         f4BSyRMjJg99LQBBdi5KyGGRBkfp7dmurPgEgck5d2ZzZ8SiUDpSVy6r80aY868z0EXt
         nqPLjS6ejTGSL1rjZXyPJ4pccOZQ/yempJD/niSlBD3/jL4+YrAW1c1pRsEhylY7dUov
         MEfPfAmcofIMiNvGjwMxIOpx4XuMu3R0n8jWmV7ErDZxuXLl/VZu2jeCobN2+rANP/bv
         LM/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9XNRoZ2ew52jmZplaxDNG5ldpMIW6nAQ9Gwse+qu/W3dieaN+V+jFUbkj+jxt7pGEvRr8ZQm1T16i2RmEWxvtnQGBOXXO0iAX6bjr1aGfpHUxNzFK7FjQ5Wiali2dlH/m2JvOlcB5A2zEK91gAlhL4bIP/tuGFDDS8a9Rt7ZuNvfR24fMkLBf
X-Gm-Message-State: AOJu0Yy9mzOovZcdcq260h9QQdlzKXo6QAfyZxwocNEy0tktqa4eWS3Z
	tZvYeYxYW9mr84NF/uqUbyez4fqypTh3iXQDksikrpJuFZmRwjBj8bfNUGREgmMoIE92tWYpmRj
	7qKzFdy8F4N3PX4wfeDRbFDtL6F4=
X-Google-Smtp-Source: AGHT+IGSowF/+xWsJ96Y/dHBc0kV+WSElRsdFJhZmSTk9Dz1YbSkQSIgU2LDwJkdHchcBZki+qVTxZok5w4qnCfrVlQ=
X-Received: by 2002:a2e:b6d1:0:b0:2d6:e2aa:6801 with SMTP id
 m17-20020a2eb6d1000000b002d6e2aa6801mr6798806ljo.46.1714418547561; Mon, 29
 Apr 2024 12:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429190500.30979-3-ryncsn@gmail.com>
 <Zi_xeKUSD6C8TNYK@casper.infradead.org>
In-Reply-To: <Zi_xeKUSD6C8TNYK@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 03:22:10 +0800
Message-ID: <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:14=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > page_index is only for mixed usage of page cache and swap cache, for
> > pure page cache usage, the caller can just use page->index instead.
> >
> > It can't be a swap cache page here (being part of buffer head),
> > so just drop it, also convert it to use folio.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: linux-nilfs@vger.kernel.org
> > ---
> >  fs/nilfs2/bmap.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > index 383f0afa2cea..f4e5df0cd720 100644
> > --- a/fs/nilfs2/bmap.c
> > +++ b/fs/nilfs2/bmap.c
> > @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bm=
ap *bmap,
> >       struct buffer_head *pbh;
> >       __u64 key;
> >
> > -     key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > -                                      bmap->b_inode->i_blkbits);
> > -     for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D pbh->=
b_this_page)
> > +     key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkb=
its);
> > +     for (pbh =3D folio_buffers(bh->b_folio); pbh !=3D bh; pbh =3D pbh=
->b_this_page)
> >               key++;
> >
> >       return key;
>
> Why isn't this entire function simply:
>
>         return bh->b_blocknr;
>

Nice idea, I didn't plan for extra clean up and test for fs code, but
this might be OK to have, will check it.

