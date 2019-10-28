Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1CE6CEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJ1HUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:45 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56964 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfJ1HUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:44 -0400
Received: by mail-pl1-f202.google.com with SMTP id bb3so5452515plb.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WzbsbFz4o8H8SJZeCqtGo6txi0Bzn3b43TKqwjKX5n4=;
        b=bUb2NMWDO+aVOB94qsGaE64AsV4ygRC4sgW32zy6qGeDAA2U+p/koZ8w2pc/HE6FrP
         v72wYbH57p/iSQVrWVLzaRKLlm8537Hp3TR01PPkw9kG9AsxxauKK1BUpV6S3rRG9JO5
         3pmdA7UwYXqJyMqiDJqGKH6/hh0BQcS3Ct0Y7bGA2wuHhF8ad9y/jlNA5BS4Wzxz7TGY
         X9akU9rQVWfKIDwYLSE1goDdInj6SYZpYTUIoO2CMazWlGkNsGL7pqL+A/poc7DQmkDR
         6EDb6rp0odYTNQKND/l+ltMCASAJtbRe2KLhWKDR5bcWV6w9UlhzzyMZK9bim/OJOfpS
         /P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WzbsbFz4o8H8SJZeCqtGo6txi0Bzn3b43TKqwjKX5n4=;
        b=HtTTEF8wbpVfDOuve5BEu9D78NvrqsaNQ0NTlrMcYDk2JBY4FXjfgw5XN75MglzkNd
         APzcbkvGnGx9SNUfkN74q60cCd91Eo41d5enHNCEu+qzS+8iw0xXo/+BofSq7nFAtBCy
         UzCbcypD8W6U/y38xL0Fu88UuFXw1tUl7W22yWRsrxiCexW4hfjNslJm2gMjaUtCw0DM
         kLgo0Z7LH+ubdfyT2oKpQminuBEZ4dQliahhSLe6Vn6QnJ1T2VaDdZYCvnNc5iCpqRTr
         CwD/kDHn8iZjImANaRnfSU3L2MjYEzMjEuD+djl2J7wa7Rp6NyNOXnMTMZLYEWTrv141
         TAug==
X-Gm-Message-State: APjAAAUwzY3FlaVvvMF3SleG22xPfkUeijq8Ec0OybETPLf1ubqpCzUF
        6PDv2B8kjDtDvqqasJRmAwYcFBgcFig=
X-Google-Smtp-Source: APXvYqwFWXhDGmTzN1CzplsG0yv8tZy8yJA11DEE9f5LVjzOlT/VMK72QlpuHZYWdmiS6fTmCwTGSpXQIuY=
X-Received: by 2002:a63:5605:: with SMTP id k5mr19434999pgb.14.1572247242788;
 Mon, 28 Oct 2019 00:20:42 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:25 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-3-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 2/9] block: Add encryption context to struct bio
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
 include/linux/bio-crypt-ctx.h | 219 ++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |   6 +-
 include/linux/blk_types.h     |   6 +
 10 files changed, 426 insertions(+), 30 deletions(-)
 create mode 100644 block/bio-crypt-ctx.c
 create mode 100644 include/linux/bio-crypt-ctx.h

diff --git a/block/Makefile b/block/Makefile
index e922844219c2..f39611ed151f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,4 +36,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
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
index 8f0ed6228fc5..ce8003aadf07 100644
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
@@ -992,6 +993,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
 
+	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..3b5959d386fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1807,5 +1807,8 @@ int __init blk_dev_init(void)
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 #endif
 
+	if (bio_crypt_ctx_init() < 0)
+		panic("Failed to allocate mem for bio crypt ctxs\n");
+
 	return 0;
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 48e6725b32ee..c97c02a20c6a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -557,6 +557,9 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
+	if (WARN_ON_ONCE(!bio_crypt_ctx_compatible(bio, req->bio)))
+		goto no_merge;
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
@@ -711,8 +714,14 @@ static enum elv_merge blk_try_req_merge(struct request *req,
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
@@ -748,6 +757,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!bio_crypt_ctx_compatible(req->bio, next->bio))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -880,16 +892,31 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
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
index 1a5e328c443a..67c24294d7c8 100644
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
index 000000000000..5cd569f77c31
--- /dev/null
+++ b/include/linux/bio-crypt-ctx.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+#ifndef __LINUX_BIO_CRYPT_CTX_H
+#define __LINUX_BIO_CRYPT_CTX_H
+
+enum blk_crypto_mode_num {
+	BLK_ENCRYPTION_MODE_INVALID	= 0,
+	BLK_ENCRYPTION_MODE_AES_256_XTS	= 1,
+};
+
+#ifdef CONFIG_BLOCK
+#include <linux/blk_types.h>
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+struct bio_crypt_ctx {
+	int keyslot;
+	const u8 *raw_key;
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
+				    const u8 *raw_key,
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
+static inline const u8 *bio_crypt_raw_key(struct bio *bio)
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
index d0cb7c350cdc..63d0fee423fa 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -8,6 +8,7 @@
 #include <linux/highmem.h>
 #include <linux/mempool.h>
 #include <linux/ioprio.h>
+#include <linux/bio-crypt-ctx.h>
 
 #ifdef CONFIG_BLOCK
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
@@ -564,11 +565,6 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 }
 #endif
 
-enum blk_crypto_mode_num {
-	BLK_ENCRYPTION_MODE_INVALID	= 0,
-	BLK_ENCRYPTION_MODE_AES_256_XTS	= 1,
-};
-
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d688b96d1d63..d3ee2dcb634d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -18,6 +18,7 @@ struct block_device;
 struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
+struct bio_crypt_ctx;
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
@@ -173,6 +174,11 @@ struct bio {
 	u64			bi_iocost_cost;
 #endif
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
2.24.0.rc0.303.g954a862665-goog

