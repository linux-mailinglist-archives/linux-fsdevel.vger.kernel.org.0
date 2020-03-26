Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E56193677
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 04:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCZDIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 23:08:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40124 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgCZDIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:08:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id y84so4014729pfb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 20:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XWE1MRwP0T7BijeUj5H99pp9GVBAq9lD++w1PBB/TqY=;
        b=PwJtB8B60MKnN2siSa47eALSgq3mBgL4Jl/icl4JyAdiTkDP+6oC8VTrhV2pEsDN7A
         BiWiRRTSTNmS2x+UptgQL4Pw7hBkYI7JaVRpspV9PZ32Bc2wv4OKGoirdxtiCSg0eOMn
         atd9y/BEw/4q1E8E3xKwdolmsoO97VJVAavsOLEvu4SQj7CeEQvcFpr8ZvwukWcqIWwv
         Ck50qZLQ2GbN34Eoru1Lp9Dlq5crDCxslpYnawFejxsXB8lOF+fswzlTJ3XajQonBDuM
         3CDoTfSlBiYLG4/RrAbwTHyZDcjFZqhSvGH+4ri+w3nkPnsTTyc6nNaoYkgi6jJfl+LL
         jxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XWE1MRwP0T7BijeUj5H99pp9GVBAq9lD++w1PBB/TqY=;
        b=OBamivkNpdWl0+fIMgvctxTMyfhFWBT0l5/TPWK76d8RCGqwKvsp6+sniahzSRSAVM
         2OyvMz4vauOWBNKLLxSoMaa3MWfNjZAH1hyx9cx2uVT0kMM2Gx7Qlbicz36n8BYA5qLt
         YrWYwLSMnza1Ym2XfOmd08UqyouPR6QwhjZYPSsS5Wh1fIJmKTHg5Qje1Iblu54BbC34
         cg0wuMoBsO5koGEd1o5YC9d5o0CSM1rxmawdj9+hvNzWg7mlYUvj8q9TK9ODHOOhMb57
         JijC+KZSHH2zzeAEU+MKHwNPqG3J+i3c7+wXIGCuCKgYthU/eUAVZjmoLUf6mciOHncj
         igiw==
X-Gm-Message-State: ANhLgQ3YUIg+1iWm5T7X6BqX6Ftl7tUAkqYfYNJET13VcgzKoUd7//Xb
        ceaJxRUMF8YgP7gnM3idyHbQsPfsj04=
X-Google-Smtp-Source: ADFU+vuec1XQr7sd9CF+vr9OY1VB21wJ7HG7IuhruDfZUWKPgZbi3H3YqTCYPQhkqJfRrOLYh3jGSDXu5M4=
X-Received: by 2002:a65:5884:: with SMTP id d4mr3000925pgu.170.1585192099210;
 Wed, 25 Mar 2020 20:08:19 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:06:55 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-5-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v9 04/11] block: blk-crypto-fallback for Inline Encryption
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

Blk-crypto delegates crypto operations to inline encryption hardware when
available. The separately configurable blk-crypto-fallback contains a
software fallback to the kernel crypto API - when enabled, blk-crypto
will use this fallback for en/decryption when inline encryption hardware is
not available. This lets upper layers not have to worry about whether or
not the underlying device has support for inline encryption before
deciding to specify an encryption context for a bio, and also allows for
testing without actual inline encryption hardware. For more details, refer
to Documentation/block/inline-encryption.rst.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 195 +++++++
 block/Kconfig                             |  10 +
 block/Makefile                            |   1 +
 block/blk-crypto-fallback.c               | 666 ++++++++++++++++++++++
 block/blk-crypto-internal.h               |  25 +
 block/blk-crypto.c                        |  46 +-
 include/linux/blk-crypto.h                |  17 +-
 8 files changed, 947 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/blk-crypto-fallback.c

diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 3fa7a52fafa46..026addfc69bc9 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -14,6 +14,7 @@ Block
    cmdline-partition
    data-integrity
    deadline-iosched
+   inline-encryption
    ioprio
    kyber-iosched
    null_blk
diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
new file mode 100644
index 0000000000000..3fa475799ecd1
--- /dev/null
+++ b/Documentation/block/inline-encryption.rst
@@ -0,0 +1,195 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Inline Encryption
+=================
+
+Background
+==========
+
+Inline encryption hardware sits logically between memory and the disk, and can
+en/decrypt data as it goes in/out of the disk. Inline encryption hardware has a
+fixed number of "keyslots" - slots into which encryption contexts (i.e. the
+encryption key, encryption algorithm, data unit size) can be programmed by the
+kernel at any time. Each request sent to the disk can be tagged with the index
+of a keyslot (and also a data unit number to act as an encryption tweak), and
+the inline encryption hardware will en/decrypt the data in the request with the
+encryption context programmed into that keyslot. This is very different from
+full disk encryption solutions like self encrypting drives/TCG OPAL/ATA
+Security standards, since with inline encryption, any block on disk could be
+encrypted with any encryption context the kernel chooses.
+
+
+Objective
+=========
+
+We want to support inline encryption (IE) in the kernel.
+To allow for testing, we also want a crypto API fallback when actual
+IE hardware is absent. We also want IE to work with layered devices
+like dm and loopback (i.e. we want to be able to use the IE hardware
+of the underlying devices if present, or else fall back to crypto API
+en/decryption).
+
+
+Constraints and notes
+=====================
+
+- IE hardware has a limited number of "keyslots" that can be programmed
+  with an encryption context (key, algorithm, data unit size, etc.) at any time.
+  One can specify a keyslot in a data request made to the device, and the
+  device will en/decrypt the data using the encryption context programmed into
+  that specified keyslot. When possible, we want to make multiple requests with
+  the same encryption context share the same keyslot.
+
+- We need a way for upper layers like filesystems to specify an encryption
+  context to use for en/decrypting a struct bio, and a device driver (like UFS)
+  needs to be able to use that encryption context when it processes the bio.
+
+- We need a way for device drivers to expose their capabilities in a unified
+  way to the upper layers.
+
+
+Design
+======
+
+We add a :c:type:`struct bio_crypt_ctx` to :c:type:`struct bio` that can
+represent an encryption context, because we need to be able to pass this
+encryption context from the FS layer to the device driver to act upon.
+
+While IE hardware works on the notion of keyslots, the FS layer has no
+knowledge of keyslots - it simply wants to specify an encryption context to
+use while en/decrypting a bio.
+
+We introduce a keyslot manager (KSM) that handles the translation from
+encryption contexts specified by the FS to keyslots on the IE hardware.
+This KSM also serves as the way IE hardware can expose its capabilities to
+upper layers. The generic mode of operation is: each device driver that wants
+to support IE will construct a KSM and set it up in its struct request_queue.
+Upper layers that want to use IE on this device can then use this KSM in
+the device's struct request_queue to translate an encryption context into
+a keyslot. The presence of the KSM in the request queue shall be used to mean
+that the device supports IE.
+
+On the device driver end of the interface, the device driver needs to tell the
+KSM how to actually manipulate the IE hardware in the device to do things like
+programming the crypto key into the IE hardware into a particular keyslot. All
+this is achieved through the :c:type:`struct keyslot_mgmt_ll_ops` that the
+device driver passes to the KSM when creating it.
+
+It uses refcounts to track which keyslots are idle (either they have no
+encryption context programmed, or there are no in-flight struct bios
+referencing that keyslot). When a new encryption context needs a keyslot, it
+tries to find a keyslot that has already been programmed with the same
+encryption context, and if there is no such keyslot, it evicts the least
+recently used idle keyslot and programs the new encryption context into that
+one. If no idle keyslots are available, then the caller will sleep until there
+is at least one.
+
+
+blk-mq changes, other block layer changes and blk-crypto-fallback
+=================================================================
+
+We add a pointer to a ``bi_crypt_context`` and ``keyslot`` to
+:c:type:`struct request`. These will be referred to as the ``crypto fields``
+for the request. This ``keyslot`` is the keyslot into which the
+``bi_crypt_context`` has been programmed into in the keyslot manager of the
+``request_queue`` that this request is being sent to.
+
+We introduce ``block/blk-crypto-fallback.c``, which allows upper layers to remain
+blissfully unaware of whether or not real inline encryption hardware is present
+underneath.
+
+When a bio is submitted with a target ``request_queue`` that doesn't support the
+encryption context specified with the bio, the block layer will en/decrypt the
+bio with the blk-crypto-fallback.
+
+If the bio is a ``WRITE`` bio, a bounce bio is allocated, and the data in the bio
+is encrypted stored in the bounce bio - blk-mq will then proceed to process the
+bounce bio as if it were not encrypted at all (except when blk-integrity is
+concerned). ``blk-crypto-fallback`` sets the bounce bio's ``bi_end_io`` to an
+internal function that cleans up the bounce bio and ends the original bio.
+
+If the bio is a ``READ`` bio, the bio's ``bi_end_io`` (and also ``bi_private``)
+is saved and overwritten by ``blk-crypto-fallback`` to
+``bio_crypto_fallback_decrypt_bio``.  The bio's ``bi_crypt_context`` is also
+overwritten with ``NULL``, so that to the rest of the stack, the bio looks
+as if it was a regular bio that never had an encryption context specified.
+``bio_crypto_fallback_decrypt_bio`` will decrypt the bio, restore the original
+``bi_end_io`` (and also ``bi_private``) and end the bio again.
+
+If we reach a point when a :c:type:`struct request` needs to be allocated for a
+bio that still has an encryption context, that means that the bio was not
+handled by the ``blk-crypto-fallback``, which means that the underlying inline
+encryption hardware claimed to support the encryption context specified with the
+bio. So in this situation, blk-mq tries to program the encryption context into
+the ``request_queue``'s keyslot_manager, and obtain a keyslot, which it stores
+in its newly added ``keyslot`` field. This keyslot is released when the request
+is completed.
+
+When a bio is added to a request, the request takes over ownership of the
+``bi_crypt_context`` of the bio - in particular, the request keeps the
+``bi_crypt_context`` of the first bio in its bio-list, and frees the rest
+(blk-mq needs to be careful to maintain this invariant during bio and request
+merges).
+
+To make it possible for inline encryption to work with request queue based
+layered devices, when a request is cloned, its ``crypto fields`` are cloned as
+well. When the cloned request is submitted, blk-mq programs the
+``bi_crypt_context`` of the request into the clone's request_queue's keyslot
+manager, and stores the returned keyslot in the clone's ``keyslot``.
+
+
+Layered Devices
+===============
+
+Request queue based layered devices like dm-rq that wish to support IE need to
+create their own keyslot manager for their request queue, and expose whatever
+functionality they choose. When a layered device wants to pass a clone of that
+request to another ``request_queue``, blk-crypto will initialize and prepare the
+clone as necessary - see ``blk_crypto_rq_prep_clone`` and
+``blk_crypto_insert_cloned_request`` in ``blk-crypto.c``.
+
+
+Future Optimizations for layered devices
+========================================
+
+Creating a keyslot manager for a layered device uses up memory for each
+keyslot, and in general, a layered device merely passes the request on to a
+"child" device, so the keyslots in the layered device itself are completely
+unused, and don't need any refcounting or keyslot programming. We can instead
+define a new type of KSM; the "passthrough KSM", that layered devices can use
+to advertise an unlimited number of keyslots, and support for any encryption
+algorithms they choose, while not actually using any memory for each keyslot.
+Another use case for the "passthrough KSM" is for IE devices that do not have a
+limited number of keyslots.
+
+
+Interaction between inline encryption and blk integrity
+=======================================================
+
+At the time of this patch, there is no real hardware that supports both these
+features. However, these features do interact with each other, and it's not
+completely trivial to make them both work together properly. In particular,
+when a WRITE bio wants to use inline encryption on a device that supports both
+features, the bio will have an encryption context specified, after which
+its integrity information is calculated (using the plaintext data, since
+the encryption will happen while data is being written), and the data and
+integrity info is sent to the device. Obviously, the integrity info must be
+verified before the data is encrypted. After the data is encrypted, the device
+must not store the integrity info that it received with the plaintext data
+since that might reveal information about the plaintext data. As such, it must
+re-generate the integrity info from the ciphertext data and store that on disk
+instead. Another issue with storing the integrity info of the plaintext data is
+that it changes the on disk format depending on whether hardware inline
+encryption support is present or the kernel crypto API fallback is used (since
+if the fallback is used, the device will receive the integrity info of the
+ciphertext, not that of the plaintext).
+
+Because there isn't any real hardware yet, it seems prudent to assume that
+hardware implementations might not implement both features together correctly,
+and disallow the combination for now. Whenever a device supports integrity, the
+kernel will pretend that the device does not support hardware inline encryption
+(by essentially setting the keyslot manager in the request_queue of the device
+to NULL). When the crypto API fallback is enabled, this means that all bios with
+and encryption context will use the fallback, and IO will complete as usual.
+When the fallback is disabled, a bio with an encryption context will be failed.
diff --git a/block/Kconfig b/block/Kconfig
index c04a1d5008421..0af3876237748 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -192,6 +192,16 @@ config BLK_INLINE_ENCRYPTION
 	  block layer handle encryption, so users can take
 	  advantage of inline encryption hardware if present.
 
