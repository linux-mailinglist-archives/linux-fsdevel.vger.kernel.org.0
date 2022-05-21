Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F652FEA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiEURsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiEURss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 13:48:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC266369F0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7lix6mJlHKFElpiObH5RXZ049ELCvlf+5IyPMjX+RxU=; b=hockm30xS9ZT79zx6j2V1+Led9
        7qinl6TFYLo+rRsW0XB5/6RZ80Qx7fNfLSmDpcIwFBN3xAmzwxi9vLNo71Cr7b2OKS9LZ638c+CLF
        Vb4PzhRWdAHfi62Z2OA4lumzDud56+297G1I6RJU6XrwbDWAl4SEBiQKIWlWuyzFN3w26dEMaNph/
        RiLMg1g6cSY9nkrz2wDJ73ZI9rCpNeaBSTmh83RSn4pbZmGSsWwS2HJwuVSU+N9YFnaSn1cwY0Csm
        bgySRAPrJ7+aNbgaWIxjt1847R+OM89o2NUN6z/vwU84V2qGCBoWxgqieLRSktCtGM9ItsfnHFsKG
        6mb0MoYQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsTDW-00GuhJ-PC; Sat, 21 May 2022 17:48:43 +0000
Date:   Sat, 21 May 2022 17:48:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
 <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
 <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621143501.GA3789@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resurrecting an old thread]

On Mon, Jun 21, 2021 at 04:35:01PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 02:32:46PM +0000, Al Viro wrote:
> > 	I'd rather have a single helper for those checks, rather than
> > open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...
> 
> Yes, I think something like:
> 
> static inline bool iocb_is_sync(struct kiocb *iocb)
> {
> 	return (iocb->ki_flags & IOCB_DSYNC) ||
> 		S_SYNC(iocb->ki_filp->f_mapping->host);
> }
> 
> should do the job.

There's a problem with that variant.  Take a look at btrfs_direct_write():
        const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
	...
        /*
	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
	 * calls generic_write_sync() (through iomap_dio_complete()), because
	 * that results in calling fsync (btrfs_sync_file()) which will try to
	 * lock the inode in exclusive/write mode.
	 */
	if (is_sync_write)
		iocb->ki_flags &= ~IOCB_DSYNC;
	...

	/*
	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do  
	 * the fsync (call generic_write_sync()).
	 */
	if (is_sync_write)
		iocb->ki_flags |= IOCB_DSYNC;

will run into trouble.  How about this (completely untested):

Precalculate iocb_flags()

Store the value in file->f_i_flags; calculate at open time (do_dentry_open()
for opens, alloc_file() for pipe(2)/socket(2)/etc.), update at FCNTL_SETFL
time.

IOCB_DSYNC is... special in that respect; replace checks for it with
an inlined helper (iocb_is_dsync()), leave the checks of underlying fs
mounted with -o sync and/or inode being marked sync until then.
To avoid breaking btrfs deadlock avoidance, add an explicit "no dsync" flag
that would suppress IOCB_DSYNC; that way btrfs_direct_write() can set it
for the duration of work where it wants to avoid generic_write_sync()
triggering.

That ought to reduce the overhead of new_sync_{read,write}() quite a bit.

NEEDS TESTING; NOT FOR MERGE IN THAT FORM.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..b1f7c4111458 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -37,7 +37,7 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
 	unsigned int op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 
 	/* avoid the need for a I/O completion work item */
-	if (iocb->ki_flags & IOCB_DSYNC)
+	if (iocb_is_dsync(iocb))
 		op |= REQ_FUA;
 	return op;
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index f3d58abf11e0..2be306fe9c13 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -112,7 +112,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
+	iocb->ki_flags = ki_flags | iocb->ki_filp->f_i_flags;
 
 	return call_iter(iocb, &iter);
 }
diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..fb84adb6dc00 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1475,7 +1475,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = req->ki_filp->f_i_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 380054c94e4b..4bd417b7c240 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1883,7 +1883,6 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1937,13 +1936,12 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/*
-	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
+	 * We suppress IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
 	 * calls generic_write_sync() (through iomap_dio_complete()), because
 	 * that results in calling fsync (btrfs_sync_file()) which will try to
 	 * lock the inode in exclusive/write mode.
 	 */
-	if (is_sync_write)
-		iocb->ki_flags &= ~IOCB_DSYNC;
+	iocb->ki_flags |= IOCB_NO_DSYNC;
 
 	/*
 	 * The iov_iter can be mapped to the same file range we are writing to.
@@ -2004,8 +2002,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do
 	 * the fsync (call generic_write_sync()).
 	 */
-	if (is_sync_write)
-		iocb->ki_flags |= IOCB_DSYNC;
+	iocb->ki_flags &= ~IOCB_NO_DSYNC;
 
 	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
 	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
