Return-Path: <linux-fsdevel+bounces-18183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12F8B61FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39381F23A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65E13B28A;
	Mon, 29 Apr 2024 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZFWi/Nd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBA12B73;
	Mon, 29 Apr 2024 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418941; cv=none; b=Q7cYTMB/U+uxrlM7BBww5AkacYYFR1gzvFdZYgLrD9TahGEujjoEUqmpFn7DpZa6PidOozdN3sToZoqrfFvr+IOJgGiom7iF97jtQxZtDqFlK2Ap0tpw7GOkRfsh+hhIsKmdz2vuAReCxB0jm3j2o6qHW/VEiwcRwTPMztz8UK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418941; c=relaxed/simple;
	bh=NWeoDDKOD67boHpn0fRJjHGzYo37DLBDTAZnh/t/pk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csp8bdB8yuPdTHO30jOPqh762P02rR/yFR3zAVgJQmW+I9UX6qFJJfzTH8cyHQfCch6z8CPTpjH1jHPUyDP/3MZXlEAg158bbu0KhPs1A+AqUOcDABoeqb0Rf8G9BBt3xfjVAo0SO4B+dwY9OqIS58nIkQmd1PD9swQT3uBwMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZFWi/Nd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso755566276.3;
        Mon, 29 Apr 2024 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418939; x=1715023739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Id47GDLJX/lNIbckbHqS7aCM9UEs1NMxnMsPlIfT5U=;
        b=fZFWi/NdoVD2z/xGb7zN1/Q6tLuFHw2uylWPG/RUnB+xJawE7BjIGKIFfGBZIUVefs
         6Dh2os2+LcyyMDMDz1cSgtsj5UG8yGZ4CnxTMrBButQIC7GtG2v7hE+m2/k1PFOB+BWX
         39WjCxc1j/FaelGYFTc0S9eOB1kPYrbqgMK/tQXASxSCznSp3opRaNsKDq8xgBt5IIBW
         PTaKeeXuX1f8ldGhJgjLUMt1fPVgtg1etRgE8PxObuZJs05+fj24cGOYxidqNs+3+uF0
         9512wUT+JFuXmdSeSwD6Y6J/a7odU6x+qeAOvCrKG0GRj2QZXI0dFXsuY0BwLOTqdNnL
         QMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418939; x=1715023739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Id47GDLJX/lNIbckbHqS7aCM9UEs1NMxnMsPlIfT5U=;
        b=ZL3xL4FddNfJ2ci5lrSXwRMM/jYRp4Sy3m7npFE3o2ntycZ+qehbDVIjyLuAsMLID6
         LibzIDOkMTDMdaBN+5M7j5FMi3eGViwWpM95bLVf6kFnWXUP/9tcuF3IruTGLcdOatjH
         6Ytf57toODnwZWNMWFMyPLIf71/zTmWqb1QC3+VDppgT6cEt9Bnx2J/okc4dsfJsYMAd
         4VeoNUsqKUIfdlOd0BF/ucqVwjS0LMb/QGgZCmTXjJOw2teUE+SA9SucpB1QBeSQM8EA
         maPTq5L4VRpGhJaY5fdnIC/OvEwYCMxDXyRpzrAnC/gP8voWN+I8EC0gwwlWF65OE1Ez
         zkaA==
X-Forwarded-Encrypted: i=1; AJvYcCVCvowXLG+Ncua2y2VUxJ4tTNV23kHrUua7bQxfaRjs+Eu3xmnkkERS15kTzPABgzQfhwjd5pDnS6Py7tCy8f5yZVnEV8qgn/JX/xVbEtyj59Ke5AlgGEZCmw8NDdfPNUz4x/h3Q4MkbfjR8aA4aUFWQSQ0Ic2LJonqj3TdFM1mJIRflyIjO9db
X-Gm-Message-State: AOJu0YxCBRd3+LYZm154TVkNvedqz13b1jvGYWNUjI6IDc4FyEzMMJ+w
	yCmhNhhHRpK7sAk6lXLzkABktfABL8yuC9Id2d5Cgg1+ldpF34T87GWvLJ4qaOVmuwFXjjI8c72
	hTmT3B5m8VOoymu5Jj0g8doVkRoE=
X-Google-Smtp-Source: AGHT+IGnykyuLXCrJmmx0CN8EyQRfA8e+LNcgun2TNRNAmKdNprludRbilUzZT/X2nWgoMq7eBz6w63uJZ7OvZ8nzOA=
X-Received: by 2002:a25:7587:0:b0:de5:8427:d669 with SMTP id
 q129-20020a257587000000b00de58427d669mr8497299ybc.53.1714418939241; Mon, 29
 Apr 2024 12:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429190500.30979-3-ryncsn@gmail.com>
 <Zi_xeKUSD6C8TNYK@casper.infradead.org> <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
In-Reply-To: <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 30 Apr 2024 04:28:41 +0900
Message-ID: <CAKFNMomdPzaF4AL5qHCZovtgdefd3V35D_qFDPoMeXyWCZtzUg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Apr 30, 2024 at 3:14=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > page_index is only for mixed usage of page cache and swap cache, for
> > > pure page cache usage, the caller can just use page->index instead.
> > >
> > > It can't be a swap cache page here (being part of buffer head),
> > > so just drop it, also convert it to use folio.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > Cc: linux-nilfs@vger.kernel.org
> > > ---
> > >  fs/nilfs2/bmap.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > > index 383f0afa2cea..f4e5df0cd720 100644
> > > --- a/fs/nilfs2/bmap.c
> > > +++ b/fs/nilfs2/bmap.c
> > > @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_=
bmap *bmap,
> > >       struct buffer_head *pbh;
> > >       __u64 key;
> > >
> > > -     key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > > -                                      bmap->b_inode->i_blkbits);
> > > -     for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D pbh=
->b_this_page)
> > > +     key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_bl=
kbits);
> > > +     for (pbh =3D folio_buffers(bh->b_folio); pbh !=3D bh; pbh =3D p=
bh->b_this_page)
> > >               key++;
> > >
> > >       return key;
> >
> > Why isn't this entire function simply:
> >
> >         return bh->b_blocknr;
> >
>
> Nice idea, I didn't plan for extra clean up and test for fs code, but
> this might be OK to have, will check it.

Wait a minute.

This function returns a key that corresponds to the cache offset of
the data block, not the disk block number.

Why is returning to bh->b_blocknr an alternative ?
Am I missing something?

Ryusuke Konishi

