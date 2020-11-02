Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657F2A332E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKBSnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBSnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80DC061A48
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nz9pMjX52oOyDOQK/h+mNIPY0q/AM3o8K/VbuCzMZaY=; b=kuwYmLU/mZ/d9vl0TNDOVl0kr5
        KldrIXp47MXZcbKp9y2YXpRv7h6ilE0IIMDw70F/0OJvuFqannPt2ctFwJ8VP90/kFgwlqe+HYFOZ
        T+W8SMx6f4aIO9amkV63M3X9Luhg6wbK9vzGzC2Rd8N8yXtrRxhX8O1Gh0WJa/bY3bdxpkDbDxu9Q
        1hIgFFvHy8Pz80WbAbaR3ipLd9+CYxu7w3wi3T9Pjd+//axIiCaGeol/0bGKEDsnH/hH/g/05ef0O
        tx5BPFzERozE8HmytwgtYOUvb+9t7/iWE+6fZAnVWbuy7C+RqE+4Pw6tZ9U7qJxCkOvfSqbgmYP6x
        aqLsgDhA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenW-0006m2-Bq; Mon, 02 Nov 2020 18:43:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 03/17] mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
Date:   Mon,  2 Nov 2020 18:42:58 +0000
Message-Id: <20201102184312.25926-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is prep work for the next patch, but I think at least one of the
current callers would prefer a killable sleep to an uninterruptible one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 3 +--
 mm/filemap.c            | 7 +++++--
 mm/huge_memory.c        | 4 ++--
 mm/migrate.c            | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 00288ed24698..71b36b275e4d 100644
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
index d9636ccf87ff..709774a60379 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1358,20 +1358,23 @@ static int wait_on_page_locked_async(struct page *page,
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
index 616102ba3682..ac114d265950 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1432,7 +1432,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
@@ -1468,7 +1468,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		put_and_wait_on_page_locked(page);
+		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 39663dfbc273..a50bbb0e029b 100644
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
2.28.0

