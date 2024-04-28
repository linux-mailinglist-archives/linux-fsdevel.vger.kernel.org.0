Return-Path: <linux-fsdevel+bounces-18015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC98B4D46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69801B20B1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BA73510;
	Sun, 28 Apr 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOzbiPHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AE79F0;
	Sun, 28 Apr 2024 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325844; cv=none; b=DlkBwL/J60om7GdUJ673RJQvaOlOmxY0dDjezSTzrYkjQjOhY1Tn/PEpEorC/WL/VUCbWSlUKb7U6dS9RwKt/OAh814KnogZprlNIoE2Fz41Kqd3DhifF8IvJAqLXg9rnP3IGgVl/Ni21MVTG+6LczhjyWgGg9VkPk/amU+IQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325844; c=relaxed/simple;
	bh=k/p0+piWbqFxV0/iw58pgAaRMUt66R+LBwhDr0aqIVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLMeSVOab1BjMiIceQHU05diXdEot+M5uQJoYB/GVs8XdAO1lZeJBumouDRB2nvwgc8+MbZqYDnyGzvPodGoo3xcplOMjioeoSFbgdhuGv2F2JAqgZUBSQ7JeN7t20H7ToRUwCqKwDkZvhmKu0/JvTtjlh1ukP1NF78O5UHO2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOzbiPHs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so45175261fa.0;
        Sun, 28 Apr 2024 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325841; x=1714930641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M+7SXqqUCz3AMb8S+u8A0bUNwyf95ASvG0+qysyKfY=;
        b=EOzbiPHsJA8Gpknno4b55KEoTi0FAuy5FsXkqSo/zExyHjcGGGRmaLZFdYgL4HE+VH
         8YrZ+VtvRHRTFLGHnL3ZtXR1IsjarVYGDRCpK1oQVYMxPwXJ0ODHZKC5DSlgDlSSOeix
         OKIii5q2p71jor1xslh7df2h2ypH1/vlP4z5ku0IlWyMi9rgCNmr2nIm83fknI3Q+VV3
         Utuuzv95/YfWYqQu0qZrBU1t00oCxVUfquyzCmqsA/AkyNzOC8vTfWsCCDVFReDcryYf
         sjpNc4NQOuR2eYPm/dpnts/BNTnX+4yUAyFLz+ALn+hbsmlppVEJLCa74Dsu8RnYB3bn
         3lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325841; x=1714930641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M+7SXqqUCz3AMb8S+u8A0bUNwyf95ASvG0+qysyKfY=;
        b=Lcd8RMe2dnsU4H54Iqmrcj5lrI/kF2zyldFRQMEhKTSNS6vpXfnEQGTWg8aTFYZQXy
         hyDpiBecQEHpfmVQaMItVuB3AvULQRDxrrpIv2+X8yaIBPZlCTyx+zmzBLGEAh7/bvpy
         Wpz/rFit+lje3RvNnF6BnpruqPToKik80V4XuOphS/z6zQg9R6UN0E07WnYzCJL4KyKe
         ts+MZAkU5NbX3dRdwoKaDMa1cx/VoTXQ3kf1GZrLoLKw1Hy+LJD60PQ3QdqGiOH9d8Iy
         CSHPLFQ/JKyf+nWLN2HCJdp+tFG3Z9+mYAOGSqp4zUiNjXMWSYbQR3/oduy1flxmh6pd
         vChg==
X-Forwarded-Encrypted: i=1; AJvYcCWgOUx7rMGVg6oRT0wlCJKOwModajlBpiiE/jVqHKbt3vvPH4D+8JZkEx6tMrv5HhWtaejvqQYzYGnCDfB8JwDVeqSFlAZGjlsdqBG1lENaTJ6c7YxWIMoeQf5nJWMe2oyfIa1GW7LY9XzdSQ==
X-Gm-Message-State: AOJu0YyBN0wVMYNRVcDhh7FUSgbUmXibwjTyOUPvrjIJivGurjQB5a0k
	2DZQG6q5m+V4jwYOQhm5FUAE2y2dhY1RTT/OAdbHNOwO8IES+5EQ/uLTjJy4xceHFeiqdt/0Z4O
	AjcUrxzE1Scltx2kuBJ5FJMGwSyI=
X-Google-Smtp-Source: AGHT+IETOZuoJd/xz6aIGmwIsw9yXSQIJCM4rWPYbEALodfeYov81CKqQggfN1JeZG0fTBDgM6yKkiGNkU+PuSxgCiI=
X-Received: by 2002:a2e:9d10:0:b0:2db:ef48:ea38 with SMTP id
 t16-20020a2e9d10000000b002dbef48ea38mr5486201lji.45.1714325840835; Sun, 28
 Apr 2024 10:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zico_U_i5ZQu9a1N@casper.infradead.org> <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
In-Reply-To: <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 29 Apr 2024 01:37:04 +0800
Message-ID: <CAMgjq7AD=n0T8C=pn_NM2nr-njNKXOxLh49GRrnP0ugGvuATcA@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 7:16=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Ying,
>
> On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Hi, Matthew,
> >
> > Matthew Wilcox <willy@infradead.org> writes:
> >
> > > On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
> > >> Is it possible to add "start_offset" support in xarray, so "index"
> > >> will subtract "start_offset" before looking up / inserting?
> > >
> > > We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
> > > XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We cou=
ld
> > > generalise it, but then we'd have to store that somewhere and there's
> > > no obvious good place to store it that wouldn't enlarge struct xarray=
,
> > > which I'd be reluctant to do.
> > >
> > >> Is it possible to use multiple range locks to protect one xarray to
> > >> improve the lock scalability?  This is why we have multiple "struct
> > >> address_space" for one swap device.  And, we may have same lock
> > >> contention issue for large files too.
> > >
> > > It's something I've considered.  The issue is search marks.  If we de=
lete
> > > an entry, we may have to walk all the way up the xarray clearing bits=
 as
> > > we go and I'd rather not grab a lock at each level.  There's a conven=
ient
> > > 4 byte hole between nr_values and parent where we could put it.
> > >
> > > Oh, another issue is that we use i_pages.xa_lock to synchronise
> > > address_space.nrpages, so I'm not sure that a per-node lock will help=
.
> >
> > Thanks for looking at this.
> >
> > > But I'm conscious that there are workloads which show contention on
> > > xa_lock as their limiting factor, so I'm open to ideas to improve all
> > > these things.
> >
> > I have no idea so far because my very limited knowledge about xarray.
>
> For the swap file usage, I have been considering an idea to remove the
> index part of the xarray from swap cache. Swap cache is different from
> file cache in a few aspects.
> For one if we want to have a folio equivalent of "large swap entry".
> Then the natural alignment of those swap offset on does not make
> sense. Ideally we should be able to write the folio to un-aligned swap
> file locations.
>

Hi Chris,

This sound interesting, I have a few questions though...

Are you suggesting we handle swap on file and swap on device
differently? Swap on file is much less frequently used than swap on
device I think.

And what do you mean "index part of the xarray"? If we need a cache,
xarray still seems one of the best choices to hold the content.

> The other aspect for swap files is that, we already have different
> data structures organized around swap offset, swap_map and
> swap_cgroup. If we group the swap related data structure together. We
> can add a pointer to a union of folio or a shadow swap entry. We can
> use atomic updates on the swap struct member or breakdown the access
> lock by ranges just like swap cluster does.
>
> I want to discuss those ideas in the upcoming LSF/MM meet up as well.

Looking forward to it!

>
> Chris

