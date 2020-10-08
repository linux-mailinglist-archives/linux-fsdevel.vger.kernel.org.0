Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC2286FED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgJHHxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgJHHxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:53:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BDC061755;
        Thu,  8 Oct 2020 00:53:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g10so3313926pfc.8;
        Thu, 08 Oct 2020 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qJjIPlozmkNYa4hgIbvz/Ie5BxbOL9v4A/WGUmTXOls=;
        b=A4CotWTUv4SSKawvuG4fyX6lmUYxauvlfzbK1VGFGliw/+Hb4vF0kP8GJdQz4m7JCS
         zcOt6ayVl6ZCzFN6BS3VAPJxOvIimyACt8iGuIvSGcZ5d0DZ9oKSTUi5XgiAUAdKDcwO
         8UC8kML3jRdtqYTI4PzQLf8OYsO+WzLhTwWIE5RRZRPRsoGTOf5Z1agcglxa4bBcirrs
         yb3XOIkfpGPu/QOnfcxSHqCb9LvFFB78MuMLnbBnGc1oMpDkf2X+IkXeCDiKLSdU1pTH
         7XHLFH9TDBbYG7k3BW09q8DElgZDdwWo4zqxuMGtDNvqdniygQmWNyAOc4mImThOKqPU
         vKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qJjIPlozmkNYa4hgIbvz/Ie5BxbOL9v4A/WGUmTXOls=;
        b=c30I08WcujtvKHxR2HDDITENeJwx1SmMtcbg/3oOhzzK0/nVa0EdDhOlvemPgC4TyT
         gRKcC1dv6OkeuU+5PIKbmQRqP0swWesy5KK7HoDPxi9cedP8Tz42rfYKQsPuvLcnDJDq
         ZO2O98LzUZggIOKVHc5nvWV9aN+ctMbqhN7MuYsVFRabp0nhLAgD91zkDNKKs26B5FHn
         8qE0pMpkS9Yjh4BvpgPqYpzAERqjUUuE+VJUH5bz3+KxgxTnC2coCzzRODqrqOclY5rt
         MtHEs2FfHBRy+QLoVhxGapJpQXpvGA+JGX7dzIDQunEWPrcdi0ISueXuHdLHluTt9pG0
         RFZg==
X-Gm-Message-State: AOAM531hWnLLVah2Crzo16lJ81SLvpBFU+D6U242gfKr68nHvNgG4S/K
        Z/QrUJ2ZkQ5qeForQ/zEJmE=
X-Google-Smtp-Source: ABdhPJy8yQp1z0/EalCAAT6S8LqSFEXVSQ8GG6uPZn0IqwOk8P7RdzdwXjS6vW3DkFtBn5pa0rRPDw==
X-Received: by 2002:a62:5382:0:b029:155:6333:ce4f with SMTP id h124-20020a6253820000b02901556333ce4fmr777107pfb.28.1602143619365;
        Thu, 08 Oct 2020 00:53:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:53:38 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 02/35] mm: support direct memory reservation
Date:   Thu,  8 Oct 2020 15:53:52 +0800
Message-Id: <2fbc347a5f52591fc9da8d708fef0be238eb06a5.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Introduce 'dmem=' to reserve system memory for DMEM (direct memory),
comparing with 'mem=' and 'memmap', it reserves memory based on the
topology of NUMA, for the detailed info, please refer to
kernel-parameters.txt

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 .../admin-guide/kernel-parameters.txt         |  38 +++
 arch/x86/kernel/setup.c                       |   3 +
 include/linux/dmem.h                          |  16 +
 mm/Kconfig                                    |   9 +
 mm/Makefile                                   |   1 +
 mm/dmem.c                                     | 137 ++++++++
 mm/dmem_reserve.c                             | 303 ++++++++++++++++++
 7 files changed, 507 insertions(+)
 create mode 100644 include/linux/dmem.h
 create mode 100644 mm/dmem.c
 create mode 100644 mm/dmem_reserve.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..da15d4fc49db 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -980,6 +980,44 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	dmem=[!]size[KMG]
