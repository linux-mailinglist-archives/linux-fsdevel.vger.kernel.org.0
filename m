Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140E4A733E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbiBBOez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiBBOey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EBC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z5so18412548plg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uplRDMf9P3k9aUR6OrL9VGZsCccO7/3RG36fBhJFyME=;
        b=kSLOTeQhvBFw7fsL96na0cRlWcVjElWVvAoseaINB/pZHqA7KWxP3av/18pkL1aF+0
         MKOQJZSHRAd5a5PwAiR1h2yWe05lQOOjIoyguZQ6FRdfPhWOhYS2Q2cmjxo/HRQGt/Jy
         BLny0ZANjrtCry2BJhLKzk1uwsIbJqH7I0w5IgRmX7/Xh8uBWszfMynYBEc3fqos21Qu
         CxFcpkYtSGBHbUPVu/D5nyQUIrxpb/JUykO56+48bAqzUjS16agFbbk3P3Z3QbATWhrM
         WyboLCUgxUOu26c9aIeOzVgtlweBJ8PzLJ1+xwkL63Hi5ucGoWjq0bEicpnPVjxdUrpG
         lkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uplRDMf9P3k9aUR6OrL9VGZsCccO7/3RG36fBhJFyME=;
        b=vc+v2KYvU83OQ7LaQzXO/aXYK2/JuVshfaPDrQ4mJneYRcFXtAl0jHPHtDsIMx8OEW
         qUkyv4xLEZEvyLqXUVHenkJhxL2NXGhBEysrU4QJket686c+iOJspVi+JytAeeUGxwDJ
         mppoNpIsK8V2NcXn0X+XcVhrrLlbpMeptO6FM9T2VPrlkFGL35gzyIfcRncob+FRoC28
         uHDAiF+GfY0pezGoOIgRGBZtBJcyCG0W/apWOtriUea8rSp9pKulnODvCTZhCq2aGXfz
         8Zhb0v7WZ/wXkDga5R0X5r3qd4weBYkch3gC+Ni8ZgEdB2IY86ECT8uob4cRSUB/Uall
         MNCQ==
X-Gm-Message-State: AOAM5306p4nTF5ogzUhDE1P/++b5lR18Crn3w/GMDifxrgB09MEKAwpV
        xi7c5Rqk3d2k4jQ0Yj/YSr5ggw==
X-Google-Smtp-Source: ABdhPJxYVhkrB3EfA0Rf/jBLdL6J+MWAJGy/3N8zt0fObDKgb6hfYJaRk8Ro75dji+V85rbzZGD4sA==
X-Received: by 2002:a17:902:e851:: with SMTP id t17mr30063915plg.102.1643812493488;
        Wed, 02 Feb 2022 06:34:53 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/6] dax: fix missing writeprotect the pte entry
Date:   Wed,  2 Feb 2022 22:33:06 +0800
Message-Id: <20220202143307.96282-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220202143307.96282-1-songmuchun@bytedance.com>
References: <20220202143307.96282-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently dax_mapping_entry_mkclean() fails to clean and write protect
the pte entry within a DAX PMD entry during an *sync operation. This
can result in data loss in the following sequence:

  1) process A mmap write to DAX PMD, dirtying PMD radix tree entry and
     making the pmd entry dirty and writeable.
  2) process B mmap with the @offset (e.g. 4K) and @length (e.g. 4K)
     write to the same file, dirtying PMD radix tree entry (already
     done in 1)) and making the pte entry dirty and writeable.
  3) fsync, flushing out PMD data and cleaning the radix tree entry. We
     currently fail to mark the pte entry as clean and write protected
     since the vma of process B is not covered in dax_entry_mkclean().
  4) process B writes to the pte. These don't cause any page faults since
     the pte entry is dirty and writeable. The radix tree entry remains
     clean.
  5) fsync, which fails to flush the dirty PMD data because the radix tree
     entry was clean.
  6) crash - dirty data that should have been fsync'd as part of 5) could
     still have been in the processor cache, and is lost.

Just to use pfn_mkclean_range() to clean the pfns to fix this issue.

Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 83 ++++++----------------------------------------------------------
 1 file changed, 7 insertions(+), 76 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index e031e4b6c13c..b64ac02d55d7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rmap.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -801,87 +802,17 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
-static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
-		unsigned long pfn)
+static void dax_entry_mkclean(struct address_space *mapping, unsigned long pfn,
+			      unsigned long npfn, pgoff_t start)
 {
 	struct vm_area_struct *vma;
-	pte_t pte, *ptep = NULL;
-	pmd_t *pmdp = NULL;
-	spinlock_t *ptl;
+	pgoff_t end = start + npfn - 1;
 
 	i_mmap_lock_read(mapping);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
-		struct mmu_notifier_range range;
-		unsigned long address;
-
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
+		pfn_mkclean_range(pfn, npfn, start, vma);
 		cond_resched();
-
-		if (!(vma->vm_flags & VM_SHARED))
-			continue;
-
-		address = pgoff_address(index, vma);
-
-		/*
-		 * follow_invalidate_pte() will use the range to call
-		 * mmu_notifier_invalidate_range_start() on our behalf before
-		 * taking any lock.
-		 */
-		if (follow_invalidate_pte(vma->vm_mm, address, &range, &ptep,
-					  &pmdp, &ptl))
-			continue;
-
-		/*
-		 * No need to call mmu_notifier_invalidate_range() as we are
-		 * downgrading page table protection not changing it to point
-		 * to a new page.
-		 *
-		 * See Documentation/vm/mmu_notifier.rst
-		 */
-		if (pmdp) {
-#ifdef CONFIG_FS_DAX_PMD
-			pmd_t pmd;
-
-			if (pfn != pmd_pfn(*pmdp))
-				goto unlock_pmd;
-			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
-				goto unlock_pmd;
-
-			flush_cache_range(vma, address,
-					  address + HPAGE_PMD_SIZE);
-			pmd = pmdp_invalidate(vma, address, pmdp);
-			pmd = pmd_wrprotect(pmd);
-			pmd = pmd_mkclean(pmd);
-			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
-unlock_pmd:
-#endif
-			spin_unlock(ptl);
-		} else {
-			if (pfn != pte_pfn(*ptep))
-				goto unlock_pte;
-			if (!pte_dirty(*ptep) && !pte_write(*ptep))
-				goto unlock_pte;
-
-			flush_cache_page(vma, address, pfn);
-			pte = ptep_clear_flush(vma, address, ptep);
-			pte = pte_wrprotect(pte);
-			pte = pte_mkclean(pte);
-			set_pte_at(vma->vm_mm, address, ptep, pte);
-unlock_pte:
-			pte_unmap_unlock(ptep, ptl);
-		}
-
-		mmu_notifier_invalidate_range_end(&range);
 	}
 	i_mmap_unlock_read(mapping);
 }
@@ -949,7 +880,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
-	dax_entry_mkclean(mapping, index, pfn);
+	dax_entry_mkclean(mapping, pfn, count, index);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
-- 
2.11.0

