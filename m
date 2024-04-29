Return-Path: <linux-fsdevel+bounces-18187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18538B630A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82E82837D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FF14039D;
	Mon, 29 Apr 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgNVBP5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D9128807;
	Mon, 29 Apr 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420905; cv=none; b=UzYksNWyh436jgzoI0KRhs9z2JaeqKakdoDVPbV++JebjN2ZWBlZXJtZCpBsMkiaa2XVMt/137Q6ZIL2pciLIlMllyDO7w1BxyDU8uG8GzxX1RStxwvIh/B7xzDGFsUTGLbJPVNmU7K3ACmV37YRZuQmECsLYZw4c7knt6mzYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420905; c=relaxed/simple;
	bh=OhvfwqbEewNNmLOjBwipzE7KXYAA4WVSdJVmyQX+r18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcjGMiXeLvBVJ0szi0pNb8g8DOdUULMN+p7vTPbyc/9bHQGzGwuTzQ5H8kMIm3zlPwI5H/vEx6c7/l/2/VyBzJYL6kJ3N5dXMFpD2tPa55PD0bXA4gprdu3pVxxF/68Lre7vNY/1IUQlQ18wmrXBtuZySJum78us3/49VVB1aWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgNVBP5A; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so55906711fa.2;
        Mon, 29 Apr 2024 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420902; x=1715025702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt3s+UzBw6kM3wJOvLkf2xGMTIu2IRgPL+I5Y7L6Qrw=;
        b=RgNVBP5AEtc9dpo3i7C68RIYmaPeofBuiSRHjTh4kAt4kr2mEc8nFZoJnwpYCx/fEI
         a8m5f4BAiOk4Gmnvt2vpxEd1cvRHcTxB3IO8aHPkNOa6oP/j5SDJi0kT9yQDxrbAtk84
         qKgK2OVQC3JpHKrHBSv9AzKjlGHZOF6U85tOHMDNCb69ApA0BPG/kjLeYJAAsviYpeXr
         I0Ts1xZ4Jk+oPw2ybrAk2NoWsBJZjoumzMTYs+UxKsQE6absl6prgXnFq/ztOsF+jFxe
         3ITE1GlOZBEMbbZEsue4S9pSd9pva9hjbDekQnZicSxA8CTNGd0jUxfKvk6tpfVYzm6N
         w7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420902; x=1715025702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt3s+UzBw6kM3wJOvLkf2xGMTIu2IRgPL+I5Y7L6Qrw=;
        b=tsKIBdLSIS2jiD/diD3T4dJ1ZM7+dUSBQrW+McsDnZhzTt2N8wEShwlhUR5Zercmqh
         6sRs2240MEAuU65TtAUtKm/32cYqKtotzGy29ot0UDbpqMaFI81UG+WtCYhDyWF6ItbN
         TnfvgDtduMRt2inKS7pL+RNx+2quLptOEwhMFX5BKT44GHhTzblgYER1UZ21JyFehWY1
         woVmYAvXLBsJu0VcrLH50jftGV86tT9+iMkQsTtB8bq1z69v4/DJD38jtDxohGFGKowQ
         IVm78J8dE3TW06S+mRX9mmy/zdhvtKJQs91sqseX5Llo3yNxVl35EKfR3/k7jGtKT+fu
         caZg==
X-Forwarded-Encrypted: i=1; AJvYcCXn1vmY13br0r1/T2TKB2BrqEZVWaPnAeIFYBrRYjh/qXJkbLSqyGtIzPcCPxso38eNd+WiXhOutIgiyuPg25otVDgZ4qA/r450xb/bbFqKHzqCe38Ffmw74XfFAr2SPSXoLxw67ftr7AdX84Z0IoAlR2kTmsRUejEBvmpBa4Yc/Bx+3cjJ8DSz
X-Gm-Message-State: AOJu0Yxfh3HG19bhyis1ZeVSZBe0VMSuIStWLB2jAa+++fEc52jBN1+s
	uLvp6f6hlMhPGdf0WJu934vxRdMpcp56YYqT6Ipy3dl03i8zyltvi/7GPWdR9hhwaavpW/6WFlp
	+vN3zVBjqBU/r5Sl53wetOLsczn8=
