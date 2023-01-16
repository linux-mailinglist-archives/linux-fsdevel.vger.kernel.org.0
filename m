Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240D666D29E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjAPXJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAPXJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C623642
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/M45GDyobIrHzzTTPdxvHNS6ahkXl3LWGYzDNmotxYs=;
        b=Sfqjs0j9slXxyQeHcLmH7T/70HIn+1sfXaYPMpQEIe9wfioAh2YuY2wULhPW8Rz05RXfA6
        INWfAIFAdRr2IhF0z30GdvgL3iF1RnD9GkNZaerJnbFeJ0dQtpkuKuPa/2ql1D0CiL/JxG
        cBNgRSpenNVXpT4B5wH7pDglPpg7nio=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-Hy5vodhWN_CQKmWbF5lN4w-1; Mon, 16 Jan 2023 18:08:19 -0500
X-MC-Unique: Hy5vodhWN_CQKmWbF5lN4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA79B3C0CD55;
        Mon, 16 Jan 2023 23:08:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 884EF492B00;
        Mon, 16 Jan 2023 23:08:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 02/34] iov_iter: Use IOCB/IOMAP_WRITE/op_is_write rather
 than iterator direction
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:17 +0000
Message-ID: <167391049698.2311931.13641162904441620555.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use information other than the iterator direction to determine the
direction of the I/O:

 (*) If a kiocb is available, use the IOCB_WRITE flag.

 (*) If an iomap_iter is available, use the IOMAP_WRITE flag.

 (*) If a request is available, use op_is_write().

Drop the check on the iterator in smbd_recv() and its warning.

This leaves __iov_iter_get_pages_alloc() the only user of iov_iter_rw(), so
move it there and uninline it.

Changes:
========
ver #6)
 - Move to the front of the patchset.
 - Added iocb_is_read() and iocb_is_write() to check IOCB_WRITE.
 - Use op_is_write() in bio_copy_user_iov().
 - Drop the checks from smbd_recv().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/167305163159.1521586.9460968250704377087.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk/ # v5
---

 block/blk-map.c      |    2 +-
 block/fops.c         |    8 ++++----
 fs/9p/vfs_addr.c     |    2 +-
 fs/affs/file.c       |    4 ++--
 fs/ceph/file.c       |    2 +-
 fs/cifs/smbdirect.c  |    9 ---------
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
 include/linux/fs.h   |   10 ++++++++++
 include/linux/uio.h  |    5 -----
 lib/iov_iter.c       |    5 +++++
 28 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c73..08cbb7ff3b19 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -203,7 +203,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	/*
 	 * success
 	 */
-	if ((iov_iter_rw(iter) == WRITE &&
+	if ((op_is_write(rq->cmd_flags) &&
 	     (!map_data || !map_data->null_mapped)) ||
 	    (map_data && map_data->from_user)) {
 		ret = bio_copy_from_iter(bio, iter);
diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..5d376285edde 100644
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
@@ -296,7 +296,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					unsigned int nr_pages)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
-	bool is_read = iov_iter_rw(iter) == READ;
+	bool is_read = iocb_is_read(iocb);
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 97599edbc300..080be076b7b6 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -254,7 +254,7 @@ v9fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t n;
 	int err = 0;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		n = p9_client_write(file->private_data, pos, iter, &err);
 		if (n) {
 			struct inode *inode = file_inode(file);
diff --git a/fs/affs/file.c b/fs/affs/file.c
index cefa222f7881..0dc67fc5d6cb 100644
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
index 764598e1efd9..27c72a2f6af5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1284,7 +1284,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
-	bool write = iov_iter_rw(iter) == WRITE;
+	bool write = iocb_is_write(iocb);
 	bool should_dirty = !write && user_backed_iter(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 90789aaa6567..3e693ffd0662 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1938,14 +1938,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	unsigned int to_read, page_offset;
 	int rc;
 
-	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc = -EINVAL;
-		goto out;
-	}
-
 	switch (iov_iter_type(&msg->msg_iter)) {
 	case ITER_KVEC:
 		buf = msg->msg_iter.kvec->iov_base;
@@ -1967,7 +1959,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 		rc = -EINVAL;
 	}
 
-out:
 	/* SMBDirect will read it all or nothing */
 	if (rc > 0)
 		msg->msg_iter.count = 0;
diff --git a/fs/dax.c b/fs/dax.c
index c48a3a93ab29..b538a2ab7b66 100644
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
+	if (iocb_is_write(iocb)) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
 	} else {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae1..cf196f2a211e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1143,7 +1143,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 
 	/* watch out for a 0 len io from a tricksy fs */
-	if (iov_iter_rw(iter) == READ && !count)
+	if (iocb_is_read(iocb) && !count)
 		return 0;
 
 	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
@@ -1157,14 +1157,14 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	memset(dio, 0, offsetof(struct dio, pages));
 
 	dio->flags = flags;
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb)) {
 		/* will be released by direct_io_worker */
 		inode_lock(inode);
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
-	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
+	if (iocb_is_read(iocb) && offset >= dio->i_size) {
 		retval = 0;
 		goto fail_dio;
 	}
@@ -1177,7 +1177,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			goto fail_dio;
 	}
 
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb)) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
 		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
