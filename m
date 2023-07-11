Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5D74F8ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGKUVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGKUVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F210D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SWi2hnJa6UVy5RDmiU5nvVsgG2SVJpIZTkG5op8he4U=; b=W/ZMMD3uCnkA6CMhMyDdz/rsx8
        js1sAmaboeOuGlO/QfP/tkIY64sHyudD8yzOcDG8w95UyCCrvW3+lRjx/ndAFDyBdq1yILWDVxX8s
        +xR3hsJqKfIvR/awLGd+z8FNyTkV10J7mb6UVwioKberqclMIvX8E8is2PY1eBNf85tLDI9xFcP6J
        ojVNyWZKBjenQ1R0trgEulrgdvA3/JGfcRNl/lFbRuHNBJHBPsQg4e2GGLqbbjN8nrFGqOYg/Pafl
        pfiG+sUyiO7cHtXp32JUp31f8x4BgNQtw5g4lLaF2ybHg3RjpLPYkq3hVEu9oje9EIX+X7z7w25Lp
        j1KRSO/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqr-00G1QD-Un; Tue, 11 Jul 2023 20:20:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 4/9] mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
Date:   Tue, 11 Jul 2023 21:20:42 +0100
Message-Id: <20230711202047.3818697-5-willy@infradead.org>
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

Push the check down from __handle_mm_fault().  There's a mild upside to
this patch in that we'll allocate the page tables while under the VMA
lock rather than the mmap lock, reducing the hold time on the mmap lock,
since the retry will find the page tables already populated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6eda5c5f2069..52f7fdd78380 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4924,6 +4924,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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
@@ -5020,11 +5025,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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
-- 
2.39.2

