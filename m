Return-Path: <linux-fsdevel+bounces-10933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30684F496
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF91F2AC2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EF2E407;
	Fri,  9 Feb 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YdAD4LbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1802E40F;
	Fri,  9 Feb 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477977; cv=none; b=i+NDVbfCBz525g1w60zjBlA2Joz25lHyKkTZBbuZ8sX6awNVnwGt272wOm0qBEfpOYk7FwG1j8HUPy1oxKdbEnzE3k3oXl23R8ssLTQOvuZMNY9xaRNrnQZrV4v+/YzeXUoMsqhqo7yONY2kpcQo5VH5EKI9XmH6RI0p8KnkW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477977; c=relaxed/simple;
	bh=LlFG5OHsURXc51nizpCRAFTTa0l9BgimKbifcwMflh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=PfwZqoxO4B+7n2ExPl9S/FCpVxSwwbU5rK6MYdn5WV9VOImOTbfkextumi2Pi9OS3skOmoz/3dx5ceZttOo8YI1EV1sCfbs+nxNQB0y3B2nSLS4KAj/Ryq8G8yjBs/fSOBfMhVCWiQxc4VHtAHqMww4bwv8oaWCtNbQx9lEaXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YdAD4LbV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209112612euoutp02e7afcd652788447d16f24e353ee6eec4~yLitwV40s1148511485euoutp02k;
	Fri,  9 Feb 2024 11:26:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209112612euoutp02e7afcd652788447d16f24e353ee6eec4~yLitwV40s1148511485euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707477972;
	bh=5LC74cW+Fbdz3s4xIgDv8lYzBx2xOsdxE4BOP4kFzgE=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=YdAD4LbVjFg8tZee0Q+ZGs7/X816uHjBEb2EBoMWE5MsD1ptbrdSiVrLX7p+bxYTM
	 +ZKYmvhY6flz7/CqS5GZfF0XTXM+n2+VO1W7ks7Eeo9kiolXDvci0TC/9tTZ1EDld6
	 Fbos9VIMlHfc+QH8/vC9Eam5S8D4OXc3N2q6HFEY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209112612eucas1p189aa0d19a71218f7119cb52436b8269d~yLiti3I1-3086330863eucas1p15;
	Fri,  9 Feb 2024 11:26:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.46.09552.4DB06C56; Fri,  9
	Feb 2024 11:26:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209112612eucas1p27996a26c0866043ae96f9240ed7680b9~yLitBvhuf2354223542eucas1p2M;
	Fri,  9 Feb 2024 11:26:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209112612eusmtrp2b90f15aeb3ffdcd96ed8c0eb14f7a289~yLitAmzRP1526215262eusmtrp2R;
	Fri,  9 Feb 2024 11:26:12 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-60-65c60bd47bdb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.71.09146.3DB06C56; Fri,  9
	Feb 2024 11:26:11 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209112609eusmtip1be13c5e6f826b7e71540651fd316dc7a~yLirDTnKD2008820088eusmtip1p;
	Fri,  9 Feb 2024 11:26:09 +0000 (GMT)
