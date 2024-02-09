Return-Path: <linux-fsdevel+bounces-10914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A684F3CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F981C2101A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268E31755;
	Fri,  9 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DXIjdvdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5F2D61B;
	Fri,  9 Feb 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475822; cv=none; b=bx8BeZ9D1fmgYrH7AQppLfyhXPUCBoQ8Hqsxy6kb2tn0X0X3vD0+FJ99PTq+Q1D1Mw8KQbOEbBhAeqUWR7CWFB87T1cBiiCMsCTAZe+WQeM6NdORBh0a0scZfEbi7PclvH7SlZIDZP7ib/WLHwXplVykXL72OE9NYJIqP2QuWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475822; c=relaxed/simple;
	bh=1l4xiU706H2waXh/SIkgEpJmrgL3FO4YrpToTkMtbVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGg1Qui0d0SdnzwCu6SOUS0NDIDC2SLVzKTlDy//CuHRMj4OjSPj5HCJfRBb0bF/ZwAwnNV1N1Yayd+jP7rww2s97kzFC3HprQ30tNujYYg3q40X5W8qa8GaQUwtaayFg8J/1biAiqIuoowIWvNrSvbOuFpnJnMir3zGf8c/jIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DXIjdvdY; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 23B431C1D36;
	Fri,  9 Feb 2024 11:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707475819;
	bh=1l4xiU706H2waXh/SIkgEpJmrgL3FO4YrpToTkMtbVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXIjdvdYGrzwWVWMVI6Remj5A1/1opy6lpRHzFIYTZLWyMVxAS0GqiHt0QzLsiugc
	 tvvxaVIiLYwWjLDketPdgB6IjeIzuRQjf0VXRq4uzWaUxF47AnNB7oFkRdbiNpNUbW
	 HDmrYJbED+uweFULqbi7wy+SndFRaeBkGeZFChggfx9o340PcIvRurtq71ONFv2o7f
	 s27ei5GDzj0AfGwrq5wl8tU5tEoNGwWKu9P94P6KWZA0kBrbD2nsaeccZF+eyuQp8t
	 +eQxQXTJDI6ZkcdJbl70Peccoydsny5tIoOXDqlQ72EccI2IjbeNb/kQ6vb3dy6xwO
	 XwUbAf264qglA==
Date: Fri, 9 Feb 2024 11:50:17 +0100
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
Subject: Re: [PATCH v4 00/10] IOMMU memory observability
Message-ID: <ZcYDaTRhQLaBAZ5H@8bytes.org>
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207174102.1486130-1-pasha.tatashin@soleen.com>

Hi Pasha,

On Wed, Feb 07, 2024 at 05:40:52PM +0000, Pasha Tatashin wrote:
> v4:
> - Synced with v6.8-rc3 
> - Updated commit log for "iommu: account IOMMU allocated memory" as
>   suggested by Michal Koutný
> - Added more Acked-bys David Rientjes and Thierry Reding
> - Added Tested-by Bagas Sanjaya.

Thanks for these changes! To merge them I need more reviews and/or acks
from the actual iommu driver maintainers.

Thanks,

	Joerg

