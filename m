Return-Path: <linux-fsdevel+bounces-5541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041580D3CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0E1F219E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121B4C3DD;
	Mon, 11 Dec 2023 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhoGWDjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A44E1B9;
	Mon, 11 Dec 2023 17:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D725DC433B6;
	Mon, 11 Dec 2023 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702315796;
	bh=VP6rxIE0YrbcOG/9wnq9cB6kaypzUe7LOgu57Kw03yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OhoGWDjz+ZlKfXChXtVyZo+ZKQpmeBytRpThc2k+jzaIgdO4y8wTrqu1pp5xdKoq+
	 YSP2Ea0Zzujdu09Cyw0tPxiSEoQU0ZFc4bcIi1Eu9UR8wNzynUYCLiy7Fj5GQR4ZqL
	 xXmVXpT/EHk1JohfYBIBn9gj+gM+TVCyJzm8uUht85HorFunHJudGcJZc4NSBW6Zmk
	 nX3duK2/kh+NRt5u9wwIKpu9lgA3mMEjlBSmoozvL9wxjp/FnGenPy5xMjQklfhmLB
	 8VKyRaXtdbpsH7Yon4EZRZ0usr3clw50x4oHXjTGL1vaLU3OEIjym5FEsh01x8AUoI
	 rPWxCB3xOMpyQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50be3611794so5564679e87.0;
        Mon, 11 Dec 2023 09:29:55 -0800 (PST)
X-Gm-Message-State: AOJu0YyiqScgjDVOovHibZ4EXqle6LMA0ff/iAx62ZAoZRZwWf34E7Wa
	NvbzB5G3yRD+GJRsvzCHwGfWBT3n5qOsYk4D4w==
X-Google-Smtp-Source: AGHT+IGf9GxCgHbSaCR9ChlHwIzcYeJN/o9beG+fFS/Wj2+MXjJAqODSxU5em7xHCQ26rKUjit1wlHMa263dNGOiUjs=
X-Received: by 2002:ac2:42c3:0:b0:50b:efd4:1475 with SMTP id
 n3-20020ac242c3000000b0050befd41475mr1861829lfl.9.1702315793752; Mon, 11 Dec
 2023 09:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231119165721.9849-1-alexandru.elisei@arm.com> <20231119165721.9849-12-alexandru.elisei@arm.com>
In-Reply-To: <20231119165721.9849-12-alexandru.elisei@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Dec 2023 11:29:40 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
Message-ID: <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com, 
	steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com, 
	david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 10:59=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Allow the kernel to get the size and location of the MTE tag storage
> regions from the DTB. This memory is marked as reserved for now.
>
> The DTB node for the tag storage region is defined as:
>
>         tags0: tag-storage@8f8000000 {
>                 compatible =3D "arm,mte-tag-storage";
>                 reg =3D <0x08 0xf8000000 0x00 0x4000000>;
>                 block-size =3D <0x1000>;
>                 memory =3D <&memory0>;    // Associated tagged memory nod=
e
>         };

I skimmed thru the discussion some. If this memory range is within
main RAM, then it definitely belongs in /reserved-memory.

You need a binding for this too.

> The tag storage region represents the largest contiguous memory region th=
at
> holds all the tags for the associated contiguous memory region which can =
be
> tagged. For example, for a 32GB contiguous tagged memory the correspondin=
g
> tag storage region is 1GB of contiguous memory, not two adjacent 512M of
> tag storage memory.
>
> "block-size" represents the minimum multiple of 4K of tag storage where a=
ll
> the tags stored in the block correspond to a contiguous memory region. Th=
is
> is needed for platforms where the memory controller interleaves tag write=
s
> to memory. For example, if the memory controller interleaves tag writes f=
or
> 256KB of contiguous memory across 8K of tag storage (2-way interleave),
> then the correct value for "block-size" is 0x2000. This value is a hardwa=
re
> property, independent of the selected kernel page size.
>
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
>           Documentation/arch/arm64/memory-tagging-extension.rst.
>
> +if ARM64_MTE
> +config ARM64_MTE_TAG_STORAGE
> +       bool "Dynamic MTE tag storage management"
> +       help
> +         Adds support for dynamic management of the memory used by the h=
ardware
> +         for storing MTE tags. This memory, unlike normal memory, cannot=
 be
