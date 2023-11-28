Return-Path: <linux-fsdevel+bounces-4102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7397FCB96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CED282C87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811801863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91D9B8F;
	Tue, 28 Nov 2023 14:53:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8943E2F4;
	Tue, 28 Nov 2023 14:54:01 -0800 (PST)
Received: from [10.57.71.132] (unknown [10.57.71.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723B13F6C4;
	Tue, 28 Nov 2023 14:53:06 -0800 (PST)
Message-ID: <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
Date: Tue, 28 Nov 2023 22:53:04 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by
 iommu-pages.h
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 alex.williamson@redhat.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io,
 asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
 iommu@lists.linux.dev, jasowang@redhat.com, jernej.skrabec@gmail.com,
 jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, kevin.tian@intel.com,
 krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st,
 mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com,
 netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org,
 samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
 thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
 vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
 will@kernel.org, yu-cheng.yu@intel.com
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128204938.1453583-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> Convert iommu/fsl_pamu.c to use the new page allocation functions
> provided in iommu-pages.h.

Again, this is not a pagetable. This thing doesn't even *have* pagetables.

Similar to patches #1 and #2 where you're lumping in configuration 
tables which belong to the IOMMU driver itself, as opposed to pagetables 
which effectively belong to an IOMMU domain's user. But then there are 
still drivers where you're *not* accounting similar configuration 
structures, so I really struggle to see how this metric is useful when 
it's so completely inconsistent in what it's counting :/

Thanks,
Robin.

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/fsl_pamu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index f37d3b044131..7bfb49940f0c 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -16,6 +16,7 @@
>   #include <linux/platform_device.h>
>   
>   #include <asm/mpc85xx.h>
> +#include "iommu-pages.h"
>   
>   /* define indexes for each operation mapping scenario */
>   #define OMI_QMAN        0x00
> @@ -828,7 +829,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>   		(PAGE_SIZE << get_order(OMT_SIZE));
>   	order = get_order(mem_size);
>   
> -	p = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	p = __iommu_alloc_pages(GFP_KERNEL, order);
>   	if (!p) {
>   		dev_err(dev, "unable to allocate PAACT/SPAACT/OMT block\n");
>   		ret = -ENOMEM;
> @@ -916,7 +917,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>   		iounmap(guts_regs);
>   
>   	if (ppaact)
> -		free_pages((unsigned long)ppaact, order);
> +		iommu_free_pages(ppaact, order);
>   
>   	ppaact = NULL;
>   

