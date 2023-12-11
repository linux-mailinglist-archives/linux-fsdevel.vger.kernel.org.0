Return-Path: <linux-fsdevel+bounces-5498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB4780CE9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7961F21859
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1D495DA;
	Mon, 11 Dec 2023 14:45:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A21EC2;
	Mon, 11 Dec 2023 06:45:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0141FEC;
	Mon, 11 Dec 2023 06:45:54 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD8A03F738;
	Mon, 11 Dec 2023 06:45:02 -0800 (PST)
Date: Mon, 11 Dec 2023 14:45:00 +0000
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
Message-ID: <ZXcgbJsFRotjOgUw@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a@epcas2p2.samsung.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com>
 <20231129084424.GA2988384@tiffany>
 <ZWxxJipc2STxHHKn@raptor>
 <20231208050340.GA1359878@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208050340.GA1359878@tiffany>

Hi,

On Fri, Dec 08, 2023 at 02:03:44PM +0900, Hyesoo Yu wrote:
> Hi, 
> 
> I'm sorry for the late response, I was on vacation.
> 
> On Sun, Dec 03, 2023 at 12:14:30PM +0000, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Wed, Nov 29, 2023 at 05:44:24PM +0900, Hyesoo Yu wrote:
> > > Hello.
> > > 
> > > On Sun, Nov 19, 2023 at 04:57:05PM +0000, Alexandru Elisei wrote:
> > > > Allow the kernel to get the size and location of the MTE tag storage
> > > > regions from the DTB. This memory is marked as reserved for now.
> > > > 
> > > > The DTB node for the tag storage region is defined as:
> > > > 
> > > >         tags0: tag-storage@8f8000000 {
> > > >                 compatible = "arm,mte-tag-storage";
> > > >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> > > >                 block-size = <0x1000>;
> > > >                 memory = <&memory0>;	// Associated tagged memory node
> > > >         };
> > > >
> > > 
> > > How about using compatible = "shared-dma-pool" like below ?
> > > 
> > > &reserved_memory {
> > > 	tags0: tag0@8f8000000 {
> > > 		compatible = "arm,mte-tag-storage";
> > >         	reg = <0x08 0xf8000000 0x00 0x4000000>;
> > > 	};
> > > }
> > > 
> > > tag-storage {
> > >         compatible = "arm,mte-tag-storage";
> > > 	memory-region = <&tag>;
> > >         memory = <&memory0>;
> > > 	block-size = <0x1000>;
> > > }
> > > 
> > > And then, the activation of CMA would be performed in the CMA code.
> > > We just can get the region information from memory-region and allocate it directly
> > > like alloc_contig_range, take_page_off_buddy. It seems like we can remove a lots of code.
> >
> 
> Sorry, that example was my mistake. Actually I wanted to write like this. 
> 
> &reserved_memory {
> 	tags0: tag0@8f8000000 {
> 		compatible = "shared-dma-pool";
>         	reg = <0x08 0xf8000000 0x00 0x4000000>;
> 		reusable;
> 	};
> }
> 
> tag-storage {
>         compatible = "arm,mte-tag-storage";
>  	memory-region = <&tag>;
>         memory = <&memory0>;
> 	block-size = <0x1000>;
> }

I prototyped your suggestion with this change to the device tree:

            reserved-memory {
                    #address-cells = <0x02>;
                    #size-cells = <0x02>;
                    ranges;

                    tags0: tag-storage@8f8000000 {
                            compatible = "arm,mte-tag-storage";
                            reg = <0x08 0xf8000000 0x00 0x4000000>;
                            block-size = <0x1000>;
                            memory = <&memory0>;
                            reusable;
                    };
            };

Would you mind explaining what we are gaining by using reserved mem?

Struct reserved_mem only has the base and size of the tag storage region,
and initialization for reserved mem happens before the DTB is unflattened.
When I prototyped using reserved mem, I still had to write the code to
parse the memory node address and size. This code was the same as the code
needed to parse the tag storage region address and size, so having that
information in struct reserved_mem does not reduce the size of the code by
a meaningful amount.

