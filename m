Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4AD1FABB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfEOT3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EE74300C76F;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B855219733;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E8F06225489; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 21/30] fuse, dax: Implement dax read/write operations
Date:   Wed, 15 May 2019 15:27:06 -0400
Message-Id: <20190515192715.18000-22-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements basic DAX support. mmap() is not implemented
yet and will come in later patches. This patch looks into implemeting
read/write.

We make use of interval tree to keep track of per inode dax mappings.

Do not use dax for file extending writes, instead just send WRITE message
to daemon (like we do for direct I/O path). This will keep write and
i_size change atomic w.r.t crash.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/file.c            | 454 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |  21 ++
 fs/fuse/inode.c           |   6 +
 include/uapi/linux/fuse.h |   1 +
 4 files changed, 476 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e9a7aa97c539..edbb11ca735e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,12 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include <linux/interval_tree_generic.h>
+
+INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
+                     START, LAST, static inline, fuse_dax_interval_tree);
 
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
@@ -171,6 +177,173 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
+static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
+{
+	struct fuse_dax_mapping *dmap = NULL;
+
+	spin_lock(&fc->lock);
+
+	/* TODO: Add logic to try to free up memory if wait is allowed */
+	if (fc->nr_free_ranges <= 0) {
+		spin_unlock(&fc->lock);
+		return NULL;
+	}
+
+	WARN_ON(list_empty(&fc->free_ranges));
+
+	/* Take a free range */
+	dmap = list_first_entry(&fc->free_ranges, struct fuse_dax_mapping,
+					list);
+	list_del_init(&dmap->list);
+	fc->nr_free_ranges--;
+	spin_unlock(&fc->lock);
+	return dmap;
+}
+
+/* This assumes fc->lock is held */
+static void __free_dax_mapping(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	list_add_tail(&dmap->list, &fc->free_ranges);
+	fc->nr_free_ranges++;
+}
+
+static void free_dax_mapping(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	/* Return fuse_dax_mapping to free list */
+	spin_lock(&fc->lock);
+	__free_dax_mapping(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
+/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
+static int fuse_setup_one_mapping(struct inode *inode,
+				struct file *file, loff_t offset,
+				struct fuse_dax_mapping *dmap)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_file *ff = NULL;
+	struct fuse_setupmapping_in inarg;
+	FUSE_ARGS(args);
+	ssize_t err;
+
+	if (file)
+		ff = file->private_data;
+
+	WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
+	WARN_ON(fc->nr_free_ranges < 0);
+
+	/* Ask fuse daemon to setup mapping */
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.foffset = offset;
+	if (ff)
+		inarg.fh = ff->fh;
+	else
+		inarg.fh = -1;
+	inarg.moffset = dmap->window_offset;
+	inarg.len = FUSE_DAX_MEM_RANGE_SZ;
+	if (file) {
+		inarg.flags |= (file->f_mode & FMODE_WRITE) ?
+				FUSE_SETUPMAPPING_FLAG_WRITE : 0;
+		inarg.flags |= (file->f_mode & FMODE_READ) ?
+				FUSE_SETUPMAPPING_FLAG_READ : 0;
+	} else {
+		inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
+		inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
+	}
+	args.in.h.opcode = FUSE_SETUPMAPPING;
+	args.in.h.nodeid = fi->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	err = fuse_simple_request(fc, &args);
+	if (err < 0) {
+		printk(KERN_ERR "%s request failed at mem_offset=0x%llx %zd\n",
+				 __func__, dmap->window_offset, err);
+		return err;
+	}
+
+	pr_debug("fuse_setup_one_mapping() succeeded. offset=0x%llx err=%zd\n", offset, err);
+
+	/* TODO: What locking is required here. For now, using fc->lock */
+	dmap->start = offset;
+	dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
+	/* Protected by fi->i_dmap_sem */
+	fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
+	fi->nr_dmaps++;
+	return 0;
+}
+
+static int fuse_removemapping_one(struct inode *inode,
+					struct fuse_dax_mapping *dmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_removemapping_in inarg;
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.moffset = dmap->window_offset;
+	inarg.len = dmap->length;
+	args.in.h.opcode = FUSE_REMOVEMAPPING;
+	args.in.h.nodeid = fi->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	return fuse_simple_request(fc, &args);
+}
+
+/*
+ * It is called from evict_inode() and by that time inode is going away. So
+ * this function does not take any locks like fi->i_dmap_sem for traversing
+ * that fuse inode interval tree. If that lock is taken then lock validator
+ * complains of deadlock situation w.r.t fs_reclaim lock.
+ */
+void fuse_removemapping(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	ssize_t err;
+	struct fuse_dax_mapping *dmap;
+
+	/* Clear the mappings list */
+	while (true) {
+		WARN_ON(fi->nr_dmaps < 0);
+
+		dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0,
+								-1);
+		if (dmap) {
+			fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+			fi->nr_dmaps--;
+		}
+
+		if (!dmap)
+			break;
+
+		/*
+		 * During umount/shutdown, fuse connection is dropped first
+		 * and later evict_inode() is called later. That means any
+		 * removemapping messages are going to fail. Send messages
+		 * only if connection is up. Otherwise fuse daemon is
+		 * responsible for cleaning up any leftover references and
+		 * mappings.
+		 */
+		if (fc->connected) {
+			err = fuse_removemapping_one(inode, dmap);
+			if (err) {
+				pr_warn("Failed to removemapping. offset=0x%llx"
+					" len=0x%llx\n", dmap->window_offset,
+					dmap->length);
+			}
+		}
+
+		/* Add it back to free ranges list */
+		free_dax_mapping(fc, dmap);
+	}
+}
+
 void fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
