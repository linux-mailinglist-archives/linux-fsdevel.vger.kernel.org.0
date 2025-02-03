Return-Path: <linux-fsdevel+bounces-40584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC9A25626
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4B164DBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449620102C;
	Mon,  3 Feb 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1BJo2zXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336F1FFC4C;
	Mon,  3 Feb 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575824; cv=none; b=EXUD6x3MNRQbmguhaH7D3RYTgqnb0KS5ol3DyTavYESoL19z0w+V6SwNmochSq0iyXaXXrOyIL+o6uh/u9elP04hAdIfoRNx/UmwOzo1vR4328of3lYdyDAQcIhedOWurZevOeYTG3/TR3m7b0l8vzNfvXVktpTXApy81ZVoXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575824; c=relaxed/simple;
	bh=eWgMtLSItRFRCilpI5gkDAfvNqJI7R7VVvazggB1HDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHo08XA70MyH1D5A/7i2+UP7fSomXOuSIJW+clvcVcvD5A80w6q+aE2LfM005TGokjoKOtPF2H5vFvV8ZdOnhoKb/9e9PXc0ezgMGN78es2DbNj5wUiVZIG8daJESOj6Nph4htlxwsDiXSs63NYpJ8pkYMSt5T0tpR4GiMPmn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1BJo2zXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FcXkIA/5Yfj+mlhdUB2rXIYPv6sZBOXhbPnnA7cZBDk=; b=1BJo2zXK/VRXdBOv4FSllrnv7k
	/3uZsytlF4JSwnFgawnglAOAX6ZJKJ9xC/MYH8Vj2kwRo81qBmlqu20O1QCC+vEYjIgXcTgbfU2GK
	DtylnMGp3tdJjzayzrEEdvhkw0u4AiEyE32lB40ikYT9EFDXjsqZavCTQmyjuSDS3Yj0zVn7kfWDT
	Oj+zab/pKiSoftKUvDbT3n/2r8/EWjIWjDT4gKkQjR65LvVn6+sAIfqxzcVmExhWx1X0V2sXEjKPY
	Y6DsJQXr65imevvpnGpl1s9V8e15QjDaSaAPSM03xxi6SmGdjvqHWjFbVSYn6XxCvAqZM0PMWfeaz
	beNq4mPg==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszV-0000000F1jm-28pr;
	Mon, 03 Feb 2025 09:43:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 6/7] xfs: support T10 protection information
Date: Mon,  3 Feb 2025 10:43:10 +0100
Message-ID: <20250203094322.1809766-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add support for generating / verifying protection information in the
file system.  This is done by hooking into the bio submission in
iomap and then using the generic PI helpers.  Compared to just using
the block layer auto PI this extends the protection envelope and also
prepares for eventually passing through PI from userspace at least
for direct I/O.

Right now this is still pretty hacky, e.g. the single PI buffer can
get pretty gigantic and has no mempool backing it.  The deferring of
I/O completions is done unconditionally instead only when needed,
and we assume the device can actually handle these huge segments.
The latter should be fixed by doing proper splitting based on metadata
limits in the block layer, but the rest needs to be addressed here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/Makefile        |  1 +
 fs/xfs/xfs_aops.c      | 29 +++++++++++++++--
 fs/xfs/xfs_aops.h      |  1 +
 fs/xfs/xfs_data_csum.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_data_csum.h |  7 ++++
 fs/xfs/xfs_file.c      | 27 +++++++++++++++-
 fs/xfs/xfs_inode.h     |  6 ++--
 7 files changed, 136 insertions(+), 8 deletions(-)
 create mode 100644 fs/xfs/xfs_data_csum.c
 create mode 100644 fs/xfs/xfs_data_csum.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 7afa51e41427..aa8749d640e7 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -73,6 +73,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_bmap_util.o \
 				   xfs_bio_io.o \
 				   xfs_buf.o \
+				   xfs_data_csum.o \
 				   xfs_dahash_test.o \
 				   xfs_dir2_readdir.o \
 				   xfs_discard.o \
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3e42a684cce1..291f5d4dbce6 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -19,6 +19,7 @@
 #include "xfs_reflink.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
+#include "xfs_data_csum.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -122,6 +123,11 @@ xfs_end_ioend(
 		goto done;
 	}
 
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ) {
+		error = xfs_data_csum_verify(ioend);
+		goto done;
+	}
+
 	/*
 	 * Success: commit the COW or unwritten blocks if needed.
 	 */
@@ -175,7 +181,7 @@ xfs_end_io(
 	}
 }
 
