Return-Path: <linux-fsdevel+bounces-4705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E258023BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FE91C20403
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CEF4F2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 12:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3D60DB;
	Sun,  3 Dec 2023 04:14:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1593C1688;
	Sun,  3 Dec 2023 04:15:28 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F364F3F73F;
	Sun,  3 Dec 2023 04:14:33 -0800 (PST)
Date: Sun, 3 Dec 2023 12:14:30 +0000
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
Message-ID: <ZWxxJipc2STxHHKn@raptor>
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
> 
> And then, the activation of CMA would be performed in the CMA code.
> We just can get the region information from memory-region and allocate it directly
> like alloc_contig_range, take_page_off_buddy. It seems like we can remove a lots of code.

Played with reserved_mem a bit. I don't think that's the correct path
forward.

The location of the tag storage is a hardware property, independent of how
Linux is configured.

early_init_fdt_scan_reserved_mem() is called from arm64_memblock_init(),
**after** the kernel enforces an upper address for various reasons. One of
the reasons can be that it's been compiled with 39 bits VA.

After early_init_fdt_scan_reserved_mem() returns, the kernel sets the
maximum address, stored in the variable "high_memory".

What can happen is that tag storage is present at an address above the
maximum addressable by the kernel, and the CMA code will trigger an
unrecovrable page fault.

I was able to trigger this with the dts change:

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a355..201359d014e4 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -183,6 +183,13 @@ vram: vram@18000000 {
                        reg = <0x00000000 0x18000000 0 0x00800000>;
                        no-map;
                };
+
+
+               linux,cma {
+                       compatible = "shared-dma-pool";
+                       reg = <0x100 0x0 0x00 0x4000000>;
+                       reusable;
+               };
        };

        gic: interrupt-controller@2f000000 {

And the error I got:

[    0.000000] Reserved memory: created CMA memory pool at 0x0000010000000000, size 64 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000010000000000..0x0000010003ffffff (65536 KiB) map reusable linux,cma
[..]
[    0.793193] WARNING: CPU: 0 PID: 1 at mm/cma.c:111 cma_init_reserved_areas+0xa8/0x378
[..]
[    0.806945] Unable to handle kernel paging request at virtual address 00000001fe000000
[    0.807277] Mem abort info:
[    0.807277]   ESR = 0x0000000096000005
[    0.807693]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.808110]   SET = 0, FnV = 0
[    0.808443]   EA = 0, S1PTW = 0
[    0.808526]   FSC = 0x05: level 1 translation fault
[    0.808943] Data abort info:
[    0.808943]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    0.809360]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.809776]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.810221] [00000001fe000000] user address but active_mm is swapper
[..]
[    0.820887] Call trace:
[    0.821027]  cma_init_reserved_areas+0xc4/0x378
[    0.821443]  do_one_initcall+0x7c/0x1c0
[    0.821860]  kernel_init_freeable+0x1bc/0x284
[    0.822277]  kernel_init+0x24/0x1dc
[    0.822693]  ret_from_fork+0x10/0x20
[    0.823554] Code: 9127a29a cb813321 d37ae421 8b030020 (f8636822)
[    0.823554] ---[ end trace 0000000000000000 ]---
[    0.824360] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.824443] SMP: stopping secondary CPUs
[    0.825193] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Should reserved mem check if the reserved memory is actually addressable by
the kernel if it's not "no-map"? Should cma fail gracefully if
!pfn_valid(base_pfn)? Shold early_init_fdt_scan_reserved_mem() be moved
because arm64_bootmem_init()? I don't have the answer to any of those. And
I got a kernel panic because the kernel cannot address that memory (39 bits
VA). I don't know what would happen if the upper limit is reduced for
another reason.

What I think should happen:

1. Add the tag storage memory before any limits are enforced by
arm64_bootmem_init().

2. Call cma_declare_contiguous_nid() after arm64_bootmem_init(), because
the function will check the memory limit.

3. Have an arch initcall that checks that the CMA regions corresponding to
the tag storage have been activated successfully (cma_init_reserved_areas()
is a core initcall). If not, then don't enable tag storage.

How does that sound to you?

Thanks,
Alex

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



