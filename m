Return-Path: <linux-fsdevel+bounces-77512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CpXGWBZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:17:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3F153649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF54308F816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC930B510;
	Wed, 18 Feb 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="152zd6ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F02E1F11;
	Wed, 18 Feb 2026 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395237; cv=none; b=ViSe2SaaNc7A5zQTSo8kfqFKB6dnEPtWxl1VOnRrD4eNQ4P6lqbKjAXN+001V4DZAb/2pebC8hrprIKMUWGSUxYFXtploaJqTu66BrENppmREbEAgqml+dAYnKNuOkoThieasn1dQODxfI7rQRSxcobLBJKOBEVXRa8HgrX+YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395237; c=relaxed/simple;
	bh=FtIi1HBS3ZBDkiPKUTnGtyTv1h6coj1ssKxstALYxvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYy0hFETXGhmno9OkIW5rUoIALt2HG6HQqPkhE+oFMkAdvOQWkWBq6D7bw0Y2nBKqAnvMDGVS9ZODBVF82PMunJuV80CMjxmY3chg0nR4u5/Pd+FNh7BO+P3eNDooQaJycv/fbcBXpqbWzUZHDY/p5gDH/kbX++EleMxN/Ed0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=152zd6ud; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2ZrKaUeLz68CdRrjgcS8AAqe3IGa5FSVazOIMbvdQzU=; b=152zd6ud+8PuhPYuW0Aq34kli0
	HSKc6UL2tAwaXJOi+iuBEJAXPlNWSdn2FLpF1etjtDIpu8p+ryojvbYexByDQula/VWFu1XqFOV4K
	DeAa4T1cEvP8hqX/bOZ1cU3M7cRvJ79wkIc+LZxtVeUFDY2L+18UTadqykaPjsEakGZhfW8o8Zy0n
	VmWR7XeEJ6gCDda0YNlCn2NrCerUbdIB1Zh/cT9Ro9DYFQe4v66skANDhq6/C+uwQJmwOak130+aO
	RgrXWSJP3opUle7Ni5qpDe5dEddGOV+RKRKMz0H5MnWlqsN+fG2v/VkUMj8OSwD/ryfWXP6mTFejh
	2Pc55new==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaos-00000009LVY-2GYA;
	Wed, 18 Feb 2026 06:13:54 +0000
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
Subject: [PATCH 14/15] iomap: support T10 protection information
Date: Wed, 18 Feb 2026 07:12:08 +0100
Message-ID: <20260218061238.3317841-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061238.3317841-1-hch@lst.de>
References: <20260218061238.3317841-1-hch@lst.de>
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
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77512-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0D3F153649
X-Rspamd-Action: no action

Add support for generating / verifying protection information in iomap.
This is done by hooking into the bio submission and then using the
generic PI helpers.  Compared to just using the block layer auto PI
this extends the protection envelope and also prepares for eventually
passing through PI from userspace at least for direct I/O.

To generate or verify PI, the file system needs to set the
IOMAP_F_INTEGRITY flag on the iomap for the request, and ensure the
ioends are used for all integrity I/O.  Additionally the file system
must defer read I/O completions to user context so that the guard
tag validation isn't run from interrupt context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c        | 24 +++++++++++++++++++++---
 fs/iomap/direct-io.c  | 15 ++++++++++++++-
 fs/iomap/internal.h   | 13 +++++++++++++
 fs/iomap/ioend.c      | 20 ++++++++++++++++++--
 include/linux/iomap.h |  7 +++++++
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index b4de67bdd513..f989ffcaac96 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (C) 2016-2023 Christoph Hellwig.
  */
+#include <linux/bio-integrity.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include "internal.h"
@@ -17,6 +18,8 @@ static u32 __iomap_read_end_io(struct bio *bio, int error)
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
 		folio_count++;
 	}
+	if (bio_integrity(bio))
+		fs_bio_integrity_free(bio);
 	bio_put(bio);
 	return folio_count;
 }
@@ -34,7 +37,11 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
 static void iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	submit_bio(ctx->read_ctx);
+	struct bio *bio = ctx->read_ctx;
+
+	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_alloc(bio);
+	submit_bio(bio);
 }
 
 static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
@@ -91,6 +98,7 @@ int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 
 	if (!bio ||
 	    bio_end_sector(bio) != iomap_sector(&iter->iomap, iter->pos) ||
+	    bio->bi_iter.bi_size > iomap_max_bio_size(&iter->iomap) - plen ||
 	    !bio_add_folio(bio, folio, plen, offset_in_folio(folio, iter->pos)))
 		iomap_read_alloc_bio(iter, ctx, plen);
 	return 0;
