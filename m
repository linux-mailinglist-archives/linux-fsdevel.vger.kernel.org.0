Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4BA6934
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfICNDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:03:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfICNDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xzRnW2aFKIR4Go6zJR+EkxzYJxdzSlbNaELnTruCoJc=; b=ABd9nv5VNR5t03iP9mtowtvbkK
        FDmmJQ5KD1GaPkJLOgcgBn0prU5glpPTvEzd28SHKwrW+Ab0VizvepBX5bOcZye/XTUHbAlyAQyfl
        5IiOsja6aY7Wsc8gpqsbPqh5ZAYGX62uXySpJrAmbwF+TJqR2qOo9OACdYq8Y0Ek6K5JVgW0dU1us
        EHzThKiC/+BZceJAjcLXoIOftuFYEbV1iqoS2zd4+IqE2ha7xP9i6G5q4FcpcpMNOTLI9WyZ7+1NN
        t1u7FZseMo/OsbOiXcCL+bDwJFngsSNi7IhwNwHld8tKeJ9EiLkjwCdDslVwN9+KBPxytSuTA+wzt
        3Ge4mG6g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58T5-0003sv-1I; Tue, 03 Sep 2019 13:03:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 1/2] iomap: split size and error for iomap_dio_rw ->end_io
Date:   Tue,  3 Sep 2019 15:03:26 +0200
Message-Id: <20190903130327.6023-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903130327.6023-1-hch@lst.de>
References: <20190903130327.6023-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Modify the calling convention for the iomap_dio_rw ->end_io() callback.
Rather than passing either dio->error or dio->size as the 'size' argument,
instead pass both the dio->error and the dio->size value separately.

In the instance that an error occurred during a write, we currently cannot
determine whether any blocks have been allocated beyond the current EOF and
data has subsequently been written to these blocks within the ->end_io()
callback. As a result, we cannot judge whether we should take the truncate
failed write path. Having both dio->error and dio->size will allow us to
perform such checks within this callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
[hch: minor cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 9 +++------
 fs/xfs/xfs_file.c     | 8 +++++---
 include/linux/iomap.h | 4 ++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 10517cea9682..2ccf1c6460d4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -77,13 +77,10 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (dio->end_io) {
-		ret = dio->end_io(iocb,
-				dio->error ? dio->error : dio->size,
-				dio->flags);
-	} else {
+	if (dio->end_io)
+		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
+	else
 		ret = dio->error;
-	}
 
 	if (likely(!ret)) {
 		ret = dio->size;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d952d5962e93..3d8e6db9ef77 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -370,21 +370,23 @@ static int
 xfs_dio_write_end_io(
 	struct kiocb		*iocb,
 	ssize_t			size,
+	int			error,
 	unsigned		flags)
 {
 	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	loff_t			offset = iocb->ki_pos;
 	unsigned int		nofs_flag;
-	int			error = 0;
 
 	trace_xfs_end_io_direct_write(ip, offset, size);
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (size <= 0)
-		return size;
+	if (error)
+		return error;
+	if (!size)
+		return 0;
 
 	/*
 	 * Capture amount written on completion as we can't reliably account
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..50bb746d2216 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
-		unsigned flags);
+typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size, int error,
+				 unsigned int flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
-- 
2.20.1