+			[KNL, NUMA] When CONFIG_DMEM is set, this means
+			the size of memory reserved for dmemfs on each numa
+			memory node and 'size' must be aligned to the default
+			alignment that is the size of memory section which is
+			128M on default on x86_64. If set '!', such amount of
+			memory on each node will be owned by kernel and dmemfs
+			own the rest of memory on each node.
+			Example: Reserve 4G memory on each node for dmemfs
+				dmem = 4G
+
+	dmem=[!]size[KMG]:align[KMG]
+			[KNL, NUMA] Ditto. 'align' should be power of two and
+			it's not smaller than the default alignment. Also
+			'size' must be aligned to 'align'.
+			Example: Bad dmem parameter because 'size' misaligned
+				dmem=0x40200000:1G
+
+	dmem=size[KMG]@addr[KMG]
+			[KNL] When CONFIG_DMEM is set, this marks specific
+			memory as reserved for dmemfs. Region of memory will be
+			used by dmemfs, from addr to addr + size. Reserving a
+			certain memory region for kernel is illegal so '!' is
+			forbidden. Should not assign 'addr' to 0 because kernel
+			will occupy fixed memory region begin at 0 address.
+			Ditto, 'size' and 'addr' must be aligned to default
+			alignment.
+			Example: Exclude memory from 5G-6G for dmemfs.
+				dmem=1G@5G
+
+	dmem=size[KMG]@addr[KMG]:align[KMG]
+			[KNL] Ditto. 'align' should be power of two and it's
+			not smaller than the default alignment. Also 'size'
+			and 'addr' must be aligned to 'align'. Specially,
+			'@addr' and ':align' could occur in any order.
+			Example: Exclude memory from 5G-6G for dmemfs.
+				dmem=1G:1G@5G
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously.
 			Format: <driver_name1>,<driver_name2>...
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc74..c2e59093a95e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#include <linux/dmem.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -1177,6 +1178,8 @@ void __init setup_arch(char **cmdline_p)
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
+	dmem_reserve_init();
+
 	x86_init.paging.pagetable_init();
 
 	kasan_init();
diff --git a/include/linux/dmem.h b/include/linux/dmem.h
new file mode 100644
index 000000000000..5049322d941c
--- /dev/null
+++ b/include/linux/dmem.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_DMEM_H
+#define _LINUX_DMEM_H
+
+#ifdef CONFIG_DMEM
+int dmem_reserve_init(void);
+void dmem_init(void);
+int dmem_region_register(int node, phys_addr_t start, phys_addr_t end);
+
+#else
+static inline int dmem_reserve_init(void)
+{
+	return 0;
+}
+#endif
+#endif	/* _LINUX_DMEM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f..e1995da11cea 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -226,6 +226,15 @@ config BALLOON_COMPACTION
 	  scenario aforementioned and helps improving memory defragmentation.
 
 #
+# support for direct memory basics
+config DMEM
+	bool "Direct Memory Reservation"
+	def_bool n
+	depends on SPARSEMEM
+	help
+	  Allow reservation of memory which could be dedicated usage of dmem.
+	  It's the basics of dmemfs.
+
 # support for memory compaction
 config COMPACTION
 	bool "Allow for memory compaction"