@@ -1476,32 +1649,290 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return res;
 }
 
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file->f_mapping->host;
 
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_read_iter(iocb, to);
-	else
+	if (IS_DAX(inode))
+		return fuse_dax_read_iter(iocb, to);
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_read_iter(iocb, to);
+
+	return fuse_cache_read_iter(iocb, to);
 }
 
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file->f_mapping->host;
 
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
+	if (IS_DAX(inode))
+		return fuse_dax_write_iter(iocb, from);
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_write_iter(iocb, from);
+
+	return fuse_cache_write_iter(iocb, from);
+}
+
+static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
+{
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->length = length;
+	iomap->type = IOMAP_HOLE;
+}
+
+static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t length,
+			struct iomap *iomap, struct fuse_dax_mapping *dmap,
+			unsigned flags)
+{
+	loff_t offset, len;
+	loff_t i_size = i_size_read(inode);
+
+	offset = pos - dmap->start;
+	len = min(length, dmap->length - offset);
+
+	/* If length is beyond end of file, truncate further */
+	if (pos + len > i_size)
+		len = i_size - pos;
+
+	if (len > 0) {
+		iomap->addr = dmap->window_offset + offset;
+		iomap->length = len;
+		if (flags & IOMAP_FAULT)
+			iomap->length = ALIGN(len, PAGE_SIZE);
+		iomap->type = IOMAP_MAPPED;
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				" length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	} else {
+		/* Mapping beyond end of file is hole */
+		fuse_fill_iomap_hole(iomap, length);
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				"length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	}
+}
+
+/* This is just for DAX and the mapping is ephemeral, do not use it for other
+ * purposes since there is no block device with a permanent mapping.
+ */
+static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
+			    unsigned flags, struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_dax_mapping *dmap, *alloc_dmap = NULL;
+	int ret;
+
+	/* We don't support FIEMAP */
+	BUG_ON(flags & IOMAP_REPORT);
+
+	pr_debug("fuse_iomap_begin() called. pos=0x%llx length=0x%llx\n",
+			pos, length);
+
+	/*
+	 * Writes beyond end of file are not handled using dax path. Instead
+	 * a fuse write message is sent to daemon
+	 */
+	if (flags & IOMAP_WRITE && pos >= i_size_read(inode))
+		return -EIO;
+
+	iomap->offset = pos;
+	iomap->flags = 0;
+	iomap->bdev = NULL;
+	iomap->dax_dev = fc->dax_dev;
+
+	/*
+	 * Both read/write and mmap path can race here. So we need something
+	 * to make sure if we are setting up mapping, then other path waits
+	 *
+	 * For now, use a semaphore for this. It probably needs to be
+	 * optimized later.
+	 */
+	down_read(&fi->i_dmap_sem);
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
+
+	if (dmap) {
+		fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+		up_read(&fi->i_dmap_sem);
+		return 0;
+	} else {
+		up_read(&fi->i_dmap_sem);
+		pr_debug("%s: no mapping at offset 0x%llx length 0x%llx\n",
+				__func__, pos, length);
+		if (pos >= i_size_read(inode))
+			goto iomap_hole;
+
+		alloc_dmap = alloc_dax_mapping(fc);
+		if (!alloc_dmap)
+			return -EBUSY;
+
+		/*
+		 * Drop read lock and take write lock so that only one
+		 * caller can try to setup mapping and other waits
+		 */
+		down_write(&fi->i_dmap_sem);
+		/*
+		 * We dropped lock. Check again if somebody else setup
+		 * mapping already.
+		 */
+		dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos,
+							pos);
+		if (dmap) {
+			fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+			free_dax_mapping(fc, alloc_dmap);
+			up_write(&fi->i_dmap_sem);
+			return 0;
+		}
+
+		/* Setup one mapping */
+		ret = fuse_setup_one_mapping(inode, NULL,
+				ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
+				alloc_dmap);
+		if (ret < 0) {
+			printk("fuse_setup_one_mapping() failed. err=%d"
+				" pos=0x%llx\n", ret, pos);
+			free_dax_mapping(fc, alloc_dmap);
+			up_write(&fi->i_dmap_sem);
+			return ret;
+		}
+		fuse_fill_iomap(inode, pos, length, iomap, alloc_dmap, flags);
+		up_write(&fi->i_dmap_sem);
+		return 0;
+	}
+
+	/*
+	 * If read beyond end of file happnes, fs code seems to return
+	 * it as hole
+	 */
+iomap_hole:
+	fuse_fill_iomap_hole(iomap, length);
+	pr_debug("fuse_iomap_begin() returning hole mapping. pos=0x%llx length_asked=0x%llx length_returned=0x%llx\n", pos, length, iomap->length);
+	return 0;
+}
+
+static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+			  ssize_t written, unsigned flags,
+			  struct iomap *iomap)
+{
+	/* DAX writes beyond end-of-file aren't handled using iomap, so the
+	 * file size is unchanged and there is nothing to do here.
+	 */
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin = fuse_iomap_begin,
+	.iomap_end = fuse_iomap_end,
+};
+
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	ret = dax_iomap_rw(iocb, to, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	/* TODO file_accessed(iocb->f_filp) */
+
+	return ret;
+}
+
+static bool file_extending_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return (iov_iter_rw(from) == WRITE &&
+		((iocb->ki_pos) >= i_size_read(inode)));
+}
+
+static ssize_t fuse_dax_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
+	ssize_t ret;
+
+	ret = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	if (ret < 0)
+		return ret;
+
+	fuse_invalidate_attr(inode);
+	fuse_write_update_size(inode, iocb->ki_pos);
+	return ret;
+}
+
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret, count;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	ret = file_remove_privs(iocb->ki_filp);
+	if (ret)
+		goto out;
+	/* TODO file_update_time() but we don't want metadata I/O */
+
+	/* Do not use dax for file extending writes as its an mmap and
+	 * trying to write beyong end of existing page will generate
+	 * SIGBUS.
+	 */
+	if (file_extending_write(iocb, from)) {
+		ret = fuse_dax_direct_write(iocb, from);
+		goto out;
+ 	}
+
+	ret = dax_iomap_rw(iocb, from, &fuse_iomap_ops);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If part of the write was file extending, fuse dax path will not
+	 * take care of that. Do direct write instead.
+	 */
+	if (iov_iter_count(from) && file_extending_write(iocb, from)) {
+		count = fuse_dax_direct_write(iocb, from);
+		if (count < 0)
+			goto out;
+		ret += count;
+	}
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
 }
 
 static void fuse_writepage_free(struct fuse_conn *fc, struct fuse_req *req)