+config BLK_INLINE_ENCRYPTION_FALLBACK
+	bool "Enable crypto API fallback for blk-crypto"
+	depends on BLK_INLINE_ENCRYPTION
+	select CRYPTO
+	select CRYPTO_SKCIPHER
+	help
+	  Enabling this lets the block layer handle inline encryption
+	  by falling back to the kernel crypto API when inline
+	  encryption hardware is not present.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 82f42ca3f7695..9464fb6ae423a 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
new file mode 100644
index 0000000000000..928118ba2da0d
--- /dev/null
+++ b/block/blk-crypto-fallback.c
@@ -0,0 +1,666 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Refer to Documentation/block/inline-encryption.rst for detailed explanation.
+ */
+
+#define pr_fmt(fmt) "blk-crypto-fallback: " fmt
+
+#include <crypto/skcipher.h>
+#include <linux/blk-cgroup.h>
+#include <linux/blk-crypto.h>
+#include <linux/blkdev.h>
+#include <linux/crypto.h>
+#include <linux/keyslot-manager.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/random.h>
+
+#include "blk-crypto-internal.h"
+
+static unsigned int num_prealloc_bounce_pg = 32;
+module_param(num_prealloc_bounce_pg, uint, 0);
+MODULE_PARM_DESC(num_prealloc_bounce_pg,
+		 "Number of preallocated bounce pages for the blk-crypto crypto API fallback");
+
+static unsigned int blk_crypto_num_keyslots = 100;
+module_param_named(num_keyslots, blk_crypto_num_keyslots, uint, 0);
+MODULE_PARM_DESC(num_keyslots,
+		 "Number of keyslots for the blk-crypto crypto API fallback");
+
+static unsigned int num_prealloc_fallback_crypt_ctxs = 128;
+module_param(num_prealloc_fallback_crypt_ctxs, uint, 0);
+MODULE_PARM_DESC(num_prealloc_crypt_fallback_ctxs,
+		 "Number of preallocated bio fallback crypto contexts for blk-crypto to use during crypto API fallback");
+
+struct bio_fallback_crypt_ctx {
+	struct bio_crypt_ctx crypt_ctx;
+	/*
+	 * Copy of the bvec_iter when this bio was submitted.
+	 * We only want to en/decrypt the part of the bio as described by the
+	 * bvec_iter upon submission because bio might be split before being
+	 * resubmitted
+	 */
+	struct bvec_iter crypt_iter;
+	u64 fallback_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	union {
+		struct {
+			struct work_struct work;
+			struct bio *bio;
+		};
+		struct {
+			void *bi_private_orig;
+			bio_end_io_t *bi_end_io_orig;
+		};
+	};
+};
+
+static struct kmem_cache *bio_fallback_crypt_ctx_cache;
+static mempool_t *bio_fallback_crypt_ctx_pool;
+
+/*
+ * Allocating a crypto tfm during I/O can deadlock, so we have to preallocate
+ * all of a mode's tfms when that mode starts being used. Since each mode may
+ * need all the keyslots at some point, each mode needs its own tfm for each
+ * keyslot; thus, a keyslot may contain tfms for multiple modes.  However, to
+ * match the behavior of real inline encryption hardware (which only supports a
+ * single encryption context per keyslot), we only allow one tfm per keyslot to
+ * be used at a time - the rest of the unused tfms have their keys cleared.
+ */
+static DEFINE_MUTEX(tfms_init_lock);
+static bool tfms_inited[BLK_ENCRYPTION_MODE_MAX];
+
+static struct blk_crypto_keyslot {
+	enum blk_crypto_mode_num crypto_mode;
+	struct crypto_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
+} *blk_crypto_keyslots;
+
+static struct blk_keyslot_manager blk_crypto_ksm;
+static struct workqueue_struct *blk_crypto_wq;
+static mempool_t *blk_crypto_bounce_page_pool;
+
+/*
+ * This is the key we set when evicting a keyslot. This *should* be the all 0's
+ * key, but AES-XTS rejects that key, so we use some random bytes instead.
+ */
+static u8 blank_key[BLK_CRYPTO_MAX_KEY_SIZE];
+
+static void blk_crypto_evict_keyslot(unsigned int slot)
+{
+	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
+	enum blk_crypto_mode_num crypto_mode = slotp->crypto_mode;
+	int err;
+
+	WARN_ON(slotp->crypto_mode == BLK_ENCRYPTION_MODE_INVALID);
+
+	/* Clear the key in the skcipher */
+	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], blank_key,
+				     blk_crypto_modes[crypto_mode].keysize);
+	WARN_ON(err);
+	slotp->crypto_mode = BLK_ENCRYPTION_MODE_INVALID;
+}
+
+static int blk_crypto_keyslot_program(struct blk_keyslot_manager *ksm,
+				      const struct blk_crypto_key *key,
+				      unsigned int slot)
+{
+	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
+	const enum blk_crypto_mode_num crypto_mode = key->crypto_mode;
+	int err;
+
+	if (crypto_mode != slotp->crypto_mode &&
+	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID)
+		blk_crypto_evict_keyslot(slot);
+
+	slotp->crypto_mode = crypto_mode;
+	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], key->raw,
+				     key->size);
+	if (err) {
+		blk_crypto_evict_keyslot(slot);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int blk_crypto_keyslot_evict(struct blk_keyslot_manager *ksm,
+				    const struct blk_crypto_key *key,
+				    unsigned int slot)
+{
+	blk_crypto_evict_keyslot(slot);
+	return 0;
+}
+
+/*
+ * The crypto API fallback KSM ops - only used for a bio when it specifies a
+ * blk_crypto_key that was not supported by the device's inline encryption
+ * hardware.
+ */
+static const struct blk_ksm_ll_ops blk_crypto_ksm_ll_ops = {
+	.keyslot_program	= blk_crypto_keyslot_program,
+	.keyslot_evict		= blk_crypto_keyslot_evict,
+};
+
+static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
+{
+	struct bio *src_bio = enc_bio->bi_private;
+	int i;
+
+	for (i = 0; i < enc_bio->bi_vcnt; i++)
+		mempool_free(enc_bio->bi_io_vec[i].bv_page,
+			     blk_crypto_bounce_page_pool);
+
+	src_bio->bi_status = enc_bio->bi_status;
+
+	bio_put(enc_bio);
+	bio_endio(src_bio);
+}
+
+static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
+	if (!bio)
+		return NULL;
+	bio->bi_disk		= bio_src->bi_disk;
+	bio->bi_opf		= bio_src->bi_opf;
+	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
+	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+
+	bio_for_each_segment(bv, bio_src, iter)
+		bio->bi_io_vec[bio->bi_vcnt++] = bv;
+
+	bio_clone_blkg_association(bio, bio_src);
+	blkcg_bio_issue_init(bio);
+
+	return bio;
+}
+
+static bool blk_crypto_alloc_cipher_req(struct bio *src_bio,
+					struct blk_ksm_keyslot *slot,
+					struct skcipher_request **ciph_req_ret,
+					struct crypto_wait *wait)
+{
+	struct skcipher_request *ciph_req;
+	const struct blk_crypto_keyslot *slotp;
+	int keyslot_idx = blk_ksm_get_slot_idx(slot);
+
+	slotp = &blk_crypto_keyslots[keyslot_idx];
+	ciph_req = skcipher_request_alloc(slotp->tfms[slotp->crypto_mode],
+					  GFP_NOIO);
+	if (!ciph_req) {
+		src_bio->bi_status = BLK_STS_RESOURCE;
+		return false;
+	}
+
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, wait);
+	*ciph_req_ret = ciph_req;
+
+	return true;
+}
+
+static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+	unsigned int i = 0;
+	unsigned int num_sectors = 0;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+
+	bio_for_each_segment(bv, bio, iter) {
+		num_sectors += bv.bv_len >> SECTOR_SHIFT;
+		if (++i == BIO_MAX_PAGES)
+			break;
+	}
+	if (num_sectors < bio_sectors(bio)) {
+		struct bio *split_bio;
+
+		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
+		if (!split_bio) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			return false;
+		}
+		bio_chain(split_bio, bio);
+		generic_make_request(bio);
+		*bio_ptr = split_bio;
+	}
+
+	return true;
+}
+
+union blk_crypto_iv {
+	__le64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	u8 bytes[BLK_CRYPTO_MAX_IV_SIZE];
+};
+
+static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+				 union blk_crypto_iv *iv)
+{
+	int i;
+
+	for (i = 0; i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++)
+		iv->dun[i] = cpu_to_le64(dun[i]);
+}
+
+/*
+ * The crypto API fallback's encryption routine.
+ * Allocate a bounce bio for encryption, encrypt the input bio using crypto API,
+ * and replace *bio_ptr with the bounce bio. May split input bio if it's too
+ * large. Returns true on success. Returns false and sets bio->bi_status on
+ * error.
+ */
+static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
+{
+	struct bio *src_bio, *enc_bio;
+	struct bio_crypt_ctx *bc;
+	struct blk_ksm_keyslot *slot;
+	int data_unit_size;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	struct scatterlist src, dst;
+	union blk_crypto_iv iv;
+	unsigned int i, j;
+	bool ret = false;
+	blk_status_t blk_st;
+
+	/* Split the bio if it's too big for single page bvec */
+	if (!blk_crypto_split_bio_if_needed(bio_ptr))
+		return false;
+
+	src_bio = *bio_ptr;
+	bc = src_bio->bi_crypt_context;
+	data_unit_size = bc->bc_key->data_unit_size;
+
+	/* Allocate bounce bio for encryption */
+	enc_bio = blk_crypto_clone_bio(src_bio);
+	if (!enc_bio) {
+		src_bio->bi_status = BLK_STS_RESOURCE;
+		return false;
+	}
+
+	/*
+	 * Use the crypto API fallback keyslot manager to get a crypto_skcipher
+	 * for the algorithm and key specified for this bio.
+	 */
+	blk_st = blk_ksm_get_slot_for_key(&blk_crypto_ksm, bc->bc_key, &slot);
+	if (blk_st != BLK_STS_OK) {
+		src_bio->bi_status = blk_st;
+		goto out_put_enc_bio;
+	}
+
+	/* and then allocate an skcipher_request for it */
+	if (!blk_crypto_alloc_cipher_req(src_bio, slot, &ciph_req, &wait))
+		goto out_release_keyslot;
+
+	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
+	sg_init_table(&src, 1);
+	sg_init_table(&dst, 1);
+
+	skcipher_request_set_crypt(ciph_req, &src, &dst, data_unit_size,
+				   iv.bytes);
+
+	/* Encrypt each page in the bounce bio */
+	for (i = 0; i < enc_bio->bi_vcnt; i++) {
+		struct bio_vec *enc_bvec = &enc_bio->bi_io_vec[i];
+		struct page *plaintext_page = enc_bvec->bv_page;
+		struct page *ciphertext_page =
+			mempool_alloc(blk_crypto_bounce_page_pool, GFP_NOIO);
+
+		enc_bvec->bv_page = ciphertext_page;
+
+		if (!ciphertext_page) {
+			src_bio->bi_status = BLK_STS_RESOURCE;
+			goto out_free_bounce_pages;
+		}
+
+		sg_set_page(&src, plaintext_page, data_unit_size,
+			    enc_bvec->bv_offset);
+		sg_set_page(&dst, ciphertext_page, data_unit_size,
+			    enc_bvec->bv_offset);
+
+		/* Encrypt each data unit in this page */
+		for (j = 0; j < enc_bvec->bv_len; j += data_unit_size) {
+			blk_crypto_dun_to_iv(curr_dun, &iv);
+			if (crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
+					    &wait)) {
+				i++;
+				src_bio->bi_status = BLK_STS_IOERR;
+				goto out_free_bounce_pages;
+			}
+			bio_crypt_dun_increment(curr_dun, 1);
+			src.offset += data_unit_size;
+			dst.offset += data_unit_size;
+		}
+	}
+
+	enc_bio->bi_private = src_bio;
+	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
+	*bio_ptr = enc_bio;
+	ret = true;
+
+	enc_bio = NULL;
+	goto out_free_ciph_req;
+
+out_free_bounce_pages:
+	while (i > 0)
+		mempool_free(enc_bio->bi_io_vec[--i].bv_page,
+			     blk_crypto_bounce_page_pool);
+out_free_ciph_req:
+	skcipher_request_free(ciph_req);
+out_release_keyslot:
+	blk_ksm_put_slot(slot);
+out_put_enc_bio:
+	if (enc_bio)
+		bio_put(enc_bio);
+
+	return ret;
+}
+
+/*
+ * The crypto API fallback's main decryption routine.
+ * Decrypts input bio in place, and calls bio_endio on the bio.
+ */
+static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
+{
+	struct bio_fallback_crypt_ctx *f_ctx =
+		container_of(work, struct bio_fallback_crypt_ctx, work);
+	struct bio *bio = f_ctx->bio;
+	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
+	struct blk_ksm_keyslot *slot;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	union blk_crypto_iv iv;
+	struct scatterlist sg;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	const int data_unit_size = bc->bc_key->data_unit_size;
+	unsigned int i;
+	blk_status_t blk_st;
+
+	/*
+	 * Use the crypto API fallback keyslot manager to get a crypto_skcipher
+	 * for the algorithm and key specified for this bio.
+	 */
+	blk_st = blk_ksm_get_slot_for_key(&blk_crypto_ksm, bc->bc_key, &slot);
+	if (blk_st != BLK_STS_OK) {
+		bio->bi_status = blk_st;
+		goto out_no_keyslot;
+	}
+
+	/* and then allocate an skcipher_request for it */
+	if (!blk_crypto_alloc_cipher_req(bio, slot, &ciph_req, &wait))
+		goto out;
+
+	memcpy(curr_dun, f_ctx->fallback_dun, sizeof(curr_dun));
+	sg_init_table(&sg, 1);
+	skcipher_request_set_crypt(ciph_req, &sg, &sg, data_unit_size,
+				   iv.bytes);
+
+	/* Decrypt each segment in the bio */
+	__bio_for_each_segment(bv, bio, iter, f_ctx->crypt_iter) {
+		struct page *page = bv.bv_page;
+
+		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
+
+		/* Decrypt each data unit in the segment */
+		for (i = 0; i < bv.bv_len; i += data_unit_size) {
+			blk_crypto_dun_to_iv(curr_dun, &iv);
+			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
+					    &wait)) {
+				bio->bi_status = BLK_STS_IOERR;
+				goto out;
+			}
+			bio_crypt_dun_increment(curr_dun, 1);
+			sg.offset += data_unit_size;
+		}
+	}
+
+out:
+	skcipher_request_free(ciph_req);
+	blk_ksm_put_slot(slot);
+out_no_keyslot:
+	mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
+	bio_endio(bio);
+}
+
+/**
+ * blk_crypto_fallback_decrypt_endio - clean up bio w.r.t fallback decryption
+ *
+ * @bio: the bio to clean up.
+ *
+ * Restore bi_private and bi_end_io, and queue the bio for decryption into a
+ * workqueue, since this function will be called from an atomic context.
+ */
+static void blk_crypto_fallback_decrypt_endio(struct bio *bio)
+{
+	struct bio_fallback_crypt_ctx *f_ctx = bio->bi_private;
+
+	bio->bi_private = f_ctx->bi_private_orig;
+	bio->bi_end_io = f_ctx->bi_end_io_orig;
+
+	/* If there was an IO error, don't queue for decrypt. */
+	if (bio->bi_status) {
+		mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
+		bio_endio(bio);
+		return;
+	}
+
+	INIT_WORK(&f_ctx->work, blk_crypto_fallback_decrypt_bio);
+	f_ctx->bio = bio;
+	queue_work(blk_crypto_wq, &f_ctx->work);
+}
+
+/**
+ * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decryption
+ *
+ * @bio_ptr: pointer to the bio to prepare
+ *
+ * If bio is doing a WRITE operation, we split the bio into two parts, resubmit
+ * the second part. Allocates a bounce bio for the first part, encrypts it, and
+ * update bio_ptr to point to the bounce bio.
+ *
+ * For a READ operation, we mark the bio for decryption by using bi_private and
+ * bi_end_io.
+ *
+ * In either case, this function will make the bio look like a regular bio (i.e.
+ * as if no encryption context was ever specified) for the purposes of the rest
+ * of the stack except for blk-integrity (blk-integrity and blk-crypto are not
+ * currently supported together).
+ *
+ * Returns true on success. Sets bio->bi_status and returns false on error.
+ */
+bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	struct bio_fallback_crypt_ctx *f_ctx;
+
+	if (!tfms_inited[bc->bc_key->crypto_mode]) {
+		bio->bi_status = BLK_STS_IOERR;
+		return false;
+	}
+
+	if (!blk_ksm_crypto_key_supported(&blk_crypto_ksm, bc->bc_key)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		return false;
+	}
+
+	if (bio_data_dir(bio) == WRITE)
+		return blk_crypto_fallback_encrypt_bio(bio_ptr);
+
+	/*
+	 * bio READ case: Set up a f_ctx in the bio's bi_private and set the
+	 * bi_end_io appropriately to trigger decryption when the bio is ended.
+	 */
+	f_ctx = mempool_alloc(bio_fallback_crypt_ctx_pool, GFP_NOIO);
+	f_ctx->crypt_ctx = *bc;
+	memcpy(f_ctx->fallback_dun, bc->bc_dun, sizeof(f_ctx->fallback_dun));
+	f_ctx->crypt_iter = bio->bi_iter;
+	f_ctx->bi_private_orig = bio->bi_private;
+	f_ctx->bi_end_io_orig = bio->bi_end_io;
+	bio->bi_private = (void *)f_ctx;
+	bio->bi_end_io = blk_crypto_fallback_decrypt_endio;
+	bio_crypt_free_ctx(bio);
+
+	return true;
+}
+
+int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
+{
+	return blk_ksm_evict_key(&blk_crypto_ksm, key);
+}
+
+static bool blk_crypto_fallback_inited;
+static int blk_crypto_fallback_init(void)
+{
+	int i;
+	int err = -ENOMEM;
+
+	if (blk_crypto_fallback_inited)
+		return 0;
+
+	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
+
+	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
+	if (err)
+		goto out;
+	err = -ENOMEM;
+
+	blk_crypto_ksm.ksm_ll_ops = blk_crypto_ksm_ll_ops;
+	blk_crypto_ksm.max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
+
+	/* All blk-crypto modes have a crypto API fallback. */
+	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
+		blk_crypto_ksm.crypto_modes_supported[i] = 0xFFFFFFFF;
+	blk_crypto_ksm.crypto_modes_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
+
+	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
+					WQ_UNBOUND | WQ_HIGHPRI |
+					WQ_MEM_RECLAIM, num_online_cpus());
+	if (!blk_crypto_wq)
+		goto fail_free_ksm;
+
+	blk_crypto_keyslots = kcalloc(blk_crypto_num_keyslots,
+				      sizeof(blk_crypto_keyslots[0]),
+				      GFP_KERNEL);
+	if (!blk_crypto_keyslots)
+		goto fail_free_wq;
+
+	blk_crypto_bounce_page_pool =
+		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
+	if (!blk_crypto_bounce_page_pool)
+		goto fail_free_keyslots;
+
+	bio_fallback_crypt_ctx_cache = KMEM_CACHE(bio_fallback_crypt_ctx, 0);
+	if (!bio_fallback_crypt_ctx_cache)
+		goto fail_free_bounce_page_pool;
+
+	bio_fallback_crypt_ctx_pool =
+		mempool_create_slab_pool(num_prealloc_fallback_crypt_ctxs,
+					 bio_fallback_crypt_ctx_cache);
+	if (!bio_fallback_crypt_ctx_pool)
+		goto fail_free_crypt_ctx_cache;
+
+	blk_crypto_fallback_inited = true;
+
+	return 0;
+fail_free_crypt_ctx_cache:
+	kmem_cache_destroy(bio_fallback_crypt_ctx_cache);
+fail_free_bounce_page_pool:
+	mempool_destroy(blk_crypto_bounce_page_pool);
+fail_free_keyslots:
+	kfree(blk_crypto_keyslots);
+fail_free_wq:
+	destroy_workqueue(blk_crypto_wq);
+fail_free_ksm:
+	blk_ksm_destroy(&blk_crypto_ksm);
+out:
+	return err;
+}
+
+/**
+ * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
+ * @key: A key to use on the device
+ * @q: the request queue for the device
+ *
+ * Upper layers must call this function to ensure that the crypto API fallback
+ * has transforms for the algorithm/data_unit_size/dun_bytes combo specified by
+ * the key, if it becomes necessary.
+ *
+ * Return: 0 on success and -err on error.
+ */
+int blk_crypto_start_using_key(struct blk_crypto_key *key,
+			       struct request_queue *q)
+{
+	enum blk_crypto_mode_num mode_num = key->crypto_mode;
+	struct blk_crypto_keyslot *slotp;
+	unsigned int i;
+	int err = 0;
+
+	/*
+	 * Fast path
+	 * Ensure that updates to blk_crypto_keyslots[i].tfms[mode_num]
+	 * for each i are visible before we try to access them.
+	 */
+	if (likely(smp_load_acquire(&tfms_inited[mode_num])))
+		return 0;
+
+	/*
+	 * If the keyslot manager of the request queue supports this crypto
+	 * mode, then we don't need to allocate this mode.
+	 */
+	if (blk_ksm_crypto_key_supported(q->ksm, key))
+		return 0;
+
+	mutex_lock(&tfms_init_lock);
+	err = blk_crypto_fallback_init();
+	if (err)
+		goto out;
+
+	if (tfms_inited[mode_num])
+		goto out;
+
+	for (i = 0; i < blk_crypto_num_keyslots; i++) {
+		slotp = &blk_crypto_keyslots[i];
+		slotp->tfms[mode_num] = crypto_alloc_skcipher(
+					blk_crypto_modes[mode_num].cipher_str,
+					0, 0);
+		if (IS_ERR(slotp->tfms[mode_num])) {
+			err = PTR_ERR(slotp->tfms[mode_num]);
+			slotp->tfms[mode_num] = NULL;
+			goto out_free_tfms;
+		}
+
+		crypto_skcipher_set_flags(slotp->tfms[mode_num],
+					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+	}
+
+	/*
+	 * Ensure that updates to blk_crypto_keyslots[i].tfms[mode_num]
+	 * for each i are visible before we set tfms_inited[mode_num].
+	 */
+	smp_store_release(&tfms_inited[mode_num], true);
+	goto out;
+
+out_free_tfms:
+	for (i = 0; i < blk_crypto_num_keyslots; i++) {
+		slotp = &blk_crypto_keyslots[i];
+		crypto_free_skcipher(slotp->tfms[mode_num]);
+		slotp->tfms[mode_num] = NULL;
+	}
+out:
+	mutex_unlock(&tfms_init_lock);
+	return err;
+}
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 1e6d339fe1429..45889df33b25a 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -16,6 +16,8 @@ struct blk_crypto_mode {
 	unsigned int ivsize; /* iv size in bytes */
 };
 
+extern const struct blk_crypto_mode blk_crypto_modes[];
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
 static inline const struct blk_crypto_key *bio_crypt_key(struct bio *bio)
@@ -169,4 +171,27 @@ static inline blk_status_t blk_crypto_insert_cloned_request(struct request *rq)
 	return BLK_STS_OK;
 }
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+
+bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
+
+int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
+static inline bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+{
+	pr_warn_once("crypto API fallback disabled; failing request.\n");
+	(*bio_ptr)->bi_status = BLK_STS_NOTSUPP;
+	return false;
+}
+
+static inline int
+blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
 #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index a52ec4eb153be..41d5e421624e5 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -3,6 +3,10 @@
  * Copyright 2019 Google LLC
  */
 
