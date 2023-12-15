Return-Path: <linux-fsdevel+bounces-6228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E2A8151B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A600FB23481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BED48CFC;
	Fri, 15 Dec 2023 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N6wBlilf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2265639E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so709513fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 13:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702674715; x=1703279515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9KJ+4BbcKeSEG7077PFa7FVZHENUrxS+8ivlb7RAxY=;
        b=N6wBlilfI55+czR8cmZ6G0UtIUVB0bXS/J8gqZ7UM8gyFPhprH55om1aQkAYd/i0ey
         8u3McsxGkx7smNVvNhmwVXU4cSM1MQXM12tjl2Vu2s0gn0aAvZ67W7yJXfBjlyKY/qoT
         MZEnUf7RV29cPfcPyqHiGrV+GA0/e+QFdZUcyIPg53U5I0i+dxOWo2J6l/Cq5lsKJsVC
         trjpTAOGuNYPhDUQeR3L8e9Vrzyx0/VnySWOR0eM+nuTM/vg8xiElSOn4a9IuzBTfQ+f
         CFl+xVEosabj7YSjngBL7c1C75lZl7pTBNFy9MyGLUXlt8XRnrKZtW8aM7zsL4g0BRvU
         DHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674715; x=1703279515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9KJ+4BbcKeSEG7077PFa7FVZHENUrxS+8ivlb7RAxY=;
        b=pOgffQ6E7FPhgM5kn3RvZUX+EgNkw+HjkObM+4Q71OwEgMDpIwv/lLFEB48Cv0LjZP
         VyTNVelGlPnKYUpGQcaO2WY/XR7oKinEV7uE4QoTciHVu6r3wyGpCK4o0JSR6ymDm7fb
         8C0qpzV6zEn6CVCATadgfbYm4+h0hxHhRhVjoajf+5dPKnJ1ONDvyEJCHKVI2x554v89
         LLtwW6IZd6C36NMe4/TNVQ22h7gGyV3GYv4qUG9gJmXiiLathVATxyRH/nWLswIljrLa
         Rh2/AMJk/tIqRPocITsXmX6ZxNmetu1cg0tRJILnDpGD1a0qPSA/8/xmWDfr2NIq7mCt
         +aSQ==
X-Gm-Message-State: AOJu0Yz9HXNgEo3vydIkWMoliy8iC+YMZmxj3qr8FWB/adC8C7go8+yy
	wUwUlaWOb1QYl/+n7T/UFcvyPLkMv1u0RdKURhYpVQ==
X-Google-Smtp-Source: AGHT+IFHrLpndT4XCwAesdcyNwQf00aMOvX02D4/8uxdog8acvbjKfsi57jpp2aqEyynfGVCKlt0IXuLjUhCsHgb3nk=
X-Received: by 2002:a05:6870:c09:b0:203:7ccc:b6e8 with SMTP id
 le9-20020a0568700c0900b002037cccb6e8mr1214533oab.25.1702674715317; Fri, 15
 Dec 2023 13:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-11-pasha.tatashin@soleen.com> <c0d23d3e-39e6-57af-fd38-eb1b885d7da4@google.com>
In-Reply-To: <c0d23d3e-39e6-57af-fd38-eb1b885d7da4@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 15 Dec 2023 16:11:18 -0500
Message-ID: <CA+CK2bD0Wz8mzB_BGKEYKCHRJKKVwr0CPK7OOC0tD_Sxi5Rp5g@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] iommu: account IOMMU allocated memory
To: David Rientjes <rientjes@google.com>
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
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 3f85254f3cef..e004e05a7cde 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1418,7 +1418,7 @@ PAGE_SIZE multiple when read back.
> >         sec_pagetables
> >               Amount of memory allocated for secondary page tables,
> >               this currently includes KVM mmu allocations on x86
> > -             and arm64.
> > +             and arm64 and IOMMU page tables.
>
> Hmm, if existing users are parsing this field and alerting when it exceeds
> an expected value (a cloud provider, let's say), is it safe to add in a
> whole new set of page tables?
>
> I understand the documentation allows for it, but I think potential impact
> on userspace would be more interesting.

Hi David,

This is something that was discussed at LPC'23. I also was proposing a
separate counter for iommu page tables, but it was noted that we
specifically have sec_pagetables called this way to include all non
regular CPU page tables, and we should therefore account for them
together.

Please also see this discussion from the previous version of this patch series:
https://lore.kernel.org/all/CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com/

Pasha

