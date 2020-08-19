Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3024A920
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHSWV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:21:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727808AbgHSWVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcgTBFosTbhNKFFZzbdc/W9WoRGYzP/Gict1sblj9Qo=;
        b=it4/mXdZ4Jd4eVNruW4Wyp6l6ujA8WiFDwC/4WxFc/mYL22nS+XRreGyGGilLvfrhzSf0k
        4HNLfndmHu5hMZ2W4cn/s6lCpBMpSEEl4bpRgBtGd0rMx2oFLOgXnUjR2gPA7jfGFXfTAs
        SWkEM2WY4h8KaaaZVJEyQ7AU5jag88k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-pZ_okPj5P1WaY5coPG9MnA-1; Wed, 19 Aug 2020 18:21:09 -0400
X-MC-Unique: pZ_okPj5P1WaY5coPG9MnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 267C98030A3;
        Wed, 19 Aug 2020 22:21:08 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2AC7C0B9;
        Wed, 19 Aug 2020 22:21:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4D49E2256F0; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH v3 18/18] fuse,virtiofs: Add logic to free up a memory range
Date:   Wed, 19 Aug 2020 18:19:56 -0400
Message-Id: <20200819221956.845195-19-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add logic to free up a busy memory range. Freed memory range will be
returned to free pool. Add a worker which can be started to select
and free some busy memory ranges.

Process can also steal one of its busy dax ranges if free range is not
available. I will refer it to as direct reclaim.

If free range is not available and nothing can't be stolen from same
inode, caller waits on a waitq for free range to become available.

For reclaiming a range, as of now we need to hold following locks in
specified order.

	down_write(&fi->i_mmap_sem);
	down_write(&fi->i_dmap_sem);

We look for a free range in following order.

A. Try to get a free range.
B. If not, try direct reclaim.
C. If not, wait for a memory range to become free

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/file.c      | 482 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h    |  25 +++
 fs/fuse/inode.c     |   4 +
 fs/fuse/virtio_fs.c |   5 +
 4 files changed, 508 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 723602813ad6..12c4716fc1e5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/delay.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -35,6 +36,8 @@ static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 	return pages;
 }
 
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
+							struct inode *inode);
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
 {
@@ -191,6 +194,26 @@ static void fuse_link_write_file(struct file *file)
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
+	if (fc->nr_free_ranges < free_threshold)
+		queue_delayed_work(system_long_wq, &fc->dax_free_work,
+				   msecs_to_jiffies(delay_ms));
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
@@ -199,7 +222,7 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 
 	if (fc->nr_free_ranges <= 0) {
 		spin_unlock(&fc->lock);
-		return NULL;
+		goto out_kick;
 	}
 
 	WARN_ON(list_empty(&fc->free_ranges));
@@ -210,6 +233,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	list_del_init(&dmap->list);
 	fc->nr_free_ranges--;
 	spin_unlock(&fc->lock);
+
+out_kick:
+	kick_dmap_free_worker(fc, 0);
 	return dmap;
 }
 
