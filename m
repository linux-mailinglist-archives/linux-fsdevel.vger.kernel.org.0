Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB1167C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBULvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:51:10 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49515 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgBULvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:51:07 -0500
Received: by mail-pg1-f201.google.com with SMTP id u14so1045385pgq.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yagKer9E3Fu9lQJukupqwDAeVgC9XQWyGMZE/BCTkPQ=;
        b=WXjmMIeD5Clp1E3WUfxXU6XVKFsaTJV2rihZnO9J+2+G29xShEPS1Vc3Yh1Dl3SOj3
         nM9lCRabGMS5+xIHZYDccGTxrF23r+W3vryc9tAzDMwEqwY6TfIaH3JknA33G/86hnjX
         jl/9KRYrtG24jlIvIMachjun4Yt892oZRlWGHnl7CLSoQENDaRhJK0MfyM5CflIlJAht
         MFYacpv5D7Ubo3DMXIQUUxXuBAd8iyV/TmyDeSo8ivncLgGjecfT2uagD/gt6lvAwmBF
         1uN+CtkGWpLg0XdmVBCKxVe7pS6GYl2pEk+rlN9k5f1olVkBJSqA2y38jpqf4cHjQLl6
         sx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yagKer9E3Fu9lQJukupqwDAeVgC9XQWyGMZE/BCTkPQ=;
        b=uY58fIegdy7sgYGu6s4K5EQtdAetGg7rtMsu/Pkord5mrI11mRXr58sfogvQ/i/iDm
         /Tg8hD2EQwee9hsK+5hWcy3ejwa8b/MNeCYAGlSVAFFP0Gsc5B67P0DWOtS+ehLja/XQ
         x4OsPsdiRcVqXqCkYoFg+pwtHRLyRkBhM2Pa8iXN65KkNrJm9jtDtitZC5vJbE8sq2vt
         v7V/D/mWRQiFivK9fksysTJj4Rn6krPEEIZZK6sZ7nuJ/gLuv2xwRP+Kh7OqySCFZJg6
         YBplY9tXm4Yak69phQnG0U3jvapAPAZmouMNLylIads95HHRGD2fuXg1TSSO9fADs0We
         Ql9w==
X-Gm-Message-State: APjAAAUpHkQCazL4TcK9tC268ABlXOMdetNA/SfqryMrahEx7DbwJtde
        wnvHJ9eDeJoyyOkVvM3jcW2WOuDsSzg=
X-Google-Smtp-Source: APXvYqyrDeM4OxvA+zHYLAifyWEkwKHj+euE5iN6s5zqBXK3iA20CLokxJhQbyTFJif/TKARZCoevDbsvak=
X-Received: by 2002:a65:44cd:: with SMTP id g13mr112135pgs.365.1582285865406;
 Fri, 21 Feb 2020 03:51:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 03:50:43 -0800
In-Reply-To: <20200221115050.238976-1-satyat@google.com>
Message-Id: <20200221115050.238976-3-satyat@google.com>
Mime-Version: 1.0
References: <20200221115050.238976-1-satyat@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 2/9] block: Inline encryption support for blk-mq
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
it's the upper layers (like the filesystem/fscrypt) that knows about
and manages encryption contexts. As such, when the upper layer submits
a bio to the block layer, and this bio eventually reaches a device
driver with support for inline encryption, the device driver will need
to have been told the encryption context for that bio.

