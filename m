Return-Path: <linux-fsdevel+bounces-45530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF34A791B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D5518920E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0523CF07;
	Wed,  2 Apr 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itCQ22Ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E523CF08
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606019; cv=none; b=lmcP27My71x6xlKb3nXDC7kLbKUIf4YW+JkR0VPEFbV0r5ScBv81VNyDNRinwQMPsBp6MI/k+LWJrUIszxXe+/a4W6KlHknBLQiCHfcVExaVtJX2hxf0ZkTx4bdY/vb+Ux1zNBLFgL3/zEXvEUBpHs69ZstUU3OTIN+mHRTYBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606019; c=relaxed/simple;
	bh=JpLtZ7/TAVVgG0aMUrAKK98nEQcBnIvibgswWIBflyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGCZT9JEwiukJ35WLqZ/jvexLakIM2AvWMpZwwCuPplDVZUIT2iswerlhzXU60AuJjQPGx7QzpLJk1LhbfxMcErdkDkMb75+mkEYDD/1SBw9map4QCaV2ON1YIoau+dxnJYQZmpPLGZPsrfh4+ArmEOnwt2pFOnwGGCsVVS7VSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itCQ22Ts; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GVXJ9CoqQx/pIpf3FQPir+UyUtnBDDswwBlUb1tywgg=; b=itCQ22TsKCGEi7SS+DASJiYifq
	igeU+PIWCAXoCeY9aQW7mYN6rQR/F3VX+s8opkz6QsiBHgVv6RCU0yfgomgAxXRFqWfsUxml63U1e
	/yPtClKJxj3hSw3An4t7+YmuqoQetQ9hZw0DNYF7r0HCkG7zczHgGIff4ho5yjhQAE9dxN7jE/Xb8
	aOw9W4LEBIG/NVFL3ocpEkooBeLXfrtQJNLaFIuBlvWjlKsxDYcYk2L3su6bdaSx8Wr+k4/e79dLH
	//BCfezd5Gnxy6Ivcmd0q0Wmo8OHGop0Fky5PGKXe53HV6w4RWeZio6uabS4ebpCbXCEyt/3nPra9
	16L1QOYA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gsm-3XPn;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2 8/9] mm: Remove swap_writepage() and shmem_writepage()
Date: Wed,  2 Apr 2025 16:00:02 +0100
Message-ID: <20250402150005.2309458-9-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call swap_writeout() and shmem_writeout() from pageout() instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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
index 4bce19df557b..f7716b6569fa 100644
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
index 7d377ceae035..858cee02ca49 100644
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
@@ -3776,7 +3764,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			index--;
 
 		/*
-		 * Inform shmem_writepage() how far we have reached.
+		 * Inform shmem_writeout() how far we have reached.
 		 * No need for lock or barrier: we have the page lock.
 		 */
 		if (!folio_test_uptodate(folio))
@@ -5199,7 +5187,6 @@ static int shmem_error_remove_folio(struct address_space *mapping,
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
index 2eff8b51a945..f9fa30ae13be 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2359,7 +2359,7 @@ static int try_to_unuse(unsigned int type)
 	 * Limit the number of retries? No: when mmget_not_zero()
 	 * above fails, that mm is likely to be freeing swap from
 	 * exit_mmap(), which proceeds at its own independent pace;
-	 * and even shmem_writepage() could have been preempted after
+	 * and even shmem_writeout() could have been preempted after
 	 * folio_alloc_swap(), temporarily hiding that swap.  It's easy
 	 * and robust (though cpu-intensive) just to keep retrying.
 	 */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..d172c998d592 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -653,16 +653,16 @@ typedef enum {
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
@@ -685,7 +685,11 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
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
@@ -708,7 +712,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			wbc.list = folio_list;
 
 		folio_set_reclaim(folio);
-		res = mapping->a_ops->writepage(&folio->page, &wbc);
+		res = writeout(folio, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, folio, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
@@ -717,7 +721,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		}
 
 		if (!folio_test_writeback(folio)) {
-			/* synchronous write or broken a_ops? */
+			/* synchronous write? */
 			folio_clear_reclaim(folio);
 		}
 		trace_mm_vmscan_write_folio(folio);
-- 
2.47.2


