Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF530981F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfHUR5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbfHUR5q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 866007F75A;
        Wed, 21 Aug 2019 17:57:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDA45D6B7;
        Wed, 21 Aug 2019 17:57:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D2AC4223D0D; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        kbuild test robot <lkp@intel.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 17/19] fuse: Add logic to free up a memory range
Date:   Wed, 21 Aug 2019 13:57:18 -0400
Message-Id: <20190821175720.25901-18-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 21 Aug 2019 17:57:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add logic to free up a busy memory range. Freed memory range will be
returned to free pool. Add a worker which can be started to select
and free some busy memory ranges.

In certain cases (write path), process can steal one of its busy
dax ranges (inline reclaim) if free range is not available.

If free range is not available and nothing can't be stolen from same
inode, caller waits on a waitq for free range to become available.

For reclaiming a range, as of now we need to hold following locks in
specified order.

	down_write(&fi->i_mmap_sem);
	down_write(&fi->i_dmap_sem);


Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/file.c      | 488 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h    |  25 +++
 fs/fuse/inode.c     |   5 +
 fs/fuse/virtio_fs.c |  10 +
 4 files changed, 519 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8c1777fb61f7..2ff7624d58c0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -25,6 +25,8 @@
 INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
                      START, LAST, static inline, fuse_dax_interval_tree);
 
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
+				struct inode *inode);
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
 {
@@ -177,6 +179,28 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
+static void
+__kick_dmap_free_worker(struct fuse_conn *fc, unsigned long delay_ms)
+{
+	unsigned long free_threshold;
+
+	/* If number of free ranges are below threshold, start reclaim */
+	free_threshold = max((fc->nr_ranges * FUSE_DAX_RECLAIM_THRESHOLD)/100,
+				(unsigned long)1);
+	if (fc->nr_free_ranges < free_threshold) {
+		pr_debug("fuse: Kicking dax memory reclaim worker. nr_free_ranges=0x%ld nr_total_ranges=%ld\n", fc->nr_free_ranges, fc->nr_ranges);
+		queue_delayed_work(system_long_wq, &fc->dax_free_work,
+				   msecs_to_jiffies(delay_ms));
+	}
+}
+
+static void kick_dmap_free_worker(struct fuse_conn *fc, unsigned long delay_ms)
+{
+	spin_lock(&fc->lock);
+	__kick_dmap_free_worker(fc, delay_ms);
+	spin_unlock(&fc->lock);
+}
+
 static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 {
 	struct fuse_dax_mapping *dmap = NULL;
@@ -186,7 +210,7 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	/* TODO: Add logic to try to free up memory if wait is allowed */
 	if (fc->nr_free_ranges <= 0) {
 		spin_unlock(&fc->lock);
-		return NULL;
+		goto out_kick;
 	}
 
 	WARN_ON(list_empty(&fc->free_ranges));
@@ -197,6 +221,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	list_del_init(&dmap->list);
 	fc->nr_free_ranges--;
 	spin_unlock(&fc->lock);
+
+out_kick:
+	kick_dmap_free_worker(fc, 0);
 	return dmap;
 }
 
@@ -223,6 +250,8 @@ static void __dmap_add_to_free_pool(struct fuse_conn *fc,
 {
 	list_add_tail(&dmap->list, &fc->free_ranges);
 	fc->nr_free_ranges++;
+	/* TODO: Wake up only when needed */
+	wake_up(&fc->dax_range_waitq);
 }
 
 static void dmap_add_to_free_pool(struct fuse_conn *fc,
@@ -274,9 +303,15 @@ static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
 
 	dmap->writable = writable;
 	if (!upgrade) {
-		/* TODO: What locking is required here. For now,
-		 * using fc->lock
+		/*
+		 * We don't take a refernce on inode. inode is valid right now
+		 * and when inode is going away, cleanup logic should first
+		 * cleanup dmap entries.
+		 *
+		 * TODO: Do we need to ensure that we are holding inode lock
+		 * as well.
 		 */
+		dmap->inode = inode;
 		dmap->start = offset;
 		dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
 		/* Protected by fi->i_dmap_sem */
@@ -356,6 +391,7 @@ static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
 		 "window_offset=0x%llx length=0x%llx\n", dmap->start,
 		 dmap->end, dmap->window_offset, dmap->length);
 	__dmap_remove_busy_list(fc, dmap);
+	dmap->inode = NULL;
 	dmap->start = dmap->end = 0;
 	__dmap_add_to_free_pool(fc, dmap);
 }
@@ -424,6 +460,21 @@ static void inode_reclaim_dmap_range(struct fuse_conn *fc, struct inode *inode,
 	spin_unlock(&fc->lock);
 }
 
+static int dmap_removemapping_one(struct inode *inode,
+				  struct fuse_dax_mapping *dmap)
+{
+	struct fuse_removemapping_one forget_one;
+	struct fuse_removemapping_in inarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.count = 1;
+	memset(&forget_one, 0, sizeof(forget_one));
+	forget_one.moffset = dmap->window_offset;
+	forget_one.len = dmap->length;
+
+	return fuse_send_removemapping(inode, &inarg, &forget_one);
+}
+
 /*
  * It is called from evict_inode() and by that time inode is going away. So
  * this function does not take any locks like fi->i_dmap_sem for traversing
@@ -1816,6 +1867,18 @@ static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t length,
 		if (flags & IOMAP_FAULT)
 			iomap->length = ALIGN(len, PAGE_SIZE);
 		iomap->type = IOMAP_MAPPED;
+
+		/*
+		 * increace refcnt so that reclaim code knows this dmap is in
+		 * use. This assumes i_dmap_sem mutex is held either
+		 * shared/exclusive.
+		 */
+		refcount_inc(&dmap->refcnt);
+
+		/* iomap->private should be NULL */
+		WARN_ON_ONCE(iomap->private);
+		iomap->private = dmap;
+
 		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
 				" length 0x%llx\n", __func__, iomap->addr,
 				iomap->offset, iomap->length);
@@ -1838,8 +1901,23 @@ static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
 	int ret;
 	bool writable = flags & IOMAP_WRITE;
 
-	alloc_dmap = alloc_dax_mapping(fc);
-	if (!alloc_dmap)
+	/* Can't do reclaim in fault path yet due to lock ordering.
+	 * Read path takes shared inode lock and that's not sufficient
+	 * for inline range reclaim. Caller needs to drop lock, wait
+	 * and retry.
+	 */
+	if (flags & IOMAP_FAULT || !(flags & IOMAP_WRITE)) {
+		alloc_dmap = alloc_dax_mapping(fc);
+		if (!alloc_dmap)
+			return -ENOSPC;
+	} else {
+		alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
+		if (IS_ERR(alloc_dmap))
+			return PTR_ERR(alloc_dmap);
+	}
+
+	/* If we are here, we should have memory allocated */
+	if (WARN_ON(!alloc_dmap))
 		return -EBUSY;
 
 	/*
@@ -1892,14 +1970,25 @@ static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
 	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
 
 	/* We are holding either inode lock or i_mmap_sem, and that should
-	 * ensure that dmap can't reclaimed or truncated and it should still
-	 * be there in tree despite the fact we dropped and re-acquired the
-	 * lock.
+	 * ensure that dmap can't be truncated. We are holding a reference
+	 * on dmap and that should make sure it can't be reclaimed. So dmap
+	 * should still be there in tree despite the fact we dropped and
+	 * re-acquired the i_dmap_sem lock.
 	 */
 	ret = -EIO;
 	if (WARN_ON(!dmap))
 		goto out_err;
 
+	/* We took an extra reference on dmap to make sure its not reclaimd.
+	 * Now we hold i_dmap_sem lock and that reference is not needed
+	 * anymore. Drop it.
+	 */
+	if (refcount_dec_and_test(&dmap->refcnt)) {
+		/* refcount should not hit 0. This object only goes
+		 * away when fuse connection goes away */
+		WARN_ON_ONCE(1);
+	}
+
 	/* Maybe another thread already upgraded mapping while we were not
 	 * holding lock.
 	 */
@@ -1968,7 +2057,11 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 			 * two threads to be trying to this simultaneously
 			 * for same dmap. So drop shared lock and acquire
 			 * exclusive lock.
+			 *
+			 * Before dropping i_dmap_sem lock, take reference
+			 * on dmap so that its not freed by range reclaim.
 			 */
+			refcount_inc(&dmap->refcnt);
 			up_read(&fi->i_dmap_sem);
 			pr_debug("%s: Upgrading mapping at offset 0x%llx"
 				 " length 0x%llx\n", __func__, pos, length);
@@ -2004,6 +2097,16 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			  ssize_t written, unsigned flags,
 			  struct iomap *iomap)
 {
+	struct fuse_dax_mapping *dmap = iomap->private;
+
+	if (dmap) {
+		if (refcount_dec_and_test(&dmap->refcnt)) {
+			/* refcount should not hit 0. This object only goes
+			 * away when fuse connection goes away */
+			WARN_ON_ONCE(1);
+		}
+	}
+
 	/* DAX writes beyond end-of-file aren't handled using iomap, so the
 	 * file size is unchanged and there is nothing to do here.
 	 */
@@ -2018,7 +2121,18 @@ static const struct iomap_ops fuse_iomap_ops = {
 static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	ssize_t ret;
+	bool retry = false;
+
+retry:
+	if (retry && !(fc->nr_free_ranges > 0)) {
+		ret = -EINTR;
+		if (wait_event_killable_exclusive(fc->dax_range_waitq,
+						  (fc->nr_free_ranges > 0))) {
+			goto out;
+		}
+	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!inode_trylock_shared(inode))
@@ -2030,8 +2144,19 @@ static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	ret = dax_iomap_rw(iocb, to, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
 
+	/* If a dax range could not be allocated and it can't be reclaimed
+	 * inline, then drop inode lock and retry. Range reclaim logic
+	 * requires exclusive access to inode lock.
+	 *
+	 * TODO: What if -ENOSPC needs to be returned to user space. Fix it.
+	 */
+	if (ret == -ENOSPC) {
+		retry = true;
+		goto retry;
+	}
 	/* TODO file_accessed(iocb->f_filp) */
 
+out:
 	return ret;
 }
 
@@ -2810,10 +2935,21 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
 	pfn_t pfn;
+	int error = 0;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool retry = false;
 
 	if (write)
 		sb_start_pagefault(sb);
 
+retry:
+	if (retry && !(fc->nr_free_ranges > 0)) {
+		ret = -EINTR;
+		if (wait_event_killable_exclusive(fc->dax_range_waitq,
+					(fc->nr_free_ranges > 0)))
+			goto out;
+	}
+
 	/*
 	 * We need to serialize against not only truncate but also against
 	 * fuse dax memory range reclaim. While a range is being reclaimed,
@@ -2821,13 +2957,20 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 	 * to populate page cache or access memory we are trying to free.
 	 */
 	down_read(&get_fuse_inode(inode)->i_mmap_sem);
-	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, &error, &fuse_iomap_ops);
+	if ((ret & VM_FAULT_ERROR) && error == -ENOSPC) {
+		error = 0;
+		retry = true;
+		up_read(&get_fuse_inode(inode)->i_mmap_sem);
+		goto retry;
+	}
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 
 	up_read(&get_fuse_inode(inode)->i_mmap_sem);
 
+out:
 	if (write)
 		sb_end_pagefault(sb);
 
@@ -3979,3 +4122,330 @@ void fuse_init_file_inode(struct inode *inode)
 		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
+
+static int dmap_writeback_invalidate(struct inode *inode,
+				     struct fuse_dax_mapping *dmap)
+{
+	int ret;
+
+	ret = filemap_fdatawrite_range(inode->i_mapping, dmap->start,
+				       dmap->end);
+	if (ret) {
+		printk("filemap_fdatawrite_range() failed. err=%d start=0x%llx,"
+			" end=0x%llx\n", ret, dmap->start, dmap->end);
+		return ret;
+	}
+
+	ret = invalidate_inode_pages2_range(inode->i_mapping,
+					    dmap->start >> PAGE_SHIFT,
+					    dmap->end >> PAGE_SHIFT);
+	if (ret)
+		printk("invalidate_inode_pages2_range() failed err=%d\n", ret);
+
+	return ret;
+}
+
+static int reclaim_one_dmap_locked(struct fuse_conn *fc, struct inode *inode,
+				   struct fuse_dax_mapping *dmap)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/*
+	 * igrab() was done to make sure inode won't go under us, and this
+	 * further avoids the race with evict().
+	 */
+	ret = dmap_writeback_invalidate(inode, dmap);
+
+	/* TODO: What to do if above fails? For now,
+	 * leave the range in place.
+	 */
+	if (ret)
+		return ret;
+
+	/* Remove dax mapping from inode interval tree now */
+	fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+	fi->nr_dmaps--;
+
+	ret = dmap_removemapping_one(inode, dmap);
+	if (ret) {
+		pr_warn("Failed to remove mapping. offset=0x%llx len=0x%llx\n",
+			dmap->window_offset, dmap->length);
+	}
+
+	return 0;
+}
+
+static void fuse_wait_dax_page(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+        up_write(&fi->i_mmap_sem);
+        schedule();
+        down_write(&fi->i_mmap_sem);
+}
+
+/* Should be called with fi->i_mmap_sem lock held exclusively */
+static int __fuse_break_dax_layouts(struct inode *inode, bool *retry,
+				    loff_t start, loff_t end)
+{
+	struct page *page;
+
+	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+	if (!page)
+		return 0;
+
+	*retry = true;
+	return ___wait_var_event(&page->_refcount,
+			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
+			0, 0, fuse_wait_dax_page(inode));
+}
+
+/* dmap_end == 0 leads to unmapping of whole file */
+static int fuse_break_dax_layouts(struct inode *inode, u64 dmap_start,
+				  u64 dmap_end)
+{
+	bool	retry;
+	int	ret;
+
+	do {
+		retry = false;
+		ret = __fuse_break_dax_layouts(inode, &retry, dmap_start,
+					       dmap_end);
+        } while (ret == 0 && retry);
+
+        return ret;
+}
+
+/* First first mapping in the tree and free it. */
+static struct fuse_dax_mapping *
+inode_reclaim_first_dmap_locked(struct fuse_conn *fc, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0, -1);
+	if (!dmap)
+		return NULL;
+
+	ret = reclaim_one_dmap_locked(fc, inode, dmap);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	/* Clean up dmap. Do not add back to free list */
+	dmap_remove_busy_list(fc, dmap);
+	dmap->inode = NULL;
+	dmap->start = dmap->end = 0;
+
+	pr_debug("fuse: reclaimed memory range window_offset=0x%llx,"
+				" length=0x%llx\n", dmap->window_offset,
+				dmap->length);
+	return dmap;
+}
+
+/*
+ * First first mapping in the tree and free it and return it. Do not add
+ * it back to free pool.
+ *
+ * This is called with inode lock held.
+ */
+static struct fuse_dax_mapping *inode_reclaim_first_dmap(struct fuse_conn *fc,
+							 struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	down_write(&fi->i_mmap_sem);
+
+	/* Make sure there are references to inode pages using
+	 * get_user_pages()
+	 *
+	 * TODO: Only check for page range inside dmap (and not whole inode)
+	 */
+	ret = fuse_break_dax_layouts(inode, 0, 0);
+	if (ret) {
+		printk("virtio_fs: fuse_break_dax_layouts() failed. err=%d\n",
+		       ret);
+		dmap = ERR_PTR(ret);
+		goto out_mmap_sem;
+	}
+	down_write(&fi->i_dmap_sem);
+	dmap = inode_reclaim_first_dmap_locked(fc, inode);
+	up_write(&fi->i_dmap_sem);
+out_mmap_sem:
+	up_write(&fi->i_mmap_sem);
+	return dmap;
+}
+
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
+					struct inode *inode)
+{
+	struct fuse_dax_mapping *dmap;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	while(1) {
+		dmap = alloc_dax_mapping(fc);
+		if (dmap)
+			return dmap;
+
+		if (fi->nr_dmaps) {
+			dmap = inode_reclaim_first_dmap(fc, inode);
+			if (dmap)
+				return dmap;
+		}
+		/*
+		 * There are no mappings which can be reclaimed.
+		 * Wait for one.
+		 */
+		if (!(fc->nr_free_ranges > 0)) {
+			if (wait_event_killable_exclusive(fc->dax_range_waitq,
+					(fc->nr_free_ranges > 0)))
+				return ERR_PTR(-EINTR);
+		}
+	}
+}
+
+static int lookup_and_reclaim_dmap_locked(struct fuse_conn *fc,
+					  struct inode *inode, u64 dmap_start)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
+						 dmap_start);
+
+	/* Range already got cleaned up by somebody else */
+	if (!dmap)
+		return 0;
+
+	/* still in use. */
+	if (refcount_read(&dmap->refcnt) > 1)
+		return 0;
+
+	ret = reclaim_one_dmap_locked(fc, inode, dmap);
+	if (ret < 0)
+		return ret;
+
+	/* Cleanup dmap entry and add back to free list */
+	spin_lock(&fc->lock);
+	dmap_reinit_add_to_free_pool(fc, dmap);
+	spin_unlock(&fc->lock);
+	return ret;
+}
+
+/*
+ * Free a range of memory.
+ * Locking.
+ * 1. Take fuse_inode->i_mmap_sem to block dax faults.
+ * 2. Take fuse_inode->i_dmap_sem to protect interval tree and also to make
+ *    sure read/write can not reuse a dmap which we might be freeing.
+ */
+static int lookup_and_reclaim_dmap(struct fuse_conn *fc, struct inode *inode,
+				   u64 dmap_start, u64 dmap_end)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	down_write(&fi->i_mmap_sem);
+	ret = fuse_break_dax_layouts(inode, dmap_start, dmap_end);
+	if (ret) {
+		printk("virtio_fs: fuse_break_dax_layouts() failed. err=%d\n",
+		       ret);
+		goto out_mmap_sem;
+	}
+
+	down_write(&fi->i_dmap_sem);
+	ret = lookup_and_reclaim_dmap_locked(fc, inode, dmap_start);
+	up_write(&fi->i_dmap_sem);
+out_mmap_sem:
+	up_write(&fi->i_mmap_sem);
+	return ret;
+}
+
+static int try_to_free_dmap_chunks(struct fuse_conn *fc,
+				   unsigned long nr_to_free)
+{
+	struct fuse_dax_mapping *dmap, *pos, *temp;
+	int ret, nr_freed = 0;
+	u64 dmap_start = 0, window_offset = 0, dmap_end = 0;
+	struct inode *inode = NULL;
+
+	/* Pick first busy range and free it for now*/
+	while(1) {
+		if (nr_freed >= nr_to_free)
+			break;
+
+		dmap = NULL;
+		spin_lock(&fc->lock);
+
+		if (!fc->nr_busy_ranges) {
+			spin_unlock(&fc->lock);
+			return 0;
+		}
+
+		list_for_each_entry_safe(pos, temp, &fc->busy_ranges,
+						busy_list) {
+			/* skip this range if it's in use. */
+			if (refcount_read(&pos->refcnt) > 1)
+				continue;
+
+			inode = igrab(pos->inode);
+			/*
+			 * This inode is going away. That will free
+			 * up all the ranges anyway, continue to
+			 * next range.
+			 */
+			if (!inode)
+				continue;
+			/*
+			 * Take this element off list and add it tail. If
+			 * inode lock can't be obtained, this will help with
+			 * selecting new element
+			 */
+			dmap = pos;
+			list_move_tail(&dmap->busy_list, &fc->busy_ranges);
+			dmap_start = dmap->start;
+			dmap_end = dmap->end;
+			window_offset = dmap->window_offset;
+			break;
+		}
+		spin_unlock(&fc->lock);
+		if (!dmap)
+			return 0;
+
+		ret = lookup_and_reclaim_dmap(fc, inode, dmap_start, dmap_end);
+		iput(inode);
+		if (ret) {
+			printk("%s(window_offset=0x%llx) failed. err=%d\n",
+				__func__, window_offset, ret);
+			return ret;
+		}
+		nr_freed++;
+	}
+	return 0;
+}
+
+/* TODO: This probably should go in inode.c */
+void fuse_dax_free_mem_worker(struct work_struct *work)
+{
+	int ret;
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+						dax_free_work.work);
+	pr_debug("fuse: Worker to free memory called. nr_free_ranges=%lu"
+		 " nr_busy_ranges=%lu\n", fc->nr_free_ranges,
+		 fc->nr_busy_ranges);
+
+	ret = try_to_free_dmap_chunks(fc, FUSE_DAX_RECLAIM_CHUNK);
+	if (ret) {
+		pr_debug("fuse: try_to_free_dmap_chunks() failed with err=%d\n",
+			 ret);
+	}
+
+	/* If number of free ranges are still below threhold, requeue */
+	kick_dmap_free_worker(fc, 1);
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 070a5c2b6498..5f2f348536aa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -57,6 +57,16 @@
 #define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
 #define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
 
