Return-Path: <linux-fsdevel+bounces-17950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199C8B428E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 01:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BD81C21E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131D3BB25;
	Fri, 26 Apr 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIG7okHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C438F86;
	Fri, 26 Apr 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173375; cv=none; b=fMrYrEtYip4GHCTik19EJLOYVnKC8oF+lB0lpil4MZVS2WmbRVo/bM43FtPX2k6I5lPUYGqkQlYzAWn9d20pz7DAp1wl84/t6WEE92ciKZ2L1U+0GJ72doDmDNST8rYLiFnZ+mC5KDyPcUxtzn/06gJK6r8k+vO62H0lR0EAiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173375; c=relaxed/simple;
	bh=i/wBhRN2FmRqLAw3qg/6YhyNV8moTihsEClOdkMDA3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSpi6Twys5h0rTeTmugXtR4ugfdmXaSTJxMiU+ymYgRYL/BFVo4ykFABdNjxzq3IHVwjad1314GX4mEcbrftjwwu/MLzRHYRmIBI9WRoHrnVqJZipGpAdqJhISejoAkXl072rUdzGaX4FoO3R+GxoQ6rsr1Urv45AffeQoXsiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIG7okHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03551C32782;
	Fri, 26 Apr 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173375;
	bh=i/wBhRN2FmRqLAw3qg/6YhyNV8moTihsEClOdkMDA3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jIG7okHspmyEZtC4YgDgWUw6VzhoyVKmUwELbWDK9TChMiY4tis9qSYAuMfoHS3R9
	 yfdr9NrwqxFUmJkdEy1CaBTHorlqqjQ2JxUx1JjqX/G4kP4y4PkEWTXdrKPVExj6hY
	 tG8scTPbdPtvQRAtcUd+ZoPvPTealJ5apigf5ePe823rQowanLDNwaWiTLz/+euxVf
	 9z5LnFspPg3wVCuiFNqk/AVJNrAOKAFphQxJePOn13dICHsR5/o0kkqkF3exLuJHZc
	 SNmtd6SRQ0Yytfp8TNp8xi6DbRzHvgHMZFgSm2mW4a8jkQMz3QEMd7gBiGykfSJ/z5
	 FkOwyJjb/3T/A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso38371831fa.0;
        Fri, 26 Apr 2024 16:16:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxbN6O+ljrQG0Hu/JagRUJZLXTfO8oaIdMlwePFn3apAW+xUfawWstNWgRzJhk4zfXO2VdRcALU20wRwHAjoYzVTbPykL3F2ro5vsqJ3fB7hs0nhKi8exAP5fV2wqKNWgye7Z6CXU9FthZ8w==
X-Gm-Message-State: AOJu0YxsgJ1rm21jUOENGOuurHualFCF2cYnOzc/fba9cL5KvJyIO+3k
	ug29uE+QiPUpc6KsZ05eZQzm1Uy9z8Hn7CId8AubNNHyZ88trqSwnANaCqX08iU42TxGw33dcWT
	mLQ6/nN8eO8XoPV+RxOJlgVWGdw==
X-Google-Smtp-Source: AGHT+IHXJuz7ODOWEdpU1q+G5HUecFVtjp4DvyVAWQUl8xxkWjgti7Z7xPLaVIYjNEeN1nykpXQSKRy1h93c+/5jwSw=
X-Received: by 2002:a05:6512:3144:b0:51b:1e76:4e9c with SMTP id
 s4-20020a056512314400b0051b1e764e9cmr2532587lfi.29.1714173373661; Fri, 26 Apr
 2024 16:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zico_U_i5ZQu9a1N@casper.infradead.org> <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Apr 2024 16:16:01 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
Message-ID: <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Kairui Song <kasong@tencent.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Matthew,
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
> >> Is it possible to add "start_offset" support in xarray, so "index"
> >> will subtract "start_offset" before looking up / inserting?
> >
> > We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
> > XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We could
> > generalise it, but then we'd have to store that somewhere and there's
> > no obvious good place to store it that wouldn't enlarge struct xarray,
> > which I'd be reluctant to do.
> >
> >> Is it possible to use multiple range locks to protect one xarray to
> >> improve the lock scalability?  This is why we have multiple "struct
> >> address_space" for one swap device.  And, we may have same lock
> >> contention issue for large files too.
> >
> > It's something I've considered.  The issue is search marks.  If we dele=
te
> > an entry, we may have to walk all the way up the xarray clearing bits a=
s
> > we go and I'd rather not grab a lock at each level.  There's a convenie=
nt
> > 4 byte hole between nr_values and parent where we could put it.
> >
> > Oh, another issue is that we use i_pages.xa_lock to synchronise
> > address_space.nrpages, so I'm not sure that a per-node lock will help.
>
> Thanks for looking at this.
>
> > But I'm conscious that there are workloads which show contention on
> > xa_lock as their limiting factor, so I'm open to ideas to improve all
> > these things.
>
> I have no idea so far because my very limited knowledge about xarray.

For the swap file usage, I have been considering an idea to remove the
index part of the xarray from swap cache. Swap cache is different from
file cache in a few aspects.
For one if we want to have a folio equivalent of "large swap entry".
Then the natural alignment of those swap offset on does not make
sense. Ideally we should be able to write the folio to un-aligned swap
file locations.

The other aspect for swap files is that, we already have different
data structures organized around swap offset, swap_map and
swap_cgroup. If we group the swap related data structure together. We
can add a pointer to a union of folio or a shadow swap entry. We can
use atomic updates on the swap struct member or breakdown the access
lock by ranges just like swap cluster does.

I want to discuss those ideas in the upcoming LSF/MM meet up as well.

Chris

