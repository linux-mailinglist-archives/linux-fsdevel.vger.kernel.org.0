Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3F32C55B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhCDAUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238886AbhCCQYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:24:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C7D764EEB;
        Wed,  3 Mar 2021 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614788594;
        bh=3L5LfgX8YQZHs8RhJs3aUV3Lp9pUuH2HcdGSCfQz7w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGfvsZGZQAM599zQUIVcrTqth2yu+GJIaidUQ1VxQKtyB4kVeRNubHlrvDGzmHjrb
         P8e1H/vG0/zaY55hqTarALIx9hq7kKeE175hk0vnoCLpEej7OzEfhmvY+mOUHDc2o3
         CW4yk4ob8BGnQ2Ij/D4eL5k36utJUK/ySgdRHlEI9JI6MXgiH8/XquGySEjL2b651m
         +5gHVUeyrsTGyJC7csSVRUFbpDqELxLTTVNNoC91CQ6p1sASqfFEM9qXWN9RKGa6Bo
         b1cgGZPzWU9ZoNbd5PxwYd0Caw1zQMCebLmUxFfqKSh3htleCbNw/Y4+zDUNrWJe9a
         SfFXg++8K8MSg==
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v18 4/9] set_memory: allow set_direct_map_*_noflush() for multiple pages
Date:   Wed,  3 Mar 2021 18:22:04 +0200
Message-Id: <20210303162209.8609-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210303162209.8609-1-rppt@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The underlying implementations of set_direct_map_invalid_noflush() and
set_direct_map_default_noflush() allow updating multiple contiguous pages
at once.

Add numpages parameter to set_direct_map_*_noflush() to expose this
ability with these APIs.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>	[arm64]
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
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
 arch/arm64/include/asm/cacheflush.h |  4 ++--
 arch/arm64/mm/pageattr.c            | 10 ++++++----
 arch/riscv/include/asm/set_memory.h |  4 ++--
 arch/riscv/mm/pageattr.c            |  8 ++++----
 arch/x86/include/asm/set_memory.h   |  4 ++--
 arch/x86/mm/pat/set_memory.c        |  8 ++++----
 include/linux/set_memory.h          |  4 ++--
 kernel/power/snapshot.c             |  4 ++--
 mm/vmalloc.c                        |  5 +++--
 9 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 52e5c1623224..ace2c3d7ae7e 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -133,8 +133,8 @@ static __always_inline void __flush_icache_all(void)
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 #include <asm-generic/cacheflush.h>
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 92eccaf595c8..b53ef37bf95a 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -148,34 +148,36 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_VALID));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	struct page_change_data data = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(PTE_VALID),
 	};
+	unsigned long size = PAGE_SIZE * numpages;
 
 	if (!debug_pagealloc_enabled() && !rodata_full)
 		return 0;
 
 	return apply_to_page_range(&init_mm,
 				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   size, change_page_range, &data);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	struct page_change_data data = {
 		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
 		.clear_mask = __pgprot(PTE_RDONLY),
 	};
+	unsigned long size = PAGE_SIZE * numpages;
 
 	if (!debug_pagealloc_enabled() && !rodata_full)
 		return 0;
 
 	return apply_to_page_range(&init_mm,
 				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   size, change_page_range, &data);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 6887b3d9f371..018e26732940 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -26,8 +26,8 @@ static inline void protect_kernel_text_data(void) {}
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 5e49e4b4a4cc..9618181b70be 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -156,11 +156,11 @@ int set_memory_nx(unsigned long addr, int numpages)
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	int ret;
 	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
+	unsigned long end = start + PAGE_SIZE * numpages;
 	struct pageattr_masks masks = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(_PAGE_PRESENT)
@@ -173,11 +173,11 @@ int set_direct_map_invalid_noflush(struct page *page)
 	return ret;
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	int ret;
 	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
+	unsigned long end = start + PAGE_SIZE * numpages;
 	struct pageattr_masks masks = {
 		.set_mask = PAGE_KERNEL,
 		.clear_mask = __pgprot(0)
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4352f08bfbb5..6224cb291f6c 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -80,8 +80,8 @@ int set_pages_wb(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, int numpages);
+int set_direct_map_default_noflush(struct page *page, int numpages);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..d157fd617c99 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2184,14 +2184,14 @@ static int __set_pages_np(struct page *page, int numpages)
 	return __change_page_attr_set_clr(&cpa, 0);
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
-	return __set_pages_np(page, 1);
+	return __set_pages_np(page, numpages);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, int numpages)
 {
-	return __set_pages_p(page, 1);
+	return __set_pages_p(page, numpages);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index fe1aa4e54680..c650f82db813 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -15,11 +15,11 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
-static inline int set_direct_map_invalid_noflush(struct page *page)
+static inline int set_direct_map_invalid_noflush(struct page *page, int numpages)
 {
 	return 0;
 }
-static inline int set_direct_map_default_noflush(struct page *page)
+static inline int set_direct_map_default_noflush(struct page *page, int numpages)
 {
 	return 0;
 }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d63560e1cf87..64b7aab9aee4 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -86,7 +86,7 @@ static inline void hibernate_restore_unprotect_page(void *page_address) {}
 static inline void hibernate_map_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		int ret = set_direct_map_default_noflush(page);
+		int ret = set_direct_map_default_noflush(page, 1);
 
 		if (ret)
 			pr_warn_once("Failed to remap page\n");
@@ -99,7 +99,7 @@ static inline void hibernate_unmap_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
-		int ret  = set_direct_map_invalid_noflush(page);
+		int ret = set_direct_map_invalid_noflush(page, 1);
 
 		if (ret)
 			pr_warn_once("Failed to remap page\n");
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c907897..8ab83fbecadd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2195,13 +2195,14 @@ struct vm_struct *remove_vm_area(const void *addr)
 }
 
 static inline void set_area_direct_map(const struct vm_struct *area,
-				       int (*set_direct_map)(struct page *page))
+				       int (*set_direct_map)(struct page *page,
+							     int numpages))
 {
 	int i;
 
 	for (i = 0; i < area->nr_pages; i++)
 		if (page_address(area->pages[i]))
-			set_direct_map(area->pages[i]);
+			set_direct_map(area->pages[i], 1);
 }
 
 /* Handle removing and resetting vm mappings related to the vm_struct. */
-- 
2.28.0

