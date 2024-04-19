Return-Path: <linux-fsdevel+bounces-17266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E58AA640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607C71C20AFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48DD10F9;
	Fri, 19 Apr 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP/7kWYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FF385;
	Fri, 19 Apr 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486733; cv=none; b=qkwe2QSPcff0bBMNYuXs/xTrfLjQqWXnYzM68RnGMKA45LWryWXU9kZDY6kik3VGe8OtsI06LuwUBpO+D5ieDd9koz+BZCt21mHkKb2r40fWi6bH6uhpUon5Rh/aFw307Ws21Rz/1ePshlA4MV4gk48xluU4xUZRIjKM/4IiHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486733; c=relaxed/simple;
	bh=J9OCujdVD1wISLUjXJjfz12GpenMuoeaxYnqqdrF+mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmW8evTdiKPdeJ4FFt/xDl7h53qoT89Ks9aLifPAAFC4WEaa9kHFwELImN3xPrWUPHHQQINfcorSB1IkhkD8OAl6AlfSjivpVH0g/FptAjRHiH0WPzUtA8ToJw+znamux9Xlo8v7LV5YuS0sRoF6cCQ7O0jAmyljeEoh7M9V50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP/7kWYg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so1421326a12.1;
        Thu, 18 Apr 2024 17:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713486730; x=1714091530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj4m/kgBH9ztYxNsBRNWWV+PAwZT7yiTynnRU4KUON8=;
        b=XP/7kWYgtDg0SsfN8fWXTCV/hM6u4zfX7NuJCuoaTp98b65vd4XHkIbEHeckEPeVyo
         70ss19kqCNoW7Fcg+RCNan7u6wppKT6hT2hheGiPwaleqshym/g8j61gUw1G700xmDvP
         FBx7yEIX5XkgxU6SUrNT85kMhznTYz4Jd2xX5V/o0s2u2MPRAkrO+mRl3qta1ATFz0Ba
         4YHG7T+fzq3aBBUqMunC+rrrY/mNdvOCNGob5JAo01jOx6T2e76yzQxDc2TD1ltF89+L
         dTy6eWmuJ4B/f7J/yf4EHFwsnNISyOOdps9iFQx8XzK4GNPAh9XvIFQkqf4CQfmDKJcC
         UuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713486730; x=1714091530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oj4m/kgBH9ztYxNsBRNWWV+PAwZT7yiTynnRU4KUON8=;
        b=QUJh3gid5vszMq3cBRpeDTsVIJ0ZXfNF3MnvK+MAXi4OcRcGLJGBtJtq2huU4SG08+
         rkK/hz7kPUTY2Xw+eTbt5yO29wy6Pb19Rgu+WlxWiw+2sUf9ESx5V5zaV09IFblIc3fx
         inoJRCgIxu+qMQuZ6ckQrIeIPKV6yR2yeMBTMzNID10uEqIUK5VcJcn7k9wWvG3asdgv
         ZyBNta0jR2rMCDHfuxKe28OTemHE4vR4iWyRV0L0MLWHbta4+4T3nAI3Yz96oJB/Y3oD
         U4ae9aIa2f8E1Mvytgu2A2t8+xLJ2zJ7V3UJPdnMjG57xIM5a8VbisZ0c6yYFSZ9qQ1w
         4xAg==
X-Forwarded-Encrypted: i=1; AJvYcCVUQTm+yZVPAv3xj8g0ljbVO4txREtVW6ZtDLtstkEfPOz0+gvxnJgWkPfbXmPOyyJP7mhfWhmDvLT3tE1aZTj64DvS2gKLDULeIR6HP+qBFevudP5DI/GHWqR8kk8I4nu/eJfQWKpGM+oQpLUbvxq1GFujUCxvooIQZ5P7nhFafd59bXs1fhjjvRdxXRpNZZcEbd2XpgiflLECMLkbKwrAM5PXjfl07ThAfGitTNHgHbtoDWCSrP0i11EwmIInt3y21TUhdYlLFkMBpoyVJLgv95uEDxcua626WcTlsQ==
X-Gm-Message-State: AOJu0YxFS2/ZIaFdeqtJbLOZcPxHrvjoyOANstkY273OwSWomeFQPSic
	SQjrLKnIjmuch+ewttOdKDiH2kIByvIcPNC4VJpwxVq3fM8XnuxjoAExbD7UIyPr0NUGaaY2S84
	dUF4QX5qyv533R+xihUynYAJc04A=
