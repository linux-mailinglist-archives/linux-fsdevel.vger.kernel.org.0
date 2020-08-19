Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211E124A934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHSWWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:22:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727897AbgHSWVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ES7VXWnJmxtNjv1SU4EOUCl97libFKKT2+jZq3jVEXw=;
        b=PaRBMgoYb/h45oyLOZNeP6hSYHwycf5qSoY+fTbPjAX4npQ6RjCxHC5Yq9MkyADDKyltYY
        22xyEPvHp1KP2XWteBwJrI6oCaVRMmsHNtdBtxV4vVTxpeGUMdiIQNyECXVjm+ohrCZ2pc
        RTum3NqgDS0nmozliKcC9KxgIfClrxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-P3FaIpgoPSSevl-zTmxCwA-1; Wed, 19 Aug 2020 18:21:05 -0400
X-MC-Unique: P3FaIpgoPSSevl-zTmxCwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B6451007471;
        Wed, 19 Aug 2020 22:21:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29437756D4;
        Wed, 19 Aug 2020 22:21:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 38BB62256EE; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v3 16/18] fuse, dax: Serialize truncate/punch_hole and dax fault path
Date:   Wed, 19 Aug 2020 18:19:54 -0400
Message-Id: <20200819221956.845195-17-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently in fuse we don't seem have any lock which can serialize fault
path with truncate/punch_hole path. With dax support I need one for
following reasons.

1. Dax requirement

  DAX fault code relies on inode size being stable for the duration of
  fault and want to serialize with truncate/punch_hole and they explicitly
  mention it.

  static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
                               const struct iomap_ops *ops)
        /*
         * Check whether offset isn't beyond end of file now. Caller is
         * supposed to hold locks serializing us with truncate / punch hole so
         * this is a reliable test.
         */
        max_pgoff = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);

2. Make sure there are no users of pages being truncated/punch_hole

  get_user_pages() might take references to page and then do some DMA
  to said pages. Filesystem might truncate those pages without knowing
  that a DMA is in progress or some I/O is in progress. So use
  dax_layout_busy_page() to make sure there are no such references
  and I/O is not in progress on said pages before moving ahead with
  truncation.

3. Limitation of kvm page fault error reporting

  If we are truncating file on host first and then removing mappings in
  guest lateter (truncate page cache etc), then this could lead to a
  problem with KVM. Say a mapping is in place in guest and truncation
  happens on host. Now if guest accesses that mapping, then host will
  take a fault and kvm will either exit to qemu or spin infinitely.

  IOW, before we do truncation on host, we need to make sure that guest
  inode does not have any mapping in that region or whole file.

4. virtiofs memory range reclaim

 Soon I will introduce the notion of being able to reclaim dax memory
 ranges from a fuse dax inode. There also I need to make sure that
 no I/O or fault is going on in the reclaimed range and nobody is using
 it so that range can be reclaimed without issues.

Currently if we take inode lock, that serializes read/write. But it does
not do anything for faults. So I add another semaphore fuse_inode->i_mmap_sem
for this purpose.  It can be used to serialize with faults.

As of now, I am adding taking this semaphore only in dax fault path and
not regular fault path because existing code does not have one. May
be existing code can benefit from it as well to take care of some
races, but that we can fix later if need be. For now, I am just focussing
only on DAX path which is new path.

Also added logic to take fuse_inode->i_mmap_sem in
truncate/punch_hole/open(O_TRUNC) path to make sure file truncation and
fuse dax fault are mutually exlusive and avoid all the above problems.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
---
 fs/fuse/dir.c    | 32 ++++++++++++++-----
 fs/fuse/file.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h |  9 ++++++
 fs/fuse/inode.c  |  1 +
 4 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..4c7e29ba7c4c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1501,6 +1501,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb && S_ISREG(inode->i_mode);
