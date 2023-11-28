Return-Path: <linux-fsdevel+bounces-4100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020957FCB94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD091F20D46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2CEDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5330819B0;
	Tue, 28 Nov 2023 14:47:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1F11FB;
	Tue, 28 Nov 2023 14:47:56 -0800 (PST)
Received: from [10.57.71.132] (unknown [10.57.71.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40BF3F6C4;
	Tue, 28 Nov 2023 14:47:00 -0800 (PST)
Message-ID: <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
Date: Tue, 28 Nov 2023 22:46:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
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
 <20231128204938.1453583-6-pasha.tatashin@soleen.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128204938.1453583-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> Convert iommu/io-pgtable-arm-v7s.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 75f244a3e12d..3d494ca1f671 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -34,6 +34,7 @@
>   #include <linux/types.h>
>   
>   #include <asm/barrier.h>
> +#include "iommu-pages.h"
>   
>   /* Struct accessors */
>   #define io_pgtable_to_data(x)						\
> @@ -255,7 +256,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>   		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
>   
>   	if (lvl == 1)
> -		table = (void *)__get_free_pages(gfp_l1 | __GFP_ZERO, get_order(size));
> +		table = iommu_alloc_pages(gfp_l1, get_order(size));
>   	else if (lvl == 2)
>   		table = kmem_cache_zalloc(data->l2_tables, gfp);

Is it really meaningful to account the L1 table which is always 
allocated upon initial creation, yet not the L2 tables which are 
allocated in use?

Thanks,
Robin.

> @@ -283,6 +284,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>   	}
>   	if (lvl == 2)
>   		kmemleak_ignore(table);
> +
>   	return table;
>   
>   out_unmap:
> @@ -290,7 +292,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>   	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
>   out_free:
>   	if (lvl == 1)
> -		free_pages((unsigned long)table, get_order(size));
> +		iommu_free_pages(table, get_order(size));
>   	else
>   		kmem_cache_free(data->l2_tables, table);
>   	return NULL;
> @@ -306,8 +308,9 @@ static void __arm_v7s_free_table(void *table, int lvl,
>   	if (!cfg->coherent_walk)
>   		dma_unmap_single(dev, __arm_v7s_dma_addr(table), size,
>   				 DMA_TO_DEVICE);
> +
>   	if (lvl == 1)
> -		free_pages((unsigned long)table, get_order(size));
> +		iommu_free_pages(table, get_order(size));
>   	else
>   		kmem_cache_free(data->l2_tables, table);
>   }

