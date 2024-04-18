Return-Path: <linux-fsdevel+bounces-17237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFD8A971F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC0284551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79A15B96A;
	Thu, 18 Apr 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3MNcWQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1315AD8E;
	Thu, 18 Apr 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435556; cv=none; b=hkYV8Q6QcaABz8KNeT5cdghDLhuULlHV0KzQdGkB6Qu0fu7+RY+cJPOYmvHrO2e7qBuoe/BNtcdyKVzrFEWQ0mVnqcyTAPCznnCDCO3zrB6gqFqln4vUhFV2C47gfp1MviW7KapkRYFdlQzPJzbmuTkFC9psqz9vvhuO2QGfwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435556; c=relaxed/simple;
	bh=VL6pJSQmGCfJDVOYa1cGphoXn4BaHMl8XQjHe6z0SE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkaPwxQn4dnApK3/IiAK3QfRaF/1M8ZW78gjUzT2HyWIoYx4fR4SQqOZUcvSOA9WrEog97L3SNRLdiSMqKI8G01ftebutR2KXVO8psz1+IaWj7zh8bDeqVEr27OxxG1PSFpYVEyaUTC6uGXKfnL6/kOYV3Is/0BtlgpxiSOsPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3MNcWQS; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dac92abe71so179181e0c.2;
        Thu, 18 Apr 2024 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713435554; x=1714040354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QuOPPA02NXP13o7JH32iH/XYg33BypsERiunyF7/0U=;
        b=Z3MNcWQS7uQZhyRM/fbKnZX7Js9mX7nCX2zyPrL+AKu6aLeC7a0V0A8xz2I8lpzzdn
         fnzyn11LBxvwCMy8DXP1wND7b7WbHodOHDFlWDeolZ7cZy2okhmuFczGUMq/p8hf1aOn
         0hvzs+xEnP2JgBVIsiGcE5CSZL1U1wqBd7ngQwPwWGbLokZ/0HNGCiSmcV8/ch9T9A/s
         RbqqzCw/ltdo4KoplEPfn/dIPmOdjw2MAhdqrbuXLHb8gP1pWpKApIwZ0lYHTHWeOETk
         gTht+EVMQdZmIFyyIT4VAXWuPTCrp0RW/IG3S89Fx+H0ePdVuD1k9ks5wEI0Dvw+EWSZ
         A78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435554; x=1714040354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QuOPPA02NXP13o7JH32iH/XYg33BypsERiunyF7/0U=;
        b=qAWk8FdSPdhyQsRR3Jk3N/q9sU5xlX9Mk/U+UFhyezTtIylvacQ0+HHEBzTCb3Rq/w
         wMlXE7Y+R6m50RzD7ntN6RpnoIbrPgEVBWECWjvO9+wtADWfAep4smh8h++GPpLW9Yno
         W8+ibU92xg+QgArThZmJPTZLXR3K9rYQwhbhDgZKzbZq78NDGdiveJ1MDyoXPglw3Puk
         NoMPs8M1j5wCqngB8wcq1VYAsLPcyCV8yaiLSs6vBL1OR/2E7vJ7qrjH/NJfMGEGFJAz
         99s7mojCY55zsYxrjsEv7zUUAkMXtnVCGIsbtUrUI6mnxjFNI998/wKoL7g2Q5OyhKtq
         sdnw==
X-Forwarded-Encrypted: i=1; AJvYcCWIS2ioyk6+85frfLm77fvSvqvoLMreSA6FlKWp4kmXJMFCwzLOcE2jF3o3K+ZcB3qvW4ex0n3EfwUgMXneIrUMRFfrf52v3f2dg6zvu8L7XqLsZlzVIMc+vuDJVH7Nzh+jlbf5rHVRZOki3Q==
X-Gm-Message-State: AOJu0YyRusVff8by/gIsBv2ExVjhPA5iMnNwYF03NCon22NyXrH0KO5R
	liwr6MjzZ8zpuZpwB3cSIXsY3uI89eHSpjZWxGefvyItHoXcZUsqOnvHNYntbyVMwZJQdqKRqZT
	TsFsTtLsJokbDTjRgp16gI8vRF80=
X-Google-Smtp-Source: AGHT+IGMflGHigU8Eg0vQ4TNMTAXYcW6h8YOwebe7rJ8EymYG4DHBz561WN3t+D6I+iM3orlfSSM2gPpEHnrOBhEBfY=
X-Received: by 2002:a05:6122:550:b0:4c0:9ed8:57b3 with SMTP id
 y16-20020a056122055000b004c09ed857b3mr2912649vko.1.1713435554013; Thu, 18 Apr
 2024 03:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-8-ryncsn@gmail.com>
 <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com> <CAMgjq7Am+5ftvAW4X2xOhAZ+zotSR8gD8oG+_CV=pJvsqy2Oyw@mail.gmail.com>
In-Reply-To: <CAMgjq7Am+5ftvAW4X2xOhAZ+zotSR8gD8oG+_CV=pJvsqy2Oyw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 22:19:02 +1200
Message-ID: <CAGsJ_4zVH+MtB1X4J7X9Gk9c1bg_BNGKbg7viBXDKKKO8TO4EQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: drop page_index/page_file_offset and convert swap
 helpers to use folio
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Apr 18, 2024 at 9:55=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Apr 18, 2024 at 4:12=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > When applied on swap cache pages, page_index / page_file_offset was u=
sed
> > > to retrieve the swap cache index or swap file offset of a page, and t=
hey
> > > have their folio equivalence version: folio_index / folio_file_pos.
> > >
> > > We have eliminated all users for page_index / page_file_offset, every=
thing
> > > is using folio_index / folio_file_pos now, so remove the old helpers.
> > >
> > > Then convert the implementation of folio_index / folio_file_pos to
> > > to use folio natively.
> > >
> > > After this commit, all users that might encounter mixed usage of swap
> > > cache and page cache will only use following two helpers:
> > >
> > > folio_index (calls __folio_swap_cache_index)
> > > folio_file_pos (calls __folio_swap_file_pos)
> > >
> > > The offset in swap file and index in swap cache is still basically th=
e
> > > same thing at this moment, but will be different in following commits=
.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > Hi Kairui, thanks !
> >
> > I also find it rather odd that folio_file_page() is utilized for both
> > swp and file.
> >
> > mm/memory.c <<do_swap_page>>
> >              page =3D folio_file_page(folio, swp_offset(entry));
> > mm/swap_state.c <<swapin_readahead>>
> >              return folio_file_page(folio, swp_offset(entry));
> > mm/swapfile.c <<unuse_pte>>
> >              page =3D folio_file_page(folio, swp_offset(entry));
> >
> > Do you believe it's worthwhile to tidy up?
> >
>
> Hi Barry,
>
> I'm not sure about this. Using folio_file_page doesn't look too bad,
> and it will be gone once we convert them to always use folio, this
> shouldn't take too long.

HI Kairui,
I am not quite sure this is going to be quite soon. our swap-in large
folios refault still have corner cases which can't map large folios even
we hit large folios in swapcache [1].
personally, i feel do_swap_page() isn't handling file, and those pages
are anon but not file.  so a separate helper taking folio and entry as
arguments seem more readable as Chris even wants to remove
the assumption large folios have been to swapped to contiguous
swap offsets. anyway, it is just me :-=EF=BC=89

[1] https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.=
com/

