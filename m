Return-Path: <linux-fsdevel+bounces-77952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EnrEy1WnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:29:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C971E176E0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39D730804F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9387D1DF273;
	Mon, 23 Feb 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TDdsHKH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B883F;
	Mon, 23 Feb 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853040; cv=none; b=Ut6QjxaKp72ytHmX/Rd7NJdv1T0THRELEW9Y5tV+SJjtj8ezWhse7FRY6dLRfWoqNzD4Fc4YrB/WXYS9aLTUwgLpJN3pO39OB4o3d4w1ulDzrvxcKsB70q6F0ssSa8pcku3IGQo/9Wax6HOzkg2jYJoYc47M2XcOPWXsbVXH0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853040; c=relaxed/simple;
	bh=Ia12ckmAsSk8ITdVjaMQMn80Tn4ldTZUd+PU9+DPfks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfvU7sCjD6DeVGewa/ylSOuzFzOHpl8/+DQ9wkcZQXK2W40G2cWbAuYJLepwk8Z0wKzaOFZMrPBn0fEgnjfKkjxTJS7j2iAaa084zBVn7sqPk3j2ASi3pI1mw3i4dlXf+N6f6qJrEFj5qQSM2OktHVQ4U0YnMh5WPUkYTxKc/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TDdsHKH1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UXAA0RQj1ZeglDCy6cgGpo+e4MRe1hdQoQbU6s7Exhg=; b=TDdsHKH1dvUXf+koG6MuLWab3n
	uYHkCudJWJjsd3Jg0IElRn108Ya09Aj45la+bYpovRHz6KwQlnQsCL1656Bd/iIFIl5VGUkzvvidV
	lZiynYydtG0CXo1DjAslUHZ5etFS2dim1tf57gVHniTyDs1xSRZC3mXeuC3sAytkEP9K3hivhTKzG
	U88UP/R/aG4A2PWgSV0MOb4qVB4pUeV3Fcr34Q33OT97NlEQVIsEEq8HTnO5S2ON8tq4MiP/zsQKv
	Ej068v4SSTDYeK0Xw+JpraDhDiRK9SoAZVTwKB7xsRRnTehM26LSI7CdyrKN2YmFQwUltZxbFUjSs
	T+hiOzIA==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVum-00000000MBJ-1v2W;
	Mon, 23 Feb 2026 13:23:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 16/16] xfs: support T10 protection information
Date: Mon, 23 Feb 2026 05:20:16 -0800
Message-ID: <20260223132021.292832-17-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77952-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C971E176E0E
X-Rspamd-Action: no action

Add support for generating / verifying protection information in the file
system.  This is largely done by simply setting the IOMAP_F_INTEGRITY
flag and letting iomap do all of the work.  XFS just has to ensure that
the data read completions for integrity data are run from user context.

For zoned writeback, XFS also has to generate the integrity data itself
as the zoned writeback path is not using the generic writeback_submit
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_aops.c  | 47 ++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iomap.c |  9 ++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76678814f46f..f279055fcea0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include <linux/bio-integrity.h>
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -661,6 +662,8 @@ xfs_zoned_writeback_submit(
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
+	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_generate(&ioend->io_bio);
 	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
 	return 0;
 }
@@ -741,12 +744,45 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void
+xfs_bio_submit_read(
+	const struct iomap_iter		*iter,
+	struct iomap_read_folio_ctx	*ctx)
+{
+	struct bio			*bio = ctx->read_ctx;
+
+	/* defer read completions to the ioend workqueue */
+	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_read_ops xfs_iomap_read_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= xfs_bio_submit_read,
+	.bio_set		= &iomap_ioend_bioset,
+};
+
+static inline const struct iomap_read_ops *
+xfs_get_iomap_read_ops(
+	const struct address_space	*mapping)
+{
+	struct xfs_inode		*ip = XFS_I(mapping->host);
+
+	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
+		return &xfs_iomap_read_ops;
+	return &iomap_bio_read_ops;
+}
+
 STATIC int
 xfs_vm_read_folio(
-	struct file		*unused,
-	struct folio		*folio)
+	struct file			*file,
+	struct folio			*folio)
 {
-	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
+
+	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
+	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
 	return 0;
 }
 
@@ -754,7 +790,10 @@ STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx	ctx = { .rac = rac };
+
+	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
+	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
 }
 
 static int
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..9c2f12d5fec9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -143,11 +143,14 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	if (mapping_flags & IOMAP_DAX)
+	iomap->flags = iomap_flags;
+	if (mapping_flags & IOMAP_DAX) {
 		iomap->dax_dev = target->bt_daxdev;
-	else
+	} else {
 		iomap->bdev = target->bt_bdev;
-	iomap->flags = iomap_flags;
+		if (bdev_has_integrity_csum(iomap->bdev))
+			iomap->flags |= IOMAP_F_INTEGRITY;
+	}
 
 	/*
 	 * If the inode is dirty for datasync purposes, let iomap know so it
-- 
2.47.3