We want to communicate the encryption context from the upper layer
to the storage device along with the bio, when the bio is submitted to the
block layer. To do this, we add a struct bio_crypt_ctx to struct bio, which
can represent an encryption context (note that we can't use the bi_private
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

For now, blk-crypto and blk-integrity can't be used with each other
(and any attempts to do both on a bio will cause the bio to fail).

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
 block/bio-integrity.c       |   5 +
 block/bio.c                 |   7 +-
 block/blk-core.c            |  16 ++
 block/blk-crypto-internal.h |  19 ++
 block/blk-crypto.c          | 412 ++++++++++++++++++++++++++++++++++++
 block/blk-map.c             |   1 +
 block/blk-merge.c           |  11 +
 block/blk-mq.c              |  16 ++
 block/blk.h                 |   3 +
 block/bounce.c              |   2 +
 drivers/md/dm.c             |   2 +
 include/linux/blk-crypto.h  | 211 ++++++++++++++++++
 include/linux/blk_types.h   |   6 +
 include/linux/blkdev.h      |  10 +
 15 files changed, 721 insertions(+), 2 deletions(-)
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c

diff --git a/block/Makefile b/block/Makefile
index ef3a05dcf1f2..82f42ca3f769 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -37,4 +37,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..bce563031e7c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -42,6 +42,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	struct bio_set *bs = bio->bi_pool;
 	unsigned inline_vecs;
 
+	if (bio_has_crypt_ctx(bio)) {
+		pr_warn("blk-integrity can't be used together with blk-crypto en/decryption.");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
 		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
 		inline_vecs = nr_vecs;
diff --git a/block/bio.c b/block/bio.c
index 94d697217887..115fd5960508 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -236,6 +237,8 @@ void bio_uninit(struct bio *bio)
 
 	if (bio_integrity(bio))
 		bio_integrity_free(bio);
+
+	bio_crypt_free_ctx(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
 
@@ -664,11 +667,12 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 
 	__bio_clone_fast(b, bio);
 
+	bio_crypt_clone(b, bio, gfp_mask);
+
 	if (bio_integrity(bio)) {
 		int ret;
 
 		ret = bio_integrity_clone(b, bio, gfp_mask);
-
 		if (ret < 0) {
 			bio_put(b);
 			return NULL;
@@ -1046,6 +1050,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
 
+	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..1d8f3fa5cb6c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -38,6 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/blk-crypto.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -120,6 +121,9 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
 	refcount_set(&rq->ref, 1);
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	rq->rq_crypt_ctx.keyslot = -EINVAL;
+#endif
 }
 EXPORT_SYMBOL(blk_rq_init);
 
@@ -617,6 +621,8 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
 
+	bio_crypt_free_ctx(bio);
+
 	blk_account_io_start(req, false);
 	return true;
 }
@@ -641,6 +647,8 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 	req->__sector = bio->bi_iter.bi_sector;
 	req->__data_len += bio->bi_iter.bi_size;
 
+	blk_crypto_rq_bio_prep(req, bio);
+
 	blk_account_io_start(req, false);
 	return true;
 }
@@ -1258,6 +1266,9 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
+	if (blk_crypto_insert_cloned_request(q, rq))
+		return BLK_STS_IOERR;
+
 	if (blk_queue_io_stat(q))
 		blk_account_io_start(rq, true);
 
@@ -1646,6 +1657,8 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 
 	__blk_rq_prep_clone(rq, rq_src);
 
+	blk_crypto_rq_prep_clone(rq, rq_src);
+
 	return 0;
 
 free_and_out:
@@ -1813,5 +1826,8 @@ int __init blk_dev_init(void)
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 #endif
 
+	if (bio_crypt_ctx_init() < 0)
+		panic("Failed to allocate mem for bio crypt ctxs\n");
+
 	return 0;
 }
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
new file mode 100644
index 000000000000..2452b5dee140
--- /dev/null
+++ b/block/blk-crypto-internal.h
@@ -0,0 +1,19 @@
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
+	const char *cipher_str; /* crypto API name (for fallback case) */
+	unsigned int keysize; /* key size in bytes */
+	unsigned int ivsize; /* iv size in bytes */
+};
+
+#endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 000000000000..b10b01c83907
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,412 @@
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
+		.cipher_str = "xts(aes)",
+		.keysize = 64,
+		.ivsize = 16,
+	},
+	[BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV] = {
+		.cipher_str = "essiv(cbc(aes),sha256)",
+		.keysize = 16,
+		.ivsize = 16,
+	},
+	[BLK_ENCRYPTION_MODE_ADIANTUM] = {
+		.cipher_str = "adiantum(xchacha12,aes)",
+		.keysize = 32,
+		.ivsize = 32,
+	},
+};
+
+static int num_prealloc_crypt_ctxs = 128;
+
+module_param(num_prealloc_crypt_ctxs, int, 0444);
+MODULE_PARM_DESC(num_prealloc_crypt_ctxs,
+		"Number of bio crypto contexts to preallocate");
+
+static struct kmem_cache *bio_crypt_ctx_cache;
+static mempool_t *bio_crypt_ctx_pool;
+
+int __init bio_crypt_ctx_init(void)
+{
+	size_t i;
+
+	bio_crypt_ctx_cache = KMEM_CACHE(bio_crypt_ctx, 0);
+	if (!bio_crypt_ctx_cache)
+		return -ENOMEM;
+
+	bio_crypt_ctx_pool = mempool_create_slab_pool(num_prealloc_crypt_ctxs,
+						      bio_crypt_ctx_cache);
+	if (!bio_crypt_ctx_pool)
+		return -ENOMEM;
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
+}
+
+struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
+{
+	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+}
+
+void bio_crypt_free_ctx(struct bio *bio)
+{
+	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
+	bio->bi_crypt_context = NULL;
+}
+
+void bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
+{
+	const struct bio_crypt_ctx *src_bc = src->bi_crypt_context;
+
+	if (!src_bc)
+		return;
+
+	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
+	*dst->bi_crypt_context = *src_bc;
+}
+EXPORT_SYMBOL_GPL(bio_crypt_clone);
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
+	return bio_crypt_ctx_compatible(rq->rq_crypt_ctx.bc,
+					bio->bi_crypt_context);
+}
+
+/*
+ * Checks that two bio crypt contexts are compatible, and also
+ * that their data_unit_nums are continuous (and can hence be merged)
+ * in the order b_1 followed by b_2.
+ */
+static bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1,
+				    unsigned int bc1_bytes,
+				    struct bio_crypt_ctx *bc2)
+{
+	if (!bio_crypt_ctx_compatible(bc1, bc2))
+		return false;
+
+	return !bc1 || bio_crypt_dun_is_contiguous(bc1, bc1_bytes, bc2->bc_dun);
+}
+
+bool bio_crypt_ctx_back_mergeable(struct request *req, struct bio *bio)
+{
+	return bio_crypt_ctx_mergeable(req->rq_crypt_ctx.bc, blk_rq_bytes(req),
+				       bio->bi_crypt_context);
+}
+
+bool bio_crypt_ctx_front_mergeable(struct request *req, struct bio *bio)
+{
+	return bio_crypt_ctx_mergeable(bio->bi_crypt_context,
+				       bio->bi_iter.bi_size,
+				       req->rq_crypt_ctx.bc);
+}
+
+bool bio_crypt_ctx_merge_rq(struct request *req, struct request *next)
+{
+	return bio_crypt_ctx_mergeable(req->rq_crypt_ctx.bc, blk_rq_bytes(req),
+				       next->rq_crypt_ctx.bc);
+}
+
+/* Check that all I/O segments are data unit aligned */
+static int bio_crypt_check_alignment(struct bio *bio)
+{
+	const unsigned int data_unit_size =
+				bio->bi_crypt_context->bc_key->data_unit_size;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bio_for_each_segment(bv, bio, iter) {
+		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
+			return -EIO;
+	}
+	return 0;
+}
+
+/* Return: 0 on success, negative on error */
+int rq_crypt_ctx_acquire_keyslot(struct bio_crypt_ctx *bc,
+				  struct keyslot_manager *ksm,
+				  struct rq_crypt_ctx *rc)
+{
+	rc->keyslot = blk_ksm_get_slot_for_key(ksm, bc->bc_key);
+	return rc->keyslot >= 0 ? 0 : rc->keyslot;
+}
+
+void rq_crypt_ctx_release_keyslot(struct keyslot_manager *ksm,
+				  struct rq_crypt_ctx *rc)
+{
+	if (rc->keyslot >= 0)
+		blk_ksm_put_slot(ksm, rc->keyslot);
+	rc->keyslot = -EINVAL;
+}
+
+/**
+ * blk_crypto_init_request - Initializes the request's rq_crypt_ctx based on the
+ *			     bio to be added to the request, and prepares it for
+ *			     hardware inline encryption.
+ *
+ * @rq: The request to init
+ * @q: The request queue this request will be submitted to
+ * @bio: The bio that will (eventually) be added to @rq.
+ *
+ * Initializes the request's rq_crypt_ctx to appropriate default values.
+ * Then, if the bio doesn't have an encryption context, there's nothing to do.
+ * Otherwise, we're relying on the underlying device's inline encryption HW for
+ * en/decryption, so get a keyslot for the bio crypt ctx.
+ *
+ * Return: 0 on success, and negative error code otherwise.
+ */
+int blk_crypto_init_request(struct request *rq, struct request_queue *q,
+			    struct bio *bio)
+{
+	struct rq_crypt_ctx *rc = &rq->rq_crypt_ctx;
+	struct bio_crypt_ctx *bc;
+	int err;
+
+	rc->bc = NULL;
+	rc->keyslot = -EINVAL;
+
+	if (!bio)
+		return 0;
+
+	bc = bio->bi_crypt_context;
+	if (!bc)
+		return 0;
+
+	err = rq_crypt_ctx_acquire_keyslot(bc, q->ksm, rc);
+	if (err)
+		pr_warn_once("Failed to acquire keyslot for %s (err=%d).\n",
+			     bio->bi_disk->disk_name, err);
+	return err;
+}
+
+/**
+ * blk_crypto_free_request - Uninitialize the rq_crypt_ctx of a request.
+ *
+ * @rq: The request whose rq_crypt_ctx to uninitialize.
+ *
+ * Completely uninitializes the rq_crypt_ctx of a request. If a keyslot has been
+ * programmed into some inline encryption hardware, that keyslot is released.
+ * The bio_crypt_ctx pointed to by the rq_crypt_ctx is also freed, if any.
+ */
+void blk_crypto_free_request(struct request *rq)
+{
+	struct rq_crypt_ctx *rc = &rq->rq_crypt_ctx;
+
+	rq_crypt_ctx_release_keyslot(rq->q->ksm, rc);
+	mempool_free(rc->bc, bio_crypt_ctx_pool);
+	rc->bc = NULL;
+}
+
+/**
+ * blk_crypto_bio_prep - Prepare bio for inline encryption
+ *
+ * @bio_ptr: pointer to original bio pointer
+ *
+ * Succeeds if the bio doesn't have inline encryption enabled or if the bio
+ * crypt context provided for the bio is supported by the underlying device's
+ * inline encryption hardware. Ends the bio with error otherwise.
+ *
+ * Return: 0 on success; nonzero on error (and bio_endio() will have been called
+ *	   so bio submission should abort).
+ */
+int blk_crypto_bio_prep(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	int err;
+
+	if (!bc)
+		return 0;
+
+	/*
+	 * If bio has no data, just pretend it didn't have an encryption
+	 * context.
+	 */
+	if (!bio_has_data(bio)) {
+		bio_crypt_free_ctx(bio);
+		return 0;
+	}
+
+	err = bio_crypt_check_alignment(bio);
+	if (err)
+		goto fail;
+
+	/* Success if device supports the encryption context */
+	if (blk_ksm_crypto_mode_supported(bio->bi_disk->queue->ksm, bc->bc_key))
+		return 0;
+
+fail:
+	bio->bi_status = BLK_STS_IOERR;
+	bio_endio(*bio_ptr);
+	return err;
+}
+
+/**
+ * blk_crypto_rq_bio_prep - Prepare a request when its first bio is inserted
+ *
+ * @rq: The request to prepare
+ * @bio: The first bio being inserted into the request
+ *
+ * Frees the bio crypt context in the request's old rq_crypt_ctx, if any, and
+ * moves the bio crypt context of the bio into the request's rq_crypt_ctx.
+ */
+void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
+{
+	mempool_free(rq->rq_crypt_ctx.bc, bio_crypt_ctx_pool);
+	rq->rq_crypt_ctx.bc = bio->bi_crypt_context;
+	bio->bi_crypt_context = NULL;
+}
+
+void blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
+{
+	dst->rq_crypt_ctx.bc = NULL;
+	dst->rq_crypt_ctx.keyslot = -EINVAL;
+
+	if (src->rq_crypt_ctx.keyslot < 0) {
+		/* src doesn't have any crypto info, so nothing to do */
+		return;
+	}
+
+	dst->rq_crypt_ctx.bc = src->rq_crypt_ctx.bc;
+}
+
+/**
+ * blk_crypto_insert_cloned_request - Prepare a cloned request to be inserted
+ *				      into a request queue.
+ * @q: the queue to submit the request
+ * @rq: the request being queued
+ *
+ * Return: 0 on success, nonzero on error.
+ */
+int blk_crypto_insert_cloned_request(struct request_queue *q,
+				     struct request *rq)
+{
+	int err;
+
+	if (!rq->bio)
+		return 0;
+
+	/*
+	 * Pretend that the bio had the encryption ctx before calling
+	 * blk_crypto_init_request
+	 */
+	rq->bio->bi_crypt_context = rq->rq_crypt_ctx.bc;
+	err = blk_crypto_init_request(rq, q, rq->bio);
+	/*
+	 * blk_crypto_init_request *always* clears the rq->rq_crypt_ctx to
+	 * defaults, so regardless of what err is, restore the rq->rq_crypt_ctx.
+	 */
+	blk_crypto_rq_bio_prep(rq, rq->bio);
+
+	return err;
+}
+
+/**
+ * blk_crypto_init_key() - Prepare a key for use with blk-crypto
+ * @blk_key: Pointer to the blk_crypto_key to initialize.
+ * @raw_key: Pointer to the raw key. Must be the correct length for the chosen
+ *	     @crypto_mode; see blk_crypto_modes[].
+ * @crypto_mode: identifier for the encryption algorithm to use
+ * @blk_crypto_dun_bytes: number of bytes that will be used to specify the DUN
+ *			  when this key is used
+ * @data_unit_size: the data unit size to use for en/decryption
+ *
+ * Return: 0 on success, -errno on failure.  The caller is responsible for
+ *	   zeroizing both blk_key and raw_key when done with them.
+ */
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
+			unsigned int blk_crypto_dun_bytes,
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
+	blk_key->crypto_mode = crypto_mode;
+	blk_key->dun_bytes = blk_crypto_dun_bytes;
+	blk_key->data_unit_size = data_unit_size;
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
+/**
+ * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
+ *			    it may have been programmed into
+ * @q: The request queue who's keyslot manager this key might have been
+ *     programmed into
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
+	if (q->ksm && blk_ksm_crypto_mode_supported(q->ksm, key))
+		return blk_ksm_evict_key(q->ksm, key);
+
+	return 0;
+}
diff --git a/block/blk-map.c b/block/blk-map.c
index b0790268ed9d..4484e37d316e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -41,6 +41,7 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
 		rq->biotail->bi_next = *bio;
 		rq->biotail = *bio;
 		rq->__data_len += (*bio)->bi_iter.bi_size;
+		bio_crypt_free_ctx(*bio);
 	}
 
 	return 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..a0c24b6e0eb3 100644
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
index a12b1763508d..6b437637d029 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 
@@ -316,6 +317,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
+#endif
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	rq->rq_crypt_ctx.bc = NULL;
+	rq->rq_crypt_ctx.keyslot = -EINVAL;
 #endif
 	/* tag was already set */
 	rq->extra_len = 0;
