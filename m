Return-Path: <linux-fsdevel+bounces-75439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O1iMWUCd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671384543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC043047517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1B237180;
	Mon, 26 Jan 2026 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ib7d/Bje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EC21B191;
	Mon, 26 Jan 2026 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406934; cv=none; b=nN6RYXzLwqeeVOb+HX01wK8cwCwdPEOCiLs4XNXvhsb7TeABZcYz9sv3dqaSOCM/+h5u08BZqxOuUmCfLpl+vb+1xq0PwKiKCtP/RuUe1Hij0r1/CChD8xpbC+Fi+ZCqceq2KjGYJp9IYSqCl9mllK2dfrGxcFIbTX+aDGmeYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406934; c=relaxed/simple;
	bh=q2Bsw0gvgDGkXLg/9oEIMSI1eoTPG+O7JQVXDyTq9Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcdfszrHi10Dk7pcFRdm3GpCvy4DuMAEYOwGSfvfQBd4ttIlSS/sSpHgxYiZy/MdJJQZpkOQLo1csvnwR3LriU7r2iuLyHkCUR6s+7PLl/LsRtcpSyIavLxj7hJVnZEE0eGjHDnCVa6uMu7ohYWJVkRHlJco0PN1wTSKqG3x3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ib7d/Bje; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sXHZbB43c13fbs5r72Zc9F2JAltuW1UpNZAPhVZROh4=; b=ib7d/BjexXkWz0qKVjuMrg2N18
	3z0U2GdtgZmfKr7b4IbxVLRyatJvbReWXgMvbE0WYcynOJhcr+L57PBUGXK4J9ErnOt7szqpWK7Iy
	Zsj4OpNL92z2u9FpqCRg5uxp3agGavda0R0jPgbCdwL6vDvD0IPwtEcSWipkFJE/lOoD1GIPJN/Yf
	GqxNeTd/XerLuy0IetcckoAjVVPBzv1bHO29oE5tgQa8X/Gi5vAziQTh2svM5UdKewGcf9coHEza/
	Y/nnp8+oysErkFHbiICBR0tt7Sl6Inq3q68eIP/VK5qiDn7LjYk3TZWlScYew6oTKNSGgSeE9FI2s
	5CAtkQ8g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFZU-0000000BxLo-0R71;
	Mon, 26 Jan 2026 05:55:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 15/15] xfs: use bounce buffering direct I/O when the device requires stable pages
Date: Mon, 26 Jan 2026 06:53:46 +0100
Message-ID: <20260126055406.1421026-16-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75439-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 3671384543
X-Rspamd-Action: no action

Fix direct I/O on devices that require stable pages by asking iomap
to bounce buffer.  To support this, ioends are used for direct reads
in this case to provide a user context for copying data back from the
bounce buffer.

This fixes qemu when used on devices using T10 protection information
and probably other cases like iSCSI using data digests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
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


