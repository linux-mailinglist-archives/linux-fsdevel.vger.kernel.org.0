Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7441FAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEOT2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfEOT1f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49C078110C;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEBC71972D;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 173E022548E; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 26/30] fuse: Add logic to free up a memory range
Date:   Wed, 15 May 2019 15:27:11 -0400
Message-Id: <20190515192715.18000-27-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add logic to free up a busy memory range. Freed memory range will be
returned to free pool. Add a worker which can be started to select
and free some busy memory ranges.

In certain cases (write path), process can steal one of its busy
dax ranges if free range is not available.

If free range is not available and nothing can't be stolen from same
inode, caller waits on a waitq for free range to become available.

For reclaiming a range, as of now we need to hold following locks in
specified order.

	inode_trylock(inode);
	down_write(&fi->i_mmap_sem);
	down_write(&fi->i_dmap_sem);

This means, one can not wait for a range to become free when in fault
path because it can lead to deadlock in following two situations.

- Worker thread to free memory might block on fuse_inode->i_mmap_sem as well.
- This inode is holding all the memory and more memory can't be freed.

In both the cases, deadlock will ensue. So return -ENOSPC from iomap_begin()
in fault path if memory can't be allocated. Drop fuse_inode->i_mmap_sem,
and wait for a free range to become available and retry.

read path can't do direct reclaim as well because it holds shared inode
lock while reclaim assumes that inode lock is held exclusively. Due to
shared lock, it might happen that one reader is still reading from range
and another reader reclaims that range leading to problems. So read path
also returns -ENOSPC and higher layers retry (like fault path).

 a different story. We hold inode lock and lock ordering
allows to grab fuse_inode->immap_sem, if needed. That means we can do direct
reclaim in that path. But if there is no memory allocated to this inode,
then direct reclaim will not work and we need to wait for a memory range
to become free. So try following order.

A. Try to get a free range.
B. If not, try direct reclaim.
C. If not, wait for a memory range to become free

Here sleeping with locks held should be fine because in step B, we made
sure this inode is not holding any ranges. That means other inodes are
holding ranges and somebody should be able to free memory. Also, worker
thread does a trylock() on inode lock. That means worker tread will not
wait on this inode and move onto next memory range. Hence above sequence
should be deadlock free.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 357 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h |  22 +++
 fs/fuse/inode.c  |   4 +
 3 files changed, 374 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3f0f7a387341..87fc2b5e0a3a 100644
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
@@ -179,6 +181,7 @@ static void fuse_link_write_file(struct file *file)
 
 static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 {
+	unsigned long free_threshold;
 	struct fuse_dax_mapping *dmap = NULL;
 
 	spin_lock(&fc->lock);
@@ -186,7 +189,7 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	/* TODO: Add logic to try to free up memory if wait is allowed */
 	if (fc->nr_free_ranges <= 0) {
 		spin_unlock(&fc->lock);
-		return NULL;
+		goto out_kick;
 	}
 
 	WARN_ON(list_empty(&fc->free_ranges));
@@ -197,15 +200,43 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	list_del_init(&dmap->list);
 	fc->nr_free_ranges--;
 	spin_unlock(&fc->lock);
+
+out_kick:
+	/* If number of free ranges are below threshold, start reclaim */
+	free_threshold = max((fc->nr_ranges * FUSE_DAX_RECLAIM_THRESHOLD)/100,
+				(unsigned long)1);
+	if (fc->nr_free_ranges < free_threshold) {
+		pr_debug("fuse: Kicking dax memory reclaim worker. nr_free_ranges=0x%ld nr_total_ranges=%ld\n", fc->nr_free_ranges, fc->nr_ranges);
+		queue_delayed_work(system_long_wq, &fc->dax_free_work, 0);
+	}
 	return dmap;
 }
 