@@ -474,6 +479,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	const int sched_tag = rq->internal_tag;
 
+	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 	if (rq->tag != -1)
@@ -1968,6 +1974,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	unsigned int nr_segs;
 	blk_qc_t cookie;
 
+	if (blk_crypto_bio_prep(&bio))
+		return BLK_QC_T_NONE;
+
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(q, &bio, &nr_segs);
 
@@ -1998,6 +2007,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
+	if (blk_crypto_init_request(rq, q, bio)) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		bio_endio(bio);
+		blk_mq_end_request(rq, BLK_STS_RESOURCE);
+		return BLK_QC_T_NONE;
+	}
+
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
 	plug = blk_mq_plug(q, bio);
diff --git a/block/blk.h b/block/blk.h
index 0b8884353f6b..3929900fca02 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-crypto.h>
 #include <xen/xen.h>
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -117,6 +118,8 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
+
+	blk_crypto_rq_bio_prep(rq, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..c3aaed070124 100644
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
index b89f07ee2eff..e5b5ffa73619 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1304,6 +1304,8 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 
 	__bio_clone_fast(clone, bio);
 
+	bio_crypt_clone(clone, bio, GFP_NOIO);
+
 	if (bio_integrity(bio)) {
 		int r;
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index b8d54eca1c0d..f855895770f6 100644
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
@@ -42,4 +44,213 @@ struct blk_crypto_key {
 	u8 raw[BLK_CRYPTO_MAX_KEY_SIZE];
 };
 
+#define BLK_CRYPTO_MAX_IV_SIZE		32
+#define BLK_CRYPTO_DUN_ARRAY_SIZE	(BLK_CRYPTO_MAX_IV_SIZE/sizeof(u64))
+
+/**
+ * struct bio_crypt_ctx - an inline encryption context
+ * @bc_key: the key, algorithm, and data unit size to use
+ * @bc_dun: the data unit number (starting IV) to use
+ * @bc_keyslot: the keyslot that has been assigned for this key in @bc_ksm,
+ *		or -1 if no keyslot has been assigned yet.
+ * @bc_ksm: the keyslot manager into which the key has been programmed with
+ *	    @bc_keyslot, or NULL if this key hasn't yet been programmed.
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
+#ifdef CONFIG_BLOCK
+
+#include <linux/blk_types.h>
+
+struct request;
+struct request_queue;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+int bio_crypt_ctx_init(void);
+
+struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask);
+
+void bio_crypt_free_ctx(struct bio *bio);
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return bio->bi_crypt_context;
+}
+
+void bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
+
+static inline void bio_crypt_set_ctx(struct bio *bio,
+				     const struct blk_crypto_key *key,
+				     const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+				     gfp_t gfp_mask)
+{
+	struct bio_crypt_ctx *bc = bio_crypt_alloc_ctx(gfp_mask);
+
+	bc->bc_key = key;
+	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
+
+	bio->bi_crypt_context = bc;
+}
+
+static inline bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
+					       unsigned int bytes,
+					u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
+{
+	int i = 0;
+	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
+
+	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
+		if (bc->bc_dun[i] + inc != next_dun[i])
+			return false;
+		inc = ((bc->bc_dun[i] + inc)  < inc);
+		i++;
+	}
+
+	return true;
+}
+
+static inline void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+					   unsigned int inc)
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
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+	if (!bc)
+		return;
+
+	bio_crypt_dun_increment(bc->bc_dun,
+				bytes >> bc->bc_key->data_unit_size_bits);
+}
+
+bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
+
+bool bio_crypt_ctx_front_mergeable(struct request *req, struct bio *bio);
+
+bool bio_crypt_ctx_back_mergeable(struct request *req, struct bio *bio);
+
+bool bio_crypt_ctx_merge_rq(struct request *req, struct request *next);
+
+void blk_crypto_bio_back_merge(struct request *req, struct bio *bio);
+
+void blk_crypto_bio_front_merge(struct request *req, struct bio *bio);
+
+void blk_crypto_free_request(struct request *rq);
+
+int blk_crypto_init_request(struct request *rq, struct request_queue *q,
+			    struct bio *bio);
+
+int blk_crypto_bio_prep(struct bio **bio_ptr);
+
+void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio);
+
+void blk_crypto_rq_prep_clone(struct request *dst, struct request *src);
+
+int blk_crypto_insert_cloned_request(struct request_queue *q,
+				     struct request *rq);
+
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
+			unsigned int blk_crypto_dun_bytes,
+			unsigned int data_unit_size);
+
+int blk_crypto_evict_key(struct request_queue *q,
+			 const struct blk_crypto_key *key);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline int bio_crypt_ctx_init(void)
+{
+	return 0;
+}
+
+static inline bool bio_has_crypt_ctx(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
+				   gfp_t gfp_mask) { }
+
+static inline void bio_crypt_free_ctx(struct bio *bio) { }
+
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes) { }
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
+static inline void blk_crypto_bio_back_merge(struct request *req,
+					     struct bio *bio) { }
+
+static inline void blk_crypto_bio_front_merge(struct request *req,
+					      struct bio *bio) { }
+
+static inline void blk_crypto_free_request(struct request *rq) { }
+
+static inline int blk_crypto_init_request(struct request *rq,
+					  struct request_queue *q,
+					  struct bio *bio)
+{
+	return 0;
+}
+
+static inline int blk_crypto_bio_prep(struct bio **bio_ptr)
+{
+	return 0;
+}
+
+static inline void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
+{ }
+
+static inline void blk_crypto_rq_prep_clone(struct request *dst,
+					    struct request *src) { }
+
+static inline int blk_crypto_insert_cloned_request(struct request_queue *q,
+						   struct request *rq)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#endif /* CONFIG_BLOCK */
+
 #endif /* __LINUX_BLK_CRYPTO_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..1996689c51d3 100644
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
index 8881b25ef58b..a90332299f29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/blk-crypto.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -124,6 +125,11 @@ enum mq_rq_state {
 	MQ_RQ_COMPLETE		= 2,
 };
 
+struct rq_crypt_ctx {
+	struct bio_crypt_ctx *bc;
+	int keyslot;
+};
+
 /*
  * Try to put the fields that are referenced together in the same cacheline.
  *
@@ -224,6 +230,10 @@ struct request {
 	unsigned short nr_integrity_segments;
 #endif
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct rq_crypt_ctx rq_crypt_ctx;
+#endif
+
 	unsigned short write_hint;
 	unsigned short ioprio;
 
-- 
2.25.0.265.gbab2e86ba0-goog

