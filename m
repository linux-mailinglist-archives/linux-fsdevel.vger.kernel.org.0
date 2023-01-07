Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB47D660ADE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjAGAf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbjAGAfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27784BFC
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673051637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dH/Q7Q7uhbaE8X/xEXhKxP+j3xs1s/GoBjaXEmu1x4Y=;
        b=eudk3xMb9g1TtQ/Bc3etYDXdNlpwAgIldNno0gntOL+LkqfScmiocIRqr5G50CGoerLr+a
        NMqN3LUYG3LILoSZo6aKC20xHmU5JlwoaOIQfoPjOqjIIr2/1jnCyjYKWMmcpB662L0Ai8
        4ZzB6dYNw5g5ltw/TydryYk9w3m98Eg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-BTlxP85oPXilxILQZUAaIg-1; Fri, 06 Jan 2023 19:33:54 -0500
X-MC-Unique: BTlxP85oPXilxILQZUAaIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B633814955;
        Sat,  7 Jan 2023 00:33:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBF1492B08;
        Sat,  7 Jan 2023 00:33:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 3/7] iov_iter: Use IOCB/IOMAP_WRITE if available rather
 than iterator direction
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Jan 2023 00:33:51 +0000
Message-ID: <167305163159.1521586.9460968250704377087.stgit@warthog.procyon.org.uk>
In-Reply-To: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a kiocb or iomap_iter is available, then use the IOCB_WRITE flag or the
IOMAP_WRITE flag to determine whether we're writing rather than the
iterator direction flag.