X-Google-Smtp-Source: AGHT+IGKieE1Y9dItlGmKmGisjgxP6q9UdIr3kOeK+kf4J5nBKEpfrB6yJjFguszrY/TUPv6ziQLRBzzr5PxjfwC7mg=
X-Received: by 2002:a50:9e4d:0:b0:570:db4:e5cd with SMTP id
 z71-20020a509e4d000000b005700db4e5cdmr351855ede.34.1713486729802; Thu, 18 Apr
 2024 17:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409192301.907377-5-david@redhat.com> <20240418145003.8780-1-ioworker0@gmail.com>
 <f8f30747-1313-4939-a2ad-3accd14ba01f@redhat.com>
In-Reply-To: <f8f30747-1313-4939-a2ad-3accd14ba01f@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Apr 2024 08:31:58 +0800
Message-ID: <CAK1f24nO-7QUYxXsYqDH=Hg7J_Hn9rxpkfQzaBBOpqFnzbCATQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/18] mm: track mapcount of large folios in single value
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, chris@zankel.net, 
	corbet@lwn.net, dalias@libc.org, fengwei.yin@intel.com, 
	glaubitz@physik.fu-berlin.de, hughd@google.com, jcmvbkbc@gmail.com, 
	linmiaohe@huawei.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-sh@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev, 
	naoya.horiguchi@nec.com, peterx@redhat.com, richardycc@google.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, willy@infradead.org, 
	ysato@users.sourceforge.jp, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:09=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.04.24 16:50, Lance Yang wrote:
> > Hey David,
> >
> > FWIW, just a nit below.
>
> Hi!
>

Thanks for clarifying!

> Thanks, but that was done on purpose.
>
> This way, we'll have a memory barrier (due to at least one
> atomic_inc_and_test()) between incrementing the folio refcount
> (happening before the rmap change) and incrementing the mapcount.
>
> Is it required? Not 100% sure, refcount vs. mapcount checks are always a
> bit racy. But doing it this way let me sleep better at night ;)

Yep, I understood :)

Thanks,
Lance

>
> [with no subpage mapcounts, we'd do the atomic_inc_and_test on the large
> mapcount and have the memory barrier there again; but that's stuff for
> the future]
>
> Thanks!



>
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 2608c40dffad..08bb6834cf72 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1143,7 +1143,6 @@ static __always_inline unsigned int __folio_add_r=
map(struct folio *folio,
> >               int *nr_pmdmapped)
> >   {
> >       atomic_t *mapped =3D &folio->_nr_pages_mapped;
> > -     const int orig_nr_pages =3D nr_pages;
> >       int first, nr =3D 0;
> >
> >       __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> > @@ -1155,6 +1154,7 @@ static __always_inline unsigned int __folio_add_r=
map(struct folio *folio,
> >                       break;
> >               }
> >
> > +             atomic_add(nr_pages, &folio->_large_mapcount);
> >               do {
> >                       first =3D atomic_inc_and_test(&page->_mapcount);
> >                       if (first) {
> > @@ -1163,7 +1163,6 @@ static __always_inline unsigned int __folio_add_r=
map(struct folio *folio,
> >                                       nr++;
> >                       }
> >               } while (page++, --nr_pages > 0);
> > -             atomic_add(orig_nr_pages, &folio->_large_mapcount);
> >               break;
> >       case RMAP_LEVEL_PMD:
> >               first =3D atomic_inc_and_test(&folio->_entire_mapcount);
> >
> > Thanks,
> > Lance
> >
>
> --
> Cheers,
>
> David / dhildenb
>

