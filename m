Return-Path: <linux-fsdevel+bounces-21064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7188FD2E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D689B24842
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B543188CA3;
	Wed,  5 Jun 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVHsNPwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC961FD6;
	Wed,  5 Jun 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604661; cv=none; b=J3bFiFOsrqx9/UXvCDWhvZOAiOF8igEtEk6nsp79jwPsRuSAK4YOqe0I6SdJK/Ga+YLZ0OWaEeYc7YYxZ06OkUd1vZiuxiq1MEiP0b9DnOcAMRGZBV4Yz5rwco/XPHXzWdGhfwO76nG5+j64Epy1BPBJ4leWy7srMvTHOLqE1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604661; c=relaxed/simple;
	bh=fy2dC7kJ5yIyYLkY6YYNVLaA9wC2Bbg3j4tuIPc/4tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fPEBSXK98kGY6oKIjA5gD+UuVlowG/+foRy2IpdpH/lSnMC8pi8kY31C9wa6KBxjogWXjUbVqMaUWAV4FjkuV8q4fRIjKrmHuUyks+G5pkE82IHQHUwPxLoIsyFqmK0mm1fN4H3qxBzE6+IJrv27UOoZGCwOk/LCt/vAR6mCXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVHsNPwH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7024791a950so785835b3a.0;
        Wed, 05 Jun 2024 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717604659; x=1718209459; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flQITc7xQJ7hzuC/l9q3Vyu4uqvXTdu5y2cqIKMXoP8=;
        b=bVHsNPwHaG6DWjrcPfRAcl2Kc14h4ZyvhCYqVlsxzrlpPiE6KdwTp1at0BIfLrDcen
         ZZ/eyFv9H/0Gk9kbeAbW5GMNrvJwGksf4bYjlILyFygq5o7tadnirdvSHJUUp0UauPZM
         urn8KJ6i0uizcpwpojuH+tcQWwIaZw+tcD+S9u17bCe/+HqBJmq9dp+d6jDhe768AiTj
         8Ad1B5sYMI/GuSpEsJioug4PB3JgUMhSb0gLoFmrn6Q2CzFb4/WrPDBazrO2B+yzb9GC
         emuK5FGMhsyhHqoqG44FKc4ijbs6/TWTFtVcmC9Fu5J162PqLUk+8ukgUx6YftoLivsr
         jeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604659; x=1718209459;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flQITc7xQJ7hzuC/l9q3Vyu4uqvXTdu5y2cqIKMXoP8=;
        b=S3ZqrZa5/VMnU9pN1YRMJ4n29vJTjHH7ZND/TsNp/y2sHKEw4ZX1EHhGfEeolSDsWw
         G64pNqdB3kOafyMQiboAvB1WoVVIq97BcEFB5i7c171JPNWZvbtBLrEPNBkLU4xA7pG4
         2fLjwYCF/YR144gfoBpJsMtcgC86YVLIQ3707ByfFL4DmWzWjKHklSPr3hSwFc8SaKGY
         Rqf8cWnr7K2+J4Tnb34YBvZYF6bA24r9Gw0iDENmqdqfSkYkIYGuZ+EAlJeduM2izoRG
         iapD774DJvIMp6oRCrLlWvtw8GVn8c5kg7+m0q4RxW78pyiT2Iki5SWMDJQ1wuDi/v1c
         ke2w==
X-Forwarded-Encrypted: i=1; AJvYcCVOm6BSl2Mvl/JRvHCUio1bVFtSxnWLryscE8tiQJOD6JR6ppq/5gMnFoWC3i2qMfg2VOVcgH2oGqZDnIru8IwPP/xEWyI/eKKRa6e+ByAflCsYwsMHdZuW2qwPgDbF3E8L2uN2LGhcoNH8agbt1JY6I9Fz3enZG+Q6NwgL0y4o0w==
X-Gm-Message-State: AOJu0Yy3iYq0n/2n75NVqYRQ0qhJmnVZY5gPTiA3vJbAhgsdQTF/i2JW
	GgEvvuqA6IAk+aCvl4MlSbFoifYJsi8q149sWuOjhhWsHjfcw7hW3uNkUlFs82v1sOGm9AAFTS8
	Prc1KuB3oHsx+3DIzfTOfchMUSBM=
X-Google-Smtp-Source: AGHT+IFl4BDR1W/qUUzA2PO/5TqjnOMuZDrbSdWXqHm0/vvIQclz1kYhZyeF3J6773NUVsVX4sJpCnsoN9a3gAPR1gc=
X-Received: by 2002:a17:90a:6b43:b0:2c1:dc60:d933 with SMTP id
 98e67ed59e1d1-2c299a23347mr185983a91.19.1717604659345; Wed, 05 Jun 2024
 09:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org> <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
 <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
In-Reply-To: <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 09:24:07 -0700
Message-ID: <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> > > > +/*
> > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a given add=
ress, or the
> > > > + * next VMA. Search is done under RCU protection, without taking o=
r assuming
> > > > + * mmap_lock. Returned VMA is guaranteed to be stable and not isol=
ated.
> > >
> > > You know this is supposed to be the _short_ description, right?
> > > Three lines is way too long.  The full description goes between the
> > > arguments and the Return: line.
>
> Sure, I'll adjust.
>
> > >
> > > > + * @mm: The mm_struct to check
> > > > + * @addr: The address
> > > > + *
> > > > + * Returns: The VMA associated with addr, or the next VMA.
> > > > + * May return %NULL in the case of no VMA at addr or above.
> > > > + * If the VMA is being modified and can't be locked, -EBUSY is ret=
urned.
> > > > + */
> > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
> > > > +                                        unsigned long address)
> > > > +{
> > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > +   struct vm_area_struct *vma;
> > > > +   int err;
> > > > +
> > > > +   rcu_read_lock();
> > > > +retry:
> > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > +   if (!vma) {
> > > > +           err =3D 0; /* no VMA, return NULL */
> > > > +           goto inval;
> > > > +   }
> > > > +
> > > > +   if (!vma_start_read(vma)) {
> > > > +           err =3D -EBUSY;
> > > > +           goto inval;
> > > > +   }
> > > > +
> > > > +   /*
> > > > +    * Check since vm_start/vm_end might change before we lock the =
VMA.
> > > > +    * Note, unlike lock_vma_under_rcu() we are searching for VMA c=
overing
> > > > +    * address or the next one, so we only make sure VMA wasn't upd=
ated to
> > > > +    * end before the address.
> > > > +    */
> > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > +           err =3D -EBUSY;
> > > > +           goto inval_end_read;
> > > > +   }
> > > > +
> > > > +   /* Check if the VMA got isolated after we found it */
> > > > +   if (vma->detached) {
> > > > +           vma_end_read(vma);
> > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > +           /* The area was replaced with another one */
> > >
> > > Surely you need to mas_reset() before you goto retry?
> >
> > Probably more than that.  We've found and may have adjusted the
> > index/last; we should reconfigure the maple state.  You should probably
> > use mas_set(), which will reset the maple state and set the index and
> > long to address.
>
> Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> address)` case, I presume we want to do the same, right? Basically, on
> each retry start from the `address` unconditionally, no matter what's
> the reason for retry.

ah, never mind, we don't retry in that situation, I'll just put
`mas_set(&mas, address);` right before `goto retry;`. Unless we should
actually retry in the case when VMA got moved before the requested
address, not sure, let me know what you think. Presumably retrying
will allow us to get the correct VMA without the need to fall back to
mmap_lock?

>
> >
> >
> > >
> > > > +           goto retry;
> > > > +   }
> > >

