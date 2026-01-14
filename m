Return-Path: <linux-fsdevel+bounces-73636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F35D1CEDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BA9C30BAE17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD137BE73;
	Wed, 14 Jan 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Ka/24u/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DA37BE6A;
	Wed, 14 Jan 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376591; cv=none; b=Ri1y9vs7R9VHvPwSLp9ryluZC9eGLSoEwtzytDeSVL9tBx4u5IjgTBEvyD4qp4JhgL5ZeLPIV/pqLoVR8ABrnPzyrI8YoN0+HE6GRQPX2wSrcOVGfnOCQk6EWBykwHaptle2lkrZx5pv1YyqfWyUX5NVG1wGH44AHJ3EMRNeS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376591; c=relaxed/simple;
	bh=fstN+ttGR1Tkx/SMD4pdGVMR3RICmjyBVfAOdypRaVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUGUHCpFZG8zJvmr6NkPwh9UTLDKIWjbDtkxlONRF4oGGZr5XvoMby9k2GjlPQJ/OssWbX9pS7fFnDWnn8JikMIwyDAh9c3lccaiW8Hsudw0bdPi5ig8UeUrR9dkshIexTLT9Ml6E58Ms/Oh9M/ZMbTQeN7UV6XDCfRqhopl9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Ka/24u/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vs0qF2w8oC2H8MjhYecenftcyABjbWpdGAO4a8GAGaY=; b=1Ka/24u/jx3tNWO146+czhB9Fn
	aPocfYEyqnVIgN3qnfmfbQtt1wKCbPGGBzIkAU5cTQKn7QgJUkpqat5YeL70iAOWmqbRqZlnNNOVU
	QJFNKAxIjcNx8k0hfp5ZMo5Wo/CMmigH5n1k0ZYudN94rDIspZDNxBdolJRXqUBhji4mL8W4mdB0v
	W/wQRkJ9KLjo65xZkkCcl3DZbE/jScEMWr+cHew3/mfUYfxAajuDTaA2WjVbZ1jehJix6nbes2aQq
	cq6pRSr3cnzFmYqq9Bxke1Odjuc6QTj6aNrwYwKo2DeHLuST8uNVKGw+LRok9R7PNG17ZxqlzB0sv
	/kA9CD5Q==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWx-00000008E20-0XjB;
	Wed, 14 Jan 2026 07:43:03 +0000
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
Date: Wed, 14 Jan 2026 08:41:12 +0100
Message-ID: <20260114074145.3396036-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
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


