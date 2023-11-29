Return-Path: <linux-fsdevel+bounces-4165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBB7FD474
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9956CB20AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA861A732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="errNq7QE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC91E111;
	Wed, 29 Nov 2023 00:55:55 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231129085553epoutp046018296c42d7434ded80274d4c3eb47e~cDC6xYt2N0030700307epoutp04L;
	Wed, 29 Nov 2023 08:55:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231129085553epoutp046018296c42d7434ded80274d4c3eb47e~cDC6xYt2N0030700307epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701248153;
	bh=cxuo0rjgsu822iymiSVM9UwW6HOQ3HapEo/i2G5CNCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=errNq7QExsGeCygRBZ7d2cbkwZBlRsZi2XQTGjHABdOtGDtdWzQQpikPRb+qoDQ3F
	 WK+Jl9PoqhqlhUqlF7s5sXWOYskuWArJKsPf0fWfP7kK3O3X2FF2y1hyY7kSvtJT8k
	 jnKNllksQ3CgINriCXOHmMVgyhEvetcxxJNSI9ig=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231129085553epcas2p2e1745bc34017fc6e2280cdd18f576254~cDC6enMIt1962319623epcas2p2n;
	Wed, 29 Nov 2023 08:55:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SgCpc6D37z4x9Py; Wed, 29 Nov
	2023 08:55:52 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.AA.09607.89CF6656; Wed, 29 Nov 2023 17:55:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20231129085552epcas2p259a8df24ee5866fe93c16f706c031649~cDC5QGPwv1502015020epcas2p2S;
	Wed, 29 Nov 2023 08:55:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231129085552epsmtrp252e8f494c1d7aa96fdba6d44f146167c~cDC5Ow1bm0843708437epsmtrp2S;
	Wed, 29 Nov 2023 08:55:52 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-37-6566fc98cf9b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.DA.07368.79CF6656; Wed, 29 Nov 2023 17:55:52 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231129085551epsmtip1d362d9bf85f6070615fc4e6cda6e80f9~cDC40frex0824008240epsmtip1_;
	Wed, 29 Nov 2023 08:55:51 +0000 (GMT)
