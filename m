Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207075FF65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGXSyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGXSyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27318188
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TWTBYufoYSHkxfGZKIaPme2dTr/Pf10i6Hfp7/PcTWM=; b=EInUKGfNGCuTTNsKCFRp6uzlB9
        1fJcmDCG3/jqX0aR3pLqeB7Hfy3fyyoldC/a2lX8d4E4Z+0RA6Dqfj4qjuAvlFXSEhACCF4KIS8YA
        CfoD9MK242rPZ7Zi1CapBwX3l2XrXyD8sHIWtl7fQT15/dJnIuqKFa9jwI3D0IFIxQXiGB/eIyGQW
        MgbFEpHyXrSqrRmNd7OZcOekNHH53oejJDKO5zaI1nU3ilkddAlysN4Cviibn2M2A7528Ffzmggtq
        yof80Uewlt6OaQZ2zNYLFnAa9mWwu7VMTOfLdGS0Qrn4Gfz4V8UeeqDrY3cehYVPDsJXVVYK+Ty+y
        iaQQTgqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iR5-7U; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 03/10] mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
Date:   Mon, 24 Jul 2023 19:54:03 +0100
Message-Id: <20230724185410.1124082-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724185410.1124082-1-willy@infradead.org>
References: <20230724185410.1124082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle a little more of the page fault path outside the mmap sem.
The hugetlb path doesn't need to check whether the VMA is anonymous;
the VM_HUGETLB flag is only set on hugetlbfs VMAs.  There should be no
performance change from the previous commit; this is simply a step to
ease bisection of any problems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/hugetlb.c |  6 ++++++
 mm/memory.c  | 18 +++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 154cc5b31572..e327a5a7602c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6089,6 +6089,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
+	/* TODO: Handle faults under the VMA lock */
+	if (flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
diff --git a/mm/memory.c b/mm/memory.c
index c7ad754dd8ed..5ca8902b6f67 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5112,10 +5112,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 }
 
 /*
- * By the time we get here, we already hold the mm semaphore
- *
- * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __folio_lock_or_retry().
+ * On entry, we hold either the VMA lock or the mmap_lock
+ * (FAULT_FLAG_VMA_LOCK tells you which).  If VM_FAULT_RETRY is set in
+ * the result, the mmap_lock is not held on exit.  See filemap_fault()
+ * and __folio_lock_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
@@ -5134,6 +5134,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
@@ -5361,11 +5366,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 	}
 
-	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
-
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
-- 
2.39.2

