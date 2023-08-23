Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53F7858C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjHWNQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbjHWNQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD9410E7;
        Wed, 23 Aug 2023 06:16:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9101655;
        Wed, 23 Aug 2023 06:16:11 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BD83F740;
        Wed, 23 Aug 2023 06:15:24 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 13/37] arm64: mte: Reserve tag storage memory
Date:   Wed, 23 Aug 2023 14:13:26 +0100
Message-Id: <20230823131350.114942-14-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the kernel to get the size and location of the MTE tag storage memory
from the DTB. This memory is marked as reserved for now, with later patches
adding support for making use of it.

The DTB node for the tag storage region is defined as:

metadata1: metadata@8c0000000  {
	compatible = "arm,mte-tag-storage";
	reg = <0x08 0xc0000000 0x00 0x1000000>;
	block-size = <0x1000>;  // 4k
	memory = <&memory1>; // Associated tagged memory
};

The tag storage region represents the largest contiguous memory region that
holds all the tags for the associated contiguous memory region which can be
tagged. For example, for a 32GB contiguous tagged memory the corresponding
tag storage region is 1GB of contiguous memory, not two adjacent 512M
memory regions.

"block-size" represents the minimum multiple of 4K of tag storage where all
the tags stored in the block correspond to a contiguous memory region. This
in needed for platforms where the memory controller interleaves tag writes
to memory. For example, if the memory controller interleaves tag writes for
256KB of contiguous memory across 8K of tag storage (2-way interleave),
then the correct value for "block-size" is 0x2000.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/Kconfig                       |  12 ++
 arch/arm64/include/asm/memory_metadata.h |   3 +-
 arch/arm64/include/asm/mte_tag_storage.h |  15 ++
 arch/arm64/kernel/Makefile               |   1 +
 arch/arm64/kernel/mte_tag_storage.c      | 262 +++++++++++++++++++++++
 arch/arm64/kernel/setup.c                |   7 +
 6 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
 create mode 100644 arch/arm64/kernel/mte_tag_storage.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f6..ed27bb87babd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2077,6 +2077,18 @@ config ARM64_MTE
 
 	  Documentation/arch/arm64/memory-tagging-extension.rst.
 
+if ARM64_MTE
+config ARM64_MTE_TAG_STORAGE
+	bool "Dynamic MTE tag storage management"
+	select MEMORY_METADATA
+	help
+	  Adds support for dynamic management of the memory used by the hardware
+	  for storing MTE tags. This memory can be used as regular data memory
+	  when it's not used for storing tags.
+
+	  If unsure, say N
+endif # ARM64_MTE
+
 endmenu # "ARMv8.5 architectural features"
 
 menu "ARMv8.7 architectural features"
diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index 132707fce9ab..3287b2776af1 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -14,9 +14,10 @@ static inline bool metadata_storage_enabled(void)
 {
 	return false;
 }
+
 static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 {
-	return false;
+	return !(gfp_mask & __GFP_TAGGED);
 }
 
 #define page_has_metadata(page)			page_mte_tagged(page)
diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
new file mode 100644
index 000000000000..8f86c4f9a7c3
--- /dev/null
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+#ifndef __ASM_MTE_TAG_STORAGE_H
+#define __ASM_MTE_TAG_STORAGE_H
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+void mte_tag_storage_init(void);
+#else
+static inline void mte_tag_storage_init(void)
+{
+}
+#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
+#endif /* __ASM_MTE_TAG_STORAGE_H  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d95b3d6b471a..5f031bf9f8f1 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
+obj-$(CONFIG_ARM64_MTE_TAG_STORAGE)	+= mte_tag_storage.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
 obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.o
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
new file mode 100644
index 000000000000..5014dda9bf35
--- /dev/null
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for dynamic tag storage.
+ *
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/of_device.h>
+#include <linux/of_fdt.h>
+#include <linux/range.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+
+#include <asm/memory_metadata.h>
+#include <asm/mte_tag_storage.h>
+
+struct tag_region {
+	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
+	struct range tag_range;	/* Tag storage memory, in PFNs. */
+	u32 block_size;		/* Tag block size, in pages. */
+};
+
+#define MAX_TAG_REGIONS	32
+
+static struct tag_region tag_regions[MAX_TAG_REGIONS];
+static int num_tag_regions;
+
+static int __init tag_storage_of_flat_get_range(unsigned long node, const __be32 *reg,
+						int reg_len, struct range *range)
+{
+	int addr_cells = dt_root_addr_cells;
+	int size_cells = dt_root_size_cells;
+	u64 size;
+
+	if (reg_len / 4 > addr_cells + size_cells)
+		return -EINVAL;
+
+	range->start = PHYS_PFN(of_read_number(reg, addr_cells));
+	size = PHYS_PFN(of_read_number(reg + addr_cells, size_cells));
+	if (size == 0) {
+		pr_err("Invalid node");
+		return -EINVAL;
+	}
+	range->end = range->start + size - 1;
+
+	return 0;
+}
+
+static int __init tag_storage_of_flat_get_tag_range(unsigned long node,
+						    struct range *tag_range)
+{
+	const __be32 *reg;
+	int reg_len;
+
+	reg = of_get_flat_dt_prop(node, "reg", &reg_len);
+	if (reg == NULL) {
+		pr_err("Invalid metadata node");
+		return -EINVAL;
+	}
+
+	return tag_storage_of_flat_get_range(node, reg, reg_len, tag_range);
+}
+
+static int __init tag_storage_of_flat_get_memory_range(unsigned long node, struct range *mem)
+{
+	const __be32 *reg;
+	int reg_len;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &reg_len);
+	if (reg == NULL)
+		reg = of_get_flat_dt_prop(node, "reg", &reg_len);
+
+	if (reg == NULL) {
+		pr_err("Invalid memory node");
+		return -EINVAL;
+	}
+
+	return tag_storage_of_flat_get_range(node, reg, reg_len, mem);
+}
+
+struct find_memory_node_arg {
+	unsigned long node;
+	u32 phandle;
+};
+
+static int __init fdt_find_memory_node(unsigned long node, const char *uname,
+				       int depth, void *data)
+{
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	struct find_memory_node_arg *arg = data;
+
+	if (depth != 1 || !type || strcmp(type, "memory") != 0)
+		return 0;
+
+	if (of_get_flat_dt_phandle(node) == arg->phandle) {
+		arg->node = node;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __init tag_storage_get_memory_node(unsigned long tag_node, unsigned long *mem_node)
+{
+	struct find_memory_node_arg arg = { 0 };
+	const __be32 *memory_prop;
+	u32 mem_phandle;
+	int ret, reg_len;
+
+	memory_prop = of_get_flat_dt_prop(tag_node, "memory", &reg_len);
+	if (!memory_prop) {
+		pr_err("Missing 'memory' property in the tag storage node");
+		return -EINVAL;
+	}
+
+	mem_phandle = be32_to_cpup(memory_prop);
+	arg.phandle = mem_phandle;
+
+	ret = of_scan_flat_dt(fdt_find_memory_node, &arg);
+	if (ret != 1) {
+		pr_err("Associated memory node not found");
+		return -EINVAL;
+	}
+
+	*mem_node = arg.node;
+
+	return 0;
+}
+
+static int __init tag_storage_of_flat_read_u32(unsigned long node, const char *propname,
+					       u32 *retval)
+{
+	const __be32 *reg;
+
+	reg = of_get_flat_dt_prop(node, propname, NULL);
+	if (!reg)
+		return -EINVAL;
+
+	*retval = be32_to_cpup(reg);
+	return 0;
+}
+
+static u32 __init get_block_size_pages(u32 block_size_bytes)
+{
+	u32 a = PAGE_SIZE;
+	u32 b = block_size_bytes;
+	u32 r;
+
+	/* Find greatest common divisor using the Euclidian algorithm. */
+	do {
+		r = a % b;
+		a = b;
+		b = r;
+	} while (b != 0);
+
+	return PHYS_PFN(PAGE_SIZE * block_size_bytes / a);
+}
+
+static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
+				       int depth, void *data)
+{
+	struct tag_region *region;
+	unsigned long mem_node;
+	struct range *mem_range;
+	struct range *tag_range;
+	u32 block_size_bytes;
+	u32 nid;
+	int ret;
+
+	if (depth != 1 || !strstr(uname, "metadata"))
+		return 0;
+
+	if (!of_flat_dt_is_compatible(node, "arm,mte-tag-storage"))
+		return 0;
+
+	if (num_tag_regions == MAX_TAG_REGIONS) {
+		pr_err("Maximum number of tag storage regions exceeded");
+		return -EINVAL;
+	}
+
+	region = &tag_regions[num_tag_regions];
+	mem_range = &region->mem_range;
+	tag_range = &region->tag_range;
+
+	ret = tag_storage_of_flat_get_tag_range(node, tag_range);
+	if (ret) {
+		pr_err("Invalid tag storage node");
+		return ret;
+	}
+
+	ret = tag_storage_get_memory_node(node, &mem_node);
+	if (ret)
+		return ret;
+
+	ret = tag_storage_of_flat_get_memory_range(mem_node, mem_range);
+	if (ret) {
+		pr_err("Invalid address for associated data memory node");
+		return ret;
+	}
+
+	/* The tag region must exactly match the corresponding memory. */
+	if (range_len(tag_range) * 32 != range_len(mem_range)) {
+		pr_err("Tag region doesn't cover exactly the corresponding memory region");
+		return -EINVAL;
+	}
+
+	ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
+	if (ret || block_size_bytes == 0) {
+		pr_err("Invalid or missing 'block-size' property");
+		return -EINVAL;
+	}
+	region->block_size = get_block_size_pages(block_size_bytes);
+	if (range_len(tag_range) % region->block_size != 0) {
+		pr_err("Tag storage region size is not a multiple of allocation block size");
+		return -EINVAL;
+	}
+
+	ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
+	if (ret)
+		nid = numa_node_id();
+
+	ret = memblock_add_node(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)),
+				nid, MEMBLOCK_NONE);
+	if (ret) {
+		pr_err("Error adding tag memblock (%d)", ret);
+		return ret;
+	}
+	memblock_reserve(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
+
+	pr_info("Found MTE tag storage region 0x%llx@0x%llx, block size %u pages",
+		PFN_PHYS(range_len(tag_range)), PFN_PHYS(tag_range->start), region->block_size);
+
+	num_tag_regions++;
+
+	return 0;
+}
+
+void __init mte_tag_storage_init(void)
+{
+	struct range *tag_range;
+	int i, ret;
+
+	ret = of_scan_flat_dt(fdt_init_tag_storage, NULL);
+	if (ret) {
+		pr_err("MTE tag storage management disabled");
+		goto out_err;
+	}
+
+	if (num_tag_regions == 0)
+		pr_info("No MTE tag storage regions detected");
+
+	return;
+
+out_err:
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		memblock_remove(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
+	}
+	num_tag_regions = 0;
+}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..1b77138c1aa5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/kasan.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/numa.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
@@ -342,6 +343,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 			   FW_BUG "Booted with MMU enabled!");
 	}
 
+	/*
+	 * Must be called before memory limits are enforced by
+	 * arm64_memblock_init().
+	 */
+	mte_tag_storage_init();
+
 	arm64_memblock_init();
 
 	paging_init();
-- 
2.41.0

