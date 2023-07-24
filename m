Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87275FF69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGXSyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXSyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0BE55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j/+5nvHmLcQr2gQNLZnma/P8C+KH0GEPUfvfP6aRFCA=; b=BFJKXQAH8Ld9mSwUnjlCJ9Cgoh
        fHUbEJMazDTd4xQQptvmIIdTFyaEH2YONUrjuOkX0UZQQ3TTYhtjroUHubNIxcQHwaE5xTUDqOCJs
        0VU0ypfcwtPQHyWFq4J4BuPx+zIDlFkLgft+yQUGk+0ivxv9RpxA2BtSphe+v5RvSEm05/oiXwvrR
        /Af8Ms5TsZWa/9POSZcp9IVBoKd4YybnnKWboaz7rRkZcWp7CN8Ot7LXch5abDyrcgIJSZMVUI+7z
        zu1lLMHI/+0UzRSBkH2VswJg10brdZ4gtKKnSmFrNxMIEaU9Dx578le2dcBm6S3Rj+jhQQWKd8ygJ
        E9UgB4KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iRB-Fc; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 06/10] mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
Date:   Mon, 24 Jul 2023 19:54:06 +0100
Message-Id: <20230724185410.1124082-7-willy@infradead.org>
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

Call do_pte_missing() under the VMA lock ... then immediately retry
in do_fault().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9e4dd65e06ac..11b337876477 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4775,6 +4775,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK){
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
@@ -5060,11 +5065,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
-	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
-		vma_end_read(vmf->vma);
-		return VM_FAULT_RETRY;
-	}
-
 	if (unlikely(pmd_none(*vmf->pmd))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
@@ -5097,6 +5097,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!vmf->pte)
 		return do_pte_missing(vmf);
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
+		pte_unmap(vmf->pte);
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-- 
2.39.2

