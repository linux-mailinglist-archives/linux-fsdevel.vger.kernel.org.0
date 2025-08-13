Return-Path: <linux-fsdevel+bounces-57707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF6EB24B33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9588136F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859A2EAD03;
	Wed, 13 Aug 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CYLpPAZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD11C5D7B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092988; cv=none; b=oZ2QLLezpijXJBkk0Q06Vg2Nko02JJUCSKCkG5t7FrKHxktitAUF41WAZzibJR6eD+FAizdHKK9SwoNXGnC7xCWDjkdhSVlMJ4mex059vzz2ohepX3OJa8Hi24j0jdyWf72HCW9W2hjbkN+Lpr6Pe0WtAOpOJCPsSAFOw8BgRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092988; c=relaxed/simple;
	bh=tjiy6lq7zUfoy7QhTySB92H1/vQWjMoW9kYs9mRlj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKrG2eSMrENi7B9eKfNGLh7ZadTGNdVHhKHXspsFJKcGIUI7H7t11lo5Mc2O2u8al8gBFvJ17Uj9V9Rv5wFyUTv7/FERNuYyCfoU9h+0JeNdrIQeWMr+40nXfI0AVEfhoQiQ/7gdyKlv8WSiQIBa16axJuqfZJ/8VsqVPQru/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CYLpPAZK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1008221dcso3369581cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755092985; x=1755697785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=CYLpPAZKQShpwEUsNee6RM4kJnUJPku1C/MQYNOe/wnPVA5nW2BKgAt1P1Qd8z89nW
         3UtpVGFG3IKSpUYRpGP4xEOZPpe4ziX5OZepo7criuF/tePoWvlr4yv0hTFZKmgQZI4k
         VQUSLZjp6YrmB0xiF14ed5T0A0SiZIpyA1wMp1Sds5IooxGok3m9ud2CPdLLBq6MDLhj
         KPmeuvzKihC4FqfvrU71scgVCrIzuCp9x1FTnxYbscMeB1lss3m2+En/hx6Zuqqs+k06
         9qhgvDn1hn6kcvSvreQ1PTIR+age4FM1u9iMaS0Vbc4R7zAXprlU4SM3S8Vb5iJdYS6j
         GOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092985; x=1755697785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=tpp3/U1Ivg1TPFXm3XZggR7nNz367sgmiiuYJu67nbk0ZFxBjsNypuB1BZ+fhWwfRq
         LoRYvnrsFSqvnqJx9WWkCOJUL/Jyb2owD7K5c4QSTLiXo2g4KHAxPHC2+UG5s2ofiOVo
         8/Zo5KTm8OYCrGWE/tnrgX2JI4l813ae/3bXgagZ0FcuiOb28dkdwRxXRJZBw7BPWL6M
         ObN7JC8D+Ig4Su+QHM4yqeUAf6aQuJ2M0gG7CDynNO/oaXAV16z1Zsbqfu7B8qJ8Rd2F
         SGu9uCdhuO5nwo0BiOybZHagYqFgxo+xajRAYC7yOnoGyLQrgfZGASkCxtkyNl73EjKl
         kB/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4re3tiH3VXBss9cAwCWaF0F9uOgdl82EQBPcYpl5cvpB+g9NscUPQM0f3pTRQDPCvgd1EpyvpPdcMzg74@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qeYTZikN5urGotSJgBZA79yJ+ttagktb4X5/XxYP4Y5SylC7
	lEqWzEgR9dJoiktfRquRfYODvU56o8A6WGvFmmld5IgyuOlB3tb/DQlnMSZSkJsd90wtrpA7EBi
	uAg6ErRbDB5gzrwelIRBj+of49k/HR4FYJOYUVguAuA==
X-Gm-Gg: ASbGnctiCCL5W7gUx4zufl9x+ehDqas71jo4jk5DBtUD6/S8Splk5WVeWEOfFesyRnq
	QiX9gW7+pApY7lgRtAYn5CYU4+59N6xq/R5pcFKhjpZldtC+rPzeHXLKQJfS3Z+fRnQ+eRLTBiS
	VDsniFTnXwpp+hHMev8BtDQUS8ETBEKczgtxCSSla2sv2jTDwdbVeaef4BG5ro5BAt+enqQoJO4
	vJq
X-Google-Smtp-Source: AGHT+IGct8ZeidsnGi/YbFJu4oMvwbFYwPG2diux+p27hnjphdKkPPw2dpGSZ3mXdM1D29x0JXCw0Y4/KsFGm7KlPlM=
X-Received: by 2002:ac8:5d55:0:b0:4af:4bac:e539 with SMTP id
 d75a77b69052e-4b0fdfdb678mr31989691cf.3.1755092985396; Wed, 13 Aug 2025
 06:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250813063407.GA3182745.vipinsh@google.com>
 <mafs0wm77wgjx.fsf@kernel.org>
In-Reply-To: <mafs0wm77wgjx.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Aug 2025 13:49:09 +0000
X-Gm-Features: Ac12FXyj1CElzNmOfajT8FxAkTu6tjsBaL5e4YwqAjZVvEs1xx2b7a4U9Pkl3Fk
Message-ID: <CA+CK2bCmQ3hY+ACnLrVZ1qwiTiVvxEBCDNFmAHn_uVRagvshhw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:29=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> Hi Vipin,
>
> Thanks for the review.
>
> On Tue, Aug 12 2025, Vipin Sharma wrote:
>
> > On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> >> From: Pratyush Yadav <ptyadav@amazon.de>
> >> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preser=
ved_folio *pfolios,
> >> +                                    unsigned int nr_folios)
> >> +{
> >> +    unsigned int i;
> >> +
> >> +    for (i =3D 0; i < nr_folios; i++) {
> >> +            const struct memfd_luo_preserved_folio *pfolio =3D &pfoli=
os[i];
> >> +            struct folio *folio;
> >> +
> >> +            if (!pfolio->foliodesc)
> >> +                    continue;
> >> +
> >> +            folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc=
));
> >> +
> >> +            kho_unpreserve_folio(folio);
> >
> > This one is missing WARN_ON_ONCE() similar to the one in
> > memfd_luo_preserve_folios().
>
> Right, will add.
>
> >
> >> +            unpin_folio(folio);
>
> Looking at this code caught my eye. This can also be called from LUO's
> finish callback if no one claimed the memfd after live update. In that
> case, unpin_folio() is going to underflow the pincount or refcount on
> the folio since after the kexec, the folio is no longer pinned. We
> should only be doing folio_put().
>
> I think this function should take a argument to specify which of these
> cases it is dealing with.
>
> >> +    }
> >> +}
> >> +
> >> +static void *memfd_luo_create_fdt(unsigned long size)
> >> +{
> >> +    unsigned int order =3D get_order(size);
> >> +    struct folio *fdt_folio;
> >> +    int err =3D 0;
> >> +    void *fdt;
> >> +
> >> +    if (order > MAX_PAGE_ORDER)
> >> +            return NULL;
> >> +
> >> +    fdt_folio =3D folio_alloc(GFP_KERNEL, order);
> >
> > __GFP_ZERO should also be used here. Otherwise this can lead to
> > unintentional passing of old kernel memory.
>
> fdt_create() zeroes out the buffer so this should not be a problem.

You are right, fdt_create() zeroes the whole buffer, however, I wonder
if it could be `optimized` to only clear only the header part of FDT,
not the rest and this could potentially lead us to send an FDT buffer
that contains both a valid FDT and the trailing bits contain data from
old kernel.

Pasha