+	bool fault_blocked = false;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -1509,6 +1510,22 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (err)
 		return err;
 
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (WARN_ON(!S_ISREG(inode->i_mode)))
+			return -EIO;
+		is_truncate = true;
+	}
+
+	if (IS_DAX(inode) && is_truncate) {
+		down_write(&fi->i_mmap_sem);
+		fault_blocked = true;
+		err = fuse_break_dax_layouts(inode, 0, 0);
+		if (err) {
+			up_write(&fi->i_mmap_sem);
+			return err;
+		}
+	}
+
 	if (attr->ia_valid & ATTR_OPEN) {
 		/* This is coming from open(..., ... | O_TRUNC); */
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
@@ -1521,17 +1538,11 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 			 */
 			i_size_write(inode, 0);
 			truncate_pagecache(inode, 0);
-			return 0;
+			goto out;
 		}
 		file = NULL;
 	}
 
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (WARN_ON(!S_ISREG(inode->i_mode)))
-			return -EIO;
-		is_truncate = true;
-	}
-
 	/* Flush dirty data/metadata before non-truncate SETATTR */
 	if (is_wb && S_ISREG(inode->i_mode) &&
 	    attr->ia_valid &
@@ -1614,6 +1625,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+out:
+	if (fault_blocked)
+		up_write(&fi->i_mmap_sem);
+
 	return 0;
 
 error:
@@ -1621,6 +1636,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		fuse_release_nowrite(inode);
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+	if (fault_blocked)
+		up_write(&fi->i_mmap_sem);
 	return err;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0eecb4097c14..aaa57c625af7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -445,23 +445,35 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
+			  (fc->writeback_cache);
+	bool dax_truncate = (file->f_flags & O_TRUNC) &&
+			  fc->atomic_o_trunc && IS_DAX(inode);
 
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
 
-	if (is_wb_truncate) {
+	if (is_wb_truncate || dax_truncate) {
 		inode_lock(inode);
 		fuse_set_nowrite(inode);
 	}
 
-	err = fuse_do_open(fc, get_node_id(inode), file, isdir);
+	if (dax_truncate) {
+		down_write(&get_fuse_inode(inode)->i_mmap_sem);
+		err = fuse_break_dax_layouts(inode, 0, 0);
+		if (err)
+			goto out;
+	}
 
+	err = fuse_do_open(fc, get_node_id(inode), file, isdir);
 	if (!err)
 		fuse_finish_open(inode, file);
 
-	if (is_wb_truncate) {
+out:
+	if (dax_truncate)
+		up_write(&get_fuse_inode(inode)->i_mmap_sem);
+
+	if (is_wb_truncate | dax_truncate) {
 		fuse_release_nowrite(inode);
 		inode_unlock(inode);
 	}
@@ -2011,6 +2023,47 @@ static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_end = fuse_iomap_end,
 };
 
+static void fuse_wait_dax_page(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	up_write(&fi->i_mmap_sem);
+	schedule();
+	down_write(&fi->i_mmap_sem);
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
+int fuse_break_dax_layouts(struct inode *inode, u64 dmap_start,
+				  u64 dmap_end)
+{
+	bool	retry;
+	int	ret;
+
+	do {
+		retry = false;
+		ret = __fuse_break_dax_layouts(inode, &retry, dmap_start,
+					       dmap_end);
+	} while (ret == 0 && retry);
+
+	return ret;
+}
+
 static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -2889,10 +2942,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	if (write)
 		sb_start_pagefault(sb);
 
+	/*
+	 * We need to serialize against not only truncate but also against
+	 * fuse dax memory range reclaim. While a range is being reclaimed,
+	 * we do not want any read/write/mmap to make progress and try
+	 * to populate page cache or access memory we are trying to free.
+	 */
+	down_read(&get_fuse_inode(inode)->i_mmap_sem);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
 
 	if (write)
 		sb_end_pagefault(sb);
@@ -3811,6 +3872,8 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
 			   (mode & FALLOC_FL_PUNCH_HOLE);
 
+	bool block_faults = IS_DAX(inode) && lock_inode;
+
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
@@ -3819,6 +3882,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (lock_inode) {
 		inode_lock(inode);
+		if (block_faults) {
+			down_write(&fi->i_mmap_sem);
+			err = fuse_break_dax_layouts(inode, 0, 0);
+			if (err)
+				goto out;
+		}
+
 		if (mode & FALLOC_FL_PUNCH_HOLE) {
 			loff_t endbyte = offset + length - 1;
 
@@ -3868,6 +3938,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+	if (block_faults)
+		up_write(&fi->i_mmap_sem);
+
 	if (lock_inode)
 		inode_unlock(inode);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 22fb01ba55fb..e555c9a33359 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -176,6 +176,13 @@ struct fuse_inode {
 	/** Lock to protect write related fields */
 	spinlock_t lock;
 
+	/**
+	 * Can't take inode lock in fault path (leads to circular dependency).
+	 * Introduce another semaphore which can be taken in fault path and
+	 * then other filesystem paths can take this to block faults.
+	 */
+	struct rw_semaphore i_mmap_sem;
+
 	/*
 	 * Semaphore to protect modifications to dmap_tree
 	 */
@@ -1158,4 +1165,6 @@ node_to_dmap(struct interval_tree_node *node)
 	return container_of(node, struct fuse_dax_mapping, itn);
 }
 
+int fuse_break_dax_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8ea2d3ebcb36..3735bc5fdfa2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -88,6 +88,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.25.4

