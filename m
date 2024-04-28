Return-Path: <linux-fsdevel+bounces-18017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68A8B4D4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C458B20F80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964407352B;
	Sun, 28 Apr 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGGPJnS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836154087F;
	Sun, 28 Apr 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326370; cv=none; b=Xkmx1HcuBq8DqpYhC2a8HuebvvvefYDBYmRIfDbj4cxVMH4iZXefdid1DmjoWZjCZPGwKRzGF+H+XL9irQTWjxk1j9aDvkUFZZ1VQNQ7k5undvAve8r8vJEObBwgjsFGlp36mcXGILbfavQxOsEOXCEVumhydrojWcJoKirZ4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326370; c=relaxed/simple;
	bh=MxmbqoXt90QmaA54xJmZ52kaA7d5rIlfaRc/meZ8AW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvI3QibyG3fvbKeN/1KN6Q+0uY3otDljYYwPvBIp/VoVmCIhkgRZKU2RpLigk+z6k1/8YJH7yIPbTdv7NjFlU5EWqONj/zC+nXa0ziAyfjqfzOMq/Hk9ds4PsAQmN9y77hF+B5wrfesmx8uI62o596v1LVMXh0V+zfMIJJMO6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGGPJnS1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso51294621fa.1;
        Sun, 28 Apr 2024 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714326367; x=1714931167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urp8+z3N4hHCle9QkhlH7xL+m+5t13Mh2RYPMaU6QnY=;
        b=YGGPJnS1NVisRSVV65fcSBu7skc0XLVw02ShU7bSvS0e6A4kVmrCvYMaq9hJHU3NVy
         LjuBycr4ZWM3rZkm9l0nO8fFIb+z0xeYSeueqMMDXjpNp2zyIWFz1eDppB6ZiWGtdwcV
         E98ekrs+pM4q6OZvTXoQw0fJ1qvnoVELVQK3RQkmbksJ9O2W21hwHO52dNY9pgcbexln
         4mg+vK1UPJBqo5yTuogfsmxBshrmw8FOD4blAemtIQMA9qTNbEnMnHZKKs4aY2UT8mKy
         Y/RYE/dmlnzpBK2WAQTdGzEZoVWsx0RpyyfPBeHv4EcqG4Cwt9CJPWc4hnNdFr1+Iz5B
         fYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714326367; x=1714931167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urp8+z3N4hHCle9QkhlH7xL+m+5t13Mh2RYPMaU6QnY=;
        b=P3ofcQGwDPpYL9zMH0/HZ/v1qq9C42Q6QcnbN+eFXUS0Pq4rQDz6oQy6wLwEE2wFk5
         PGisorGEx//TxUe9/UHyK1g4EQ2VkE2F2jNEEVgsmRB33Yni5I+qw51zUrxbns3l5/dz
         WyFpHnJ4XZIzP28csVU4EPNx3GEUMwX2uaxos9aJGg65OSaniJRZUSzagpi3JPsScC3X
         mQk91j9OXmuGcQYFTyk4QyWJGDs0rJP5OPniJHgST6Hq/QnLUjT4pNxF9i/7sz2ij61d
         pOSnvL7TDm7Or9ll6aJor5c6qWL3WNks6AQl6BwEqOgNK4wCcwV1dAnqb1QjM+z0uch/
         hx4g==
X-Forwarded-Encrypted: i=1; AJvYcCUyvy9wNYAJhl96Hvgu/cLZKL7eASD9TB2JNEediLretj60dLmzJJg/Oxm04wxbfdKv9ArOTRutVhhpBG1AM7rcJThFEw/PvYxSOfJkdMfFaxdU2ppqe6RAsSLgicb0erdR6kpOgiCTUdkd2g==
X-Gm-Message-State: AOJu0YzRmeITnfhqY8omWIVeQzk3Sx5FFICRcwmjyrrk4UUQZtQC8Ia2
	DHcX3qjK/71sPu0rjo8nQ/rlowW4FzsSeHLWl2pqH+ESq+cI45+Efw/vjmcxRBM9xAUoWQHxOeM
	Qkgtj1oKcYQbp8LfeAoAxiim28rU=
