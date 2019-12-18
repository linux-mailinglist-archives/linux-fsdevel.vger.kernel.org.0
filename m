Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADDC124A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLROw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:52:29 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56414 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLROw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:52:29 -0500
Received: by mail-pg1-f201.google.com with SMTP id a4so1306086pgq.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kik5bKTq/mKmI0hTGynjbMZOlrR5Z2Vl3xKr3Jf/JAI=;
        b=OgiGI6AAcaHghiaDfjSSj02/U86vPyKiDz6BTpb0skRuUzVpUICJnfx0Vso0fao1zz
         oLN52Css45+xig/e8H4hVAE1YMRWCK0Ymj0D8Q6V26nbAombcArVSYysRv8QUFGy1JpI
         AN7waPo3m05X8wgaUprlUgPUgS7HqcriN3x5Q9FkIn8sXyrXpRKe+MQvivq9BHEh1Rpf
         YOWL3QsJzBQj4x5+bx0jIjVbEzTjT/8MQLILAgngPpcJ6x2oqJ67sHWaUqdmN0ogty2Z
         wxUt3VbjKnvyiIw4Nb5OTyhvIS7Ob721ZQ1TFykS1OXqPaYqBF8rnZ5AaXGKF3qERllt
         9y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kik5bKTq/mKmI0hTGynjbMZOlrR5Z2Vl3xKr3Jf/JAI=;
        b=jGX0UZ8ragqNtMCOlyfL/WI4m9w9JwC6EeiSmhgH2YgNbLS/YeygHZrSHy0vCqvGLi
         iW6EAntWxbcRyYy7B1PZcA5hDjgKOWkWqSWu/Y44je24dI0/0KaAm0ZLgvyh4H8aYpdl
         LCs1o7wiPLdJkeA66jDwUbQIgLg+SW0hyILyGtx5Qmw20ePHo8CMXCb2Hdw8O5Ba5gzI
         t3HbhzBovHBULgMtLbn82cOYLxdkzTIAzawljM3WASZ6vMBooUqOpwD0Gfr8Y4xQ+1Va
         bpacuNnEQNsc1JRWdBD++Z2DUIosVbN/oDWCHlWsg6Kf29CTmuUTrRw/pJKNHVcppo2p
         aWhw==
X-Gm-Message-State: APjAAAWp+fyMOOc+pMpCOten13y3r7Fp66pssbdFrScH7/Q8yowBWv0J
        6NqBqvSwdWyi47+q8dxJ/+UfyH8YBiA=
X-Google-Smtp-Source: APXvYqw3rgIryvD4N3nvIdq0VRtMQwFkTWbxQDWL4rrQQvIGIaRmDwR5hSosSPTiUZ8yMhIKzwNWcXaHR9w=
X-Received: by 2002:a63:ff20:: with SMTP id k32mr3437519pgi.448.1576680747305;
 Wed, 18 Dec 2019 06:52:27 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:51:30 -0800
In-Reply-To: <20191218145136.172774-1-satyat@google.com>
Message-Id: <20191218145136.172774-4-satyat@google.com>
Mime-Version: 1.0
References: <20191218145136.172774-1-satyat@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v6 3/9] block: blk-crypto for Inline Encryption
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

We introduce blk-crypto, which manages programming keyslots for struct
bios. With blk-crypto, filesystems only need to call bio_crypt_set_ctx with
the encryption key, algorithm and data_unit_num; they don't have to worry
about getting a keyslot for each encryption context, as blk-crypto handles
that. Blk-crypto also makes it possible for layered devices like device
mapper to make use of inline encryption hardware.

Blk-crypto delegates crypto operations to inline encryption hardware when
available. The separately configurable blk-crypto-fallback also contains a
software fallback to the kernel crypto API - when enabled, blk-crypto
will use this fallback for en/decryption when inline encryption hardware is
not available. For more details, refer to
Documentation/block/inline-encryption.rst.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 183 ++++++
 block/Kconfig                             |  10 +
 block/Makefile                            |   4 +-
 block/bio-crypt-ctx.c                     |  17 +-
 block/bio.c                               |   5 +
 block/blk-core.c                          |  13 +-
 block/blk-crypto-fallback.c               | 648 ++++++++++++++++++++++
 block/blk-crypto-internal.h               |  58 ++
 block/blk-crypto.c                        | 242 ++++++++
 include/linux/blk-crypto.h                |  63 +++
 11 files changed, 1236 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/blk-crypto-fallback.c
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c
 create mode 100644 include/linux/blk-crypto.h

diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 3fa7a52fafa4..026addfc69bc 100644
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
index 000000000000..330106b23c09
--- /dev/null
+++ b/Documentation/block/inline-encryption.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Inline Encryption
+=================
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
+- IE hardware have a limited number of "keyslots" that can be programmed
+  with an encryption context (key, algorithm, data unit size, etc.) at any time.
+  One can specify a keyslot in a data request made to the device, and the
+  device will en/decrypt the data using the encryption context programmed into
+  that specified keyslot. When possible, we want to make multiple requests with
+  the same encryption context share the same keyslot.
+
+- We need a way for filesystems to specify an encryption context to use for
+  en/decrypting a struct bio, and a device driver (like UFS) needs to be able
+  to use that encryption context when it processes the bio.
+
+- We need a way for device drivers to expose their capabilities in a unified
+  way to the upper layers.
+
+
+Design
+======
+
+We add a struct bio_crypt_ctx to struct bio that can represent an
+encryption context, because we need to be able to pass this encryption
+context from the FS layer to the device driver to act upon.
+
+While IE hardware works on the notion of keyslots, the FS layer has no
+knowledge of keyslots - it simply wants to specify an encryption context to
+use while en/decrypting a bio.
+
+We introduce a keyslot manager (KSM) that handles the translation from
+encryption contexts specified by the FS to keyslots on the IE hardware.
+This KSM also serves as the way IE hardware can expose their capabilities to
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
+Blk-crypto
+==========
+
+The above is sufficient for simple cases, but does not work if there is a
+need for a crypto API fallback, or if we are want to use IE with layered
+devices. To these ends, we introduce blk-crypto. Blk-crypto allows us to
+present a unified view of encryption to the FS (so FS only needs to specify
+an encryption context and not worry about keyslots at all), and blk-crypto
+can decide whether to delegate the en/decryption to IE hardware or to the
+crypto API. Blk-crypto maintains an internal KSM that serves as the crypto
+API fallback.
+
+Blk-crypto needs to ensure that the encryption context is programmed into the
+"correct" keyslot manager for IE. If a bio is submitted to a layered device
+that eventually passes the bio down to a device that really does support IE, we
+want the encryption context to be programmed into a keyslot for the KSM of the
+device with IE support. However, blk-crypto does not know a priori whether a
+particular device is the final device in the layering structure for a bio or
+not. So in the case that a particular device does not support IE, since it is
+possibly the final destination device for the bio, if the bio requires
+encryption (i.e. the bio is doing a write operation), blk-crypto must fallback
+to the crypto API *before* sending the bio to the device.
+
+Blk-crypto ensures that:
+
+- The bio's encryption context is programmed into a keyslot in the KSM of the
+  request queue that the bio is being submitted to (or the crypto API fallback
+  KSM if the request queue doesn't have a KSM), and that the ``bc_ksm``
+  in the ``bi_crypt_context`` is set to this KSM
+
+- That the bio has its own individual reference to the keyslot in this KSM.
+  Once the bio passes through blk-crypto, its encryption context is programmed
+  in some KSM. The "its own individual reference to the keyslot" ensures that
+  keyslots can be released by each bio independently of other bios while
+  ensuring that the bio has a valid reference to the keyslot when, for e.g., the
+  crypto API fallback KSM in blk-crypto performs crypto on the device's behalf.
+  The individual references are ensured by increasing the refcount for the
+  keyslot in the ``bc_ksm`` when a bio with a programmed encryption
+  context is cloned.
+
+
+What blk-crypto does on bio submission
+--------------------------------------
+
+**Case 1:** blk-crypto is given a bio with only an encryption context that hasn't
+been programmed into any keyslot in any KSM (for e.g. a bio from the FS).
+  In this case, blk-crypto will program the encryption context into the KSM of the
+  request queue the bio is being submitted to (and if this KSM does not exist,
+  then it will program it into blk-crypto's internal KSM for crypto API
+  fallback). The KSM that this encryption context was programmed into is stored
+  as the ``bc_ksm`` in the bio's ``bi_crypt_context``.
+
+**Case 2:** blk-crypto is given a bio whose encryption context has already been
+programmed into a keyslot in the *crypto API fallback* KSM.
+  In this case, blk-crypto does nothing; it treats the bio as not having
+  specified an encryption context. Note that we cannot do here what we will do
+  in Case 3 because we would have already encrypted the bio via the crypto API
+  by this point.
+
+**Case 3:** blk-crypto is given a bio whose encryption context has already been
+programmed into a keyslot in some KSM (that is *not* the crypto API fallback
+KSM).
+  In this case, blk-crypto first releases that keyslot from that KSM and then
+  treats the bio as in Case 1.
+
+This way, when a device driver is processing a bio, it can be sure that
+the bio's encryption context has been programmed into some KSM (either the
+device driver's request queue's KSM, or blk-crypto's crypto API fallback KSM).
+It then simply needs to check if the bio's ``bc_ksm`` is the device's
+request queue's KSM. If so, then it should proceed with IE. If not, it should
+simply do nothing with respect to crypto, because some other KSM (perhaps the
+blk-crypto crypto API fallback KSM) is handling the en/decryption.
+
+Blk-crypto will release the keyslot that is being held by the bio (and also
+decrypt it if the bio is using the crypto API fallback KSM) once
+``bio_remaining_done`` returns true for the bio.
+
+
+Layered Devices
+===============
+
+Layered devices that wish to support IE need to create their own keyslot
+manager for their request queue, and expose whatever functionality they choose.
+When a layered device wants to pass a bio to another layer (either by
+resubmitting the same bio, or by submitting a clone), it doesn't need to do
+anything special because the bio (or the clone) will once again pass through
+blk-crypto, which will work as described in Case 3. If a layered device wants
+for some reason to do the IO by itself instead of passing it on to a child
+device, but it also chose to expose IE capabilities by setting up a KSM in its
+request queue, it is then responsible for en/decrypting the data itself. In
+such cases, the device can choose to call the blk-crypto function
+``blk_crypto_fallback_to_kernel_crypto_api`` (TODO: Not yet implemented), which will
+cause the en/decryption to be done via the crypto API fallback.
+
+
+Future Optimizations for layered devices
+========================================
+
+Creating a keyslot manager for the layered device uses up memory for each
+keyslot, and in general, a layered device (like dm-linear) merely passes the
+request on to a "child" device, so the keyslots in the layered device itself
+might be completely unused. We can instead define a new type of KSM; the
+"passthrough KSM", that layered devices can use to let blk-crypto know that
+this layered device *will* pass the bio to some child device (and hence
+through blk-crypto again, at which point blk-crypto can program the encryption
+context, instead of programming it into the layered device's KSM). Again, if
+the device "lies" and decides to do the IO itself instead of passing it on to
+a child device, it is responsible for doing the en/decryption (and can choose
+to call ``blk_crypto_fallback_to_kernel_crypto_api``). Another use case for the
+"passthrough KSM" is for IE devices that want to manage their own keyslots/do
+not have a limited number of keyslots.
diff --git a/block/Kconfig b/block/Kconfig
index f19da9da80fc..f35358e23ade 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -188,6 +188,16 @@ config BLK_INLINE_ENCRYPTION
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
index 79f2b8b3fc5d..bb8d12526f2e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -37,4 +37,6 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o bio-crypt-ctx.o
\ No newline at end of file
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o bio-crypt-ctx.o \
+					   blk-crypto.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
\ No newline at end of file
diff --git a/block/bio-crypt-ctx.c b/block/bio-crypt-ctx.c
index dadf0da3c21b..75982dabc7a3 100644
--- a/block/bio-crypt-ctx.c
+++ b/block/bio-crypt-ctx.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include "blk-crypto-internal.h"
 
 static int num_prealloc_crypt_ctxs = 128;
 
@@ -21,6 +22,8 @@ static mempool_t *bio_crypt_ctx_pool;
 
 int __init bio_crypt_ctx_init(void)
 {
+	size_t i;
+
 	bio_crypt_ctx_cache = KMEM_CACHE(bio_crypt_ctx, 0);
 	if (!bio_crypt_ctx_cache)
 		return -ENOMEM;
@@ -33,6 +36,12 @@ int __init bio_crypt_ctx_init(void)
 	/* This is assumed in various places. */
 	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
 
+	/* Sanity check that no algorithm exceeds the defined limits. */
+	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++) {
+		BUG_ON(blk_crypto_modes[i].keysize > BLK_CRYPTO_MAX_KEY_SIZE);
+		BUG_ON(blk_crypto_modes[i].ivsize > BLK_CRYPTO_MAX_IV_SIZE);
+	}
+
 	return 0;
 }
 
@@ -52,11 +61,11 @@ void bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 	const struct bio_crypt_ctx *src_bc = src->bi_crypt_context;
 
 	/*
-	 * If a bio is swhandled, then it will be decrypted when bio_endio
-	 * is called. As we only want the data to be decrypted once, copies
-	 * of the bio must not have have a crypt context.
+	 * If a bio is fallback_crypted, then it will be decrypted when
+	 * bio_endio is called. As we only want the data to be decrypted once,
+	 * copies of the bio must not have have a crypt context.
 	 */
-	if (!src_bc)
+	if (!src_bc || bio_crypt_fallback_crypted(src_bc))
 		return;
 
 	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
diff --git a/block/bio.c b/block/bio.c
index c99e054d56ef..b8bc9c9855fb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1791,6 +1792,10 @@ void bio_endio(struct bio *bio)
 again:
 	if (!bio_remaining_done(bio))
 		return;
+
+	if (!blk_crypto_endio(bio))
+		return;
+
 	if (!bio_integrity_endio(bio))
 		return;
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 5200f4d1fed4..60c09a4e8629 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -38,6 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/blk-crypto.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1063,7 +1064,9 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret = q->make_request_fn(q, bio);
+
+			if (!blk_crypto_submit_bio(&bio))
+				ret = q->make_request_fn(q, bio);
 
 			blk_queue_exit(q);
 
@@ -1111,7 +1114,7 @@ blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
-	blk_qc_t ret;
+	blk_qc_t ret = BLK_QC_T_NONE;
 
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
@@ -1125,7 +1128,8 @@ blk_qc_t direct_make_request(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	ret = q->make_request_fn(q, bio);
+	if (!blk_crypto_submit_bio(&bio))
+		ret = q->make_request_fn(q, bio);
 	blk_queue_exit(q);
 	return ret;
 }
@@ -1813,5 +1817,8 @@ int __init blk_dev_init(void)
 	if (bio_crypt_ctx_init() < 0)
 		panic("Failed to allocate mem for bio crypt ctxs\n");
 
+	if (blk_crypto_fallback_init() < 0)
+		panic("Failed to init blk-crypto-fallback\n");
+
 	return 0;
 }
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
new file mode 100644
index 000000000000..9773bd6a5186
--- /dev/null
+++ b/block/blk-crypto-fallback.c
@@ -0,0 +1,648 @@
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
+};
+
+/* The following few vars are only used during the crypto API fallback */
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
+struct blk_crypto_decrypt_work {
+	struct work_struct work;
+	struct bio *bio;
+};
+
+static struct blk_crypto_keyslot {
+	struct crypto_skcipher *tfm;
+	enum blk_crypto_mode_num crypto_mode;
+	struct crypto_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
+} *blk_crypto_keyslots;
+
+/* The following few vars are only used during the crypto API fallback */
+static struct keyslot_manager *blk_crypto_ksm;
+static struct workqueue_struct *blk_crypto_wq;
+static mempool_t *blk_crypto_bounce_page_pool;
+static struct kmem_cache *blk_crypto_decrypt_work_cache;
+
+bool bio_crypt_fallback_crypted(const struct bio_crypt_ctx *bc)
+{
+	return bc && bc->bc_ksm == blk_crypto_ksm;
+}
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
+static int blk_crypto_keyslot_program(struct keyslot_manager *ksm,
+				      const struct blk_crypto_key *key,
+				      unsigned int slot)
+{
+	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
+	const enum blk_crypto_mode_num crypto_mode = key->crypto_mode;
+	int err;
+
+	if (crypto_mode != slotp->crypto_mode &&
+	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID) {
+		blk_crypto_evict_keyslot(slot);
+	}
+
+	if (!slotp->tfms[crypto_mode])
+		return -ENOMEM;
+	slotp->crypto_mode = crypto_mode;
+	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], key->raw,
+				     key->size);
+	if (err) {
+		blk_crypto_evict_keyslot(slot);
+		return err;
+	}
+	return 0;
+}
+
+static int blk_crypto_keyslot_evict(struct keyslot_manager *ksm,
+				    const struct blk_crypto_key *key,
+				    unsigned int slot)
+{
+	blk_crypto_evict_keyslot(slot);
+	return 0;
+}
+
+/*
+ * The crypto API fallback KSM ops - only used for a bio when it specifies a
+ * blk_crypto_mode for which we failed to get a keyslot in the device's inline
+ * encryption hardware (which probably means the device doesn't have inline
+ * encryption hardware that supports that crypto mode).
+ */
+static const struct keyslot_mgmt_ll_ops blk_crypto_ksm_ll_ops = {
+	.keyslot_program	= blk_crypto_keyslot_program,
+	.keyslot_evict		= blk_crypto_keyslot_evict,
+};
+
+static void blk_crypto_encrypt_endio(struct bio *enc_bio)
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
+	if (bio_integrity(bio_src) &&
+	    bio_integrity_clone(bio, bio_src, GFP_NOIO) < 0) {
+		bio_put(bio);
+		return NULL;
+	}
+
+	bio_clone_blkg_association(bio, bio_src);
+	blkcg_bio_issue_init(bio);
+
+	return bio;
+}
+
+static int blk_crypto_alloc_cipher_req(struct bio *src_bio,
+				       struct skcipher_request **ciph_req_ret,
+				       struct crypto_wait *wait)
+{
+	struct skcipher_request *ciph_req;
+	const struct blk_crypto_keyslot *slotp;
+
+	slotp = &blk_crypto_keyslots[src_bio->bi_crypt_context->bc_keyslot];
+	ciph_req = skcipher_request_alloc(slotp->tfms[slotp->crypto_mode],
+					  GFP_NOIO);
+	if (!ciph_req) {
+		src_bio->bi_status = BLK_STS_RESOURCE;
+		return -ENOMEM;
+	}
+
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, wait);
+	*ciph_req_ret = ciph_req;
+	return 0;
+}
+
+static int blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
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
+			return -ENOMEM;
+		}
+		bio_chain(split_bio, bio);
+		generic_make_request(bio);
+		*bio_ptr = split_bio;
+	}
+	return 0;
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
+ * large.
+ */
+static int blk_crypto_encrypt_bio(struct bio **bio_ptr)
+{
+	struct bio *src_bio;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	union blk_crypto_iv iv;
+	struct scatterlist src, dst;
+	struct bio *enc_bio;
+	unsigned int i, j;
+	int data_unit_size;
+	struct bio_crypt_ctx *bc;
+	int err = 0;
+
+	/* Split the bio if it's too big for single page bvec */
+	err = blk_crypto_split_bio_if_needed(bio_ptr);
+	if (err)
+		return err;
+
+	src_bio = *bio_ptr;
+	bc = src_bio->bi_crypt_context;
+	data_unit_size = bc->bc_key->data_unit_size;
+
+	/* Allocate bounce bio for encryption */
+	enc_bio = blk_crypto_clone_bio(src_bio);
+	if (!enc_bio) {
+		src_bio->bi_status = BLK_STS_RESOURCE;
+		return -ENOMEM;
+	}
+
+	/*
+	 * Use the crypto API fallback keyslot manager to get a crypto_skcipher
+	 * for the algorithm and key specified for this bio.
+	 */
+	err = bio_crypt_ctx_acquire_keyslot(bc, blk_crypto_ksm);
+	if (err) {
+		src_bio->bi_status = BLK_STS_IOERR;
+		goto out_put_enc_bio;
+	}
+
+	/* and then allocate an skcipher_request for it */
+	err = blk_crypto_alloc_cipher_req(src_bio, &ciph_req, &wait);
+	if (err)
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
+			err = -ENOMEM;
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
+			err = crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
+					      &wait);
+			if (err) {
+				i++;
+				src_bio->bi_status = BLK_STS_RESOURCE;
+				goto out_free_bounce_pages;
+			}
+			bio_crypt_dun_increment(curr_dun, 1);
+			src.offset += data_unit_size;
+			dst.offset += data_unit_size;
+		}
+	}
+
+	enc_bio->bi_private = src_bio;
+	enc_bio->bi_end_io = blk_crypto_encrypt_endio;
+	*bio_ptr = enc_bio;
+
+	enc_bio = NULL;
+	err = 0;
+	goto out_free_ciph_req;
+
+out_free_bounce_pages:
+	while (i > 0)
+		mempool_free(enc_bio->bi_io_vec[--i].bv_page,
+			     blk_crypto_bounce_page_pool);
+out_free_ciph_req:
+	skcipher_request_free(ciph_req);
+out_release_keyslot:
+	bio_crypt_ctx_release_keyslot(bc);
+out_put_enc_bio:
+	if (enc_bio)
+		bio_put(enc_bio);
+
+	return err;
+}
+
+static void blk_crypto_free_fallback_crypt_ctx(struct bio *bio)
+{
+	mempool_free(container_of(bio->bi_crypt_context,
+				  struct bio_fallback_crypt_ctx,
+				  crypt_ctx),
+		     bio_fallback_crypt_ctx_pool);
+	bio->bi_crypt_context = NULL;
+}
+
+/*
+ * The crypto API fallback's main decryption routine.
+ * Decrypts input bio in place.
+ */
+static void blk_crypto_decrypt_bio(struct work_struct *work)
+{
+	struct blk_crypto_decrypt_work *decrypt_work =
+		container_of(work, struct blk_crypto_decrypt_work, work);
+	struct bio *bio = decrypt_work->bio;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	union blk_crypto_iv iv;
+	struct scatterlist sg;
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	struct bio_fallback_crypt_ctx *f_ctx =
+		container_of(bc, struct bio_fallback_crypt_ctx, crypt_ctx);
+	const int data_unit_size = bc->bc_key->data_unit_size;
+	unsigned int i;
+	int err;
+
+	/*
+	 * Use the crypto API fallback keyslot manager to get a crypto_skcipher
+	 * for the algorithm and key specified for this bio.
+	 */
+	if (bio_crypt_ctx_acquire_keyslot(bc, blk_crypto_ksm)) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		goto out_no_keyslot;
+	}
+
+	/* and then allocate an skcipher_request for it */
+	err = blk_crypto_alloc_cipher_req(bio, &ciph_req, &wait);
+	if (err)
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
+	bio_crypt_ctx_release_keyslot(bc);
+out_no_keyslot:
+	kmem_cache_free(blk_crypto_decrypt_work_cache, decrypt_work);
+	blk_crypto_free_fallback_crypt_ctx(bio);
+	bio_endio(bio);
+}
+
+/*
+ * Queue bio for decryption.
+ * Returns true iff bio was queued for decryption.
+ */
+bool blk_crypto_queue_decrypt_bio(struct bio *bio)
+{
+	struct blk_crypto_decrypt_work *decrypt_work;
+
+	/* If there was an IO error, don't queue for decrypt. */
+	if (bio->bi_status)
+		goto out;
+
+	decrypt_work = kmem_cache_zalloc(blk_crypto_decrypt_work_cache,
+					 GFP_ATOMIC);
+	if (!decrypt_work) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		goto out;
+	}
+
+	INIT_WORK(&decrypt_work->work, blk_crypto_decrypt_bio);
+	decrypt_work->bio = bio;
+	queue_work(blk_crypto_wq, &decrypt_work->work);
+
+	return true;
+out:
+	blk_crypto_free_fallback_crypt_ctx(bio);
+	return false;
+}
+
+/**
+ * blk_crypto_start_using_mode() - Start using a crypto algorithm on a device
+ * @mode_num: the blk_crypto_mode we want to allocate ciphers for.
+ * @data_unit_size: the data unit size that will be used
+ * @q: the request queue for the device
+ *
+ * Upper layers must call this function to ensure that a the crypto API fallback
+ * has transforms for this algorithm, if they become necessary.
+ *
+ * Return: 0 on success and -err on error.
+ */
+int blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+				unsigned int data_unit_size,
+				struct request_queue *q)
+{
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
+	 * If the keyslot manager of the request queue supports this
+	 * crypto mode, then we don't need to allocate this mode.
+	 */
+	if (keyslot_manager_crypto_mode_supported(q->ksm, mode_num,
+						  data_unit_size))
+		return 0;
+
+	mutex_lock(&tfms_init_lock);
+	if (likely(tfms_inited[mode_num]))
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
+
+int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
+{
+	return keyslot_manager_evict_key(blk_crypto_ksm, key);
+}
+
+int blk_crypto_fallback_submit_bio(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	struct bio_fallback_crypt_ctx *f_ctx;
+
+	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_mode])) {
+		bio->bi_status = BLK_STS_IOERR;
+		return -EIO;
+	}
+
+	if (bio_data_dir(bio) == WRITE)
+		return blk_crypto_encrypt_bio(bio_ptr);
+
+	/*
+	 * Mark bio as fallback crypted and replace the bio_crypt_ctx with
+	 * another one contained in a bio_fallback_crypt_ctx, so that the
+	 * fallback has space to store the info it needs for decryption.
+	 */
+	bc->bc_ksm = blk_crypto_ksm;
+	f_ctx = mempool_alloc(bio_fallback_crypt_ctx_pool, GFP_NOIO);
+	f_ctx->crypt_ctx = *bc;
+	memcpy(f_ctx->fallback_dun, bc->bc_dun, sizeof(f_ctx->fallback_dun));
+	f_ctx->crypt_iter = bio->bi_iter;
+
+	bio_crypt_free_ctx(bio);
+	bio->bi_crypt_context = &f_ctx->crypt_ctx;
+
+	return 0;
+}
+
+int __init blk_crypto_fallback_init(void)
+{
+	int i;
+	unsigned int crypto_mode_supported[BLK_ENCRYPTION_MODE_MAX];
+
+	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
+
+	/* All blk-crypto modes have a crypto API fallback. */
+	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
+		crypto_mode_supported[i] = 0xFFFFFFFF;
+	crypto_mode_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
+
+	blk_crypto_ksm = keyslot_manager_create(blk_crypto_num_keyslots,
+						&blk_crypto_ksm_ll_ops,
+						crypto_mode_supported, NULL);
+	if (!blk_crypto_ksm)
+		return -ENOMEM;
+
+	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
+					WQ_UNBOUND | WQ_HIGHPRI |
+					WQ_MEM_RECLAIM, num_online_cpus());
+	if (!blk_crypto_wq)
+		return -ENOMEM;
+
+	blk_crypto_keyslots = kcalloc(blk_crypto_num_keyslots,
+				      sizeof(blk_crypto_keyslots[0]),
+				      GFP_KERNEL);
+	if (!blk_crypto_keyslots)
+		return -ENOMEM;
+
+	blk_crypto_bounce_page_pool =
+		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
+	if (!blk_crypto_bounce_page_pool)
+		return -ENOMEM;
+
+	blk_crypto_decrypt_work_cache = KMEM_CACHE(blk_crypto_decrypt_work,
+						   SLAB_RECLAIM_ACCOUNT);
+	if (!blk_crypto_decrypt_work_cache)
+		return -ENOMEM;
+
+	bio_fallback_crypt_ctx_cache = KMEM_CACHE(bio_fallback_crypt_ctx, 0);
+	if (!bio_fallback_crypt_ctx_cache)
+		return -ENOMEM;
+
+	bio_fallback_crypt_ctx_pool =
+		mempool_create_slab_pool(num_prealloc_fallback_crypt_ctxs,
+					 bio_fallback_crypt_ctx_cache);
+	if (!bio_fallback_crypt_ctx_pool)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
new file mode 100644
index 000000000000..43351eecc97a
--- /dev/null
+++ b/block/blk-crypto-internal.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_INTERNAL_H
+#define __LINUX_BLK_CRYPTO_INTERNAL_H
+
+#include <linux/bio.h>
+
+/* Represents a crypto mode supported by blk-crypto  */
+struct blk_crypto_mode {
+	const char *cipher_str; /* crypto API name (for fallback case) */
+	unsigned int keysize; /* key size in bytes */
+	unsigned int ivsize; /* iv size in bytes */
+};
+
+extern const struct blk_crypto_mode blk_crypto_modes[];
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+
+int blk_crypto_fallback_submit_bio(struct bio **bio_ptr);
+
+bool blk_crypto_queue_decrypt_bio(struct bio *bio);
+
+int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
+
+bool bio_crypt_fallback_crypted(const struct bio_crypt_ctx *bc);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
+static inline bool bio_crypt_fallback_crypted(const struct bio_crypt_ctx *bc)
+{
+	return false;
+}
+
+static inline int blk_crypto_fallback_submit_bio(struct bio **bio_ptr)
+{
+	pr_warn_once("blk-crypto crypto API fallback disabled; failing request");
+	(*bio_ptr)->bi_status = BLK_STS_NOTSUPP;
+	return -EIO;
+}
+
+static inline bool blk_crypto_queue_decrypt_bio(struct bio *bio)
+{
+	WARN_ON(1);
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
+#endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 000000000000..2c47e8eec865
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Refer to Documentation/block/inline-encryption.rst for detailed explanation.
+ */
+
+#define pr_fmt(fmt) "blk-crypto: " fmt
+
+#include <linux/blk-crypto.h>
+#include <linux/blkdev.h>
+#include <linux/keyslot-manager.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
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
+/**
+ * blk_crypto_submit_bio - handle submitting bio for inline encryption
+ *
+ * @bio_ptr: pointer to original bio pointer
+ *
+ * If the bio doesn't have inline encryption enabled or the submitter already
+ * specified a keyslot for the target device, do nothing.  Else, a raw key must
+ * have been provided, so acquire a device keyslot for it if supported.  Else,
+ * use the crypto API fallback.
+ *
+ * When the crypto API fallback is used for encryption, blk-crypto may choose to
+ * split the bio into 2 - the first one that will continue to be processed and
+ * the second one that will be resubmitted via generic_make_request.
+ * A bounce bio will be allocated to encrypt the contents of the aforementioned
+ * "first one", and *bio_ptr will be updated to this bounce bio.
+ *
+ * Return: 0 if bio submission should continue; nonzero if bio_endio() was
+ *	   already called so bio submission should abort.
+ */
+int blk_crypto_submit_bio(struct bio **bio_ptr)
+{
+	struct bio *bio = *bio_ptr;
+	struct request_queue *q;
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	int err;
+
+	if (!bc || !bio_has_data(bio))
+		return 0;
+
+	/*
+	 * When a read bio is marked for fallback decryption, its bi_iter is
+	 * saved so that when we decrypt the bio later, we know what part of it
+	 * was marked for fallback decryption (when the bio is passed down after
+	 * blk_crypto_submit bio, it may be split or advanced so we cannot rely
+	 * on the bi_iter while decrypting in blk_crypto_endio)
+	 */
+	if (bio_crypt_fallback_crypted(bc))
+		return 0;
+
+	err = bio_crypt_check_alignment(bio);
+	if (err) {
+		bio->bi_status = BLK_STS_IOERR;
+		goto out;
+	}
+
+	q = bio->bi_disk->queue;
+
+	if (bc->bc_ksm) {
+		/* Key already programmed into device? */
+		if (q->ksm == bc->bc_ksm)
+			return 0;
+
+		/* Nope, release the existing keyslot. */
+		bio_crypt_ctx_release_keyslot(bc);
+	}
+
+	/* Get device keyslot if supported */
+	if (keyslot_manager_crypto_mode_supported(q->ksm,
+						  bc->bc_key->crypto_mode,
+						  bc->bc_key->data_unit_size)) {
+		err = bio_crypt_ctx_acquire_keyslot(bc, q->ksm);
+		if (!err)
+			return 0;
+
+		pr_warn_once("Failed to acquire keyslot for %s (err=%d).  Falling back to crypto API.\n",
+			     bio->bi_disk->disk_name, err);
+	}
+
+	/* Fallback to crypto API */
+	err = blk_crypto_fallback_submit_bio(bio_ptr);
+	if (err)
+		goto out;
+
+	return 0;
+out:
+	bio_endio(*bio_ptr);
+	return err;
+}
+
+/**
+ * blk_crypto_endio - clean up bio w.r.t inline encryption during bio_endio
+ *
+ * @bio: the bio to clean up
+ *
+ * If blk_crypto_submit_bio decided to fallback to crypto API for this bio,
+ * we queue the bio for decryption into a workqueue and return false,
+ * and call bio_endio(bio) at a later time (after the bio has been decrypted).
+ *
+ * If the bio is not to be decrypted by the crypto API, this function releases
+ * the reference to the keyslot that blk_crypto_submit_bio got.
+ *
+ * Return: true if bio_endio should continue; false otherwise (bio_endio will
+ * be called again when bio has been decrypted).
+ */
+bool blk_crypto_endio(struct bio *bio)
+{
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+	if (!bc)
+		return true;
+
+	if (bio_crypt_fallback_crypted(bc)) {
+		/*
+		 * The only bios who's crypto is handled by the blk-crypto
+		 * fallback when they reach here are those with
+		 * bio_data_dir(bio) == READ, since WRITE bios that are
+		 * encrypted by the crypto API fallback are handled by
+		 * blk_crypto_encrypt_endio().
+		 */
+		return !blk_crypto_queue_decrypt_bio(bio);
+	}
+
+	if (bc->bc_keyslot >= 0)
+		bio_crypt_ctx_release_keyslot(bc);
+
+	return true;
+}
+
+/**
+ * blk_crypto_init_key() - Prepare a key for use with blk-crypto
+ * @blk_key: Pointer to the blk_crypto_key to initialize.
+ * @raw_key: Pointer to the raw key.  Must be the correct length for the chosen
+ *	     @crypto_mode; see blk_crypto_modes[].
+ * @crypto_mode: identifier for the encryption algorithm to use
+ * @data_unit_size: the data unit size to use for en/decryption
+ *
+ * Return: The blk_crypto_key that was prepared, or an ERR_PTR() on error.  When
+ *	   done using the key, it must be freed with blk_crypto_free_key().
+ */
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
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
+ * will call keyslot_manager_evict_key on the queue's keyslot manager, if one
+ * exists, and supports the crypto algorithm with the specified data unit size.
+ * Otherwise, it will evict the key from the blk-crypto-fallback's ksm.
+ *
+ * Return: 0 on success, -err on error.
+ */
+int blk_crypto_evict_key(struct request_queue *q,
+			 const struct blk_crypto_key *key)
+{
+	if (q->ksm &&
+	    keyslot_manager_crypto_mode_supported(q->ksm, key->crypto_mode,
+						  key->data_unit_size))
+		return keyslot_manager_evict_key(q->ksm, key);
+
+	return blk_crypto_fallback_evict_key(key);
+}
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
new file mode 100644
index 000000000000..07d32e33f0bb
--- /dev/null
+++ b/include/linux/blk-crypto.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_H
+#define __LINUX_BLK_CRYPTO_H
+
+#include <linux/bio.h>
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+int blk_crypto_submit_bio(struct bio **bio_ptr);
+
+bool blk_crypto_endio(struct bio *bio);
+
+int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+			enum blk_crypto_mode_num crypto_mode,
+			unsigned int data_unit_size);
+
+int blk_crypto_evict_key(struct request_queue *q,
+			 const struct blk_crypto_key *key);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline int blk_crypto_submit_bio(struct bio **bio_ptr)
+{
+	return 0;
+}
+
+static inline bool blk_crypto_endio(struct bio *bio)
+{
+	return true;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+
+int blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+				unsigned int data_unit_size,
+				struct request_queue *q);
+
+int blk_crypto_fallback_init(void);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
+static inline int
+blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+			    unsigned int data_unit_size,
+			    struct request_queue *q)
+{
+	return 0;
+}
+
+static inline int blk_crypto_fallback_init(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
+
+#endif /* __LINUX_BLK_CRYPTO_H */
-- 
2.24.1.735.g03f4e72817-goog

