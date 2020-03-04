Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11107179606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgCDQ76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729989AbgCDQ7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xp1VA4ipR2eo6LQlFmgV8Czte53teZ2GPcnj82h9CaY=;
        b=BUNsTeKwdcMGzsRZXDy7HzwPm8nhNZiWCN1PnHixbL1xnrtD6MS7XQzVbaHLIKgjpayle+
        23c/FkxxFHKzxihezMz3abQZksX2VYnfWF69L0M5Eb2fBm1D72AV+wel2U45XqvmAsdllH
        9X/cef4K6BhzRZMkfo11D8eT7v9dYBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111--hjy_1sOM-aW1-pCu2Jr-A-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: -hjy_1sOM-aW1-pCu2Jr-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CFD6DB66;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 550D648;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 93E1222581A; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Date:   Wed,  4 Mar 2020 11:58:45 -0500
Message-Id: <20200304165845.3081-21-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
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
 fs/fuse/file.c   | 450 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h |  25 +++
 fs/fuse/inode.c  |   5 +
 3 files changed, 473 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8b264fcb9b3c..61ae2ddeef55 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -8,6 +8,7 @@
=20
 #include "fuse_i.h"
=20
+#include <linux/delay.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -37,6 +38,8 @@ static struct page **fuse_pages_alloc(unsigned int npag=
es, gfp_t flags,
 	return pages;
 }
