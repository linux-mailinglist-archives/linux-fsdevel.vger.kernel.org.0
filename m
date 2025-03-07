Return-Path: <linux-fsdevel+bounces-43431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D09A56993
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8227F3B3B44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53A21C9E3;
	Fri,  7 Mar 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKfpkTCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A421ADC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=g/wisMDFimH0kvHZaxrjWu/QagzlfIxfbkvKpK27/V7fwu0VvoCPrsnDXDjQbsYD83TlX6imgBMC5zU49nFzAxFSOJVE8UcKtlhgsxBYFH7YjCt9lIdMniSzs+qSgLLy1i2z53XNL6EQJeWmw6BGS0YEL6vDhvvoB8TnPz7sNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=79boLRtLNSezE3NHdNOhLXTaQKPMPwDQxvuXOCfhRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0qDX3KzqYitOL5ihhWGDn9XZbBLlEhcQNhAAqGUJDMbUbIT9dLHcK5D9EPhA+fCDZbe5McHMmlUoIjcXfekJ/39kgJVByJc9+5lRTtly/R8dUaQw4w+PawKtKfO4FuxwEsArJfYa5zvJSec1p6eMjfce1BrbAWQLqMV7ZpR2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKfpkTCm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MCnjYQ2acBJQekNMxLqjVlaD6rzjLtTKGq0ILj29RFk=; b=bKfpkTCmPxeSbXcJ7VM2ipo40+
	XhaUhwgXUh45osKdAPlOYImlO/cUXTUKj1rso0Nxr5kg3xJMtFI7iBuHFUbWDu297CZZ4WUdie9nI
	xUBagCMx7AExicE0jt1iSaDzkrB5ZwfMad0uC0IwsOgjsoSnrLHpB5Zr4eAjyUA5hd1Uiib+p1cjV
	0WoALUdFcA3onPZONfN9vs80yhz9/HM6oEUdmf5S5M8tGA9UTzC+TqXEVdeh3hen/BGWub0VD8M0l
	y9vURrdeEI/VW7zSD9Y9JamRMCTciMSodw1MXCCTm6yaz1xnNv4UzbkTk8yYaVIC5QoEEo65MUWcL
	dtFzcuRw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGo-3MSz;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] mm: Remove swap_writepage() and shmem_writepage()
