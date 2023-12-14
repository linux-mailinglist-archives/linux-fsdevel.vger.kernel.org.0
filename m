Return-Path: <linux-fsdevel+bounces-6133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48469813A92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799221C20CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98069783;
	Thu, 14 Dec 2023 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZprlJCGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88E69787
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-425e63955f6so22129341cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702581441; x=1703186241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2wAVapsX3d4Wu5zcLkO1Y9GXGGh0W89rcgF3jgTa1I=;
        b=ZprlJCGrVSIpyUiDmp2/IzTG6YFUGMyWp9w+Ix9/Vj2z3UtQz6rlen2BjAWSlirmBy
         nv79chpSvzOUg+bsKPB0SLk1O5HCCC0KKuwg0wSlyI5ky2A0b3pFl+naX28MxmWx8kYM
         kcXSOpRLqDe56ncRyS/kqAGl4M/A4ZwjCZfTy/QV8piACkozLHePd0iEY3COnM3+PxOp
         7v6mcLVGFjGFYNGQW2BK1ZTxwqhciMzzrIvjxAGDoj3sdF6p8zfGjXbfnMdYSv3EpiFy
         rBF4w2t32Z0cTgi3L1IvRNPcr+ycvFAaMq9vON6sbKX6R6Fh1SX2MO4EU1JHMxtqav4x
         vvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581441; x=1703186241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2wAVapsX3d4Wu5zcLkO1Y9GXGGh0W89rcgF3jgTa1I=;
        b=Pp3BN/pq0mTlRBLNwKIxePpN34dEn1bo4XkUDWk5mecbA3WI5ps5mCaeAfqPOdZUxK
         zXT6HENnpKonBK9MlYpZpx/Hi5Jf6zJSKVtUuJBKwJh+69N0wHaGM5P01SSkKzBvWUjS
         ADC78LAASLf9omd0M4CLHfYomPR+uIPnC8vkvYJzidEAsOlE0mQEJ9yaHxZwDNSDjpk9
         GIT23+kh5ZGDelPV7tTCcFNpX2d/hPyXWjjpJQtLOxCEuCjAQxcCWxnleWW/ShRPzY0i
         iosprwnn2NCtFalbNzrtHAyUW3CNm88KCR1jFCulSXqQpjLffx7TeMkUE4KXHupkjeTI
         90Zg==
X-Gm-Message-State: AOJu0YzdY23jtmsq6fPEHrUunw9d5MLxrIzlrDviCreAbTkxHOAIImKE
	8voKBJsTe07pJ/Vp2EYwZc2W2sNWd/SjW2uRCU+Heg==
X-Google-Smtp-Source: AGHT+IFzRCB9Md6JcXtZ2Es25f4UOuYMeLP9Itx6hDPrn436g7L6e3bJmetcIjga0ApETmdpPvmDW7XHrih7qp2afIE=
X-Received: by 2002:a05:622a:452:b0:423:a4f6:9aa2 with SMTP id
 o18-20020a05622a045200b00423a4f69aa2mr12441941qtx.6.1702581441062; Thu, 14
 Dec 2023 11:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
In-Reply-To: <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Dec 2023 14:16:44 -0500
Message-ID: <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page allocations
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com, 
	alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, 
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:58=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>
> > diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> > new file mode 100644
> > index 000000000000..2332f807d514
> > --- /dev/null
> > +++ b/drivers/iommu/iommu-pages.h
> > @@ -0,0 +1,199 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2023, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +#ifndef __IOMMU_PAGES_H
> > +#define __IOMMU_PAGES_H
> > +
> > +#include <linux/vmstat.h>
> > +#include <linux/gfp.h>
> > +#include <linux/mm.h>
> > +
> > +/*
> > + * All page allocation that are performed in the IOMMU subsystem must =
use one of
> > + * the functions below.  This is necessary for the proper accounting a=
s IOMMU
> > + * state can be rather large, i.e. multiple gigabytes in size.
> > + */
> > +
> > +/**
> > + * __iommu_alloc_pages_node - allocate a zeroed page of a given order =
from
> > + * specific NUMA node.
> > + * @nid: memory NUMA node id
>
> NUMA_NO_NODE if no locality requirements?

If no locality is required, there is a better interface:
__iommu_alloc_pages(). That one will also take a look at the calling
process policies to determine the proper NUMA node when nothing is
specified. However, when policies should be ignored, and no locality
required, NUMA_NO_NODE can be passed.

>
> > + * @gfp: buddy allocator flags
> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp=
,
> > +                                                 int order)
> > +{
> > +     struct page *pages;
>
> s/pages/page/ here and later in this file.

In this file, where there a page with an "order", I reference it with
"pages", when no order (i.e. order =3D 0), I reference it with "page"

I.e.: __iommu_alloc_page vs. __iommu_alloc_pages

>
> > +
> > +     pages =3D alloc_pages_node(nid, gfp | __GFP_ZERO, order);
> > +     if (!pages)
>
> unlikely()?

Will add it.

>
> > +             return NULL;
> > +
> > +     return pages;
> > +}
> > +
> > +/**
> > + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> > + * @gfp: buddy allocator flags
> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> > +{
> > +     struct page *pages;
> > +
> > +     pages =3D alloc_pages(gfp | __GFP_ZERO, order);
> > +     if (!pages)
> > +             return NULL;
> > +
> > +     return pages;
> > +}
> > +
> > +/**
> > + * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA n=
ode.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
> > + *
> > + * returns the struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
> > +{
> > +     return __iommu_alloc_pages_node(nid, gfp, 0);
> > +}
> > +
> > +/**
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
> > + * @pages: head struct page of the page
>
> I think "pages" implies more than one page, this is just a (potentially
> compound) page?

Yes, more than one page, basically, when order may be > 0.

> > +/**
> > + * iommu_free_page - free page
> > + * @virt: virtual address of the page to be freed.
> > + */
> > +static inline void iommu_free_page(void *virt)
> > +{
> > +     iommu_free_pages(virt, 0);
> > +}
> > +
> > +/**
> > + * iommu_free_pages_list - free a list of pages.
> > + * @pages: the head of the lru list to be freed.
>
> Document the locking requirements for this?

Thank you for the review. I will add info about locking requirements,
in fact they are very relaxed.

These pages are added to the list by unmaps or remaps operation in
Intel IOMMU implementation. These calls assume that whoever is doing
those operations has exclusive access to the VA range in the page
table of that operation. The pages in this freelist only belong to the
former page-tables from the IOVA range for those operations.

> > + */
> > +static inline void iommu_free_pages_list(struct list_head *pages)
> > +{
> > +     while (!list_empty(pages)) {
> > +             struct page *p =3D list_entry(pages->prev, struct page, l=
ru);
> > +
> > +             list_del(&p->lru);
> > +             put_page(p);
> > +     }
> > +}

