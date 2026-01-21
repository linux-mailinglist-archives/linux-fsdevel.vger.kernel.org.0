Return-Path: <linux-fsdevel+bounces-74797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cExwGVF2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:46:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE252460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABAAC4C2101
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD3410D26;
	Wed, 21 Jan 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AFsVEcDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99644A725;
	Wed, 21 Jan 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977837; cv=none; b=t+2q1rrgY7bEnm8oc+UOcgaXbentUlH7g27F+3cnbMtcaFLxtg9UcLY4nxwbcGVv1J5bPYWF/7pa7Dvico2jM6ATdJ+/dHQTzDSFHLX9eiFWfE1F+WjbrNu6irKijInliAz22k3jz/lXOf1AXc9qG2cFs94r/pPgLwSKabHRZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977837; c=relaxed/simple;
	bh=4jVkq7wOpxnEqYUE2fJDT+wT8pQwSz5OD5UGg8zGj6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaRhl1TEnV1IaeJYiBsounk92x3ZT2/3vELbA9d6mC8NHDjnEKA3yFhg1wAob73/gjj4We4t4kZs0xmErtWkS+gNH2xz3giOn30kViFwhAknou96NSW2vJUi/6wY9zh4bvx2KXCYLddWzjUffWtuKUz9YgSO2PqAmJC7JltPHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AFsVEcDI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Pf0qvFy//+7QPDgAvomhvdn4TVJl4jHHyOSqX5CizUk=; b=AFsVEcDI/niLKv48X9uP70djKY
	MpwJ8P5j6pDrmqUV91rDdDVorFwRHjZHXjTLDq6U/FJngrkBy0r32v+m3wp+sTDiTc1sGnJEx0+F9
	xFrW9mxKSaSc7RMLFjuTYsEUOK1qZAamqMcoZLE2s5mjFmRdDVwpxjHnVaDbUeDTelKTpq/rj152f
	1044CMw4hhDEqqyvvAS60H7x548teLx8hjqCnOM3btkEHNAKYz06ZzNvRMgzqhA39Bu6jaKH0HKek
	EZVyLmW28zO9UZjrJPks5ODBWAOp9z0pD/jJsoYXFlrZG6lwSGEp5z12syLFvy6Tar/texftat/8d
	yrSYvkqA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwW-00000004xXR-2rKH;
	Wed, 21 Jan 2026 06:43:53 +0000
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
Subject: [PATCH 01/15] block: factor out a bio_integrity_action helper
Date: Wed, 21 Jan 2026 07:43:09 +0100
Message-ID: <20260121064339.206019-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74797-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,infradead.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0CAE252460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split the logic to see if a bio needs integrity metadata from
bio_integrity_prep into a reusable helper than can be called from
file system code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c    | 64 +++++------------------------------
 block/bio-integrity.c         | 48 ++++++++++++++++++++++++++
 block/blk-mq.c                |  6 ++--
 drivers/nvdimm/btt.c          |  6 ++--
 include/linux/bio-integrity.h |  5 ++-
 include/linux/blk-integrity.h | 16 +++++++++
 6 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 44dcdf7520c5..3a4141a9de0c 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -50,11 +50,6 @@ static bool bip_should_check(struct bio_integrity_payload *bip)
 	return bip->bip_flags & BIP_CHECK_FLAGS;
 }
 
-static bool bi_offload_capable(struct blk_integrity *bi)
-{
-	return bi->metadata_size == bi->pi_tuple_size;
-}
-
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
@@ -84,69 +79,27 @@ bool __bio_integrity_endio(struct bio *bio)
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
+ * @action:	preparation action needed
+ *
+ * Allocate the integrity payload.  For writes, generate the integrity metadata
+ * and for reads, setup the completion handler to verify the metadata.
  *
- * Checks if the bio already has an integrity payload attached.  If it does, the
- * payload has been generated by another kernel subsystem, and we just pass it
- * through.
- * Otherwise allocates integrity payload and for writes the integrity metadata
- * will be generated.  For reads, the completion handler will verify the
- * metadata.
+ * This is used for bios that do not have user integrity payloads attached.
  */
-bool bio_integrity_prep(struct bio *bio)
+void bio_integrity_prep(struct bio *bio, unsigned int action)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
-	bool set_flags = true;
-	gfp_t gfp = GFP_NOIO;
-
-	if (!bi)
-		return true;
-
-	if (!bio_sectors(bio))
-		return true;
-
-	/* Already protected? */
-	if (bio_integrity(bio))
-		return true;
-
-	switch (bio_op(bio)) {
-	case REQ_OP_READ:
-		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
-			if (bi_offload_capable(bi))
-				return true;
-			set_flags = false;
-		}
-		break;
-	case REQ_OP_WRITE:
-		/*
-		 * Zero the memory allocated to not leak uninitialized kernel
-		 * memory to disk for non-integrity metadata where nothing else
-		 * initializes the memory.
-		 */
-		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
-			if (bi_offload_capable(bi))
-				return true;
-			set_flags = false;
-			gfp |= __GFP_ZERO;
-		} else if (bi->metadata_size > bi->pi_tuple_size)
-			gfp |= __GFP_ZERO;
-		break;
-	default:
-		return true;
-	}
-
-	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
-		return true;
 
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
 	bid->bio = bio;
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
-	bio_integrity_alloc_buf(bio, gfp & __GFP_ZERO);
+	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
 
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
 
