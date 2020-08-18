Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CE2486FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHROQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 10:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHROQZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:16:25 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DAD20829;
        Tue, 18 Aug 2020 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760184;
        bh=zc15LsD1sPr9/ZbyAvhQVudYgFhm3woFSb45SRpcY0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXh/wS6baOtHWub6WK55rP1sORfDRlaH9KA4ZH9loQ2K9uIAXB/Z1HTqFrO5Zz16m
         L49Xr26Z6YSYWhAI/uEfDIGP8mDo7j6g7mgKdrWwdX0NU/JRR4VfY+zgPLx+m9wB9l
         vpaideBHzS79DywiOJt8+eoDYyvEMkgiuO/dGfBE=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH v4 1/6] mm: add definition of PMD_PAGE_ORDER
Date:   Tue, 18 Aug 2020 17:15:49 +0300
Message-Id: <20200818141554.13945-2-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818141554.13945-1-rppt@kernel.org>
References: <20200818141554.13945-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The definition of PMD_PAGE_ORDER denoting the number of base pages in the
second-level leaf page is already used by DAX and maybe handy in other
cases as well.

Several architectures already have definition of PMD_ORDER as the size of
second level page table, so to avoid conflict with these definitions use
PMD_PAGE_ORDER name and update DAX respectively.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 fs/dax.c                | 11 ++++-------
 include/linux/pgtable.h |  3 +++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 95341af1a966..09a7fdb879b6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -49,9 +49,6 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
 #define PG_PMD_COLOUR	((PMD_SIZE >> PAGE_SHIFT) - 1)
 #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
 
-/* The order of a PMD entry */
-#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
-
 static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
 
 static int __init init_dax_wait_table(void)
@@ -98,7 +95,7 @@ static bool dax_is_locked(void *entry)
 static unsigned int dax_entry_order(void *entry)
 {
 	if (xa_to_value(entry) & DAX_PMD)
-		return PMD_ORDER;
+		return PMD_PAGE_ORDER;
 	return 0;
 }
 
@@ -1455,7 +1452,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
+	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_PAGE_ORDER);
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync;
@@ -1514,7 +1511,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * entry is already in the array, for instance), it will return
 	 * VM_FAULT_FALLBACK.
 	 */
-	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
+	entry = grab_mapping_entry(&xas, mapping, PMD_PAGE_ORDER);
 	if (xa_is_internal(entry)) {
 		result = xa_to_internal(entry);
 		goto fallback;
@@ -1680,7 +1677,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	if (order == 0)
 		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
 #ifdef CONFIG_FS_DAX_PMD
-	else if (order == PMD_ORDER)
+	else if (order == PMD_PAGE_ORDER)
 		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a124c21e3204..fb9c386e4f54 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -28,6 +28,9 @@
 #define USER_PGTABLES_CEILING	0UL
 #endif
 
+/* Number of base pages in a second level leaf page */
+#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.26.2

