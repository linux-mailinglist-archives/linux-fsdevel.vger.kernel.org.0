Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2CB6D6477
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjDDOAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjDDOAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DE5267
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fp3DXW4B3dj0QEKkbnSR4pkaFzIpRXPOad7xMgXDJaQ=; b=TxwFEXAtSCPKXbeHQbszWeprHo
        VxqiwXK91lJo0UbDX3RXW4XNyqSskCcZ+9c6WpaI49UbctxbS8wZqEs3nPaFmlxhiHDuV8vPlJax2
        YyzP6h7vKnv5ar2DQ7nkf41EsuJBzI5y3wKFEZhWVvhRMEWky3yvIorFwMObUfedc0Ox57hBgNG4L
        hJdS5UNhY9mxtMwjqVdTEK1iqVrDNyxYcuLW4sE/QpfuP1jUoT8MUTWkYQUjLGPjz2slZ/+T3Dmu8
        uN5UE/fYsoduKgaE2VcvgZ2054Ku5h1J2ox/V4pURx85nuWl/nVa5VEMNVMnWzhBlMND2LjjWjjuw
        v1Yks0fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcl-Co; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 4/6] mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
Date:   Tue,  4 Apr 2023 14:58:48 +0100
Message-Id: <20230404135850.3673404-5-willy@infradead.org>
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

Call do_pte_missing(), do_wp_page() and do_numa_page() under the
VMA lock.  The first two gain the check, but do_numa_page() looks
safe to run outside the mmap lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a2e27403e4f1..dc2baddc6040 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3329,6 +3329,9 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
+		return VM_FAULT_RETRY;
+
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3644,6 +3647,8 @@ static vm_fault_t do_pte_missing(struct vm_fault *vmf)
 {
 	if (vma_is_anonymous(vmf->vma))
 		return do_anonymous_page(vmf);
+	else if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
 	else
 		return do_fault(vmf);
 }
@@ -4896,9 +4901,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
-	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma))
-		return VM_FAULT_RETRY;
-
 	if (unlikely(pmd_none(*vmf->pmd))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
@@ -4957,6 +4959,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma))
+		return VM_FAULT_RETRY;
+
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
-- 
2.39.2