-	if (set_flags) {
+	if (action & BI_ACT_CHECK) {
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bid->bip.bip_flags |= BIP_IP_CHECKSUM;
 		if (bi->csum_type)
@@ -160,7 +113,6 @@ bool bio_integrity_prep(struct bio *bio)
 		blk_integrity_generate(bio);
 	else
 		bid->saved_bio_iter = bio->bi_iter;
-	return true;
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 09eeaf6e74b8..6bdbb4ed2d1a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/blk-integrity.h>
+#include <linux/t10-pi.h>
 #include "blk.h"
 
 struct bio_integrity_alloc {
@@ -16,6 +17,53 @@ struct bio_integrity_alloc {
 
 static mempool_t integrity_buf_pool;
 
+static bool bi_offload_capable(struct blk_integrity *bi)
+{
+	return bi->metadata_size == bi->pi_tuple_size;
+}
+
+unsigned int __bio_integrity_action(struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
+		return 0;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
+			if (bi_offload_capable(bi))
+				return 0;
+			return BI_ACT_BUFFER;
+		}
+		return BI_ACT_BUFFER | BI_ACT_CHECK;
+	case REQ_OP_WRITE:
+		/*
+		 * Flush masquerading as write?
+		 */
+		if (!bio_sectors(bio))
+			return 0;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk for non-integrity metadata where nothing else
+		 * initializes the memory.
+		 */
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
+			if (bi_offload_capable(bi))
+				return 0;
+			return BI_ACT_BUFFER | BI_ACT_ZERO;
+		}
+
+		if (bi->metadata_size > bi->pi_tuple_size)
+			return BI_ACT_BUFFER | BI_ACT_CHECK | BI_ACT_ZERO;
+		return BI_ACT_BUFFER | BI_ACT_CHECK;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(__bio_integrity_action);
+
 void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e3..3e58f6d50a1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3133,6 +3133,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = current->plug;
 	const int is_sync = op_is_sync(bio->bi_opf);
+	unsigned int integrity_action;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int nr_segs;
 	struct request *rq;
@@ -3185,8 +3186,9 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio)
 		goto queue_exit;
 
-	if (!bio_integrity_prep(bio))
-		goto queue_exit;
+	integrity_action = bio_integrity_action(bio);
+	if (integrity_action)
+		bio_integrity_prep(bio, integrity_action);
 
 	blk_mq_bio_issue_init(q, bio);
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index a933db961ed7..9cc4b659de1a 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1437,14 +1437,16 @@ static void btt_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
+	unsigned int integrity_action;
 	struct bvec_iter iter;
 	unsigned long start;
 	struct bio_vec bvec;
 	int err = 0;
 	bool do_acct;
 
-	if (!bio_integrity_prep(bio))
-		return;
+	integrity_action = bio_integrity_action(bio);
+	if (integrity_action)
+		bio_integrity_prep(bio, integrity_action);
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 21e4652dcfd2..276cbbdd2c9d 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -78,7 +78,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter);
 int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta);
 void bio_integrity_unmap_user(struct bio *bio);
-bool bio_integrity_prep(struct bio *bio);
+void bio_integrity_prep(struct bio *bio, unsigned int action);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
 void bio_integrity_trim(struct bio *bio);
 int bio_integrity_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp_mask);
@@ -104,9 +104,8 @@ static inline void bio_integrity_unmap_user(struct bio *bio)
 {
 }
 
-static inline bool bio_integrity_prep(struct bio *bio)
+static inline void bio_integrity_prep(struct bio *bio, unsigned int action)
 {
-	return true;
 }
 
 static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c15b1ac62765..91d12610d252 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -180,4 +180,20 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+enum bio_integrity_action {
+	BI_ACT_BUFFER		= (1u << 0),	/* allocate buffer */
+	BI_ACT_CHECK		= (1u << 1),	/* generate / verify PI */
+	BI_ACT_ZERO		= (1u << 2),	/* zero buffer */
+};
+
+unsigned int __bio_integrity_action(struct bio *bio);
+static inline unsigned int bio_integrity_action(struct bio *bio)
+{
+	if (!blk_get_integrity(bio->bi_bdev->bd_disk))
+		return 0;
+	if (bio_integrity(bio))
+		return 0;
+	return __bio_integrity_action(bio);
+}
+
 #endif /* _LINUX_BLK_INTEGRITY_H */
-- 
2.47.3


