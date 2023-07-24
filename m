Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495075FF6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGXSyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGXSyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07410E2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/dr8E7Ysfsh/pzxHk8PrgytRhAkkfjQGUpicX+vSfvw=; b=h2urfpoJlH+/tTgmv+1TWIjF7V
        SHPiUiKpC2n086K/Blscs2mtWtATwrhaglAB7qSgdBQvKMNtIPQV/UFDUBNnXBCJKZqS02PMxZDhN
        QIpfedqmho8nh2D698VotNmU0q5qTKALJGUD/wc0E58tg4ZCE4Gn2rhzDLRFYpHGnf4jBnK69OxHr
        fBw6gic1/us6lWW6l7ExzoNHq56D4JqqkX3VwhzEJSKvB1yN9l0CoM6WoGz83conZI3w9cwm2x84i
        Zc3bYa8EqN9n54f/4wlFuqSHLh/NnBnmRxHDAymVbpKp5GzpcpfCkw2wIAESzGP7wGjHvSVs7xgCq
        /JBsnc2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iR7-AG; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v3 04/10] mm: Handle PUD faults under the VMA lock
Date:   Mon, 24 Jul 2023 19:54:04 +0100
Message-Id: <20230724185410.1124082-5-willy@infradead.org>
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

Postpone checking the VMA_LOCK flag until we've attempted to handle
faults on PUDs.  There's a mild upside to this patch in that we'll
allocate the page tables while under the VMA lock rather than the mmap
lock, reducing the hold time on the mmap lock, since the retry will find
the page tables already populated.  The real purpose here is to make a
commit that shows we don't call ->huge_fault under the VMA lock.  We do
now handle setting the accessed bit on a PUD fault under the VMA lock,
but that doesn't seem likely to be a measurable difference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5ca8902b6f67..7fec616f490b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4987,11 +4987,17 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	struct vm_area_struct *vma = vmf->vma;
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+	if (vma->vm_ops->huge_fault) {
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+			vma_end_read(vma);
+			return VM_FAULT_RETRY;
+		}
+		return vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+	}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
@@ -5000,21 +5006,26 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vma))
 		goto split;
-	if (vmf->vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
-		if (vmf->vma->vm_ops->huge_fault) {
-			ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		if (vma->vm_ops->huge_fault) {
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				vma_end_read(vma);
+				return VM_FAULT_RETRY;
+			}
+			ret = vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 			if (!(ret & VM_FAULT_FALLBACK))
 				return ret;
 		}
 	}
 split:
 	/* COW or write-notify not handled on PUD level: split pud.*/
-	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
+	__split_huge_pud(vma, vmf->pud, vmf->address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 	return VM_FAULT_FALLBACK;
 }
@@ -5134,11 +5145,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
-	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
-
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
@@ -5182,6 +5188,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	if (pmd_none(*vmf.pmd) &&
 	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
 		ret = create_huge_pmd(&vmf);
-- 
2.39.2