+/*
+ * Refer to Documentation/block/inline-encryption.rst for detailed explanation.
+ */
+
 #define pr_fmt(fmt) "blk-crypto: " fmt
 
 #include <linux/bio.h>
@@ -206,7 +210,8 @@ static bool bio_crypt_check_alignment(struct bio *bio)
  * __blk_crypto_init_request - Initializes the request's crypto fields based on
  *			       the blk_crypto_key for a bio to be added to the
  *			       request, and prepares it for hardware inline
- *			       encryption.
+ *			       encryption (as opposed to using the crypto API
+ *			       fallback).
  *
  * @rq: The request to init
  * @key: The blk_crypto_key of bios that will (eventually) be added to @rq.
@@ -219,6 +224,10 @@ static bool bio_crypt_check_alignment(struct bio *bio)
 blk_status_t __blk_crypto_init_request(struct request *rq,
 				       const struct blk_crypto_key *key)
 {
+	/*
+	 * We have a bio crypt context here - that means we didn't fallback
+	 * to crypto API, so try to program a keyslot now.
+	 */
 	return blk_ksm_get_slot_for_key(rq->q->ksm, key, &rq->crypt_keyslot);
 }
 
@@ -243,9 +252,16 @@ void __blk_crypto_free_request(struct request *rq)
  *
  * @bio_ptr: pointer to original bio pointer
  *
