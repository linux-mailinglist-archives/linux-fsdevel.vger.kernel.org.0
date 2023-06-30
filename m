Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB183743EC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjF3P1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjF3P0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457BB3C18
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTAo5WyNhYPHTqroVSIv35KW6e6h/y8Wf6WLMg0PsSM=;
        b=ilT1BxkqNHnajlXRKLi0GRTDscupBnWdU7Vteo9uAl6cdHrHQwQl/YwYwMVrnC2g+OWX+N
        j8tYsS2V4wAbd6aibr51B/fIBDduT/lNhB3W2bH7jQqJPqkZbgHvjOWJ51HDTzVjMp9tHs
        WDPP0BokUehccVzd4GW4Jnyl7net81U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Mw6G-2_pMeSIKzFWrVhLrA-1; Fri, 30 Jun 2023 11:25:41 -0400
X-MC-Unique: Mw6G-2_pMeSIKzFWrVhLrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D632F8631DF;
        Fri, 30 Jun 2023 15:25:39 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C700DC00049;
        Fri, 30 Jun 2023 15:25:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 04/11] iov_iter: Use IOCB_WRITE rather than iterator direction
Date:   Fri, 30 Jun 2023 16:25:17 +0100
Message-ID: <20230630152524.661208-5-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a kiocb is available, use the IOCB_WRITE flag instead of the iterator
direction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 block/fops.c         |  8 ++++----
 fs/9p/vfs_addr.c     |  2 +-
 fs/affs/file.c       |  4 ++--
 fs/ceph/file.c       |  2 +-
 fs/dax.c             |  2 +-
 fs/direct-io.c       | 22 +++++++++++-----------
 fs/exfat/inode.c     |  6 +++---
 fs/ext2/inode.c      |  2 +-
 fs/f2fs/file.c       | 10 +++++-----
 fs/fat/inode.c       |  4 ++--
 fs/fuse/dax.c        |  2 +-
 fs/fuse/file.c       |  8 ++++----
 fs/hfs/inode.c       |  2 +-
 fs/hfsplus/inode.c   |  2 +-
 fs/iomap/direct-io.c |  2 +-
 fs/jfs/inode.c       |  2 +-
 fs/nfs/direct.c      |  2 +-
 fs/nilfs2/inode.c    |  2 +-
 fs/ntfs3/inode.c     |  2 +-
 fs/ocfs2/aops.c      |  2 +-
 fs/orangefs/inode.c  |  2 +-
 fs/reiserfs/inode.c  |  2 +-
 fs/udf/inode.c       |  2 +-
 include/linux/fs.h   | 10 ++++++++++
 24 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..e70a5ef4d447 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,7 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (iocb_is_read(iocb)) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -88,7 +88,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		goto out;
 	ret = bio.bi_iter.bi_size;
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (iocb_is_write(iocb))
 		task_io_account_write(ret);
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
@@ -174,7 +174,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool is_read = iocb_is_read(iocb), is_sync;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
@@ -311,7 +311,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					unsigned int nr_pages)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
-	bool is_read = iov_iter_rw(iter) == READ;
+	bool is_read = iocb_is_read(iocb);
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 8a635999a7d6..18bce4f8a158 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -257,7 +257,7 @@ v9fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t n;
 	int err = 0;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		n = p9_client_write(file->private_data, pos, iter, &err);
 		if (n) {
 			struct inode *inode = file_inode(file);
diff --git a/fs/affs/file.c b/fs/affs/file.c
index e43f2f007ac1..ad70ff27e5f2 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -400,7 +400,7 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		loff_t size = offset + count;
 
 		if (AFFS_I(inode)->mmu_private < size)
@@ -408,7 +408,7 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter, affs_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && iocb_is_write(iocb))
 		affs_write_failed(mapping, offset + count);
 	return ret;
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3bb27b9ce751..453429e9b9e6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1280,7 +1280,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
-	bool write = iov_iter_rw(iter) == WRITE;
+	bool write = iocb_is_write(iocb);
 	bool should_dirty = !write && user_backed_iter(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
diff --git a/fs/dax.c b/fs/dax.c
index 2ababb89918d..5c6ebe64a3fd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1573,7 +1573,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return 0;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
 	} else {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 7bc494ee56b9..2b517cc5b32d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1125,7 +1125,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 
 	/* watch out for a 0 len io from a tricksy fs */
-	if (iov_iter_rw(iter) == READ && !count)
+	if (iocb_is_read(iocb) && !count)
 		return 0;
 
 	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
@@ -1139,7 +1139,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	memset(dio, 0, offsetof(struct dio, pages));
 
 	dio->flags = flags;
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb)) {
 		/* will be released by direct_io_worker */
 		inode_lock(inode);
 	}