@@ -2180,6 +2611,11 @@ static ssize_t fuse_file_splice_read(struct file *in, loff_t *ppos,
 
 }
 
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return -EINVAL; /* TODO */
+}
+
 static int convert_fuse_file_lock(struct fuse_conn *fc,
 				  const struct fuse_file_lock *ffl,
 				  struct file_lock *fl)
@@ -3212,6 +3648,7 @@ static const struct address_space_operations fuse_file_aops  = {
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
@@ -3221,4 +3658,9 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	INIT_LIST_HEAD(&fi->writepages);
+	fi->dmap_tree = RB_ROOT_CACHED;
+
+	if (fc->dax_dev) {
+		inode->i_flags |= S_DAX;
+	}
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5439e4628362..f1ae549eff98 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -98,11 +98,22 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->end)
+
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
 
+	/* For interval tree in file/inode */
+	struct rb_node rb;
+	/** Start Position in file */
+	__u64 start;
+	/** End Position in file */
+	__u64 end;
+	__u64 __subtree_last;
+
        /** Position in DAX window */
        u64 window_offset;
 
@@ -195,6 +206,15 @@ struct fuse_inode {
 
 	/** Lock to protect write related fields */
 	spinlock_t lock;
+
+	/*
+	 * Semaphore to protect modifications to dmap_tree
+	 */
+	struct rw_semaphore i_dmap_sem;
+
+	/** Sorted rb tree of struct fuse_dax_mapping elements */
+	struct rb_root_cached dmap_tree;
+	unsigned long nr_dmaps;
 };
 
 /** FUSE inode state bits */
@@ -1226,5 +1246,6 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_removemapping(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8a3dd72f9843..ad66a353554b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -83,7 +83,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
@@ -119,6 +121,10 @@ static void fuse_evict_inode(struct inode *inode)
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
+		if (IS_DAX(inode)) {
+			fuse_removemapping(inode);
+			WARN_ON(fi->nr_dmaps);
+		}
 		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
 		fi->forget = NULL;
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 9eb313220549..5042e227e8a8 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -826,6 +826,7 @@ struct fuse_copy_file_range_in {
 
 #define FUSE_SETUPMAPPING_ENTRIES 8
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
 	/* An already open handle */
 	uint64_t	fh;
-- 
2.20.1

