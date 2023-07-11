Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138474F8EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGKUVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKUVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255610D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y6MqKlK6OxY+tonB29qlEWdduvckRCFfUllkRcgCchQ=; b=ZX0x/yAQj25a5I0W1lufq/qwUP
        oXson9J+2ubQdjXaXjjRQ+O80fML4BiNDyo6y8jRSU1mXCImAXYb7ruFGwoRefM3EqSQc1BDVRPo2
        ppz+hwLnF9JLwe05Hcdxyrw3BWuVIpaMCFMjDmpKW1LoHIwy9KeZbvl1DlfsSmjuvhHINYGd8vruW
        wwfs5AZ3GNemhwSJxsakWnNgZpxjJnyTa/d7nKlahUEur99F9UV6GUfq7l/OxED//pTMUJ0Bk9pGb
        qK6l4TnIwmYQpiv/bo7yufDpeMmcqZxl85DCZrq+hr9QYvbfBAf+PWdagfdqEdA21O7KpOeUCFSP8
        HfNHy3Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqs-00G1QH-5O; Tue, 11 Jul 2023 20:20:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 6/9] mm: Move the FAULT_FLAG_VMA_LOCK check down from do_fault()
Date:   Tue, 11 Jul 2023 21:20:44 +0100
Message-Id: <20230711202047.3818697-7-willy@infradead.org>
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

Perform the check at the start of do_read_fault(), do_cow_fault()
and do_shared_fault() instead.  Should be no performance change from
the last commit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 88cf9860f17e..709bffee8aa2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4547,6 +4547,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
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
@@ -4575,6 +4580,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
 
@@ -4615,6 +4625,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
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
@@ -4661,11 +4676,6 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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