@@ -1147,7 +1147,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
-	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
+	if (iocb_is_read(iocb) && offset >= dio->i_size) {
 		retval = 0;
 		goto fail_dio;
 	}
@@ -1160,7 +1160,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			goto fail_dio;
 	}
 
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb)) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
 		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
@@ -1176,13 +1176,13 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	if (is_sync_kiocb(iocb))
 		dio->is_async = false;
-	else if (iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
+	else if (iocb_is_write(iocb) && end > i_size_read(inode))
 		dio->is_async = false;
 	else
 		dio->is_async = true;
 
 	dio->inode = inode;
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			dio->opf |= REQ_NOWAIT;
@@ -1194,7 +1194,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
 	 * so that we can call ->fsync.
 	 */
-	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
+	if (dio->is_async && iocb_is_write(iocb)) {
 		retval = 0;
 		if (iocb_is_dsync(iocb))
 			retval = dio_set_defer_completion(dio);
@@ -1230,7 +1230,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
 
-	dio->should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
+	dio->should_dirty = user_backed_iter(iter) && iocb_is_read(iocb);
 	sdio.iter = iter;
 	sdio.final_block_in_request = end >> blkbits;
 
@@ -1287,7 +1287,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * we can let i_mutex go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
-	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
+	if (iocb_is_read(iocb) && (dio->flags & DIO_LOCKING))
 		inode_unlock(dio->inode);
 
 	/*
@@ -1299,7 +1299,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	BUG_ON(retval == -EIOCBQUEUED);
 	if (dio->is_async && retval == 0 && dio->result &&
-	    (iov_iter_rw(iter) == READ || dio->result == count))
+	    (iocb_is_read(iocb) || dio->result == count))
 		retval = -EIOCBQUEUED;
 	else
 		dio_await_completion(dio);
@@ -1312,7 +1312,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	return retval;
 
 fail_dio:
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb))
 		inode_unlock(inode);
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 481dd338f2b8..706db9cd1b4e 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -411,10 +411,10 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
 	loff_t size = iocb->ki_pos + iov_iter_count(iter);
-	int rw = iov_iter_rw(iter);
+	bool writing = iocb_is_write(iocb);
 	ssize_t ret;
 
-	if (rw == WRITE) {
+	if (writing) {
 		/*
 		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
 		 * so we need to update the ->i_size_aligned to block boundary.
@@ -433,7 +433,7 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * condition of exfat_get_block() and ->truncate().
 	 */
 	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
-	if (ret < 0 && (rw & WRITE))
+	if (ret < 0 && writing)
 		exfat_write_failed(mapping, size);
 	return ret;
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26f135e7ffce..b239c16ab7ee 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -919,7 +919,7 @@ ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 
 	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && iocb_is_write(iocb))
 		ext2_write_failed(mapping, offset + count);
 	return ret;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2435111a8532..7ef596b901d9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -805,7 +805,7 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
-static bool f2fs_force_buffered_io(struct inode *inode, int rw)
+static bool f2fs_force_buffered_io(struct inode *inode, bool writing)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -823,9 +823,9 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
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
@@ -861,7 +861,7 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		unsigned int bsize = i_blocksize(inode);
 
 		stat->result_mask |= STATX_DIOALIGN;
-		if (!f2fs_force_buffered_io(inode, WRITE)) {
+		if (!f2fs_force_buffered_io(inode, true)) {
 			stat->dio_mem_align = bsize;
 			stat->dio_offset_align = bsize;
 		}
@@ -4280,7 +4280,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iov_iter_rw(iter)))
+	if (f2fs_force_buffered_io(inode, iocb_is_write(iocb)))
 		return false;
 
 	/*
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d99b8549ec8f..237e20891df2 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -261,7 +261,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		/*
 		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
 		 * so we need to update the ->mmu_private to block boundary.
@@ -281,7 +281,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * condition of fat_get_block() and ->truncate().
 	 */
 	ret = blockdev_direct_IO(iocb, inode, iter, fat_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
+	if (ret < 0 && iocb_is_write(iocb))
 		fat_write_failed(mapping, offset + count);
 
 	return ret;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..7bfbe1783462 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -720,7 +720,7 @@ static bool file_extending_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	return (iov_iter_rw(from) == WRITE &&
+	return (iocb_is_write(iocb) &&
 		((iocb->ki_pos) >= i_size_read(inode) ||
 		  (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode))));
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bc4115288eec..f43a39faa8e4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2911,7 +2911,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	inode = file->f_mapping->host;
 	i_size = i_size_read(inode);
 
-	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
+	if (iocb_is_read(iocb) && (offset >= i_size))
 		return 0;
 
 	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
@@ -2923,7 +2923,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	io->bytes = -1;
 	io->size = 0;
 	io->offset = offset;
-	io->write = (iov_iter_rw(iter) == WRITE);
+	io->write = iocb_is_write(iocb);
 	io->err = 0;
 	/*
 	 * By default, we want to optimize all I/Os with async request
@@ -2956,7 +2956,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		io->done = &wait;
 	}
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else {
@@ -2979,7 +2979,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	kref_put(&io->refcnt, fuse_io_release);
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		fuse_write_update_attr(inode, pos, ret);
 		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 441d7fc952e3..d95ac1f559b5 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -141,7 +141,7 @@ static ssize_t hfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely(iocb_is_write(iocb) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7d1a675e037d..9851a6cb9e3b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -138,7 +138,7 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely(iocb_is_write(iocb) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ea3b868c8355..a56099470185 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -510,7 +510,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (iocb_is_read(iocb)) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 8ac10e396050..0d1f94ac9488 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -334,7 +334,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely(iocb_is_write(iocb) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9a18c5a69ace..5f4522dd05b5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -133,7 +133,7 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 
 	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
 
-	if (iov_iter_rw(iter) == READ)
+	if (iocb_is_read(iocb))
 		ret = nfs_file_direct_read(iocb, iter, true);
 	else
 		ret = nfs_file_direct_write(iocb, iter, true);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a8ce522ac747..93c61fcb5e91 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -289,7 +289,7 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (iocb_is_write(iocb))
 		return 0;
 
 	/* Needs synchronization with the cleaner */
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6c560245eef4..5b50c4653ff8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -774,7 +774,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t vbo = iocb->ki_pos;
 	loff_t end;
-	int wr = iov_iter_rw(iter) & WRITE;
+	bool wr = iocb_is_write(iocb);
 	size_t iter_count = iov_iter_count(iter);
 	loff_t valid;
 	ssize_t ret;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 8dfc284e85f0..e8afc0c13f71 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2456,7 +2456,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	    !ocfs2_supports_append_dio(osb))
 		return 0;
 
