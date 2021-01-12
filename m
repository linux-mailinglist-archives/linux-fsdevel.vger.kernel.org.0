Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F42F35B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392196AbhALQ1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392162AbhALQ1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:27:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F7BC061795;
        Tue, 12 Jan 2021 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U4TNttCTzO8AVoz3r/I2T8BRe2Ywej16S1VOWPSVT+Q=; b=G2SxzKRDoL2wZmsl/qy+Z5IsVU
        vde7/cMj9zddJT+an9hJkWns8c8T3xJN98EAzb3Rj4yL4BQvg+jmx/PMb6mTU87x0Q05cvmcOWOMf
        7EUFecWwvbbkNR6gpithYWUX1eoEELuAnjcDdcjKzW4r/U5FRPrhgmDJ9UEOq8NRa5vti+F0hGCE2
        Uw2p8lNQQ3WLLR6nvJub2PMlxMmD+mxHBTVvegf+zxO05Ry2cdlO13ZibKrGa0GMzqhouoXgFfmJk
        BGe6rvLHAwtrQcsLjC1HA0KwkZ5iOsvM8TVnhvCPO+La9F+ctqXeca6AgkEoLHqDFhQBw6WqV64wf
        ALfU/vHw==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMV9-0052Ae-T2; Tue, 12 Jan 2021 16:26:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Brian Foster <bfoster@redhat.com>
Subject: [PATCH 01/10] xfs: factor out a xfs_ilock_iocb helper
Date:   Tue, 12 Jan 2021 17:26:07 +0100
Message-Id: <20210112162616.2003366-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112162616.2003366-1-hch@lst.de>
References: <20210112162616.2003366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to factor out the nowait locking logical for the read/write
helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_file.c | 55 +++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f738372d..c441cddfa4acbc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -197,6 +197,23 @@ xfs_file_fsync(
 	return error;
 }
 
+static int
+xfs_ilock_iocb(
+	struct kiocb		*iocb,
+	unsigned int		lock_mode)
+{
+	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!xfs_ilock_nowait(ip, lock_mode))
+			return -EAGAIN;
+	} else {
+		xfs_ilock(ip, lock_mode);
+	}
+
+	return 0;
+}
+
 STATIC ssize_t
 xfs_file_dio_aio_read(
 	struct kiocb		*iocb,
@@ -213,12 +230,9 @@ xfs_file_dio_aio_read(
 
 	file_accessed(iocb->ki_filp);
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
+	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	if (ret)
+		return ret;
 	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
 			is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
@@ -240,13 +254,9 @@ xfs_file_dax_read(
 	if (!count)
 		return 0; /* skip atime */
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
-
+	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	if (ret)
+		return ret;
 	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
@@ -264,12 +274,9 @@ xfs_file_buffered_aio_read(
 
 	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
+	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	if (ret)
+		return ret;
 	ret = generic_file_read_iter(iocb, to);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
@@ -608,13 +615,9 @@ xfs_file_dax_write(
 	size_t			count;
 	loff_t			pos;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
-	}
-
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
 	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
 	if (ret)
 		goto out;
-- 
2.29.2

