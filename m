Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B968E97420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHUH50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:57:26 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49482 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHUH5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:57:25 -0400
Received: by mail-qk1-f202.google.com with SMTP id l14so1256905qke.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IJJtlknwtk9R5EKrLGyaqkcJMNagGiZqElpki0nh3vk=;
        b=FVyr06XBTw70NrHexmEQX4TMcwGRPmNimrVnPiKP1u/Shbgouh1GRyIxEBBS9U6wt9
         qtpFYxNJTNUOZgf0fqvCjItYxjqaIipimmCvwP34uH9AK/KxNyocg16/J3phZptzYthi
         pXZnxi26FLtahOdEV46RhVk2ZU6mht4xEI7SFXmwXHGptsOap6dUKFFC6c38n0DcU34y
         9udABHLgSHs7d8+5PztESdtY03K3RrxraV+EwWnxRTne+hY8HqU47GZCiCeF3+8nKyjQ
         wKo8zm2gZs0mqcKRs++6rxBEDQb9GA9pOy/ORskno7le0ArabmIltSzfbGjJaJI/lnMS
         TgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IJJtlknwtk9R5EKrLGyaqkcJMNagGiZqElpki0nh3vk=;
        b=j5GnLDovqqHZIOUFg0XhRwwPOnKmxyUVFYLUHpA8rlJwhHGPNTkKaL/fsNpDdzYMCq
         HGf+eRiI2OWJzrs5R5iQ2VxE/AC35se1xBI6JyRRX9Iwe//H7wnDYapfknI1i15mvD37
         RvgZ5QAzdZDzhFm4R+z99ul7iUNauecBUDS7Ag6qDHlJPgTKUMJJHwGgMzYNoR+0lwaq
         Qif1+yG4ycoIxTzL8uA/Xskkj9Rb6fQUGfxaZ35ScIC38PX+g+MyEO8rz2D36iNfaiwE
         tgAn2i5LwdEowZr3g5vt/aKuVqrMWg5LTVqpMVyXnu/j/VlwG761ji0//4hPBX3y866u
         XFZg==
X-Gm-Message-State: APjAAAUwSp09GHFe+uJlByBlEfi9aB5N/DS5/2VeBmnLhdEZVwM2H4lP
        /H5SYV4fWBP8pbIYjR/G3/trSQXATOc=
X-Google-Smtp-Source: APXvYqyF4CEq7FNstHV9Yw7XcPzl84Mu1qdahWk99gbLSRGvHimfT0i+qmMXAUPrIxmIzuOwCb4rM/7BcE4=
X-Received: by 2002:a37:99c2:: with SMTP id b185mr14536177qke.475.1566374243624;
 Wed, 21 Aug 2019 00:57:23 -0700 (PDT)
Date:   Wed, 21 Aug 2019 00:57:08 -0700
In-Reply-To: <20190821075714.65140-1-satyat@google.com>
Message-Id: <20190821075714.65140-3-satyat@google.com>
Mime-Version: 1.0
References: <20190821075714.65140-1-satyat@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v4 2/8] block: Add encryption context to struct bio
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must have some way of letting a storage device driver know what
encryption context it should use for en/decrypting a request. However,
it's the filesystem/fscrypt that knows about and manages encryption
contexts. As such, when the filesystem layer submits a bio to the block
layer, and this bio eventually reaches a device driver with support for
inline encryption, the device driver will need to have been told the
encryption context for that bio.

We want to communicate the encryption context from the filesystem layer
to the storage device along with the bio, when the bio is submitted to the
block layer. To do this, we add a struct bio_crypt_ctx to struct bio, which
can represent an encryption context (note that we can't use the bi_private
field in struct bio to do this because that field does not function to pass
information across layers in the storage stack). We also introduce various
functions to manipulate the bio_crypt_ctx and make the bio/request merging
logic aware of the bio_crypt_ctx.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/Makefile                |   2 +-
 block/bio-crypt-ctx.c         | 137 +++++++++++++++++++++
 block/bio.c                   |  18 +--
 block/blk-core.c              |   3 +
 block/blk-merge.c             |  35 +++++-
 block/bounce.c                |  15 +--
 drivers/md/dm.c               |  15 ++-
 include/linux/bio-crypt-ctx.h | 226 ++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |  13 +-
 include/linux/blk_types.h     |   6 +
 10 files changed, 433 insertions(+), 37 deletions(-)
 create mode 100644 block/bio-crypt-ctx.c
 create mode 100644 include/linux/bio-crypt-ctx.h

