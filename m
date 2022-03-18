Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CC4DD580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiCRHtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiCRHtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:49:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA436175393
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:48:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so5261871pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FG/K6837zQPVwcpe+tAz7OlRAj17PMacY8wX1oMHrEs=;
        b=KPK4LrnCmNp7Z6s5wQGhYN0YTe9YmNp4wMsWtNeciJ6Nr5c6ooIjt1Wod+Zs6C6l6k
         rUcoy/8jY41NqMFbnQ46C6HAJCWqPWBwoxGl2aaAI4m0MHAF1Dffrolb7X9K1sy7vQdE
         Iz/qDAw+yir/EV+4I1S8emceiVNlQH3W1LjhDNdnHluUbY0KeGwccCatFvpqM5klMw5t
         ZWwiE/ZVn49o6MGwrkX/P/f/ysD8jHyWliSofcl71V+rEy9rCR6dH4MyEcR7cY+NAJD6
         74s4ettE0gg17Ki/VftrCzXY1HQBtI+ic6p6Np9vQ8oU0bIqUFrl2YD7/OiVOwkgtHPn
         NJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FG/K6837zQPVwcpe+tAz7OlRAj17PMacY8wX1oMHrEs=;
        b=diNuhQmX9gmaNTRol8cLqynsv/UPgsQil1FiHeIFOCAVy60D96m+d6PAVB1FyxElod
         qZeyrWTUZvVrmEmszFQ1tsF8VbJiaKXu9A6QOle7sLn2ksjyFyr22JnllutRbgXGXaFn
         dlnC6/CERXtH+MYN/tPL1U5MIn56dFQY6PygEZk3tLocsIfIGiVuCVltWMNHA2/WtQ95
         Lf29BDEjM8DOtSnrZyJlurKXqjD8M3jc3tRza4dQWOWoASJsSIy0PiHswscRz0x1uwt7
         j3qMccQL2uCiyyfDklndYOiDtvm6O5phlndT8tSUxXQ47JxKVjctsaSkVq7MQxljmiTe
         Yr2w==
X-Gm-Message-State: AOAM530vd7HC4JQ+CFgQn19QrVmP7DzNcTqn8J/7+Sk+JYkUfAvf223V
        beOsoC4gm5FdA6aJZC9yYc8iew==
X-Google-Smtp-Source: ABdhPJzqGruIlbwCoxPni7WvLhOqAvLIoTrelUOfikdFmyPFQKUK/Ax2ojztKR7LFVa9l6ohLSmn1A==
X-Received: by 2002:a17:90b:17d1:b0:1bf:1e3:ded3 with SMTP id me17-20020a17090b17d100b001bf01e3ded3mr20609033pjb.144.1647589681912;
        Fri, 18 Mar 2022 00:48:01 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm8770941pfx.81.2022.03.18.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:48:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 5/6] dax: fix missing writeprotect the pte entry
Date:   Fri, 18 Mar 2022 15:45:28 +0800
Message-Id: <20220318074529.5261-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318074529.5261-1-songmuchun@bytedance.com>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index a372304c9695..7fd4a16769f9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rmap.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -789,87 +790,17 @@ static void *dax_insert_entry(struct xa_state *xas,
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
@@ -937,7 +868,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
-	dax_entry_mkclean(mapping, index, pfn);
+	dax_entry_mkclean(mapping, pfn, count, index);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
-- 
2.11.0