=20
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_co=
nn *fc,
+				struct inode *inode, bool fault);
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file =
*file,
 			  int opcode, struct fuse_open_out *outargp)
 {
@@ -193,6 +196,28 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
=20
+static void
+__kick_dmap_free_worker(struct fuse_conn *fc, unsigned long delay_ms)
+{
+	unsigned long free_threshold;
+
+	/* If number of free ranges are below threshold, start reclaim */
+	free_threshold =3D max((fc->nr_ranges * FUSE_DAX_RECLAIM_THRESHOLD)/100=
,
+				(unsigned long)1);
+	if (fc->nr_free_ranges < free_threshold) {
+		pr_debug("fuse: Kicking dax memory reclaim worker. nr_free_ranges=3D0x=
%ld nr_total_ranges=3D%ld\n", fc->nr_free_ranges, fc->nr_ranges);
+		queue_delayed_work(system_long_wq, &fc->dax_free_work,
+				   msecs_to_jiffies(delay_ms));
+	}
+}
+
+static void kick_dmap_free_worker(struct fuse_conn *fc, unsigned long de=
lay_ms)
+{
+	spin_lock(&fc->lock);
+	__kick_dmap_free_worker(fc, delay_ms);
+	spin_unlock(&fc->lock);
+}
+
 static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 {
 	struct fuse_dax_mapping *dmap =3D NULL;
@@ -201,7 +226,7 @@ static struct fuse_dax_mapping *alloc_dax_mapping(str=
uct fuse_conn *fc)
=20
 	if (fc->nr_free_ranges <=3D 0) {
 		spin_unlock(&fc->lock);
-		return NULL;
+		goto out_kick;
 	}
=20
 	WARN_ON(list_empty(&fc->free_ranges));
@@ -212,6 +237,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(str=
uct fuse_conn *fc)
 	list_del_init(&dmap->list);
 	fc->nr_free_ranges--;
 	spin_unlock(&fc->lock);
+
+out_kick:
+	kick_dmap_free_worker(fc, 0);
 	return dmap;
 }
=20
@@ -238,6 +266,7 @@ static void __dmap_add_to_free_pool(struct fuse_conn =
*fc,
 {
 	list_add_tail(&dmap->list, &fc->free_ranges);
 	fc->nr_free_ranges++;
+	wake_up(&fc->dax_range_waitq);
 }
=20
 static void dmap_add_to_free_pool(struct fuse_conn *fc,
@@ -289,6 +318,12 @@ static int fuse_setup_one_mapping(struct inode *inod=
e, loff_t offset,
=20
 	dmap->writable =3D writable;
 	if (!upgrade) {
+		/*
+		 * We don't take a refernce on inode. inode is valid right now
+		 * and when inode is going away, cleanup logic should first
+		 * cleanup dmap entries.
+		 */
+		dmap->inode =3D inode;
 		dmap->start =3D offset;
 		dmap->end =3D offset + FUSE_DAX_MEM_RANGE_SZ - 1;
 		/* Protected by fi->i_dmap_sem */
@@ -368,6 +403,7 @@ static void dmap_reinit_add_to_free_pool(struct fuse_=
conn *fc,
 		 "window_offset=3D0x%llx length=3D0x%llx\n", dmap->start,
 		 dmap->end, dmap->window_offset, dmap->length);
 	__dmap_remove_busy_list(fc, dmap);
+	dmap->inode =3D NULL;
 	dmap->start =3D dmap->end =3D 0;
 	__dmap_add_to_free_pool(fc, dmap);
 }
@@ -386,7 +422,8 @@ static void inode_reclaim_dmap_range(struct fuse_conn=
 *fc, struct inode *inode,
 	int err, num =3D 0;
 	LIST_HEAD(to_remove);
=20
-	pr_debug("fuse: %s: start=3D0x%llx, end=3D0x%llx\n", __func__, start, e=
nd);
+	pr_debug("fuse: %s: inode=3D0x%px start=3D0x%llx, end=3D0x%llx\n", __fu=
nc__,
+		 inode, start, end);
=20
 	/*
 	 * Interval tree search matches intersecting entries. Adjust the range
@@ -400,6 +437,8 @@ static void inode_reclaim_dmap_range(struct fuse_conn=
 *fc, struct inode *inode,
 							 end);
 		if (!dmap)
 			break;
+		/* inode is going away. There should not be any users of dmap */
+		WARN_ON(refcount_read(&dmap->refcnt) > 1);
 		fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
 		num++;
 		list_add(&dmap->list, &to_remove);
@@ -434,6 +473,21 @@ static void inode_reclaim_dmap_range(struct fuse_con=
n *fc, struct inode *inode,
 	spin_unlock(&fc->lock);
 }
=20
+static int dmap_removemapping_one(struct inode *inode,
+				  struct fuse_dax_mapping *dmap)
+{
+	struct fuse_removemapping_one forget_one;
+	struct fuse_removemapping_in inarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.count =3D 1;
+	memset(&forget_one, 0, sizeof(forget_one));
+	forget_one.moffset =3D dmap->window_offset;
+	forget_one.len =3D dmap->length;
+
+	return fuse_send_removemapping(inode, &inarg, &forget_one);
+}
+
 /*
  * It is called from evict_inode() and by that time inode is going away.=
 So
  * this function does not take any locks like fi->i_dmap_sem for travers=
ing
@@ -1903,6 +1957,17 @@ static void fuse_fill_iomap(struct inode *inode, l=
off_t pos, loff_t length,
 		if (flags & IOMAP_FAULT)
 			iomap->length =3D ALIGN(len, PAGE_SIZE);
 		iomap->type =3D IOMAP_MAPPED;
+		/*
+		 * increace refcnt so that reclaim code knows this dmap is in
+		 * use. This assumes i_dmap_sem mutex is held either
+		 * shared/exclusive.
+		 */
+		refcount_inc(&dmap->refcnt);
+
+		/* iomap->private should be NULL */
+		WARN_ON_ONCE(iomap->private);
+		iomap->private =3D dmap;
+
 		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
 				" length 0x%llx\n", __func__, iomap->addr,
 				iomap->offset, iomap->length);
@@ -1925,8 +1990,12 @@ static int iomap_begin_setup_new_mapping(struct in=
ode *inode, loff_t pos,
 	int ret;
 	bool writable =3D flags & IOMAP_WRITE;
=20
-	alloc_dmap =3D alloc_dax_mapping(fc);
-	if (!alloc_dmap)
+	alloc_dmap =3D alloc_dax_mapping_reclaim(fc, inode, flags & IOMAP_FAULT=
);
+	if (IS_ERR(alloc_dmap))
+		return PTR_ERR(alloc_dmap);
+
+	/* If we are here, we should have memory allocated */
+	if (WARN_ON(!alloc_dmap))
 		return -EBUSY;
=20
 	/*
@@ -1979,14 +2048,25 @@ static int iomap_begin_upgrade_mapping(struct ino=
de *inode, loff_t pos,
 	dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
=20
 	/* We are holding either inode lock or i_mmap_sem, and that should
-	 * ensure that dmap can't reclaimed or truncated and it should still
-	 * be there in tree despite the fact we dropped and re-acquired the
-	 * lock.
+	 * ensure that dmap can't be truncated. We are holding a reference
+	 * on dmap and that should make sure it can't be reclaimed. So dmap
+	 * should still be there in tree despite the fact we dropped and
+	 * re-acquired the i_dmap_sem lock.
 	 */
 	ret =3D -EIO;
 	if (WARN_ON(!dmap))
 		goto out_err;
=20
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
@@ -2056,7 +2136,11 @@ static int fuse_iomap_begin(struct inode *inode, l=
off_t pos, loff_t length,
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
@@ -2092,6 +2176,16 @@ static int fuse_iomap_end(struct inode *inode, lof=
f_t pos, loff_t length,
 			  ssize_t written, unsigned flags,
 			  struct iomap *iomap)
 {
+	struct fuse_dax_mapping *dmap =3D iomap->private;
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
@@ -4103,3 +4197,345 @@ void fuse_init_file_inode(struct inode *inode)
 		inode->i_data.a_ops =3D &fuse_dax_file_aops;
 	}
 }
+
+static int dmap_writeback_invalidate(struct inode *inode,
+				     struct fuse_dax_mapping *dmap)
+{
+	int ret;
+
+	ret =3D filemap_fdatawrite_range(inode->i_mapping, dmap->start,
+				       dmap->end);
+	if (ret) {
+		printk("filemap_fdatawrite_range() failed. err=3D%d start=3D0x%llx,"
+			" end=3D0x%llx\n", ret, dmap->start, dmap->end);
+		return ret;
+	}
+
+	ret =3D invalidate_inode_pages2_range(inode->i_mapping,
+					    dmap->start >> PAGE_SHIFT,
+					    dmap->end >> PAGE_SHIFT);
+	if (ret)
+		printk("invalidate_inode_pages2_range() failed err=3D%d\n", ret);
+
+	return ret;
+}
+
+static int reclaim_one_dmap_locked(struct fuse_conn *fc, struct inode *i=
node,
+				   struct fuse_dax_mapping *dmap)
+{
+	int ret;
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+
+	/*
+	 * igrab() was done to make sure inode won't go under us, and this
+	 * further avoids the race with evict().
+	 */
+	ret =3D dmap_writeback_invalidate(inode, dmap);
+	if (ret)
+		return ret;
+
+	/* Remove dax mapping from inode interval tree now */
+	fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+	fi->nr_dmaps--;
+
+	/* It is possible that umount/shutodwn has killed the fuse connection
+	 * and worker thread is trying to reclaim memory in parallel. So check
+	 * if connection is still up or not otherwise don't send removemapping
+	 * message.
+	 */
+	if (fc->connected) {
+		ret =3D dmap_removemapping_one(inode, dmap);
+		if (ret) {
+			pr_warn("Failed to remove mapping. offset=3D0x%llx"
+				" len=3D0x%llx ret=3D%d\n", dmap->window_offset,
+				dmap->length, ret);
+		}
+	}
+	return 0;
+}
+
+static void fuse_wait_dax_page(struct inode *inode)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
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
+	page =3D dax_layout_busy_page_range(inode->i_mapping, start, end);
+	if (!page)
+		return 0;
+
+	*retry =3D true;
+	return ___wait_var_event(&page->_refcount,
+			atomic_read(&page->_refcount) =3D=3D 1, TASK_INTERRUPTIBLE,
+			0, 0, fuse_wait_dax_page(inode));
+}
+
+/* dmap_end =3D=3D 0 leads to unmapping of whole file */
+static int fuse_break_dax_layouts(struct inode *inode, u64 dmap_start,
+				  u64 dmap_end)
+{
+	bool	retry;
+	int	ret;
+
+	do {
+		retry =3D false;
+		ret =3D __fuse_break_dax_layouts(inode, &retry, dmap_start,
+					       dmap_end);
+        } while (ret =3D=3D 0 && retry);
+
+        return ret;
+}
+
+/* Find first mapping in the tree and free it. */
+static struct fuse_dax_mapping *
+inode_reclaim_one_dmap_locked(struct fuse_conn *fc, struct inode *inode)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	for (dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0, -1);
+	     dmap;
+	     dmap =3D fuse_dax_interval_tree_iter_next(dmap, 0, -1)) {
+		/* still in use. */
+		if (refcount_read(&dmap->refcnt) > 1)
+			continue;
+
+		ret =3D reclaim_one_dmap_locked(fc, inode, dmap);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		/* Clean up dmap. Do not add back to free list */
+		dmap_remove_busy_list(fc, dmap);
+		dmap->inode =3D NULL;
+		dmap->start =3D dmap->end =3D 0;
+
+		pr_debug("fuse: %s: reclaimed memory range. inode=3D%px,"
+			 " window_offset=3D0x%llx, length=3D0x%llx\n", __func__,
+			 inode, dmap->window_offset, dmap->length);
+		return dmap;
+	}
+
+	return NULL;
+}
+
+/*
+ * Find first mapping in the tree and free it and return it. Do not add
+ * it back to free pool. If fault =3D=3D true, this function should be c=
alled
+ * with fi->i_mmap_sem held.
+ */
+static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn =
*fc,
+							 struct inode *inode,
+							 bool fault)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	if (!fault)
+		down_write(&fi->i_mmap_sem);
+
+	/*
+	 * Make sure there are no references to inode pages using
+	 * get_user_pages()
+	 */
+	ret =3D fuse_break_dax_layouts(inode, 0, 0);
+	if (ret) {
+		printk("virtio_fs: fuse_break_dax_layouts() failed. err=3D%d\n",
+		       ret);
+		dmap =3D ERR_PTR(ret);
+		goto out_mmap_sem;
+	}
+	down_write(&fi->i_dmap_sem);
+	dmap =3D inode_reclaim_one_dmap_locked(fc, inode);
+	up_write(&fi->i_dmap_sem);
+out_mmap_sem:
+	if (!fault)
+		up_write(&fi->i_mmap_sem);
+	return dmap;
+}
+
+/* If fault =3D=3D true, it should be called with fi->i_mmap_sem locked =
*/
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_co=
nn *fc,
+					struct inode *inode, bool fault)
+{
+	struct fuse_dax_mapping *dmap;
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+
+	while(1) {
+		dmap =3D alloc_dax_mapping(fc);
+		if (dmap)
+			return dmap;
+
+		if (fi->nr_dmaps) {
+			dmap =3D inode_reclaim_one_dmap(fc, inode, fault);
+			if (dmap)
+				return dmap;
+			/* If we could not reclaim a mapping because it
+			 * had a reference, that should be a temporary
+			 * situation. Try again.
+			 */
+			msleep(1);
+			continue;
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
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
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
+	ret =3D reclaim_one_dmap_locked(fc, inode, dmap);
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
+ * 2. Take fuse_inode->i_dmap_sem to protect interval tree and also to m=
ake
+ *    sure read/write can not reuse a dmap which we might be freeing.
+ */
+static int lookup_and_reclaim_dmap(struct fuse_conn *fc, struct inode *i=
node,
+				   u64 dmap_start, u64 dmap_end)
+{
+	int ret;
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+
+	down_write(&fi->i_mmap_sem);
+	ret =3D fuse_break_dax_layouts(inode, dmap_start, dmap_end);
+	if (ret) {
+		printk("virtio_fs: fuse_break_dax_layouts() failed. err=3D%d\n",
+		       ret);
+		goto out_mmap_sem;
+	}
+
+	down_write(&fi->i_dmap_sem);
+	ret =3D lookup_and_reclaim_dmap_locked(fc, inode, dmap_start);
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
+	int ret, nr_freed =3D 0;
+	u64 dmap_start =3D 0, window_offset =3D 0, dmap_end =3D 0;
+	struct inode *inode =3D NULL;
+
+	/* Pick first busy range and free it for now*/
+	while(1) {
+		if (nr_freed >=3D nr_to_free)
+			break;
+
+		dmap =3D NULL;
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
+			inode =3D igrab(pos->inode);
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
+			dmap =3D pos;
+			list_move_tail(&dmap->busy_list, &fc->busy_ranges);
+			dmap_start =3D dmap->start;
+			dmap_end =3D dmap->end;
+			window_offset =3D dmap->window_offset;
+			break;
+		}
+		spin_unlock(&fc->lock);
+		if (!dmap)
+			return 0;
+
+		ret =3D lookup_and_reclaim_dmap(fc, inode, dmap_start, dmap_end);
+		iput(inode);
+		if (ret) {
+			printk("%s(window_offset=3D0x%llx) failed. err=3D%d\n",
+				__func__, window_offset, ret);
+			return ret;
+		}
+		nr_freed++;
+	}
+	return 0;
+}
+
+void fuse_dax_free_mem_worker(struct work_struct *work)
+{
+	int ret;
+	struct fuse_conn *fc =3D container_of(work, struct fuse_conn,
+						dax_free_work.work);
+	pr_debug("fuse: Worker to free memory called. nr_free_ranges=3D%lu"
+		 " nr_busy_ranges=3D%lu\n", fc->nr_free_ranges,
+		 fc->nr_busy_ranges);
+
+	ret =3D try_to_free_dmap_chunks(fc, FUSE_DAX_RECLAIM_CHUNK);
+	if (ret) {
+		pr_debug("fuse: try_to_free_dmap_chunks() failed with err=3D%d\n",
+			 ret);
+	}
+
+	/* If number of free ranges are still below threhold, requeue */
+	kick_dmap_free_worker(fc, 1);
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index de213a7e1b0e..41c2fbff0d37 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -54,6 +54,16 @@
 #define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
 #define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
=20
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
=20
@@ -75,6 +85,9 @@ struct fuse_forget_link {
=20
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Pointer to inode where this memory range is mapped */
+	struct inode *inode;
+
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
=20
@@ -97,6 +110,9 @@ struct fuse_dax_mapping {
=20
 	/* Is this mapping read-only or read-write */
 	bool writable;
+
+	/* reference count when the mapping is used by dax iomap. */
+	refcount_t refcnt;
 };
=20
 /** FUSE inode */
@@ -822,11 +838,19 @@ struct fuse_conn {
 	unsigned long nr_busy_ranges;
 	struct list_head busy_ranges;
=20
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
=20
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *=
sb)
@@ -1164,6 +1188,7 @@ unsigned int fuse_len_args(unsigned int numargs, st=
ruct fuse_arg *args);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
+void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_cleanup_inode_mappings(struct inode *inode);
=20
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d4770e7fb7eb..3560b62077a7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -663,11 +663,13 @@ static int fuse_dax_mem_range_init(struct fuse_conn=
 *fc,
 		range->window_offset =3D i * FUSE_DAX_MEM_RANGE_SZ;
 		range->length =3D FUSE_DAX_MEM_RANGE_SZ;
 		INIT_LIST_HEAD(&range->busy_list);
+		refcount_set(&range->refcnt, 1);
 		list_add_tail(&range->list, &mem_ranges);
 	}
=20
 	list_replace_init(&mem_ranges, &fc->free_ranges);
 	fc->nr_free_ranges =3D nr_ranges;
+	fc->nr_ranges =3D nr_ranges;
 	return 0;
 out_err:
 	/* Free All allocated elements */
@@ -692,6 +694,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user=
_namespace *user_ns,
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
+	init_waitqueue_head(&fc->dax_range_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
@@ -711,6 +714,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user=
_namespace *user_ns,
 	fc->max_pages =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
 	INIT_LIST_HEAD(&fc->busy_ranges);
+	INIT_DELAYED_WORK(&fc->dax_free_work, fuse_dax_free_mem_worker);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
=20
@@ -719,6 +723,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		struct fuse_iqueue *fiq =3D &fc->iq;
=20
+		flush_delayed_work(&fc->dax_free_work);
 		if (fc->dax_dev)
 			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		if (fiq->ops->release)
--=20
2.20.1

