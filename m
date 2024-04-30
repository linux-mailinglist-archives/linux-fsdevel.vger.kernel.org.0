Return-Path: <linux-fsdevel+bounces-18371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F28B7B83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8751F22FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B4176FDB;
	Tue, 30 Apr 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex6G+WZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FD174EF8;
	Tue, 30 Apr 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490854; cv=none; b=fxX3M6CVKLLldDo1KAFTFdYldFYsd0pWsLSiLfFPI/joulS3j2lTkUq6Lo/DNv1BoKqS5r5CGtFWUZY5SgazoXgzvUjGMyMa/YbLqvT5QkgivaHK2V4H6h6lqnL48qqRsUBgvNnsZYKCefeSE1ZR3hwvirCuvm5QivhwDeFS4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490854; c=relaxed/simple;
	bh=G2aFg75Ul9Crtdd2fDfTN6nEZKobxn6q24Vr/7Ka/YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0tpx96OGhFFeIh/Uccu3f5io8wCXjAbFf+vjqPvx6Hq21wMfvnFEiVWxkXNDpAzm6d3bIwOtQ9iPT0u/dysaVP2oNBUMXrg+c8wbsb/GuT1WA9/6+1YoVAMU883ekbXDEfXWJURzigt+RKlRatwAnfXPDEQxx38WOCDcEt+bNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex6G+WZF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so63352821fa.0;
        Tue, 30 Apr 2024 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490851; x=1715095651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1HgWwLjoipLTcuV2mY+tWY78vZZqlbVL58B4f0iiu4=;
        b=Ex6G+WZFfD8IybSvygSSSBp5gAiM9pb1wbNNfy+wtSjGXtMX5x/QWOUW2nKL4bhmTV
         fPHF4rWf7L00B/n7V2CfwqsDeeha0Y6tH9F64PYq5nl5D1VKBy7NT31S3P1AADtGKkcv
         87xU3eQrBDg/WN7qoHVcweXth09RIc34U7P6a6GzeMGhUJw9dMcnXM109z1d30m0MdUm
         czxdFPjiAqoCPicn34xCoVyb4lnF7AUK+f0U5zH57GWpRBhIclRXyisKF67qwfHNT0z3
         PIA8GDYofdyBx7PVxkLFuQlwieQv0tLnSX+6sTo1URZx9Ur5i1yILqIPoyX1kRtPCNeK
         fRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490851; x=1715095651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1HgWwLjoipLTcuV2mY+tWY78vZZqlbVL58B4f0iiu4=;
        b=u6OUZOAIZY1G5QsQuycYWZ2RTnbgihl3i6b3WcG2SHdLPenHZUc0ccqLRXrs47E6aP
         XztgDgY03wq2BDqcBPRYAIQI7jO+FCGFFFPHV+Q28irTMECHtwZqfNlE9bflHm+eP95Z
         /wb3RozJr2NkNWCXklsMFJQ5aNuf/OD5eY3AL/hCqnluPLz770X2GGpO/nwwaoKuvU2C
         8c1sbFm1CjvoreQ3fC3Prn1xXy0nD8+GYlPz2gHodjUVOBgGjNhc7xzUgcnjzKoQ86u3
         GjvsMqzG/+SEbEdB6zjOMrh8EgvQmYMz2BAqMpyd0ldW3VscHl8Z68TrX+KPzO74H8ft
         ptuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxdrcM8KjaGBRagSvt7Hh5UPK3AqGd3i0c9UzJIeVKgeMF9ie1ggzlPSPstu/1W+KU0Im5QhhrfmCY6E96PTOGQ36Yzabqs/qa57ecFvG5v+c6McOw+RMyVvzI7Xeb0kgu+yqZ7L3kwgXEZ2iMqIwSmiBny/XW4kZcXNwxPfnaRbc1pCMOCeCD
X-Gm-Message-State: AOJu0YzvRV1XAbhSxT7cwe0lvMRM4kZwSeP+SBCm9OC7f2K1KQrD9zYR
	8deQ72ToA5T3OOAwO/GLwSiUqr5IWWDERXlbkk4gQlBLJ65e8iHhG1L4NAANaSbAhvJNwDeQCkg
	7UEoQrDm85FxX+rhjJpcVkbxVzC0=