-	if (iov_iter_rw(iter) == READ)
+	if (iocb_is_read(iocb))
 		get_block = ocfs2_lock_get_block;
 	else
 		get_block = ocfs2_dio_wr_get_block;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 9014bbcc8031..120a9a6c0f3b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -513,7 +513,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	 */
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
-	enum ORANGEFS_io_type type = iov_iter_rw(iter) == WRITE ?
+	enum ORANGEFS_io_type type = iocb_is_write(iocb) ?
             ORANGEFS_IO_WRITE : ORANGEFS_IO_READ;
 	loff_t *offset = &pos;
 	struct inode *inode = file->f_mapping->host;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 77bd3b27059f..ca57930178f4 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3248,7 +3248,7 @@ static ssize_t reiserfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely(iocb_is_write(iocb) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1e71e04ae8f6..d49c12c1f4d9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -311,7 +311,7 @@ static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 		return 0;
 	ret = blockdev_direct_IO(iocb, inode, iter, udf_get_block);
-	if (unlikely(ret < 0 && iov_iter_rw(iter) == WRITE))
+	if (unlikely(ret < 0 && iocb_is_write(iocb)))
 		udf_write_failed(mapping, iocb->ki_pos + count);
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 466eba253502..e344db819498 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -368,6 +368,16 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 	return kiocb->ki_complete == NULL;
 }
 
+static inline bool iocb_is_write(const struct kiocb *kiocb)
+{
+	return kiocb->ki_flags & IOCB_WRITE;
+}
+
+static inline bool iocb_is_read(const struct kiocb *kiocb)
+{
+	return !iocb_is_write(kiocb);
+}
+
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*read_folio)(struct file *, struct folio *);

