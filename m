Return-Path: <linux-fsdevel+bounces-74811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAmFFLp3cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF552639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C76F1509C43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4230B44CADD;
	Wed, 21 Jan 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6dAPNii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B844CADC;
	Wed, 21 Jan 2026 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977897; cv=none; b=XDp4cGu+qH7MvqsfqnJtC44BB/74vcx9ybm5GS0rJDL3YccvEkciybsZwgu72c4KpV2YnovzhDLePDgaZBRjzts8NIS+5NPxmmpCHSG/XPE0Qxq4yX8d/I6BZkk3PqyKZzDxMrjdUSQ2enLcutu8w9ClxdBvn9GpZO7MmJ94s14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977897; c=relaxed/simple;
	bh=k0pKIIFT6fcWZWnScMeJJgJrGA3y3DlPf8Pc23JXOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6CpsaXPAtbYiWb0PQdzWsf8F6I6sn9byrsGxOlCVBBl5bFltZcalgd6MTESgHcFPVcuifVg3LuNHQK5BBYTJv86bfjjsfSA0IZ5zu8K7s5dPaXuTGQxkYJ2wRc8NSaTJC2BlL+DE5i5QjjSop3a1dAJp4hzmvaXNypTc5+XJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T6dAPNii; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=agtoUCfvTswu5T9CtD7lXqw0D7N4kQ0ksocEuMt4BJo=; b=T6dAPNii4z2giUQLaQafDXOTqp
	O8EKjSdCFl0/JavCVQnWCbFw2T7/o0FZBC9FpCf14BENOBzTbSdAqVV69KJnxbJRw1ZFrBlwzoCih
	TIU19AHZynifGjWU5Yn2pnQ1aNKDbQ3/Kesd7BhAOpp9BtaB81m/Q+n2P0ZkRGnPZBhQULapoANuO
	tCp5/JvntqAR+LwzFx41Cv0uWnSdfojrwhsiYXzaqWfMxtnxJCQ3LiGaeESxHnvIKSfMbnsByRI16
	PPIHTOrLlVxRs6oQhqxOFCHbEhY6KnxDPWdOq5AxdxE26o32AM9VWWN2/qPmytNVnD95JG7e0g3M0
	bKrJUtmA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRxW-00000004xgi-0kZy;
	Wed, 21 Jan 2026 06:44:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 15/15] xfs: support T10 protection information
Date: Wed, 21 Jan 2026 07:43:23 +0100
Message-ID: <20260121064339.206019-16-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
References: <20260121064339.206019-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74811-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: E7CF552639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for generating / verifying protection information in the file
system.  This is largely done by simply setting the IOMAP_F_INTEGRITY
flag and letting iomap do all of the work.  XFS just has to ensure that
the data read completions for integrity data are run from user context.

For zoned writeback, XFS also has to generate the integrity data itself
as the zoned writeback path is not using the generic writeback_submit
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c  | 47 ++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iomap.c |  9 ++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c3c1e149fff4..4baf0a85271c 100644
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
@@ -741,12 +744,43 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void
+xfs_bio_submit_read(
+	const struct iomap_iter		*iter,
+	struct iomap_read_folio_ctx	*ctx)
+{
+	struct bio			*bio = ctx->read_ctx;
+
+	/* delay read completions to the ioend workqueue */
+	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_read_ops xfs_bio_read_integrity_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= xfs_bio_submit_read,
+	.bio_set		= &iomap_ioend_bioset,
+};
+
+static inline const struct iomap_read_ops *bio_read_ops(struct xfs_inode *ip)
+{
+	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
+		return &xfs_bio_read_integrity_ops;
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
+	struct iomap_read_folio_ctx	ctx = {
+		.cur_folio	= folio,
+		.ops		= bio_read_ops(XFS_I(file->f_mapping->host)),
+	};
+
+	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
 	return 0;
 }
 
@@ -754,7 +788,12 @@ STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx	ctx = {
+		.rac		= rac,
+		.ops		= bio_read_ops(XFS_I(rac->mapping->host)),
+	};
+
+	iomap_readahead(&xfs_read_iomap_ops, &ctx);
 }
 
 static int
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 37a1b33e9045..6ed784894b5a 100644
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