Date: Fri,  7 Mar 2025 13:54:10 +0000
Message-ID: <20250307135414.2987755-11-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call swap_writeout() and shmem_writeout() from pageout() instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/blk-wbt.c |  2 +-
 mm/page_io.c    |  3 +--
 mm/shmem.c      | 23 +++++------------------
 mm/swap.h       |  4 ++--
 mm/swap_state.c |  1 -
 mm/swapfile.c   |  2 +-
 mm/vmscan.c     | 28 ++++++++++++++++------------
 7 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f1754d07f7e0..60885731e8ab 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -37,7 +37,7 @@
 enum wbt_flags {
 	WBT_TRACKED		= 1,	/* write, tracked for throttling */
 	WBT_READ		= 2,	/* read */
-	WBT_SWAP		= 4,	/* write, from swap_writepage() */
+	WBT_SWAP		= 4,	/* write, from swap_writeout() */
 	WBT_DISCARD		= 8,	/* discard */
 
 	WBT_NR_BITS		= 4,	/* number of bits */
diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..e9151952c514 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -237,9 +237,8 @@ static void swap_zeromap_folio_clear(struct folio *folio)
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
  */
-int swap_writepage(struct page *page, struct writeback_control *wbc)
+int swap_writeout(struct folio *folio, struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
 	int ret;
 
 	if (folio_free_swap(folio)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 427b7f70fffb..a786b94a468a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -98,7 +98,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
 #define SHORT_SYMLINK_LEN 128
 
 /*
- * shmem_fallocate communicates with shmem_fault or shmem_writepage via
+ * shmem_fallocate communicates with shmem_fault or shmem_writeout via
  * inode->i_private (with i_rwsem making sure that it has only one user at
  * a time): we would prefer not to enlarge the shmem inode just for that.
  */
@@ -107,7 +107,7 @@ struct shmem_falloc {
 	pgoff_t start;		/* start of range currently being fallocated */
 	pgoff_t next;		/* the next page offset to be fallocated */
 	pgoff_t nr_falloced;	/* how many new pages have been fallocated */
-	pgoff_t nr_unswapped;	/* how often writepage refused to swap out */
+	pgoff_t nr_unswapped;	/* how often writeout refused to swap out */
 };
 
 struct shmem_options {
@@ -446,7 +446,7 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 	/*
 	 * Special case: whereas normally shmem_recalc_inode() is called
 	 * after i_mapping->nrpages has already been adjusted (up or down),
-	 * shmem_writepage() has to raise swapped before nrpages is lowered -
+	 * shmem_writeout() has to raise swapped before nrpages is lowered -
 	 * to stop a racing shmem_recalc_inode() from thinking that a page has
 	 * been freed.  Compensate here, to avoid the need for a followup call.
 	 */
@@ -1536,11 +1536,6 @@ int shmem_unuse(unsigned int type)
 	return error;
 }
 
-static int shmem_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return shmem_writeout(page_folio(page), wbc);
-}
-
 /**
  * shmem_writeout - Write the folio to swap
  * @folio: The folio to write
@@ -1558,13 +1553,6 @@ int shmem_writeout(struct folio *folio, struct writeback_control *wbc)
 	int nr_pages;
 	bool split = false;
 
-	/*
-	 * Our capabilities prevent regular writeback or sync from ever calling
-	 * shmem_writepage; but a stacking filesystem might use ->writepage of
-	 * its underlying filesystem, in which case tmpfs should write out to
-	 * swap only in response to memory pressure, and not for the writeback
-	 * threads or sync.
-	 */
 	if (WARN_ON_ONCE(!wbc->for_reclaim))
 		goto redirty;
 
@@ -1653,7 +1641,7 @@ int shmem_writeout(struct folio *folio, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-		return swap_writepage(&folio->page, wbc);
+		return swap_writeout(folio, wbc);
 	}
 
 	list_del_init(&info->swaplist);
@@ -3780,7 +3768,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			index--;
 
 		/*
-		 * Inform shmem_writepage() how far we have reached.
+		 * Inform shmem_writeout() how far we have reached.
 		 * No need for lock or barrier: we have the page lock.
 		 */
 		if (!folio_test_uptodate(folio))
@@ -5203,7 +5191,6 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 }
 
 static const struct address_space_operations shmem_aops = {
-	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
 	.write_begin	= shmem_write_begin,
diff --git a/mm/swap.h b/mm/swap.h
index 6f4a3f927edb..aa62463976d5 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -20,7 +20,7 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 		__swap_read_unplug(plug);
 }
 void swap_write_unplug(struct swap_iocb *sio);
-int swap_writepage(struct page *page, struct writeback_control *wbc);
+int swap_writeout(struct folio *folio, struct writeback_control *wbc);
 void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
 
 /* linux/mm/swap_state.c */
@@ -141,7 +141,7 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
-static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
+static inline int swap_writeout(struct folio *f, struct writeback_control *wbc)
 {
 	return 0;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 68fd981b514f..ec2b1c9c9926 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -30,7 +30,6 @@
  * vmscan's shrink_folio_list.
  */
 static const struct address_space_operations swap_aops = {
-	.writepage	= swap_writepage,
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= migrate_folio,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 628f67974a7c..60c994f84842 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2360,7 +2360,7 @@ static int try_to_unuse(unsigned int type)
 	 * Limit the number of retries? No: when mmget_not_zero()
 	 * above fails, that mm is likely to be freeing swap from
 	 * exit_mmap(), which proceeds at its own independent pace;
-	 * and even shmem_writepage() could have been preempted after
+	 * and even shmem_writeout() could have been preempted after
 	 * folio_alloc_swap(), temporarily hiding that swap.  It's easy
 	 * and robust (though cpu-intensive) just to keep retrying.
 	 */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 34410d24dc15..e9f84fa31b9a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -648,16 +648,16 @@ typedef enum {
 static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			 struct swap_iocb **plug, struct list_head *folio_list)
 {
+	int (*writeout)(struct folio *, struct writeback_control *);
+
 	/*
-	 * If the folio is dirty, only perform writeback if that write
-	 * will be non-blocking.  To prevent this allocation from being
-	 * stalled by pagecache activity.  But note that there may be
-	 * stalls if we need to run get_block().  We could test
-	 * PagePrivate for that.
-	 *
-	 * If this process is currently in __generic_file_write_iter() against
-	 * this folio's queue, we can perform writeback even if that
-	 * will block.
+	 * We no longer attempt to writeback filesystem folios here, other
+	 * than tmpfs/shmem.  That's taken care of in page-writeback.
+	 * If we find a dirty filesystem folio at the end of the LRU list,
+	 * typically that means the filesystem is saturating the storage
+	 * with contiguous writes and telling it to write a folio here
+	 * would only make the situation worse by injecting an element
+	 * of random access.
 	 *
 	 * If the folio is swapcache, write it back even if that would
 	 * block, for some throttling. This happens by accident, because
@@ -680,7 +680,11 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		}
 		return PAGE_KEEP;
 	}
-	if (mapping->a_ops->writepage == NULL)
+	if (shmem_mapping(mapping))
+		writeout = shmem_writeout;
+	else if (folio_test_anon(folio))
+		writeout = swap_writeout;
+	else
 		return PAGE_ACTIVATE;
 
 	if (folio_clear_dirty_for_io(folio)) {
@@ -703,7 +707,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			wbc.list = folio_list;
 
 		folio_set_reclaim(folio);
-		res = mapping->a_ops->writepage(&folio->page, &wbc);
+		res = writeout(folio, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, folio, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
@@ -712,7 +716,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		}
 
 		if (!folio_test_writeback(folio)) {
-			/* synchronous write or broken a_ops? */
+			/* synchronous write? */
 			folio_clear_reclaim(folio);
 		}
 		trace_mm_vmscan_write_folio(folio);
-- 
2.47.2


