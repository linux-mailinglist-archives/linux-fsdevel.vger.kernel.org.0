Return-Path: <linux-fsdevel+bounces-8962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5783C8AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849251C214F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE713E219;
	Thu, 25 Jan 2024 16:44:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68913E222;
	Thu, 25 Jan 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201080; cv=none; b=A6RBxP+oZk/JsWZ3grJSHl/Qb94iYYP9i0+ngmTKhFz0OmYlY41UfmyZUeWk3p7HWDwWkHSzNNCB1Op4FPIS+s0iiy0OUNl1q3FEotwpsjin+/XJnHmohZgYIiucGFacvqSh7+xIIKxAeAPrWIzfI9KtOyKYZRXdn0ojIm94P+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201080; c=relaxed/simple;
	bh=XukQx5R0ddUBbcqQsHqz8JxEh94JF8KFUT0xeK6jImA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZX71EtyprbfkM2gbEnl9c6e5tTlN6ie9IWn0tzo4QYovnrEzkO+Sx5WfMCy0JrBgcugDJcsJrlYDMpoOEDJAEJIkmP0qHx03eKObqWMu/IDRGZMLYujiUrKfTZHX3iucCpiSNVowIKCCErt5SJaRV5blmdHY8enNeP36QvmqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607B01682;
	Thu, 25 Jan 2024 08:45:21 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711BE3F5A1;
	Thu, 25 Jan 2024 08:44:31 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 19/35] arm64: mte: Discover tag storage memory
Date: Thu, 25 Jan 2024 16:42:40 +0000
Message-Id: <20240125164256.4147-20-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the kernel to get the base address, size, block size and associated
memory node for tag storage from the device tree blob.

A tag storage region represents the smallest contiguous memory region that
holds all the tags for the associated contiguous memory region which can be
tagged. For example, for a 32GB contiguous tagged memory the corresponding
tag storage region is exactly 1GB of contiguous memory, not two adjacent
512M of tag storage memory, nor one 2GB tag storage region.

Tag storage is described as reserved memory; future patches will teach the
kernel how to make use of it for data (non-tagged) allocations.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* Reworked from rfc v2 patch #11 ("arm64: mte: Reserve tag storage memory").
* Added device tree schema (Rob Herring)
* Tag storage memory is now described in the "reserved-memory" node (Rob
Herring).

 .../reserved-memory/arm,mte-tag-storage.yaml  |  78 +++++++++
 arch/arm64/Kconfig                            |  12 ++
 arch/arm64/include/asm/mte_tag_storage.h      |  16 ++
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/mte_tag_storage.c           | 158 ++++++++++++++++++
 arch/arm64/mm/init.c                          |   3 +
 6 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,mte-tag-storage.yaml
 create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
 create mode 100644 arch/arm64/kernel/mte_tag_storage.c

diff --git a/Documentation/devicetree/bindings/reserved-memory/arm,mte-tag-storage.yaml b/Documentation/devicetree/bindings/reserved-memory/arm,mte-tag-storage.yaml
new file mode 100644
index 000000000000..a99aaa1e8b6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/arm,mte-tag-storage.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/arm,mte-tag-storage.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tag storage memory for Memory Tagging Extension
+
+description: |
+  Description of the tag storage memory region that Linux can use to store
+  data when the associated memory is not tagged.
+
+  The reserved memory described by the node must also be described by a
+  standalone 'memory' node.
+
+maintainers:
+  - Alexandru Elisei <alexandru.elisei@arm.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: arm,mte-tag-storage
+
+  reg:
+    description: |
+      Specifies the memory region that MTE uses for tag storage. The size of the
+      region must be equal to the size needed to store all the tags for the
+      associated tagged memory.
+
+  block-size:
+    description: |
+      Specifies the minimum multiple of 4K bytes of tag storage where all the
+      tags stored in the block correspond to a contiguous memory region. This
+      is needed for platforms where the memory controller interleaves tag
+      writes to memory.
+
+      For example, if the memory controller interleaves tag writes for 256KB
+      of contiguous memory across 8K of tag storage (2-way interleave), then
+      the correct value for 'block-size' is 0x2000.
+
+      This value is a hardware property, independent of the selected kernel page
+      size.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  tagged-memory:
+    description: |
+      Specifies the memory node, as a phandle, for which all the tags are
+      stored in the tag storage region.
+
+      The memory node must describe one contiguous memory region (i.e, the
+      'ranges' property of the memory node must have exactly one entry).
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - block-size
+  - tagged-memory
+  - reusable
+
+examples:
+  - |
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      tags0: tag-storage@8f8000000 {
+        compatible = "arm,mte-tag-storage";
+        reg = <0x08 0xf8000000 0x00 0x4000000>;
+        block-size = <0x1000>;
+        tagged-memory = <&memory0>;
+        reusable;
+      };
+    };
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..92d97930b56e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2082,6 +2082,18 @@ config ARM64_MTE
 
 	  Documentation/arch/arm64/memory-tagging-extension.rst.
 
