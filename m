Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687D75FF61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGXSyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGXSyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757DE55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q+DaNTNbIUG3q6eDPG2po4w54RCX1zIfiIR5STu1uiQ=; b=IfZBEC2bafAFTQbS89y7UijEBE
        RWmQ1Ds4r4Jychulds5YnYRb3I0od+yIzxGEjRBg/sMoaW8Sgo39q598ZbCrb8yFJjLhEXLbKGw2u
        m6ON7coI8Vkyui8eqwVD3MAAI4b1SEwfQnyn3FGv9SQx1ziGML5H3GK5zcH+sBTO4lmFkaq0PKQyx
        xzo+xp/C7beutQOsWwV77qUovD+qADlO+56E/Dwyj29cWGg4lg7hX6Mo01FXPuux0JJUirC3kWWWp
        PlgvLemMPnSu3miVyRvcWhE2qw/Nw7f8SnbiBBb69OcutacNlt/2UeeoQC1+cppK2G6+2AMHfS7AU
        qU4S7HIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iRJ-S7; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v3 10/10] mm: Handle faults that merely update the accessed bit under the VMA lock
Date:   Mon, 24 Jul 2023 19:54:10 +0100
Message-Id: <20230724185410.1124082-11-willy@infradead.org>
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

Move FAULT_FLAG_VMA_LOCK check out of handle_pte_fault().  This should
have a significant performance improvement for mmaped files.  Write faults
(on read-only shared pages) still take the mmap lock as we do not want
to audit all the implementations of ->pfn_mkwrite() and ->page_mkwrite().
However write-faults on private mappings are handled under the VMA lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ad77ac7f8c9b..20a2e9ed4aeb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3393,6 +3393,11 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 		vm_fault_t ret;
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+			vma_end_read(vmf->vma);
+			return VM_FAULT_RETRY;
+		}
+
 		vmf->flags |= FAULT_FLAG_MKWRITE;
 		ret = vma->vm_ops->pfn_mkwrite(vmf);
 		if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
@@ -3415,6 +3420,12 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 		vm_fault_t tmp;
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+			folio_put(folio);
+			vma_end_read(vmf->vma);
+			return VM_FAULT_RETRY;
+		}
+
 		tmp = do_page_mkwrite(vmf, folio);
 		if (unlikely(!tmp || (tmp &
 				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
@@ -5113,12 +5124,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
-	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
-		pte_unmap(vmf->pte);
-		vma_end_read(vmf->vma);
-		return VM_FAULT_RETRY;
-	}
-
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
-- 
2.39.2

