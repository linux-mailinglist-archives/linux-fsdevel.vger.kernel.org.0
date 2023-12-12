Return-Path: <linux-fsdevel+bounces-5723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384180F335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A77281C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1878E9C;
	Tue, 12 Dec 2023 16:39:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B1812C;
	Tue, 12 Dec 2023 08:38:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930CF143D;
	Tue, 12 Dec 2023 08:39:30 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B2B3F738;
	Tue, 12 Dec 2023 08:38:38 -0800 (PST)
Date: Tue, 12 Dec 2023 16:38:32 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Rob Herring <robh@kernel.org>
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
	kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <ZXiMiLz9ZyUdxUP8@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com>
 <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>

Hi Rob,

Thank you so much for the feedback, I'm not very familiar with device tree,
and any comments are very useful.

On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> On Sun, Nov 19, 2023 at 10:59 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Allow the kernel to get the size and location of the MTE tag storage
> > regions from the DTB. This memory is marked as reserved for now.
> >
> > The DTB node for the tag storage region is defined as:
> >
> >         tags0: tag-storage@8f8000000 {
> >                 compatible = "arm,mte-tag-storage";
> >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> >                 block-size = <0x1000>;
> >                 memory = <&memory0>;    // Associated tagged memory node
> >         };
> 
> I skimmed thru the discussion some. If this memory range is within
> main RAM, then it definitely belongs in /reserved-memory.

Ok, will do that.

If you don't mind, why do you say that it definitely belongs in
reserved-memory? I'm not trying to argue otherwise, I'm curious about the
motivation.

Tag storage is not DMA and can live anywhere in memory. In
arm64_memblock_init(), the kernel first removes the memory that it cannot
address from memblock. For example, because it has been compiled with
CONFIG_ARM64_VA_BITS_39=y. And then calls
early_init_fdt_scan_reserved_mem().

What happens if reserved memory is above what the kernel can address?

From my testing, when the kernel is compiled with 39 bit VA, if I use
reserved memory to discover tag storage the lives above the virtua address
limit and then I try to use CMA to manage the tag storage memory, I get a
kernel panic:

[    0.000000] Reserved memory: created CMA memory pool at 0x0000010000000000, size 64 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000010000000000..0x0000010003ffffff (65536 KiB) map reusable linux,cma
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

> 
> You need a binding for this too.

By binding you mean having an yaml file in dt-schem [1] describing the tag
storage node, right?

[1] https://github.com/devicetree-org/dt-schema

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
> >           Documentation/arch/arm64/memory-tagging-extension.rst.
> >
> > +if ARM64_MTE
> > +config ARM64_MTE_TAG_STORAGE
> > +       bool "Dynamic MTE tag storage management"
> > +       help
> > +         Adds support for dynamic management of the memory used by the hardware
> > +         for storing MTE tags. This memory, unlike normal memory, cannot be
> > +         tagged. When it is used to store tags for another memory location it
> > +         cannot be used for any type of allocation.
> > +
> > +         If unsure, say N
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
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_CRASH_CORE)              += crash_core.o
> >  obj-$(CONFIG_ARM_SDE_INTERFACE)                += sdei.o
> >  obj-$(CONFIG_ARM64_PTR_AUTH)           += pointer_auth.o
> >  obj-$(CONFIG_ARM64_MTE)                        += mte.o
> > +obj-$(CONFIG_ARM64_MTE_TAG_STORAGE)    += mte_tag_storage.o
> >  obj-y                                  += vdso-wrap.o
> >  obj-$(CONFIG_COMPAT_VDSO)              += vdso32-wrap.o
> >  obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)        += patch-scs.o
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
> 
> You probably don't need this header. If you depend on what it
> implicitly includes, then that will now break in linux-next.

I'll have a look if I can remove it. Might be an artifact from an earlier
version of the patches.

