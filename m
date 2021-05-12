Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B773737BE8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhELNrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhELNro (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC448B186;
        Wed, 12 May 2021 13:46:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 055701F2B6A; Wed, 12 May 2021 15:46:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/11] fuse: Convert to using invalidate_lock
Date:   Wed, 12 May 2021 15:46:17 +0200
Message-Id: <20210512134631.4053-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512101639.22278-1-jack@suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use invalidate_lock instead of fuse's private i_mmap_sem. The intended
purpose is exactly the same. By this conversion we fix a long standing
race between hole punching and read(2) / readahead(2) paths that can
lead to stale page cache contents.

CC: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fuse/dax.c    | 50 +++++++++++++++++++++++-------------------------
 fs/fuse/dir.c    | 11 ++++++-----
 fs/fuse/file.c   | 10 +++++-----
 fs/fuse/fuse_i.h |  7 -------
 fs/fuse/inode.c  |  1 -
 5 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..03e5477ee913 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -443,12 +443,12 @@ static int fuse_setup_new_dax_mapping(struct inode *inode, loff_t pos,
 	/*
 	 * Can't do inline reclaim in fault path. We call
 	 * dax_layout_busy_page() before we free a range. And
-	 * fuse_wait_dax_page() drops fi->i_mmap_sem lock and requires it.
-	 * In fault path we enter with fi->i_mmap_sem held and can't drop
-	 * it. Also in fault path we hold fi->i_mmap_sem shared and not
-	 * exclusive, so that creates further issues with fuse_wait_dax_page().
-	 * Hence return -EAGAIN and fuse_dax_fault() will wait for a memory
-	 * range to become free and retry.
+	 * fuse_wait_dax_page() drops mapping->invalidate_lock and requires it.
+	 * In fault path we enter with mapping->invalidate_lock held and can't
+	 * drop it. Also in fault path we hold mapping->invalidate_lock shared
+	 * and not exclusive, so that creates further issues with
+	 * fuse_wait_dax_page().  Hence return -EAGAIN and fuse_dax_fault()
+	 * will wait for a memory range to become free and retry.
 	 */
 	if (flags & IOMAP_FAULT) {
 		alloc_dmap = alloc_dax_mapping(fcd);
@@ -512,7 +512,7 @@ static int fuse_upgrade_dax_mapping(struct inode *inode, loff_t pos,
 	down_write(&fi->dax->sem);
 	node = interval_tree_iter_first(&fi->dax->tree, idx, idx);
 
-	/* We are holding either inode lock or i_mmap_sem, and that should
+	/* We are holding either inode lock or invalidate_lock, and that should
 	 * ensure that dmap can't be truncated. We are holding a reference
 	 * on dmap and that should make sure it can't be reclaimed. So dmap
 	 * should still be there in tree despite the fact we dropped and
@@ -659,14 +659,12 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 static void fuse_wait_dax_page(struct inode *inode)
 {
-	struct fuse_inode *fi = get_fuse_inode(inode);
-
-	up_write(&fi->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	schedule();
-	down_write(&fi->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 }
 
-/* Should be called with fi->i_mmap_sem lock held exclusively */
+/* Should be called with mapping->invalidate_lock held exclusively */
 static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 				    loff_t start, loff_t end)
 {
@@ -812,18 +810,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	 * we do not want any read/write/mmap to make progress and try
 	 * to populate page cache or access memory we are trying to free.
 	 */
-	down_read(&get_fuse_inode(inode)->i_mmap_sem);
+	down_read(&inode->i_mapping->invalidate_lock);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, &error, &fuse_iomap_ops);
 	if ((ret & VM_FAULT_ERROR) && error == -EAGAIN) {
 		error = 0;
 		retry = true;
-		up_read(&get_fuse_inode(inode)->i_mmap_sem);
+		up_read(&inode->i_mapping->invalidate_lock);
 		goto retry;
 	}
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
-	up_read(&get_fuse_inode(inode)->i_mmap_sem);
+	up_read(&inode->i_mapping->invalidate_lock);
 
 	if (write)
 		sb_end_pagefault(sb);
@@ -959,7 +957,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
 	int ret;
 	struct interval_tree_node *node;
 
-	down_write(&fi->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 
 	/* Lookup a dmap and corresponding file offset to reclaim. */
 	down_read(&fi->dax->sem);
@@ -1020,7 +1018,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
 out_write_dmap_sem:
 	up_write(&fi->dax->sem);
 out_mmap_sem:
-	up_write(&fi->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	return dmap;
 }
 
@@ -1049,10 +1047,10 @@ alloc_dax_mapping_reclaim(struct fuse_conn_dax *fcd, struct inode *inode)
 		 * had a reference or some other temporary failure,
 		 * Try again. We want to give up inline reclaim only
 		 * if there is no range assigned to this node. Otherwise
-		 * if a deadlock is possible if we sleep with fi->i_mmap_sem
-		 * held and worker to free memory can't make progress due
-		 * to unavailability of fi->i_mmap_sem lock. So sleep
-		 * only if fi->dax->nr=0
+		 * if a deadlock is possible if we sleep with
+		 * mapping->invalidate_lock held and worker to free memory
+		 * can't make progress due to unavailability of
+		 * mapping->invalidate_lock.  So sleep only if fi->dax->nr=0
 		 */
 		if (retry)
 			continue;
@@ -1060,8 +1058,8 @@ alloc_dax_mapping_reclaim(struct fuse_conn_dax *fcd, struct inode *inode)
 		 * There are no mappings which can be reclaimed. Wait for one.
 		 * We are not holding fi->dax->sem. So it is possible
 		 * that range gets added now. But as we are not holding
-		 * fi->i_mmap_sem, worker should still be able to free up
-		 * a range and wake us up.
+		 * mapping->invalidate_lock, worker should still be able to
+		 * free up a range and wake us up.
 		 */
 		if (!fi->dax->nr && !(fcd->nr_free_ranges > 0)) {
 			if (wait_event_killable_exclusive(fcd->range_waitq,
@@ -1107,7 +1105,7 @@ static int lookup_and_reclaim_dmap_locked(struct fuse_conn_dax *fcd,
 /*
  * Free a range of memory.
  * Locking:
- * 1. Take fi->i_mmap_sem to block dax faults.
+ * 1. Take mapping->invalidate_lock to block dax faults.
  * 2. Take fi->dax->sem to protect interval tree and also to make sure
  *    read/write can not reuse a dmap which we might be freeing.
  */
@@ -1121,7 +1119,7 @@ static int lookup_and_reclaim_dmap(struct fuse_conn_dax *fcd,
 	loff_t dmap_start = start_idx << FUSE_DAX_SHIFT;
 	loff_t dmap_end = (dmap_start + FUSE_DAX_SZ) - 1;
 
-	down_write(&fi->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 	ret = fuse_dax_break_layouts(inode, dmap_start, dmap_end);
 	if (ret) {
 		pr_debug("virtio_fs: fuse_dax_break_layouts() failed. err=%d\n",
@@ -1133,7 +1131,7 @@ static int lookup_and_reclaim_dmap(struct fuse_conn_dax *fcd,
 	ret = lookup_and_reclaim_dmap_locked(fcd, inode, start_idx);
 	up_write(&fi->dax->sem);
 out_mmap_sem:
-	up_write(&fi->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	return ret;
 }
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..0ab27170da11 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1601,6 +1601,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct address_space *mapping = inode->i_mapping;
 	FUSE_ARGS(args);
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
@@ -1625,11 +1626,11 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	}
 
 	if (FUSE_IS_DAX(inode) && is_truncate) {
-		down_write(&fi->i_mmap_sem);
+		down_write(&mapping->invalidate_lock);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, 0);
 		if (err) {
-			up_write(&fi->i_mmap_sem);
+			up_write(&mapping->invalidate_lock);
 			return err;
 		}
 	}
@@ -1739,13 +1740,13 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
 		truncate_pagecache(inode, outarg.attr.size);
-		invalidate_inode_pages2(inode->i_mapping);
+		invalidate_inode_pages2(mapping);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 out:
 	if (fault_blocked)
-		up_write(&fi->i_mmap_sem);
+		up_write(&mapping->invalidate_lock);
 
 	return 0;
 
@@ -1756,7 +1757,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
 	if (fault_blocked)
-		up_write(&fi->i_mmap_sem);
+		up_write(&mapping->invalidate_lock);
 	return err;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4d25ed..22be837169a7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -243,7 +243,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	}
 
 	if (dax_truncate) {
-		down_write(&get_fuse_inode(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping->invalidate_lock);
 		err = fuse_dax_break_layouts(inode, 0, 0);
 		if (err)
 			goto out;
@@ -255,7 +255,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 
 out:
 	if (dax_truncate)
-		up_write(&get_fuse_inode(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping->invalidate_lock);
 
 	if (is_wb_truncate | dax_truncate) {
 		fuse_release_nowrite(inode);
@@ -2920,7 +2920,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (lock_inode) {
 		inode_lock(inode);
 		if (block_faults) {
-			down_write(&fi->i_mmap_sem);
+			down_write(&inode->i_mapping->invalidate_lock);
 			err = fuse_dax_break_layouts(inode, 0, 0);
 			if (err)
 				goto out;
@@ -2976,7 +2976,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
 	if (block_faults)
-		up_write(&fi->i_mmap_sem);
+		up_write(&inode->i_mapping->invalidate_lock);
 
 	if (lock_inode)
 		inode_unlock(inode);
@@ -3045,7 +3045,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * modifications.  Yet this does give less guarantees than if the
 	 * copying was performed with write(2).
 	 *
-	 * To fix this a i_mmap_sem style lock could be used to prevent new
+	 * To fix this a mapping->invalidate_lock could be used to prevent new
 	 * faults while the copy is ongoing.
 	 */
 	err = fuse_writeback_range(inode_out, pos_out, pos_out + len - 1);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..5130e88f811e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -149,13 +149,6 @@ struct fuse_inode {
 	/** Lock to protect write related fields */
 	spinlock_t lock;
 
-	/**
-	 * Can't take inode lock in fault path (leads to circular dependency).
-	 * Introduce another semaphore which can be taken in fault path and
-	 * then other filesystem paths can take this to block faults.
-	 */
-	struct rw_semaphore i_mmap_sem;
-
 #ifdef CONFIG_FUSE_DAX
 	/*
 	 * Dax specific inode data
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..f73bab71a0a0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -85,7 +85,6 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->orig_ino = 0;
 	fi->state = 0;
 	mutex_init(&fi->mutex);
-	init_rwsem(&fi->i_mmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
-- 
2.26.2

