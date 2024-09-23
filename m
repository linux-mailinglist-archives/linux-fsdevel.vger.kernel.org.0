Return-Path: <linux-fsdevel+bounces-29864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D997EE27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA332280DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66519D885;
	Mon, 23 Sep 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nuwzfLMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5719CD0B;
	Mon, 23 Sep 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105366; cv=none; b=Oj1CpvafVexSMvgMxcycq2TkpIjGUNl/7rkFwpJm42ZKzMB+15D3BJ6w4XicFQPizgUAfN2aqM6T8p9of1g+eCCbJLvckv2gqU1RCFLB+giTcMb8Gu2LihOsMJLT6UNJIXnxX7p4pgXPONZM1KM6FobJvXnLnUSR6K9yvd8XTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105366; c=relaxed/simple;
	bh=2xSfjx7mTYH3CqsMy3bqGwAuT1LVcPEiXBeOHMVgOgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9/wpit4PEQVundzFC1ZyucLEJearYfvY2DchIDGo1CIMH0HRcgC4ppJoAnnwpDdBkY/MKjyGcDifna0CnqRh8VJVXmIUu6MwTUdEsb5N7OfwP4zyMzJxWvSqfHigrHPpyI+AG4C+CewUoll5J0H79TzUqwt4F3x+otiOxKBgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nuwzfLMN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0NscEMk2kiBsYQhLP1xw5CZD+PdKBvBFhROQQNJxM4g=; b=nuwzfLMNV9fKCqTO8o1KEilSD8
	lVSM372s/qp9UJ8HeJIh7tdLI1BkPRZavGs6lfRGYWYuZEuOTyMO13Dv2leKsuzM4z1o22BXyf+Jg
	DgL7BZ+47C40LBfCj2cTTeuKgxKGcamAX99XHwvMVyNZjv5QX7d0aD5deA5I7+qNmaW/+zZVR04ZM
	xbZcR3jgrMyR/kpfSt/PgFQj0E19PheuMEw13Orn4sFUfAqxO+kPsNOjwBAGaULrgFB981s9KYnxv
	0Vlgd54AE21WB33k5QHuUeA+lTQC1RsDk5R1yb1wR/VvD7ZUAzgwfJSZ6aCfI6Dilp10uKePKihUL
	kMECVm0A==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl07-0000000HV8o-31U4;
	Mon, 23 Sep 2024 15:29:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] xfs: factor out a xfs_file_write_zero_eof helper
Date: Mon, 23 Sep 2024 17:28:18 +0200
Message-ID: <20240923152904.1747117-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split a helper from xfs_file_write_checks that just deal with the
post-EOF zeroing to keep the code readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 140 +++++++++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 58 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 412b1d71b52b7d..3efb0da2a910d6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -347,10 +347,77 @@ xfs_file_splice_read(
 	return ret;
 }
 
+/*
+ * Take care of zeroing post-EOF blocks when they might exist.
+ *
+ * Returns 0 if successfully, a negative error for a failure, or 1 if this
+ * function dropped the iolock and reacquired it exclusively and the caller
+ * needs to restart the write sanity checks.
+ */
+static ssize_t
+xfs_file_write_zero_eof(
+	struct kiocb		*iocb,
+	struct iov_iter		*from,
+	unsigned int		*iolock,
+	size_t			count,
+	bool			*drained_dio)
+{
+	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	loff_t			isize;
+
+	/*
+	 * We need to serialise against EOF updates that occur in IO completions
+	 * here. We want to make sure that nobody is changing the size while
+	 * we do this check until we have placed an IO barrier (i.e. hold
+	 * XFS_IOLOCK_EXCL) that prevents new IO from being dispatched.  The
+	 * spinlock effectively forms a memory barrier once we have
+	 * XFS_IOLOCK_EXCL so we are guaranteed to see the latest EOF value and
+	 * hence be able to correctly determine if we need to run zeroing.
+	 */
+	spin_lock(&ip->i_flags_lock);
+	isize = i_size_read(VFS_I(ip));
+	if (iocb->ki_pos <= isize) {
+		spin_unlock(&ip->i_flags_lock);
+		return 0;
+	}
+	spin_unlock(&ip->i_flags_lock);
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	if (!*drained_dio) {
+		/*
+		 * If zeroing is needed and we are currently holding the iolock
+		 * shared, we need to update it to exclusive which implies
+		 * having to redo all checks before.
+		 */
+		if (*iolock == XFS_IOLOCK_SHARED) {
+			xfs_iunlock(ip, *iolock);
+			*iolock = XFS_IOLOCK_EXCL;
+			xfs_ilock(ip, *iolock);
+			iov_iter_reexpand(from, count);
+		}
+
+		/*
+		 * We now have an IO submission barrier in place, but AIO can do
+		 * EOF updates during IO completion and hence we now need to
+		 * wait for all of them to drain.  Non-AIO DIO will have drained
+		 * before we are given the XFS_IOLOCK_EXCL, and so for most
+		 * cases this wait is a no-op.
+		 */
+		inode_dio_wait(VFS_I(ip));
+		*drained_dio = true;
+		return 1;
+	}
+
+	trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
+	return xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
+}
+
 /*
  * Common pre-write limit and setup checks.
  *
- * Called with the iolocked held either shared and exclusive according to
+ * Called with the iolock held either shared and exclusive according to
  * @iolock, and returns with it held.  Might upgrade the iolock to exclusive
  * if called for a direct write beyond i_size.
  */