This allows all but three of the users of iov_iter_rw() to be got rid of: a
consistency check and a warning statement in cifs and one user in the block
layer that has neither available.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
---

 block/fops.c         |    8 ++++----
 fs/9p/vfs_addr.c     |    2 +-
 fs/affs/file.c       |    4 ++--
 fs/ceph/file.c       |    2 +-
 fs/dax.c             |    6 +++---
 fs/direct-io.c       |   22 +++++++++++-----------
 fs/exfat/inode.c     |    6 +++---
 fs/ext2/inode.c      |    2 +-
 fs/f2fs/file.c       |   10 +++++-----
 fs/fat/inode.c       |    4 ++--
 fs/fuse/dax.c        |    2 +-
 fs/fuse/file.c       |    8 ++++----
 fs/hfs/inode.c       |    2 +-
 fs/hfsplus/inode.c   |    2 +-
 fs/iomap/direct-io.c |    6 +++---
 fs/jfs/inode.c       |    2 +-
 fs/nfs/direct.c      |    2 +-
 fs/nilfs2/inode.c    |    2 +-
 fs/ntfs3/inode.c     |    2 +-
 fs/ocfs2/aops.c      |    2 +-
 fs/orangefs/inode.c  |    2 +-
 fs/reiserfs/inode.c  |    2 +-
 fs/udf/inode.c       |    2 +-
 23 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..29c6de67c39e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,7 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (!(iocb->ki_flags & IOCB_WRITE)) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -88,7 +88,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		goto out;
 	ret = bio.bi_iter.bi_size;
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (iocb->ki_flags & IOCB_WRITE)
 		task_io_account_write(ret);
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
@@ -174,7 +174,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool is_read = !(iocb->ki_flags & IOCB_WRITE), is_sync;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
@@ -296,7 +296,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					unsigned int nr_pages)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
-	bool is_read = iov_iter_rw(iter) == READ;
+	bool is_read = !(iocb->ki_flags & IOCB_WRITE);
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 97599edbc300..383d62fc3e18 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -254,7 +254,7 @@ v9fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t n;
 	int err = 0;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb->ki_flags & IOCB_WRITE) {
 		n = p9_client_write(file->private_data, pos, iter, &err);
 		if (n) {
 			struct inode *inode = file_inode(file);
diff --git a/fs/affs/file.c b/fs/affs/file.c
index cefa222f7881..1c0e80a8aab9 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -400,7 +400,7 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb->ki_flags & IOCB_WRITE) {
 		loff_t size = offset + count;
 
 		if (AFFS_I(inode)->mmu_private < size)
@@ -408,7 +408,7 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter, affs_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && (iocb->ki_flags & IOCB_WRITE))
 		affs_write_failed(mapping, offset + count);
 	return ret;
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 764598e1efd9..8bdc5b52c271 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1284,7 +1284,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
-	bool write = iov_iter_rw(iter) == WRITE;
+	bool write = iocb->ki_flags & IOCB_WRITE;
 	bool should_dirty = !write && user_backed_iter(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
diff --git a/fs/dax.c b/fs/dax.c
index c48a3a93ab29..7f4c3789907b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1405,7 +1405,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	loff_t pos = iomi->pos;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
-	bool write = iov_iter_rw(iter) == WRITE;
+	bool write = iomi->flags & IOMAP_WRITE;
 	bool cow = write && iomap->flags & IOMAP_F_SHARED;
 	ssize_t ret = 0;
 	size_t xfer;
@@ -1455,7 +1455,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
-		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+		if (map_len == -EIO && write) {
 			map_len = dax_direct_access(dax_dev, pgoff,
 					PHYS_PFN(size), DAX_RECOVERY_WRITE,
 					&kaddr, NULL);
@@ -1530,7 +1530,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return 0;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb->ki_flags & IOCB_WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
 	} else {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae1..e2d5c757a27a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1143,7 +1143,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 
 	/* watch out for a 0 len io from a tricksy fs */
-	if (iov_iter_rw(iter) == READ && !count)
+	if (!(iocb->ki_flags & IOCB_WRITE) && !count)
 		return 0;
 
 	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
@@ -1157,14 +1157,14 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	memset(dio, 0, offsetof(struct dio, pages));
 
 	dio->flags = flags;
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && !(iocb->ki_flags & IOCB_WRITE)) {
 		/* will be released by direct_io_worker */
 		inode_lock(inode);
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
-	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
+	if (!(iocb->ki_flags & IOCB_WRITE) && offset >= dio->i_size) {
 		retval = 0;
 		goto fail_dio;
 	}
@@ -1177,7 +1177,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			goto fail_dio;
 	}
 
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && !(iocb->ki_flags & IOCB_WRITE)) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
 		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
@@ -1193,13 +1193,13 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	if (is_sync_kiocb(iocb))
 		dio->is_async = false;
-	else if (iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
+	else if ((iocb->ki_flags & IOCB_WRITE) && end > i_size_read(inode))
 		dio->is_async = false;
 	else
 		dio->is_async = true;
 
 	dio->inode = inode;
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb->ki_flags & IOCB_WRITE) {
 		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			dio->opf |= REQ_NOWAIT;
@@ -1211,7 +1211,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
 	 * so that we can call ->fsync.
 	 */
-	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
+	if (dio->is_async && (iocb->ki_flags & IOCB_WRITE)) {
 		retval = 0;
 		if (iocb_is_dsync(iocb))
 			retval = dio_set_defer_completion(dio);
@@ -1248,7 +1248,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
 
-	dio->should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
+	dio->should_dirty = user_backed_iter(iter) && !(iocb->ki_flags & IOCB_WRITE);
 	sdio.iter = iter;
 	sdio.final_block_in_request = end >> blkbits;
 
@@ -1305,7 +1305,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * we can let i_mutex go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
-	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
+	if (!(iocb->ki_flags & IOCB_WRITE) && (dio->flags & DIO_LOCKING))
 		inode_unlock(dio->inode);
 
 	/*
@@ -1317,7 +1317,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	BUG_ON(retval == -EIOCBQUEUED);
 	if (dio->is_async && retval == 0 && dio->result &&
-	    (iov_iter_rw(iter) == READ || dio->result == count))
+	    (!(iocb->ki_flags & IOCB_WRITE) || dio->result == count))
 		retval = -EIOCBQUEUED;
 	else
 		dio_await_completion(dio);
@@ -1330,7 +1330,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	return retval;
 
 fail_dio:
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
+	if (dio->flags & DIO_LOCKING && !(iocb->ki_flags & IOCB_WRITE))
 		inode_unlock(inode);
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 5b644cb057fa..26c2cff71878 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -412,10 +412,10 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
 	loff_t size = iocb->ki_pos + iov_iter_count(iter);
-	int rw = iov_iter_rw(iter);
+	bool writing = iocb->ki_flags & IOCB_WRITE;
 	ssize_t ret;
 
-	if (rw == WRITE) {
+	if (writing) {
 		/*
 		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
 		 * so we need to update the ->i_size_aligned to block boundary.
@@ -434,7 +434,7 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * condition of exfat_get_block() and ->truncate().
 	 */
 	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
-	if (ret < 0 && (rw & WRITE))
+	if (ret < 0 && writing)
 		exfat_write_failed(mapping, size);
 	return ret;
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 69aed9e2359e..9ed588d70722 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -919,7 +919,7 @@ ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 
 	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && (iocb->ki_flags & IOCB_WRITE))
 		ext2_write_failed(mapping, offset + count);
 	return ret;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ecbc8c135b49..7a7cfa39b327 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -809,7 +809,7 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
-static bool f2fs_force_buffered_io(struct inode *inode, int rw)
+static bool f2fs_force_buffered_io(struct inode *inode, bool writing)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -827,9 +827,9 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE))
+	if (f2fs_sb_has_blkzoned(sbi) && writing)
 		return true;