> 
> > +#include <linux/of_fdt.h>
> > +#include <linux/range.h>
> > +#include <linux/string.h>
> > +#include <linux/xarray.h>
> > +
> > +#include <asm/mte_tag_storage.h>
> > +
> > +struct tag_region {
> > +       struct range mem_range; /* Memory associated with the tag storage, in PFNs. */
> > +       struct range tag_range; /* Tag storage memory, in PFNs. */
> > +       u32 block_size;         /* Tag block size, in pages. */
> > +};
> > +
> > +#define MAX_TAG_REGIONS        32
> > +
> > +static struct tag_region tag_regions[MAX_TAG_REGIONS];
> > +static int num_tag_regions;
> > +
> > +static int __init tag_storage_of_flat_get_range(unsigned long node, const __be32 *reg,
> > +                                               int reg_len, struct range *range)
> > +{
> > +       int addr_cells = dt_root_addr_cells;
> > +       int size_cells = dt_root_size_cells;
> > +       u64 size;
> > +
> > +       if (reg_len / 4 > addr_cells + size_cells)
> > +               return -EINVAL;
> > +
> > +       range->start = PHYS_PFN(of_read_number(reg, addr_cells));
> > +       size = PHYS_PFN(of_read_number(reg + addr_cells, size_cells));
> > +       if (size == 0) {
> > +               pr_err("Invalid node");
> > +               return -EINVAL;
> > +       }
> > +       range->end = range->start + size - 1;
> 
> We have a function to read (and translate which you forgot) addresses.
> Add what's missing rather than open code your own.

I must have missed that there's already a function to read addresses. Would
you mind pointing me in the right direction?

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init tag_storage_of_flat_get_tag_range(unsigned long node,
> > +                                                   struct range *tag_range)
> > +{
> > +       const __be32 *reg;
> > +       int reg_len;
> > +
> > +       reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> > +       if (reg == NULL) {
> > +               pr_err("Invalid metadata node");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return tag_storage_of_flat_get_range(node, reg, reg_len, tag_range);
> > +}
> > +
> > +static int __init tag_storage_of_flat_get_memory_range(unsigned long node, struct range *mem)
> > +{
> > +       const __be32 *reg;
> > +       int reg_len;
> > +
> > +       reg = of_get_flat_dt_prop(node, "linux,usable-memory", &reg_len);
> > +       if (reg == NULL)
> > +               reg = of_get_flat_dt_prop(node, "reg", &reg_len);
> > +
> > +       if (reg == NULL) {
> > +               pr_err("Invalid memory node");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return tag_storage_of_flat_get_range(node, reg, reg_len, mem);
> > +}
> > +
> > +struct find_memory_node_arg {
> > +       unsigned long node;
> > +       u32 phandle;
> > +};
> > +
> > +static int __init fdt_find_memory_node(unsigned long node, const char *uname,
> > +                                      int depth, void *data)
> > +{
> > +       const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> > +       struct find_memory_node_arg *arg = data;
> > +
> > +       if (depth != 1 || !type || strcmp(type, "memory") != 0)
> > +               return 0;
> > +
> > +       if (of_get_flat_dt_phandle(node) == arg->phandle) {
> > +               arg->node = node;
> > +               return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init tag_storage_get_memory_node(unsigned long tag_node, unsigned long *mem_node)
> > +{
> > +       struct find_memory_node_arg arg = { 0 };
> > +       const __be32 *memory_prop;
> > +       u32 mem_phandle;
> > +       int ret, reg_len;
> > +
> > +       memory_prop = of_get_flat_dt_prop(tag_node, "memory", &reg_len);
> > +       if (!memory_prop) {
> > +               pr_err("Missing 'memory' property in the tag storage node");
> > +               return -EINVAL;
> > +       }
> > +
> > +       mem_phandle = be32_to_cpup(memory_prop);
> > +       arg.phandle = mem_phandle;
> > +
> > +       ret = of_scan_flat_dt(fdt_find_memory_node, &arg);
> 
> Do not use of_scan_flat_dt. It is a relic predating libfdt which can
> get a node by phandle directly.

I used that because that's what drivers/of/fdt.c uses. With reserved memory
I shouldn't need it, because struct reserved_mem already includes a
phandle.

> 
> > +       if (ret != 1) {
> > +               pr_err("Associated memory node not found");
> > +               return -EINVAL;
> > +       }
> > +
> > +       *mem_node = arg.node;
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init tag_storage_of_flat_read_u32(unsigned long node, const char *propname,
> > +                                              u32 *retval)
> 
> If you are going to make a generic function, make it for everyone.

Sure. If I still need it, should I put the function in
include/linux/of_fdt.h?

> 
> > +{
> > +       const __be32 *reg;
> > +
> > +       reg = of_get_flat_dt_prop(node, propname, NULL);
> > +       if (!reg)
> > +               return -EINVAL;
> > +
> > +       *retval = be32_to_cpup(reg);
> > +       return 0;
> > +}
> > +
> > +static u32 __init get_block_size_pages(u32 block_size_bytes)
> > +{
> > +       u32 a = PAGE_SIZE;
> > +       u32 b = block_size_bytes;
> > +       u32 r;
> > +
> > +       /* Find greatest common divisor using the Euclidian algorithm. */
> > +       do {
> > +               r = a % b;
> > +               a = b;
> > +               b = r;
> > +       } while (b != 0);
> > +
> > +       return PHYS_PFN(PAGE_SIZE * block_size_bytes / a);
> > +}
> > +
> > +static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
> > +                                      int depth, void *data)
> > +{
> > +       struct tag_region *region;
> > +       unsigned long mem_node;
> > +       struct range *mem_range;
> > +       struct range *tag_range;
> > +       u32 block_size_bytes;
> > +       u32 nid = 0;
> > +       int ret;
> > +
> > +       if (depth != 1 || !strstr(uname, "tag-storage"))
> > +               return 0;
> > +
> > +       if (!of_flat_dt_is_compatible(node, "arm,mte-tag-storage"))
> > +               return 0;
> > +
> > +       if (num_tag_regions == MAX_TAG_REGIONS) {
> > +               pr_err("Maximum number of tag storage regions exceeded");
> > +               return -EINVAL;
> > +       }
> > +
> > +       region = &tag_regions[num_tag_regions];
> > +       mem_range = &region->mem_range;
> > +       tag_range = &region->tag_range;
> > +
> > +       ret = tag_storage_of_flat_get_tag_range(node, tag_range);
> > +       if (ret) {
> > +               pr_err("Invalid tag storage node");
> > +               return ret;
> > +       }
> > +
> > +       ret = tag_storage_get_memory_node(node, &mem_node);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = tag_storage_of_flat_get_memory_range(mem_node, mem_range);
> > +       if (ret) {
> > +               pr_err("Invalid address for associated data memory node");
> > +               return ret;
> > +       }
> > +
> > +       /* The tag region must exactly match the corresponding memory. */
> > +       if (range_len(tag_range) * 32 != range_len(mem_range)) {
> > +               pr_err("Tag storage region 0x%llx-0x%llx does not cover the memory region 0x%llx-0x%llx",
> > +                      PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
> > +                      PFN_PHYS(mem_range->start), PFN_PHYS(mem_range->end));
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
> > +       if (ret || block_size_bytes == 0) {
> > +               pr_err("Invalid or missing 'block-size' property");
> > +               return -EINVAL;
> > +       }
> > +       region->block_size = get_block_size_pages(block_size_bytes);
> > +       if (range_len(tag_range) % region->block_size != 0) {
> > +               pr_err("Tag storage region size 0x%llx is not a multiple of block size %u",
> > +                      PFN_PHYS(range_len(tag_range)), region->block_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
> 
> I was going to say we already have a way to associate memory nodes
> other nodes using "numa-node-id", so the "memory" phandle property is
> somewhat redundant. Maybe the tag node should have a numa-node-id.
> With that, it looks like you don't even need to access the /memory
> node. Avoiding that would be good for 2 reasons. It avoids parsing
> memory nodes twice and it's not the kernel's job to validate the DT.
> Really, if you want memory info, you should use memblock to get it
> because all the special cases of memory layout are handled. For
> example you can have memory nodes with multiple 'reg' entries or
> multiple memory nodes or both, and then some of those could be
> contiguous.

I need to have a memory node associated with the tag storage node because
there is a static relationship between a page from "normal" memory and its
associated tag storage. If the code doesn't know that the memory region
A..B has the corresponding tag storage in the region X..Y, then it doesn't
know which tag storage to reserve when a page is allocated as tagged.

In the example above, assuming that page P is allocated as tagged, the
corresponding tag storage page that needs to be reserved is:

tag_storage_pfn = (page_to_pfn(P) - PHYS_PFN(A)) / 32* + PHYS_PFN(X)

numa-node-id is not enough for this, because as far I know you can have
multiple memory regions withing the same numa node.

*32 tagged pages use one tag storage page to store the tags.

Thanks,
Alex


