Return-Path: <linux-fsdevel+bounces-75765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBMTG/08emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:44:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912ECA60EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22FA7305C825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6B30F94E;
	Wed, 28 Jan 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zJ3iAhAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2F30F53B;
	Wed, 28 Jan 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617010; cv=none; b=uitR3/ay0OosJ4pIEHB/rOiW+VPQ3Y0CgeCDbHmG3SSnHw07pgGJQYsY9iYf1RV/WmT7HalHl9zcKyGCU6GlTCd7c9U2JHsYQ6f/4w7SXfjjj/LVd0YByaouFmevmRld+fGuDiHOR3n0ylehyO0qSNCa06a1gNt8/fRZtcTl+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617010; c=relaxed/simple;
	bh=xJIUhzrdWM29utvDFnBHm1RLJztFOOehCwsGEWrX+Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NawMf29ArLz3n4MNzHQNL0dzEzrLgVKypU4kGLTv+/P0EW6DWaTzUjf/bMD2v8fIzpWTmFmLHnlLfIwFmm4l2BLC787Od+Qn/IIfSbtZvT71xQpLm7y8mYk0WPLUk/2rjd/TGWMWp9mUynO3wEptW8OsLNHLp1M+Wf3fB71G2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zJ3iAhAX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t5am/PMSyJqJ5QtLpgPMTsJIRNWDX0BDJ9QUsYq6aSo=; b=zJ3iAhAXrRr6sJ6oTxE9XQYTzg
	I5r/O+w2OGu9rCr8bSnFCXSZpxFKSz13O4Ky1Q5MY6YhSgAZzm2civRZ2f5RsMJUW0AlyNL2wo1nT
	hpj36O2cjqmbBHD5+gwMYHn7fEqD4L0DvaE7w7oawnEkZDbO9hhGXCb9dMljstD2/UrZ4lLU1z5q/
	qTZs2IA+kS0M4YEEHQ7d/TPzWSUIw2yQAfMwv8EnapQq27oAJhMPHF+VrIdmfgyyQUTbX5Zw7c15T
	BBciD+oTFiRSa7ifcyP73VmM3r0viRXgCoPO3qR9zWwt8W+uNmDTrHd3wEcTnUsh7wFB5KfO6E/C3
	6Uk4hNoQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Dk-0000000GN2u-3AfU;
	Wed, 28 Jan 2026 16:16:46 +0000
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
Date: Wed, 28 Jan 2026 17:15:09 +0100
Message-ID: <20260128161517.666412-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[samsung.com:server fail,infradead.org:server fail,sin.lore.kernel.org:server fail,lst.de:server fail];
	TAGGED_FROM(0.00)[bounces-75765-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,samsung.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 912ECA60EB
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
index 952815eb5992..831378a6ced4 100644
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
@@ -215,6 +216,9 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
+	if (bio_integrity(bio))
+		fs_bio_integrity_free(bio);
+
 	if (dio->flags & IOMAP_DIO_BOUNCE) {
 		bio_iov_iter_unbounce(bio, !!dio->error,
 				dio->flags & IOMAP_DIO_USER_BACKED);
@@ -325,8 +329,10 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
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
@@ -343,6 +349,13 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
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
index 72f20e8c8893..a2931f8c454c 100644
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
@@ -59,6 +60,8 @@ static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
 		folio_count++;
 	}
 
+	if (bio_integrity(bio))
+		fs_bio_integrity_free(bio);
 	bio_put(bio);	/* frees the ioend */
 	return folio_count;
 }
@@ -92,6 +95,8 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		return error;
 	}
 
+	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_generate(&ioend->io_bio);
 	submit_bio(&ioend->io_bio);
 	return 0;
 }
@@ -113,10 +118,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
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
@@ -181,7 +189,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
-	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, map_len, ioend_flags)) {
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
@@ -258,6 +266,14 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
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
index de730970998f..f0e3ed8ad6a6 100644
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