@@ -2074,7 +2071,7 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct file *file = iocb->ki_filp;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
-	const bool sync = iocb->ki_flags & IOCB_DSYNC;
+	const bool sync = iocb_is_dsync(iocb);
 
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aef06e607b40..56dc5a7ad119 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1211,7 +1211,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
 		retval = 0;
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb_is_dsync(iocb))
 			retval = dio_set_defer_completion(dio);
 		else if (!dio->inode->i_sb->s_dio_done_wq) {
 			/*
diff --git a/fs/fcntl.c b/fs/fcntl.c
index f15d885b9796..62082194fb39 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -79,6 +79,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 	}
 	spin_lock(&filp->f_lock);
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
+	filp->f_i_flags = iocb_flags(filp);
 	spin_unlock(&filp->f_lock);
 
  out:
diff --git a/fs/file_table.c b/fs/file_table.c
index ada8fe814db9..a9efe34e6fae 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -241,6 +241,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 	if ((file->f_mode & FMODE_WRITE) &&
 	     likely(fop->write || fop->write_iter))
 		file->f_mode |= FMODE_CAN_WRITE;
+	file->f_i_flags = iocb_flags(file);
 	file->f_mode |= FMODE_OPENED;
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f18d14d5fea1..a636980f55fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1041,7 +1041,7 @@ static unsigned int fuse_write_flags(struct kiocb *iocb)
 {
 	unsigned int flags = iocb->ki_filp->f_flags;
 
-	if (iocb->ki_flags & IOCB_DSYNC)
+	if (iocb_is_dsync(iocb))
 		flags |= O_DSYNC;
 	if (iocb->ki_flags & IOCB_SYNC)
 		flags |= O_SYNC;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 91de361ea9ab..73f53c208df2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3765,7 +3765,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!io_req_ffs_set(req))
 		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
 
-	kiocb->ki_flags = iocb_flags(file);
+	kiocb->ki_flags = file->f_i_flags;
 	ret = kiocb_set_rw_flags(kiocb, req->rw.flags);
 	if (unlikely(ret))
 		return ret;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b08f5dc31780..9825a6cd13fc 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -538,17 +538,20 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
-		/*
-		 * For datasync only writes, we optimistically try using FUA for
-		 * this IO.  Any non-FUA write that occurs will clear this flag,
-		 * hence we know before completion whether a cache flush is
-		 * necessary.
-		 */
-		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
-			dio->flags |= IOMAP_DIO_WRITE_FUA;
+			/*
+			 * For datasync only writes, we optimistically
+			 * try using FUA for this IO.  Any non-FUA write
+			 * that occurs will clear this flag, hence we
+			 * know before completion whether a cache flush
+			 * is necessary.
+			 */
+
+			if (!(iocb->ki_flags & IOCB_SYNC))
+				dio->flags |= IOMAP_DIO_WRITE_FUA;
+		}
 	}
 
 	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e20e7c841489..0f78b5220877 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -707,7 +707,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
 	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_ioprio = iocb->ki_ioprio;
-	if (iocb->ki_flags & IOCB_DSYNC)
+	if (iocb_is_dsync(iocb))
 		bio->bi_opf |= REQ_FUA;
 
 	ret = bio_iov_iter_get_pages(bio, from);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..bc1cbfae73a4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -317,6 +317,9 @@ enum rw_hint {
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
 
+/* suppress dsync */
+#define IOCB_NO_DSYNC		(1 << 31)
+
 struct kiocb {
 	struct file		*ki_filp;
 
@@ -945,6 +948,7 @@ struct file {
 	spinlock_t		f_lock;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
+	unsigned int 		f_i_flags;
 	fmode_t			f_mode;
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
@@ -2191,13 +2195,11 @@ static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
 	       !gid_valid(i_gid_into_mnt(mnt_userns, inode));
 }
 
-static inline int iocb_flags(struct file *file);
-
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
-		.ki_flags = iocb_flags(filp),
+		.ki_flags = filp->f_i_flags,
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
@@ -2721,6 +2723,14 @@ extern int vfs_fsync(struct file *file, int datasync);
 extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 				unsigned int flags);
 
+static inline bool iocb_is_dsync(const struct kiocb *iocb)
+{
+	if (unlikely(iocb->ki_flags & IOCB_NO_DSYNC))
+		return false;
+	return (iocb->ki_flags & IOCB_DSYNC) ||
+		IS_SYNC(iocb->ki_filp->f_mapping->host);
+}
+
 /*
  * Sync the bytes written if this was a synchronous write.  Expect ki_pos
  * to already be updated for the write, and will return either the amount
@@ -2728,7 +2738,7 @@ extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
  */
 static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 {
-	if (iocb->ki_flags & IOCB_DSYNC) {
+	if (iocb_is_dsync(iocb)) {
 		int ret = vfs_fsync_range(iocb->ki_filp,
 				iocb->ki_pos - count, iocb->ki_pos - 1,
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
@@ -3265,7 +3275,7 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_APPEND;
 	if (file->f_flags & O_DIRECT)
 		res |= IOCB_DIRECT;
-	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
+	if (file->f_flags & O_DSYNC)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
