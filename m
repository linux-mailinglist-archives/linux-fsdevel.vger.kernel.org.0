Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6A1A1A79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDHD5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 23:57:17 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34001 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDHD5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:57:15 -0400
Received: by mail-pf1-f201.google.com with SMTP id 71so4350497pfu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MtAX/xIbpqUCGW2ZIuEBQw9PKLJewJg8nOWzuA5Z47c=;
        b=CYElrtPlDp9Pqs4J1Fp/fLQCKy02nxn8EwR7MUMQdmIXtt3Gj3a8Qs9OIwbN5FcYj3
         U9xWhfftOcH4EkRPbx70T9PMuqddnI6exunScfui1NbAAAhOdoxUDpHMSf77UQx/LHqQ
         kdZ5/saQBugbRfnmB0pbNTCF7ZATSS48avAEQsvhVxHKvC3++x9CbKsFRMesmpsyrl+C
         82mOfoPUqfrtbYjnRh1zrcZFUve0ZjixclM9T/aN1823F1CNE+4j5hhkD7XqbEo5HaAf
         sh/Gb/IRrsJY07rBisRVaV1aiYq1hvLDxdOgpB5E2tT41jeFX/qnwOAfbiSNjDHjuM3c
         LS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MtAX/xIbpqUCGW2ZIuEBQw9PKLJewJg8nOWzuA5Z47c=;
        b=U0/YYAlKP/umgCqdCTaZrHBz89zwylO7/LlW5gfTaZdI2qwCrgxigjb4z63n5lMI2R
         zsU6LKb+O9cUX0hcUTO/50rx55J9pm6X8TxLaLdzn+Vb+oS79ATY+k0yJzdHXDJeN6kT
         KAHHjnV9PsfiGfyPNGzPcCPn6SUNN3mVUDr2WimKL5po2Exz9nsQg8AILTR8kDdrD8G5
         WRWuL/eYdkxYtTI6j7vhxW3nZT5cH80MJHFyTPIjJ30Yh7G7cc+BhOIdGpfSpjZLaLIe
         gTYjWOMwOBnffpe0Od8qmktFy4YRS/KCD/ApuvUCJwc1uZou1LRhhHtRgAq+E9b8NIsL
         Wnew==
X-Gm-Message-State: AGi0Pub06xOhWW4ONbpNTm6YqweKExU4Wdi4zR/eGd+DNX33ri29CjBS
        z/lHT4Q1FO3rJKF4iQSvPJSsQlnuJEI=
X-Google-Smtp-Source: APiQypIrx/eK8l6r5a8H9woi56piKInypmr2ggkX0SM5KpJHVwSt/kjprqBoAmnv/zStvY1xzcvhaLjafDs=
X-Received: by 2002:a17:90a:20f0:: with SMTP id f103mr2838727pjg.88.1586318233695;
 Tue, 07 Apr 2020 20:57:13 -0700 (PDT)
Date:   Tue,  7 Apr 2020 20:56:45 -0700
In-Reply-To: <20200408035654.247908-1-satyat@google.com>
Message-Id: <20200408035654.247908-4-satyat@google.com>
Mime-Version: 1.0
References: <20200408035654.247908-1-satyat@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v10 03/12] block: Inline encryption support for blk-mq
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
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
it's the upper layers (like the filesystem/fscrypt) that know about and
manages encryption contexts. As such, when the upper layer submits a bio
to the block layer, and this bio eventually reaches a device driver with
support for inline encryption, the device driver will need to have been
told the encryption context for that bio.

We want to communicate the encryption context from the upper layer to the
storage device along with the bio, when the bio is submitted to the block
layer. To do this, we add a struct bio_crypt_ctx to struct bio, which can
represent an encryption context (note that we can't use the bi_private
field in struct bio to do this because that field does not function to pass
information across layers in the storage stack). We also introduce various
functions to manipulate the bio_crypt_ctx and make the bio/request merging
logic aware of the bio_crypt_ctx.