Message-ID: <a1c452f9-c265-4934-82c2-8c9278d087ec@samsung.com>
Date: Fri, 9 Feb 2024 12:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] iommu/exynos: use page allocation function
 provided by iommu-pages.h
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org,
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com,
	rientjes@google.com, bagasdotme@gmail.com, mkoutny@suse.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240207174102.1486130-6-pasha.tatashin@soleen.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3pvb28xZZeK4YxpUIZEkYdOl5yNjagj46pjzoVBXDZHQ++A
	yGstuLFs2k2gtnGE1wQrFMQqoOX9JsDkJXS8FKEqFCVIZJV1PIRJC8pWLm789/n+zu97ft/f
	SQ6JCc/xHMnwqFhGEiWKcCZs8Jpb5n6PwQ23mN2mti0ou1RLoDF1DYGqupMBMg/Zol9/Aqgy
	tZpAmp/D0P2CLBxN3JQDtFBqwVBqUTqGblT4o5XxKS6yzCM0mVsCUIIqH0eKS2U81DRVzUOX
	kzQ4amzS4ehuQzaBHmpXuGhubAVDWf3NHJTR3EAgxbyKQF1T7QTq1ufx0JUCV5Sj+g1Hv5t/
	QHOav3FkMmTiKElTzkEtMxNcNDmuIFDqYh5AyyMrHGRuUOPIUtABkKJsDkfJTZ8ic2s/ByUY
	3kZFskXufg96okXNoRMHXhC0Vq0F9MsuLUG3/TmN0WXjN7h0vWqUR+dVxNGVhW70lUYjh664
	riDoirk0Hm3QNxJ0V9YSTqt1x+hKzZlPtnxu856YiQg/xUi8fIJtwsrrHhAxauF3urJiIANn
	X1MCPgmpffCv1Ce4EtiQQqoQwIznOTxWzAOovzbAZcUzAFvri7ivLGOLw2uWAgAvTD/GWDEL
	4NWsbqAEJCmgfOBtvYvVgFMuMLHu/KpZQNlB3cUJ3MqbKCf4aDiLZ+WNlBg+zr/LsTJGOcDh
	iVyO9U57SkfC2ocFq00EtQcqTUrCynzqAKypH10zOMFaU/ZqCEhlbIAL1XKCjeoLMxoHeSxv
	hE87q9Z4M1ypZydASg5g3tKjNZECoGxyGLBd3tDQZyGs62DUTlja4MWWD0D1UPtqGVK28L7J
	jg1hC9NqMjG2LIDnkoRstytUdZb8N7bl9gDGMg2TFy5yU8A21bp3Ua3bX7VuNdX/GfIAfh04
	MHHSyFBGujeK+dZTKoqUxkWFeoZER1aAfz9L98vOhTpQ+HTWsxVwSNAKIIk52wsCNO2MUCAW
	xX/PSKK/ksRFMNJW8AaJOzsItoudGCEVKoplTjJMDCN5dcoh+Y4yzv5Qy9Fru5d28ne59HUE
	F/keH0/3u5rjJ1xyO9FoDmqPSWgLyum1VSxnnjYG/tFzb6+ksmu75utj3r0iY6VxNNkj7sNN
	hpD8EzLHEsFxr4+KtaKwQ4fje2zGtvK/dO06wj/iNjYj2BcwY5frmzh48I4woDh9K/nsrGPz
	4PNg+cB0dH/2jDLjM4cf/V1lKQPy19O2nabD+3flGl3KqaXpkKovePodsydjLxj8vjHmJPvP
	6mpv8j8wGehfvLx9U94M7tCfsncP9+k72tFQPOL+5Pxm3/ffDXQPHGo2hMe/dbivqUd4Z8Sd
	vndQvCPycqm4VE55lHy8XDL7Tm8kE3QGhFx68MLfGZeGifa4YRKp6B+gJCk3mwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH/d3e/npBkEuBcCVTSEVjIBTKo55OxnRh7rIpEecjczHYyRWI
	vNKHwz0iaEVomA6feKkFoQsioDwGQgc6kSEFM+YYhCEggSbEAWES3CgDOx5bwn+f5Hw/55yc
	HEog/gZ7UYkpGk6VokySYEey882TwYDutW1c0HSrHAz3KjAMG+sxfN95AYGtZx1czURQm1eH
	wXQmAfpK80mw/ngewet7cwLIK7ssgPKaPWAfGRfC3AzAWOFdBDq+mIScgioRNI/XieBWlomE
	pmYLCd1mA4ahCrsQpoftAsjvekDAlQdmDDkzPIb28VYMnb1FIigp3QI3+YckdNi+gmnTXyRM
	DlwnIctUTcCjP61CGBvJwZA3W4Rg/rmdAJvZSMJc6U8IcqqmSbjQvA9sLV0E6AbCoCxjVrgj
	gLU+MhLsuV8XMFthrEDsm/YKzD6emBKwVSPlQraRHxSxRTVatva2H1vS9JJga+7kYLZm+pKI
	Hehtwmx7/j8ka7TEsLWm03s3HJaGq1K1Gs4nIVWteUfyqQyCpTIFSINDFVJZyLYjbweHSQIj
	wuO4pMSTnCow4qg0obrhd5xmFKdbqipRBjrrokcOFEOHMsOz/aQeOVJi+jvEXOkqwiuFtxjL
	tQzhCrsx8716vBKaQsyNqYxFg6Kc6Qjml17fpQxJ+zLnGnKX8860K2O5YSWX2IP2Zl7054uW
	2I2OY0aLu4klFtCeTL+1cJndaQvF8AZqpX8nYoZbetBSAdMyRj+pX17Igd7J1DcO/ifLGX2d
	Hq2wN3N/0iD4Frnyq2bzq2bwqxR+lVKEyDvIndOqk+OT1TKpWpms1qbES4+lJtegxb+sb7PV
	NiDjH6+kLYigUAtiKIHE3Xm/qZUTO8cpT33BqVJjVdokTt2CwhYPkCfw8jiWuvjYKZpYmTwo
	TBYqVwSFKeQhEk/nqLRspZiOV2q4ExyXxqn+9wjKwSuDyA4XV9skW7cf7DM/9bQ6FRMv321c
	KO/w2H3APXq/+8ZBtdIrpDBa5BJzdELkreCfjZ0orT0V2yHyfWYuKGvatSHkS9Zf23Z+UBoT
	jeebeq6PIr/d9WJ586XbWzb5FAS8uhYVO5Lww4utfSFOCyZ7dFrknlu8DvVbAyvXbWaiInde
	PR7ve8RzR9ahzvdtyo90B+cqXeOi7k85pQdmvi4246HDDu+Nftz+8yefb9oVvC9729qvP3R7
	LBxaM3M68WG6f67huCLafPFyhyEe567XTK154lK+Pt30WehG3Qfzz31+o4vvRh7y13meuVli
	PTDR6rBAKxy9x+0nh7YvKMqfZsLf9rMSUp2glPkJVGrlvy4KzuQgBAAA