diff --git a/mm/Makefile b/mm/Makefile
index d5649f1c12c0..97fa2fdf492e 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_DMEM) += dmem.o dmem_reserve.o
diff --git a/mm/dmem.c b/mm/dmem.c
new file mode 100644
index 000000000000..b5fb4f1b92db
--- /dev/null
+++ b/mm/dmem.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * memory management for dmemfs
+ *
+ * Authors:
+ *   Xiao Guangrong  <gloryxiao@tencent.com>
+ *   Chen Zhuo	     <sagazchen@tencent.com>
+ *   Haiwei Li	     <gerryhwli@tencent.com>
+ *   Yulei Zhang     <yuleixzhang@tencent.com>
+ */
+#include <linux/mempolicy.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/cpuset.h>
+#include <linux/nodemask.h>
+#include <linux/topology.h>
+#include <linux/dmem.h>
+#include <linux/debugfs.h>
+#include <linux/notifier.h>
+
+/*
+ * There are two kinds of page in dmem management:
+ * - nature page, it's the CPU's page size, i.e, 4K on x86
+ *
+ * - dmem page, it's the unit size used by dmem itself to manage all
+ *     registered memory. It's set by dmem_alloc_init()
+ */
+struct dmem_region {
+	/* original registered memory region */
+	phys_addr_t reserved_start_addr;
+	phys_addr_t reserved_end_addr;
+
+	/* memory region aligned to dmem page */
+	phys_addr_t dpage_start_pfn;
+	phys_addr_t dpage_end_pfn;
+
+	/*
+	 * avoid memory allocation if the dmem region is small enough
+	 */
+	unsigned long static_bitmap;
+	unsigned long *bitmap;
+	u64 next_free_pos;
+	struct list_head node;
+
+	unsigned long static_error_bitmap;
+	unsigned long *error_bitmap;
+};
+
+/*
+ * statically define number of regions to avoid allocating memory
+ * dynamically from memblock as slab is not available at that time
+ */
+#define DMEM_REGION_PAGES	2
+#define INIT_REGION_NUM							\
+	((DMEM_REGION_PAGES << PAGE_SHIFT) / sizeof(struct dmem_region))
+
+static struct dmem_region static_regions[INIT_REGION_NUM];
+
+struct dmem_node {
+	unsigned long total_dpages;
+	unsigned long free_dpages;
+
+	/* fallback list for allocation */
+	int nodelist[MAX_NUMNODES];
+	struct list_head regions;
+};
+
+struct dmem_pool {
+	struct mutex lock;
+
+	unsigned long region_num;
+	unsigned long registered_pages;
+	unsigned long unaligned_pages;
+
+	/* shift bits of dmem page */
+	unsigned long dpage_shift;
+
+	unsigned long total_dpages;
+	unsigned long free_dpages;
+
+	/*
+	 * increased when allocator is initialized,
+	 * stop it being destroyed when someone is
+	 * still using it
+	 */
+	u64 user_count;
+	struct dmem_node nodes[MAX_NUMNODES];
+};
+
+static struct dmem_pool dmem_pool = {
+	.lock = __MUTEX_INITIALIZER(dmem_pool.lock),
+};
+
+#define for_each_dmem_node(_dnode)					\
+	for (_dnode = dmem_pool.nodes;					\
+		_dnode < dmem_pool.nodes + ARRAY_SIZE(dmem_pool.nodes);	\
+		_dnode++)
+
+void __init dmem_init(void)
+{
+	struct dmem_node *dnode;
+
+	pr_info("dmem: pre-defined region: %ld\n", INIT_REGION_NUM);
+
+	for_each_dmem_node(dnode)
+		INIT_LIST_HEAD(&dnode->regions);
+}
+
+/*
+ * register the memory region to dmem pool as freed memory, the region
+ * should be properly aligned to PAGE_SIZE at least
+ *
+ * it's safe to be out of dmem_pool's lock as it's used at the very
+ * beginning of system boot
+ */
+int dmem_region_register(int node, phys_addr_t start, phys_addr_t end)
+{
+	struct dmem_region *dregion;
+
+	pr_info("dmem: register region [%#llx - %#llx] on node %d.\n",
+		(unsigned long long)start, (unsigned long long)end, node);
+
+	if (unlikely(dmem_pool.region_num >= INIT_REGION_NUM)) {
+		pr_err("dmem: region is not sufficient.\n");
+		return -ENOMEM;
+	}
+
+	dregion = &static_regions[dmem_pool.region_num++];
+	dregion->reserved_start_addr = start;
+	dregion->reserved_end_addr = end;
+
+	list_add_tail(&dregion->node, &dmem_pool.nodes[node].regions);
+	dmem_pool.registered_pages += __phys_to_pfn(end) -
+					__phys_to_pfn(start);
+	return 0;
+}
diff --git a/mm/dmem_reserve.c b/mm/dmem_reserve.c
new file mode 100644
index 000000000000..567ee9f18a7d
--- /dev/null
+++ b/mm/dmem_reserve.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support reserved memory for dmem.
+ * As dmem_reserve_init will adjust memblock to reserve memory
+ * for dmem, we could save a vast amount of memory for 'struct page'.
+ *
+ * Authors:
+ *   Xiao Guangrong  <gloryxiao@tencent.com>
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <linux/log2.h>
+#include <linux/dmem.h>
+
+struct dmem_param {
+	phys_addr_t base;
+	phys_addr_t size;
+	phys_addr_t align;
+	/*
+	 * If set to 1, dmem_param specified requested memory for kernel,
+	 * otherwise for dmem.
+	 */
+	bool resv_kernel;
+};
+
+static struct dmem_param dmem_param __initdata;
+
+/* Check dmem param defined by user to match dmem align */
+static int __init check_dmem_param(bool resv_kernel, phys_addr_t base,
+				   phys_addr_t size, phys_addr_t align)
+{
+	phys_addr_t min_align = 1UL << SECTION_SIZE_BITS;
+
+	if (!align)
+		align = min_align;
+
+	/*
+	 * the reserved region should be aligned to memory section
+	 * at least
+	 */
+	if (align < min_align) {
+		pr_warn("dmem: 'align' should be %#llx at least to be aligned to memory section.\n",
+			min_align);
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(align)) {
+		pr_warn("dmem: 'align' should be power of 2.\n");
+		return -EINVAL;
+	}
+
+	if (base & (align - 1)) {
+		pr_warn("dmem: 'addr' is unaligned to 'align' in dmem=\n");
+		return -EINVAL;
+	}
+
+	if (size & (align - 1)) {
+		pr_warn("dmem: 'size' is unaligned to 'align' in dmem=\n");
+		return -EINVAL;
+	}
+
+	if (base >= base + size) {
+		pr_warn("dmem: 'addr + size' overflow in dmem=\n");
+		return -EINVAL;
+	}
+
+	if (resv_kernel && base) {
+		pr_warn("dmem: take a certain base address for kernel is illegal\n");
+		return -EINVAL;
+	}
+
+	dmem_param.base = base;
+	dmem_param.size = size;
+	dmem_param.align = align;
+	dmem_param.resv_kernel = resv_kernel;
+
+	pr_info("dmem: parameter: base address %#llx size %#llx align %#llx resv_kernel %d\n",
+		(unsigned long long)base, (unsigned long long)size,
+		(unsigned long long)align, resv_kernel);
+	return 0;
+}
+
+static int __init parse_dmem(char *p)
+{
+	phys_addr_t base, size, align;
+	char *oldp;
+	bool resv_kernel = false;
+
+	if (!p)
+		return -EINVAL;
+
+	base = align = 0;
+
+	if (*p == '!') {
+		resv_kernel = true;
+		p++;
+	}
+
+	oldp = p;
+	size = memparse(p, &p);
+	if (oldp == p)
+		return -EINVAL;
+
+	if (!size) {
+		pr_warn("dmem: 'size' of 0 defined in dmem=, or {invalid} param\n");
+		return -EINVAL;
+	}
+
+	while (*p) {
+		phys_addr_t *pvalue;
+
+		switch (*p) {
+		case '@':
+			pvalue = &base;
+			break;
+		case ':':
+			pvalue = &align;
+			break;
+		default:
+			pr_warn("dmem: unknown indicator: %c in dmem=\n", *p);
+			return -EINVAL;
+		}
+
+		/*
+		 * Some attribute had been specified multiple times.
+		 * This is not allowed.
+		 */
+		if (*pvalue)
+			return -EINVAL;
+
+		oldp = ++p;
+		*pvalue = memparse(p, &p);
+		if (oldp == p)
+			return -EINVAL;
+
+		if (*pvalue == 0) {
+			pr_warn("dmem: 'addr' or 'align' should not be set to 0\n");
+			return -EINVAL;
+		}
+	}
+
+	return check_dmem_param(resv_kernel, base, size, align);
+}
+
+early_param("dmem", parse_dmem);
+
+/*
+ * We wanna remove a memory range from memblock.memory thoroughly.
+ * As isolating memblock.memory in memblock_remove needs to double
+ * the array of memblock_region, allocated memory for new array maybe
+ * locate in the memory range which we wanna to remove.
+ *	So, conflict.
+ * To resolve this conflict, here reserve this memory range firstly.
+ * While reserving this memory range, isolating memory.reserved will allocate
+ * memory excluded from memory range which to be removed. So following
+ * double array in memblock_remove can't observe this reserved range.
+ */
+static void __init dmem_remove_memblock(phys_addr_t base, phys_addr_t size)
+{
+	memblock_reserve(base, size);
+	memblock_remove(base, size);
+	memblock_free(base, size);
+}
+
+static u64 node_req_mem[MAX_NUMNODES] __initdata;
+
+/* Reserve certain size of memory for dmem in each numa node */
+static void __init dmem_reserve_size(phys_addr_t size, phys_addr_t align,
+		bool resv_kernel)
+{
+	phys_addr_t start, end;
+	u64 i;
+	int nid;
+
+	/* Calculate available free memory on each node */
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start,
+				&end, &nid)
+		node_req_mem[nid] += end - start;
+
+	/* Calculate memory size needed to reserve on each node for dmem */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		node_req_mem[i] = ALIGN(node_req_mem[i], align);
+
+		if (!resv_kernel) {
+			node_req_mem[i] = min(size, node_req_mem[i]);
+			continue;
+		}
+
+		/* leave dmem_param.size memory for kernel */
+		if (node_req_mem[i] > size)
+			node_req_mem[i] = node_req_mem[i] - size;
+		else
+			node_req_mem[i] = 0;
+	}
+
+retry:
+	for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&start, &end, &nid) {
+		/* Well, we have got enough memory for this node. */
+		if (!node_req_mem[nid])
+			continue;
+
+		start = round_up(start, align);
+		end = round_down(end, align);
+		/* Skip memblock_region which is too small */
+		if (start >= end)
+			continue;
+
+		/* Towards memory block at higher address */
+		start = end - min((end - start), node_req_mem[nid]);
+
+		/*
+		 * do not have enough resource to save the region, skip it
+		 * from now on
+		 */
+		if (dmem_region_register(nid, start, end) < 0)
+			break;
+
+		dmem_remove_memblock(start, end - start);
+
+		node_req_mem[nid] -= end - start;
+
+		/* We have dropped a memblock, so re-walk it. */
+		goto retry;
+	}
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (!node_req_mem[i])
+			continue;
+
+		pr_info("dmem: %#llx size of memory is not reserved on node %lld due to misaligned regions.\n",
+			(unsigned long long)size, i);
+	}
+
+}
+
+/* Reserve [base, base + size) for dmem. */
+static void __init
+dmem_reserve_region(phys_addr_t base, phys_addr_t size, phys_addr_t align)
+{
+	phys_addr_t start, end;
+	phys_addr_t p_start, p_end;
+	u64 i;
+	int nid;
+
+	p_start = base;
+	p_end = base + size;
+
+retry:
+	for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&start, &end, &nid) {
+		/* Find region located in user defined range. */
+		if (start >= p_end || end <= p_start)
+			continue;
+
+		start = round_up(max(start, p_start), align);
+		end = round_down(min(end, p_end), align);
+		if (start >= end)
+			continue;
+
+		if (dmem_region_register(nid, start, end) < 0)
+			break;
+
+		dmem_remove_memblock(start, end - start);
+
+		size -= end - start;
+		if (!size)
+			return;
+
+		/* We have dropped a memblock, so re-walk it. */
+		goto retry;
+	}
+
+	pr_info("dmem: %#llx size of memory is not reserved for dmem due to holes and misaligned regions in [%#llx, %#llx].\n",
+		(unsigned long long)size, (unsigned long long)base,
+		(unsigned long long)(base + size));
+}
+
+/* Reserve memory for dmem */
+int __init dmem_reserve_init(void)
+{
+	phys_addr_t base, size, align;
+	bool resv_kernel;
+
+	dmem_init();
+
+	base = dmem_param.base;
+	size = dmem_param.size;
+	align = dmem_param.align;
+	resv_kernel = dmem_param.resv_kernel;
+
+	/* Dmem param had not been enabled. */
+	if (size == 0)
+		return 0;
+
+	if (base)
+		dmem_reserve_region(base, size, align);
+	else
+		dmem_reserve_size(size, align, resv_kernel);
+
+	return 0;
+}
-- 
2.28.0

