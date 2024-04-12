Return-Path: <linux-fsdevel+bounces-16793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F68A2BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F161F24495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6153E0C;
	Fri, 12 Apr 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LuZbLWJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8A53373;
	Fri, 12 Apr 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916619; cv=none; b=n2hMJmaXIUdCyPKIxKqycwkw8bwG++A9yWUF2tve7JS5jrsay5L21WpXLZpbQy4jWqG2vU2T7KEo1pVbWSQ6ykaCN568fchV5f9Aly2Wwh86R8OlE1fMYwVC0nuMNzjmheANhHUJg0uomGKl0AaoGZrPZX75DGVJh2il0XbKqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916619; c=relaxed/simple;
	bh=E+iVkylCqaTgNVotthxWDOOoCqml/4nGJOpaARXTjK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obYLr5ka/CzZ5wBcAYioLpi6ofINDwBNK9+5O6FlmPJWUY8nW1lD+vjj/zPnEOM+00NTqUgNZ5W/tAJsj/GyZDD/DG4L8gA91V6MCIhA3SXCnHHbWakYHX9mTs8awcTHWw2Lo/ZByg0vyqM+WjFe6Be6kF7czZcoIeJ1ZvKdDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=LuZbLWJP; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 51047281A38;
	Fri, 12 Apr 2024 12:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916616;
	bh=E+iVkylCqaTgNVotthxWDOOoCqml/4nGJOpaARXTjK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuZbLWJPGCLZJPltogQTsk4oQ9NTj4Tsj7ifX4XmlHt9dm9BjBk7wNSRnJEGBBLX0
	 RR1K295opyq8KNseqPbA6/RWBABghoCfLVi53gLBIUssvvge/FC7qptmqVDcplhzTo
	 XuBmaDg9QBQ/vnZqdaxAREDkzJpp0Wy4QVBWKVDHOT7296ofu/w9sV3sUJl9A78VIT
	 Q8HYmCNyUOwMBct7Se9mdxxPDMr4hl0kzCGipNnFTmrP6p8lRL075rML4+cOeADLWK
	 3bfKf9EbMlshGtJnw/aGnFdGxYsmOkfVQGWHlFj/MJ94e75Lh2o+bnyCKL3btAMYV6
	 t2ODbB7AbBEpQ==
Date: Fri, 12 Apr 2024 12:10:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com,
	bagasdotme@gmail.com, mkoutny@suse.com
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
Message-ID: <ZhkIhtTCWg6bgl1o@8bytes.org>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>

Pasha,

On Thu, Feb 22, 2024 at 05:39:26PM +0000, Pasha Tatashin wrote:
> Pasha Tatashin (11):
>   iommu/vt-d: add wrapper functions for page allocations
>   iommu/dma: use iommu_put_pages_list() to releae freelist
>   iommu/amd: use page allocation function provided by iommu-pages.h
>   iommu/io-pgtable-arm: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-dart: use page allocation function provided by
>     iommu-pages.h
>   iommu/exynos: use page allocation function provided by iommu-pages.h
>   iommu/rockchip: use page allocation function provided by iommu-pages.h
>   iommu/sun50i: use page allocation function provided by iommu-pages.h
>   iommu/tegra-smmu: use page allocation function provided by
>     iommu-pages.h
>   iommu: observability of the IOMMU allocations
>   iommu: account IOMMU allocated memory

Some problems with this:

  1. I get DKIM failures when downloading this patch-set with b4, can
     you please send them via a mailserver with working DKIM?

  2. They don't apply to v6.9-rc3. Please rebase to that version and
     are-send.

Thanks,

	Joerg

