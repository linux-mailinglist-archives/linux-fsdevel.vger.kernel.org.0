Return-Path: <linux-fsdevel+bounces-74399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1BCD3A06A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECCC5303D374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADB33858A;
	Mon, 19 Jan 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmigF/rI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63213382CD;
	Mon, 19 Jan 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808745; cv=none; b=eOwjA/RIS97E2aveGqegR7h/KChHdQXbeC0DQ8gtxz6IcFpMrVfqqYelRwmemIZqLiJ8V7ScT5ovbxccxxQiAIKprFI7zYlpKWxToRNXXBuulK4AJwjH8l/aZLWsOkMPLhnC2nl83LoXMW1QPjM1ftCf/YNyzAhi28zb9/LFK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808745; c=relaxed/simple;
	bh=fstN+ttGR1Tkx/SMD4pdGVMR3RICmjyBVfAOdypRaVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVVBejqckJdVfh2gYHKDjXDjBwOx4FtHYQJqtWu0ed2A8eTNvqRxwViexluzSNsZGZfjJg90TrKIRIpqtwzZlhdmTh5Nwok2NjtvIOa4ZYV06PlWSMPbZJZ6x5IFG2M9qXIslPfEnXQvmScE3CMCoEIu0YccGhr0Mzq2gB651Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HmigF/rI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vs0qF2w8oC2H8MjhYecenftcyABjbWpdGAO4a8GAGaY=; b=HmigF/rIdev4qHiRIXdX1qGD7h
	15u0t5OKZRJu2u29qXknxBf/H7MMB6QgyzVoBz14Qm0POs4b0OLBe6WDOXeqHaW+/I+7htf3Cz3bT
	4GXOFox7cRwuKvQLPfbjnf5ZtZVvzvMiaEdYQhUPr+BoerXcYYwgidfiQkU5OC5QPkvrYLkrLEN5s
	mYOoeC/FeVBABN0xmO3+waF3wxYeGL9KPfX7Vwn7ZA8RevylEOf2uOdj/E5zYHS4AM0iUa0Wh8sS/
	3JnKH/MNzyxFH9K+BTMN16AbGwKl7xKiLupNxrAq6/HOlNY5VxTzvFUUUZ2pPJpwfxK+CPrEIHrOi
	d6Y9anxA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjxD-00000001WHG-44F0;
	Mon, 19 Jan 2026 07:45:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/14] xfs: use bounce buffering direct I/O when the device requires stable pages
Date: Mon, 19 Jan 2026 08:44:21 +0100
Message-ID: <20260119074425.4005867-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fix direct I/O on devices that require stable pages by asking iomap
to bounce buffer.  To support this, ioends are used for direct reads
in this case to provide a user context for copying data back from the
bounce buffer.

This fixes qemu when used on devices using T10 protection information
and probably other cases like iSCSI using data digests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c |  8 ++++++--
 fs/xfs/xfs_file.c | 41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 56a544638491..c3c1e149fff4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -103,7 +103,7 @@ xfs_ioend_put_open_zones(
  * IO write completion.
  */
 STATIC void
-xfs_end_ioend(
+xfs_end_ioend_write(
 	struct iomap_ioend	*ioend)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
@@ -202,7 +202,11 @@ xfs_end_io(
 			io_list))) {
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
-		xfs_end_ioend(ioend);
+		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+			iomap_finish_ioends(ioend,
+				blk_status_to_errno(ioend->io_bio.bi_status));
+		else
+			xfs_end_ioend_write(ioend);
 		cond_resched();
 	}
 }
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af3..f6cc63dcf961 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -224,12 +224,34 @@ xfs_ilock_iocb_for_write(
 	return 0;
 }
 
+/*
+ * Bounce buffering dio reads need a user context to copy back the data.
+ * Use an ioend to provide that.
+ */
+static void
+xfs_dio_read_bounce_submit_io(
+	const struct iomap_iter	*iter,
+	struct bio		*bio,
+	loff_t			file_offset)
+{
+	iomap_init_ioend(iter->inode, bio, file_offset, IOMAP_IOEND_DIRECT);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_dio_ops xfs_dio_read_bounce_ops = {
+	.submit_io	= xfs_dio_read_bounce_submit_io,
+	.bio_set	= &iomap_ioend_bioset,
+};
+
 STATIC ssize_t
 xfs_file_dio_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	unsigned int		dio_flags = 0;
+	const struct iomap_dio_ops *dio_ops = NULL;
 	ssize_t			ret;
 
 	trace_xfs_file_direct_read(iocb, to);
@@ -242,7 +264,12 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
+		dio_ops = &xfs_dio_read_bounce_ops;
+		dio_flags |= IOMAP_DIO_BOUNCE;
+	}
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, dio_ops, dio_flags,
+			NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -703,6 +730,8 @@ xfs_file_dio_write_aligned(
 		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
 		iolock = XFS_IOLOCK_SHARED;
 	}
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
+		dio_flags |= IOMAP_DIO_BOUNCE;
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, ops, dops, dio_flags, ac, 0);
 out_unlock:
@@ -750,6 +779,7 @@ xfs_file_dio_write_atomic(
 {
 	unsigned int		iolock = XFS_IOLOCK_SHARED;
 	ssize_t			ret, ocount = iov_iter_count(from);
+	unsigned int		dio_flags = 0;
 	const struct iomap_ops	*dops;
 
 	/*
@@ -777,8 +807,10 @@ xfs_file_dio_write_atomic(
 	}
 
 	trace_xfs_file_direct_write(iocb, from);
-	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
-			0, NULL, 0);
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
+		dio_flags |= IOMAP_DIO_BOUNCE;
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops, dio_flags,
+			NULL, 0);
 
 	/*
 	 * The retry mechanism is based on the ->iomap_begin method returning
@@ -867,6 +899,9 @@ xfs_file_dio_write_unaligned(
 	if (flags & IOMAP_DIO_FORCE_WAIT)
 		inode_dio_wait(VFS_I(ip));
 
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
+		flags |= IOMAP_DIO_BOUNCE;
+
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
 			   &xfs_dio_write_ops, flags, NULL, 0);
-- 
2.47.3


