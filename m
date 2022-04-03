Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C044F07E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbiDCFn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 01:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbiDCFnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:43:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5060338BC0
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 22:41:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s11so1290584pla.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Apr 2022 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ij9Ou9wostYj6EGhx1lGIRtlvYKIpDSow4S1vsu6OkU=;
        b=XeDR2vJSmU7Ivd3WN7rCTrbkf25VSpqOphH+Y0b8v30A2+sw5zqGls9Infj7s8yVlP
         svWNwaO1p/aGhXjj7Zupj5x3tuNFjanAQWQWM6u7liBIOurPY1rHvAScK/VCuZ7iFAfg
         pFi84i3m4JempmgKh34P9NIz6wJ875JOw+0Aqg1U6aRUn/Xtf4315rOLnph7LcPVNo/o
         bCkdnwqsmM4WrVRAFJEPnNeFpXgXWQf43xph7Siue3ttUD6DaIe9v5c5W0aQH8CZed+l
         DJeXFlvu8ihwu8DuH0KCvDNYmwo5uFWXXWrAhMpb9CnbUIRuHIanH9teTlUUk6AjPz45
         B+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ij9Ou9wostYj6EGhx1lGIRtlvYKIpDSow4S1vsu6OkU=;
        b=Lw0M2+1eE0xFlWuh7VoVFfBxArac/DLHNTG8Yf1zBHASdP1Nz9SklrOv8l/QTqvj2t
         G+DW5qLrxYv9CJcJmVlCvfzX3QdafJWyz7fXiaItQTI7Gw4E9b2/LVwK4kYpJ6B66IcZ
         5gfEy8PMw0bI1MHKfMH1yh89bd9jICI1PcTkajv7hHOU0kSLQkr1G5xYdmnlOG0CQVhz
         +jALk7O49qgSxxjrZTPL4brxyl16Qg1fZ/KbLEeqO6FdJdCI6azCgq+6OMhiHPakhGbh
         IFXV7HPwds/rXHlK9rXzqYVfAeAy/awd+CRX1FpExR7uAkPMBTOQfQcP1F2XLX43BjW8
         JhZQ==
X-Gm-Message-State: AOAM533ukT7tofqcO77pSvWTVNhSnwaMv0UXnDGdJcF7uqnBpl9EKWh/
        Ki1Pv5vy/WZfwFUX5O9u75sZ6w==
X-Google-Smtp-Source: ABdhPJxCMZdeA2cMPE4dzvOrFTBRiMQzhbgxuHDpUKbgulRM1aIbxvU3i75LzfHUzm2CYnokBq58DQ==
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id q16-20020a170902dad000b00154740a9094mr17337374plx.107.1648964505726;
        Sat, 02 Apr 2022 22:41:45 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm8262479pfx.34.2022.04.02.22.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 22:41:45 -0700 (PDT)
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
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 5/6] dax: fix missing writeprotect the pte entry
Date:   Sun,  3 Apr 2022 13:39:56 +0800
Message-Id: <20220403053957.10770-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220403053957.10770-1-songmuchun@bytedance.com>
References: <20220403053957.10770-1-songmuchun@bytedance.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 99 ++++++++--------------------------------------------------------
 1 file changed, 12 insertions(+), 87 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a372304c9695..1ac12e877f4f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rmap.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -789,96 +790,12 @@ static void *dax_insert_entry(struct xa_state *xas,
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
-/* Walk all mappings of a given index of a file and writeprotect them */
-static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
-		unsigned long pfn)
-{
-	struct vm_area_struct *vma;
-	pte_t pte, *ptep = NULL;
-	pmd_t *pmdp = NULL;
-	spinlock_t *ptl;
-
-	i_mmap_lock_read(mapping);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
-		struct mmu_notifier_range range;
-		unsigned long address;
-
-		cond_resched();
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
-	}
-	i_mmap_unlock_read(mapping);
-}
-
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 		struct address_space *mapping, void *entry)
 {
-	unsigned long pfn, index, count;
+	unsigned long pfn, index, count, end;
 	long ret = 0;
+	struct vm_area_struct *vma;
 
 	/*
 	 * A page got tagged dirty in DAX mapping? Something is seriously
@@ -936,8 +853,16 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	pfn = dax_to_pfn(entry);
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
+	end = index + count - 1;
+
+	/* Walk all mappings of a given index of a file and writeprotect them */
+	i_mmap_lock_read(mapping);
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
+		pfn_mkclean_range(pfn, count, index, vma);
+		cond_resched();
+	}
+	i_mmap_unlock_read(mapping);
 
-	dax_entry_mkclean(mapping, index, pfn);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
-- 
2.11.0