> 
> 
> > Played with reserved_mem a bit. I don't think that's the correct path
> > forward.
> > 
> > The location of the tag storage is a hardware property, independent of how
> > Linux is configured.
> > 
> > early_init_fdt_scan_reserved_mem() is called from arm64_memblock_init(),
> > **after** the kernel enforces an upper address for various reasons. One of
> > the reasons can be that it's been compiled with 39 bits VA.
> > 
> 
> I'm not sure about this part. What is the upper address enforced by the kernel ?
> Where can I check the code ? Do you means that memblock_end_of_DRAM() ?  

I am referring to arch/arm64/mm/init.c:: arm64_memblock_init(). The
function initializes reserved mem (in early_init_fdt_scan_reserved_mem())
**after**removing memory from memblock that the kernel cannot address.

> 
> > After early_init_fdt_scan_reserved_mem() returns, the kernel sets the
> > maximum address, stored in the variable "high_memory".
> >
> > What can happen is that tag storage is present at an address above the
> > maximum addressable by the kernel, and the CMA code will trigger an
> > unrecovrable page fault.
> > 
> > I was able to trigger this with the dts change:
> > 
> > diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > index 60472d65a355..201359d014e4 100644
> > --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> > @@ -183,6 +183,13 @@ vram: vram@18000000 {
> >                         reg = <0x00000000 0x18000000 0 0x00800000>;
> >                         no-map;
> >                 };
> > +
> > +
> > +               linux,cma {
> > +                       compatible = "shared-dma-pool";
> > +                       reg = <0x100 0x0 0x00 0x4000000>;
> > +                       reusable;
> > +               };
> >         };
> > 
> >         gic: interrupt-controller@2f000000 {
> > 
> > And the error I got:
> > 
> > [    0.000000] Reserved memory: created CMA memory pool at 0x0000010000000000, size 64 MiB
> > [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
> > [    0.000000] OF: reserved mem: 0x0000010000000000..0x0000010003ffffff (65536 KiB) map reusable linux,cma
> > [..]
> > [    0.793193] WARNING: CPU: 0 PID: 1 at mm/cma.c:111 cma_init_reserved_areas+0xa8/0x378
> > [..]
> > [    0.806945] Unable to handle kernel paging request at virtual address 00000001fe000000
> > [    0.807277] Mem abort info:
> > [    0.807277]   ESR = 0x0000000096000005
> > [    0.807693]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    0.808110]   SET = 0, FnV = 0
> > [    0.808443]   EA = 0, S1PTW = 0
> > [    0.808526]   FSC = 0x05: level 1 translation fault
> > [    0.808943] Data abort info:
> > [    0.808943]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > [    0.809360]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    0.809776]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    0.810221] [00000001fe000000] user address but active_mm is swapper
> > [..]
> > [    0.820887] Call trace:
> > [    0.821027]  cma_init_reserved_areas+0xc4/0x378
> > [    0.821443]  do_one_initcall+0x7c/0x1c0
> > [    0.821860]  kernel_init_freeable+0x1bc/0x284
> > [    0.822277]  kernel_init+0x24/0x1dc
> > [    0.822693]  ret_from_fork+0x10/0x20
> > [    0.823554] Code: 9127a29a cb813321 d37ae421 8b030020 (f8636822)
> > [    0.823554] ---[ end trace 0000000000000000 ]---
> > [    0.824360] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [    0.824443] SMP: stopping secondary CPUs
> > [    0.825193] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> > 
> > Should reserved mem check if the reserved memory is actually addressable by
> > the kernel if it's not "no-map"? Should cma fail gracefully if
> > !pfn_valid(base_pfn)? Shold early_init_fdt_scan_reserved_mem() be moved
> > because arm64_bootmem_init()? I don't have the answer to any of those. And
> > I got a kernel panic because the kernel cannot address that memory (39 bits
> > VA). I don't know what would happen if the upper limit is reduced for
> > another reason.
> > 
> 
> My answer may not be accurate because I don't understand what this upper limit is.
> Is this a problem caused by the tag storage area not being included in the memory node ?

This problem is caused by the kernel cannot using virtual addresses in the
linear map (where VA == PA) to access the tag storage region.

