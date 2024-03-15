Return-Path: <linux-fsdevel+bounces-14546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0287D667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 22:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4201F22AAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A855C19;
	Fri, 15 Mar 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ejWnM7Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AD38F91;
	Fri, 15 Mar 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539614; cv=none; b=fEGVIS8PBI8yvee7EP4mwDtC7RmvjxqZu9vhDRezSoWt5udaaGyHB+mIqjZiNqoyu0kRHjWdeyH8NpIwXncNSgVxf6k2V0hEv7wDvBeiTQlqCXyP3Rx0vrY2VTCIzN1t0Iyq44JnKggtBp9J9EBs0t1KBSML8aqOb1clJZNxVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539614; c=relaxed/simple;
	bh=jhM7ZU8FyIla2o0H5m42cLWxc85vKv1rzCK2ST8oj+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEnMIUls7Ete+pleowEj5WeYn2G6IlmefS71DwSQ0jKZ9YpyL8335l1xr6NjjX4fTiwJr8WOT3NbD1d8zSrJ6DikefgqSEqFZWHboCn/C95efpnRE5HF96OJVOmMNb/8S7ZlkPsBnz9oBtYpWZxRY8c6d71+XHcW68p/KZgyYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ejWnM7Jj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1C8531E2193;
	Fri, 15 Mar 2024 22:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1710539602;
	bh=jhM7ZU8FyIla2o0H5m42cLWxc85vKv1rzCK2ST8oj+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejWnM7JjNgo1Ys7WJ+duORdqNChXIKawPJHEGPvKzhkkfIAJlfXspOCr+eQiMME96
	 tsTNs3axuK/FqxnqYzLYkhwGHhTDgI6Cdp6ZKqqXu7KW7v9HCNEeuqiwmAad9NsHgd
	 lq+LllK57GAVJFVoam7Sf8tvQ9nx4V+81+F0a32IC+o8INOLldtxyrDbk2lIuD0/Iq
	 tbEjEEqioSbWbO88Xjro/jyflz8JvdRxBIwvkrBbje7A/LU8xIgIDkO6vb/wAwlPza
	 ylpM/bpodX485nATx/iDV9D/v0w1o7eJtSGgjBG0OqY6jWlAfbe2CebOkr+Ex3MpAg
	 U7tplkqnSgVoQ==
Date: Fri, 15 Mar 2024 22:53:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com,
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
	will@kernel.org, yu-cheng.yu@intel.com, bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
Message-ID: <ZfTDUGSshZUbs13-@8bytes.org>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <00555af4-8786-b772-7897-aef1e912b368@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00555af4-8786-b772-7897-aef1e912b368@google.com>

Hi David,

On Fri, Mar 15, 2024 at 02:33:53PM -0700, David Rientjes wrote:
> Joerg, is this series anticipated to be queued up in the core branch of 
> git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git so it gets into 
> linux-next?
> 
> This observability seems particularly useful so that we can monitor and 
> alert on any unexpected increases (unbounded memory growth from this 
> subsystem has in the past caused us issues before the memory is otherwise 
> not observable by host software).
> 
> Or are we still waiting on code reviews from some folks that we should 
> ping?

A few more reviews would certainly help, but I will also do a review on
my own. If things are looking good I can merge it into the iommu tree
when 6.9-rc3 is released (which is the usual time I start merging new
stuff).

Regards,

	Joerg

