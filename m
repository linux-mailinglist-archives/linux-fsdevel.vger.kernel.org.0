Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45C12ACBEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgKJDhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbgKJDhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5056C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TF365VSeC8OiSB/yNZ2eARfA+gFOUwNPC1/tSlIhlrI=; b=gzdzFoOawh+h+YCg/VMGZ+6c16
        dFjhq03VZim5FPe590UC2WDVKJ7PvjX/xjN1jxLHuHMXH2PCjO4C9rRz/2IQ0B0wwywzKJKfxNFiK
        CsofYFktDK8NMb6yDGal3hQyns2DPB/DH7w2zEQWGxbD37Xz/SVkb0vnpWLqUGv9df92I+5h6CuAR
        QomiTG6io8cyrSZOahAOQXtzb5U7ZQC7YnHTNriPc2plyCClvRJL9GPpn3qte64L2hHQxA3jOrWqQ
        X5Eytp+gJ9RPuHvjaNzIMDcQVwIz+aki+3SnLjwCkONnZh9vMuawGGchOEtJLSj1KEUx2tHDtM7Ep
        yQ1cA82g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKSx-00064z-LP; Tue, 10 Nov 2020 03:37:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 05/18] mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
Date:   Tue, 10 Nov 2020 03:36:50 +0000
Message-Id: <20201110033703.23261-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
index 1de586eb377e..a2681f6882cf 100644
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