X-Google-Smtp-Source: AGHT+IEUwVSZGAkL0NmCiPGfPRW7x955qFnKQc6XQIgknlcmV/FRn4nEWgAGVLy6zxpOCntcK+HxFa6yyP83rfcnZa8=
X-Received: by 2002:a2e:8802:0:b0:2dc:c95f:984d with SMTP id
 x2-20020a2e8802000000b002dcc95f984dmr7214308ljh.5.1714420901889; Mon, 29 Apr
 2024 13:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429190500.30979-3-ryncsn@gmail.com>
 <Zi_xeKUSD6C8TNYK@casper.infradead.org> <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
 <CAKFNMomdPzaF4AL5qHCZovtgdefd3V35D_qFDPoMeXyWCZtzUg@mail.gmail.com> <Zi_3OxP6xKjBWBLO@casper.infradead.org>
In-Reply-To: <Zi_3OxP6xKjBWBLO@casper.infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 30 Apr 2024 05:01:25 +0900
Message-ID: <CAKFNMokDR7oQxDH8WeUeJKm6GLDo54AnByYXxdAWHjiFeGWEwA@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>, Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:38=E2=80=AFAM Matthew Wilcox wrote:
>
> On Tue, Apr 30, 2024 at 04:28:41AM +0900, Ryusuke Konishi wrote:
> > On Tue, Apr 30, 2024 at 4:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Apr 30, 2024 at 3:14=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > page_index is only for mixed usage of page cache and swap cache, =
for
> > > > > pure page cache usage, the caller can just use page->index instea=
d.
> > > > >
> > > > > It can't be a swap cache page here (being part of buffer head),
> > > > > so just drop it, also convert it to use folio.
> > > > >
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > > > Cc: linux-nilfs@vger.kernel.org
> > > > > ---
> > > > >  fs/nilfs2/bmap.c | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > > > > index 383f0afa2cea..f4e5df0cd720 100644
> > > > > --- a/fs/nilfs2/bmap.c
> > > > > +++ b/fs/nilfs2/bmap.c
> > > > > @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct ni=
lfs_bmap *bmap,
> > > > >       struct buffer_head *pbh;
> > > > >       __u64 key;
> > > > >
> > > > > -     key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > > > > -                                      bmap->b_inode->i_blkbits);
> > > > > -     for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D=
 pbh->b_this_page)
> > > > > +     key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->=
i_blkbits);
> > > > > +     for (pbh =3D folio_buffers(bh->b_folio); pbh !=3D bh; pbh =
=3D pbh->b_this_page)
> > > > >               key++;
> > > > >
> > > > >       return key;
> > > >
> > > > Why isn't this entire function simply:
> > > >
> > > >         return bh->b_blocknr;
> > > >
> > >
> > > Nice idea, I didn't plan for extra clean up and test for fs code, but
> > > this might be OK to have, will check it.
> >
> > Wait a minute.
> >
> > This function returns a key that corresponds to the cache offset of
> > the data block, not the disk block number.
> >
> > Why is returning to bh->b_blocknr an alternative ?
> > Am I missing something?
>
> Sorry, I forgot how b_blocknr was used.  What I meant was:
>
>         u64 key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_=
blkbits);
>
>         return key + bh_offset(bh) >> bmap->b_inode->i_blkbits;
>
> The point is to get rid of the loop.  We could simplify this (and make
> it ready for bs>PS) by doing:
>
>         loff_t pos =3D folio_pos(bh->b_folio) + bh_offset(bh);
>         return pos >> bmap->b_inode->i_blkbits;

I see, I understand the idea that it would be better to eliminate the loop.

The above conversion looks fine.
What are you going to do, Kairui ?

Thanks,
Ryusuke Konishi