-STATIC void
+void
 xfs_end_bio(
 	struct bio		*bio)
 {
@@ -417,6 +423,8 @@ xfs_submit_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
+	xfs_data_csum_generate(&ioend->io_bio);
+
 	/* send ioends that might require a transaction to the completion wq */
 	if (xfs_ioend_is_append(ioend) ||
 	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
@@ -517,19 +525,34 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void xfs_buffered_read_submit_io(struct inode *inode,
+		struct bio *bio, loff_t file_offset)
+{
+	xfs_data_csum_alloc(bio);
+	iomap_init_ioend(inode, bio, file_offset, 0);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_read_folio_ops xfs_iomap_read_ops = {
+	.bio_set	= &iomap_ioend_bioset,
+	.submit_io	= xfs_buffered_read_submit_io,
+};
+
 STATIC int
 xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops,
+			&xfs_iomap_read_ops);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
+	iomap_readahead(rac, &xfs_read_iomap_ops, &xfs_iomap_read_ops);
 }
 
 static int
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index e0bd68419764..efed1ab59dbf 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -10,5 +10,6 @@ extern const struct address_space_operations xfs_address_space_operations;
 extern const struct address_space_operations xfs_dax_aops;
 
 int	xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
+void	xfs_end_bio(struct bio *bio);
 
 #endif /* __XFS_AOPS_H__ */
diff --git a/fs/xfs/xfs_data_csum.c b/fs/xfs/xfs_data_csum.c
new file mode 100644
index 000000000000..d9d3620654b1
--- /dev/null
+++ b/fs/xfs/xfs_data_csum.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2025 Christoph Hellwig.
+ */
+#include "xfs.h"
+#include "xfs_format.h"
+#include "xfs_shared.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_cksum.h"
+#include "xfs_data_csum.h"
+#include <linux/iomap.h>
+#include <linux/blk-integrity.h>
+#include <linux/bio-integrity.h>
+
+void *
+xfs_data_csum_alloc(
+	struct bio		*bio)
+{
+	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip;
+	unsigned int		buf_size;
+	void			*buf;
+
+	if (!bi)
+		return NULL;
+
+	buf_size = bio_integrity_bytes(bi, bio_sectors(bio));
+	/* XXX: this needs proper mempools */
+	/* XXX: needs (partial) zeroing if tuple_size > csum_size */
+	buf = kmalloc(buf_size, GFP_NOFS | __GFP_NOFAIL);
+	bip = bio_integrity_alloc(bio, GFP_NOFS | __GFP_NOFAIL, 1);
+	if (!bio_integrity_add_page(bio, virt_to_page(buf), buf_size,
+			offset_in_page(buf)))
+		WARN_ON_ONCE(1);
+
+	if (bi->csum_type) {
+		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
+			bip->bip_flags |= BIP_IP_CHECKSUM;
+		bip->bip_flags |= BIP_CHECK_GUARD;
+	}
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		bip->bip_flags |= BIP_CHECK_REFTAG;
+	bip_set_seed(bip, bio->bi_iter.bi_sector);
+
+	return buf;
+}
+
+void
+xfs_data_csum_generate(
+	struct bio		*bio)
+{
+	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (!bi || !bi->csum_type)
+		return;
+
+	xfs_data_csum_alloc(bio);
+	blk_integrity_generate(bio);
+}
+
+int
+xfs_data_csum_verify(
+	struct iomap_ioend	*ioend)
+{
+	struct bio		*bio = &ioend->io_bio;
+	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (!bi || !bi->csum_type)
+		return 0;
+	return blk_integrity_verify_all(bio, ioend->io_sector);
+}
diff --git a/fs/xfs/xfs_data_csum.h b/fs/xfs/xfs_data_csum.h
new file mode 100644
index 000000000000..f32215e8f46c
--- /dev/null
+++ b/fs/xfs/xfs_data_csum.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct iomap_ioend;
+
+void *xfs_data_csum_alloc(struct bio *bio);
+void xfs_data_csum_generate(struct bio *bio);
+int xfs_data_csum_verify(struct iomap_ioend *ioend);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7a7d89c345e..0d64c54017f0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -25,6 +25,8 @@
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
 #include "xfs_file.h"
+#include "xfs_data_csum.h"
+#include "xfs_aops.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
@@ -227,6 +229,20 @@ xfs_ilock_iocb_for_write(
 	return 0;
 }
 
+static void xfs_dio_read_submit_io(const struct iomap_iter *iter,
+		struct bio *bio, loff_t file_offset)
+{
+	xfs_data_csum_alloc(bio);
+	iomap_init_ioend(iter->inode, bio, file_offset, IOMAP_IOEND_DIRECT);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_dio_ops xfs_dio_read_ops = {
+	.bio_set	= &iomap_ioend_bioset,
+	.submit_io	= xfs_dio_read_submit_io,
+};
+
 STATIC ssize_t
 xfs_file_dio_read(
 	struct kiocb		*iocb,
@@ -245,7 +261,8 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, &xfs_dio_read_ops, 0,
+			NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -578,8 +595,16 @@ xfs_dio_write_end_io(
 	return error;
 }
 
+static void xfs_dio_write_submit_io(const struct iomap_iter *iter,
+		struct bio *bio, loff_t file_offset)
+{
+	xfs_data_csum_generate(bio);
+	submit_bio(bio);
+}
+
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
+	.submit_io	= xfs_dio_write_submit_io,
 };
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c08093a65352..ff346bbe454c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -609,10 +609,8 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 
 static inline void xfs_update_stable_writes(struct xfs_inode *ip)
 {
-	if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
-		mapping_set_stable_writes(VFS_I(ip)->i_mapping);
-	else
-		mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
+	/* XXX: unconditional for now */
+	mapping_set_stable_writes(VFS_I(ip)->i_mapping);
 }
 
 /*
-- 
2.45.2


