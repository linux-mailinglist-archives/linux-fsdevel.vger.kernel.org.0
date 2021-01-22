Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A293008B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbhAVQaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbhAVQaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:30:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191AC0613D6;
        Fri, 22 Jan 2021 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7yDv+i0eIg8ZvTjuDWGz32b4qM8yWB/b7IST0cofvso=; b=fWIimBfn5uj+rYocxj2U6BwDDk
        hxqDig/ECh7KywOxb05sZydtqH6PGSb/0bxkIdiOB/mZEaBp3KzMjSV5NuGwGAmFmvEZ30VKBeW/I
        jRUlVcuM4byT5/Ux1hTuh43oaRS5JM4iRgJbaOVk2PsZDTsbcyLe0fAKZXKjfLCl5a0ypydDj0qCc
        mZYj/spw036gWLBYugwPYYdWyC/kH7gfmj34OvOGU5JDAU0HydLCVoS/VV8odDB9IKpaN4zDvluA9
        2VUsI0qysqkzVHQgVqF62yXvLELbzMm6xEXin25RUuB/kbAYPi13eFhZm0mKukWWluJ2uxGQnH77T
        o0U4bcOw==;
Received: from [2001:4bb8:188:1954:662b:86d3:ab5f:ac21] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zIl-000xX9-UU; Fri, 22 Jan 2021 16:28:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 03/11] xfs: cleanup the read/write helper naming
Date:   Fri, 22 Jan 2021 17:20:35 +0100
Message-Id: <20210122162043.616755-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122162043.616755-1-hch@lst.de>
References: <20210122162043.616755-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop a few pointless aio_ prefixes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fb4e6f2852bb8b..ae7313ccaa11ed 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -215,7 +215,7 @@ xfs_ilock_iocb(
 }
 
 STATIC ssize_t
-xfs_file_dio_aio_read(
+xfs_file_dio_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
@@ -265,7 +265,7 @@ xfs_file_dax_read(
 }
 
 STATIC ssize_t
-xfs_file_buffered_aio_read(
+xfs_file_buffered_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
@@ -300,9 +300,9 @@ xfs_file_read_iter(
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
-		ret = xfs_file_dio_aio_read(iocb, to);
+		ret = xfs_file_dio_read(iocb, to);
 	else
-		ret = xfs_file_buffered_aio_read(iocb, to);
+		ret = xfs_file_buffered_read(iocb, to);
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
@@ -317,7 +317,7 @@ xfs_file_read_iter(
  * if called for a direct write beyond i_size.
  */
 STATIC ssize_t
-xfs_file_aio_write_checks(
+xfs_file_write_checks(
 	struct kiocb		*iocb,
 	struct iov_iter		*from,
 	int			*iolock)
@@ -502,7 +502,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 };
 
 /*
- * xfs_file_dio_aio_write - handle direct IO writes
+ * xfs_file_dio_write - handle direct IO writes
  *
  * Lock the inode appropriately to prepare for and issue a direct IO write.
  * By separating it from the buffered write path we remove all the tricky to
@@ -527,7 +527,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
  * negative return values.
  */
 STATIC ssize_t
-xfs_file_dio_aio_write(
+xfs_file_dio_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
@@ -549,7 +549,7 @@ xfs_file_dio_aio_write(
 	/*
 	 * Don't take the exclusive iolock here unless the I/O is unaligned to
 	 * the file system block size.  We don't need to consider the EOF
-	 * extension case here because xfs_file_aio_write_checks() will relock
+	 * extension case here because xfs_file_write_checks() will relock
 	 * the inode as necessary for EOF zeroing cases and fill out the new
 	 * inode size as appropriate.
 	 */
@@ -580,7 +580,7 @@ xfs_file_dio_aio_write(
 		xfs_ilock(ip, iolock);
 	}
 
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
+	ret = xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
 		goto out;
 	count = iov_iter_count(from);
@@ -590,7 +590,7 @@ xfs_file_dio_aio_write(
 	 * in-flight at the same time or we risk data corruption. Wait for all
 	 * other IO to drain before we submit. If the IO is aligned, demote the
 	 * iolock if we had to take the exclusive lock in
-	 * xfs_file_aio_write_checks() for other reasons.
+	 * xfs_file_write_checks() for other reasons.
 	 */
 	if (unaligned_io) {
 		inode_dio_wait(inode);
@@ -634,7 +634,7 @@ xfs_file_dax_write(
 	ret = xfs_ilock_iocb(iocb, iolock);
 	if (ret)
 		return ret;
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
+	ret = xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
 		goto out;
 
@@ -663,7 +663,7 @@ xfs_file_dax_write(
 }
 
 STATIC ssize_t
-xfs_file_buffered_aio_write(
+xfs_file_buffered_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
@@ -682,7 +682,7 @@ xfs_file_buffered_aio_write(
 	iolock = XFS_IOLOCK_EXCL;
 	xfs_ilock(ip, iolock);
 
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
+	ret = xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
 		goto out;
 
@@ -769,12 +769,12 @@ xfs_file_write_iter(
 		 * CoW.  In all other directio scenarios we do not
 		 * allow an operation to fall back to buffered mode.
 		 */
-		ret = xfs_file_dio_aio_write(iocb, from);
+		ret = xfs_file_dio_write(iocb, from);
 		if (ret != -ENOTBLK)
 			return ret;
 	}
 
-	return xfs_file_buffered_aio_write(iocb, from);
+	return xfs_file_buffered_write(iocb, from);
 }
 
 static void
-- 
2.29.2