+/* Number of ranges reclaimer will try to free in one invocation */
+#define FUSE_DAX_RECLAIM_CHUNK		(10)
+
+/*
+ * Dax memory reclaim threshold in percetage of total ranges. When free
+ * number of free ranges drops below this threshold, reclaim can trigger
+ * Default is 20%
+ * */
+#define FUSE_DAX_RECLAIM_THRESHOLD	(20)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -109,6 +119,9 @@ struct fuse_forget_link {
 
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Pointer to inode where this memory range is mapped */
+	struct inode *inode;
+
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
 
@@ -131,6 +144,9 @@ struct fuse_dax_mapping {
 
 	/* Is this mapping read-only or read-write */
 	bool writable;
+
+	/* reference count when the mapping is used by dax iomap. */
+	refcount_t refcnt;
 };
 
 /** FUSE inode */
@@ -895,12 +911,20 @@ struct fuse_conn {
 	unsigned long nr_busy_ranges;
 	struct list_head busy_ranges;
 
+	/* Worker to free up memory ranges */
+	struct delayed_work dax_free_work;
+
+	/* Wait queue for a dax range to become free */
+	wait_queue_head_t dax_range_waitq;
+
 	/*
 	 * DAX Window Free Ranges. TODO: This might not be best place to store
 	 * this free list
 	 */
 	long nr_free_ranges;
 	struct list_head free_ranges;
+
+	unsigned long nr_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1279,6 +1303,7 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
+void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_cleanup_inode_mappings(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b80e76a307f3..4871933f4557 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -661,11 +661,13 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
 		range->length = FUSE_DAX_MEM_RANGE_SZ;
 		INIT_LIST_HEAD(&range->busy_list);
+		refcount_set(&range->refcnt, 1);
 		list_add_tail(&range->list, &mem_ranges);
 	}
 
 	list_replace_init(&mem_ranges, &fc->free_ranges);
 	fc->nr_free_ranges = nr_ranges;
+	fc->nr_ranges = nr_ranges;
 	return 0;
 out_err:
 	/* Free All allocated elements */
@@ -692,6 +694,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
+	init_waitqueue_head(&fc->dax_range_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
@@ -712,6 +715,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
 	INIT_LIST_HEAD(&fc->busy_ranges);
+	INIT_DELAYED_WORK(&fc->dax_free_work, fuse_dax_free_mem_worker);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -720,6 +724,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		flush_delayed_work(&fc->dax_free_work);
 		if (fc->dax_dev)
 			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		put_pid_ns(fc->pid_ns);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 9198c2b84677..72b97bcd8e44 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -491,6 +491,15 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(fs->dax_dev);
 }
 
+static void virtio_fs_pagemap_page_free(struct page *page)
+{
+	wake_up_var(&page->_refcount);
+}
+
+static const struct dev_pagemap_ops virtio_fs_pagemap_ops = {
+	.page_free	= virtio_fs_pagemap_page_free,
+};
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	struct virtio_shm_region cache_reg;
@@ -517,6 +526,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
+	pgmap->ops = &virtio_fs_pagemap_ops;
 
 	/* Ideally we would directly use the PCI BAR resource but
 	 * devm_memremap_pages() wants its own copy in pgmap.  So
-- 
2.20.1

