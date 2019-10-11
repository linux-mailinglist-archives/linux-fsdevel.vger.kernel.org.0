Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A98D427F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfJKOOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 10:14:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:53720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbfJKOOi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:14:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83090B5EE;
        Fri, 11 Oct 2019 14:14:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C5D81E150E; Fri, 11 Oct 2019 16:14:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, <linux-xfs@vger.kernel.org>,
        darrick.wong@oracle.com, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
Date:   Fri, 11 Oct 2019 16:14:31 +0200
Message-Id: <20191011141433.18354-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191011125520.11697-1-jack@suse.cz>
References: <20191011125520.11697-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Filesystems do not support doing IO as asynchronous in some cases. For
example in case of unaligned writes or in case file size needs to be
extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
in such cases, add argument to iomap_dio_rw() which makes the function
wait for IO completion. This also results in executing
iomap_dio_complete() inline in iomap_dio_rw() providing its return value
to the caller as for ordinary sync IO.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/file.c        | 6 ++++--
 fs/iomap/direct-io.c  | 7 +++++--
 fs/xfs/xfs_file.c     | 5 +++--
 include/linux/iomap.h | 3 ++-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 997b326247e2..f0caee2b7c00 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -732,7 +732,8 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
+			   is_sync_kiocb(iocb));
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -767,7 +768,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
+			   is_sync_kiocb(iocb));
 
 out:
 	gfs2_glock_dq(&gh);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..1bfa0993f705 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -392,7 +392,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  */
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -400,7 +401,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos, start = pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
-	bool wait_for_completion = is_sync_kiocb(iocb);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
@@ -409,6 +409,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!count)
 		return 0;
 
+	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
+		return -EINVAL;
+
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1ffb179f35d2..0739ba72a82e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -188,7 +188,7 @@ xfs_file_dio_aio_read(
 	file_accessed(iocb->ki_filp);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL, is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -547,7 +547,8 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
+			   is_sync_kiocb(iocb));
 
 	/*
 	 * If unaligned, this is the only IO in-flight. If it has not yet
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7aa5d6117936..76b14cb729dc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -195,7 +195,8 @@ struct iomap_dio_ops {
 };
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.16.4

