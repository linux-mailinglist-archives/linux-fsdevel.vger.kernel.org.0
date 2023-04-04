Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0666D647B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjDDOAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjDDOAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E57527A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NLYKRwFNq+8FLihqhRGQQaNAsp7ufPwRcv+8u3H1cA4=; b=it1WBTzCbBaRNto+t074tt0Ush
        V1CMwLewtl1Ml7qU5ah8lyoolevYZpl6ajFurNLcf3LgTOT5eRim6LguAdfOxqGY5KEmjEvFKc9f/
        +wvpgAB26L2MfoJtXNLnOKrezsaXjg6iGehplYusPKYuFCqJdzS+yQpirPEX3VaC45ImCMI4OkdGP
        wRk3ZC+AnxvMeyglwYxclUIi1BDH0vOhR1425jfurrFBzJJFYBfKMttWXuXOr9KIPAHI8kX8pNfA/
        ciGWPILcbwdfVQwL0k+Z/SoXgBLlOW889RFA/2HwuHRfWOIw942qXzIBiuPRQq1jgZ9GFnnrlZBoU
        X1ZgHIag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcn-FW; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 5/6] mm: Move the FAULT_FLAG_VMA_LOCK check down from do_pte_missing()
Date:   Tue,  4 Apr 2023 14:58:49 +0100
Message-Id: <20230404135850.3673404-6-willy@infradead.org>
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

Perform the check at the start of do_read_fault(), do_cow_fault()
and do_shared_fault() instead.  Should be no performance change from
the last commit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc2baddc6040..9952bebd25b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3647,8 +3647,6 @@ static vm_fault_t do_pte_missing(struct vm_fault *vmf)
 {
 	if (vma_is_anonymous(vmf->vma))
 		return do_anonymous_page(vmf);
-	else if (vmf->flags & FAULT_FLAG_VMA_LOCK)
-		return VM_FAULT_RETRY;
 	else
 		return do_fault(vmf);
 }
@@ -4523,6 +4521,8 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret = 0;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
 	 * if page by the offset is not ready to be mapped (cold cache or
@@ -4550,6 +4550,9 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
+
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
 
@@ -4589,6 +4592,9 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret, tmp;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
+
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
-- 
2.39.2

