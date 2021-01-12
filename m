Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6F2F253F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbhALBIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:35 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37063 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731224AbhALBIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:35 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F2FF33E5D08;
        Tue, 12 Jan 2021 12:07:51 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005WbG-IK; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qb5-B0; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [PATCH 4/6] xfs: make xfs_file_aio_write_checks IOCB_NOWAIT-aware
Date:   Tue, 12 Jan 2021 12:07:44 +1100
Message-Id: <20210112010746.1154363-5-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=BJ1VQgRmi8QOorsWphoA:9 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Ensure we don't block on the iolock, or waiting for I/O in
xfs_file_aio_write_checks if the caller asked to avoid that.

Fixes: 29a5d29ec181 ("xfs: nowait aio support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4eb4555516e4..512833ce1d41 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -341,7 +341,14 @@ xfs_file_aio_write_checks(
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
 
@@ -352,7 +359,11 @@ xfs_file_aio_write_checks(
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
@@ -374,6 +385,10 @@ xfs_file_aio_write_checks(
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
@@ -607,7 +622,8 @@ xfs_file_dio_aio_write(
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
 	ret = iomap_dio_rw(&args);
 out:
-	xfs_iunlock(ip, iolock);
+	if (iolock)
+		xfs_iunlock(ip, iolock);
 
 	/*
 	 * No fallback to buffered IO after short writes for XFS, direct I/O
@@ -646,7 +662,8 @@ xfs_file_dax_write(
 		error = xfs_setfilesize(ip, pos, ret);
 	}
 out:
-	xfs_iunlock(ip, iolock);
+	if (iolock)
+		xfs_iunlock(ip, iolock);
 	if (error)
 		return error;
 
-- 
2.28.0