> 
> The reason for not including it in the memory node is to enable static mte when dmte
> initilization fails, right ? I think I missed that. I thought the tag storage is included
> in the memory node and registered as cma.
> 
> > What I think should happen:
> > 
> > 1. Add the tag storage memory before any limits are enforced by
> > arm64_bootmem_init().
> >
> > 2. Call cma_declare_contiguous_nid() after arm64_bootmem_init(), because
> > the function will check the memory limit.
> > 
> > 3. Have an arch initcall that checks that the CMA regions corresponding to
> > the tag storage have been activated successfully (cma_init_reserved_areas()
> > is a core initcall). If not, then don't enable tag storage.
> > 
> > How does that sound to you?
> > 
> > Thanks,
> > Alex
> > 
> 
> I think this is a good way to utilize the cma code !

Cool, thanks!

Alex

> 
> Thanks,
> Regards.
> 
> > > > +	ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
> > > > +	if (ret || block_size_bytes == 0) {
> > > > +		pr_err("Invalid or missing 'block-size' property");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	region->block_size = get_block_size_pages(block_size_bytes);
> > > > +	if (range_len(tag_range) % region->block_size != 0) {
> > > > +		pr_err("Tag storage region size 0x%llx is not a multiple of block size %u",
> > > > +		       PFN_PHYS(range_len(tag_range)), region->block_size);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > 
> > > I was confused about the variable "block_size", The block size declared in the device tree is
> > > in bytes, but the actual block size used is in pages. I think the term "block_size" can cause
> > > confusion as it might be interpreted as bytes. If possible, I suggest changing the term "block_size"
> > > to something more readable, such as "block_nr_pages" (This is just a example!)
> > > 
> > > Thanks,
> > > Regards.
> >>
> 
> What do you think about this ?
> 
> Thanks,
> Regards.
> 
> > > > +	ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
> > > > +	if (ret)
> > > > +		nid = numa_node_id();
> > > > +
> > > > +	ret = memblock_add_node(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)),
> > > > +				nid, MEMBLOCK_NONE);
> > > > +	if (ret) {
> > > > +		pr_err("Error adding tag memblock (%d)", ret);
> > > > +		return ret;
> > > > +	}
> > > > +	memblock_reserve(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > > > +
> > > > +	pr_info("Found tag storage region 0x%llx-0x%llx, block size %u pages",
> > > > +		PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end), region->block_size);
> > > > +
> > > > +	num_tag_regions++;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void __init mte_tag_storage_init(void)
> > > > +{
> > > > +	struct range *tag_range;
> > > > +	int i, ret;
> > > > +
> > > > +	ret = of_scan_flat_dt(fdt_init_tag_storage, NULL);
> > > > +	if (ret) {
> > > > +		for (i = 0; i < num_tag_regions; i++) {
> > > > +			tag_range = &tag_regions[i].tag_range;
> > > > +			memblock_remove(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > > > +		}
> > > > +		num_tag_regions = 0;
> > > > +		pr_info("MTE tag storage region management disabled");
> > > > +	}
> > > > +}
> > > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > > index 417a8a86b2db..1b77138c1aa5 100644
> > > > --- a/arch/arm64/kernel/setup.c
> > > > +++ b/arch/arm64/kernel/setup.c
> > > > @@ -42,6 +42,7 @@
> > > >  #include <asm/cpufeature.h>
> > > >  #include <asm/cpu_ops.h>
> > > >  #include <asm/kasan.h>
> > > > +#include <asm/mte_tag_storage.h>
> > > >  #include <asm/numa.h>
> > > >  #include <asm/scs.h>
> > > >  #include <asm/sections.h>
> > > > @@ -342,6 +343,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> > > >  			   FW_BUG "Booted with MMU enabled!");
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * Must be called before memory limits are enforced by
> > > > +	 * arm64_memblock_init().
> > > > +	 */
> > > > +	mte_tag_storage_init();
> > > > +
> > > >  	arm64_memblock_init();
> > > >  
> > > >  	paging_init();
> > > > -- 
> > > > 2.42.1
> > > > 
> > > > 
> > 
> > 
> > 