+if ARM64_MTE
+config ARM64_MTE_TAG_STORAGE
+	bool
+	help
+	  Adds support for dynamic management of the memory used by the hardware
+	  for storing MTE tags. This memory, unlike normal memory, cannot be
+	  tagged. When it is used to store tags for another memory location it
+	  cannot be used for any type of allocation.
+
+	  If unsure, say N
+endif # ARM64_MTE
+
 endmenu # "ARMv8.5 architectural features"
 
 menu "ARMv8.7 architectural features"
diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
new file mode 100644
index 000000000000..3c2cd29e053e
--- /dev/null
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+#ifndef __ASM_MTE_TAG_STORAGE_H
+#define __ASM_MTE_TAG_STORAGE_H
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+void mte_init_tag_storage(void);
+#else
+static inline void mte_init_tag_storage(void)
+{
+}
+#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
+
+#endif /* __ASM_MTE_TAG_STORAGE_H  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index e5d03a7039b4..89c28b538908 100644
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
index 000000000000..2f32265d8ad8
--- /dev/null
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for dynamic tag storage.
+ *
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/range.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+
+#include <asm/mte_tag_storage.h>
+
+struct tag_region {
+	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
+	struct range tag_range;	/* Tag storage memory, in PFNs. */
+	u32 block_size_pages;	/* Tag block size, in pages. */
+	phandle mem_phandle;	/* phandle for the associated memory node. */
+};
+
+#define MAX_TAG_REGIONS	32
+
+static struct tag_region tag_regions[MAX_TAG_REGIONS];
+static int num_tag_regions;
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
+int __init tag_storage_probe(struct reserved_mem *rmem)
+{
+	struct tag_region *region;
+	u32 block_size_bytes;
+	int ret;
+
+	if (num_tag_regions == MAX_TAG_REGIONS) {
+		pr_err("Exceeded maximum number of tag storage regions");
+		goto out_err;
+	}
+
+	region = &tag_regions[num_tag_regions];
+	region->tag_range.start = PHYS_PFN(rmem->base);
+	region->tag_range.end = PHYS_PFN(rmem->base + rmem->size - 1);
+
+	ret = of_flat_read_u32(rmem->fdt_node, "block-size", &block_size_bytes);
+	if (ret || block_size_bytes == 0) {
+		pr_err("Invalid or missing 'block-size' property");
+		goto out_err;
+	}
+
+	region->block_size_pages = get_block_size_pages(block_size_bytes);
+	if (range_len(&region->tag_range) % region->block_size_pages != 0) {
+		pr_err("Tag storage region size 0x%llx pages is not a multiple of block size 0x%x pages",
+		       range_len(&region->tag_range), region->block_size_pages);
+		goto out_err;
+	}
+
+	ret = of_flat_read_u32(rmem->fdt_node, "tagged-memory", &region->mem_phandle);
+	if (ret) {
+		pr_err("Invalid or missing 'tagged-memory' property");
+		goto out_err;
+	}
+
+	num_tag_regions++;
+	return 0;
+
+out_err:
+	num_tag_regions = 0;
+	return -EINVAL;
+}
+RESERVEDMEM_OF_DECLARE(tag_storage, "arm,mte-tag-storage", tag_storage_probe);
+
+static int __init mte_find_tagged_memory_regions(void)
+{
+	struct device_node *mem_dev;
+	struct tag_region *region;
+	struct range *mem_range;
+	const __be32 *reg;
+	u64 addr, size;
+	int i;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		region = &tag_regions[i];
+		mem_range = &region->mem_range;
+
+		mem_dev = of_find_node_by_phandle(region->mem_phandle);
+		if (!mem_dev) {
+			pr_err("Cannot find tagged memory node");
+			goto out;
+		}
+
+		reg = of_get_property(mem_dev, "reg", NULL);
+		if (!reg) {
+			pr_err("Invalid tagged memory node");
+			goto out_put_mem;
+		}
+
+		addr = of_translate_address(mem_dev, reg);
+		if (addr == OF_BAD_ADDR) {
+			pr_err("Invalid memory address");
+			goto out_put_mem;
+		}
+
+		size = of_read_number(reg + of_n_addr_cells(mem_dev), of_n_size_cells(mem_dev));
+		if (!size) {
+			pr_err("Invalid memory size");
+			goto out_put_mem;
+		}
+
+		mem_range->start = PHYS_PFN(addr);
+		mem_range->end = PHYS_PFN(addr + size - 1);
+
+		of_node_put(mem_dev);
+	}
+
+	return 0;
+
+out_put_mem:
+	of_node_put(mem_dev);
+out:
+	return -EINVAL;
+}
+
+void __init mte_init_tag_storage(void)
+{
+	int ret;
+
+	if (num_tag_regions == 0)
+		return;
+
+	ret = mte_find_tagged_memory_regions();
+	if (ret)
+		goto out_disabled;
+
+	return;
+
+out_disabled:
+	num_tag_regions = 0;
+	pr_info("MTE tag storage region management disabled");
+}
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..2ccc0c294a13 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -39,6 +39,7 @@
 #include <asm/kernel-pgtable.h>
 #include <asm/kvm_host.h>
 #include <asm/memory.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/numa.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -386,6 +387,8 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
+	mte_init_tag_storage();
+
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
 	 * detected at build time already.
-- 
2.43.0


