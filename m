Return-Path: <linux-fsdevel+bounces-11366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345185317A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED4C28AD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D055C14;
	Tue, 13 Feb 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCIC4VOm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DF55784;
	Tue, 13 Feb 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829943; cv=none; b=QSvvzPCgh9NEKzhmEoL4YKzy6PB76P1rcL6edUZPji/tBP/I8KHytw7DURkPqTrVc262XrPQamixx57N1P9CmDuJtQvuX8EUINPea67u1bYeT7jmkQOkRaJFtIV+dV1hhmbpokt1z3JArp6eutqB8z7R3cz7zbFbbQyuX6LIUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829943; c=relaxed/simple;
	bh=0xP8I+Qej1cBpPDnNiDZJmh7/DqD49joD1ERj3DvfKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY7av0wuYZHZgIEfs4H1OVltkgaPv2W1/EFweAyiTDgtpUxV1RieadKubrlth2Fq0PmYAQGUWwBLSJAzUkFKBYGtSgiYvsU3AaB9txG2TQAXwIdtrqAtF1zP74llHWPPE8zZjwYi1PE3JVMtcCJzVf6K5cusT5wNXm9ubar+hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCIC4VOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8FFC433C7;
	Tue, 13 Feb 2024 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707829942;
	bh=0xP8I+Qej1cBpPDnNiDZJmh7/DqD49joD1ERj3DvfKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCIC4VOmOV8x0JsCqVrhzsGXz5txq4HxyFPJQRNTQh3KKT2Il8RF8+xeahTD5vCl5
	 Kektsz/mfJ/JF35E4m5MMed5MRfMr6AfYG18l3OHogPx0QMHtC27U91R9ksMBhJ7LC
	 QrvfK3L/7OQ2iqeglywl+CEqt2Kk1nqFfANGVdzwrbq09GCHd1PFvhMsW+yndJN2EI
	 7AKa7uQuypabSxDDmx7RIiGt05YBvnxfcDyb7e4cAzPNfO0Its8Aro6czQ6i5gQbBA
	 2KpPkjnKmYQ164gn/9NIeHWvTjE9mVJFzcMrCxOJS/SnPSYLIExFrgWV58G9p+7QNg
	 Scf3fQWeQ5fiA==
Date: Tue, 13 Feb 2024 13:12:11 +0000
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
Message-ID: <20240213131210.GA28926@willie-the-truck>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226200205.562565-11-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Pasha,

On Tue, Dec 26, 2023 at 08:02:05PM +0000, Pasha Tatashin wrote:
> In order to be able to limit the amount of memory that is allocated
> by IOMMU subsystem, the memory must be accounted.
> 
> Account IOMMU as part of the secondary pagetables as it was discussed
> at LPC.
> 
> The value of SecPageTables now contains mmeory allocation by IOMMU
> and KVM.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  Documentation/filesystems/proc.rst      | 4 ++--
>  drivers/iommu/iommu-pages.h             | 2 ++
>  include/linux/mmzone.h                  | 2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3f85254f3cef..e004e05a7cde 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1418,7 +1418,7 @@ PAGE_SIZE multiple when read back.
>  	  sec_pagetables
>  		Amount of memory allocated for secondary page tables,
>  		this currently includes KVM mmu allocations on x86
> -		and arm64.
> +		and arm64 and IOMMU page tables.
>  
>  	  percpu (npn)
>  		Amount of memory used for storing per-cpu kernel
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 49ef12df631b..86f137a9b66b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1110,8 +1110,8 @@ KernelStack
>  PageTables
>                Memory consumed by userspace page tables
>  SecPageTables
> -              Memory consumed by secondary page tables, this currently
> -              currently includes KVM mmu allocations on x86 and arm64.
> +              Memory consumed by secondary page tables, this currently includes
> +              KVM mmu and IOMMU allocations on x86 and arm64.

While I can see the value in this for IOMMU mappings managed by VFIO,
doesn't this end up conflating that with the normal case of DMA domains?
For systems that e.g. rely on an IOMMU for functional host DMA, it seems
wrong to subject that to accounting constraints.

Will

