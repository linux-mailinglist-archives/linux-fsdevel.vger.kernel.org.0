Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745075FF63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGXSya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGXSy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1254DE55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bf2WSeVVnx5PtuK0GrdZC7nqaCiGfJc1owLWRc2d9S0=; b=pq4q53ipW8imewozPRVRm9SF+m
        RVM+pPZTkW+xlAdqR4U8etpaEe/I/DDBVIxPfL9YcKgLPN700wsZFK/8HQ5tiM5SH9mlMAQeOGFQA
        pCDpj4vAGjQDG2G8pb6Xmrrw2nge32+b/8RHXob2OgRXXA53Z7FI7GZWoNnSVpT3xUtrrRsaP4FR6
        tK7rBBJ1LALKGEDtjsDaIcr8sxHVwqGwW0SYlCDqoxT5OW/qwUT1M9eB4glQiild/Zb7Pqwbx9PUp
        /ECOtnxFdu74Lg9qhUaT959BflWAxgCMzx3rOnmDtJjeTqakbEK6eH6mVpXBfeR3DdLPiqoB/07ik
        DDyIR+Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iRH-PM; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v3 09/10] mm: Handle swap and NUMA PTE faults under the VMA lock
Date:   Mon, 24 Jul 2023 19:54:09 +0100
Message-Id: <20230724185410.1124082-10-willy@infradead.org>
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

Move the FAULT_FLAG_VMA_LOCK check down in handle_pte_fault().  This is
probably not a huge win in its own right, but is a nicely separable bit
from the next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index cf28afe7a416..ad77ac7f8c9b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5107,18 +5107,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!vmf->pte)
 		return do_pte_missing(vmf);
 
-	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
-		pte_unmap(vmf->pte);
-		vma_end_read(vmf->vma);
-		return VM_FAULT_RETRY;
-	}
-
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma)) {
+		pte_unmap(vmf->pte);
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
-- 
2.39.2