We also make changes to blk-mq to make it handle bios with encryption
contexts. blk-mq can merge many bios into the same request. These bios need
to have contiguous data unit numbers (the necessary changes to blk-merge
are also made to ensure this) - as such, it suffices to keep the data unit
number of just the first bio, since that's all a storage driver needs to
infer the data unit number to use for each data block in each bio in a
request. blk-mq keeps track of the encryption context to be used for all
the bios in a request with the request's rq_crypt_ctx. When the first bio
is added to an empty request, blk-mq will program the encryption context
of that bio into the request_queue's keyslot manager, and store the
returned keyslot in the request's rq_crypt_ctx. All the functions to
operate on encryption contexts are in blk-crypto.c.

Upper layers only need to call bio_crypt_set_ctx with the encryption key,
algorithm and data_unit_num; they don't have to worry about getting a
keyslot for each encryption context, as blk-mq/blk-crypto handles that.
Blk-crypto also makes it possible for request-based layered devices like
dm-rq to make use of inline encryption hardware by cloning the
rq_crypt_ctx and programming a keyslot in the new request_queue when
necessary.

Note that any user of the block layer can submit bios with an
encryption context, such as filesystems, device-mapper targets, etc.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/Makefile              |   2 +-
 block/bio.c                 |   6 +
 block/blk-core.c            |  20 +-
 block/blk-crypto-internal.h | 157 ++++++++++++++
 block/blk-crypto.c          | 396 ++++++++++++++++++++++++++++++++++++
 block/blk-map.c             |   1 +
 block/blk-merge.c           |  11 +
 block/blk-mq.c              |  13 ++
 block/blk.h                 |   4 +
 block/bounce.c              |   2 +
 drivers/md/dm.c             |   3 +
 include/linux/blk-crypto.h  |  71 +++++++
 include/linux/blk_types.h   |   6 +
 include/linux/blkdev.h      |   5 +
 14 files changed, 692 insertions(+), 5 deletions(-)
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c

diff --git a/block/Makefile b/block/Makefile
index fc963e4676b0a..3ee88d3e807d2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,4 +36,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20e..960303de1bb4a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -18,6 +18,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
 #include <linux/sched/sysctl.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -237,6 +238,8 @@ void bio_uninit(struct bio *bio)
 
 	if (bio_integrity(bio))
 		bio_integrity_free(bio);
+
+	bio_crypt_free_ctx(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
 
@@ -708,6 +711,8 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 
 	__bio_clone_fast(b, bio);
 
+	bio_crypt_clone(b, bio, gfp_mask);
+
 	if (bio_integrity(bio)) {
 		int ret;
 
@@ -1105,6 +1110,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
 
+	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715ea..99bc42c38feba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -38,6 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/blk-crypto.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -120,6 +121,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
 	refcount_set(&rq->ref, 1);
+	blk_crypto_rq_set_defaults(rq);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
@@ -623,6 +625,8 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
 
+	bio_crypt_free_ctx(bio);
+
 	blk_account_io_start(req, false);
 	return true;
 }
@@ -647,6 +651,8 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 	req->__sector = bio->bi_iter.bi_sector;
 	req->__data_len += bio->bi_iter.bi_size;
 
+	blk_crypto_rq_bio_prep(req, bio);
+
 	blk_account_io_start(req, false);
 	return true;
 }
@@ -1072,7 +1078,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret = q->make_request_fn(q, bio);
+			if (blk_crypto_bio_prep(&bio))
+				ret = q->make_request_fn(q, bio);
 
 			blk_queue_exit(q);
 
@@ -1120,7 +1127,7 @@ blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
-	blk_qc_t ret;
+	blk_qc_t ret = BLK_QC_T_NONE;
 
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
@@ -1132,8 +1139,8 @@ blk_qc_t direct_make_request(struct bio *bio)
 			bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