X-Google-Smtp-Source: AGHT+IH7pdZicu4uh/ZkHr0Ti6TFgkBfJ9pqAtcJFUfLakRoyEY+RT0Y2F0U8MhrSCG7VjRQg5cnZkXUG29elM5wPDA=
X-Received: by 2002:a2e:9f09:0:b0:2de:48ef:c3ce with SMTP id
 u9-20020a2e9f09000000b002de48efc3cemr23422ljk.49.1714490850543; Tue, 30 Apr
 2024 08:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429190500.30979-3-ryncsn@gmail.com>
 <Zi_xeKUSD6C8TNYK@casper.infradead.org> <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
 <CAKFNMomdPzaF4AL5qHCZovtgdefd3V35D_qFDPoMeXyWCZtzUg@mail.gmail.com>
 <Zi_3OxP6xKjBWBLO@casper.infradead.org> <CAKFNMokDR7oQxDH8WeUeJKm6GLDo54AnByYXxdAWHjiFeGWEwA@mail.gmail.com>
In-Reply-To: <CAKFNMokDR7oQxDH8WeUeJKm6GLDo54AnByYXxdAWHjiFeGWEwA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 23:27:13 +0800
Message-ID: <CAMgjq7D0HwiD-v_HCQWkGNoK2hWzL-B-1u0zRAp9xR6p+HfiUQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:01=E2=80=AFAM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Tue, Apr 30, 2024 at 4:38=E2=80=AFAM Matthew Wilcox wrote:
> >
> > On Tue, Apr 30, 2024 at 04:28:41AM +0900, Ryusuke Konishi wrote:
> > > On Tue, Apr 30, 2024 at 4:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Tue, Apr 30, 2024 at 3:14=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > >
> > > > > > page_index is only for mixed usage of page cache and swap cache=
, for
> > > > > > pure page cache usage, the caller can just use page->index inst=
ead.
> > > > > >
> > > > > > It can't be a swap cache page here (being part of buffer head),
> > > > > > so just drop it, also convert it to use folio.
> > > > > >
> > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > > > > Cc: linux-nilfs@vger.kernel.org
> > > > > > ---
> > > > > >  fs/nilfs2/bmap.c | 5 ++---
> > > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > > > > > index 383f0afa2cea..f4e5df0cd720 100644
> > > > > > --- a/fs/nilfs2/bmap.c
> > > > > > +++ b/fs/nilfs2/bmap.c
> > > > > > @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct =
nilfs_bmap *bmap,
> > > > > >       struct buffer_head *pbh;
> > > > > >       __u64 key;
> > > > > >
> > > > > > -     key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > > > > > -                                      bmap->b_inode->i_blkbits=
);
> > > > > > -     for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =
=3D pbh->b_this_page)
> > > > > > +     key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode=
->i_blkbits);
> > > > > > +     for (pbh =3D folio_buffers(bh->b_folio); pbh !=3D bh; pbh=
 =3D pbh->b_this_page)
> > > > > >               key++;
> > > > > >
> > > > > >       return key;
> > > > >
> > > > > Why isn't this entire function simply:
> > > > >
> > > > >         return bh->b_blocknr;
> > > > >
> > > >
> > > > Nice idea, I didn't plan for extra clean up and test for fs code, b=
ut
> > > > this might be OK to have, will check it.
> > >
> > > Wait a minute.
> > >
> > > This function returns a key that corresponds to the cache offset of
> > > the data block, not the disk block number.
> > >
> > > Why is returning to bh->b_blocknr an alternative ?
> > > Am I missing something?
> >
> > Sorry, I forgot how b_blocknr was used.  What I meant was:
> >
> >         u64 key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->=
i_blkbits);
> >
> >         return key + bh_offset(bh) >> bmap->b_inode->i_blkbits;
> >
> > The point is to get rid of the loop.  We could simplify this (and make
> > it ready for bs>PS) by doing:
> >
> >         loff_t pos =3D folio_pos(bh->b_folio) + bh_offset(bh);
> >         return pos >> bmap->b_inode->i_blkbits;
>
> I see, I understand the idea that it would be better to eliminate the loo=
p.
>
> The above conversion looks fine.
> What are you going to do, Kairui ?

Hi, I'd like to remove the loop as Matthew suggested, that will make
the code cleaner.
I'm not very familiar with this part so I'll check related code first
for double check, won't take long though.

> Thanks,
> Ryusuke Konishi