X-Google-Smtp-Source: AGHT+IF0hGkqlSiNpnCt1/7PlPxOXq6YivEUUbJxPWUGFtsMDlHgo9AM7RRFS9D7lB6xZ5hH4/+Ib+UmmeONZcU/zkA=
X-Received: by 2002:a2e:914c:0:b0:2df:b42:84fc with SMTP id
 q12-20020a2e914c000000b002df0b4284fcmr2778845ljg.10.1714326366516; Sun, 28
 Apr 2024 10:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zico_U_i5ZQu9a1N@casper.infradead.org> <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com> <CAMgjq7AD=n0T8C=pn_NM2nr-njNKXOxLh49GRrnP0ugGvuATcA@mail.gmail.com>
In-Reply-To: <CAMgjq7AD=n0T8C=pn_NM2nr-njNKXOxLh49GRrnP0ugGvuATcA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 29 Apr 2024 01:45:49 +0800
Message-ID: <CAMgjq7Buvn4f4U8uwpZB3e-rWgCcpvfd5uopgUqQxrVcgGcEMQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Apr 27, 2024 at 7:16=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Ying,
> >
> > On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> > >
> > > Hi, Matthew,
> > >
> > > Matthew Wilcox <willy@infradead.org> writes:
> > >
> > > > On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
> > > >> Is it possible to add "start_offset" support in xarray, so "index"
> > > >> will subtract "start_offset" before looking up / inserting?
> > > >
> > > > We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
> > > > XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We c=
ould
> > > > generalise it, but then we'd have to store that somewhere and there=
's
> > > > no obvious good place to store it that wouldn't enlarge struct xarr=
ay,
> > > > which I'd be reluctant to do.
> > > >
> > > >> Is it possible to use multiple range locks to protect one xarray t=
o
> > > >> improve the lock scalability?  This is why we have multiple "struc=
t
> > > >> address_space" for one swap device.  And, we may have same lock
> > > >> contention issue for large files too.
> > > >
> > > > It's something I've considered.  The issue is search marks.  If we =
delete
> > > > an entry, we may have to walk all the way up the xarray clearing bi=
ts as
> > > > we go and I'd rather not grab a lock at each level.  There's a conv=
enient
> > > > 4 byte hole between nr_values and parent where we could put it.
> > > >
> > > > Oh, another issue is that we use i_pages.xa_lock to synchronise
> > > > address_space.nrpages, so I'm not sure that a per-node lock will he=
lp.
> > >
> > > Thanks for looking at this.
> > >
> > > > But I'm conscious that there are workloads which show contention on
> > > > xa_lock as their limiting factor, so I'm open to ideas to improve a=
ll
> > > > these things.
> > >
> > > I have no idea so far because my very limited knowledge about xarray.
> >
> > For the swap file usage, I have been considering an idea to remove the
> > index part of the xarray from swap cache. Swap cache is different from
> > file cache in a few aspects.
> > For one if we want to have a folio equivalent of "large swap entry".
> > Then the natural alignment of those swap offset on does not make
> > sense. Ideally we should be able to write the folio to un-aligned swap
> > file locations.
> >
>
> Hi Chris,
>
> This sound interesting, I have a few questions though...
>
> Are you suggesting we handle swap on file and swap on device
> differently? Swap on file is much less frequently used than swap on
> device I think.
>
> And what do you mean "index part of the xarray"? If we need a cache,
> xarray still seems one of the best choices to hold the content.
>
> > The other aspect for swap files is that, we already have different
> > data structures organized around swap offset, swap_map and
> > swap_cgroup. If we group the swap related data structure together. We
> > can add a pointer to a union of folio or a shadow swap entry. We can
> > use atomic updates on the swap struct member or breakdown the access
> > lock by ranges just like swap cluster does.

Oh, and BTW I'm also trying to breakdown the swap address space range
(from 64M to 16M, SWAP_ADDRESS_SPACE_SHIFT from 14 to
12). It's a simple approach, but the coupling and increased memory
usage of address_space structure makes the performance go into
regression (about -2% for worst real world workload). I found this
part very performance sensitive, so basically I'm not making much
progress for the future items I mentioned in this cover letter. New
ideas could be very helpful!

> >
> > I want to discuss those ideas in the upcoming LSF/MM meet up as well.
>
> Looking forward to it!
>
> >
> > Chris