-
-	ret = q->make_request_fn(q, bio);
+	if (blk_crypto_bio_prep(&bio))
+		ret = q->make_request_fn(q, bio);
 	blk_queue_exit(q);
 	return ret;
 }
@@ -1263,6 +1270,9 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
+	if (blk_crypto_insert_cloned_request(rq))
+		return BLK_STS_IOERR;
+
 	if (blk_queue_io_stat(q))
 		blk_account_io_start(rq, true);
 
@@ -1640,6 +1650,8 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	rq->ioprio = rq_src->ioprio;
 	rq->extra_len = rq_src->extra_len;
 
+	blk_crypto_rq_prep_clone(rq, rq_src);
+
 	return 0;
 
 free_and_out:
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
new file mode 100644
index 0000000000000..bcaa08442bfda
--- /dev/null
+++ b/block/blk-crypto-internal.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_INTERNAL_H
+#define __LINUX_BLK_CRYPTO_INTERNAL_H
+
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+
+/* Represents a crypto mode supported by blk-crypto  */
+struct blk_crypto_mode {
+	unsigned int keysize; /* key size in bytes */
+	unsigned int ivsize; /* iv size in bytes */
+};
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int inc);
+
+bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
+
+bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
+			     struct bio_crypt_ctx *bc2);
+
+static inline bool bio_crypt_ctx_back_mergeable(struct request *req,
+						struct bio *bio)
+{
+	return bio_crypt_ctx_mergeable(req->crypt_ctx, blk_rq_bytes(req),
+				       bio->bi_crypt_context);
+}
+
+static inline bool bio_crypt_ctx_front_mergeable(struct request *req,
+						 struct bio *bio)
+{
+	return bio_crypt_ctx_mergeable(bio->bi_crypt_context,
+				       bio->bi_iter.bi_size, req->crypt_ctx);
+}
+
+static inline bool bio_crypt_ctx_merge_rq(struct request *req,
+					  struct request *next)
+{
+	return bio_crypt_ctx_mergeable(req->crypt_ctx, blk_rq_bytes(req),
+				       next->crypt_ctx);
+}
+
+static inline void blk_crypto_rq_set_defaults(struct request *rq)
+{
+	rq->crypt_ctx = NULL;
+	rq->crypt_keyslot = NULL;
+}
+
+static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
+{
+	return rq->crypt_ctx;
+}
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
+					       struct bio *bio)
+{
+	return true;
+}
+
+static inline bool bio_crypt_ctx_front_mergeable(struct request *req,
+						 struct bio *bio)
+{
+	return true;
+}
+
+static inline bool bio_crypt_ctx_back_mergeable(struct request *req,
+						struct bio *bio)
+{
+	return true;
+}
+
+static inline bool bio_crypt_ctx_merge_rq(struct request *req,
+					  struct request *next)
+{
+	return true;
+}
+
+static inline void blk_crypto_rq_set_defaults(struct request *rq) { }
+
+static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
+{
+	return false;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	if (bio_has_crypt_ctx(bio))
+		__bio_crypt_advance(bio, bytes);
+}
+
+void __bio_crypt_free_ctx(struct bio *bio);
+static inline void bio_crypt_free_ctx(struct bio *bio)
+{
+	if (bio_has_crypt_ctx(bio))
+		__bio_crypt_free_ctx(bio);
+}
+
+bool __blk_crypto_bio_prep(struct bio **bio_ptr);
+static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
+{
+	if (bio_has_crypt_ctx(*bio_ptr))
+		return __blk_crypto_bio_prep(bio_ptr);
+	return true;
+}
+
+blk_status_t __blk_crypto_init_request(struct request *rq);
+static inline blk_status_t blk_crypto_init_request(struct request *rq)
+{
+	if (blk_crypto_rq_is_encrypted(rq))
+		return __blk_crypto_init_request(rq);
+	return BLK_STS_OK;
+}
+
+void __blk_crypto_free_request(struct request *rq);
+static inline void blk_crypto_free_request(struct request *rq)
+{
+	if (blk_crypto_rq_is_encrypted(rq))
+		__blk_crypto_free_request(rq);
+}
+
+void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio);
+static inline void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
+{
+	if (bio_has_crypt_ctx(bio))
+		__blk_crypto_rq_bio_prep(rq, bio);
+}
+
+void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src);
+static inline void blk_crypto_rq_prep_clone(struct request *dst,
+					    struct request *src)
+{
+
+	if (blk_crypto_rq_is_encrypted(src))
+		__blk_crypto_rq_prep_clone(dst, src);
+}
+
+blk_status_t __blk_crypto_insert_cloned_request(struct request *rq);
+static inline blk_status_t blk_crypto_insert_cloned_request(struct request *rq)
+{
+
+	if (blk_crypto_rq_is_encrypted(rq))
+		return __blk_crypto_insert_cloned_request(rq);
+	return BLK_STS_OK;
+}
+
+#endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 0000000000000..7546363dc584e
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#define pr_fmt(fmt) "blk-crypto: " fmt
+
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/keyslot-manager.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
+#include <linux/slab.h>
+
+#include "blk-crypto-internal.h"
+
+const struct blk_crypto_mode blk_crypto_modes[] = {
+	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
+		.keysize = 64,
+		.ivsize = 16,
+	},
+	[BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV] = {
+		.keysize = 16,
+		.ivsize = 16,
+	},
+	[BLK_ENCRYPTION_MODE_ADIANTUM] = {
+		.keysize = 32,
+		.ivsize = 32,
+	},
+};
+
+/*
+ * This number needs to be at least (the number of threads doing IO
+ * concurrently) * (maximum recursive depth of a bio), so that we don't
+ * deadlock on crypt_ctx allocations. The default is chosen to be the same
+ * as the default number of post read contexts in both EXT4 and F2FS.
+ */
+static int num_prealloc_crypt_ctxs = 128;
+
+module_param(num_prealloc_crypt_ctxs, int, 0444);
+MODULE_PARM_DESC(num_prealloc_crypt_ctxs,
+		"Number of bio crypto contexts to preallocate");
+
+static struct kmem_cache *bio_crypt_ctx_cache;
+static mempool_t *bio_crypt_ctx_pool;
+
+static int __init bio_crypt_ctx_init(void)
+{
+	size_t i;
+
+	bio_crypt_ctx_cache = KMEM_CACHE(bio_crypt_ctx, 0);
+	if (!bio_crypt_ctx_cache)
+		goto out_no_mem;
+
+	bio_crypt_ctx_pool = mempool_create_slab_pool(num_prealloc_crypt_ctxs,
+						      bio_crypt_ctx_cache);
+	if (!bio_crypt_ctx_pool)
+		goto out_no_mem;
+
+	/* This is assumed in various places. */
+	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
+
+	/* Sanity check that no algorithm exceeds the defined limits. */
+	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++) {
+		BUG_ON(blk_crypto_modes[i].keysize > BLK_CRYPTO_MAX_KEY_SIZE);
+		BUG_ON(blk_crypto_modes[i].ivsize > BLK_CRYPTO_MAX_IV_SIZE);
+	}
+
+	return 0;
+out_no_mem:
+	panic("Failed to allocate mem for bio crypt ctxs\n");
+}
+subsys_initcall(bio_crypt_ctx_init);
+
+void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
+		       const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE], gfp_t gfp_mask)
+{
+	struct bio_crypt_ctx *bc = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+
+	bc->bc_key = key;
+	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
+
+	bio->bi_crypt_context = bc;
+}
+
+void __bio_crypt_free_ctx(struct bio *bio)
+{
+	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
+	bio->bi_crypt_context = NULL;
+}
+
+void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
+{
+	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+	*dst->bi_crypt_context = *src->bi_crypt_context;
+}
+EXPORT_SYMBOL_GPL(__bio_crypt_clone);
+
+void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int inc)
+{
+	int i = 0;
+
+	while (inc && i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
+		dun[i] += inc;
+		inc = (dun[i] < inc);
+		i++;
+	}
+}
+
+void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+	bio_crypt_dun_increment(bc->bc_dun,
+				bytes >> bc->bc_key->data_unit_size_bits);
+}
+
+/*
+ * Returns true if @bc_dun plus @bytes converted to data units is equal to
+ * @next_dun, treating the DUNs as multi-limb integers.
+ */
+bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
+				 unsigned int bytes,
+				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
+{
+	int i = 0;
+	unsigned int carry = bytes >> bc->bc_key->data_unit_size_bits;
+
+	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
+		if (bc->bc_dun[i] + carry != next_dun[i])
+			return false;
+		/*
+		 * If the addition in this limb overflowed, then we need to
+		 * carry 1 into the next limb. Else the carry is 0.
+		 */
+		if ((bc->bc_dun[i] + carry) < carry)
+			carry = 1;
+		else
+			carry = 0;
+		i++;
+	}
+
+	/* If the DUN wrapped through 0, don't treat it as contiguous. */
+	return carry == 0;
+}
+
+/*
+ * Checks that two bio crypt contexts are compatible - i.e. that
+ * they are mergeable except for data_unit_num continuity.
+ */
+static bool bio_crypt_ctx_compatible(struct bio_crypt_ctx *bc1,
+				     struct bio_crypt_ctx *bc2)
+{
+	if (!bc1)
+		return !bc2;
+
+	return bc2 && bc1->bc_key == bc2->bc_key;
+}
+
+bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio)
+{
+	return bio_crypt_ctx_compatible(rq->crypt_ctx, bio->bi_crypt_context);
+}
+
+/*
+ * Checks that two bio crypt contexts are compatible, and also
+ * that their data_unit_nums are continuous (and can hence be merged)
+ * in the order b_1 followed by b_2.
+ */
+bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
+			     struct bio_crypt_ctx *bc2)
+{
+	if (!bio_crypt_ctx_compatible(bc1, bc2))
+		return false;
+
+	return !bc1 || bio_crypt_dun_is_contiguous(bc1, bc1_bytes, bc2->bc_dun);
+}
+
+/*
+ * Check that all I/O segments are data unit aligned, and set bio->bi_status
+ * on error.
+ */
+static bool bio_crypt_check_alignment(struct bio *bio)
+{
+	const unsigned int data_unit_size =
+		bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bio_for_each_segment(bv, bio, iter) {
+		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size)) {
+			bio->bi_status = BLK_STS_IOERR;
+			return false;
+		}
+	}
+
+	return true;
+}
+
+blk_status_t __blk_crypto_init_request(struct request *rq)
+{
+	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
+					&rq->crypt_keyslot);
+}
+
+/**
+ * __blk_crypto_free_request - Uninitialize the crypto fields of a request.
+ *
+ * @rq: The request whose crypto fields to uninitialize.
+ *
+ * Completely uninitializes the crypto fields of a request. If a keyslot has
+ * been programmed into some inline encryption hardware, that keyslot is
+ * released. The rq->crypt_ctx is also freed.
+ */
+void __blk_crypto_free_request(struct request *rq)
+{
+	blk_ksm_put_slot(rq->crypt_keyslot);
+	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
+	blk_crypto_rq_set_defaults(rq);
+}
+
+/**
+ * __blk_crypto_bio_prep - Prepare bio for inline encryption
+ *
+ * @bio_ptr: pointer to original bio pointer
+ *
+ * Succeeds if the bio doesn't have inline encryption enabled or if the bio
+ * crypt context provided for the bio is supported by the underlying device's
+ * inline encryption hardware. Ends the bio with error otherwise.
+ *
+ * Caller must ensure bio has bio_crypt_ctx.
+ *
+ * Return: true on success; false on error (and bio->bi_status will be set
+ *	   appropriately, and bio_endio() will have been called so bio
+ *	   submission should abort).
+ */
+bool __blk_crypto_bio_prep(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+
+	/* Error if bio has no data. */
+	if (WARN_ON_ONCE(!bio_has_data(bio)))
+		goto fail;
+
+	if (!bio_crypt_check_alignment(bio))
+		goto fail;
+
+	/*
+	 * Success if device supports the encryption context, and blk-integrity
+	 * isn't supported by device/is turned off.
+	 */
+	if (!blk_ksm_crypto_cfg_supported(bio->bi_disk->queue->ksm,
+				&bio->bi_crypt_context->bc_key->crypto_cfg)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		goto fail;
+	}
+
+	return true;
+fail:
+	bio_endio(*bio_ptr);
+	return false;
+}
+
+/**
+ * __blk_crypto_rq_bio_prep - Prepare a request when its first bio is inserted
+ *
+ * @rq: The request to prepare
+ * @bio: The first bio being inserted into the request
+ *
+ * Frees the bio crypt context in the request's old rq->crypt_ctx, if any, and
+ * moves the bio crypt context of the bio into the request's rq->crypt_ctx.
+ */
+void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
+{
+	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
+	rq->crypt_ctx = bio->bi_crypt_context;
+	bio->bi_crypt_context = NULL;
+}
+
+void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
+{
+	dst->crypt_ctx = src->crypt_ctx;
+}
+
+/**
+ * __blk_crypto_insert_cloned_request - Prepare a cloned request to be inserted
+ *					into a request queue.
+ * @rq: the request being queued
+ *
+ * Return: BLK_STS_OK on success, nonzero on error.
+ */
+blk_status_t __blk_crypto_insert_cloned_request(struct request *rq)
+{
+	return blk_crypto_init_request(rq);
+}
+
+/**
+ * blk_crypto_init_key() - Prepare a key for use with blk-crypto
+ * @blk_key: Pointer to the blk_crypto_key to initialize.
+ * @raw_key: Pointer to the raw key. Must be the correct length for the chosen
+ *	     @crypto_mode; see blk_crypto_modes[].
+ * @crypto_mode: identifier for the encryption algorithm to use
+ * @dun_bytes: number of bytes that will be used to specify the DUN when this
+ *	       key is used
+ * @data_unit_size: the data unit size to use for en/decryption
+ *
+ * Return: 0 on success, -errno on failure.  The caller is responsible for
+ *	   zeroizing both blk_key and raw_key when done with them.
+ */
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
+			unsigned int dun_bytes,
+			unsigned int data_unit_size)
+{
+	const struct blk_crypto_mode *mode;
+	static siphash_key_t hash_key;
+
+	memset(blk_key, 0, sizeof(*blk_key));
+
+	if (crypto_mode >= ARRAY_SIZE(blk_crypto_modes))
+		return -EINVAL;
+
+	mode = &blk_crypto_modes[crypto_mode];
+	if (mode->keysize == 0)
+		return -EINVAL;
+
+	if (!is_power_of_2(data_unit_size))
+		return -EINVAL;
+
+	blk_key->crypto_cfg.crypto_mode = crypto_mode;
+	blk_key->crypto_cfg.dun_bytes = dun_bytes;
+	blk_key->crypto_cfg.data_unit_size = data_unit_size;
+	blk_key->data_unit_size_bits = ilog2(data_unit_size);
+	blk_key->size = mode->keysize;
+	memcpy(blk_key->raw, raw_key, mode->keysize);
+
+	/*
+	 * The keyslot manager uses the SipHash of the key to implement O(1) key
+	 * lookups while avoiding leaking information about the keys.  It's
+	 * precomputed here so that it only needs to be computed once per key.
+	 */
+	get_random_once(&hash_key, sizeof(hash_key));
+	blk_key->hash = siphash(raw_key, mode->keysize, &hash_key);
+
+	return 0;
+}
+
+bool blk_crypto_config_supported(struct request_queue *q,
+				 const struct blk_crypto_config *cfg)
+{
+	return blk_ksm_crypto_cfg_supported(q->ksm, cfg);
+}
+
+/**
+ * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
+ * @key: A key to use on the device
+ * @q: the request queue for the device
+ *
+ * Upper layers must call this function to ensure that the hardware supports
+ * the key's crypto settings.
+ *
+ * Return: 0 on success; -ENOPKG if the hardware doesn't support the key
+ */
+int blk_crypto_start_using_key(const struct blk_crypto_key *key,
+			       struct request_queue *q)
+{
+	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		return 0;
+	return -ENOPKG;
+}
+EXPORT_SYMBOL_GPL(blk_crypto_start_using_key);
+
+/**
+ * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
+ *			    it may have been programmed into
+ * @q: The request queue who's associated inline encryption hardware this key
+ *     might have been programmed into
+ * @key: The key to evict
+ *
+ * Upper layers (filesystems) should call this function to ensure that a key
+ * is evicted from hardware that it might have been programmed into. This
+ * will call blk_ksm_evict_key on the queue's keyslot manager, if one
+ * exists, and supports the crypto algorithm with the specified data unit size.
+ *
+ * Return: 0 on success or if key is not present in the q's ksm, -err on error.
+ */
+int blk_crypto_evict_key(struct request_queue *q,
+			 const struct blk_crypto_key *key)
+{
+	if (q->ksm && blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		return blk_ksm_evict_key(q->ksm, key);
+
+	return 0;
+}
diff --git a/block/blk-map.c b/block/blk-map.c
index b72c361911a48..92e23e5ff2458 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -549,6 +549,7 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
 		rq->biotail->bi_next = *bio;
 		rq->biotail = *bio;
 		rq->__data_len += (*bio)->bi_iter.bi_size;
+		bio_crypt_free_ctx(*bio);
 	}
 
 	return 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363f..a0c24b6e0eb3e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -596,6 +596,8 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 	if (blk_integrity_rq(req) &&
 	    integrity_req_gap_back_merge(req, bio))
 		return 0;
