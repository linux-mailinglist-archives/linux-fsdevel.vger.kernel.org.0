Return-Path: <linux-fsdevel+bounces-77936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMEdBM9UnGnJEAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:23:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C5176BDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B0463059FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A351F4168;
	Mon, 23 Feb 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0S1wR2vI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B511E376C;
	Mon, 23 Feb 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852853; cv=none; b=sAQlMU5a68p+x5ZAkQa1CcB3aNYJ+46x47P6ZrTZ5hbv1+vwR4wlXxW315LJGG7kAutZ2UQLwVSYGrEo3r7IRBZJSbl+LUTsz6gtZ43w1OoeMCtWXdXruovFzu8qmmxiEQma8NTg/IPrgrkZq0brcPm0QGvS9KHgjD/PrtQ2Q5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852853; c=relaxed/simple;
	bh=gxwznWsUi8Tc8O8/GnUEDfsqwmsijyAsRX0g2r+U/vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnUhbjIkDGaKbOqKsuORnG9sxQIRFkcZfVbr1ku6GG5uZuEf9FAt+jKiTE9QzIen0dTFd60KTQEC3UoKMgNZKpiG3oi5dcOAarDsGPF/0rjszMw9dRI/5EiC7ZiDgX/Vqp5vmUwdJJvoVSj7xJiN8IjSPNX2L1tcP1p8YbtGYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0S1wR2vI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n/wAKsdaRiqTYkhrvMNwQY5gIpsKsqRudZRG9GYEwnQ=; b=0S1wR2vI1U/4s+PzLJlIIZMC6l
	vIQTCo5JnE5Fd0z3vqSOIIARbnXdBS/0QfNEeKFggcHYoe9rIblils3AmTum48BYwP1yW3CM4kTLG
	k5aQbxz/Rc+gdZYWq6V7bStgH0luF4+hJyaNGksEOMXCJOxO8hafosQpQfMr1fWQ2prCL8qdqwltN
	msS4iWytiKPAaSrYsxtUXsFKPAAw+GRlqsRwfc5IvLLQbfT4C4/LzC4YYnS+R05KhTf81jUJvIzfu
	sSPRPWxYQBWJsLW1NSoVXIyWKQaB93W3Pe9z1Q2HWnO30jxQGd6UGgRpHm5BQ8rjy1DEsEj89RSqE
	HOakiHsw==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVri-00000000Lso-2qPI;
	Mon, 23 Feb 2026 13:20:47 +0000
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
Subject: [PATCH 01/16] block: factor out a bio_integrity_action helper
Date: Mon, 23 Feb 2026 05:20:01 -0800
Message-ID: <20260223132021.292832-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-77936-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,oracle.com:email,samsung.com:email,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858C5176BDA
X-Rspamd-Action: no action

Split the logic to see if a bio needs integrity metadata from
bio_integrity_prep into a reusable helper than can be called from
file system code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity-auto.c    | 64 +++++------------------------------
 block/bio-integrity.c         | 48 ++++++++++++++++++++++++++
 block/blk-mq.c                |  6 ++--
 drivers/nvdimm/btt.c          |  6 ++--
 include/linux/bio-integrity.h |  5 ++-
 include/linux/blk-integrity.h | 23 +++++++++++++
 6 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 44dcdf7520c5..e16f669dbf1e 100644
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
+ * @action:	preparation action needed (BI_ACT_*)
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
index 20f5d301d32d..0955be90038b 100644
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
index 9af8c3dec3f6..0b311a797178 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3143,6 +3143,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = current->plug;
 	const int is_sync = op_is_sync(bio->bi_opf);
+	unsigned int integrity_action;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int nr_segs;
 	struct request *rq;
@@ -3195,8 +3196,9 @@ void blk_mq_submit_bio(struct bio *bio)
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
index b6bef092f8b8..fdcb080a4314 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1435,14 +1435,16 @@ static void btt_submit_bio(struct bio *bio)
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
index c15b1ac62765..fd3f3c8c0fcd 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -180,4 +180,27 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+enum bio_integrity_action {
+	BI_ACT_BUFFER		= (1u << 0),	/* allocate buffer */
+	BI_ACT_CHECK		= (1u << 1),	/* generate / verify PI */
+	BI_ACT_ZERO		= (1u << 2),	/* zero buffer */
+};
+
+/**
+ * bio_integrity_action - return the integrity action needed for a bio
+ * @bio:	bio to operate on
+ *
+ * Returns the mask of integrity actions (BI_ACT_*) that need to be performed
+ * for @bio.
+ */
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


