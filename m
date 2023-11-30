Return-Path: <linux-fsdevel+bounces-4366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9C7FEF46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6581C20A99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383547A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F33C299;
	Thu, 30 Nov 2023 03:56:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C9B1042;
	Thu, 30 Nov 2023 03:57:27 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0453F5A1;
	Thu, 30 Nov 2023 03:56:35 -0800 (PST)
Date: Thu, 30 Nov 2023 11:56:32 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <ZWh4cIMtOMjq2Ycw@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a@epcas2p2.samsung.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com>
 <20231129084424.GA2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129084424.GA2988384@tiffany>

Hi,

On Wed, Nov 29, 2023 at 05:44:24PM +0900, Hyesoo Yu wrote:
> Hello.
> 
> On Sun, Nov 19, 2023 at 04:57:05PM +0000, Alexandru Elisei wrote:
> > Allow the kernel to get the size and location of the MTE tag storage
> > regions from the DTB. This memory is marked as reserved for now.
> > 
> > The DTB node for the tag storage region is defined as:
> > 
> >         tags0: tag-storage@8f8000000 {
> >                 compatible = "arm,mte-tag-storage";
> >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> >                 block-size = <0x1000>;
> >                 memory = <&memory0>;	// Associated tagged memory node
> >         };
> >
> 
> How about using compatible = "shared-dma-pool" like below ?
> 
> &reserved_memory {
> 	tags0: tag0@8f8000000 {
> 		compatible = "arm,mte-tag-storage";
>         	reg = <0x08 0xf8000000 0x00 0x4000000>;
> 	};
> }
> 
> tag-storage {
>         compatible = "arm,mte-tag-storage";
> 	memory-region = <&tag>;
>         memory = <&memory0>;
> 	block-size = <0x1000>;
> }

I'm sorry, but I don't follow where compatible = "shared-dma-pool" fits
with the examples.

> 
> And then, the activation of CMA would be performed in the CMA code.
> We just can get the region information from memory-region and allocate it directly
> like alloc_contig_range, take_page_off_buddy. It seems like we can remove a lots of code.

For the next iteration I am planning to integrate the code more tightly
with CMA, so any suggestions to that effect are very welcome :)

> 
> > The tag storage region represents the largest contiguous memory region that
> > holds all the tags for the associated contiguous memory region which can be
> > tagged. For example, for a 32GB contiguous tagged memory the corresponding
> > tag storage region is 1GB of contiguous memory, not two adjacent 512M of
> > tag storage memory.
> > 
> > "block-size" represents the minimum multiple of 4K of tag storage where all
> > the tags stored in the block correspond to a contiguous memory region. This
> > is needed for platforms where the memory controller interleaves tag writes
> > to memory. For example, if the memory controller interleaves tag writes for
> > 256KB of contiguous memory across 8K of tag storage (2-way interleave),
> > then the correct value for "block-size" is 0x2000. This value is a hardware
> > property, independent of the selected kernel page size.
> >
> 
> Is it considered for kernel page size like 16K page, 64K page ? The comment says
> it should be a multiple of 4K, but it should be a multiple of the "page size" more accurately.
> Please let me know if there's anything I misunderstood. :-)

The block size in the DTB is a hardware property, it's independent of the
kernel page size, which is a compile time option.

The function get_block_size_pages(), which computes the tag storage block
size as the kernel will use it, takes into account the fact that the
hardware block size is not necessarily a multiple of the kernel page size,
and computes the least common multiple by doing:

(kernel page size in bytes x DTB block size in bytes) / greatest common divisor

As for why the hardware block size is a multiple of 4k, that was chosen
because it will be part of the architecture update. Since the minimum
hardware page size is 4K, it doesn't make much sense to have the DTB
block-size smaller than that.

Hope that makes sense!

Thanks,
Alex

