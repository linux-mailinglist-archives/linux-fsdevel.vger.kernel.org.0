Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77052FE5D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 10:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbhAUJHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbhAUJHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:07:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86891C061757;
        Thu, 21 Jan 2021 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yMXBD3uXS7Xr+YNrdm80QvI+Gbfd0g98bpw+sBpq1p8=; b=W5lizb3TrKzA16PTK2jeAA9iFj
        DT/5IESercQb23bN0lea+YIgGzZ0AT3wqRTWvS4tDQcFkVr7duG6X5yFrLb+ip8JdvvRjOT0lH6y+
        5lELhpnWNuX4lVBd0KasgQugkzSmzA4DZPyiZjccRJH8/vQ6bRnIW5xA8T0SlnYESVQH7eCbmgWSL
        CnfiVlNGGnA7D5ImfPpYxvm2a8khBORh3IYJEgTHvkZVPuPYTqUZQKGqRHEMPEoBnv8yi027UJk7O
        yRwxJAsB9XYOZS/Mb8vGhTaPtuSG6g83iePn5AduqidvEtkzCjEz2kxXYiOCwPr0t0FI7nCEVhHOx
        hueqo5Ng==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Vuy-00GqLe-J0; Thu, 21 Jan 2021 09:06:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 02/11] xfs: make xfs_file_aio_write_checks IOCB_NOWAIT-aware
Date:   Thu, 21 Jan 2021 09:58:57 +0100
Message-Id: <20210121085906.322712-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121085906.322712-1-hch@lst.de>
References: <20210121085906.322712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure we don't block on the iolock, or waiting for I/O in
xfs_file_aio_write_checks if the caller asked to avoid that.

Fixes: 29a5d29ec181 ("xfs: nowait aio support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c441cddfa4acbc..fb4e6f2852bb8b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -335,7 +335,14 @@ xfs_file_aio_write_checks(
 	if (error <= 0)
 		return error;
 
-	error = xfs_break_layouts(inode, iolock, BREAK_WRITE);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		error = break_layout(inode, false);
+		if (error == -EWOULDBLOCK)
+			error = -EAGAIN;
+	} else {
+		error = xfs_break_layouts(inode, iolock, BREAK_WRITE);
+	}
+
 	if (error)
 		return error;
 
@@ -346,7 +353,11 @@ xfs_file_aio_write_checks(
 	if (*iolock == XFS_IOLOCK_SHARED && !IS_NOSEC(inode)) {
 		xfs_iunlock(ip, *iolock);
 		*iolock = XFS_IOLOCK_EXCL;
-		xfs_ilock(ip, *iolock);
+		error = xfs_ilock_iocb(iocb, *iolock);
+		if (error) {
+			*iolock = 0;
+			return error;
+		}
 		goto restart;
 	}
 	/*
@@ -368,6 +379,10 @@ xfs_file_aio_write_checks(
 	isize = i_size_read(inode);
 	if (iocb->ki_pos > isize) {
 		spin_unlock(&ip->i_flags_lock);
+
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+
 		if (!drained_dio) {
 			if (*iolock == XFS_IOLOCK_SHARED) {
 				xfs_iunlock(ip, *iolock);
@@ -593,7 +608,8 @@ xfs_file_dio_aio_write(
 			   &xfs_dio_write_ops,
 			   is_sync_kiocb(iocb) || unaligned_io);
 out:
-	xfs_iunlock(ip, iolock);
+	if (iolock)
+		xfs_iunlock(ip, iolock);
 
 	/*
 	 * No fallback to buffered IO after short writes for XFS, direct I/O
@@ -632,7 +648,8 @@ xfs_file_dax_write(
 		error = xfs_setfilesize(ip, pos, ret);
 	}
 out:
-	xfs_iunlock(ip, iolock);
+	if (iolock)
+		xfs_iunlock(ip, iolock);
 	if (error)
 		return error;
 
-- 
2.29.2