Date: Wed, 29 Nov 2023 17:44:24 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <20231129084424.GA2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231119165721.9849-12-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1ATVxTGvbubTXQEF3z0QkcbIoimJSSUx6Uq0xmZznZoK53O1A7/hEi2
	kEIezSbWx1Rji5hSFURRgkhjQUBFcQKKUEiVhxCxrUXE8qwiUqRRFBQCFtuExY7//e4333fv
	uefMEeC+v/L9BSqNgdFrFGkicgFxsXFNZEjeP58z0m8fiFFBRTmJjp66SSJ7axKaybnKR+33
	brmlB7sJNFqyD6BnFdM4up99AUdXrI8IdH/sAIH+tJdiqC8rl0DVQw8xNFLVSCBz7TMC2e51
	8lBdvYNAN2sLSNRf/i8PNVX8QqCaAgcPHXo0BFBR6SrUftmKodwpJ4myem+TqGX/ZQzZzXcw
	t7caQ7ubRklk6ekByNw0gaP6F1MEutA8yUfpvRGo6+R5/rtBdHlhOaCfT+cAOt3ezaetNiOd
	3vSQR1eWiWnb6e9I2jaWw6d7O+tIujXvOUGfMOXidGXxLnq40gLoUfstkq5s20GP21bEUwmp
	61IYhZLRCxlNklap0iSvF8V9It8gj4iUykJk0ShKJNQo1Mx6UewH8SHvqdLczRQJtyjSjG4p
	XsGyotCYdXqt0cAIU7SsYb2I0SnTdFE6CatQs0ZNskTDGN6RSaVhEW5jYmqKydXB1x1Xb31c
	t8UE/v40E8wXQCocThUXER72pS4B2OJckgkWuHkMwJzO0yR3mACw2FlGvEwU/VFNcol6ADsm
	gznTfQBrTb/NmggqCOad7eV5mKSCYWtVCfDwEioUDlwYAZ4ATl0jYd+x61gmEAgWUzSsHpR5
	PF6UBDac6ME59oEOy+DsnfOpGDjTZya5InIXwGaHguNYeL5qAnC8GI60VPE59ofjj+rn/Kmw
	70n2HBvgueumOc/bMH9o72wWp1LgnjMPgKccSK2ETd0EJ3tDc+MMn5O9oDnDl0uuhD+XFM61
	xA8OnN3L45iGXWXTfK4lTQDWZ/cT2WBF/iu/yX/lNY7fgtafxsh89xM49TosfSHgcA2sqA21
	At5psIzRsepkhg3Thf8/3SSt2gZmF0tMXwLHHj6WNABMABoAFOCiJV6SJ0mMr5dSsW07o9fK
	9cY0hm0AEe7RHMT9lyZp3ZupMchl4dHS8MhIWVRYhDRK9JpX/57jSl8qWWFgUhlGx+hf5jDB
	fH8T5mgtl3olBg63OfDgRfJFua2qydbeyY3Y+a7BeZtPiQs/Nj+PhmvvqmLedEgOh3V9WZPj
	nRj42WT6jvcDNlmdlUf8rriybvTXKJ/+WCe6a3clDoJLN1TgHH+oq8QpGFv4Vd7WzJnggoC/
	pPmDO7JWHXlaeLQnZKdrQ8fyhI3eo9k792u/lwh/397Wfi1wl98+/EDKF4svnh2ShyQGDR8T
	Xg2SHdomUc+LTbSN3zD0Zn9IsVVxZ3w6DrcVp25Wdn69bNdt4ckB8Wqjs7n/mzPd/u1M7Rst
	FpfFGQDZtXHY0oSpj+7E1RzR2+WYN7g1lDDY7bOFyrBsWp3hMi6HexbCHyqKRASbopCJcT2r
	+A/yJFfF4QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTZxzH99xdr0eV7XYQeIBgshrY0tRidZpfhhIWN71lMTOZ2zKmcQWO
	ItDCWtjYZgSWBjtAJGyEtmOjioJCGezKi6J2rnRa5tt8walQJYBEDJUIMkVHHYUs879PPt/v
	93n++TEkVyuJZnbq8wWDXpMjp2VUV6982QrLPxnCyo4LBNS1OWioPXKFBpc3DeaqT0vh8kj/
	vBovoWCysQLBTNsTEu5UdZLwm/0+BXemKim47WoiwLevhoLuMT8B9zp6KTD3zFAgjlyTwImT
	fRRc6amj4ZbjmQQ8becpOFbXJ4Hv7o8haGiKh8un7ATUzE7QsG/wLxrO7D1FgMs8RMx3uwko
	8UzSYB0YQGD2/E3CycAsBZ2/P5KCaXAN3DjULk2O4x0/ORD/9Ek14k2um1LeLhbwJo9fwjsP
	K3ix+VuaF6eqpfzgtRM077U8pfj9xTUk7zxYxN91WhE/6eqneefZr/lpcdkWNkW2Ll3I2fm5
	YEhI+lSW6TvjIfN8WYXm9qvSYuTZWoZCGMy+jhuud9NlSMZw7HGEy/ZWSBaDKGyb7iMWOQzf
	NnkWPMeOIFz5TWyQKTYOW1oHFzzNvoq9HY0oyOFsAh7uvIeCj5LsORpXttjmSwwTxvK4e1Qd
	7ISyKuzeP0AufuxBePpquWQxeBn3WUepIJOsAl8PjBPBLcnG4KYAE9QhbBKe85npKsTanlvY
	nlvY/l/YEdmMooQ8o06rS1PnqfXCFyqjRmcs0GtVabk6ES3cjuK1o+hWfUDlRgSD3AgzpDw8
	VPUgTeBC0zVffiUYcncYCnIEoxvFMJQ8MlRt+SGdY7WafCFbEPIEw38pwYREFxP1E1M+dPzG
	Z++cf7yxoqq0PGyWcw5s8D9UpsztjthUqk0aToht3OVNFWqJetmBwk8iehXhNWvWZl7avpla
	sZRpWF/kNWUVJi+5hA/syfoYtSzNfojeyhWevbdN/GD5+rOy1gxyS1bycPlmf+QfKdvF1c3v
	Bl6M64+I3pjKFr2wMj7qcftHyq2pb7+i2PZnTORs5mqtjzkq7hhd2/P9xbulpw8nkvEO7eiv
	5KqEWN+HXdJfLviHpt7PnrlYHa5sVf68pERtpOcSuXSlUfZGS8au5kfEEXdX76qZifE9XvO6
	HMvQcpvem8/RcbKbPbvNY/ZziW82bdAd44YrrT9ueumBVmWVU8ZMjVpBGoyafwGA3DRxqgMA
	AA==