@@ -1193,13 +1193,13 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
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
@@ -1211,7 +1211,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
 	 * so that we can call ->fsync.
 	 */
-	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
+	if (dio->is_async && iocb_is_write(iocb)) {
 		retval = 0;
 		if (iocb_is_dsync(iocb))
 			retval = dio_set_defer_completion(dio);
@@ -1248,7 +1248,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
 
-	dio->should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
+	dio->should_dirty = user_backed_iter(iter) && iocb_is_read(iocb);
 	sdio.iter = iter;
 	sdio.final_block_in_request = end >> blkbits;
 
@@ -1305,7 +1305,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * we can let i_mutex go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
-	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
+	if (iocb_is_read(iocb) && (dio->flags & DIO_LOCKING))
 		inode_unlock(dio->inode);
 
 	/*
@@ -1317,7 +1317,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	BUG_ON(retval == -EIOCBQUEUED);
 	if (dio->is_async && retval == 0 && dio->result &&
-	    (iov_iter_rw(iter) == READ || dio->result == count))
+	    (iocb_is_read(iocb) || dio->result == count))
 		retval = -EIOCBQUEUED;
 	else
 		dio_await_completion(dio);
@@ -1330,7 +1330,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	return retval;
 
 fail_dio:
-	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
+	if (dio->flags & DIO_LOCKING && iocb_is_read(iocb))
 		inode_unlock(inode);
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 5b644cb057fa..82554aaf4fd0 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -412,10 +412,10 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
index 69aed9e2359e..26a61f886844 100644
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
index ecbc8c135b49..51a24580cfec 100644
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
index e23e802a8013..4351376db4a1 100644
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
index 875314ee6f59..d68b45f8b3ae 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2897,7 +2897,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	inode = file->f_mapping->host;
 	i_size = i_size_read(inode);
 
-	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
+	if (iocb_is_read(iocb) && (offset >= i_size))
 		return 0;
 
 	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
@@ -2909,7 +2909,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	io->bytes = -1;
 	io->size = 0;
 	io->offset = offset;
-	io->write = (iov_iter_rw(iter) == WRITE);
+	io->write = iocb_is_write(iocb);
 	io->err = 0;
 	/*
 	 * By default, we want to optimize all I/Os with async request
@@ -2942,7 +2942,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		io->done = &wait;
 	}
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else {
@@ -2965,7 +2965,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	kref_put(&io->refcnt, fuse_io_release);
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iocb_is_write(iocb)) {
 		fuse_write_update_attr(inode, pos, ret);
 		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9c329a365e75..eec166e039d5 100644
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
index 840577a0c1e7..2b4effb6ca3e 100644
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
index 9804714b1751..b03d87f116fc 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -519,7 +519,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (iocb_is_read(iocb)) {
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
index 1707f46b1335..d865945f2a63 100644
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
index 232dd7b6cca1..496801507083 100644
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
index 20b953871574..675be8d629fc 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -761,7 +761,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t vbo = iocb->ki_pos;
 	loff_t end;
-	int wr = iov_iter_rw(iter) & WRITE;
+	bool wr = iocb_is_write(iocb);
 	size_t iter_count = iov_iter_count(iter);
 	loff_t valid;
 	ssize_t ret;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 1d65f6ef00ca..b741068a0a7e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2441,7 +2441,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	    !ocfs2_supports_append_dio(osb))
 		return 0;
 
-	if (iov_iter_rw(iter) == READ)
+	if (iocb_is_read(iocb))
 		get_block = ocfs2_lock_get_block;
 	else
 		get_block = ocfs2_dio_wr_get_block;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df560894386..ece65907ff83 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -521,7 +521,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	 */
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
-	enum ORANGEFS_io_type type = iov_iter_rw(iter) == WRITE ?
+	enum ORANGEFS_io_type type = iocb_is_write(iocb) ?
             ORANGEFS_IO_WRITE : ORANGEFS_IO_READ;
 	loff_t *offset = &pos;
 	struct inode *inode = file->f_mapping->host;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..0ed65feda193 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3249,7 +3249,7 @@ static ssize_t reiserfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * In case of error extending write may have instantiated a few
 	 * blocks outside i_size. Trim these off again.
 	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
+	if (unlikely(iocb_is_write(iocb) && ret < 0)) {
 		loff_t isize = i_size_read(inode);
 		loff_t end = iocb->ki_pos + count;
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1d7c2a812fc1..66a1b9e85cb2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -219,7 +219,7 @@ static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 
 	ret = blockdev_direct_IO(iocb, inode, iter, udf_get_block);
-	if (unlikely(ret < 0 && iov_iter_rw(iter) == WRITE))
+	if (unlikely(ret < 0 && iocb_is_write(iocb)))
 		udf_write_failed(mapping, iocb->ki_pos + count);
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 649ff061440e..6a488ae69f5d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -353,6 +353,16 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
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
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9f158238edba..6f4dfa96324d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -114,11 +114,6 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
-static inline unsigned char iov_iter_rw(const struct iov_iter *i)
-{
-	return i->data_source ? WRITE : READ;
-}
-
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
 	return i->user_backed;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9a3ff37ecd1..68497d9c1452 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1429,6 +1429,11 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
+static unsigned char iov_iter_rw(const struct iov_iter *i)
+{
+	return i->data_source ? WRITE : READ;
+}
+
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start,