> +         tagged. When it is used to store tags for another memory locati=
on it
> +         cannot be used for any type of allocation.
> +
> +         If unsure, say N
> +endif # ARM64_MTE
> +
>  endmenu # "ARMv8.5 architectural features"
>
>  menu "ARMv8.7 architectural features"
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
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
> @@ -70,6 +70,7 @@ obj-$(CONFIG_CRASH_CORE)              +=3D crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)                +=3D sdei.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)           +=3D pointer_auth.o
>  obj-$(CONFIG_ARM64_MTE)                        +=3D mte.o
> +obj-$(CONFIG_ARM64_MTE_TAG_STORAGE)    +=3D mte_tag_storage.o
>  obj-y                                  +=3D vdso-wrap.o
>  obj-$(CONFIG_COMPAT_VDSO)              +=3D vdso32-wrap.o
>  obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)        +=3D patch-scs.o
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_=
tag_storage.c
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

You probably don't need this header. If you depend on what it
implicitly includes, then that will now break in linux-next.

> +#include <linux/of_fdt.h>
> +#include <linux/range.h>
> +#include <linux/string.h>
> +#include <linux/xarray.h>
> +
> +#include <asm/mte_tag_storage.h>
> +
> +struct tag_region {
> +       struct range mem_range; /* Memory associated with the tag storage=
, in PFNs. */
> +       struct range tag_range; /* Tag storage memory, in PFNs. */
> +       u32 block_size;         /* Tag block size, in pages. */
> +};
> +
> +#define MAX_TAG_REGIONS        32
> +
> +static struct tag_region tag_regions[MAX_TAG_REGIONS];
> +static int num_tag_regions;
> +
> +static int __init tag_storage_of_flat_get_range(unsigned long node, cons=
t __be32 *reg,
> +                                               int reg_len, struct range=
 *range)