- * Succeeds if the bio doesn't have inline encryption enabled or if the bio
- * crypt context provided for the bio is supported by the underlying device's
- * inline encryption hardware. Ends the bio with error otherwise.
+ * If the bio crypt context provided for the bio is supported by the underlying
+ * device's inline encryption hardware, do nothing.
+ *
+ * Otherwise, try to perform en/decryption for this bio by falling back to the
+ * kernel crypto API. When the crypto API fallback is used for encryption,
+ * blk-crypto may choose to split the bio into 2 - the first one that will
+ * continue to be processed and the second one that will be resubmitted via
+ * generic_make_request. A bounce bio will be allocated to encrypt the contents
+ * of the aforementioned "first one", and *bio_ptr will be updated to this
+ * bounce bio.
  *
  * Caller must ensure bio has bio_crypt_ctx.
  *
@@ -265,16 +281,15 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 		goto fail;
 
 	/*
-	 * Success if device supports the encryption context, and blk-integrity
-	 * isn't supported by device/is turned off.
+	 * Success if device supports the encryption context, or we succeeded
+	 * in falling back to the crypto API.
 	 */
-	if (!blk_ksm_crypto_key_supported(bio->bi_disk->queue->ksm,
-					  bio->bi_crypt_context->bc_key)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
-		goto fail;
-	}
+	if (blk_ksm_crypto_key_supported(bio->bi_disk->queue->ksm,
+					 bio->bi_crypt_context->bc_key))
+		return true;
 
