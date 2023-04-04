Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F906D6473
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjDDOAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjDDOAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9F4EE4
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+X4Ep4ykQThQZtLA9ICZLzgCY3jpfgFwwzOJniiRp5g=; b=H5QsLN89pXHLK2DxF+z8kahswh
        xwcY3DxZ1JJ63xik1ZPiYMfP0hiCt2hH6DLAmD0RwO6stP30snJo6nQkAIRshQB46ggRt6TKnZb/a
        +ul0nI/Wjm8XXJH/i9Eu4lF3rCyYODJ1S2QhRkF10bcYOWMk/39U18ohLDwMV7wedlULvpuHvQy/o
        6U9l368xFkHT9E1bYat91pOle+g7m42oWvMtNSpjvX9WZx8CYeRo/wjjTQq1RTbxeKwPBhBMI4yfb
        3gGodTonrj+IEPRJd/Co6SGLo15XYOrccSYAxLWsBl8W5nG0TPiF/EIhsN8YcU/u863dAT14iRUlQ
        JBqsXQyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcj-9Z; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 3/6] mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
Date:   Tue,  4 Apr 2023 14:58:47 +0100
Message-Id: <20230404135850.3673404-4-willy@infradead.org>
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

Push the check down from __handle_mm_fault().  There's a mild upside to
this patch in that we'll allocate the page tables while under the VMA
lock rather than the mmap lock, reducing the hold time on the mmap lock,
since the retry will find the page tables already populated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fc1f0ef9a7a5..a2e27403e4f1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4896,6 +4896,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->vma))
+		return VM_FAULT_RETRY;
+
 	if (unlikely(pmd_none(*vmf->pmd))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
@@ -5014,9 +5017,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
-	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
-		return VM_FAULT_RETRY;
-
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
-- 
2.39.2