> +{
> +       int addr_cells =3D dt_root_addr_cells;
> +       int size_cells =3D dt_root_size_cells;
> +       u64 size;
> +
> +       if (reg_len / 4 > addr_cells + size_cells)
> +               return -EINVAL;
> +
> +       range->start =3D PHYS_PFN(of_read_number(reg, addr_cells));
> +       size =3D PHYS_PFN(of_read_number(reg + addr_cells, size_cells));
> +       if (size =3D=3D 0) {
> +               pr_err("Invalid node");
> +               return -EINVAL;
> +       }
> +       range->end =3D range->start + size - 1;

We have a function to read (and translate which you forgot) addresses.
Add what's missing rather than open code your own.

> +
> +       return 0;
> +}
> +
> +static int __init tag_storage_of_flat_get_tag_range(unsigned long node,
> +                                                   struct range *tag_ran=
ge)
> +{
> +       const __be32 *reg;
> +       int reg_len;
> +
> +       reg =3D of_get_flat_dt_prop(node, "reg", &reg_len);
> +       if (reg =3D=3D NULL) {
> +               pr_err("Invalid metadata node");
> +               return -EINVAL;
> +       }
> +
> +       return tag_storage_of_flat_get_range(node, reg, reg_len, tag_rang=
e);
> +}
> +
> +static int __init tag_storage_of_flat_get_memory_range(unsigned long nod=
e, struct range *mem)
> +{
> +       const __be32 *reg;
> +       int reg_len;
> +
> +       reg =3D of_get_flat_dt_prop(node, "linux,usable-memory", &reg_len=
);
> +       if (reg =3D=3D NULL)
> +               reg =3D of_get_flat_dt_prop(node, "reg", &reg_len);
> +
> +       if (reg =3D=3D NULL) {
> +               pr_err("Invalid memory node");
> +               return -EINVAL;
> +       }
> +
> +       return tag_storage_of_flat_get_range(node, reg, reg_len, mem);
> +}
> +
> +struct find_memory_node_arg {
> +       unsigned long node;
> +       u32 phandle;
> +};
> +
> +static int __init fdt_find_memory_node(unsigned long node, const char *u=
name,
> +                                      int depth, void *data)
> +{
> +       const char *type =3D of_get_flat_dt_prop(node, "device_type", NUL=
L);
> +       struct find_memory_node_arg *arg =3D data;
> +
> +       if (depth !=3D 1 || !type || strcmp(type, "memory") !=3D 0)
> +               return 0;
> +
> +       if (of_get_flat_dt_phandle(node) =3D=3D arg->phandle) {
> +               arg->node =3D node;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int __init tag_storage_get_memory_node(unsigned long tag_node, un=
signed long *mem_node)
> +{
> +       struct find_memory_node_arg arg =3D { 0 };
> +       const __be32 *memory_prop;
> +       u32 mem_phandle;
> +       int ret, reg_len;
> +
> +       memory_prop =3D of_get_flat_dt_prop(tag_node, "memory", &reg_len)=
;
> +       if (!memory_prop) {
> +               pr_err("Missing 'memory' property in the tag storage node=
");
> +               return -EINVAL;
> +       }
> +
> +       mem_phandle =3D be32_to_cpup(memory_prop);
> +       arg.phandle =3D mem_phandle;
> +
> +       ret =3D of_scan_flat_dt(fdt_find_memory_node, &arg);

Do not use of_scan_flat_dt. It is a relic predating libfdt which can
get a node by phandle directly.

> +       if (ret !=3D 1) {
> +               pr_err("Associated memory node not found");
> +               return -EINVAL;
> +       }
> +
> +       *mem_node =3D arg.node;
> +
> +       return 0;
> +}
> +
> +static int __init tag_storage_of_flat_read_u32(unsigned long node, const=
 char *propname,
> +                                              u32 *retval)

If you are going to make a generic function, make it for everyone.

> +{
> +       const __be32 *reg;
> +
> +       reg =3D of_get_flat_dt_prop(node, propname, NULL);
> +       if (!reg)
> +               return -EINVAL;
> +
> +       *retval =3D be32_to_cpup(reg);
> +       return 0;
> +}
> +
> +static u32 __init get_block_size_pages(u32 block_size_bytes)
> +{
> +       u32 a =3D PAGE_SIZE;
> +       u32 b =3D block_size_bytes;
> +       u32 r;
> +
> +       /* Find greatest common divisor using the Euclidian algorithm. */
> +       do {
> +               r =3D a % b;
> +               a =3D b;
> +               b =3D r;
> +       } while (b !=3D 0);
> +
> +       return PHYS_PFN(PAGE_SIZE * block_size_bytes / a);
> +}
> +
> +static int __init fdt_init_tag_storage(unsigned long node, const char *u=
name,
> +                                      int depth, void *data)
> +{
> +       struct tag_region *region;
> +       unsigned long mem_node;
> +       struct range *mem_range;
> +       struct range *tag_range;
> +       u32 block_size_bytes;
> +       u32 nid =3D 0;
> +       int ret;
> +
> +       if (depth !=3D 1 || !strstr(uname, "tag-storage"))
> +               return 0;
> +
> +       if (!of_flat_dt_is_compatible(node, "arm,mte-tag-storage"))
> +               return 0;
> +
> +       if (num_tag_regions =3D=3D MAX_TAG_REGIONS) {
> +               pr_err("Maximum number of tag storage regions exceeded");
> +               return -EINVAL;
> +       }
> +
> +       region =3D &tag_regions[num_tag_regions];
> +       mem_range =3D &region->mem_range;
> +       tag_range =3D &region->tag_range;
> +
> +       ret =3D tag_storage_of_flat_get_tag_range(node, tag_range);
> +       if (ret) {
> +               pr_err("Invalid tag storage node");
> +               return ret;
> +       }
> +
> +       ret =3D tag_storage_get_memory_node(node, &mem_node);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D tag_storage_of_flat_get_memory_range(mem_node, mem_range)=
;
> +       if (ret) {
> +               pr_err("Invalid address for associated data memory node")=
;
> +               return ret;
> +       }
> +
> +       /* The tag region must exactly match the corresponding memory. */
> +       if (range_len(tag_range) * 32 !=3D range_len(mem_range)) {
> +               pr_err("Tag storage region 0x%llx-0x%llx does not cover t=
he memory region 0x%llx-0x%llx",
> +                      PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->en=
d),
> +                      PFN_PHYS(mem_range->start), PFN_PHYS(mem_range->en=
d));
> +               return -EINVAL;
> +       }
> +
> +       ret =3D tag_storage_of_flat_read_u32(node, "block-size", &block_s=
ize_bytes);
> +       if (ret || block_size_bytes =3D=3D 0) {
> +               pr_err("Invalid or missing 'block-size' property");
> +               return -EINVAL;
> +       }
> +       region->block_size =3D get_block_size_pages(block_size_bytes);
> +       if (range_len(tag_range) % region->block_size !=3D 0) {
> +               pr_err("Tag storage region size 0x%llx is not a multiple =
of block size %u",
> +                      PFN_PHYS(range_len(tag_range)), region->block_size=
);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &n=
id);

I was going to say we already have a way to associate memory nodes
other nodes using "numa-node-id", so the "memory" phandle property is
somewhat redundant. Maybe the tag node should have a numa-node-id.
With that, it looks like you don't even need to access the /memory
node. Avoiding that would be good for 2 reasons. It avoids parsing
memory nodes twice and it's not the kernel's job to validate the DT.
Really, if you want memory info, you should use memblock to get it
because all the special cases of memory layout are handled. For
example you can have memory nodes with multiple 'reg' entries or
multiple memory nodes or both, and then some of those could be
contiguous.

Rob

