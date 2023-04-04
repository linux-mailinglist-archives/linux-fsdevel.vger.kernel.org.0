Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E06D6479
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjDDOAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjDDOAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EC188
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jRN9LMIQY9dyThVaq2oo0Jj1gstfJQImVo8wGgQY6/Q=; b=Yw+GAfLtiLfrvZGq+OER5Mn4PY
        +J0pXFeOBou2VBOR4k2CLiBm1tUeMHkv9r0ZhgGnFjFTfK+4BvkUG4x73vi5rXykhGS9VcgC+/FkX
        mfSd42Q8SVIYoUvx7B34jKjN9JSy7gzP2dNtFDh4TmIUOsJ2bwppQsAvzQvl9rcxQobgu2f+XEzRV
        X1tipMKhYfhar5o0Mfx0vwkXW0BAGIPHZlC3GVBT1QD5K9g4yiGE9emh9rG0GslClpPdkW6FLbRS8
        9wnhkIFz0AOs2gDOASmoWlKVlASpOYQlrQRlKXEvSbe0BoyJ9zmdd6Si5hRfh9pnromJ/fdl3haiu
        te7v2ZAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPch-6s; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 2/6] mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
Date:   Tue,  4 Apr 2023 14:58:46 +0100
Message-Id: <20230404135850.3673404-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230404135850.3673404-1-willy@infradead.org>
References: <20230404135850.3673404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 mm/hugetlb.c |  4 ++++
 mm/memory.c  | 14 +++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index efc443a906fa..39f168e3518f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6052,6 +6052,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
+	/* TODO: Handle faults under the VMA lock */
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
+
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
diff --git a/mm/memory.c b/mm/memory.c
index f726f85f0081..fc1f0ef9a7a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4992,10 +4992,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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
@@ -5014,6 +5014,9 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
+		return VM_FAULT_RETRY;
+
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
@@ -5223,9 +5226,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 					    flags & FAULT_FLAG_REMOTE))
 		return VM_FAULT_SIGSEGV;
 
-	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
-		return VM_FAULT_RETRY;
-
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
-- 
2.39.2

