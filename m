Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F5300835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhAVQGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbhAVQGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:06:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AAC06174A;
        Fri, 22 Jan 2021 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wMfE7bzqqAfe5q1gI/PP7mCc/7GwzPnfL/VmkkXAWNc=; b=ieDp0oWMjBBrQwYQdQPsYPdY3h
        l6bL3UT6bUuM2NoRcZ72f+sR1I4rK9w5l8yscKf1Zha2oxogAxAO8k1IR+K7tkoQs8ouiWXlfuqc5
        DtI2NxSv6AytZtsUFIwjryWNGTYpitcEY7MDGZbMtN5RUtAeZAluk6LMpa9ru+NIupOUbgapLGfNe
        YZtMKhkE19qfM8cA15xg2KATgoNTHd2pE50SzVIBbArBuHiwuOtHce6C38ekamcnDakHxyJGF013F
        SjKHJIWEQEZoQjkKpuX7eGKHjmmNKXGjSrYOfwZDVulEl15autUmchJuswsu/KfArhCVN8ys1rwks
        OQXeyA6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2yvU-000wGo-GI; Fri, 22 Jan 2021 16:05:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/18] mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
Date:   Fri, 22 Jan 2021 16:01:27 +0000
Message-Id: <20210122160140.223228-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
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
index 4317f34866c75..20225b067583a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -681,8 +681,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
-extern void put_and_wait_on_page_locked(struct page *page);
-
+int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index c5d8b6baf656a..c71cd95e5372b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1379,20 +1379,23 @@ static int wait_on_page_locked_async(struct page *page,
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
index 5aa045e3b5dc1..1764ecd5beba5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1441,7 +1441,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
@@ -1477,7 +1477,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index a3e1acc72ad78..62b81d5257aaa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -331,7 +331,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!get_page_unless_zero(page))
 		goto out;
 	pte_unmap_unlock(ptep, ptl);
-	put_and_wait_on_page_locked(page);
+	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -365,7 +365,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
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

