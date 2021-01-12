Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC802F35C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392547AbhALQ2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbhALQ2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:28:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C855C061795;
        Tue, 12 Jan 2021 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u1O29P/dYV8caCygOxPmBHzno0p91NYDlg6NrcbOsTU=; b=anm9u9CmlVmpsQeKo+0Mh0rcja
        S32LRdzFaVkJWIkeMVkZAeO1akd03Fe+LDPh6GiKrMbtno41EdLqa7EDng7Dpyxb2TanIs/B924IA
        R9LdYfCi9Uz6Ip8nyYML/1o++4ghCWagcVmcJ8XAOCdVLOXLfG3QhZcDZcn0dhJxp7MgHTvkvC4Ey
        wTPbvp5JzMdwg6ZXStJYFVZSlyk3SzvyNQmBerU1rbPBPnP+WfBjJuy7gd7vurOhuFKCD91G2WYlA
        WpQSkGBMY1LhhHKyvDt5iTnT/F0Uwdb2gDDli03vNtMDkaVFYpNpSnPynWN/2GLQ0z3nGwAOlcJZ7
        t0RgElqg==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMW1-0052Cv-9g; Tue, 12 Jan 2021 16:27:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [PATCH 05/10] xfs: simplify the read/write tracepoints
Date:   Tue, 12 Jan 2021 17:26:11 +0100
Message-Id: <20210112162616.2003366-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112162616.2003366-1-hch@lst.de>
References: <20210112162616.2003366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the iocb and iov_iter to the tracepoints and leave decoding of
actual arguments to the code only run when tracing is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 20 ++++++++------------
 fs/xfs/xfs_trace.h | 18 +++++++++---------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 97836ec53397d4..aa64e78fc3c467 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -220,12 +220,11 @@ xfs_file_dio_read(
 	struct iov_iter		*to)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
-	size_t			count = iov_iter_count(to);
 	ssize_t			ret;
 
-	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
+	trace_xfs_file_direct_read(iocb, to);
 
-	if (!count)
+	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
 	file_accessed(iocb->ki_filp);
@@ -246,12 +245,11 @@ xfs_file_dax_read(
 	struct iov_iter		*to)
 {
 	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
-	size_t			count = iov_iter_count(to);
 	ssize_t			ret = 0;
 
-	trace_xfs_file_dax_read(ip, count, iocb->ki_pos);
+	trace_xfs_file_dax_read(iocb, to);
 
-	if (!count)
+	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
@@ -272,7 +270,7 @@ xfs_file_buffered_read(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	ssize_t			ret;
 
-	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
+	trace_xfs_file_buffered_read(iocb, to);
 
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
@@ -599,7 +597,7 @@ xfs_file_dio_write(
 		iolock = XFS_IOLOCK_SHARED;
 	}
 
-	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
+	trace_xfs_file_direct_write(iocb, from);
 	/*
 	 * If unaligned, this is the only IO in-flight. Wait on it before we
 	 * release the iolock to prevent subsequent overlapping IO.
@@ -622,7 +620,6 @@ xfs_file_dax_write(
 	struct xfs_inode	*ip = XFS_I(inode);
 	int			iolock = XFS_IOLOCK_EXCL;
 	ssize_t			ret, error = 0;
-	size_t			count;
 	loff_t			pos;
 
 	ret = xfs_ilock_iocb(iocb, iolock);
@@ -633,9 +630,8 @@ xfs_file_dax_write(
 		goto out;
 
 	pos = iocb->ki_pos;
-	count = iov_iter_count(from);
 
-	trace_xfs_file_dax_write(ip, count, pos);
+	trace_xfs_file_dax_write(iocb, from);
 	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
@@ -683,7 +679,7 @@ xfs_file_buffered_write(
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = inode_to_bdi(inode);
 
-	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
+	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
 			&xfs_buffered_write_iomap_ops);
 	if (likely(ret >= 0))
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 5a263ae3d4f008..a6d04d860a565e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1287,8 +1287,8 @@ TRACE_EVENT(xfs_log_assign_tail_lsn,
 )
 
 DECLARE_EVENT_CLASS(xfs_file_class,
-	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),
-	TP_ARGS(ip, count, offset),
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_ino_t, ino)
@@ -1297,11 +1297,11 @@ DECLARE_EVENT_CLASS(xfs_file_class,
 		__field(size_t, count)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
-		__entry->ino = ip->i_ino;
-		__entry->size = ip->i_d.di_size;
-		__entry->offset = offset;
-		__entry->count = count;
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = XFS_I(file_inode(iocb->ki_filp))->i_ino;
+		__entry->size = XFS_I(file_inode(iocb->ki_filp))->i_d.di_size;
+		__entry->offset = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
 	),
 	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx count 0x%zx",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1313,8 +1313,8 @@ DECLARE_EVENT_CLASS(xfs_file_class,
 
 #define DEFINE_RW_EVENT(name)		\
 DEFINE_EVENT(xfs_file_class, name,	\
-	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),	\
-	TP_ARGS(ip, count, offset))
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),		\
+	TP_ARGS(iocb, iter))
 DEFINE_RW_EVENT(xfs_file_buffered_read);
 DEFINE_RW_EVENT(xfs_file_direct_read);
 DEFINE_RW_EVENT(xfs_file_dax_read);
-- 
2.29.2

