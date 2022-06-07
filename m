Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716453F4DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiFGELK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFGELI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:11:08 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741DCA3EB
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8cwS5sS/fLPmGZI22cBRDGat9gTpmj82SiEFpauDM3U=; b=ggGopfJ9CjqupaYtw4nkz8owwt
        d0x0JfgkM572+zM2f2XaelNCDZhUoE8H/d2AUTrbVKWg7AAJ5wAdUt85GmDXkJ1CzmWwe06JdyVRi
        DE0Ao71rwSB7B7o0W0bLmkoY21MWYUgDEaqbYUhGHu8xRW5ESwRw7QtVRj2wCH+EpyAlyVvE3l0fq
        KE4UvnLtFZ1BpZljUDSmeLTrXf6AkPql7mmbasBauxNSKMrVSGS2R3tR5OZMxjaui91OhbKNkrqUq
        gTfwukjRPy31oD3NaWoVtpmmvMANIZdQ+IpQb3DuCeMRx7Ms1LY8CYIBd+W49NsLxQWQcnsMgKfzZ
        +uYtGDtQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQYc-004YmD-EC; Tue, 07 Jun 2022 04:11:06 +0000
Date:   Tue, 7 Jun 2022 04:11:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/9] iocb: delay evaluation of IS_SYNC(...) until we want to
 check IOCB_DSYNC
Message-ID: <Yp7P2htu+wZsZ7mc@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New helper to be used instead of direct checks for IOCB_DSYNC:
iocb_is_dsync(iocb).  Checks converted, which allows to avoid
the IS_SYNC(iocb->ki_filp->f_mapping->host) part (4 cache lines)
from iocb_flags() - it's checked in iocb_is_dsync() instead

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/fops.c         |  2 +-
 fs/btrfs/file.c      |  2 +-
 fs/direct-io.c       |  2 +-
 fs/fuse/file.c       |  2 +-
 fs/iomap/direct-io.c | 22 ++++++++++++----------
 fs/zonefs/super.c    |  2 +-
 include/linux/fs.h   | 10 ++++++++--
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d6b3276a6c68..6e86931ab847 100644
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
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 98f81e304eb1..54358a5c9d56 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2021,7 +2021,7 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct file *file = iocb->ki_filp;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
-	const bool sync = iocb->ki_flags & IOCB_DSYNC;
+	const bool sync = iocb_is_dsync(iocb);
 
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 840752006f60..39647eb56904 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1210,7 +1210,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
 		retval = 0;
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb_is_dsync(iocb))
 			retval = dio_set_defer_completion(dio);
 		else if (!dio->inode->i_sb->s_dio_done_wq) {
 			/*
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..00fa861aeead 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1042,7 +1042,7 @@ static unsigned int fuse_write_flags(struct kiocb *iocb)
 {
 	unsigned int flags = iocb->ki_filp->f_flags;
 
-	if (iocb->ki_flags & IOCB_DSYNC)
+	if (iocb_is_dsync(iocb))
 		flags |= O_DSYNC;
 	if (iocb->ki_flags & IOCB_SYNC)
 		flags |= O_SYNC;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 0f16479b13d6..2be8d9e98fbc 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,17 +548,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC && !(dio_flags & IOMAP_DIO_NOSYNC))
-			dio->flags |= IOMAP_DIO_NEED_SYNC;
+		if (iocb_is_dsync(iocb)) {
+			if (!(dio_flags & IOMAP_DIO_NOSYNC))
+				dio->flags |= IOMAP_DIO_NEED_SYNC;
 
-		/*
-		 * For datasync only writes, we optimistically try using FUA for
-		 * this IO.  Any non-FUA write that occurs will clear this flag,
-		 * hence we know before completion whether a cache flush is
-		 * necessary.
-		 */
-		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
-			dio->flags |= IOMAP_DIO_WRITE_FUA;
+			/*
+			 * For datasync only writes, we optimistically try
+			 * using FUA for this IO.  Any non-FUA write that
+			 * occurs will clear this flag, hence we know before
+			 * completion whether a cache flush is necessary.
+			 */
+			if (!(iocb->ki_flags & IOCB_SYNC))
+				dio->flags |= IOMAP_DIO_WRITE_FUA;
+		}
 	}
 
 	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bcb21aea990a..04a98b4cd7ee 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -746,7 +746,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
 	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_ioprio = iocb->ki_ioprio;
-	if (iocb->ki_flags & IOCB_DSYNC)
+	if (iocb_is_dsync(iocb))
 		bio->bi_opf |= REQ_FUA;
 
 	ret = bio_iov_iter_get_pages(bio, from);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a2a4906041f..380a1292f4f9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2720,6 +2720,12 @@ extern int vfs_fsync(struct file *file, int datasync);
 extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 				unsigned int flags);
 
+static inline bool iocb_is_dsync(const struct kiocb *iocb)
+{
+	return (iocb->ki_flags & IOCB_DSYNC) ||
+		IS_SYNC(iocb->ki_filp->f_mapping->host);
+}
+
 /*
  * Sync the bytes written if this was a synchronous write.  Expect ki_pos
  * to already be updated for the write, and will return either the amount
@@ -2727,7 +2733,7 @@ extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
  */
 static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 {
-	if (iocb->ki_flags & IOCB_DSYNC) {
+	if (iocb_is_dsync(iocb)) {
 		int ret = vfs_fsync_range(iocb->ki_filp,
 				iocb->ki_pos - count, iocb->ki_pos - 1,
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
@@ -3262,7 +3268,7 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_APPEND;
 	if (file->f_flags & O_DIRECT)
 		res |= IOCB_DIRECT;
-	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
+	if (file->f_flags & O_DSYNC)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
-- 
2.30.2

