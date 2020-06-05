Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E81F0133
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgFEUsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:48:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgFEUsy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:48:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9126AC51;
        Fri,  5 Jun 2020 20:48:55 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     darrick.wong@oracle.com
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/3] xfs: fallback to buffered I/O if direct I/O is short
Date:   Fri,  5 Jun 2020 15:48:38 -0500
Message-Id: <20200605204838.10765-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200605204838.10765-1-rgoldwyn@suse.de>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Most filesystems such as ext4 and btrfs fallback to buffered I/O in case
direct write's fail. In case direct I/O is short, fallback to buffered
write to complete the I/O. Make sure the data is on disk by performing a
filemap_write_and_wait_range() and invalidating the pages in the range.

For reads, call xfs_file_buffered_aio_read() in case of short I/O.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/xfs/xfs_file.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4b8bdecc3863..786391228dea 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,10 @@
 #include <linux/fadvise.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
+STATIC ssize_t xfs_file_buffered_aio_write(struct kiocb *iocb,
+		struct iov_iter	*from);
+STATIC ssize_t xfs_file_buffered_aio_read(struct kiocb *iocb,
+		struct iov_iter	*to);
 
 int
 xfs_update_prealloc_flags(
@@ -169,6 +173,7 @@ xfs_file_dio_aio_read(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	size_t			count = iov_iter_count(to);
 	ssize_t			ret;
+	ssize_t			buffered_read = 0;
 
 	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
 
@@ -187,7 +192,13 @@ xfs_file_dio_aio_read(
 			is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
-	return ret;
+	if (ret < 0 || ret == count)
+		return ret;
+
+	iocb->ki_flags &= ~IOCB_DIRECT;
+	buffered_read = xfs_file_buffered_aio_read(iocb, to);
+
+	return ret + buffered_read;
 }
 
 static noinline ssize_t
@@ -483,6 +494,9 @@ xfs_file_dio_aio_write(
 	int			iolock;
 	size_t			count = iov_iter_count(from);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	loff_t			offset, end;
+	ssize_t			buffered_write = 0;
+	int			err;
 
 	/* DIO must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
@@ -552,12 +566,25 @@ xfs_file_dio_aio_write(
 out:
 	xfs_iunlock(ip, iolock);
 
-	/*
-	 * No fallback to buffered IO on errors for XFS, direct IO will either
-	 * complete fully or fail.
-	 */
-	ASSERT(ret < 0 || ret == count);
-	return ret;
+	if (ret < 0 || ret == count)
+		return ret;
+
+	/* Fallback to buffered write */
+
+	offset = iocb->ki_pos;
+
+	buffered_write = xfs_file_buffered_aio_write(iocb, from);
+	if (buffered_write < 0)
+		return ret;
+
+	end = offset + buffered_write - 1;
+
+	err = filemap_write_and_wait_range(mapping, offset, end);
+	if (!err)
+		invalidate_mapping_pages(mapping, offset >> PAGE_SHIFT,
+				end >> PAGE_SHIFT);
+
+	return ret + buffered_write;
 }
 
 static noinline ssize_t
-- 
2.25.0

