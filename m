Return-Path: <linux-fsdevel+bounces-17033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E5C8A690D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B801F21BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A6128805;
	Tue, 16 Apr 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap8fqOuj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374C3D38E;
	Tue, 16 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264759; cv=none; b=N6FxHByjr6wYanxPhO1E7y8wBsi6VyiapjRXwr9B6ZyPqJ+N1hcQ+sOsRID8I1+h9NjcSVwSLq45pSMImpv9Q/5jN9Efxg8B0/BTDJDXBGiSqgPiLq5Z9UneXFvLG0VT8unQUazvzh5Dq+gY5HdAwAMvLj6/r7kPOE1FpmznwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264759; c=relaxed/simple;
	bh=9gNKl0lrAyzFZuHgMx15OipfXoXEYkAjMfWK1Ym8ab8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLv7dyNTJJcvHoWjjw3SlE/PgEbevI2mrm68h0zSCpbEoBd5h4u30nVCtj/JXDF44024gHEbWr0TfYbFZlJvVatwYyEOKwiuvq2mXh0SP3H/7oK0yBzXp9brvjCl7fiw+85479H3Lp+P5d3NG0zoUt4pM5oSo+x41l1IC6WhJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap8fqOuj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5701dec0c0aso2762330a12.3;
        Tue, 16 Apr 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713264756; x=1713869556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj+Iuq37H5CQ3HHFDH6wk2fzVZAY8yC5nRKMEowsuSI=;
        b=ap8fqOujQXb5mpgB3C4efzPlg/7yyqHRat9k3cFJ85hrykaPTIJGyxX8pJaHm+HrR6
         ogizh78Ph4ntZZu4g+mO/kPXSPBDUjxKIlEEwUwpAV8HFS01UiL9Rko6zAw5BqefhHUv
         V+lE7DUs9PuQWoyV8I9wRn+sQ/XcJmL9DQWwpOCRAIk2EksYzUm/nlxcoCqviFfdTLFj
         eSKxh9wM9omkaCkpY0uRAiPS3MMyGJlvb4hdY8etENq/qZsy1KyZpJxV4yAs7yszfGOG
         P1pOUFsrxtdjhLqaY25rmc6rTIIA0ecR/JRaq2VgD2fhdHAOizqIwS+v/F7FehzZi4i9
         /uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264756; x=1713869556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yj+Iuq37H5CQ3HHFDH6wk2fzVZAY8yC5nRKMEowsuSI=;
        b=o12jYCldbKHK+e6sjuCN0aIHqp012W3Qm7pww8ublz8rHoN+GPaa3qjYu0tMLnU1M6
         FZgPwTEnTnRwiCH7uMQxpMcgcumdTFPhey06K/miWTpWXZ4TAbNbbaDdVRe6QwqLFpwe
         GV10aX0+DN+jbvsSMkxSLGE7HqACQelcP5jM20xFEyhZkFIi6YER3arQGawWZzoEnCGK
         aFbOZMcWztOPApmfOryic8qAg39ibGMNF8sXBQnl+Rr6Uaxc/JV1oHG16//VkZ8Zb4/o
         uZQeRQHrEeW7WS9qszyNrnD/Rl/dwzo55Mbp0Rb2s5EToUdlrHILg1sYrEqmNt4+pNgn
         UMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7BMzUY/+6gqZ1nL4FafQ6jbtIg/cKuTJm0Aol8QRBGD6m0gLSgJpz0hqeqJwSsxxb+kTdJYEk/e6zZGMm4ztqGA8jF7JQn5oqzK2bpJvn+wKhf6nl9Z6Lgja1pUMCpGhUwF6X+mHxEMfkHU/1bV7foOO1rgQbk6XOhCWp132NKc/1pMCuuJwciyLX6uH4yYhXlMuoHQbPFkBdo2UWPCsWV93NTFTnQrb/Bf6nW7Rghvb+i4vIHgsxapVbGAXFGmIUL2ehatbj1xUB9M6xAtNAn0jl6dokl9aq3RbnA==
X-Gm-Message-State: AOJu0Yxcpp1iaqEjsfGIbnaHnR2fvO6TOdqYCmqcD1+sntopREuEUfD6
	lSrc65JU67rtJJe8EhStyKvwYUXAno/R1sV2ftRSq4itKjJAFhAkwVeiRzz0UE9mmdmjgKjNkty
	PrRa4+qsE49bcpJqQv8mOqN/xgrY=
X-Google-Smtp-Source: AGHT+IFon2Aw3ti4vkbB1b2ywIYBBfu+zHa7Gr7yH1CDPfXp+5JnTzJ9UBBOwEC/nOMEAZCzW6rVZshgLJrmc6B/ebQ=
X-Received: by 2002:a50:f699:0:b0:570:2367:47e7 with SMTP id
 d25-20020a50f699000000b00570236747e7mr4030108edn.12.1713264756242; Tue, 16
 Apr 2024 03:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409192301.907377-6-david@redhat.com> <20240416104008.41979-1-ioworker0@gmail.com>
 <3ef81fe3-2584-4db8-ab66-eaa44c035707@redhat.com>
In-Reply-To: <3ef81fe3-2584-4db8-ab66-eaa44c035707@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 16 Apr 2024 18:52:24 +0800
Message-ID: <CAK1f24kph=hV6Da=fAXFuKChx5JVasPLYC7efQbPr+JT0WxQ1A@mail.gmail.com>
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using
 the mapcount of large folios
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

On Tue, Apr 16, 2024 at 6:47=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.04.24 12:40, Lance Yang wrote:
> > Hey David,
> >
> > Maybe I spotted a bug below.
>
> Thanks for the review!
>
> >
> > [...]
> >   static inline bool folio_likely_mapped_shared(struct folio *folio)
> >   {
> > -     return page_mapcount(folio_page(folio, 0)) > 1;
> > +     int mapcount =3D folio_mapcount(folio);
> > +
> > +     /* Only partially-mappable folios require more care. */
> > +     if (!folio_test_large(folio) || unlikely(folio_test_hugetlb(folio=
)))
> > +             return mapcount > 1;
> > +
> > +     /* A single mapping implies "mapped exclusively". */
> > +     if (mapcount <=3D 1)
> > +             return false;
> > +
> > +     /* If any page is mapped more than once we treat it "mapped share=
d". */
> > +     if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(fol=
io))
> > +             return true;
> >
> > bug: if a PMD-mapped THP is exclusively mapped, the folio_entire_mapcou=
nt()
> > function will return 1 (atomic_read(&folio->_entire_mapcount) + 1).
>
> If it's exclusively mapped, then folio_mapcount(folio)=3D=3D1. In which c=
ase
> the previous statement:
>
> if (mapcount <=3D 1)
>         return false;
>
> Catches it.

You're right!

>
> IOW, once we reach this point we now that folio_mapcount(folio) > 1, and
> there must be something else besides the entire mapping ("more than once"=
).
>
>
> Or did I not address your concern?

Sorry, my mistake :(

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

