Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FF2FE0A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbhAUE1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbhAUEV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:21:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3AC0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HzHUuJikVV1y3JaLjou2Jc0YDgu/6ReouCVS0QVD5No=; b=tdflJOWumBDFY7spMDMq1rzazb
        FVUiLcrT5vZ3tVSdcyLYZsKD5lWtWZhHS+ev65UmMrWbxp/TAcxoyTTg+ib21GP7Jrp6efp2L1icU
        u6/8XrQBDfx11udFpvyTm9Gasal1CSsk0q9jbnHS3Yjs+kt399CQZOwkbr5raIL64K5t2oJdC0wKL
        PGzp51bO0sAWspb0tZwcaZ40aMw/3xD1izEFuHlZcG6MhDBYz62XxBAh6lGVkiBjZm2ADLchl1TNv
        +xPDAiZCK5XqHU0YhgSXZY62fFnbdJ1qOoISAmXYe/+FmNkdq5GuUPyy3STVUtSv+MHP5SXAD2Bq2
        /maO801A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RRW-00GbGL-G2; Thu, 21 Jan 2021 04:19:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 05/18] mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
Date:   Thu, 21 Jan 2021 04:16:03 +0000
Message-Id: <20210121041616.3955703-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is prep work for the next patch, but I think at least one of the
current callers would prefer a killable sleep to an uninterruptible one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 3 +--
 mm/filemap.c            | 7 +++++--
 mm/huge_memory.c        | 4 ++--
 mm/migrate.c            | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 932a260a29f20..55c3b299a9e47 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -679,8 +679,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
-extern void put_and_wait_on_page_locked(struct page *page);
-
+int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3e6fae3208906..c8ec47f3c3a17 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1383,20 +1383,23 @@ static int wait_on_page_locked_async(struct page *page,
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
  * @page: The page to wait for.
+ * @state: The sleep state (TASK_KILLABLE, TASK_UNINTERRUPTIBLE, etc).
  *
  * The caller should hold a reference on @page.  They expect the page to
  * become unlocked relatively soon, but do not wish to hold up migration
  * (for example) by holding the reference while waiting for the page to
  * come unlocked.  After this function returns, the caller should not
  * dereference @page.
+ *
+ * Return: 0 if the page was unlocked or -EINTR if interrupted by a signal.
  */
-void put_and_wait_on_page_locked(struct page *page)
+int put_and_wait_on_page_locked(struct page *page, int state)
 {
 	wait_queue_head_t *q;
 
 	page = compound_head(page);
 	q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE, DROP);
+	return wait_on_page_bit_common(q, page, PG_locked, state, DROP);
 }
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08a183f6c3ab0..948e61062660b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1428,7 +1428,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
@@ -1464,7 +1464,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index c1585ec29827c..4d71fd5fe856b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -335,7 +335,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!get_page_unless_zero(page))
 		goto out;
 	pte_unmap_unlock(ptep, ptl);
-	put_and_wait_on_page_locked(page);
+	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -369,7 +369,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	if (!get_page_unless_zero(page))
 		goto unlock;
 	spin_unlock(ptl);
-	put_and_wait_on_page_locked(page);
+	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 	return;
 unlock:
 	spin_unlock(ptl);
-- 
2.29.2

