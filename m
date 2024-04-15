Return-Path: <linux-fsdevel+bounces-16923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C78A4F13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF901F21E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB46CDD5;
	Mon, 15 Apr 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FB7CdJGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD6EEBB;
	Mon, 15 Apr 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184405; cv=none; b=rzsFTX1z5vvjhduVycGBFZIP144GsXFJZrotPuoOfFTMNQCbpLSDbdC8YTN4ip9bNK6kIHMHwE+IgLQcn3M0uXvsQWu3Ju1trxSp7JIVcIdrpd3GbkvsqmSs3Tfe6noCoPNF7JQ9wTqpcsMV/vUeVugwIe18oE/4At1/glGFeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184405; c=relaxed/simple;
	bh=HfptntNOfLHxb9wL0IOVawcV6uR4l3OZGayJ1zAWzo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpM90FjiQG6c817fZcYG1KfQQyKWD1qrAj+1edg3cXIfGmWyEUT7OISK1g25zswX3P18IDfuOAW2Cp3Qgd44kSMGCEfp+p95u+mBtUD05OW2qUq0Db/6mc9hbxp4Z3EjIbd4AFPQCLIkKYHenOikPRnX/4CW3+/DeOPNsSiNyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FB7CdJGo; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1427F1C68D0;
	Mon, 15 Apr 2024 14:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1713184399;
	bh=HfptntNOfLHxb9wL0IOVawcV6uR4l3OZGayJ1zAWzo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB7CdJGoYiLUXNXxPvv8kxRp0MDw5ZnPm7BIK3ADkbk8oSMbIlG1dOJST10Ys0iVG
	 0qH7FXMf173WxTDGWYAj57PHdCnXDNhPtGD9jDi61cO/bs1sgIAfqFxvSoK9m2A9ss
	 V9SsvwyT4trOUwcVoattW6RpORUYGkpdOaQm3KBj4D4r/W12fVXjh9qkHjlwypEZMm
	 wZyw+pBBc2Nxoj847ZC+5GLtJO11Cj8rX2d0KMsV/1lstgG3Zpav64UvQflXFDpjD3
	 cZkiC/AZwyMk/jjcSbeCrSYgzIuKoCKCfVPm6zDqV7hVX7mY/mCvW+dsSHn/oXe8DJ
	 dyfbkCVsl9bHg==
Date: Mon, 15 Apr 2024 14:33:17 +0200
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
Subject: Re: [PATCH v6 00/11] IOMMU memory observability
Message-ID: <Zh0ejbLiZT4gI3EG@8bytes.org>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>

On Sat, Apr 13, 2024 at 12:25:11AM +0000, Pasha Tatashin wrote:
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

Applied to the temporary 'memory-observability' branch and part of
iommu-next. Thanks Pasha.


