Return-Path: <linux-fsdevel+bounces-17992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580598B493D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9931C20AF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D920ED;
	Sun, 28 Apr 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXVAM2bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD3215A4;
	Sun, 28 Apr 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714272214; cv=none; b=S7fRK/WiO9A/D9Oa9RFG1oqHM0ZM8JDFNXV91irT0VcdwcHEFzH6BlZTK9i9uV8GGe2s7T+MNHtqeE3DPargmI8lgzTGN221FINwK2XBEZ07/AG7vv2gh1T6070SX5donh33MOQbNU3O24iu/giY3/RCid5BAWmvb+iYrBa/Ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714272214; c=relaxed/simple;
	bh=HFYmYFkOJcs1UWSCZYbi2D5Ua/FNF/Ysbr0h8olyrCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auWJvhFV2L0AkNUDpGHsV0x6RfEmN4eAxeEb5u0nNwoUEP3nSkcxN1KJ1BGLn0amc6DLDs+DECQN1HQwtTTS7v96UZhDkgW74eisDtzoPF6Q7xcWRnr9X/FND64Y8sitWFUku2sU6q2tdgk/SHyb2LcUZrjHn987wYFYCWhzMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXVAM2bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE29C4AF0B;
	Sun, 28 Apr 2024 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714272213;
	bh=HFYmYFkOJcs1UWSCZYbi2D5Ua/FNF/Ysbr0h8olyrCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iXVAM2bvQ4QN3T+HmWeAabZGCZ4i1IlmMKfdarRhBok4Sm5fs/vb+yOLl6Y7n454t
	 3bTrXO6lYcBiu9Il+aFtNLwBPZDNzzdXc/HmaLso+r1A/ZQd73SmgQlL6yHz259nX/
	 UHynHroMuuSxnQhrfioFQlbBEBQ5EBWqsOwSVnFOUxzs+NssrSYfVqQHhY2sDOfC7R
	 ot/nYotLa6XOtM1UznO4U10TsI07KwUk41VgZ2Q7fjuJ2301o21QlTlzobPK/pGmO0
	 ODUodxtQ6UEIyQYPHcTHhG4KhhVhCoAjaoZThkfI+BXafgoerVnf2BJQub0fdbedW1
	 luz2GbSqxS56g==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so45161511fa.3;
        Sat, 27 Apr 2024 19:43:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZFSF0Op9M/yQ9RQ8DH1+qov3FDDtOvtBAOFtmoKKESix+lHfin4lsi5zqmO09OsREayuFMmbLeXxXfNoLhTb18+nIvSHTAYhG2MyEIG+yFRKAYyIzT+01gaO+C3SLl++U8mcjvXAH989unw==
X-Gm-Message-State: AOJu0YxhFw/+tORrg/ZRtxMuCTF+xykSGQ07b10G1AYnkZvVNINavzoN
	nN+9FCT0pbTYt8viPkXBK7fEs2I46lzlQYDaI+C9Gym9cUncCesAZYnNrZwqbRVSq6CLuWb1nij
	uxlbuGiSYehXsQidTuoHR5jhEhg==
X-Google-Smtp-Source: AGHT+IF75nQX/dWyajS5NVAD4ViXSOpii6Cd6eRPc+A/veNE/1VqvZTVL4PkmA9WDbIYXX+57ig2aQaECW/3iwavFMU=
X-Received: by 2002:a05:6512:313c:b0:51d:aca:4b06 with SMTP id
 p28-20020a056512313c00b0051d0aca4b06mr2055891lfd.39.1714272212358; Sat, 27
 Apr 2024 19:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zico_U_i5ZQu9a1N@casper.infradead.org> <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com> <87bk5uqoem.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk5uqoem.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 27 Apr 2024 19:43:20 -0700
X-Gmail-Original-Message-ID: <CANeU7QknjZrRXH71Uejs1BCKHsmFe5X=neK7D1d1fyos0sAb9Q@mail.gmail.com>
Message-ID: <CANeU7QknjZrRXH71Uejs1BCKHsmFe5X=neK7D1d1fyos0sAb9Q@mail.gmail.com>
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

On Sat, Apr 27, 2024 at 6:16=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Hi Ying,
> >
> > For the swap file usage, I have been considering an idea to remove the
> > index part of the xarray from swap cache. Swap cache is different from
> > file cache in a few aspects.
> > For one if we want to have a folio equivalent of "large swap entry".
> > Then the natural alignment of those swap offset on does not make
> > sense. Ideally we should be able to write the folio to un-aligned swap
> > file locations.
> >
> > The other aspect for swap files is that, we already have different
> > data structures organized around swap offset, swap_map and
> > swap_cgroup. If we group the swap related data structure together. We
> > can add a pointer to a union of folio or a shadow swap entry.
>
> The shadow swap entry may be freed.  So we need to prepare for that.

Free the shadow swap entry will just set the pointer to NULL.
Are you concerned that the memory allocated for the pointer is not
free to the system after the shadow swap entry is free?

It will be subject to fragmentation on the free swap entry.
In that regard, xarray is also subject to fragmentation. It will not
free the internal node if the node has one xa_index not freed. Even if
the xarray node is freed to slab, at slab level there is fragmentation
as well, the backing page might not free to the system.

> And, in current design, only swap_map[] is allocated if the swap space
> isn't used.  That needs to be considered too.

I am aware of that. I want to make the swap_map[] not static allocated
any more either.
The swap_map static allocation forces the rest of the swap data
structure to have other means to sparsely allocate their data
structure, repeating the fragmentation elsewhere, in different
ways.That is also the one major source of the pain point hacking on
the swap code. The data structure is spread into too many different
places.

> > We can use atomic updates on the swap struct member or breakdown the
> > access lock by ranges just like swap cluster does.
>
> The swap code uses xarray in a simple way.  That gives us opportunity to
> optimize.  For example, it makes it easy to use multiple xarray

The fixed swap offset range makes it like an array. There are many
ways to shard the array like swap entry, e.g. swap cluster is one way
to shard it. Multiple xarray is another way. We can also do multiple
xarray like sharding, or even more fancy ones.

Chris

