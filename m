Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55FA5B77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfIBQlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 12:41:14 -0400
Received: from verein.lst.de ([213.95.11.211]:51590 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfIBQlN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:41:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31E29227A8A; Mon,  2 Sep 2019 18:41:09 +0200 (CEST)
Date:   Mon, 2 Sep 2019 18:41:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, david@fromorbit.com,
        riteshh@linux.ibm.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 12/15] iomap: use a function pointer for dio submits
Message-ID: <20190902164108.GD6263@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de> <20190901200836.14959-13-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901200836.14959-13-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 03:08:33PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while
> submitting for I/O. Since btrfs requires the position
> we are working on, pass pos to iomap_dio_submit_bio()

Please avoid passing function pointers in mutable data structures.

I think the best idea here is to move the end_io handler into
a structure that can be marked const, and to which we can add the
submit handler later.  Something like this:

---
From d17419b6b4124e95088858d3dcea486db6be9ffa Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 2 Sep 2019 18:39:34 +0200
Subject: iomap: move the direct I/O ->end_io callback into a structure

Add a new iomap_dio_ops structure that for now just contains the end_io
handler.  This avoid storing the function pointer in a mutable structure,
which is a possible exploit vector for kernel code execution, and prepares
for adding a submit_io handler that btrfs needs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 17 +++++++++--------
 fs/xfs/xfs_file.c     |  6 +++++-
 include/linux/iomap.h |  9 ++++++---
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 10517cea9682..cfe5f6a88945 100644
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
@@ -72,13 +72,14 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
+	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (dio->end_io) {
-		ret = dio->end_io(iocb,
+	if (dops && dops->end_io) {
+		ret = dops->end_io(iocb,
 				dio->error ? dio->error : dio->size,
 				dio->flags);
 	} else {
@@ -101,9 +102,9 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
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
@@ -396,7 +397,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  */
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, iomap_dio_end_io_t end_io)
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -421,7 +422,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	atomic_set(&dio->ref, 1);
 	dio->size = 0;
 	dio->i_size = i_size_read(inode);
-	dio->end_io = end_io;
+	dio->dops = dops;
 	dio->error = 0;
 	dio->flags = 0;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 28101bbc0b78..0a2dc6b71c3c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -440,6 +440,10 @@ xfs_dio_write_end_io(
 	return error;
 }
 
+static const struct iomap_dio_ops xfs_dio_write_ops = {
+	.end_io		= xfs_dio_write_end_io,
+};
+
 /*
  * xfs_file_dio_aio_write - handle direct IO writes
  *
@@ -540,7 +544,7 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
 
 	/*
 	 * If unaligned, this is the only IO in-flight. If it has not yet
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..d8c0769bb360 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,10 +188,13 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
-		unsigned flags);
+
+struct iomap_dio_ops {
+	int	(*end_io)(struct kiocb *iocb, ssize_t ret, unsigned flags);
+};
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.20.1

