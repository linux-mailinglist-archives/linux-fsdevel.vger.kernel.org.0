Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E555415E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356795AbiFVEQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356687AbiFVEP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4BC10C4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vdv7Cdl9g3PWc0MQ6kvQ7n5Wg7qYgCGxU/vxDuMwimQ=; b=djIZSTqwcTeVmoa2aTIxgDePT/
        Fy5v49/IXTUxbC7yudp3/5OutsW9yvGrA1PMTNL/fiiBe1XeRQ+Vd9114VOCNOptrWXwl/UqifMdc
        VA5DrmnWJHXBnvhLlUrpOBtAiMn7UuU4l4r2nH9J3Vrz9WjnJCo2cjZg+XD2PrSn9AfENsSNs8bkQ
        5ZZIE5eSUWrsC232Ut1U1uzoFrrkDxVfCJu+SDa0hvZYkciyFMYUyb1llveNE5MeZ/7/5yFVRFfCp
        mU4TBr7UltqwRu9qSIAQVyguNTfG+N2eQa0pM/D8iu4/cb/LBzypO/HlD/JXadq5xKAqhs8v78WcH
        77M78qLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmT-0035vf-CE;
        Wed, 22 Jun 2022 04:15:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 06/44] iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
Date:   Wed, 22 Jun 2022 05:15:14 +0100
Message-Id: <20220622041552.737754-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New helper to be used instead of direct checks for IOCB_DSYNC:
iocb_is_dsync(iocb).  Checks converted, which allows to avoid
the IS_SYNC(iocb->ki_filp->f_mapping->host) part (4 cache lines)
from iocb_flags() - it's checked in iocb_is_dsync() instead

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/fops.c         |  2 +-
 fs/btrfs/file.c      |  2 +-
 fs/direct-io.c       |  2 +-
 fs/fuse/file.c       |  2 +-
 fs/iomap/direct-io.c |  3 +--
 fs/zonefs/super.c    |  2 +-
 include/linux/fs.h   | 10 ++++++++--
 7 files changed, 14 insertions(+), 9 deletions(-)

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
index c10c69e2de24..31c7f1035b20 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,8 +548,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC &&
-		    !(dio_flags & IOMAP_DIO_NOSYNC)) {
+		if (iocb_is_dsync(iocb) && !(dio_flags & IOMAP_DIO_NOSYNC)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		       /*
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