X-CMS-MailID: 20231129085552epcas2p259a8df24ee5866fe93c16f706c031649
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_376fa_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a@epcas2p2.samsung.com>
	<20231119165721.9849-12-alexandru.elisei@arm.com>

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_376fa_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello.

On Sun, Nov 19, 2023 at 04:57:05PM +0000, Alexandru Elisei wrote:
> Allow the kernel to get the size and location of the MTE tag storage
> regions from the DTB. This memory is marked as reserved for now.
> 
> The DTB node for the tag storage region is defined as:
> 
>         tags0: tag-storage@8f8000000 {
>                 compatible = "arm,mte-tag-storage";
>                 reg = <0x08 0xf8000000 0x00 0x4000000>;
>                 block-size = <0x1000>;
>                 memory = <&memory0>;	// Associated tagged memory node
>         };
>

How about using compatible = "shared-dma-pool" like below ?

&reserved_memory {
	tags0: tag0@8f8000000 {
		compatible = "arm,mte-tag-storage";
        	reg = <0x08 0xf8000000 0x00 0x4000000>;
	};
}

tag-storage {
        compatible = "arm,mte-tag-storage";
	memory-region = <&tag>;
        memory = <&memory0>;
	block-size = <0x1000>;
}

And then, the activation of CMA would be performed in the CMA code.
We just can get the region information from memory-region and allocate it directly
like alloc_contig_range, take_page_off_buddy. It seems like we can remove a lots of code.

> The tag storage region represents the largest contiguous memory region that
> holds all the tags for the associated contiguous memory region which can be
> tagged. For example, for a 32GB contiguous tagged memory the corresponding
> tag storage region is 1GB of contiguous memory, not two adjacent 512M of
> tag storage memory.
> 
> "block-size" represents the minimum multiple of 4K of tag storage where all
> the tags stored in the block correspond to a contiguous memory region. This
> is needed for platforms where the memory controller interleaves tag writes
> to memory. For example, if the memory controller interleaves tag writes for
> 256KB of contiguous memory across 8K of tag storage (2-way interleave),
> then the correct value for "block-size" is 0x2000. This value is a hardware
> property, independent of the selected kernel page size.
>

Is it considered for kernel page size like 16K page, 64K page ? The comment says
it should be a multiple of 4K, but it should be a multiple of the "page size" more accurately.
Please let me know if there's anything I misunderstood. :-)


> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/Kconfig                       |  12 ++
>  arch/arm64/include/asm/mte_tag_storage.h |  15 ++
>  arch/arm64/kernel/Makefile               |   1 +
>  arch/arm64/kernel/mte_tag_storage.c      | 256 +++++++++++++++++++++++
>  arch/arm64/kernel/setup.c                |   7 +
>  5 files changed, 291 insertions(+)
>  create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
>  create mode 100644 arch/arm64/kernel/mte_tag_storage.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..fe8276fdc7a8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,18 @@ config ARM64_MTE
>  
>  	  Documentation/arch/arm64/memory-tagging-extension.rst.
>  
> +if ARM64_MTE
> +config ARM64_MTE_TAG_STORAGE
> +	bool "Dynamic MTE tag storage management"
> +	help
> +	  Adds support for dynamic management of the memory used by the hardware
> +	  for storing MTE tags. This memory, unlike normal memory, cannot be
> +	  tagged. When it is used to store tags for another memory location it
> +	  cannot be used for any type of allocation.
> +
> +	  If unsure, say N
> +endif # ARM64_MTE
> +
>  endmenu # "ARMv8.5 architectural features"
>  
>  menu "ARMv8.7 architectural features"
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> new file mode 100644
> index 000000000000..8f86c4f9a7c3
> --- /dev/null
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +#ifndef __ASM_MTE_TAG_STORAGE_H
> +#define __ASM_MTE_TAG_STORAGE_H
> +
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +void mte_tag_storage_init(void);
> +#else
> +static inline void mte_tag_storage_init(void)
> +{
> +}
> +#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
> +#endif /* __ASM_MTE_TAG_STORAGE_H  */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index d95b3d6b471a..5f031bf9f8f1 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
>  obj-$(CONFIG_ARM64_MTE)			+= mte.o
> +obj-$(CONFIG_ARM64_MTE_TAG_STORAGE)	+= mte_tag_storage.o
>  obj-y					+= vdso-wrap.o
>  obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
>  obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.o
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> new file mode 100644
> index 000000000000..fa6267ef8392
> --- /dev/null
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Support for dynamic tag storage.
> + *
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#include <linux/memblock.h>
> +#include <linux/mm.h>
> +#include <linux/of_device.h>
> +#include <linux/of_fdt.h>
> +#include <linux/range.h>
> +#include <linux/string.h>
> +#include <linux/xarray.h>
> +
> +#include <asm/mte_tag_storage.h>
> +
> +struct tag_region {
> +	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
> +	struct range tag_range;	/* Tag storage memory, in PFNs. */
> +	u32 block_size;		/* Tag block size, in pages. */
> +};
> +
> +#define MAX_TAG_REGIONS	32
> +
> +static struct tag_region tag_regions[MAX_TAG_REGIONS];
> +static int num_tag_regions;
> +
> +static int __init tag_storage_of_flat_get_range(unsigned long node, const __be32 *reg,
> +						int reg_len, struct range *range)
> +{
> +	int addr_cells = dt_root_addr_cells;
> +	int size_cells = dt_root_size_cells;
> +	u64 size;
> +
> +	if (reg_len / 4 > addr_cells + size_cells)
> +		return -EINVAL;
> +
> +	range->start = PHYS_PFN(of_read_number(reg, addr_cells));
> +	size = PHYS_PFN(of_read_number(reg + addr_cells, size_cells));
> +	if (size == 0) {
> +		pr_err("Invalid node");
> +		return -EINVAL;
> +	}
> +	range->end = range->start + size - 1;
> +
> +	return 0;
> +}
> +
> +static int __init tag_storage_of_flat_get_tag_range(unsigned long node,
> +						    struct range *tag_range)
> +{
> +	const __be32 *reg;
> +	int reg_len;
> +
> +	reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> +	if (reg == NULL) {
> +		pr_err("Invalid metadata node");
> +		return -EINVAL;
> +	}
> +
> +	return tag_storage_of_flat_get_range(node, reg, reg_len, tag_range);
> +}
> +
> +static int __init tag_storage_of_flat_get_memory_range(unsigned long node, struct range *mem)
> +{
> +	const __be32 *reg;
> +	int reg_len;
> +
> +	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &reg_len);
> +	if (reg == NULL)
> +		reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> +
> +	if (reg == NULL) {
> +		pr_err("Invalid memory node");
> +		return -EINVAL;
> +	}
> +
> +	return tag_storage_of_flat_get_range(node, reg, reg_len, mem);
> +}
> +
> +struct find_memory_node_arg {
> +	unsigned long node;
> +	u32 phandle;
> +};
> +
> +static int __init fdt_find_memory_node(unsigned long node, const char *uname,
> +				       int depth, void *data)
> +{
> +	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +	struct find_memory_node_arg *arg = data;
> +
> +	if (depth != 1 || !type || strcmp(type, "memory") != 0)
> +		return 0;
> +
> +	if (of_get_flat_dt_phandle(node) == arg->phandle) {
> +		arg->node = node;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init tag_storage_get_memory_node(unsigned long tag_node, unsigned long *mem_node)
> +{
> +	struct find_memory_node_arg arg = { 0 };
> +	const __be32 *memory_prop;
> +	u32 mem_phandle;
> +	int ret, reg_len;
> +
> +	memory_prop = of_get_flat_dt_prop(tag_node, "memory", &reg_len);
> +	if (!memory_prop) {
> +		pr_err("Missing 'memory' property in the tag storage node");
> +		return -EINVAL;
> +	}
> +
> +	mem_phandle = be32_to_cpup(memory_prop);
> +	arg.phandle = mem_phandle;
> +
> +	ret = of_scan_flat_dt(fdt_find_memory_node, &arg);
> +	if (ret != 1) {
> +		pr_err("Associated memory node not found");
> +		return -EINVAL;
> +	}
> +
> +	*mem_node = arg.node;
> +
> +	return 0;
> +}
> +
> +static int __init tag_storage_of_flat_read_u32(unsigned long node, const char *propname,
> +					       u32 *retval)
> +{
> +	const __be32 *reg;
> +
> +	reg = of_get_flat_dt_prop(node, propname, NULL);
> +	if (!reg)
> +		return -EINVAL;
> +
> +	*retval = be32_to_cpup(reg);
> +	return 0;
> +}
> +
> +static u32 __init get_block_size_pages(u32 block_size_bytes)
> +{
> +	u32 a = PAGE_SIZE;
> +	u32 b = block_size_bytes;
> +	u32 r;
> +
> +	/* Find greatest common divisor using the Euclidian algorithm. */
> +	do {
> +		r = a % b;
> +		a = b;
> +		b = r;
> +	} while (b != 0);
> +
> +	return PHYS_PFN(PAGE_SIZE * block_size_bytes / a);
> +}
> +
> +static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
> +				       int depth, void *data)
> +{
> +	struct tag_region *region;
> +	unsigned long mem_node;
> +	struct range *mem_range;
> +	struct range *tag_range;
> +	u32 block_size_bytes;
> +	u32 nid = 0;
> +	int ret;
> +
> +	if (depth != 1 || !strstr(uname, "tag-storage"))
> +		return 0;
> +
> +	if (!of_flat_dt_is_compatible(node, "arm,mte-tag-storage"))
> +		return 0;
> +
> +	if (num_tag_regions == MAX_TAG_REGIONS) {
> +		pr_err("Maximum number of tag storage regions exceeded");
> +		return -EINVAL;
> +	}
> +
> +	region = &tag_regions[num_tag_regions];
> +	mem_range = &region->mem_range;
> +	tag_range = &region->tag_range;
> +
> +	ret = tag_storage_of_flat_get_tag_range(node, tag_range);
> +	if (ret) {
> +		pr_err("Invalid tag storage node");
> +		return ret;
> +	}
> +
> +	ret = tag_storage_get_memory_node(node, &mem_node);
> +	if (ret)
> +		return ret;
> +
> +	ret = tag_storage_of_flat_get_memory_range(mem_node, mem_range);
> +	if (ret) {
> +		pr_err("Invalid address for associated data memory node");
> +		return ret;
> +	}
> +
> +	/* The tag region must exactly match the corresponding memory. */
> +	if (range_len(tag_range) * 32 != range_len(mem_range)) {
> +		pr_err("Tag storage region 0x%llx-0x%llx does not cover the memory region 0x%llx-0x%llx",
> +		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
> +		       PFN_PHYS(mem_range->start), PFN_PHYS(mem_range->end));
> +		return -EINVAL;
> +	}
> +
> +	ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
> +	if (ret || block_size_bytes == 0) {
> +		pr_err("Invalid or missing 'block-size' property");
> +		return -EINVAL;
> +	}
> +	region->block_size = get_block_size_pages(block_size_bytes);
> +	if (range_len(tag_range) % region->block_size != 0) {
> +		pr_err("Tag storage region size 0x%llx is not a multiple of block size %u",
> +		       PFN_PHYS(range_len(tag_range)), region->block_size);
> +		return -EINVAL;
> +	}
> +

I was confused about the variable "block_size", The block size declared in the device tree is
in bytes, but the actual block size used is in pages. I think the term "block_size" can cause
confusion as it might be interpreted as bytes. If possible, I suggest changing the term "block_size"
to something more readable, such as "block_nr_pages" (This is just a example!)

Thanks,
Regards.

> +	ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
> +	if (ret)
> +		nid = numa_node_id();
> +
> +	ret = memblock_add_node(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)),
> +				nid, MEMBLOCK_NONE);
> +	if (ret) {
> +		pr_err("Error adding tag memblock (%d)", ret);
> +		return ret;
> +	}
> +	memblock_reserve(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> +
> +	pr_info("Found tag storage region 0x%llx-0x%llx, block size %u pages",
> +		PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end), region->block_size);
> +
> +	num_tag_regions++;
> +
> +	return 0;
> +}
> +
> +void __init mte_tag_storage_init(void)
> +{
> +	struct range *tag_range;
> +	int i, ret;
> +
> +	ret = of_scan_flat_dt(fdt_init_tag_storage, NULL);
> +	if (ret) {
> +		for (i = 0; i < num_tag_regions; i++) {
> +			tag_range = &tag_regions[i].tag_range;
> +			memblock_remove(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> +		}
> +		num_tag_regions = 0;
> +		pr_info("MTE tag storage region management disabled");
> +	}
> +}
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..1b77138c1aa5 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -42,6 +42,7 @@
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/kasan.h>
> +#include <asm/mte_tag_storage.h>
>  #include <asm/numa.h>
>  #include <asm/scs.h>
>  #include <asm/sections.h>
> @@ -342,6 +343,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  			   FW_BUG "Booted with MMU enabled!");
>  	}
>  
> +	/*
> +	 * Must be called before memory limits are enforced by
> +	 * arm64_memblock_init().
> +	 */
> +	mte_tag_storage_init();
> +
>  	arm64_memblock_init();
>  
>  	paging_init();
> -- 
> 2.42.1
> 
> 

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_376fa_
Content-Type: text/plain; charset="utf-8"


------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_376fa_--

