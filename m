Return-Path: <linux-fsdevel+bounces-29939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ABD983F75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746542821E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA614901B;
	Tue, 24 Sep 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MO1sP74O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85814D6ED;
	Tue, 24 Sep 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163693; cv=none; b=YJyeUy9rkZOkRhTHcxmGvVo35cdjAzRZhXaWyhcR4AEsHLfnwrrKwxCOMLbDvWGaHOMaodlrhhfJzEdcfbWfrl1hd/HHg7qiOFmeXoNyX5XcqOPRuaKXXpbE+yNQfQJzcFwPwR5iqmEakqK4gQu6CbPuos24VPlbvU+My570zDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163693; c=relaxed/simple;
	bh=nZjJmKpMm8ZBtnOAVKECTVFjT41bhblSGnQ/8mPywis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK3gNF6faEBTONj0vJodSy4Ta9iIqf+oAaydrizU1OYTiOvASz3F8+oe6guH8oerG9R6sxDfOy9nfz6oi9QKx/aAIPJku6F8JTsykmVc4we8IUUKmFzAXPJJ0XRyXzXyhC9h1rkzaqh64IJXybVQATmgAFDqzd0rxOZ58zm/Z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MO1sP74O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4AIJn7Zl7wCUZ7QHTaZaN6UoG7lkQkbVKaBIMBlzBY0=; b=MO1sP74OQ8WVo/WXJ67c2pwHGF
	WcxlV16mFzXcG7GdRxm13SpY8MHfW9xxqgSKA8QjCY2NiO7cQLFWWPVbing2QKXh5yA0pn4oj3CEL
	u3qrgKqohl9yh48rtPfTwrTAmETrTgrQE5AjMrHwFH9WEo5T+Q8cJUtAz9UpxLpeyp/g3xwKnP/MC
	nzHKLFWMrnGwOAoGHTPtWYkVstZj/wST51KSsdjumjZMdgbZc4vy1E8rKyKuPvjc6pliisgQDfZAs
	szCAaoUDE7U2kE0H7UVCQEaLUv060uK+jS8XOoUhhSfpkZIhiBdZVHo7HXCmz43/LtAyEnCx/MoH5
	WwqkQ1hQ==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0As-00000001SL4-2iIR;
	Tue, 24 Sep 2024 07:41:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] xfs: factor out a xfs_file_write_zero_eof helper
Date: Tue, 24 Sep 2024 09:40:46 +0200
Message-ID: <20240924074115.1797231-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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


