Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9F75FF64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGXSyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGXSy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181510E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hJu05/6R+2/+R58/bqnW2667sqrjvy4Vo+FjhIXzCu0=; b=EL5lMUFnNoPCZMe0eS0Hvijf+2
        j32meE393cAjsq10i8jRMBUAvHcjjnw4BZyBiVirhYCjv44Xl4PLoH/sWyaqKSIwj0MCPc3w4382H
        sMSy+UNGoiKw8jyI5NZzdHT00TMqbw5mU8dWWw9oQPdxKe0U3T6zDJ0FWgJfc8FxlIPQcYk7vEW/o
        ZuTt6UHN7KrKdU+56Av7l32r4Eo7vG1SZaOKkWH+D5hZLNwYGjYrfh6DSX0Lc98neqYSZBttPU1cN
        Ul9efZMKPBrSxs/5R+8v5NbJUr06vyCHOrd6yf9uuxA58P9XcM8NezBphhwdnh8O+svpoAzp2Swxq
        rE7Bc2kA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iR9-Cu; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v3 05/10] mm: Handle some PMD faults under the VMA lock
Date:   Mon, 24 Jul 2023 19:54:05 +0100
Message-Id: <20230724185410.1124082-6-willy@infradead.org>
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

Push the VMA_LOCK check down from __handle_mm_fault() to
handle_pte_fault().  Once again, we refuse to call ->huge_fault() with
the VMA lock held, but we will wait for a PMD migration entry with the
VMA lock held, handle NUMA migration and set the accessed bit.  We were
already doing this for anonymous VMAs, so it should be safe.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7fec616f490b..9e4dd65e06ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4949,36 +4949,47 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
-	if (vma_is_anonymous(vmf->vma))
+	struct vm_area_struct *vma = vmf->vma;
+	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vma->vm_ops->huge_fault) {
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+			vma_end_read(vma);
+			return VM_FAULT_RETRY;
+		}
+		return vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	}
 	return VM_FAULT_FALLBACK;
 }
 
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
-	if (vma_is_anonymous(vmf->vma)) {
+	if (vma_is_anonymous(vma)) {
 		if (likely(!unshare) &&
-		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
+		    userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf);
 	}
 
-	if (vmf->vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
-		if (vmf->vma->vm_ops->huge_fault) {
-			ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		if (vma->vm_ops->huge_fault) {
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				vma_end_read(vma);
+				return VM_FAULT_RETRY;
+			}
+			ret = vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 			if (!(ret & VM_FAULT_FALLBACK))
 				return ret;
 		}
 	}
 
 	/* COW or write-notify handled on pte level: split pmd. */
-	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
+	__split_huge_pmd(vma, vmf->pmd, vmf->address, false, NULL);
 
 	return VM_FAULT_FALLBACK;
 }
@@ -5049,6 +5060,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	if (unlikely(pmd_none(*vmf->pmd))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
@@ -5188,11 +5204,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
-
 	if (pmd_none(*vmf.pmd) &&
 	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
 		ret = create_huge_pmd(&vmf);
-- 
2.39.2

