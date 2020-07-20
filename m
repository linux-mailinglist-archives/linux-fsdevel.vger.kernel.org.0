Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12413225B77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGTJZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgGTJZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:25:19 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3425921775;
        Mon, 20 Jul 2020 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595237118;
        bh=hdVX0IsUo7eSkaqkoaF98FlrWWgQtbf1bZ3UXG9vp9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAapEE0p74NATUUVPXGp3NVqZWe0Odu+heF2bzFKM4D5o65DTfBQlPgNDp8AOF/IR
         cb4dsV5gr8z+qi4NQe4F+mjwYCMNHlz8tjtqiAAt2PfiU9HMWzI91Vn3jmtmU+kVse
         wSTYl6Q7+f/fP/UqEgEVOF0otXZadeHcIHitULkU=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH 1/6] mm: add definition of PMD_PAGE_ORDER
Date:   Mon, 20 Jul 2020 12:24:30 +0300
Message-Id: <20200720092435.17469-2-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720092435.17469-1-rppt@kernel.org>
References: <20200720092435.17469-1-rppt@kernel.org>
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
 fs/dax.c                | 10 +++++-----
 include/linux/pgtable.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..b91d8c8dda45 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
 #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
 
 /* The order of a PMD entry */
-#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 
 static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
 
@@ -98,7 +98,7 @@ static bool dax_is_locked(void *entry)
 static unsigned int dax_entry_order(void *entry)
 {
 	if (xa_to_value(entry) & DAX_PMD)
-		return PMD_ORDER;
+		return PMD_PAGE_ORDER;
 	return 0;
 }
 
@@ -1456,7 +1456,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
+	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_PAGE_ORDER);
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync;
@@ -1515,7 +1515,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * entry is already in the array, for instance), it will return
 	 * VM_FAULT_FALLBACK.
 	 */
-	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
+	entry = grab_mapping_entry(&xas, mapping, PMD_PAGE_ORDER);
 	if (xa_is_internal(entry)) {
 		result = xa_to_internal(entry);
 		goto fallback;
@@ -1681,7 +1681,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	if (order == 0)
 		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
 #ifdef CONFIG_FS_DAX_PMD
-	else if (order == PMD_ORDER)
+	else if (order == PMD_PAGE_ORDER)
 		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 56c1e8eb7bb0..79f8443609e7 100644
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

