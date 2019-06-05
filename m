Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD007367FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 01:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFEX2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 19:28:50 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35074 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfFEX2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:28:50 -0400
Received: by mail-yw1-f74.google.com with SMTP id d19so393069ywb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PfKOONnwMhBeh7xSjZxUh97GwXA2AXCMBFqh12uk7Ag=;
        b=J0DAiUtZCUUTRzBpukE8Bi+Zg8KGuk73KAY3DcQLUNnMdj/FOg3OeyGXyStMI+s5h/
         Tof+Neop6bYv9aH2Q7cQZJ4/QczyVCh1CyuQwSxnC2oFRB863Q+QVeu0nHWRDWpsrTh6
         axy1SphEO0PZ/ZBM8NMZ1YsA8nmR/bomL6dCmsuVmS358gnn1Hc+MVk+N1Wq3zZWj+ph
         clroptbdHt0s3OYNeoH7Xbzb7Uj7j01k6IYGmYCheIqILHsB5Eh/EkGiBXcEnLV6k6dw
         uTHbp0ZmLSadErFuRPXBhfxrjW8TbWF0wzlCLswlW93HqR1xhbrnNjkf5DdFMUMtybjT
         C98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PfKOONnwMhBeh7xSjZxUh97GwXA2AXCMBFqh12uk7Ag=;
        b=Np5ZGaax8B4bmHQTGRhgP++CBF9/CFnxpbF3+AEiVw7/fP8CGEzLd654QbQDQFS94R
         OAOVsLZ8ARuFLevfK5sEqwcAhASeZiQBheCgg6dqQLODsIaKcb/b2Orod7sbSqdiTzTu
         vhE5MGxOo7qbPETd65+OcrnDSsVpxtIiEdnttKt6oXD9FCsaRang5j0eufz9suuaOAgv
         Marws23tzccshpj1QhlHvkuEQ6vs1/Ik53b5kyLAbAkKoZBSu7bTrVBw0D0pyagYgh3B
         kfjZclphnSOmz59UfoCTD3fqCSyGE6u+4yc+sEJU9FRov10fvBSQ8NOxNWYqSscADiFM
         YI9A==
X-Gm-Message-State: APjAAAXD4r0dXWgS0Q30SiQojP40dvm6uPnqMr5VFd5jm3cEB7d25TnA
        h1y1PAVMmyEwNQILsa4+dThonQ6Ngn0=
X-Google-Smtp-Source: APXvYqzbHh9qnUCgqid1Oxso1tAxFfln2kKsRLk9fXj0Y2JzJgQ5rr9BD2G45zMYffe8ZjtO8OCuXkFr9VU=
X-Received: by 2002:a81:49c3:: with SMTP id w186mr6456661ywa.80.1559777329351;
 Wed, 05 Jun 2019 16:28:49 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:31 -0700
In-Reply-To: <20190605232837.31545-1-satyat@google.com>
Message-Id: <20190605232837.31545-3-satyat@google.com>
Mime-Version: 1.0
References: <20190605232837.31545-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 2/8] block: Add encryption context to struct bio
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
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
 block/bio.c               |  12 ++-
 block/blk-crypt-ctx.c     |  90 +++++++++++++++++++
 block/blk-merge.c         |  34 ++++++-
 block/bounce.c            |   9 +-
 drivers/md/dm.c           |  15 ++--
 include/linux/bio.h       | 180 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  28 ++++++
 7 files changed, 355 insertions(+), 13 deletions(-)
 create mode 100644 block/blk-crypt-ctx.c

diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..87aa87288b39 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/keyslot-manager.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -240,6 +241,7 @@ static void bio_free(struct bio *bio)
 	struct bio_set *bs = bio->bi_pool;
 	void *p;
 
