Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CA6D6478
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjDDOAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjDDOAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580003C39
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=52BqLkPH7JK+YVgxAe2fuxeKTYdfJ/oXPMwp85njK/A=; b=wOhh5MI6+I4NGse+vua1IB8f4A
        hZZCG95HJrdfyK8JqiDCfGDmfPoatJwd6OUBpDjbZLS1rpRg/INo4Zm7QMNbZUmHWr1+FTPGtFy+1
        4tXsE9cGWheBFU8hBh3jvu+vwuyrSNhEA0qwcC3LvgvRLxmpKZKvbxXay4xYHkbEz0oy8m2BdpdO2
        XfBSQZsFz3NVZ2WSiG8L6CJs9EpamaXyYXMfqe5PifW8V2fCb0gwJ63XmPTArO/gT6m84+xT34D6x
        AiB3JXxroKqcRT8kYynhag8ZVBv5Avf0fW91FS2TVRCCvnKSgSfVnHl2ZxjaIvJQoz7e2eN9c4SLG
        /LGz7mag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcf-4A; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
Date:   Tue,  4 Apr 2023 14:58:45 +0100
Message-Id: <20230404135850.3673404-2-willy@infradead.org>
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

The fault path will immediately fail in handle_mm_fault(), so this
is the minimal step which allows the per-VMA lock to be taken on
file-backed VMAs.  There may be a small performance reduction as a
little unnecessary work will be done on each page fault.  See later
patches for the improvement.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fdaec7772fff..f726f85f0081 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5223,6 +5223,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 					    flags & FAULT_FLAG_REMOTE))
 		return VM_FAULT_SIGSEGV;
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
+		return VM_FAULT_RETRY;
+
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
@@ -5275,12 +5278,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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