> 
> 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  arch/arm64/Kconfig                       |  12 ++
> >  arch/arm64/include/asm/mte_tag_storage.h |  15 ++
> >  arch/arm64/kernel/Makefile               |   1 +
> >  arch/arm64/kernel/mte_tag_storage.c      | 256 +++++++++++++++++++++++
> >  arch/arm64/kernel/setup.c                |   7 +
> >  5 files changed, 291 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
> >  create mode 100644 arch/arm64/kernel/mte_tag_storage.c
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 7b071a00425d..fe8276fdc7a8 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2062,6 +2062,18 @@ config ARM64_MTE
> >  
> >  	  Documentation/arch/arm64/memory-tagging-extension.rst.
> >  
> > +if ARM64_MTE
> > +config ARM64_MTE_TAG_STORAGE
> > +	bool "Dynamic MTE tag storage management"
> > +	help
> > +	  Adds support for dynamic management of the memory used by the hardware
> > +	  for storing MTE tags. This memory, unlike normal memory, cannot be
> > +	  tagged. When it is used to store tags for another memory location it
> > +	  cannot be used for any type of allocation.
> > +
> > +	  If unsure, say N
> > +endif # ARM64_MTE
> > +
> >  endmenu # "ARMv8.5 architectural features"
> >  
> >  menu "ARMv8.7 architectural features"
> > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> > new file mode 100644
> > index 000000000000..8f86c4f9a7c3
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 ARM Ltd.
> > + */
> > +#ifndef __ASM_MTE_TAG_STORAGE_H
> > +#define __ASM_MTE_TAG_STORAGE_H
> > +
> > +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > +void mte_tag_storage_init(void);
> > +#else
> > +static inline void mte_tag_storage_init(void)
> > +{
> > +}
> > +#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
> > +#endif /* __ASM_MTE_TAG_STORAGE_H  */
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index d95b3d6b471a..5f031bf9f8f1 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
> >  obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
> >  obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
> >  obj-$(CONFIG_ARM64_MTE)			+= mte.o
> > +obj-$(CONFIG_ARM64_MTE_TAG_STORAGE)	+= mte_tag_storage.o
> >  obj-y					+= vdso-wrap.o
> >  obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
> >  obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.o
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > new file mode 100644
> > index 000000000000..fa6267ef8392
> > --- /dev/null
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -0,0 +1,256 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Support for dynamic tag storage.
> > + *
> > + * Copyright (C) 2023 ARM Ltd.
> > + */
> > +
> > +#include <linux/memblock.h>
> > +#include <linux/mm.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/range.h>
> > +#include <linux/string.h>
> > +#include <linux/xarray.h>
> > +
> > +#include <asm/mte_tag_storage.h>
> > +
> > +struct tag_region {
> > +	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
> > +	struct range tag_range;	/* Tag storage memory, in PFNs. */
> > +	u32 block_size;		/* Tag block size, in pages. */
> > +};
> > +
> > +#define MAX_TAG_REGIONS	32
> > +
> > +static struct tag_region tag_regions[MAX_TAG_REGIONS];
> > +static int num_tag_regions;
> > +
> > +static int __init tag_storage_of_flat_get_range(unsigned long node, const __be32 *reg,
> > +						int reg_len, struct range *range)
> > +{
> > +	int addr_cells = dt_root_addr_cells;
> > +	int size_cells = dt_root_size_cells;
> > +	u64 size;
> > +
> > +	if (reg_len / 4 > addr_cells + size_cells)
> > +		return -EINVAL;
> > +
> > +	range->start = PHYS_PFN(of_read_number(reg, addr_cells));
> > +	size = PHYS_PFN(of_read_number(reg + addr_cells, size_cells));
> > +	if (size == 0) {
> > +		pr_err("Invalid node");
> > +		return -EINVAL;
> > +	}
> > +	range->end = range->start + size - 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init tag_storage_of_flat_get_tag_range(unsigned long node,
> > +						    struct range *tag_range)
> > +{
> > +	const __be32 *reg;
> > +	int reg_len;
> > +
> > +	reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> > +	if (reg == NULL) {
> > +		pr_err("Invalid metadata node");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return tag_storage_of_flat_get_range(node, reg, reg_len, tag_range);
> > +}
> > +
> > +static int __init tag_storage_of_flat_get_memory_range(unsigned long node, struct range *mem)
> > +{
> > +	const __be32 *reg;
> > +	int reg_len;
> > +
> > +	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &reg_len);
> > +	if (reg == NULL)
> > +		reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> > +
> > +	if (reg == NULL) {
> > +		pr_err("Invalid memory node");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return tag_storage_of_flat_get_range(node, reg, reg_len, mem);
> > +}
> > +
> > +struct find_memory_node_arg {
> > +	unsigned long node;
> > +	u32 phandle;
> > +};
> > +
> > +static int __init fdt_find_memory_node(unsigned long node, const char *uname,
> > +				       int depth, void *data)
> > +{
> > +	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> > +	struct find_memory_node_arg *arg = data;
> > +
> > +	if (depth != 1 || !type || strcmp(type, "memory") != 0)
> > +		return 0;
> > +
> > +	if (of_get_flat_dt_phandle(node) == arg->phandle) {
> > +		arg->node = node;
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init tag_storage_get_memory_node(unsigned long tag_node, unsigned long *mem_node)
> > +{
> > +	struct find_memory_node_arg arg = { 0 };
> > +	const __be32 *memory_prop;
> > +	u32 mem_phandle;
> > +	int ret, reg_len;
> > +
> > +	memory_prop = of_get_flat_dt_prop(tag_node, "memory", &reg_len);
> > +	if (!memory_prop) {
> > +		pr_err("Missing 'memory' property in the tag storage node");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mem_phandle = be32_to_cpup(memory_prop);
> > +	arg.phandle = mem_phandle;
> > +
> > +	ret = of_scan_flat_dt(fdt_find_memory_node, &arg);
> > +	if (ret != 1) {
> > +		pr_err("Associated memory node not found");
> > +		return -EINVAL;
> > +	}
> > +
> > +	*mem_node = arg.node;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init tag_storage_of_flat_read_u32(unsigned long node, const char *propname,
> > +					       u32 *retval)
> > +{
> > +	const __be32 *reg;
> > +
> > +	reg = of_get_flat_dt_prop(node, propname, NULL);
> > +	if (!reg)
> > +		return -EINVAL;
> > +
> > +	*retval = be32_to_cpup(reg);
> > +	return 0;
> > +}
> > +
> > +static u32 __init get_block_size_pages(u32 block_size_bytes)
> > +{
> > +	u32 a = PAGE_SIZE;
> > +	u32 b = block_size_bytes;
> > +	u32 r;
> > +
> > +	/* Find greatest common divisor using the Euclidian algorithm. */
> > +	do {
> > +		r = a % b;
> > +		a = b;
> > +		b = r;
> > +	} while (b != 0);
> > +
> > +	return PHYS_PFN(PAGE_SIZE * block_size_bytes / a);
> > +}
> > +
> > +static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
> > +				       int depth, void *data)
> > +{
> > +	struct tag_region *region;
> > +	unsigned long mem_node;
> > +	struct range *mem_range;
> > +	struct range *tag_range;
> > +	u32 block_size_bytes;
> > +	u32 nid = 0;
> > +	int ret;
> > +
> > +	if (depth != 1 || !strstr(uname, "tag-storage"))
> > +		return 0;
> > +
> > +	if (!of_flat_dt_is_compatible(node, "arm,mte-tag-storage"))
> > +		return 0;
> > +
> > +	if (num_tag_regions == MAX_TAG_REGIONS) {
> > +		pr_err("Maximum number of tag storage regions exceeded");
> > +		return -EINVAL;
> > +	}
> > +
> > +	region = &tag_regions[num_tag_regions];
> > +	mem_range = &region->mem_range;
> > +	tag_range = &region->tag_range;
> > +
> > +	ret = tag_storage_of_flat_get_tag_range(node, tag_range);
> > +	if (ret) {
> > +		pr_err("Invalid tag storage node");
> > +		return ret;
> > +	}
> > +
> > +	ret = tag_storage_get_memory_node(node, &mem_node);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = tag_storage_of_flat_get_memory_range(mem_node, mem_range);
> > +	if (ret) {
> > +		pr_err("Invalid address for associated data memory node");
> > +		return ret;
> > +	}
> > +
> > +	/* The tag region must exactly match the corresponding memory. */
> > +	if (range_len(tag_range) * 32 != range_len(mem_range)) {
> > +		pr_err("Tag storage region 0x%llx-0x%llx does not cover the memory region 0x%llx-0x%llx",
> > +		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
> > +		       PFN_PHYS(mem_range->start), PFN_PHYS(mem_range->end));
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
> > +	if (ret || block_size_bytes == 0) {
> > +		pr_err("Invalid or missing 'block-size' property");
> > +		return -EINVAL;
> > +	}
> > +	region->block_size = get_block_size_pages(block_size_bytes);
> > +	if (range_len(tag_range) % region->block_size != 0) {
> > +		pr_err("Tag storage region size 0x%llx is not a multiple of block size %u",
> > +		       PFN_PHYS(range_len(tag_range)), region->block_size);
> > +		return -EINVAL;
> > +	}
> > +
> 
> I was confused about the variable "block_size", The block size declared in the device tree is
> in bytes, but the actual block size used is in pages. I think the term "block_size" can cause
> confusion as it might be interpreted as bytes. If possible, I suggest changing the term "block_size"
> to something more readable, such as "block_nr_pages" (This is just a example!)
> 
> Thanks,
> Regards.
> 
> > +	ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
> > +	if (ret)
> > +		nid = numa_node_id();
> > +
> > +	ret = memblock_add_node(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)),
> > +				nid, MEMBLOCK_NONE);
> > +	if (ret) {
> > +		pr_err("Error adding tag memblock (%d)", ret);
> > +		return ret;
> > +	}
> > +	memblock_reserve(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > +
> > +	pr_info("Found tag storage region 0x%llx-0x%llx, block size %u pages",
> > +		PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end), region->block_size);
> > +
> > +	num_tag_regions++;
> > +
> > +	return 0;
> > +}
> > +
> > +void __init mte_tag_storage_init(void)
> > +{
> > +	struct range *tag_range;
> > +	int i, ret;
> > +
> > +	ret = of_scan_flat_dt(fdt_init_tag_storage, NULL);
> > +	if (ret) {
> > +		for (i = 0; i < num_tag_regions; i++) {
> > +			tag_range = &tag_regions[i].tag_range;
> > +			memblock_remove(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > +		}
> > +		num_tag_regions = 0;
> > +		pr_info("MTE tag storage region management disabled");
> > +	}
> > +}
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 417a8a86b2db..1b77138c1aa5 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -42,6 +42,7 @@
> >  #include <asm/cpufeature.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/kasan.h>
> > +#include <asm/mte_tag_storage.h>
> >  #include <asm/numa.h>
> >  #include <asm/scs.h>
> >  #include <asm/sections.h>
> > @@ -342,6 +343,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >  			   FW_BUG "Booted with MMU enabled!");
> >  	}
> >  
> > +	/*
> > +	 * Must be called before memory limits are enforced by
> > +	 * arm64_memblock_init().
> > +	 */
> > +	mte_tag_storage_init();
> > +
> >  	arm64_memblock_init();
> >  
> >  	paging_init();
> > -- 
> > 2.42.1
> > 
> > 



