Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8FE74F8EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGKUVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGKUVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBB210D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X97NNzauf5O0p+HCWC6dKF0cIqUU0VbFEqEvNM0A4i4=; b=N2FB4LpMKm0mT+slcEozTMrM51
        Mzt8L4tH3hlsu8n+Qea08POT5eAZDE9TFcS3oWwRYevUqOyXF/Rxy4n/DXbo8yPxPUMSnF1bTd3Jq
        gf0xyKh8oVCeUwqgzPW/PsA43KHs15iBRAqVrbt6ZknhdhH5OHOKUD2dh1GgoMCR3PZslcddURI8l
        EpKHwR6htyRucMHqyS7bSSc7VDt5IeV4qcQWX1bvGuIyveIrqWC1wYlfiFy9LhIHbt2dgordQS3wd
        qxSzFkAwiJG2L7M8XeQxRR36/4ziRMElrEsLItSW0Wk/DindbqfqMSYGzo0dTdKqjhSGNcQyQBCg4
        HcX1v2wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqr-00G1Q8-HB; Tue, 11 Jul 2023 20:20:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 2/9] mm: Allow per-VMA locks on file-backed VMAs
Date:   Tue, 11 Jul 2023 21:20:40 +0100
Message-Id: <20230711202047.3818697-3-willy@infradead.org>
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

The fault path will immediately fail in handle_mm_fault(), so this
is the minimal step which allows the per-VMA lock to be taken on
file-backed VMAs.  There may be a small performance reduction as a
little unnecessary work will be done on each page fault.  See later
patches for the improvement.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2c7967632866..f2dcc695f54e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5247,6 +5247,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 	}
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
@@ -5418,12 +5423,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	/* Only anonymous vmas are supported for now */
-	if (!vma_is_anonymous(vma))
-		goto inval;
-
 	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma)
+	if (vma_is_anonymous(vma) && !vma->anon_vma)
 		goto inval;
 
 	if (!vma_start_read(vma))
-- 
2.39.2

