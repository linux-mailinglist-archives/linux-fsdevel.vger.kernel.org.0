Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6722357C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGQHVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:20243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgGQHVK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:10 -0400
IronPort-SDR: 5Oks0gP7u0kjUYrivccwMrN+vatGLG5XAQTcWw6l/kTWSjX3/A1uMaVa8LXssoeIadcK+CzqpR
 MzpyLb7jTypQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129633012"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129633012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:09 -0700
IronPort-SDR: KjLQUr/O/zFt+sHsQ/7MwuDlQjjZsVVHeQXgHyNbnTTErPyyf40DTH77x+nhCzE8WtAOMPIPf5
 bYF7IWgj7SUg==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="286734931"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:08 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 13/17] kmap: Add stray write protection for device pages
Date:   Fri, 17 Jul 2020 00:20:52 -0700
Message-Id: <20200717072056.73134-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device managed pages may have additional protections.  These protections
need to be removed prior to valid use by kernel users.

Check for special treatment of device managed pages in kmap and take
action if needed.  We use kmap as an interface for generic kernel code
because under normal circumstances it would be a bug for general kernel
code to not use kmap prior to accessing kernel memory.  Therefore, this
should allow any valid kernel users to seamlessly use these pages
without issues.

Because of the critical nature of kmap it must be pointed out that the
over head on regular DRAM is carefully implemented to be as fast as
possible.  Furthermore the underlying MSR write required on device pages
when protected is better than a normal MSR write.

Specifically, WRMSR(MSR_IA32_PKRS) is not serializing but still
maintains ordering properties similar to WRPKRU.  The current SDM
section on PKRS needs updating but should be the same as that of WRPKRU.
So to quote from the WRPKRU text:

	WRPKRU will never execute speculatively. Memory accesses
	affected by PKRU register will not execute (even speculatively)
	until all prior executions of WRPKRU have completed execution
	and updated the PKRU register.

Still this will make accessing pmem more expensive from the kernel but
the overhead is minimized and many pmem users access this memory through
user page mappings which are not affected at all.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d6e82e3de027..7f809d8d5a94 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
+#include <linux/memremap.h>
 
 #include <asm/cacheflush.h>
 
@@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 
 #include <asm/kmap_types.h>
 
+static inline void enable_access(struct page *page)
+{
+	if (!page_is_access_protected(page))
+		return;
+	dev_access_enable();
+}
+
+static inline void disable_access(struct page *page)
+{
+	if (!page_is_access_protected(page))
+		return;
+	dev_access_disable();
+}
+
 #ifdef CONFIG_HIGHMEM
 extern void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
 extern void kunmap_atomic_high(void *kvaddr);
@@ -55,6 +70,11 @@ static inline void *kmap(struct page *page)
 	else
 		addr = kmap_high(page);
 	kmap_flush_tlb((unsigned long)addr);
+	/*
+	 * Even non-highmem pages may have additional access protections which
+	 * need to be checked and potentially enabled.
+	 */
+	enable_access(page);
 	return addr;
 }
 
@@ -63,6 +83,11 @@ void kunmap_high(struct page *page);
 static inline void kunmap(struct page *page)
 {
 	might_sleep();
+	/*
+	 * Even non-highmem pages may have additional access protections which
+	 * need to be checked and potentially disabled.
+	 */
+	disable_access(page);
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
@@ -85,6 +110,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
 	pagefault_disable();
+	enable_access(page);
 	if (!PageHighMem(page))
 		return page_address(page);
 	return kmap_atomic_high_prot(page, prot);
@@ -137,6 +163,7 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
+	enable_access(page);
 	return page_address(page);
 }
 
@@ -146,6 +173,7 @@ static inline void kunmap_high(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
+	disable_access(page);
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(page_address(page));
 #endif
@@ -155,6 +183,7 @@ static inline void *kmap_atomic(struct page *page)
 {
 	preempt_disable();
 	pagefault_disable();
+	enable_access(page);
 	return page_address(page);
 }
 #define kmap_atomic_prot(page, prot)	kmap_atomic(page)
@@ -216,7 +245,8 @@ static inline void kmap_atomic_idx_pop(void)
 #define kunmap_atomic(addr)                                     \
 do {                                                            \
 	BUILD_BUG_ON(__same_type((addr), struct page *));       \
-	kunmap_atomic_high(addr);                                  \
+	disable_access(kmap_to_page(addr));                     \
+	kunmap_atomic_high(addr);                               \
 	pagefault_enable();                                     \
 	preempt_enable();                                       \
 } while (0)
-- 
2.28.0.rc0.12.gb6a658bd00c9