-	if (f2fs_lfs_mode(sbi) && rw == WRITE && F2FS_IO_ALIGNED(sbi))
+	if (f2fs_lfs_mode(sbi) && writing && F2FS_IO_ALIGNED(sbi))
 		return true;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		return true;
@@ -865,7 +865,7 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		unsigned int bsize = i_blocksize(inode);
 
 		stat->result_mask |= STATX_DIOALIGN;
-		if (!f2fs_force_buffered_io(inode, WRITE)) {
+		if (!f2fs_force_buffered_io(inode, true)) {
 			stat->dio_mem_align = bsize;
 			stat->dio_offset_align = bsize;
 		}
@@ -4254,7 +4254,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iov_iter_rw(iter)))
+	if (f2fs_force_buffered_io(inode, iocb->ki_flags & IOCB_WRITE))
 		return false;
 
 	/*
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d99b8549ec8f..d7ffc30ce0e5 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -261,7 +261,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb->ki_flags & IOCB_WRITE) {
 		/*
 		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
 		 * so we need to update the ->mmu_private to block boundary.
@@ -281,7 +281,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * condition of fat_get_block() and ->truncate().
 	 */
 	ret = blockdev_direct_IO(iocb, inode, iter, fat_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && (iocb->ki_flags & IOCB_WRITE))
 		fat_write_failed(mapping, offset + count);
 
 	return ret;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e23e802a8013..fddd0b8de27e 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -720,7 +720,7 @@ static bool file_extending_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	return (iov_iter_rw(from) == WRITE &&
+	return ((iocb->ki_flags & IOCB_WRITE) &&
 		((iocb->ki_pos) >= i_size_read(inode) ||
 		  (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode))));
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 875314ee6f59..9575c4ca0667 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2897,7 +2897,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	inode = file->f_mapping->host;
 	i_size = i_size_read(inode);
 
-	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
+	if (!(iocb->ki_flags & IOCB_WRITE) && (offset >= i_size))
 		return 0;
 
 	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
@@ -2909,7 +2909,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	io->bytes = -1;
 	io->size = 0;
 	io->offset = offset;
