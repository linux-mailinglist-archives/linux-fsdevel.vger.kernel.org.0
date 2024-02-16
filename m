Return-Path: <linux-fsdevel+bounces-11877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1C8584AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8C3281D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A2133994;
	Fri, 16 Feb 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT6IeXcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F9131756;
	Fri, 16 Feb 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106284; cv=none; b=jYZAN1SQ5Q0H78Tv4vhc+pnAZ/60omxJ7f8wtKtD4R3i2/21TNTp45qwmke+PjPkxaOgQpzPBMwSN8yC7joyHHqhsyT5U7U0jicqDLAQxGE+iGXIuAVgpc+U0uw1tjeO411j77BKfG3drmWja4vU33NWrWu0W8b49nf5F/tJnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106284; c=relaxed/simple;
	bh=y2z4Q/0wnbBdLLtyxBXxt5K2cw4Zk8wNIb/HNMYSK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn74lpXKleh49luNnAaoBQIyzFXHS0w1A5aNmo6OLq31OFUKgZ/J9sJ1f9aYxt/sA1INFj8S4Y8YDBp06mclJrMYYWO7VrUJbMq96L9pWS863U1cKPzPPq5kzoE74cf/8/Hqh1vqkCLw+9YdRV5K+pkgqg491HD30kldIqLwIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT6IeXcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53326C433C7;
	Fri, 16 Feb 2024 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106283;
	bh=y2z4Q/0wnbBdLLtyxBXxt5K2cw4Zk8wNIb/HNMYSK+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT6IeXcB5A43SSuF9BwUjII4ilTrRHMPvyzAnUo1omQItjPLdK1yI1D9r6AZeDJjT
	 Lwec75FjdfHRyDok4qKpynzHaY+jVireNBdMEX/3sIKAUUpmIhEG7WzhREkQiExlla
	 CgQQTgxXPyDIS10jW64uzXwfZpoYlaicR7QgPuL2AkSdV1armgqhtJ8YVi3RmIUsAl
	 Q2sDUO4AfPf2tDL7JF+EOIX5LDDCQbncjtrRPNNl7ClDtX9p0Tr4GtgrGyYSwu7tru
	 dgGCbrO+S2RC7zBGm+KqHvQrvfNlefg2300BnAO27KjDWBt5rkFi4I/om5XiQtrGtZ
	 +tSr/4cauSzEg==
Date: Fri, 16 Feb 2024 17:57:52 +0000
From: Will Deacon <will@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	yu-cheng.yu@intel.com, rientjes@google.com
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
Message-ID: <20240216175752.GB2374@willie-the-truck>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com>
 <20240213131210.GA28926@willie-the-truck>
 <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 13, 2024 at 10:44:53AM -0500, Pasha Tatashin wrote:
> > >  SecPageTables
> > > -              Memory consumed by secondary page tables, this currently
> > > -              currently includes KVM mmu allocations on x86 and arm64.
> > > +              Memory consumed by secondary page tables, this currently includes
> > > +              KVM mmu and IOMMU allocations on x86 and arm64.
> 
> Hi Will,
> 
> > While I can see the value in this for IOMMU mappings managed by VFIO,
> > doesn't this end up conflating that with the normal case of DMA domains?
> > For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> > wrong to subject that to accounting constraints.
> 
> The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
> is passed to the iommu mapping functions. We do that from the vfio,
> iommufd, and vhost. Without this flag, the memory useage is reported
> in /proc/meminfo as part of  SecPageTables field, but not constrained
> in cgroup.

Thanks, Pasha, that explanation makes sense. I still find it bizarre to
include IOMMU allocations from the DMA API in SecPageTables though, and
I worry that it will confuse people who are using that metric as a way
to get a feeling for how much memory is being used by KVM's secondary
page-tables. As an extreme example, having a non-zero SecPageTables count
without KVM even compiled in is pretty bizarre.

Will

