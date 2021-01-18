Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3103A2FAA65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbhARTlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437587AbhARTki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:40:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C9C061573;
        Mon, 18 Jan 2021 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LNY6NH4JlXLKGL821H88MceF4b+0i+OXCr306izwOcA=; b=J5plapC5ikEFWBeVpEos0b+kU+
        pJDq/LleLbLrffcmzNbUmEfbsRvoYqOtP4HkLQZ0JDxMLiQVtElx2de5eu3XAekqd3pWc5Nt7rf8i
        QfWdbgXYsgGJ/6fPXgjnVrzDkvK4Cc0F1flPZxXCP60X/iaoCjt3cnsmJIKJrbPH6IULBAxq0JjDm
        lt4jAq2GWC24CJA9dMExCcAZI2cfi4xyedVCAf/YnYIlD4o1gnqRS5z7/K0GQzBJnJMj35gFK4VWd
        hc/jpYtDdh0/8SUTg0SJEJnx5BK9fi7pJxNjGkv7Q9ZsSq5zvFii5oc+UvFGFjwV5VaBGXSU7c2fM
        Rgh1f5Ig==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aNO-00DJ1k-HY; Mon, 18 Jan 2021 19:39:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: [PATCH 01/11] xfs: factor out a xfs_ilock_iocb helper
Date:   Mon, 18 Jan 2021 20:35:06 +0100
Message-Id: <20210118193516.2915706-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118193516.2915706-1-hch@lst.de>
References: <20210118193516.2915706-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to factor out the nowait locking logical for the read/write
helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
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

