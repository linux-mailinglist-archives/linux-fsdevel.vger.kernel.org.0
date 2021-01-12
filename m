Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C874A2F2549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbhALBIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:53 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:52068 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731358AbhALBIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:53 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 439076633C;
        Tue, 12 Jan 2021 12:08:10 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005WbA-Gq; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qaz-9H; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [PATCH 2/6] iomap: move DIO NOWAIT setup up into filesystems
Date:   Tue, 12 Jan 2021 12:07:42 +1100
Message-Id: <20210112010746.1154363-3-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=iyUNGNZGDjo-1NBN2HwA:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Add a parameter to iomap_dio_rw_args to allow callers to specify
whether nonblocking (NOWAIT) submission semantics should be used by
the DIO. This allows filesystems to add their own non-blocking
contraints to DIO on top of the user specified constraints held in
the iocb.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/btrfs/file.c       | 4 +++-
 fs/ext4/file.c        | 5 +++--
 fs/gfs2/file.c        | 2 ++
 fs/iomap/direct-io.c  | 2 +-
 fs/xfs/xfs_file.c     | 2 ++
 fs/zonefs/super.c     | 7 ++++---
 include/linux/iomap.h | 3 +++
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a49d9fa918d1..2e7c3b7b70fe 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1913,9 +1913,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		.ops			= &btrfs_dio_iomap_ops,
 		.dops			= &btrfs_dio_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
+	if (args.nonblocking)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
 	/* If the write DIO is within EOF, use a shared lock */
@@ -3628,6 +3629,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 		.ops			= &btrfs_dio_iomap_ops,
 		.dops			= &btrfs_dio_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 436508be6d88..0ce5c4cae172 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -472,6 +472,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		.ops			= &ext4_iomap_ops,
 		.dops			= &ext4_dio_write_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	/*
@@ -490,7 +491,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + count > i_size_read(inode))
 		ilock_shared = false;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (args.nonblocking) {
 		if (ilock_shared) {
 			if (!inode_trylock_shared(inode))
 				return -EAGAIN;
@@ -519,7 +520,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ret;
 
 	/* if we're going to block and IOCB_NOWAIT is set, return -EAGAIN */
-	if ((iocb->ki_flags & IOCB_NOWAIT) && (unaligned_io || extend)) {
+	if (args.nonblocking && (unaligned_io || extend)) {
 		ret = -EAGAIN;
 		goto out;
 	}
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index d44a5f9c5f34..ead246202144 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -793,6 +793,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 		.iter			= to,
 		.ops			= &gfs2_iomap_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	if (!count)
@@ -824,6 +825,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 		.iter			= from,
 		.ops			= &gfs2_iomap_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	/*
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 05cacc27578c..c0dd2db1253b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -478,7 +478,7 @@ __iomap_dio_rw(struct iomap_dio_rw_args *args)
 			dio->flags |= IOMAP_DIO_WRITE_FUA;
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (args->nonblocking) {
 		if (filemap_range_has_page(mapping, pos, end)) {
 			ret = -EAGAIN;
 			goto out_free_dio;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 29f4204e551f..3ced2746db4d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -210,6 +210,7 @@ xfs_file_dio_aio_read(
 		.iter			= to,
 		.ops			= &xfs_read_iomap_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
@@ -530,6 +531,7 @@ xfs_file_dio_aio_write(
 		.ops			= &xfs_direct_write_iomap_ops,
 		.dops			= &xfs_dio_write_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	/* DIO must be aligned to device logical sector size */
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index edf353ad1edc..486ff4872077 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -741,6 +741,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		.ops			= &zonefs_iomap_ops,
 		.dops			= &zonefs_write_dio_ops,
 		.wait_for_completion	= sync,
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
 	/*
@@ -748,11 +749,10 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !sync &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !sync && args.nonblocking)
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (args.nonblocking) {
 		if (!inode_trylock(inode))
 			return -EAGAIN;
 	} else {
@@ -922,6 +922,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			.ops			= &zonefs_iomap_ops,
 			.dops			= &zonefs_read_dio_ops,
 			.wait_for_completion	= is_sync_kiocb(iocb),
+			.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 		};
 		size_t count = iov_iter_count(to);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 16d20c01b5bb..3f85fc33a4c9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,7 +261,10 @@ struct iomap_dio_rw_args {
 	struct iov_iter		*iter;
 	const struct iomap_ops	*ops;
 	const struct iomap_dio_ops *dops;
+	/* wait for completion of submitted IO if true */
 	bool			wait_for_completion;
+	/* use non-blocking IO submission semantics if true */
+	bool			nonblocking;
 };
 
 ssize_t iomap_dio_rw(struct iomap_dio_rw_args *args);
-- 
2.28.0

