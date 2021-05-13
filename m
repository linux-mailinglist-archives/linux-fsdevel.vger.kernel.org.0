Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5437FD7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhEMStr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 14:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhEMStq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 14:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C43361406;
        Thu, 13 May 2021 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620931716;
        bh=twM3kcIsDN/gyZuW+xk/tf+yH1f34ppbMTIsKNFPmC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqW7ZqWzMwkjHcZF3FdhIT9g4YDEUVGZsrzBwVjbHW1jt8YyCgaaaLLhAEUH1JmNu
         ZotW4Jtc4LF46OAg+qgP6d1Ceuc0T41mrTn9jqb+RpWWGbcvmKSATMXfGAm1bmCJrB
         nCt9gbeOB5ZFyZ1g4qrxpQfQgfcNGxJkKJCKpo7CRPvlh9oZ6O753gkzOntH0lha8r
         PAPQdQC79pWJSo40IdjDJdfX6/YUc92id128bzBhojMMaS9F39y0eULQ0wJxpSzT7Y
         ZAzG/tYAWgEV+IkiTV4IeHRVrjHcK1oVieN9zNIoRCU9yhjz1ZIPGbqRl24xK+0j3i
         hUsRaoaZ16txQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v19 4/8] set_memory: allow querying whether set_direct_map_*() is actually enabled
Date:   Thu, 13 May 2021 21:47:30 +0300
Message-Id: <20210513184734.29317-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513184734.29317-1-rppt@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

On arm64, set_direct_map_*() functions may return 0 without actually
changing the linear map.  This behaviour can be controlled using kernel
parameters, so we need a way to determine at runtime whether calls to
set_direct_map_invalid_noflush() and set_direct_map_default_noflush() have
any effect.

Extend set_memory API with can_set_direct_map() function that allows
checking if calling set_direct_map_*() will actually change the page
table, replace several occurrences of open coded checks in arm64 with the
new function and provide a generic stub for architectures that always
modify page tables upon calls to set_direct_map APIs.

[arnd@arndb.de: arm64: kfence: fix header inclusion ]

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/Kbuild       |  1 -
 arch/arm64/include/asm/cacheflush.h |  6 ------
 arch/arm64/include/asm/kfence.h     |  2 +-
 arch/arm64/include/asm/set_memory.h | 17 +++++++++++++++++
 arch/arm64/kernel/machine_kexec.c   |  1 +
 arch/arm64/mm/mmu.c                 |  6 +++---
 arch/arm64/mm/pageattr.c            | 13 +++++++++----
 include/linux/set_memory.h          | 12 ++++++++++++
 8 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/set_memory.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 07ac208edc89..73aa25843f65 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -3,5 +3,4 @@ generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += set_memory.h
 generic-y += user.h
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index ace2c3d7ae7e..4e3c13799735 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -131,12 +131,6 @@ static __always_inline void __flush_icache_all(void)
 	dsb(ish);
 }
 
-int set_memory_valid(unsigned long addr, int numpages, int enable);
-
-int set_direct_map_invalid_noflush(struct page *page, int numpages);
-int set_direct_map_default_noflush(struct page *page, int numpages);
-bool kernel_page_present(struct page *page);
-
 #include <asm-generic/cacheflush.h>
 
 #endif /* __ASM_CACHEFLUSH_H */
diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index d061176d57ea..aa855c6a0ae6 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
new file mode 100644
index 000000000000..ecb6b0f449ab
--- /dev/null
+++ b/arch/arm64/include/asm/set_memory.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_ARM64_SET_MEMORY_H
+#define _ASM_ARM64_SET_MEMORY_H
+
+#include <asm-generic/set_memory.h>
+
+bool can_set_direct_map(void);
+#define can_set_direct_map can_set_direct_map
+
+int set_memory_valid(unsigned long addr, int numpages, int enable);
+
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
+bool kernel_page_present(struct page *page);
+
+#endif /* _ASM_ARM64_SET_MEMORY_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 90a335c74442..0ec94e718724 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
+#include <linux/set_memory.h>
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6dd9369e3ea0..e42aeff6c344 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/set_memory.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -515,7 +516,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
 
-	if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
+	if (can_set_direct_map() || crash_mem_map)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -1483,8 +1484,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	 * KFENCE requires linear map to be mapped at page granularity, so that
 	 * it is possible to protect/unprotect single pages in the KFENCE pool.
 	 */
-	if (rodata_full || debug_pagealloc_enabled() ||
-	    IS_ENABLED(CONFIG_KFENCE))
+	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index b53ef37bf95a..d505172265b0 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -19,6 +19,11 @@ struct page_change_data {
 
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
+bool can_set_direct_map(void)
+{
+	return rodata_full || debug_pagealloc_enabled();
+}
+
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
@@ -156,7 +161,7 @@ int set_direct_map_invalid_noflush(struct page *page, int numpages)
 	};
 	unsigned long size = PAGE_SIZE * numpages;
 
-	if (!debug_pagealloc_enabled() && !rodata_full)
+	if (!can_set_direct_map())
 		return 0;
 
 	return apply_to_page_range(&init_mm,
@@ -172,7 +177,7 @@ int set_direct_map_default_noflush(struct page *page, int numpages)
 	};
 	unsigned long size = PAGE_SIZE * numpages;
 
-	if (!debug_pagealloc_enabled() && !rodata_full)
+	if (!can_set_direct_map())
 		return 0;
 
 	return apply_to_page_range(&init_mm,
@@ -183,7 +188,7 @@ int set_direct_map_default_noflush(struct page *page, int numpages)
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
-	if (!debug_pagealloc_enabled() && !rodata_full)
+	if (!can_set_direct_map())
 		return;
 
 	set_memory_valid((unsigned long)page_address(page), numpages, enable);
@@ -208,7 +213,7 @@ bool kernel_page_present(struct page *page)
 	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
-	if (!debug_pagealloc_enabled() && !rodata_full)
+	if (!can_set_direct_map())
 		return true;
 
 	pgdp = pgd_offset_k(addr);
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index c650f82db813..7b4b6626032d 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -28,7 +28,19 @@ static inline bool kernel_page_present(struct page *page)
 {
 	return true;
 }
+#else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
+/*
+ * Some architectures, e.g. ARM64 can disable direct map modifications at
+ * boot time. Let them overrive this query.
+ */
+#ifndef can_set_direct_map
+static inline bool can_set_direct_map(void)
+{
+	return true;
+}
+#define can_set_direct_map can_set_direct_map
 #endif
+#endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifndef set_mce_nospec
 static inline int set_mce_nospec(unsigned long pfn, bool unmap)
-- 
2.28.0

