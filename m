Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885474F8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGKUVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKUU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:20:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408910C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GLnKPguWFW7/+2NrpNM1tuYQ/qesy2XQRrzmH9bU/NA=; b=wQ2iTu3CFpFz2xaUFdin9qQcLg
        Zo6SBBpIiOLLIMV6swSA+k3EKgZiUTrGU0JtQ0GqAtC1zBFq/djG4qxyKgxXL2rELIMTjX7PST0+t
        wEF09/oTC9SpZ1eYMICRhU549nBmS1JJGjx1yl6+G1tVkWh32Nnm4jfwsuZ1yc1aLIxLimEAr0Trj
        agjHHSe1c13m7UzUObkj9h9Ps3CS52CsrM3yseZX/Eq7zh8qaB/t5l99NlgY7UH+vEG1mGH8Nt+LF
        Xh2jqTBfKjMtc1j99Is0Levj2AGXa208pRFmDKx3Lc0dmOmQC3OHcoSsJ7qGFeTWMSqRSo0MyyldI
        H8WIznMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqr-00G1QB-Ju; Tue, 11 Jul 2023 20:20:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 3/9] mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
Date:   Tue, 11 Jul 2023 21:20:41 +0100
Message-Id: <20230711202047.3818697-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230711202047.3818697-1-willy@infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 mm/hugetlb.c |  6 ++++++
 mm/memory.c  | 18 +++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4a28ce0667f..109e1ff92bc8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6063,6 +6063,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
index f2dcc695f54e..6eda5c5f2069 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4998,10 +4998,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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
@@ -5020,6 +5020,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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
@@ -5247,11 +5252,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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