diff --git a/block/Makefile b/block/Makefile
index a72abd61b220..4147ffa63631 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -35,4 +35,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o bio-crypt-ctx.o
diff --git a/block/bio-crypt-ctx.c b/block/bio-crypt-ctx.c
new file mode 100644
index 000000000000..aa3571f72ee7
--- /dev/null
+++ b/block/bio-crypt-ctx.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/keyslot-manager.h>
+
+static int num_prealloc_crypt_ctxs = 128;
+static struct kmem_cache *bio_crypt_ctx_cache;
+static mempool_t *bio_crypt_ctx_pool;
+
+int bio_crypt_ctx_init(void)
+{
+	bio_crypt_ctx_cache = KMEM_CACHE(bio_crypt_ctx, 0);
+	if (!bio_crypt_ctx_cache)
+		return -ENOMEM;
+
+	bio_crypt_ctx_pool = mempool_create_slab_pool(
+					num_prealloc_crypt_ctxs,
+					bio_crypt_ctx_cache);
+
+	if (!bio_crypt_ctx_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
+{
+	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+}
+EXPORT_SYMBOL(bio_crypt_alloc_ctx);
+
+void bio_crypt_free_ctx(struct bio *bio)
+{
+	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
+	bio->bi_crypt_context = NULL;
+}
+EXPORT_SYMBOL(bio_crypt_free_ctx);
+
+int bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
+{
+	if (!bio_has_crypt_ctx(src))
+		return 0;
+
+	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
+	if (!dst->bi_crypt_context)
+		return -ENOMEM;
+
+	*dst->bi_crypt_context = *src->bi_crypt_context;
+
+	if (bio_crypt_has_keyslot(src))
+		keyslot_manager_get_slot(src->bi_crypt_context->processing_ksm,
+					 src->bi_crypt_context->keyslot);
+
+	return 0;
+}
+EXPORT_SYMBOL(bio_crypt_clone);
+
+bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
+{
+	if (!bio_has_crypt_ctx(bio))
+		return false;
+
+	WARN_ON(!bio_crypt_has_keyslot(bio));
+	return q->ksm == bio->bi_crypt_context->processing_ksm;
+}
+EXPORT_SYMBOL(bio_crypt_should_process);
+
+/*
+ * Checks that two bio crypt contexts are compatible - i.e. that
+ * they are mergeable except for data_unit_num continuity.
+ */
+bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
+{
+	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
+	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
+
+	if (bio_has_crypt_ctx(b_1) != bio_has_crypt_ctx(b_2))
+		return false;
+
+	if (!bio_has_crypt_ctx(b_1))
+		return true;
+
+	return bc1->keyslot == bc2->keyslot &&
+	       bc1->data_unit_size_bits == bc2->data_unit_size_bits;
+}
+
+/*
+ * Checks that two bio crypt contexts are compatible, and also
+ * that their data_unit_nums are continuous (and can hence be merged)
+ */
+bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
+				  unsigned int b1_sectors,
+				  struct bio *b_2)
+{
+	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
+	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
+
+	if (!bio_crypt_ctx_compatible(b_1, b_2))
+		return false;
+
+	return !bio_has_crypt_ctx(b_1) ||
+		(bc1->data_unit_num +
+		(b1_sectors >> (bc1->data_unit_size_bits - 9)) ==
+		bc2->data_unit_num);
+}
+
+void bio_crypt_ctx_release_keyslot(struct bio *bio)
+{
+	struct bio_crypt_ctx *crypt_ctx = bio->bi_crypt_context;
+
+	keyslot_manager_put_slot(crypt_ctx->processing_ksm, crypt_ctx->keyslot);
+	bio->bi_crypt_context->processing_ksm = NULL;
+	bio->bi_crypt_context->keyslot = -1;
+}
+
+int bio_crypt_ctx_acquire_keyslot(struct bio *bio, struct keyslot_manager *ksm)
+{
+	int slot;
+	enum blk_crypto_mode_num crypto_mode = bio_crypto_mode(bio);
+
+	if (!ksm)
+		return -ENOMEM;
+
+	slot = keyslot_manager_get_slot_for_key(ksm,
+			bio_crypt_raw_key(bio), crypto_mode,
+			1 << bio->bi_crypt_context->data_unit_size_bits);
+	if (slot < 0)
+		return slot;
+
+	bio_crypt_set_keyslot(bio, slot, ksm);
+	return 0;
+}
diff --git a/block/bio.c b/block/bio.c
index 299a0e7651ec..ada9850c90dc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -241,6 +241,7 @@ static void bio_free(struct bio *bio)
 	struct bio_set *bs = bio->bi_pool;
 	void *p;
 
+	bio_crypt_free_ctx(bio);
 	bio_uninit(bio);
 
 	if (bs) {
@@ -612,15 +613,15 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 
 	__bio_clone_fast(b, bio);
 
-	if (bio_integrity(bio)) {
-		int ret;
-
-		ret = bio_integrity_clone(b, bio, gfp_mask);
+	if (bio_crypt_clone(b, bio, gfp_mask) < 0) {
+		bio_put(b);
+		return NULL;
+	}
 
-		if (ret < 0) {
-			bio_put(b);
-			return NULL;
-		}
+	if (bio_integrity(bio) &&
+	    bio_integrity_clone(b, bio, gfp_mask) < 0) {
+		bio_put(b);
+		return NULL;
 	}
 
 	return b;
@@ -1007,6 +1008,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
 
+	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..35027e80e27d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1769,5 +1769,8 @@ int __init blk_dev_init(void)
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 #endif
 
+	if (bio_crypt_ctx_init() < 0)
+		panic("Failed to allocate mem for bio crypt ctxs\n");
+
 	return 0;
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 57f7990b342d..ebfb26b536d2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -504,6 +504,9 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
+	if (WARN_ON_ONCE(!bio_crypt_ctx_compatible(bio, req->bio)))
+		goto no_merge;
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
@@ -658,8 +661,14 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 {
 	if (blk_discard_mergable(req))
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
+	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
+		if (!bio_crypt_ctx_back_mergeable(req->bio,
+						  blk_rq_sectors(req),
+						  next->bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_BACK_MERGE;
+	}
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -695,6 +704,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!bio_crypt_ctx_compatible(req->bio, next->bio))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -827,16 +839,31 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
+	/* Only merge if the crypt contexts are compatible */
+	if (!bio_crypt_ctx_compatible(bio, rq->bio))
+		return false;
+
 	return true;
 }
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
+	if (blk_discard_mergable(rq)) {
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
+	} else if (blk_rq_pos(rq) + blk_rq_sectors(rq) ==
+		   bio->bi_iter.bi_sector) {
+		if (!bio_crypt_ctx_back_mergeable(rq->bio,
+						  blk_rq_sectors(rq), bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_BACK_MERGE;
-	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
+	} else if (blk_rq_pos(rq) - bio_sectors(bio) ==
+		   bio->bi_iter.bi_sector) {
+		if (!bio_crypt_ctx_back_mergeable(bio,
+						  bio_sectors(bio), rq->bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_FRONT_MERGE;
+	}
 	return ELEVATOR_NO_MERGE;
 }
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..6f9a2359b22a 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -267,14 +267,15 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		break;
 	}
 
-	if (bio_integrity(bio_src)) {
-		int ret;
+	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0) {
+		bio_put(bio);
+		return NULL;
+	}
 
-		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
-		if (ret < 0) {
-			bio_put(bio);
-			return NULL;
-		}
+	if (bio_integrity(bio_src) &&
+	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0) {
+		bio_put(bio);
+		return NULL;
 	}
 
 	bio_clone_blkg_association(bio, bio_src);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d0beef033e2f..ce378c0b9ebd 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1322,12 +1322,15 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 		     sector_t sector, unsigned len)
 {
 	struct bio *clone = &tio->clone;
+	int ret;
 
 	__bio_clone_fast(clone, bio);
 
-	if (bio_integrity(bio)) {
-		int r;
+	ret = bio_crypt_clone(clone, bio, GFP_NOIO);
+	if (ret < 0)
+		return ret;
 
+	if (bio_integrity(bio)) {
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
 			     !dm_target_passes_integrity(tio->ti->type))) {
 			DMWARN("%s: the target %s doesn't support integrity data.",
@@ -1336,9 +1339,11 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			return -EIO;
 		}
 
-		r = bio_integrity_clone(clone, bio, GFP_NOIO);
-		if (r < 0)
-			return r;
+		ret = bio_integrity_clone(clone, bio, GFP_NOIO);
+		if (ret < 0) {
+			bio_crypt_free_ctx(clone);
+			return ret;
+		}
 	}
 
 	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
diff --git a/include/linux/bio-crypt-ctx.h b/include/linux/bio-crypt-ctx.h
new file mode 100644
index 000000000000..ebe456289338
--- /dev/null
+++ b/include/linux/bio-crypt-ctx.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+#ifndef __LINUX_BIO_CRYPT_CTX_H
+#define __LINUX_BIO_CRYPT_CTX_H
+
+#ifdef CONFIG_BLOCK
+#include <linux/blk_types.h>
+
+enum blk_crypto_mode_num {
+	BLK_ENCRYPTION_MODE_INVALID	= -1,
+	BLK_ENCRYPTION_MODE_AES_256_XTS	= 0,
+	/*
+	 * TODO: Support these too
+	 * BLK_ENCRYPTION_MODE_AES_256_CTS	= 1,
+	 * BLK_ENCRYPTION_MODE_AES_128_CBC	= 2,
+	 * BLK_ENCRYPTION_MODE_AES_128_CTS	= 3,
+	 * BLK_ENCRYPTION_MODE_ADIANTUM		= 4,
+	 */
+};
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+struct bio_crypt_ctx {
+	int keyslot;
+	u8 *raw_key;
+	enum blk_crypto_mode_num crypto_mode;
+	u64 data_unit_num;
+	unsigned int data_unit_size_bits;
+
+	/*
+	 * The keyslot manager where the key has been programmed
+	 * with keyslot.
+	 */
+	struct keyslot_manager *processing_ksm;
+
+	/*
+	 * Copy of the bvec_iter when this bio was submitted.
+	 * We only want to en/decrypt the part of the bio
+	 * as described by the bvec_iter upon submission because
+	 * bio might be split before being resubmitted
+	 */
+	struct bvec_iter crypt_iter;
+	u64 sw_data_unit_num;
+};
+
+extern int bio_crypt_clone(struct bio *dst, struct bio *src,
+			   gfp_t gfp_mask);
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return bio->bi_crypt_context;
+}
+
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	if (bio_has_crypt_ctx(bio)) {
+		bio->bi_crypt_context->data_unit_num +=
+			bytes >> bio->bi_crypt_context->data_unit_size_bits;
+	}
+}
+
+static inline bool bio_crypt_has_keyslot(struct bio *bio)
+{
+	return bio->bi_crypt_context->keyslot >= 0;
+}
+
+extern int bio_crypt_ctx_init(void);
+
+extern struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask);
+
+extern void bio_crypt_free_ctx(struct bio *bio);
+
+static inline int bio_crypt_set_ctx(struct bio *bio,
+				    u8 *raw_key,
+				    enum blk_crypto_mode_num crypto_mode,
+				    u64 dun,
+				    unsigned int dun_bits,
+				    gfp_t gfp_mask)
+{
+	struct bio_crypt_ctx *crypt_ctx;
+
+	crypt_ctx = bio_crypt_alloc_ctx(gfp_mask);
+	if (!crypt_ctx)
+		return -ENOMEM;
+
+	crypt_ctx->raw_key = raw_key;
+	crypt_ctx->data_unit_num = dun;
+	crypt_ctx->data_unit_size_bits = dun_bits;
+	crypt_ctx->crypto_mode = crypto_mode;
+	crypt_ctx->processing_ksm = NULL;
+	crypt_ctx->keyslot = -1;
+	bio->bi_crypt_context = crypt_ctx;
+
+	return 0;
+}
+
+static inline void bio_set_data_unit_num(struct bio *bio, u64 dun)
+{
+	bio->bi_crypt_context->data_unit_num = dun;
+}
+
+static inline int bio_crypt_get_keyslot(struct bio *bio)
+{
+	return bio->bi_crypt_context->keyslot;
+}
+
+static inline void bio_crypt_set_keyslot(struct bio *bio,
+					 unsigned int keyslot,
+					 struct keyslot_manager *ksm)
+{
+	bio->bi_crypt_context->keyslot = keyslot;
+	bio->bi_crypt_context->processing_ksm = ksm;
+}
+
+extern void bio_crypt_ctx_release_keyslot(struct bio *bio);
+
+extern int bio_crypt_ctx_acquire_keyslot(struct bio *bio,
+					 struct keyslot_manager *ksm);
+
+static inline u8 *bio_crypt_raw_key(struct bio *bio)
+{
+	return bio->bi_crypt_context->raw_key;
+}
+
+static inline enum blk_crypto_mode_num bio_crypto_mode(struct bio *bio)
+{
+	return bio->bi_crypt_context->crypto_mode;
+}
+
+static inline u64 bio_crypt_data_unit_num(struct bio *bio)
+{
+	return bio->bi_crypt_context->data_unit_num;
+}
+
+static inline u64 bio_crypt_sw_data_unit_num(struct bio *bio)
+{
+	return bio->bi_crypt_context->sw_data_unit_num;
+}
+
+extern bool bio_crypt_should_process(struct bio *bio, struct request_queue *q);
+
+extern bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2);
+
+extern bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
+					 unsigned int b1_sectors,
+					 struct bio *b_2);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+struct keyslot_manager;
+
+static inline int bio_crypt_ctx_init(void)
+{
+	return 0;
+}
+
+static inline int bio_crypt_clone(struct bio *dst, struct bio *src,
+				  gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline void bio_crypt_advance(struct bio *bio,
+				     unsigned int bytes) { }
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_free_ctx(struct bio *bio) { }
+
+static inline void bio_crypt_set_ctx(struct bio *bio,
+				     u8 *raw_key,
+				     enum blk_crypto_mode_num crypto_mode,
+				     u64 dun,
+				     unsigned int dun_bits,
+				     gfp_t gfp_mask) { }
+
+static inline void bio_set_data_unit_num(struct bio *bio, u64 dun) { }
+
+static inline bool bio_crypt_has_keyslot(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_set_keyslot(struct bio *bio,
+					 unsigned int keyslot,
+					 struct keyslot_manager *ksm) { }
+
+static inline int bio_crypt_get_keyslot(struct bio *bio)
+{
+	return -1;
+}
+
+static inline u8 *bio_crypt_raw_key(struct bio *bio)
+{
+	return NULL;
+}
+
+static inline u64 bio_crypt_data_unit_num(struct bio *bio)
+{
+	return 0;
+}
+
+static inline bool bio_crypt_should_process(struct bio *bio,
+					    struct request_queue *q)
+{
+	return false;
+}
+
+static inline bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
+{
+	return true;
+}
+
+static inline bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
+						unsigned int b1_sectors,
+						struct bio *b_2)
+{
+	return true;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+#endif /* CONFIG_BLOCK */
+#endif /* __LINUX_BIO_CRYPT_CTX_H */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 6c9228dd3156..9dddcd2af3e9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -12,6 +12,7 @@
 #ifdef CONFIG_BLOCK
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/bio-crypt-ctx.h>
 
 #define BIO_DEBUG
 
@@ -564,18 +565,6 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 }
 #endif
 
-enum blk_crypto_mode_num {
-	BLK_ENCRYPTION_MODE_INVALID	= -1,
-	BLK_ENCRYPTION_MODE_AES_256_XTS	= 0,
-	/*
-	 * TODO: Support these too
-	 * BLK_ENCRYPTION_MODE_AES_256_CTS	= 1,
-	 * BLK_ENCRYPTION_MODE_AES_128_CBC	= 2,
-	 * BLK_ENCRYPTION_MODE_AES_128_CTS	= 3,
-	 * BLK_ENCRYPTION_MODE_ADIANTUM		= 4,
-	 */
-};
-
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index feff3fe4467e..e59ab0186441 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -18,6 +18,7 @@ struct block_device;
 struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
+struct bio_crypt_ctx;
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
@@ -170,6 +171,11 @@ struct bio {
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct bio_crypt_ctx	*bi_crypt_context;
+#endif
+
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 		struct bio_integrity_payload *bi_integrity; /* data integrity */
-- 
2.23.0.rc1.153.gdeed80330f-goog