+	if (!bio_crypt_ctx_back_mergeable(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
 		req_set_nomerge(req->q, req);
@@ -612,6 +614,8 @@ int ll_front_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs
 	if (blk_integrity_rq(req) &&
 	    integrity_req_gap_front_merge(req, bio))
 		return 0;
+	if (!bio_crypt_ctx_front_mergeable(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
 		req_set_nomerge(req->q, req);
@@ -661,6 +665,9 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;
 
+	if (!bio_crypt_ctx_merge_rq(req, next))
+		return 0;
+
 	/* Merge is OK... */
 	req->nr_phys_segments = total_phys_segments;
 	return 1;
@@ -885,6 +892,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
 
+	/* Only merge if the crypt contexts are compatible */
+	if (!bio_crypt_rq_ctx_compatible(rq, bio))
+		return false;
+
 	/* must be using the same buffer */
 	if (req_op(rq) == REQ_OP_WRITE_SAME &&
 	    !blk_write_same_mergeable(rq->bio, bio))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4a..2099691cf6ad8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 
@@ -317,6 +318,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
 #endif
+	blk_crypto_rq_set_defaults(rq);
 	/* tag was already set */
 	rq->extra_len = 0;
 	WRITE_ONCE(rq->deadline, 0);
@@ -474,6 +476,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	const int sched_tag = rq->internal_tag;
 
+	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 	if (rq->tag != -1)
@@ -1978,6 +1981,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct request *same_queue_rq = NULL;
 	unsigned int nr_segs;
 	blk_qc_t cookie;
+	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(q, &bio, &nr_segs);
@@ -2011,6 +2015,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
+	ret = blk_crypto_init_request(rq);
+	if (ret != BLK_STS_OK) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+		blk_mq_free_request(rq);
+		return BLK_QC_T_NONE;
+	}
+
+
 	plug = blk_mq_plug(q, bio);
 	if (unlikely(is_flush_fua)) {
 		/* Bypass scheduler for flush requests */
diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32b..b5fb2b3e7d94b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -5,7 +5,9 @@
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
 #include <linux/part_stat.h>
+#include <linux/blk-crypto.h>
 #include <xen/xen.h>
+#include "blk-crypto-internal.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
 
@@ -118,6 +120,8 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
+
+	blk_crypto_rq_bio_prep(rq, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7e..c3aaed0701246 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -267,6 +267,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		break;
 	}
 
+	bio_crypt_clone(bio, bio_src, gfp_mask);
+
 	if (bio_integrity(bio_src)) {
 		int ret;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 21c0207e3207f..8cb0dc6000bb5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -26,6 +26,7 @@
 #include <linux/pr.h>
 #include <linux/refcount.h>
 #include <linux/part_stat.h>
+#include <linux/blk-crypto.h>
 
 #define DM_MSG_PREFIX "core"
 
@@ -1305,6 +1306,8 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 
 	__bio_clone_fast(clone, bio);
 
+	bio_crypt_clone(clone, bio, GFP_NOIO);
+
 	if (bio_integrity(bio)) {
 		int r;
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index eaa683d9dca37..3c8276b9c4510 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -6,6 +6,8 @@
 #ifndef __LINUX_BLK_CRYPTO_H
 #define __LINUX_BLK_CRYPTO_H
 
+#include <linux/types.h>
+
 enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_INVALID,
 	BLK_ENCRYPTION_MODE_AES_256_XTS,
@@ -50,4 +52,73 @@ struct blk_crypto_key {
 	u8 raw[BLK_CRYPTO_MAX_KEY_SIZE];
 };
 
+#define BLK_CRYPTO_MAX_IV_SIZE		32
+#define BLK_CRYPTO_DUN_ARRAY_SIZE	(BLK_CRYPTO_MAX_IV_SIZE/sizeof(u64))
+
+/**
+ * struct bio_crypt_ctx - an inline encryption context
+ * @bc_key: the key, algorithm, and data unit size to use
+ * @bc_dun: the data unit number (starting IV) to use
+ *
+ * A bio_crypt_ctx specifies that the contents of the bio will be encrypted (for
+ * write requests) or decrypted (for read requests) inline by the storage device
+ * or controller.
+ */
+struct bio_crypt_ctx {
+	const struct blk_crypto_key	*bc_key;
+	u64				bc_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+};
+
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+
+struct request;
+struct request_queue;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return bio->bi_crypt_context;
+}
+
+void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
+		       const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+		       gfp_t gfp_mask);
+
+bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
+				 unsigned int bytes,
+				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE]);
+
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
+			unsigned int dun_bytes,
+			unsigned int data_unit_size);
+
+int blk_crypto_start_using_key(const struct blk_crypto_key *key,
+			       struct request_queue *q);
+
+int blk_crypto_evict_key(struct request_queue *q,
+			 const struct blk_crypto_key *key);
+
+bool blk_crypto_config_supported(struct request_queue *q,
+				 const struct blk_crypto_config *cfg);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return false;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
+static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
+				   gfp_t gfp_mask)
+{
+	if (bio_has_crypt_ctx(src))
+		__bio_crypt_clone(dst, src, gfp_mask);
+}
+
 #endif /* __LINUX_BLK_CRYPTO_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae117690..1996689c51d38 100644
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7b36695f71931..98aae4638fda9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -224,6 +224,11 @@ struct request {
 	unsigned short nr_integrity_segments;
 #endif
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct bio_crypt_ctx *crypt_ctx;
+	struct blk_ksm_keyslot *crypt_keyslot;
+#endif
+
 	unsigned short write_hint;
 	unsigned short ioprio;
 
-- 
2.26.0.110.g2183baf09c-goog