@@ -107,11 +115,21 @@ int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	sector_t sector = iomap_sector(srcmap, pos);
 	struct bio_vec bvec;
 	struct bio bio;
+	int error;
 
 	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio.bi_iter.bi_sector = sector;
 	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
-	return submit_bio_wait(&bio);
+	if (srcmap->flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_alloc(&bio);
+	error = submit_bio_wait(&bio);
+	if (srcmap->flags & IOMAP_F_INTEGRITY) {
+		if (!error)
+			error = fs_bio_integrity_verify(&bio, sector, len);
+		fs_bio_integrity_free(&bio);
+	}
+	return error;
 }
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2ad7c70a4ccb..b0172da3be49 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (c) 2016-2025 Christoph Hellwig.
  */
+#include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
 #include <linux/fscrypt.h>
 #include <linux/pagemap.h>
@@ -227,6 +228,9 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
+	if (bio_integrity(bio))
+		fs_bio_integrity_free(bio);
+
 	if (dio->flags & IOMAP_DIO_BOUNCE) {
 		bio_iov_iter_unbounce(bio, !!dio->error,
 				dio->flags & IOMAP_DIO_USER_BACKED);
@@ -337,8 +341,10 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
+
 	if (dio->flags & IOMAP_DIO_BOUNCE)
-		ret = bio_iov_iter_bounce(bio, dio->submit.iter, BIO_MAX_SIZE);
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter,
+				iomap_max_bio_size(&iter->iomap));
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
 					     alignment - 1);
@@ -355,6 +361,13 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		goto out_put_bio;
 	}
 
+	if (iter->iomap.flags & IOMAP_F_INTEGRITY) {
+		if (dio->flags & IOMAP_DIO_WRITE)
+			fs_bio_integrity_generate(bio);
+		else
+			fs_bio_integrity_alloc(bio);
+	}
+
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
 	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index b39dbc17e3f0..74e898b196dc 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,6 +4,19 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+/*
+ * Normally we can build bios as big as the data structure supports.
+ *
+ * But for integrity protected I/O we need to respect the maximum size of the
+ * single contiguous allocation for the integrity buffer.
+ */
+static inline size_t iomap_max_bio_size(const struct iomap *iomap)
+{
+	if (iomap->flags & IOMAP_F_INTEGRITY)
+		return max_integrity_io_size(bdev_limits(iomap->bdev));
+	return BIO_MAX_SIZE;
+}
+
 u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index c6b6cd0f2fdd..bf251d206f50 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2016-2025 Christoph Hellwig.
  */
+#include <linux/bio-integrity.h>
 #include <linux/iomap.h>
 #include <linux/list_sort.h>
 #include <linux/pagemap.h>
@@ -65,6 +66,8 @@ static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
 		folio_count++;
 	}
 
+	if (bio_integrity(bio))
+		fs_bio_integrity_free(bio);
 	bio_put(bio);	/* frees the ioend */
 	return folio_count;
 }
@@ -98,6 +101,8 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		return error;
 	}
 
+	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_generate(&ioend->io_bio);
 	submit_bio(&ioend->io_bio);
 	return 0;
 }
@@ -119,10 +124,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 }
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
-		u16 ioend_flags)
+		unsigned int map_len, u16 ioend_flags)
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
 
+	if (ioend->io_bio.bi_iter.bi_size >
+	    iomap_max_bio_size(&wpc->iomap) - map_len)
+		return false;
 	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
 	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
@@ -187,7 +195,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
-	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, map_len, ioend_flags)) {
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
@@ -264,6 +272,14 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	if (!atomic_dec_and_test(&ioend->io_remaining))
 		return 0;
+
+	if (!ioend->io_error &&
+	    bio_integrity(&ioend->io_bio) &&
+	    bio_op(&ioend->io_bio) == REQ_OP_READ) {
+		ioend->io_error = fs_bio_integrity_verify(&ioend->io_bio,
+			ioend->io_sector, ioend->io_size);
+	}
+
 	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
 		return iomap_finish_ioend_direct(ioend);
 	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 387a1174522f..531f9ebdeeae 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -65,6 +65,8 @@ struct vm_fault;
  *
  * IOMAP_F_ATOMIC_BIO indicates that (write) I/O will be issued as an atomic
  * bio, i.e. set REQ_ATOMIC.
+ *
+ * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -79,6 +81,11 @@ struct vm_fault;
 #define IOMAP_F_BOUNDARY	(1U << 6)
 #define IOMAP_F_ANON_WRITE	(1U << 7)
 #define IOMAP_F_ATOMIC_BIO	(1U << 8)
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+#define IOMAP_F_INTEGRITY	(1U << 9)
+#else
+#define IOMAP_F_INTEGRITY	0
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 /*
  * Flag reserved for file system specific usage
-- 
2.47.3


