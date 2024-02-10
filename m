Return-Path: <linux-fsdevel+bounces-11034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F024B850228
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 03:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BCE28911B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 02:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B65C99;
	Sat, 10 Feb 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="E1MTeg84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753C4C6C
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707531710; cv=none; b=FyfWaD98e/bUARAWByhFbc2imLUJQGXnogTbdBF68Ehlo7W4L48O+LjelqofimLMW8UH3F9yjO2OaXYFn9aHme0ovkVXcVDI2foj5myI8j4QLQ6sJWGitmHojG3TLYpr6vrSdMppk7MTQNnmiNgnOQMQpro0UP41FXiATff4TDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707531710; c=relaxed/simple;
	bh=OEsr09Gb3Hzxbc+OG+EIkVQM7fLubAEWg7orSg+gNbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6gZX9Ba9niWeWJr4yy/h/eFyl0mrpj9JhUbmeP4OUUjhPruD8Y44MqzaXBCB6Neomry7ch+mrEOMpBnJrE93RS3k72FJY+ZCAYBwNNOoQ30gMjWQUuWMICJyD4CpRNDilM1FonefjFLkn7TkFoDHvVBKDXnseMt5awIrE4DjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=E1MTeg84 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-219452bdf81so897699fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707531707; x=1708136507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxzMCuaeyhn3J9cU+FUkQXDQEw1s8FDPbrSZbrZddcs=;
        b=E1MTeg84HyX2eWEqdtJvMGUHAsHw4vPk1Srm6/eP/13CA8Tx8MMWNdrD/i6sscuz4l
         9fv6Gs64K4NTqllfuBu3vsarRxrHfYNSsuVBpTc2l0Un0jb9JOZ/TlixloFzfcBdXZz3
         z0TuMS+MaAbQGHLMDunzgJy/a8WYYeY1f5XkbvefPkUSBlLi5fwDhyc4lwq5RO2E1sBx
         kUTHIWvcpC1UhFlnEbxd95JKLlQkoSkd2Sofi3Y8uASJjJgUtZug7k9WbhWdkMsnZEvE
         8fdnO6K7czYOK3g2d/kPvJlRh6RHbNGS6y81kTfaGKdH/RDJ3y2ezLlS3OiDxyIS6loJ
         CWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707531707; x=1708136507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxzMCuaeyhn3J9cU+FUkQXDQEw1s8FDPbrSZbrZddcs=;
        b=Cpf8FV40dmVRStnint5XeRjwLkmqQ/kCWYo+kjHF//v2IJzv2uB5sRdwyskwBf/440
         1gkhNqT9H35UDkgIon0ijSa5gQK9MWKEDKFM2OErOzxzOWsjKWb3+naHiEY+D/zJW4M5
         0FmBt1tQCBTK94fRavhnEIoaXXmNG1cC5V1/dqKCco8/Avslf7LS6Iu5B99PzGl1uPvZ
         yAsyAFcaQdFxO2NZjjSFosMsUAkLr78P3jZthcgQntiWaUtsMgwz28e4D0IA1fDH5LC6
         Z/eNvmU6nnTyv0KSb7DJ4QPBYFaO/Ap7GJWkakwCFPF0xARtZPM8IzJfrDPLkaWnkVhe
         fmWA==
X-Forwarded-Encrypted: i=1; AJvYcCUnkDs4LnE2WRQMdMJIGQ2ofnLDP4+TfW9xTPeykqlv//DhICiUxOvTenCl3j6QHCS5dKfiBF6dLX9nc4nbG0l9I7M/7Iea1OQRRQnD9g==
X-Gm-Message-State: AOJu0YxlKKvCN/eNrkU+hDybgm+AIUTYvex2U5SM8d+QawLsvNTFJcTf
	KnJdGU+RBP3ay94baG6oAnZDMnuqKk3VyAypRF2m/hFyRBEVHSkH4Szj23mD1zlyf3ArP1+U5vM
	dbIDamHZaKqXdO3gd2kNVVilkKAJHcQrr0yKEvA==
X-Google-Smtp-Source: AGHT+IFmCDzBaOTRJEg/f8FLkRS6yQpqqh3yX5ZW6I0WCsOQ72Tibv6RAzofMrIiMT9QniCTSK/5rtfk2WW8zRu6CiM=
X-Received: by 2002:a05:6870:211:b0:218:f001:10bf with SMTP id
 j17-20020a056870021100b00218f00110bfmr1150766oad.35.1707531707564; Fri, 09
 Feb 2024 18:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-2-pasha.tatashin@soleen.com> <8ce2cd7b-7702-45aa-b4c8-25a01c27ed83@arm.com>
In-Reply-To: <8ce2cd7b-7702-45aa-b4c8-25a01c27ed83@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 9 Feb 2024 21:21:10 -0500
Message-ID: <CA+CK2bC=XyUhoSP9f0XBqEnQ-P5mMT2U=5dfzRSc9C=2b+bstQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] iommu/vt-d: add wrapper functions for page allocations
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, rientjes@google.com, bagasdotme@gmail.com, 
	mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

Thank you for reviewing this.