@@ -360,13 +427,10 @@ xfs_file_write_checks(
 	struct iov_iter		*from,
 	unsigned int		*iolock)
 {
-	struct file		*file = iocb->ki_filp;
-	struct inode		*inode = file->f_mapping->host;
-	struct xfs_inode	*ip = XFS_I(inode);
-	ssize_t			error = 0;
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
 	size_t			count = iov_iter_count(from);
 	bool			drained_dio = false;
-	loff_t			isize;
+	ssize_t			error;
 
 restart:
 	error = generic_write_checks(iocb, from);
@@ -389,7 +453,7 @@ xfs_file_write_checks(
 	 * exclusively.
 	 */
 	if (*iolock == XFS_IOLOCK_SHARED && !IS_NOSEC(inode)) {
-		xfs_iunlock(ip, *iolock);
+		xfs_iunlock(XFS_I(inode), *iolock);
 		*iolock = XFS_IOLOCK_EXCL;
 		error = xfs_ilock_iocb(iocb, *iolock);
 		if (error) {
@@ -400,64 +464,24 @@ xfs_file_write_checks(
 	}
 
 	/*
-	 * If the offset is beyond the size of the file, we need to zero any
+	 * If the offset is beyond the size of the file, we need to zero all
 	 * blocks that fall between the existing EOF and the start of this
-	 * write.  If zeroing is needed and we are currently holding the iolock
-	 * shared, we need to update it to exclusive which implies having to
-	 * redo all checks before.
-	 *
-	 * We need to serialise against EOF updates that occur in IO completions
-	 * here. We want to make sure that nobody is changing the size while we
-	 * do this check until we have placed an IO barrier (i.e.  hold the
-	 * XFS_IOLOCK_EXCL) that prevents new IO from being dispatched.  The
-	 * spinlock effectively forms a memory barrier once we have the
-	 * XFS_IOLOCK_EXCL so we are guaranteed to see the latest EOF value and
-	 * hence be able to correctly determine if we need to run zeroing.
+	 * write.
 	 *
-	 * We can do an unlocked check here safely as IO completion can only
-	 * extend EOF. Truncate is locked out at this point, so the EOF can
-	 * not move backwards, only forwards. Hence we only need to take the
-	 * slow path and spin locks when we are at or beyond the current EOF.
+	 * We can do an unlocked check for i_size here safely as I/O completion
+	 * can only extend EOF.  Truncate is locked out at this point, so the
+	 * EOF can not move backwards, only forwards. Hence we only need to take
+	 * the slow path when we are at or beyond the current EOF.
 	 */
-	if (iocb->ki_pos <= i_size_read(inode))
-		goto out;
-
-	spin_lock(&ip->i_flags_lock);
-	isize = i_size_read(inode);
-	if (iocb->ki_pos > isize) {
-		spin_unlock(&ip->i_flags_lock);
-
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EAGAIN;
-
-		if (!drained_dio) {
-			if (*iolock == XFS_IOLOCK_SHARED) {
-				xfs_iunlock(ip, *iolock);
-				*iolock = XFS_IOLOCK_EXCL;
-				xfs_ilock(ip, *iolock);
-				iov_iter_reexpand(from, count);
-			}
-			/*
-			 * We now have an IO submission barrier in place, but
-			 * AIO can do EOF updates during IO completion and hence
-			 * we now need to wait for all of them to drain. Non-AIO
-			 * DIO will have drained before we are given the
-			 * XFS_IOLOCK_EXCL, and so for most cases this wait is a
-			 * no-op.
-			 */
-			inode_dio_wait(inode);
-			drained_dio = true;
+	if (iocb->ki_pos > i_size_read(inode)) {
+		error = xfs_file_write_zero_eof(iocb, from, iolock, count,
+				&drained_dio);
+		if (error == 1)
 			goto restart;
-		}
-
-		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
-		error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
 		if (error)
 			return error;
-	} else
-		spin_unlock(&ip->i_flags_lock);
+	}
 
-out:
 	return kiocb_modified(iocb);
 }
 
-- 
2.45.2


