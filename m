Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA7A6937
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfICNDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:03:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfICNDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N5Og9wjEkwUlnbhil/yRtZ2URQCtIN3Nil87tCMqQiE=; b=M2R2avZSJSvvP8a/TY7zjLFb86
        3wAo5UcQglIbynf+AyoigA54uce9k1VVAbxpYbSGMm8z+1VSE+RV9AVM2asiATKN+Hyj9AgqIlgUl
        zp3Aegrw8diUEF5DA0mXofHFduOv+SAmf03J9ntdIojNrCz/j4vfEDBoHOHkTIOrubPL4ZDNfmAcY
        3Uqg2awlEXTDViDuJ7i3LKS6PHH9a9epToJhMwHV5VHXyyueLyhcYCk1lXY6rEXRxWSbCHGiTVmBI
        +TSJbOVPoa6ppwwGzM8dKYiMJ7rG0gBpmcCy2PXb8mwKxtbAZbBpAGvZcgJh+yL4qaPtytlk0d1BZ
        n/U3qAqA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58T7-0003t6-9P; Tue, 03 Sep 2019 13:03:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 2/2] iomap: move the iomap_dio_rw ->end_io callback into a structure
Date:   Tue,  3 Sep 2019 15:03:27 +0200
Message-Id: <20190903130327.6023-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903130327.6023-1-hch@lst.de>
References: <20190903130327.6023-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new iomap_dio_ops structure that for now just contains the end_io
handler.  This avoid storing the function pointer in a mutable structure,
which is a possible exploit vector for kernel code execution, and prepares
for adding a submit_io handler that btrfs needs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 21 ++++++++++-----------
 fs/xfs/xfs_file.c     |  6 +++++-
 include/linux/iomap.h | 10 +++++++---
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2ccf1c6460d4..1fc28c2da279 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -24,7 +24,7 @@
 
 struct iomap_dio {
 	struct kiocb		*iocb;
-	iomap_dio_end_io_t	*end_io;
+	const struct iomap_dio_ops *dops;
 	loff_t			i_size;
 	loff_t			size;
 	atomic_t		ref;
@@ -72,15 +72,14 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
+	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
+	ssize_t ret = dio->error;
 
-	if (dio->end_io)
-		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
-	else
-		ret = dio->error;
+	if (dops && dops->end_io)
+		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
 
 	if (likely(!ret)) {
 		ret = dio->size;
@@ -98,9 +97,9 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
 	 * this invalidation fails, tough, the write still worked...
 	 *
-	 * And this page cache invalidation has to be after dio->end_io(), as
-	 * some filesystems convert unwritten extents to real allocations in
-	 * end_io() when necessary, otherwise a racing buffer read would cache
+	 * And this page cache invalidation has to be after ->end_io(), as some
+	 * filesystems convert unwritten extents to real allocations in
+	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
 	if (!dio->error &&
@@ -393,7 +392,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  */
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, iomap_dio_end_io_t end_io)
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -418,7 +417,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	atomic_set(&dio->ref, 1);
 	dio->size = 0;
 	dio->i_size = i_size_read(inode);
-	dio->end_io = end_io;
+	dio->dops = dops;
 	dio->error = 0;
 	dio->flags = 0;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3d8e6db9ef77..1ffb179f35d2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -443,6 +443,10 @@ xfs_dio_write_end_io(
 	return error;
 }
 
+static const struct iomap_dio_ops xfs_dio_write_ops = {
+	.end_io		= xfs_dio_write_end_io,
+};
+
 /*
  * xfs_file_dio_aio_write - handle direct IO writes
  *
@@ -543,7 +547,7 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
 
 	/*
 	 * If unaligned, this is the only IO in-flight. If it has not yet
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 50bb746d2216..7aa5d6117936 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,10 +188,14 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size, int error,
-				 unsigned int flags);
+
+struct iomap_dio_ops {
+	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
+		      unsigned flags);
+};
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.20.1