+	bio_crypt_free_ctx(bio);
 	bio_uninit(bio);
 
 	if (bs) {
@@ -612,6 +614,7 @@ EXPORT_SYMBOL(__bio_clone_fast);
 struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 {
 	struct bio *b;
+	int ret;
 
 	b = bio_alloc_bioset(gfp_mask, 0, bs);
 	if (!b)
@@ -619,9 +622,13 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 
 	__bio_clone_fast(b, bio);
 
-	if (bio_integrity(bio)) {
-		int ret;
+	ret = bio_clone_crypt_context(b, bio, gfp_mask);
+	if (ret < 0) {
+		bio_put(b);
+		return NULL;
+	}
 
+	if (bio_integrity(bio)) {
 		ret = bio_integrity_clone(b, bio, gfp_mask);
 
 		if (ret < 0) {
@@ -1019,6 +1026,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 		bio_integrity_advance(bio, bytes);
 
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
+	bio_crypt_advance(bio, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
 
diff --git a/block/blk-crypt-ctx.c b/block/blk-crypt-ctx.c
new file mode 100644
index 000000000000..174c058ab0c6
--- /dev/null
+++ b/block/blk-crypt-ctx.c
@@ -0,0 +1,90 @@
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
+struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
+{
+	return kzalloc(sizeof(struct bio_crypt_ctx), gfp_mask);
+}
+
+void bio_crypt_free_ctx(struct bio *bio)
+{
+	kzfree(bio->bi_crypt_context);
+	bio->bi_crypt_context = NULL;
+}
+
+int bio_clone_crypt_context(struct bio *dst, struct bio *src, gfp_t gfp_mask)
+{
+	if (!bio_is_encrypted(src) || bio_crypt_swhandled(src))
+		return 0;
+
+	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
+	if (!dst->bi_crypt_context)
+		return -ENOMEM;
+
+	*dst->bi_crypt_context = *src->bi_crypt_context;
+
+	if (!bio_crypt_has_keyslot(src))
+		return 0;
+
+	keyslot_manager_get_slot(src->bi_crypt_context->processing_ksm,
+				 src->bi_crypt_context->keyslot);
+
+	return 0;
+}
+
+bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
+{
+	if (!bio_is_encrypted(bio))
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
+	if (bio_is_encrypted(b_1) != bio_is_encrypted(b_2))
+		return false;
+
+	if (!bio_is_encrypted(b_1))
+		return true;
+
+	return bc1->keyslot != bc2->keyslot &&
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
+	return !bio_is_encrypted(b_1) ||
+		(bc1->data_unit_num +
+		(b1_sectors >> (bc1->data_unit_size_bits - 9)) ==
+		bc2->data_unit_num);
+}
+
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 17713d7d98d5..f416e7f38270 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -531,6 +531,9 @@ static inline int ll_new_hw_segment(struct request_queue *q,
 	if (blk_integrity_merge_bio(q, req, bio) == false)
 		goto no_merge;
 
+	if (WARN_ON(!bio_crypt_ctx_compatible(bio, req->bio)))
+		goto no_merge;
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
@@ -696,8 +699,13 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 {
 	if (blk_discard_mergable(req))
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
+	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
+		if (!bio_crypt_ctx_back_mergeable(
+			req->bio, blk_rq_sectors(req), next->bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_BACK_MERGE;
+	}
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -733,6 +741,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!bio_crypt_ctx_compatible(req->bio, next->bio))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -865,16 +876,31 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
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
index f8ed677a1bf7..238278c13af5 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -220,6 +220,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
+	int ret;
 
 	/*
 	 * Pre immutable biovecs, __bio_clone() used to just do a memcpy from
@@ -267,9 +268,13 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		break;
 	}
 
-	if (bio_integrity(bio_src)) {
-		int ret;
+	ret = bio_clone_crypt_context(bio, bio_src, gfp_mask);
+	if (ret < 0) {
+		bio_put(bio);
+		return NULL;
+	}
 
+	if (bio_integrity(bio_src)) {
 		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
 		if (ret < 0) {
 			bio_put(bio);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5475081dcbd6..3da81e4cddde 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1324,12 +1324,15 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 		     sector_t sector, unsigned len)
 {
 	struct bio *clone = &tio->clone;
+	int ret;
 
 	__bio_clone_fast(clone, bio);
 
-	if (bio_integrity(bio)) {
-		int r;
+	ret = bio_clone_crypt_context(clone, bio, GFP_NOIO);
+	if (ret < 0)
+		return ret;
 
+	if (bio_integrity(bio)) {
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
 			     !dm_target_passes_integrity(tio->ti->type))) {
 			DMWARN("%s: the target %s doesn't support integrity data.",
@@ -1338,9 +1341,11 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
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
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0f23b5682640..ba9552932571 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -561,6 +561,186 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 }
 #endif
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+extern int bio_clone_crypt_context(struct bio *dst, struct bio *src,
+				   gfp_t gfp_mask);
+
+static inline bool bio_is_encrypted(struct bio *bio)
+{
+	return bio && bio->bi_crypt_context;
+}
+
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	if (bio_is_encrypted(bio)) {
+		bio->bi_crypt_context->data_unit_num +=
+			bytes >> bio->bi_crypt_context->data_unit_size_bits;
+	}
+}
+
+extern bool bio_crypt_swhandled(struct bio *bio);
+
+static inline bool bio_crypt_has_keyslot(struct bio *bio)
+{
+	return bio_is_encrypted(bio) &&
+	       bio->bi_crypt_context->keyslot >= 0;
+}
+
+extern struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask);
+
+extern void bio_crypt_free_ctx(struct bio *bio);
+
+static inline int bio_crypt_set_ctx(struct bio *bio,
+				     u8 *raw_key,
+				     enum blk_crypt_mode_num crypt_mode,
+				     u64 dun,
+				     unsigned int dun_bits)
+{
+	struct bio_crypt_ctx *crypt_ctx;
+
+	crypt_ctx = bio_crypt_alloc_ctx(GFP_NOIO);
+	if (!crypt_ctx)
+		return -ENOMEM;
+
+	crypt_ctx->raw_key = raw_key;
+	crypt_ctx->data_unit_num = dun;
+	crypt_ctx->data_unit_size_bits = dun_bits;
+	crypt_ctx->crypt_mode = crypt_mode;
+	crypt_ctx->processing_ksm = NULL;
+	crypt_ctx->keyslot = -1;
+	bio->bi_crypt_context = crypt_ctx;
+
+	return 0;
+}
+
+static inline int bio_crypt_get_slot(struct bio *bio)
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
+
+	bio->bi_crypt_context->crypt_iter = bio->bi_iter;
+	bio->bi_crypt_context->sw_data_unit_num =
+		bio->bi_crypt_context->data_unit_num;
+}
+
+static inline void bio_crypt_unset_keyslot(struct bio *bio)
+{
+	bio->bi_crypt_context->processing_ksm = NULL;
+	bio->bi_crypt_context->keyslot = -1;
+}
+
+static inline u8 *bio_crypt_raw_key(struct bio *bio)
+{
+	return bio->bi_crypt_context->raw_key;
+}
+
+static inline enum blk_crypt_mode_num bio_crypt_mode(struct bio *bio)
+{
+	return bio->bi_crypt_context->crypt_mode;
+}
+
+static inline u64 bio_crypt_data_unit_num(struct bio *bio)
+{
+	WARN_ON(!bio_is_encrypted(bio));
+	return bio->bi_crypt_context->data_unit_num;
+}
+
+static inline u64 bio_crypt_sw_data_unit_num(struct bio *bio)
+{
+	WARN_ON(!bio_is_encrypted(bio));
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
+static inline int bio_clone_crypt_context(struct bio *dst, struct bio *src,
+					  gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline void bio_crypt_advance(struct bio *bio,
+				     unsigned int bytes) { }
+
+static inline bool bio_is_encrypted(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_free_ctx(struct bio *bio) { }
+
+static inline void bio_crypt_set_ctx(struct bio *bio,
+				     u8 *raw_key,
+				     enum blk_crypt_mode_num crypt_mode,
+				     u64 dun,
+				     unsigned int dun_bits) { }
+
+static inline bool bio_crypt_swhandled(struct bio *bio)
+{
+	return false;
+}
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
+static inline void bio_crypt_unset_keyslot(struct bio *bio) { }
+
+static inline int bio_crypt_get_slot(struct bio *bio)
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
+	WARN_ON(1);
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
+
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index aafa96839f95..c111b1ce8d24 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -148,6 +148,29 @@ enum blk_crypt_mode_num {
 	 */
 };
 
+struct bio_crypt_ctx {
+	int keyslot;
+	u8 *raw_key;
+	enum blk_crypt_mode_num crypt_mode;
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
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -186,6 +209,11 @@ struct bio {
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
2.22.0.rc1.311.g5d7573a151-goog