-	return true;
+	if (blk_crypto_fallback_bio_prep(bio_ptr))
+		return true;
 fail:
 	bio_endio(*bio_ptr);
 	return false;
@@ -298,6 +313,10 @@ void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
 
 void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
 {
+	/* Don't clone crypto info if src uses fallback en/decryption */
+	if (!src->crypt_keyslot)
+		return;
+
 	dst->crypt_ctx = src->crypt_ctx;
 }
 
@@ -375,6 +394,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
  * is evicted from hardware that it might have been programmed into. This
  * will call blk_ksm_evict_key on the queue's keyslot manager, if one
  * exists, and supports the crypto algorithm with the specified data unit size.
+ * Otherwise, it will evict the key from the blk-crypto-fallback's ksm.
  *
  * Return: 0 on success or if key is not present in the q's ksm, -err on error.
  */
@@ -384,5 +404,5 @@ int blk_crypto_evict_key(struct request_queue *q,
 	if (q->ksm && blk_ksm_crypto_key_supported(q->ksm, key))
 		return blk_ksm_evict_key(q->ksm, key);
 
-	return 0;
+	return blk_crypto_fallback_evict_key(key);
 }
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 4add2e8846fea..c83fc736b97a4 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -58,7 +58,7 @@ struct blk_crypto_key {
  *
  * A bio_crypt_ctx specifies that the contents of the bio will be encrypted (for
  * write requests) or decrypted (for read requests) inline by the storage device
- * or controller.
+ * or controller, or by the crypto API fallback.
  */
 struct bio_crypt_ctx {
 	const struct blk_crypto_key	*bc_key;
@@ -111,4 +111,19 @@ static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
 		__bio_crypt_clone(dst, src, gfp_mask);
 }
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+
+int blk_crypto_start_using_key(struct blk_crypto_key *key,
+			       struct request_queue *q);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
+static inline int blk_crypto_start_using_key(struct blk_crypto_key *key,
+					     struct request_queue *q)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
 #endif /* __LINUX_BLK_CRYPTO_H */
-- 
2.25.1.696.g5e7596f4ac-goog