+/* This assumes fc->lock is held */
+static void __dmap_remove_busy_list(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	list_del_init(&dmap->busy_list);
+	WARN_ON(fc->nr_busy_ranges == 0);
+	fc->nr_busy_ranges--;
+}
+
+static void dmap_remove_busy_list(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	spin_lock(&fc->lock);
+	__dmap_remove_busy_list(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
 /* This assumes fc->lock is held */
 static void __free_dax_mapping(struct fuse_conn *fc,
 				struct fuse_dax_mapping *dmap)
 {
 	list_add_tail(&dmap->list, &fc->free_ranges);
 	fc->nr_free_ranges++;
+	/* TODO: Wake up only when needed */
+	wake_up(&fc->dax_range_waitq);
 }
 
 static void free_dax_mapping(struct fuse_conn *fc,
@@ -267,7 +298,15 @@ static int fuse_setup_one_mapping(struct inode *inode,
 
 	pr_debug("fuse_setup_one_mapping() succeeded. offset=0x%llx err=%zd\n", offset, err);
 
-	/* TODO: What locking is required here. For now, using fc->lock */
+	/*
+	 * We don't take a refernce on inode. inode is valid right now and
+	 * when inode is going away, cleanup logic should first cleanup
+	 * dmap entries.
+	 *
+	 * TODO: Do we need to ensure that we are holding inode lock
+	 * as well.
+	 */
+	dmap->inode = inode;
 	dmap->start = offset;
 	dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
 	/* Protected by fi->i_dmap_sem */
@@ -321,10 +360,7 @@ void fuse_removemapping(struct inode *inode)
 		if (dmap) {
 			fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
 			fi->nr_dmaps--;
-			spin_lock(&fc->lock);
-			list_del_init(&dmap->busy_list);
-			fc->nr_busy_ranges--;
-			spin_unlock(&fc->lock);
+			dmap_remove_busy_list(fc, dmap);
 		}
 
 		if (!dmap)
@@ -347,6 +383,8 @@ void fuse_removemapping(struct inode *inode)
 			}
 		}
 
+		dmap->inode = NULL;
+
 		/* Add it back to free ranges list */
 		free_dax_mapping(fc, dmap);
 	}
@@ -1784,8 +1822,23 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 		if (pos >= i_size_read(inode))
 			goto iomap_hole;
 
-		alloc_dmap = alloc_dax_mapping(fc);
-		if (!alloc_dmap)
+		/* Can't do reclaim in fault path yet due to lock ordering.
+		 * Read path takes shared inode lock and that's not sufficient
+		 * for inline range reclaim. Caller needs to drop lock, wait
+		 * and retry.
+		 */
+		if (flags & IOMAP_FAULT || !(flags & IOMAP_WRITE)) {
+			alloc_dmap = alloc_dax_mapping(fc);
+			if (!alloc_dmap)
+				return -ENOSPC;
+		} else {
+			alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
+			if (IS_ERR(alloc_dmap))
+				return PTR_ERR(alloc_dmap);
+		}
+
+		/* If we are here, we should have memory allocated */
+		if (WARN_ON(!alloc_dmap))
 			return -EBUSY;
 
 		/*
@@ -1850,7 +1903,18 @@ static const struct iomap_ops fuse_iomap_ops = {
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
@@ -1862,8 +1926,19 @@ static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
 
@@ -2642,10 +2717,21 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
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
@@ -2653,13 +2739,20 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
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
 
@@ -3762,3 +3855,249 @@ void fuse_init_file_inode(struct inode *inode)
 		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
+
+int fuse_dax_reclaim_dmap_locked(struct fuse_conn *fc, struct inode *inode,
+				struct fuse_dax_mapping *dmap)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ret = filemap_fdatawrite_range(inode->i_mapping, dmap->start,
+					dmap->end);
+	if (ret) {
+		printk("filemap_fdatawrite_range() failed. err=%d start=0x%llx,"
+			" end=0x%llx\n", ret, dmap->start, dmap->end);
+		return ret;
+	}
+
+	ret = invalidate_inode_pages2_range(inode->i_mapping,
+					dmap->start >> PAGE_SHIFT,
+					dmap->end >> PAGE_SHIFT);
+	/* TODO: What to do if above fails? For now,
+	 * leave the range in place.
+	 */
+	if (ret) {
+		printk("invalidate_inode_pages2_range() failed err=%d\n", ret);
+		return ret;
+	}
+
+	/* Remove dax mapping from inode interval tree now */
+	fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+	fi->nr_dmaps--;
+
+	ret = fuse_removemapping_one(inode, dmap);
+	if (ret) {
+		pr_warn("Failed to remove mapping. offset=0x%llx len=0x%llx\n",
+			dmap->window_offset, dmap->length);
+	}
+
+	return 0;
+}
+
+/* First first mapping in the tree and free it. */
+struct fuse_dax_mapping *fuse_dax_reclaim_first_mapping_locked(
+				struct fuse_conn *fc, struct inode *inode)
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
+	ret = fuse_dax_reclaim_dmap_locked(fc, inode, dmap);
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
+struct fuse_dax_mapping *fuse_dax_reclaim_first_mapping(struct fuse_conn *fc,
+					struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	down_write(&fi->i_mmap_sem);
+	down_write(&fi->i_dmap_sem);
+	dmap = fuse_dax_reclaim_first_mapping_locked(fc, inode);
+	up_write(&fi->i_dmap_sem);
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
+		if (fi->nr_dmaps)
+			return fuse_dax_reclaim_first_mapping(fc, inode);
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
+int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
+				u64 dmap_start)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	WARN_ON(!inode_is_locked(inode));
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
+							dmap_start);
+
+	/* Range already got cleaned up by somebody else */
+	if (!dmap)
+		return 0;
+
+	ret = fuse_dax_reclaim_dmap_locked(fc, inode, dmap);
+	if (ret < 0)
+		return ret;
+
+	/* Cleanup dmap entry and add back to free list */
+	spin_lock(&fc->lock);
+	__dmap_remove_busy_list(fc, dmap);
+	dmap->inode = NULL;
+	dmap->start = dmap->end = 0;
+	__free_dax_mapping(fc, dmap);
+	spin_unlock(&fc->lock);
+
+	pr_debug("fuse: freed memory range window_offset=0x%llx,"
+				" length=0x%llx\n", dmap->window_offset,
+				dmap->length);
+	return ret;
+}
+
+/*
+ * Free a range of memory.
+ * Locking.
+ * 1. Take inode->i_rwsem to prever further read/write.
+ * 2. Take fuse_inode->i_mmap_sem to block dax faults.
+ * 3. Take fuse_inode->i_dmap_sem to protect interval tree. It might not
+ *    be strictly necessary as lock 1 and 2 seem sufficient.
+ */
+int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
+				u64 dmap_start)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/*
+	 * If process is blocked waiting for memory while holding inode
+	 * lock, we will deadlock. So continue to free next range.
+	 */
+	if (!inode_trylock(inode))
+		return -EAGAIN;
+	down_write(&fi->i_mmap_sem);
+	down_write(&fi->i_dmap_sem);
+	ret = fuse_dax_free_one_mapping_locked(fc, inode, dmap_start);
+	up_write(&fi->i_dmap_sem);
+	up_write(&fi->i_mmap_sem);
+	inode_unlock(inode);
+	return ret;
+}
+
+int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
+{
+	struct fuse_dax_mapping *dmap, *pos, *temp;
+	int ret, nr_freed = 0;
+	u64 dmap_start = 0, window_offset = 0;
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
+		list_for_each_entry_safe(pos, temp, &fc->busy_ranges,
+						busy_list) {
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
+			window_offset = dmap->window_offset;
+			break;
+		}
+		spin_unlock(&fc->lock);
+		if (!dmap)
+			return 0;
+
+		ret = fuse_dax_free_one_mapping(fc, inode, dmap_start);
+		iput(inode);
+		if (ret && ret != -EAGAIN) {
+			printk("%s(window_offset=0x%llx) failed. err=%d\n",
+				__func__, window_offset, ret);
+			return ret;
+		}
+
+		/* Could not get inode lock. Try next element */
+		if (ret == -EAGAIN)
+			continue;
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
+	pr_debug("fuse: Worker to free memory called.\n");
+	pr_debug("fuse: Worker to free memory called. nr_free_ranges=%lu"
+		 " nr_busy_ranges=%lu\n", fc->nr_free_ranges,
+		 fc->nr_busy_ranges);
+	ret = fuse_dax_free_memory(fc, FUSE_DAX_RECLAIM_CHUNK);
+	if (ret)
+		pr_debug("fuse: fuse_dax_free_memory() failed with err=%d\n", ret);
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c93e9155b723..b4a5728444bb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -50,6 +50,16 @@
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
 
@@ -103,6 +113,9 @@ struct fuse_forget_link {
 
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Pointer to inode where this memory range is mapped */
+	struct inode *inode;
+
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
 
@@ -880,12 +893,20 @@ struct fuse_conn {
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
@@ -1260,6 +1281,7 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_removemapping(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f57f7ce02acc..8af7f31c6e19 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -678,6 +678,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 
 	list_replace_init(&mem_ranges, &fc->free_ranges);
 	fc->nr_free_ranges = nr_ranges;
+	fc->nr_ranges = nr_ranges;
 	return 0;
 out_err:
 	/* Free All allocated elements */
@@ -704,6 +705,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
+	init_waitqueue_head(&fc->dax_range_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
@@ -724,6 +726,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
 	INIT_LIST_HEAD(&fc->busy_ranges);
+	INIT_DELAYED_WORK(&fc->dax_free_work, fuse_dax_free_mem_worker);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -732,6 +735,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		flush_delayed_work(&fc->dax_free_work);
 		if (fc->dax_dev)
 			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		put_pid_ns(fc->pid_ns);
-- 
2.20.1