X-CMS-MailID: 20240209112612eucas1p27996a26c0866043ae96f9240ed7680b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207174117eucas1p237865b0a39f3a6d1a6650150efe22e83
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207174117eucas1p237865b0a39f3a6d1a6650150efe22e83
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
	<CGME20240207174117eucas1p237865b0a39f3a6d1a6650150efe22e83@eucas1p2.samsung.com>
	<20240207174102.1486130-6-pasha.tatashin@soleen.com>

On 07.02.2024 18:40, Pasha Tatashin wrote:
> Convert iommu/exynos-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 2c6e9094f1e9..3eab0ae65a4f 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -22,6 +22,8 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   
> +#include "iommu-pages.h"
> +
>   typedef u32 sysmmu_iova_t;
>   typedef u32 sysmmu_pte_t;
>   static struct iommu_domain exynos_identity_domain;
> @@ -900,11 +902,11 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
>   	if (!domain)
>   		return NULL;
>   
> -	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
> +	domain->pgtable = iommu_alloc_pages(GFP_KERNEL, 2);
>   	if (!domain->pgtable)
>   		goto err_pgtable;
>   
> -	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> +	domain->lv2entcnt = iommu_alloc_pages(GFP_KERNEL, 1);
>   	if (!domain->lv2entcnt)
>   		goto err_counter;
>   
> @@ -930,9 +932,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
>   	return &domain->domain;
>   
>   err_lv2ent:
> -	free_pages((unsigned long)domain->lv2entcnt, 1);
> +	iommu_free_pages(domain->lv2entcnt, 1);
>   err_counter:
> -	free_pages((unsigned long)domain->pgtable, 2);
> +	iommu_free_pages(domain->pgtable, 2);
>   err_pgtable:
>   	kfree(domain);
>   	return NULL;
> @@ -973,8 +975,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
>   					phys_to_virt(base));
>   		}
>   
> -	free_pages((unsigned long)domain->pgtable, 2);
> -	free_pages((unsigned long)domain->lv2entcnt, 1);
> +	iommu_free_pages(domain->pgtable, 2);
> +	iommu_free_pages(domain->lv2entcnt, 1);
>   	kfree(domain);
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


