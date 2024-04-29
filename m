Return-Path: <linux-fsdevel+bounces-18063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E98B50CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500971F2147A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDD107B6;
	Mon, 29 Apr 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDVQFtHI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF5F9DF;
	Mon, 29 Apr 2024 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369847; cv=none; b=pE6f8OXpyHC7S10gzSToCvXSeSiSm6CyrzQ4XkWO68HC+D8irwRSc1kw6NtrF/VakR6NzBV5XCuN7mOiLRkilPoeFP7OFABIpEtSXVesUqFz9hDSMdJAgPmisjNxoSxrtHafv/PDA8+GbbCo4omRQjJR1MIVik5EoyXR0xNEOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369847; c=relaxed/simple;
	bh=DOYjcOGT2lvFGzzOnztFKgQBfcSNc3I4JqaOJDOA3jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8vYmeg8GBgsovdqbPNg1NTQ4ApuBt4dtpeAVWsaymxqUee/6z1lej6g91WzcqmL0Heo2mneNSKVL9UFpN59CPhuRnv0R+wYtsBnh+j+W7117cDf3xjs6JmIcFIQAHP3gRJxM2rITukHXW7iNLjxT1mtO6i5M+uL2ttTHzHiauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDVQFtHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C9AC4AF1D;
	Mon, 29 Apr 2024 05:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714369847;
	bh=DOYjcOGT2lvFGzzOnztFKgQBfcSNc3I4JqaOJDOA3jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fDVQFtHIL71AwWubiWRpC5V7cVJP+UE8URy1geXOBDV0MEeHBMi8JS/1WT/qM7av7
	 pFgt79/xS7B9NQlz1bu7FBDA6lDitzKg2x+GAYAv7oHjDrrlUSluBZVoD53ddRmYNF
	 lJvd2unpFmJ7qgGESv1GKcOWsxQcNiToIZ8zotCpcCDC8GPXeO3ZGG+j4eTcj0+kNF
	 FOD+qvx55NejF/Fw1y/iWVDThxXqJNDaKO2XKGDjLU92tf5pOix+fCvCPCPp6tZQS3
	 etYPP/u8YObV6Lyrg7vQuf7tAqQaUZrfmSze8VondIYVqtiDNARcUGZyMqOf3cQKmK
	 jC8Bt754Q3jfw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso4335459e87.1;
        Sun, 28 Apr 2024 22:50:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8TtYlMBKdW8+lso4yzFEaL4CxY5ezJ0DP9gkS+odUUulLUyZstlUxeHHun7JS+5oDgTv3pPI3M6z0aAXarUFKXK7Jm2/vow/dppUGI9x/M0APpbTpwxNn2TT1ZMNrjWCa9TDsUmjp+SVdjw==
X-Gm-Message-State: AOJu0YxfrDlQJj7fb5Vn7B51onH/8BIVVRhMuIIH1XCIdbiYnSU2tHv/
	EVdkk6/yeXUPCVQ1a2tXBrjwvxYceobw5nyamVVheR2nDcjFyl+1KD1Xp+zi3CeR8+EEylUaagN
	jArNvjXZO6vZygbILEJwAT7Bjdw==
X-Google-Smtp-Source: AGHT+IHEaMf3LwcTvqhFz7t0z8NVl14xdoF0IutWNhbpIHDYBF2FnwK8O/uwZkbLX4yS0SfYSJsvt/nMH8aECkAoFSw=
X-Received: by 2002:a05:6512:e86:b0:51d:ed1:b44c with SMTP id
 bi6-20020a0565120e8600b0051d0ed1b44cmr4438441lfb.19.1714369845752; Sun, 28
 Apr 2024 22:50:45 -0700 (PDT)
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
From: Chris Li <chrisl@kernel.org>
Date: Sun, 28 Apr 2024 22:50:33 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=aqrb+qqGBc1NQxObQxuCPL80pJHc4mfpsirWPOCzboA@mail.gmail.com>
Message-ID: <CANeU7Q=aqrb+qqGBc1NQxObQxuCPL80pJHc4mfpsirWPOCzboA@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 10:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
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

That is not what I have in mind. The swap struct idea did not
distinguish the swap file vs swap device.BTW, I sometimes use swap on
file because I did not allocate a swap partition in advance.

>
> And what do you mean "index part of the xarray"? If we need a cache,
> xarray still seems one of the best choices to hold the content.

We still need to look up swap file offset -> folio. However if we
allocate each swap offset a "struct swap", then the folio lookup can
be as simple as get the swap_struc by offset, then atomic read of
swap_structt->folio.

Not sure how you come to the conclusion for "best choices"?  It is one
choice, but it has its drawbacks. The natural alignment requirement of
xarray, e.g. 2M large swap entries need to be written to 2M aligned
offset, that is an unnecessary restriction. If we allocate the "struct
swap" ourselves, we have more flexibility.

> > The other aspect for swap files is that, we already have different
> > data structures organized around swap offset, swap_map and
> > swap_cgroup. If we group the swap related data structure together. We
> > can add a pointer to a union of folio or a shadow swap entry. We can
> > use atomic updates on the swap struct member or breakdown the access
> > lock by ranges just like swap cluster does.
> >
> > I want to discuss those ideas in the upcoming LSF/MM meet up as well.
>
> Looking forward to it!

Thanks, I will post more when I get more progress on that.

>
> Oh, and BTW I'm also trying to breakdown the swap address space range
> (from 64M to 16M, SWAP_ADDRESS_SPACE_SHIFT from 14 to
> 12). It's a simple approach, but the coupling and increased memory
> usage of address_space structure makes the performance go into
> regression (about -2% for worst real world workload). I found this

Yes, that sounds plausible.

> part very performance sensitive, so basically I'm not making much
> progress for the future items I mentioned in this cover letter. New
> ideas could be very helpful!
>

The swap_struct idea is very different from what you are trying to do
in this series. It is more related to my LSF/MM topic on the swap back
end overhaul. More long term and bigger undertakings.

Chris