@@ -236,6 +262,7 @@ static void __dmap_add_to_free_pool(struct fuse_conn *fc,
 {
 	list_add_tail(&dmap->list, &fc->free_ranges);
 	fc->nr_free_ranges++;
+	wake_up(&fc->dax_range_waitq);
 }
 
 static void dmap_add_to_free_pool(struct fuse_conn *fc,
@@ -279,6 +306,12 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 		return err;
 	dmap->writable = writable;
 	if (!upgrade) {
+		/*
+		 * We don't take a refernce on inode. inode is valid right now
+		 * and when inode is going away, cleanup logic should first
+		 * cleanup dmap entries.
+		 */
+		dmap->inode = inode;
 		dmap->itn.start = dmap->itn.last = start_idx;
 		/* Protected by fi->i_dmap_sem */
 		interval_tree_insert(&dmap->itn, &fi->dmap_tree);
@@ -357,6 +390,7 @@ static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
 		 "window_offset=0x%llx length=0x%llx\n", dmap->itn.start,
 		 dmap->itn.last, dmap->window_offset, dmap->length);
 	__dmap_remove_busy_list(fc, dmap);
+	dmap->inode = NULL;
 	dmap->itn.start = dmap->itn.last = 0;
 	__dmap_add_to_free_pool(fc, dmap);
 }
@@ -384,6 +418,8 @@ static void inode_reclaim_dmap_range(struct fuse_conn *fc, struct inode *inode,
 		if (!node)
 			break;
 		dmap = node_to_dmap(node);
+		/* inode is going away. There should not be any users of dmap */
+		WARN_ON(refcount_read(&dmap->refcnt) > 1);
 		interval_tree_remove(&dmap->itn, &fi->dmap_tree);
 		num++;
 		list_add(&dmap->list, &to_remove);
@@ -418,6 +454,21 @@ static void inode_reclaim_dmap_range(struct fuse_conn *fc, struct inode *inode,
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
@@ -1859,6 +1910,16 @@ static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t length,
 		if (flags & IOMAP_FAULT)
 			iomap->length = ALIGN(len, PAGE_SIZE);
 		iomap->type = IOMAP_MAPPED;
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
 	} else {
 		/* Mapping beyond end of file is hole */
 		fuse_fill_iomap_hole(iomap, length);
@@ -1877,8 +1938,28 @@ static int fuse_setup_new_dax_mapping(struct inode *inode, loff_t pos,
 	unsigned long start_idx = pos >> FUSE_DAX_SHIFT;
 	struct interval_tree_node *node;
 
-	alloc_dmap = alloc_dax_mapping(fc);
-	if (!alloc_dmap)
+	/*
+	 * Can't do inline reclaim in fault path. We call
+	 * dax_layout_busy_page() before we free a range. And
+	 * fuse_wait_dax_page() drops fi->i_mmap_sem lock and requires it.
+	 * In fault path we enter with fi->i_mmap_sem held and can't drop
+	 * it. Also in fault path we hold fi->i_mmap_sem shared and not
+	 * exclusive, so that creates further issues with fuse_wait_dax_page().
+	 * Hence return -EAGAIN and fuse_dax_fault() will wait for a memory
+	 * range to become free and retry.
+	 */
+	if (flags & IOMAP_FAULT) {
+		alloc_dmap = alloc_dax_mapping(fc);
+		if (!alloc_dmap)
+			return -EAGAIN;
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
@@ -1930,16 +2011,26 @@ static int fuse_upgrade_dax_mapping(struct inode *inode, loff_t pos,
 	node = interval_tree_iter_first(&fi->dmap_tree, idx, idx);
 
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
 	if (WARN_ON(!node))
 		goto out_err;
-
 	dmap = node_to_dmap(node);
 
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
@@ -1998,7 +2089,11 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
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
@@ -2034,6 +2129,16 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
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
@@ -2960,9 +3065,15 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
 	pfn_t pfn;
+	int error = 0;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool retry = false;
 
 	if (write)
 		sb_start_pagefault(sb);
+retry:
+	if (retry && !(fc->nr_free_ranges > 0))
+		wait_event(fc->dax_range_waitq, (fc->nr_free_ranges > 0));
 
 	/*
 	 * We need to serialize against not only truncate but also against
@@ -2971,7 +3082,13 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	 * to populate page cache or access memory we are trying to free.
 	 */
 	down_read(&get_fuse_inode(inode)->i_mmap_sem);
-	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, &error, &fuse_iomap_ops);
+	if ((ret & VM_FAULT_ERROR) && error == -EAGAIN) {
+		error = 0;
+		retry = true;
+		up_read(&get_fuse_inode(inode)->i_mmap_sem);
+		goto retry;
+	}
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
@@ -4153,3 +4270,352 @@ void fuse_init_file_inode(struct inode *inode)
 		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
+
+static int dmap_writeback_invalidate(struct inode *inode,
+				     struct fuse_dax_mapping *dmap)
+{
+	int ret;
+	loff_t start_pos = dmap->itn.start << FUSE_DAX_SHIFT;
+	loff_t end_pos = (start_pos + FUSE_DAX_SZ - 1);
+
+	ret = filemap_fdatawrite_range(inode->i_mapping, start_pos, end_pos);
+	if (ret) {
+		pr_debug("fuse: filemap_fdatawrite_range() failed. err=%d"
+			 " start_pos=0x%llx, end_pos=0x%llx\n", ret, start_pos,
+			 end_pos);
+		return ret;
+	}
+
+	ret = invalidate_inode_pages2_range(inode->i_mapping,
+					    start_pos >> PAGE_SHIFT,
+					    end_pos >> PAGE_SHIFT);
+	if (ret)
+		pr_debug("fuse: invalidate_inode_pages2_range() failed err=%d\n"
+			 , ret);
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
+	if (ret)
+		return ret;
+
+	/* Remove dax mapping from inode interval tree now */
+	interval_tree_remove(&dmap->itn, &fi->dmap_tree);
+	fi->nr_dmaps--;
+
+	/* It is possible that umount/shutodwn has killed the fuse connection
+	 * and worker thread is trying to reclaim memory in parallel. So check
+	 * if connection is still up or not otherwise don't send removemapping
+	 * message.
+	 */
+	if (fc->connected) {
+		ret = dmap_removemapping_one(inode, dmap);
+		if (ret) {
+			pr_warn("Failed to remove mapping. offset=0x%llx"
+				" len=0x%llx ret=%d\n", dmap->window_offset,
+				dmap->length, ret);
+		}
+	}
+	return 0;
+}
+
+/* Find first mapped dmap for an inode and return file offset. Caller needs
+ * to hold inode->i_dmap_sem lock either shared or exclusive. */
+static struct fuse_dax_mapping *inode_lookup_first_dmap(struct fuse_conn *fc,
+							struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	struct interval_tree_node *node;
+
+	for (node = interval_tree_iter_first(&fi->dmap_tree, 0, -1); node;
+	     node = interval_tree_iter_next(node, 0, -1)) {
+		dmap = node_to_dmap(node);
+		/* still in use. */
+		if (refcount_read(&dmap->refcnt) > 1)
+			continue;
+
+		return dmap;
+	}
+
+	return NULL;
+}
+
+/*
+ * Find first mapping in the tree and free it and return it. Do not add
+ * it back to free pool.
+ */
+static struct fuse_dax_mapping *
+inode_inline_reclaim_one_dmap(struct fuse_conn *fc, struct inode *inode,
+			      bool *retry)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	u64 dmap_start, dmap_end;
+	unsigned long start_idx;
+	int ret;
+	struct interval_tree_node *node;
+
+	down_write(&fi->i_mmap_sem);
+
+	/* Lookup a dmap and corresponding file offset to reclaim. */
+	down_read(&fi->i_dmap_sem);
+	dmap = inode_lookup_first_dmap(fc, inode);
+	if (dmap) {
+		start_idx = dmap->itn.start;
+		dmap_start = start_idx << FUSE_DAX_SHIFT;
+		dmap_end = dmap_start + FUSE_DAX_SZ - 1;
+	}
+	up_read(&fi->i_dmap_sem);
+
+	if (!dmap)
+		goto out_mmap_sem;
+	/*
+	 * Make sure there are no references to inode pages using
+	 * get_user_pages()
+	 */
+	ret = fuse_break_dax_layouts(inode, dmap_start, dmap_end);
+	if (ret) {
+		pr_debug("fuse: fuse_break_dax_layouts() failed. err=%d\n",
+			 ret);
+		dmap = ERR_PTR(ret);
+		goto out_mmap_sem;
+	}
+
+	down_write(&fi->i_dmap_sem);
+	node = interval_tree_iter_first(&fi->dmap_tree, start_idx, start_idx);
+	/* Range already got reclaimed by somebody else */
+	if (!node) {
+		if (retry)
+			*retry = true;
+		goto out_write_dmap_sem;
+	}
+
+	dmap = node_to_dmap(node);
+	/* still in use. */
+	if (refcount_read(&dmap->refcnt) > 1) {
+		dmap = NULL;
+		if (retry)
+			*retry = true;
+		goto out_write_dmap_sem;
+	}
+
+	ret = reclaim_one_dmap_locked(fc, inode, dmap);
+	if (ret < 0) {
+		dmap = ERR_PTR(ret);
+		goto out_write_dmap_sem;
+	}
+
+	/* Clean up dmap. Do not add back to free list */
+	dmap_remove_busy_list(fc, dmap);
+	dmap->inode = NULL;
+	dmap->itn.start = dmap->itn.last = 0;
+
+	pr_debug("fuse: %s: inline reclaimed memory range. inode=%px,"
+		 " window_offset=0x%llx, length=0x%llx\n", __func__,
+		 inode, dmap->window_offset, dmap->length);
+
+out_write_dmap_sem:
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
+	while (1) {
+		bool retry = false;
+
+		dmap = alloc_dax_mapping(fc);
+		if (dmap)
+			return dmap;
+
+		dmap = inode_inline_reclaim_one_dmap(fc, inode, &retry);
+		/*
+		 * Either we got a mapping or it is an error, return in both
+		 * the cases.
+		 */
+		if (dmap)
+			return dmap;
+
+		/* If we could not reclaim a mapping because it
+		 * had a reference or some other temporary failure,
+		 * Try again. We want to give up inline reclaim only
+		 * if there is no range assigned to this node. Otherwise
+		 * if a deadlock is possible if we sleep with fi->i_mmap_sem
+		 * held and worker to free memory can't make progress due
+		 * to unavailability of fi->i_mmap_sem lock. So sleep
+		 * only if fi->nr_dmaps=0
+		 */
+		if (retry)
+			continue;
+		/*
+		 * There are no mappings which can be reclaimed. Wait for one.
+		 * We are not holding fi->i_dmap_sem. So it is possible
+		 * that range gets added now. But as we are not holding
+		 * fi->i_mmap_sem, worker should still be able to free up
+		 * a range and wake us up.
+		 */
+		if (!fi->nr_dmaps && !(fc->nr_free_ranges > 0)) {
+			if (wait_event_killable_exclusive(fc->dax_range_waitq,
+					(fc->nr_free_ranges > 0))) {
+				return ERR_PTR(-EINTR);
+			}
+		}
+	}
+}
+
+static int lookup_and_reclaim_dmap_locked(struct fuse_conn *fc,
+					  struct inode *inode,
+					  unsigned long start_idx)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	struct interval_tree_node *node;
+
+	/* Find fuse dax mapping at file offset inode. */
+	node = interval_tree_iter_first(&fi->dmap_tree, start_idx, start_idx);
+
+	/* Range already got cleaned up by somebody else */
+	if (!node)
+		return 0;
+	dmap = node_to_dmap(node);
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
+				   unsigned long start_idx,
+				   unsigned long end_idx)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t dmap_start = start_idx << FUSE_DAX_SHIFT;
+	loff_t dmap_end = (dmap_start + FUSE_DAX_SZ) - 1;
+
+	down_write(&fi->i_mmap_sem);
+	ret = fuse_break_dax_layouts(inode, dmap_start, dmap_end);
+	if (ret) {
+		pr_debug("virtio_fs: fuse_break_dax_layouts() failed. err=%d\n",
+			 ret);
+		goto out_mmap_sem;
+	}
+
+	down_write(&fi->i_dmap_sem);
+	ret = lookup_and_reclaim_dmap_locked(fc, inode, start_idx);
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
+	unsigned long start_idx = 0, end_idx = 0;
+	u64 window_offset = 0;
+	struct inode *inode = NULL;
+
+	/* Pick first busy range and free it for now*/
+	while (1) {
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
+			 * this element can't be freed, it will help with
+			 * selecting new element in next iteration of loop.
+			 */
+			dmap = pos;
+			list_move_tail(&dmap->busy_list, &fc->busy_ranges);
+			start_idx = end_idx = dmap->itn.start;
+			window_offset = dmap->window_offset;
+			break;
+		}
+		spin_unlock(&fc->lock);
+		if (!dmap)
+			return 0;
+
+		ret = lookup_and_reclaim_dmap(fc, inode, start_idx, end_idx);
+		iput(inode);
+		if (ret)
+			return ret;
+		nr_freed++;
+	}
+	return 0;
+}
+
+void fuse_dax_free_mem_worker(struct work_struct *work)
+{
+	int ret;
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+						dax_free_work.work);
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
index 400a19a464ca..79e8297aacc9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -56,6 +56,16 @@
 #define FUSE_DAX_SHIFT	(21)
 #define FUSE_DAX_PAGES	(FUSE_DAX_SZ/PAGE_SIZE)
 
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
 
@@ -74,6 +84,9 @@ struct fuse_forget_link {
 
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Pointer to inode where this memory range is mapped */
+	struct inode *inode;
+
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
 
@@ -91,6 +104,9 @@ struct fuse_dax_mapping {
 
 	/* Is this mapping read-only or read-write */
 	bool writable;
+
+	/* reference count when the mapping is used by dax iomap. */
+	refcount_t refcnt;
 };
 
 /** FUSE inode */
@@ -819,11 +835,19 @@ struct fuse_conn {
 	unsigned long nr_busy_ranges;
 	struct list_head busy_ranges;
 
+	/* Worker to free up memory ranges */
+	struct delayed_work dax_free_work;
+
+	/* Wait queue for a dax range to become free */
+	wait_queue_head_t dax_range_waitq;
+
 	/*
 	 * DAX Window Free Ranges
 	 */
 	long nr_free_ranges;
 	struct list_head free_ranges;
+
+	unsigned long nr_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1161,6 +1185,7 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
+void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_cleanup_inode_mappings(struct inode *inode);
 
 static inline struct fuse_dax_mapping *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 671e84e3dd99..d2e09fd0a3e6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -683,11 +683,13 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 		range->window_offset = i * FUSE_DAX_SZ;
 		range->length = FUSE_DAX_SZ;
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
@@ -712,6 +714,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
+	init_waitqueue_head(&fc->dax_range_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
@@ -731,6 +734,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
 	INIT_LIST_HEAD(&fc->busy_ranges);
+	INIT_DELAYED_WORK(&fc->dax_free_work, fuse_dax_free_mem_worker);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index fb31c9dbc0b8..07ad697b403c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1345,6 +1345,11 @@ static void virtio_kill_sb(struct super_block *sb)
 	vfs = fc->iq.priv;
 	fsvq = &vfs->vqs[VQ_HIPRIO];
 
+	/* Stop dax worker. Soon evict_inodes() will be called which will
+	 * free all memory ranges belonging to all inodes.
+	 */
+	cancel_delayed_work_sync(&fc->dax_free_work);
+
 	/* Stop forget queue. Soon destroy will be sent */
 	spin_lock(&fsvq->lock);
 	fsvq->connected = false;
-- 
2.25.4

