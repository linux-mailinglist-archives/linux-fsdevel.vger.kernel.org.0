Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744A26D647A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjDDOA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjDDOAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893D59C9
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IgHYdieXRfLvREO+xFvQYpyGVelRpE2byQDY/NWcPVw=; b=hkP38WXdxSRQI9qE4hdjSm+MIG
        dGsRyyxfG7qIxgAkpnHEL3nMtKCJK4cfzXA9camTfntUJN/qZyyI05FnwSdTv3jzAMZ++uIFUj/FG
        tYeiw5hX2sPahC/yykQOSeiOs+w/+wq3p8d4lI22HJqr5aieEKPQMBDF1fNeYy1Urdg+lUreny2qZ
        MqaF+0qam1AhUsPqvAkKcxeR7LF2tjcYHY99iYM92L2Bh42AKNUQH87AxBJA8cBViykfIvlUhGxuV
        +mMA05WyJsgPlB/21C4fBDOd/E8TGta1WocWkCzcVFFpXqODYKZbzvCJXfV0KOAQQsMOSvPPmElnQ
        AR/B9/MA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcp-II; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 6/6] mm: Run the fault-around code under the VMA lock
Date:   Tue,  4 Apr 2023 14:58:50 +0100
Message-Id: <20230404135850.3673404-7-willy@infradead.org>
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

The map_pages fs method should be safe to run under the VMA lock instead
of the mmap lock.  This should have a measurable reduction in contention
on the mmap lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9952bebd25b4..590ccaf6f7fb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4521,8 +4521,6 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret = 0;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
-		return VM_FAULT_RETRY;
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
 	 * if page by the offset is not ready to be mapped (cold cache or
@@ -4534,6 +4532,8 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		return VM_FAULT_RETRY;
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
-- 
2.39.2

