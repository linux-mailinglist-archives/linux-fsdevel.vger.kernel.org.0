Return-Path: <linux-fsdevel+bounces-15901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3898958F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4163B1F20FE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90920133416;
	Tue,  2 Apr 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmmPT9MP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5E13340E
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073303; cv=none; b=nLchSb60iidDvMKLYKgs/QuZgwzOn5LpXyfkNLe3Lm4+E0BHM28GKRwnCeagCwNcbZkKWPtLQGwUwUPBFJkIe47OdM6o72o6iAvEuu5tX5qvBs9xyQIrH5tkPC5s+HwJSc9qtpXbONao4pQPHryAutk8HBJaOkJA+Ge9aWbORRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073303; c=relaxed/simple;
	bh=pwwVenw5/sEPvsqRvdjzPU9XoQsztAk8DR1nAQ3wIhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCB8m+PvVN4EXZTjIIwCnTk+s6EaSYPTfqWOLaZhUmc6pGoXAAdSvdGaFbfP/2545f4A+jXpAU5dm4K7ihEiVaof4hWzKqcpV9Q7JPPXp9xnEhzWIv9Fvaur2xaNexahLQ3zuZAIphftM984i4xUrgNh9PSSKO4nW0nc8uuyy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmmPT9MP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6153d343a4eso5102007b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712073300; x=1712678100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmjL0/8sZK7haw7M72Eo2rYTS5WWFvl8Tyo4r32sEZU=;
        b=VmmPT9MPpEEDMTFQtjdsXn4gjEUGVCl2/jpg5QNs4XfeHUEHUWaRrStI/19efdmnZC
         nG87GEaR7gR8VzIZ84OYz3xeCRTePjOYbm8wlgY2IOC8yiW1AOPpIatyVnEmuh4EIOC3
         cTLY8MLH/MMOJGdKpktYyE2uGXq52yXwTrmltyMxT61SDTIdXSuNC7M8IYcf0alaG4Gk
         ieF1MOodeUIk1McV4kR0D9C1Jj9F8fXTQcKGuBq37rQ/15Ytz2UPy4PLhMOJUGpqMIgq
         frhpotyH1QJqzRGdvVP6YMMmHM84f4z8FuvqaLeu4FCZ2rggnit6KSt1Aa/TwYaPFZaX
         mhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073300; x=1712678100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmjL0/8sZK7haw7M72Eo2rYTS5WWFvl8Tyo4r32sEZU=;
        b=OHYEGwq6XP85yAgkwAUOoYITwCR2VwWODkramE50Wz15mwUC985J69+YxqY5wPSjdV
         6LSm81a7RjVTx52rmr2GSKuPhAIdbo+cbPhdvI1UhDlm5uX6m5Ws4ijcrAaHRB5MfwCq
         ixJ73JpHGIBUVd4dAIgKpm3pLd31+HZ+X5oQxNRBIsUxARrkr53GJtX4xErAa9zt4Ez5
         v6DLaoTHYfH3xwqDZYPsWE8YKKSz3NXOPL2hUDT4TlsrJGj4lSss+GJZd9Jm8FfAE51s
         RMYmHP8+737z/GoUq22zc/XrQikl3wETWDlEMp1kOiMIxDuL5FMNQRfyq+gIOcGJoqEo
         jMYA==
X-Forwarded-Encrypted: i=1; AJvYcCXbY8PYbtc7sXlXMBMphLMHbpK+iF4YPxjIoqpbLC1M1ncIEULK5dbqJ3z2PrdI+Wd2KEx1DUhHFYCoMe6F7QzQ2m1wD9hth9CbbGy1eg==
X-Gm-Message-State: AOJu0YwNd2D2utrXOSlJkh/xsDMvfKaTj9VwEYW33DhLHsd9vdeTx40K
	Gpwh1AcSLT4i5BexFmEs+gQbloN9FuSG1zuMzAkJvymBToz/IIyrOd8Q0RtfKJVQCEVP4TLeXXG
	rwTjiizlIdr3c97UUKSGtECvykT8=
X-Google-Smtp-Source: AGHT+IFSwuJ+MGJ73LzyCWn1zVg13sJL3Y2sTBYi6p0IYaA4W2WBQGsp6J3zMhCvOO6+qR8WujSPOIsPMOtnzhWK2cg=
X-Received: by 2002:a25:8045:0:b0:dc6:bd4c:b119 with SMTP id
 a5-20020a258045000000b00dc6bd4cb119mr12094038ybn.55.1712073300403; Tue, 02
 Apr 2024 08:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-3-wangkefeng.wang@huawei.com> <Zgr7fYRd1M6gnEBi@fedora> <9200de40-aee5-4aee-9b78-4b93e3442d5f@huawei.com>
In-Reply-To: <9200de40-aee5-4aee-9b78-4b93e3442d5f@huawei.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 2 Apr 2024 08:54:48 -0700
Message-ID: <CAOzc2pwXs1Vomy=yuQ0=mDF=oPfJVe720vPKfYP3Er7YhYtWww@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] mm: migrate_device: use more folio in __migrate_device_pages()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Tony Luck <tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, 
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>, 
	Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:21=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
>
>
> On 2024/4/2 2:22, Vishal Moola wrote:
> > On Thu, Mar 21, 2024 at 11:27:38AM +0800, Kefeng Wang wrote:
> >>
> >>              if (!newpage) {
> >> @@ -728,14 +729,13 @@ static void __migrate_device_pages(unsigned long=
 *src_pfns,
> >>                      continue;
> >>              }
> >>
> >> -            mapping =3D page_mapping(page);
> >> +            newfolio =3D page_folio(newpage);
> >
> > You could save another compound_head() call by passing the folio throug=
h
> > to migrate_vma_insert_page() and make it migrate_vma_insert_folio(),
> > since its already converted to use folios.
>
> Sure, but let's do it later, we could convert more functions in
> migrate_device.c to use folios, thanks for your review, do you

Makes sense to me. This patch looks fine to me:
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> mind to help to review other patches, hope that the poison recover
> from migrate folio was merged firstly.

I'll take a look at it, I'm not too familiar with how that code works just
yet.

> >
> >> +            folio =3D page_folio(page);
> >> +            mapping =3D folio_mapping(folio);
> >>
> >

