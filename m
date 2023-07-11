Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51074F8EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGKUU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKUU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:20:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C102310C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v94Ubxfh0lfpoM1pvfa/PhiO08lrJc9bG/pAuDnDu5E=; b=TzHT2edho2+AoBnEaZG6rSN+Xz
        HqdS52OSxRjhfnGl0GcPjNDDaW+puGj9MFK6PDZdT0nHLkUZZHVZia6dFjj4fCyS/krNwe1XiBJ5W
        fG8eF6uJHrHh/n19hVXzIQE2sFtiQSswSN30D3B9vOlrHmVQ5q51J7cxkBk0/VfmnHySgMxOdbGO5
        lPK6MQnwfgOKQrrf+YXuHBuIkBte0N1ZLRiCRnpASNkDN1JdOSpcNqw2mwsAfZ7OuF9U6HU9PLIZ/
        YsAHUMECuSPk8nMWNQYQyiCeg/QspuKbmiWuO24oJQwEh5tQaIjAA63lIhKQPa68IinpMHnL73dW7
        q4aTheXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqs-00G1QJ-7t; Tue, 11 Jul 2023 20:20:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 7/9] mm: Run the fault-around code under the VMA lock
Date:   Tue, 11 Jul 2023 21:20:45 +0100
Message-Id: <20230711202047.3818697-8-willy@infradead.org>
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

The map_pages fs method should be safe to run under the VMA lock instead
of the mmap lock.  This should have a measurable reduction in contention
on the mmap lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 709bffee8aa2..0a4e363b0605 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4547,11 +4547,6 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	struct folio *folio;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		vma_end_read(vmf->vma);
-		return VM_FAULT_RETRY;
-	}
-
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
 	 * if page by the offset is not ready to be mapped (cold cache or
@@ -4563,6 +4558,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
-- 
2.39.2

