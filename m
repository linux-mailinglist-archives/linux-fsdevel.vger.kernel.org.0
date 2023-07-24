Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4D75FF62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGXSyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXSyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AF10D1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S+dCr3wFmOnYx33aA8EkljEdRO/JPPjH0b8bNo8hRK8=; b=LpXGzVO1V3NFVNKSce0PI1K3mI
        00HJIlamGKCVSJTU/TaXpSYtxAGCJ00H8nAvYbCONsEJF+t6kq7PAN1mvhkItteW71rqdc1PhVEbq
        2gY6Z8zsNCr9W04TlSMo9Hy2HGC1WDAHIYECDH4Sbo1jdx+UmSmFhImPpi4G+6hpt3omrFGnPCioY
        r5OetU3asujp/vCVz0A1TrJNtGePESTSBDleEdYtuuJx/GTh05EMuZxNBZKUDjxrff0WVp9hInezm
        QXszgBXraH7AudLUVjQqC8IyJoZKy1QmoyTQLjTacx21fFkIGpppl2591qthTSu8Cfpv95BJwk1oO
        JSJPo0dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iRD-Jf; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 07/10] mm: Move FAULT_FLAG_VMA_LOCK check down from do_fault()
Date:   Mon, 24 Jul 2023 19:54:07 +0100
Message-Id: <20230724185410.1124082-8-willy@infradead.org>
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

Perform the check at the start of do_read_fault(), do_cow_fault()
and do_shared_fault() instead.  Should be no performance change from
the last commit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 11b337876477..627a2abb969b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4661,6 +4661,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	struct folio *folio;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
 	 * if page by the offset is not ready to be mapped (cold cache or
@@ -4689,6 +4694,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
 
@@ -4729,6 +4739,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	vm_fault_t ret, tmp;
 	struct folio *folio;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
@@ -4775,11 +4790,6 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK){
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
-
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
-- 
2.39.2