> > +#ifndef __IOMMU_PAGES_H
> > +#define __IOMMU_PAGES_H
> > +
> > +#include <linux/vmstat.h>
> > +#include <linux/gfp.h>
> > +#include <linux/mm.h>
> > +
> > +/*
> > + * All page allocation that are performed in the IOMMU subsystem must use one of
>
> "All page allocations" is too broad; As before, this is only about
> pagetable allocations, or I guess for the full nuance, allocations of
> pagetables and other per-iommu_domain configuration structures which are
> reasonable to report as "pagetables" to userspace.

I will update the comment.


>
> > + * the functions below.  This is necessary for the proper accounting as IOMMU
> > + * state can be rather large, i.e. multiple gigabytes in size.
> > + */
> > +
> > +/**
> > + * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
> > + * specific NUMA node.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
> > +                                                 int order)
> > +{
> > +     struct page *page;
> > +
> > +     page = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
> > +     if (unlikely(!page))
> > +             return NULL;
> > +
> > +     return page;
> > +}
>
> All 3 invocations of this only use the returned struct page to trivially
> derive page_address(), so we really don't need it; just clean up these
> callsites a bit more.

I will remove this function, and update all invocations to use
iommu_alloc_pages_node() directly.


> > + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> > + * @gfp: buddy allocator flags
> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> > +{
> > +     struct page *page;
> > +
> > +     page = alloc_pages(gfp | __GFP_ZERO, order);
> > +     if (unlikely(!page))
> > +             return NULL;
> > +
> > +     return page;
> > +}
>
> Same for the single invocation of this one.

I kept this function, but removed __iommu_alloc_page() that depends on
it. This is because tegra-smmu needs a "struct page" allocator.

>
> > +
> > +/**
> > + * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
> > + *
> > + * returns the struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
> > +{
> > +     return __iommu_alloc_pages_node(nid, gfp, 0);
> > +}
>
> There are no users of this at all.

Yes, I added it just for completeness, I will remove it.


> > + * __iommu_alloc_page - allocate a zeroed page
> > + * @gfp: buddy allocator flags
> > + *
> > + * returns the struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_page(gfp_t gfp)
> > +{
> > +     return __iommu_alloc_pages(gfp, 0);
> > +}
> > +
> > +/**
> > + * __iommu_free_pages - free page of a given order
> > + * @page: head struct page of the page
> > + * @order: page order
> > + */
> > +static inline void __iommu_free_pages(struct page *page, int order)
> > +{
> > +     if (!page)
> > +             return;
> > +
> > +     __free_pages(page, order);
> > +}
> > +
> > +/**
> > + * __iommu_free_page - free page
> > + * @page: struct page of the page
> > + */
> > +static inline void __iommu_free_page(struct page *page)
> > +{
> > +     __iommu_free_pages(page, 0);
> > +}
>
> Beyond one more trivial Intel cleanup for __iommu_alloc_pages(), these 3
> are then only used by tegra-smmu, so honestly I'd be inclined to just
> open-code there page_address()/virt_to_page() conversions as appropriate
> there (once again I think the whole thing could in fact be refactored to
> not use struct pages at all because all it's ever ultimately doing with
> them is page_address(), but that would be a bigger job so definitely
> out-of-scope for this series).

I removed __iommu_free_page(), but kept __iommu_free_pages() variant.

>
> > +
> > +/**
> > + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> > + * specific NUMA node.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
> > + * @order: page order
> > + *
> > + * returns the virtual address of the allocated page
> > + */
> > +static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
> > +{
> > +     struct page *page = __iommu_alloc_pages_node(nid, gfp, order);
> > +
> > +     if (unlikely(!page))
> > +             return NULL;
>
> As a general point I'd prefer to fold these checks into the accounting
> function itself rather than repeat them all over.

For the free functions this saves a few cycles by not repeating this
check again inside __free_pages(), to keep things symmetrical it makes
sense to keep __iomu_free_account and __iomu_alloc_account the same.
With the other clean-up there are not that many of these checks left.

> > + */
> > +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
> > +{
> > +     return iommu_alloc_pages_node(nid, gfp, 0);
> > +}
>
> TBH I'm not entirely convinced that saving 4 characters per invocation
> times 11 invocations makes this wrapper worthwhile :/

Let's keep them. After the clean-up that you suggested, there are
fewer functions left in this file, but I think that it is cleaner to
keep these remaining, as it is beneficial to easily distinguish when
exactly one page is allocated vs when multiple are allocated via code
search.


> > + *
> > + * There are no locking requirement for these pages, as they are going to be
> > + * put on a free list as soon as refcount reaches 0. Pages are put on this LRU
> > + * list once they are removed from the IOMMU page tables. However, they can
> > + * still be access through debugfs.
> > + */
> > +static inline void iommu_free_pages_list(struct list_head *page)
>
> Nit: I'd be inclined to call this iommu_put_pages_list for consistency.

I will rename it to iommu_put_pages_list(), indeed a better name.

>
> > +{
> > +     while (!list_empty(page)) {
> > +             struct page *p = list_entry(page->prev, struct page, lru);
> > +
> > +             list_del(&p->lru);
> > +             put_page(p);
> > +     }
> > +}
>
> I realise now you've also missed the common freelist freeing sites in
> iommu-dma.

Ah yes, thank you for catching that. I will fix it.

Pasha

