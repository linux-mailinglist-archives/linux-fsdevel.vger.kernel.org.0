Return-Path: <linux-fsdevel+bounces-17573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324638AFE15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4621F2407B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18050101F2;
	Wed, 24 Apr 2024 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAujAL+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF5101EC;
	Wed, 24 Apr 2024 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923857; cv=none; b=H0hyVq0gCiAKWDoCrtj6ZXMuVFuLDcDmOrInM18MHc5xJeeUtkEZb9FUT8+m3qP9ThgDAuTbYag999cAe3VlJT/Gv4n7lWeQOphhTTPJnFYnWOSItaFwQCBGejPaPLuIyUzu/3nJRWUPjqUnQyTxC6l/MDPVMfXPOhSTfFE6LVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923857; c=relaxed/simple;
	bh=yRXp++eZDtbM35ie9Tz8g6gaborCB6GRXR9pSFU8RHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8no02Y1w9acN/V/GhVGRsGQqLQxczdp9axrU1pb1Z6jMU4yTxYcZem31fU5bc5Mayx9POvEvPEFWosGGq6qDYtd1o83bM8vCxEF5EGvhwLDWVwnN1QZZIsDWTq7PqMHNlB6uegFK0dzOttF3h7USePqPbEkhNF3c59WrfQHmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAujAL+q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dde561f852so23195521fa.2;
        Tue, 23 Apr 2024 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713923854; x=1714528654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozl4eR2gI7UeFBtqjfRipXEMqkSU7RXdrGoXvouiIDU=;
        b=XAujAL+qZy2nBYSt1HKw4D1V1r2zRlV1TI30ij1qSp7D2U24kQ3Pi314lPbOdoTsna
         ew16lEbfKSDCV6hwPfOK2DCT8B0hj572+Vh8+fTTRkgJaQREVkN8MvHiNrf9NX+lpGM2
         7D9Zg2pJ+yELjXcWL3JZpV+rYE7KL6SURqbYVFCIj2fOf8DikmasfdPpqkt+G1HC1ZPt
         kUTwFENKC13WIRVx8cwdVyiJVgumOWVstItcv0WP/zvy7Kmena8/xV4eFlgE8iqN+nFt
         2+8UZp42mm42h+w5JXfYhPiL7DU/uw/Se3Yu70kMZV8HPpbBD61j+a+3aQlaDzCb0KSJ
         cnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713923854; x=1714528654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozl4eR2gI7UeFBtqjfRipXEMqkSU7RXdrGoXvouiIDU=;
        b=AH7dKDKI0Q4vLtRNrHjLfWi1PVJCuPVdzIDHckYsAdDbb1+GPn0LZD2Vtn/63e21D1
         0ldpiB+BkofGiPTxtuBYebhHYEBnG5sEkhqp7BMOt4+q8HykV4cign3J0e6EyuIVh8lc
         GtA0ArTtBW6V5X+KI5777rQiQEWRRooSHb4fGWBUSN9SNl7506MBpKV1lsWGB+4Z+Uf0
         1KFLDUFf9MaQrtXj4r5/e/n3olBpq+LN07BZU3RcOHWYOptEWLYF1IoVUxfWdMVy0Hx5
         fC6Tn6G9RgcsafChh+0H/ha7vSDwXJ8/tqwvHArtbGyLXGqrewqcPLaEvG23tn06ncEX
         /i9g==
X-Forwarded-Encrypted: i=1; AJvYcCVMTiw/GVDUT+LtTlihmkoZMp2WkY4DrJX7HYQmZKR3z4NXdhOiQlQuzeQShJjIL94gP5lYzqFhSDvjaqMRit5ZBkzYmRY7cqySLzS/Ut8Lcpgt3lrSWjO7S60qXQHT/b4m4+BdwSDVVwInMkACMfEQd7z01kewvTDa6/2NlI1mlabKrxKW030E
X-Gm-Message-State: AOJu0Ywh1n/pFHoH4LW7BldgsrNm4vHSXxcvMOxJ9K37CggqECe5GXm1
	ZqKdk/901tkXGmKzVmc2FQFJ0Z7u/la+YvVQ08++rAHerbdhIDtVZ13xpDBSSA4jHqqt+BMKUpg
	VfGcRKMxAxd9s87qYZrDJj6npyYg=
X-Google-Smtp-Source: AGHT+IE2q9I+k7WPfudS5N9N5JzKqwEH0Sq10D35ySO0S7T9E8Xrg9ZkxX5/n2tHqivH2mSvu0rJufvbTUgleCsPYEA=
X-Received: by 2002:a2e:b018:0:b0:2dc:de74:dfd6 with SMTP id
 y24-20020a2eb018000000b002dcde74dfd6mr501225ljk.10.1713923853805; Tue, 23 Apr
 2024 18:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423170339.54131-1-ryncsn@gmail.com> <20240423170339.54131-3-ryncsn@gmail.com>
 <CAKFNMomTmSJ=QTjTps=v9WkuEo112AT3DmEum-kNGv6pm6nghA@mail.gmail.com>
In-Reply-To: <CAKFNMomTmSJ=QTjTps=v9WkuEo112AT3DmEum-kNGv6pm6nghA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 24 Apr 2024 09:57:15 +0800
Message-ID: <CAMgjq7DiFX7JMyygy2XQS9UXCximfXnK68naaKe3V3epGoMXAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] nilfs2: drop usage of page_index
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

On Wed, Apr 24, 2024 at 2:51=E2=80=AFAM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Wed, Apr 24, 2024 at 2:04=E2=80=AFAM Kairui Song wrote:
> >
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
> >  fs/nilfs2/bmap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > index 383f0afa2cea..9f561afe864f 100644
> > --- a/fs/nilfs2/bmap.c
> > +++ b/fs/nilfs2/bmap.c
> > @@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bm=
ap *bmap,
> >         struct buffer_head *pbh;
> >         __u64 key;
> >
> > -       key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > -                                        bmap->b_inode->i_blkbits);
> > +       key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_bl=
kbits);
> >         for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D pbh=
->b_this_page)
> >                 key++;
>
> This conversion mixes the use of page and folio within the function.
> Would you like to take the opportunity to convert
> "page_buffers(bh->b_page)" to "folio_buffers(bh->b_folio)" as well?

OK, will update this part.