-	io->write = (iov_iter_rw(iter) == WRITE);
+	io->write = (iocb->ki_flags & IOCB_WRITE);
 	io->err = 0;
 	/*
 	 * By default, we want to optimize all I/Os with async request
@@ -2942,7 +2942,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		io->done = &wait;
 	}
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if ((iocb->ki_flags & IOCB_WRITE)) {
 		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else {
@@ -2965,7 +2965,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	kref_put(&io->refcnt, fuse_io_release);
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if ((iocb->ki_flags & IOCB_WRITE)) {
 		fuse_write_update_attr(inode, pos, ret);
 		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9c329a365e75..638c87afd96f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -141,7 +141,7 @@ static ssize_t hfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely((iocb->ki_flags & IOCB_WRITE) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 840577a0c1e7..843e6f1ced25 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -138,7 +138,7 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely((iocb->ki_flags & IOCB_WRITE) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9804714b1751..d045b0c54d04 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -519,7 +519,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (!(iocb->ki_flags & IOCB_WRITE)) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
 
@@ -573,7 +573,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out_free_dio;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iomi.flags & IOMAP_WRITE) {
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
@@ -613,7 +613,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 * Revert iter to a state corresponding to that as some callers (such
 	 * as the splice code) rely on it.
 	 */
-	if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
+	if (!(iomi.flags & IOMAP_WRITE) && iomi.pos >= dio->i_size)
 		iov_iter_revert(iter, iomi.pos - dio->i_size);
 
 	if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 8ac10e396050..f403d2f2bfe6 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -334,7 +334,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely((iocb->ki_flags & IOCB_WRITE) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..e94ce42f93a8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -133,7 +133,7 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 
 	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
 
-	if (iov_iter_rw(iter) == READ)
+	if (!(iocb->ki_flags & IOCB_WRITE))
 		ret = nfs_file_direct_read(iocb, iter, true);
 	else
 		ret = nfs_file_direct_write(iocb, iter, true);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 232dd7b6cca1..59df5707d30f 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -289,7 +289,7 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (iocb->ki_flags & IOCB_WRITE)
 		return 0;
 
 	/* Needs synchronization with the cleaner */
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 20b953871574..f0881d0522f8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -761,7 +761,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t vbo = iocb->ki_pos;
 	loff_t end;
-	int wr = iov_iter_rw(iter) & WRITE;
+	bool wr = iocb->ki_flags & IOCB_WRITE;
 	size_t iter_count = iov_iter_count(iter);
 	loff_t valid;
 	ssize_t ret;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 1d65f6ef00ca..3f41c6b403c2 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2441,7 +2441,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	    !ocfs2_supports_append_dio(osb))
 		return 0;
 
-	if (iov_iter_rw(iter) == READ)
+	if (!(iocb->ki_flags & IOCB_WRITE))
 		get_block = ocfs2_lock_get_block;
 	else
 		get_block = ocfs2_dio_wr_get_block;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df560894386..fbecca379e91 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -521,7 +521,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	 */
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
-	enum ORANGEFS_io_type type = iov_iter_rw(iter) == WRITE ?
+	enum ORANGEFS_io_type type = (iocb->ki_flags & IOCB_WRITE) ?
             ORANGEFS_IO_WRITE : ORANGEFS_IO_READ;
 	loff_t *offset = &pos;
 	struct inode *inode = file->f_mapping->host;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..1fc94fd5c371 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3249,7 +3249,7 @@ static ssize_t reiserfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely((iocb->ki_flags & IOCB_WRITE) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1d7c2a812fc1..6d2ce0e512f4 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -219,7 +219,7 @@ static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 
 	ret = blockdev_direct_IO(iocb, inode, iter, udf_get_block);
-	if (unlikely(ret < 0 && iov_iter_rw(iter) == WRITE))
+	if (unlikely(ret < 0 && (iocb->ki_flags & IOCB_WRITE)))
 		udf_write_failed(mapping, iocb->ki_pos + count);
 	return ret;
 }


