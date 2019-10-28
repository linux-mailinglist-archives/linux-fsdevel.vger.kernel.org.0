Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5690E6CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfJ1HUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:47 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:34278 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbfJ1HUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:47 -0400
Received: by mail-vk1-f201.google.com with SMTP id r16so4456360vkd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DgGE3grzIR+GN9HpNoFt3dVePJK0s47e9C+4g0N4hMM=;
        b=vme0M9e2HPjPQfjoNRvttQYlxaJCaP9HGOtC/nL4M8V4a29QdIJZdI+LJb0Pw2p/Jr
         LdGcC8Pg85XyuegAA0MAN6H8gcMguNT3nmmlY8OYxM2EaylGl1E/8392CDSl46SucpUQ
         MFHInTTv7ehTtKoXdn7epuWth4QzBB9bh3N/TA0MsYQLBVyH6FtpnMq2POapzz59C5v3
         1UU/B2U2jFBhMKrXXwKalTpfw3QxoeQPHxBYzWv14b852NB8VtWtBtvaA39BQjvJLtla
         pdCR5OZ3SA7amSjbb1JZmSS15u8pAPRK2LF1UWyXcspI4pkE9NHX5K90hOmoiZOf1NzO
         YvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DgGE3grzIR+GN9HpNoFt3dVePJK0s47e9C+4g0N4hMM=;
        b=KY7VLSjN9wS2c/fV4533GbSVsvlqJ6zIkshBJyTZZR4nz3RJtiH2oCOG16X3l9/xuH
         OwECMCFeqwNuxJgv1x7apBz53B/opDuIifmTw0ORsyzSer2Cls7swAXP1+I0+D3FGzl3
         DXAtSeKBdok0NIWC6ZcBFXYDWIEGUm4YHNLk2D85BTJVJ3dmbt/JbhWlFcDS0u0BEj+i
         q5c2ykuVk7TmoJ1GFtMfcHMSP4rVNG91sXKNede+SDJ3JlYpFQaGtVkAZb7v4a9iaJna
         8YzyCrlNORjjii+SKmZ3azZSacNX3Plx1/qUHjURqoF76a+fH9i3+Am+ggM98+ZcDppQ
         m/Tg==
X-Gm-Message-State: APjAAAWnkJBapmAQi3MLetR9ZLVKdT/xLWOWqQHZDazDzFq5tjLFGKNs
        dZqswKVVcrIXU1UEfB7zJLThor5Uf2M=
X-Google-Smtp-Source: APXvYqykhnZtdzORXAyupuWqn2BHYQR0B89sobdNSzCHzKD3cGNpudvmnJ9oAl+4yIGw4UNa5Frr46oMdig=
X-Received: by 2002:ab0:5a95:: with SMTP id w21mr4781080uae.72.1572247245620;
 Mon, 28 Oct 2019 00:20:45 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:26 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-4-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 3/9] block: blk-crypto for Inline Encryption
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
available, and also contains a software fallback to the kernel crypto API.
For more details, refer to Documentation/block/inline-encryption.rst.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 183 +++++
 block/Kconfig                             |   2 +
 block/Makefile                            |   3 +-
 block/bio-crypt-ctx.c                     |   7 +-
 block/bio.c                               |   5 +
 block/blk-core.c                          |  11 +-
 block/blk-crypto.c                        | 798 ++++++++++++++++++++++
 include/linux/bio-crypt-ctx.h             |   7 +
 include/linux/blk-crypto.h                |  62 ++
 10 files changed, 1076 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
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
index 000000000000..202826cee95e
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
+  KSM if the request queue doesn't have a KSM), and that the ``processing_ksm``
+  in the ``bi_crypt_context`` is set to this KSM
+
+- That the bio has its own individual reference to the keyslot in this KSM.
+  Once the bio passes through blk-crypto, its encryption context is programmed
+  in some KSM. The "its own individual reference to the keyslot" ensures that
+  keyslots can be released by each bio independently of other bios while
+  ensuring that the bio has a valid reference to the keyslot when, for e.g., the
+  crypto API fallback KSM in blk-crypto performs crypto on the device's behalf.
+  The individual references are ensured by increasing the refcount for the
+  keyslot in the ``processing_ksm`` when a bio with a programmed encryption
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
+  as the ``processing_ksm`` in the bio's ``bi_crypt_context``.
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
+It then simply needs to check if the bio's processing_ksm is the device's
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
index ae52d42b783b..606a67e47e68 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -179,6 +179,8 @@ config BLK_SED_OPAL
 
 config BLK_INLINE_ENCRYPTION
 	bool "Enable inline encryption support in block layer"
+	select CRYPTO
+	select CRYPTO_BLKCIPHER
 	help
 	  Build the blk-crypto subsystem.
 	  Enabling this lets the block layer handle encryption,
diff --git a/block/Makefile b/block/Makefile
index f39611ed151f..8932c7e4fd07 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,4 +36,5 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o bio-crypt-ctx.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o bio-crypt-ctx.o \
+					   blk-crypto.o
diff --git a/block/bio-crypt-ctx.c b/block/bio-crypt-ctx.c
index aa3571f72ee7..6a2b061865c6 100644
--- a/block/bio-crypt-ctx.c
+++ b/block/bio-crypt-ctx.c
@@ -43,7 +43,12 @@ EXPORT_SYMBOL(bio_crypt_free_ctx);
 
 int bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 {
-	if (!bio_has_crypt_ctx(src))
+	/*
+	 * If a bio is swhandled, then it will be decrypted when bio_endio
+	 * is called. As we only want the data to be decrypted once, copies
+	 * of the bio must not have have a crypt context.
+	 */
+	if (!bio_has_crypt_ctx(src) || bio_crypt_swhandled(src))
 		return 0;
 
 	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
diff --git a/block/bio.c b/block/bio.c
index ce8003aadf07..36a1712328d0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
+#include <linux/blk-crypto.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1788,6 +1789,10 @@ void bio_endio(struct bio *bio)
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
index 3b5959d386fb..0f7e81dbe2ee 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -38,6 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/blk-crypto.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1061,7 +1062,9 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret = q->make_request_fn(q, bio);
+
+			if (!blk_crypto_submit_bio(&bio))
+				ret = q->make_request_fn(q, bio);
 
 			blk_queue_exit(q);
 
@@ -1114,6 +1117,9 @@ blk_qc_t direct_make_request(struct bio *bio)
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
 
+	if (blk_crypto_submit_bio(&bio))
+		return BLK_QC_T_NONE;
+
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
 			bio->bi_status = BLK_STS_AGAIN;
@@ -1810,5 +1816,8 @@ int __init blk_dev_init(void)
 	if (bio_crypt_ctx_init() < 0)
 		panic("Failed to allocate mem for bio crypt ctxs\n");
 
+	if (blk_crypto_init() < 0)
+		panic("Failed to init blk-crypto\n");
+
 	return 0;
 }
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 000000000000..89649655bf4b
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,798 @@
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
+#include <linux/keyslot-manager.h>
+#include <linux/mempool.h>
+#include <linux/blk-cgroup.h>
+#include <linux/crypto.h>
+#include <crypto/skcipher.h>
+#include <crypto/algapi.h>
+#include <linux/module.h>
+#include <linux/sched/mm.h>
+
+/* Represents a crypto mode supported by blk-crypto  */
+struct blk_crypto_mode {
+	const char *cipher_str; /* crypto API name (for fallback case) */
+	size_t keysize; /* key size in bytes */
+};
+
+static const struct blk_crypto_mode blk_crypto_modes[] = {
+	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
+		.cipher_str = "xts(aes)",
+		.keysize = 64,
+	},
+};
+
+static unsigned int num_prealloc_bounce_pg = 32;
+module_param(num_prealloc_bounce_pg, uint, 0);
+MODULE_PARM_DESC(num_prealloc_bounce_pg,
+	"Number of preallocated bounce pages for blk-crypto to use during crypto API fallback encryption");
+
+#define BLK_CRYPTO_MAX_KEY_SIZE 64
+static int blk_crypto_num_keyslots = 100;
+module_param_named(num_keyslots, blk_crypto_num_keyslots, int, 0);
+MODULE_PARM_DESC(num_keyslots,
+		 "Number of keyslots for crypto API fallback in blk-crypto.");
+
+static struct blk_crypto_keyslot {
+	struct crypto_skcipher *tfm;
+	enum blk_crypto_mode_num crypto_mode;
+	u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
+	struct crypto_skcipher *tfms[ARRAY_SIZE(blk_crypto_modes)];
+} *blk_crypto_keyslots;
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
+static struct mutex tfms_lock[ARRAY_SIZE(blk_crypto_modes)];
+static bool tfms_inited[ARRAY_SIZE(blk_crypto_modes)];
+
+struct work_mem {
+	struct work_struct crypto_work;
+	struct bio *bio;
+};
+
+/* The following few vars are only used during the crypto API fallback */
+static struct keyslot_manager *blk_crypto_ksm;
+static struct workqueue_struct *blk_crypto_wq;
+static mempool_t *blk_crypto_page_pool;
+static struct kmem_cache *blk_crypto_work_mem_cache;
+
+bool bio_crypt_swhandled(struct bio *bio)
+{
+	return bio_has_crypt_ctx(bio) &&
+	       bio->bi_crypt_context->processing_ksm == blk_crypto_ksm;
+}
+
+static u8 blank_key[BLK_CRYPTO_MAX_KEY_SIZE];
+static void evict_keyslot(unsigned int slot)
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
+	memzero_explicit(slotp->key, BLK_CRYPTO_MAX_KEY_SIZE);
+	slotp->crypto_mode = BLK_ENCRYPTION_MODE_INVALID;
+}
+
+static int blk_crypto_keyslot_program(void *priv, const u8 *key,
+				      enum blk_crypto_mode_num crypto_mode,
+				      unsigned int data_unit_size,
+				      unsigned int slot)
+{
+	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
+	const struct blk_crypto_mode *mode = &blk_crypto_modes[crypto_mode];
+	size_t keysize = mode->keysize;
+	int err;
+
+	if (crypto_mode != slotp->crypto_mode &&
+	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID) {
+		evict_keyslot(slot);
+	}
+
+	if (!slotp->tfms[crypto_mode])
+		return -ENOMEM;
+	slotp->crypto_mode = crypto_mode;
+	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], key, keysize);
+
+	if (err) {
+		evict_keyslot(slot);
+		return err;
+	}
+
+	memcpy(slotp->key, key, keysize);
+
+	return 0;
+}
+
+static int blk_crypto_keyslot_evict(void *priv, const u8 *key,
+				    enum blk_crypto_mode_num crypto_mode,
+				    unsigned int data_unit_size,
+				    unsigned int slot)
+{
+	evict_keyslot(slot);
+	return 0;
+}
+
+static int blk_crypto_keyslot_find(void *priv,
+				   const u8 *key,
+				   enum blk_crypto_mode_num crypto_mode,
+				   unsigned int data_unit_size_bytes)
+{
+	int slot;
+	const size_t keysize = blk_crypto_modes[crypto_mode].keysize;
+
+	for (slot = 0; slot < blk_crypto_num_keyslots; slot++) {
+		if (blk_crypto_keyslots[slot].crypto_mode == crypto_mode &&
+		    !crypto_memneq(blk_crypto_keyslots[slot].key, key, keysize))
+			return slot;
+	}
+
+	return -ENOKEY;
+}
+
+static bool blk_crypto_mode_supported(void *priv,
+				      enum blk_crypto_mode_num crypt_mode,
+				      unsigned int data_unit_size)
+{
+	/* All blk_crypto_modes are required to have a crypto API fallback. */
+	return true;
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
+	.keyslot_find		= blk_crypto_keyslot_find,
+	.crypto_mode_supported	= blk_crypto_mode_supported,
+};
+
+static void blk_crypto_encrypt_endio(struct bio *enc_bio)
+{
+	struct bio *src_bio = enc_bio->bi_private;
+	int i;
+
+	for (i = 0; i < enc_bio->bi_vcnt; i++)
+		mempool_free(enc_bio->bi_io_vec[i].bv_page,
+			     blk_crypto_page_pool);
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
+/* Check that all I/O segments are data unit aligned */
+static int bio_crypt_check_alignment(struct bio *bio)
+{
+	int data_unit_size = 1 << bio->bi_crypt_context->data_unit_size_bits;
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
+static int blk_crypto_alloc_cipher_req(struct bio *src_bio,
+				       struct skcipher_request **ciph_req_ptr,
+				       struct crypto_wait *wait)
+{
+	int slot;
+	struct skcipher_request *ciph_req;
+	struct blk_crypto_keyslot *slotp;
+
+	slot = bio_crypt_get_keyslot(src_bio);
+	slotp = &blk_crypto_keyslots[slot];
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
+	*ciph_req_ptr = ciph_req;
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
+/*
+ * The crypto API fallback's encryption routine.
+ * Allocate a bounce bio for encryption, encrypt the input bio using
+ * crypto API, and replace *bio_ptr with the bounce bio. May split input
+ * bio if it's too large.
+ */
+static int blk_crypto_encrypt_bio(struct bio **bio_ptr)
+{
+	struct bio *src_bio;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	int err = 0;
+	u64 curr_dun;
+	union {
+		__le64 dun;
+		u8 bytes[16];
+	} iv;
+	struct scatterlist src, dst;
+	struct bio *enc_bio;
+	struct bio_vec *enc_bvec;
+	int i, j;
+	int data_unit_size;
+
+	/* Split the bio if it's too big for single page bvec */
+	err = blk_crypto_split_bio_if_needed(bio_ptr);
+	if (err)
+		return err;
+
+	src_bio = *bio_ptr;
+	data_unit_size = 1 << src_bio->bi_crypt_context->data_unit_size_bits;
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
+	err = bio_crypt_ctx_acquire_keyslot(src_bio, blk_crypto_ksm);
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
+	curr_dun = bio_crypt_data_unit_num(src_bio);
+	sg_init_table(&src, 1);
+	sg_init_table(&dst, 1);
+
+	skcipher_request_set_crypt(ciph_req, &src, &dst,
+				   data_unit_size, iv.bytes);
+
+	/* Encrypt each page in the bounce bio */
+	for (i = 0, enc_bvec = enc_bio->bi_io_vec; i < enc_bio->bi_vcnt;
+	     enc_bvec++, i++) {
+		struct page *plaintext_page = enc_bvec->bv_page;
+		struct page *ciphertext_page =
+			mempool_alloc(blk_crypto_page_pool, GFP_NOIO);
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
+			memset(&iv, 0, sizeof(iv));
+			iv.dun = cpu_to_le64(curr_dun);
+
+			err = crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
+					      &wait);
+			if (err) {
+				i++;
+				src_bio->bi_status = BLK_STS_RESOURCE;
+				goto out_free_bounce_pages;
+			}
+			curr_dun++;
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
+			     blk_crypto_page_pool);
+out_free_ciph_req:
+	skcipher_request_free(ciph_req);
+out_release_keyslot:
+	bio_crypt_ctx_release_keyslot(src_bio);
+out_put_enc_bio:
+	if (enc_bio)
+		bio_put(enc_bio);
+
+	return err;
+}
+
+/*
+ * The crypto API fallback's main decryption routine.
+ * Decrypts input bio in place.
+ */
+static void blk_crypto_decrypt_bio(struct work_struct *w)
+{
+	struct work_mem *work_mem =
+		container_of(w, struct work_mem, crypto_work);
+	struct bio *bio = work_mem->bio;
+	struct skcipher_request *ciph_req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	u64 curr_dun;
+	union {
+		__le64 dun;
+		u8 bytes[16];
+	} iv;
+	struct scatterlist sg;
+	int data_unit_size = 1 << bio->bi_crypt_context->data_unit_size_bits;
+	int i;
+	int err;
+
+	/*
+	 * Use the crypto API fallback keyslot manager to get a crypto_skcipher
+	 * for the algorithm and key specified for this bio.
+	 */
+	if (bio_crypt_ctx_acquire_keyslot(bio, blk_crypto_ksm)) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		goto out_no_keyslot;
+	}
+
+	/* and then allocate an skcipher_request for it */
+	err = blk_crypto_alloc_cipher_req(bio, &ciph_req, &wait);
+	if (err)
+		goto out;
+
+	curr_dun = bio_crypt_sw_data_unit_num(bio);
+	sg_init_table(&sg, 1);
+	skcipher_request_set_crypt(ciph_req, &sg, &sg, data_unit_size,
+				   iv.bytes);
+
+	/* Decrypt each segment in the bio */
+	__bio_for_each_segment(bv, bio, iter,
+			       bio->bi_crypt_context->crypt_iter) {
+		struct page *page = bv.bv_page;
+
+		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
+
+		/* Decrypt each data unit in the segment */
+		for (i = 0; i < bv.bv_len; i += data_unit_size) {
+			memset(&iv, 0, sizeof(iv));
+			iv.dun = cpu_to_le64(curr_dun);
+			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
+					    &wait)) {
+				bio->bi_status = BLK_STS_IOERR;
+				goto out;
+			}
+			curr_dun++;
+			sg.offset += data_unit_size;
+		}
+	}
+
+out:
+	skcipher_request_free(ciph_req);
+	bio_crypt_ctx_release_keyslot(bio);
+out_no_keyslot:
+	kmem_cache_free(blk_crypto_work_mem_cache, work_mem);
+	bio_endio(bio);
+}
+
+/* Queue bio for decryption */
+static void blk_crypto_queue_decrypt_bio(struct bio *bio)
+{
+	struct work_mem *work_mem =
+		kmem_cache_zalloc(blk_crypto_work_mem_cache, GFP_ATOMIC);
+
+	if (!work_mem) {
+		bio->bi_status = BLK_STS_RESOURCE;
+		bio_endio(bio);
+		return;
+	}
+
+	INIT_WORK(&work_mem->crypto_work, blk_crypto_decrypt_bio);
+	work_mem->bio = bio;
+	queue_work(blk_crypto_wq, &work_mem->crypto_work);
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
+	int err;
+	struct bio_crypt_ctx *crypt_ctx;
+
+	if (!bio_has_crypt_ctx(bio) || !bio_has_data(bio))
+		return 0;
+
+	/*
+	 * When a read bio is marked for sw decryption, its bi_iter is saved
+	 * so that when we decrypt the bio later, we know what part of it was
+	 * marked for sw decryption (when the bio is passed down after
+	 * blk_crypto_submit bio, it may be split or advanced so we cannot rely
+	 * on the bi_iter while decrypting in blk_crypto_endio)
+	 */
+	if (bio_crypt_swhandled(bio))
+		return 0;
+
+	err = bio_crypt_check_alignment(bio);
+	if (err) {
+		bio->bi_status = BLK_STS_IOERR;
+		goto out;
+	}
+
+	crypt_ctx = bio->bi_crypt_context;
+	q = bio->bi_disk->queue;
+
+	if (bio_crypt_has_keyslot(bio)) {
+		/* Key already programmed into device? */
+		if (q->ksm == crypt_ctx->processing_ksm)
+			return 0;
+
+		/* Nope, release the existing keyslot. */
+		bio_crypt_ctx_release_keyslot(bio);
+	}
+
+	/* Get device keyslot if supported */
+	if (q->ksm) {
+		err = bio_crypt_ctx_acquire_keyslot(bio, q->ksm);
+		if (!err)
+			return 0;
+
+		pr_warn_once("Failed to acquire keyslot for %s (err=%d).  Falling back to crypto API.\n",
+			     bio->bi_disk->disk_name, err);
+	}
+
+	/* Fallback to crypto API */
+	if (!READ_ONCE(tfms_inited[bio->bi_crypt_context->crypto_mode])) {
+		err = -EIO;
+		bio->bi_status = BLK_STS_IOERR;
+		goto out;
+	}
+
+	if (bio_data_dir(bio) == WRITE) {
+		/* Encrypt the data now */
+		err = blk_crypto_encrypt_bio(bio_ptr);
+		if (err)
+			goto out;
+	} else {
+		/* Mark bio as swhandled */
+		bio->bi_crypt_context->processing_ksm = blk_crypto_ksm;
+		bio->bi_crypt_context->crypt_iter = bio->bi_iter;
+		bio->bi_crypt_context->sw_data_unit_num =
+				bio->bi_crypt_context->data_unit_num;
+	}
+	return 0;
+out:
+	bio_endio(*bio_ptr);
+	return err;
+}
+
+/**
+ * blk_crypto_endio - clean up bio w.r.t inline encryption during bio_endio
+ *
+ * @bio - the bio to clean up
+ *
+ * If blk_crypto_submit_bio decided to fallback to crypto API for this
+ * bio, we queue the bio for decryption into a workqueue and return false,
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
+	if (!bio_has_crypt_ctx(bio))
+		return true;
+
+	if (bio_crypt_swhandled(bio)) {
+		/*
+		 * The only bios that are swhandled when they reach here
+		 * are those with bio_data_dir(bio) == READ, since WRITE
+		 * bios that are encrypted by the crypto API fallback are
+		 * handled by blk_crypto_encrypt_endio.
+		 */
+
+		/* If there was an IO error, don't decrypt. */
+		if (bio->bi_status)
+			return true;
+
+		blk_crypto_queue_decrypt_bio(bio);
+		return false;
+	}
+
+	if (bio_crypt_has_keyslot(bio))
+		bio_crypt_ctx_release_keyslot(bio);
+
+	return true;
+}
+
+/**
+ * blk_crypto_start_using_mode() - Allocate skciphers for a
+ *				   mode_num for all keyslots
+ * @mode_num - the blk_crypto_mode we want to allocate ciphers for.
+ *
+ * Upper layers (filesystems) should call this function to ensure that a
+ * the crypto API fallback has transforms for this algorithm, if they become
+ * necessary.
+ *
+ * Return: 0 on success and -err on error.
+ */
+int blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+				unsigned int data_unit_size,
+				struct request_queue *q)
+{
+	struct blk_crypto_keyslot *slotp;
+	int err = 0;
+	int i;
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
+						  data_unit_size)) {
+		return 0;
+	}
+
+	mutex_lock(&tfms_lock[mode_num]);
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
+	mutex_unlock(&tfms_lock[mode_num]);
+	return err;
+}
+EXPORT_SYMBOL(blk_crypto_start_using_mode);
+
+/**
+ * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
+ *			    it may have been programmed into
+ * @q - The request queue who's keyslot manager this key might have been
+ *	programmed into
+ * @key - The key to evict
+ * @mode - The blk_crypto_mode_num used with this key
+ * @data_unit_size - The data unit size used with this key
+ *
+ * Upper layers (filesystems) should call this function to ensure that a key
+ * is evicted from hardware that it might have been programmed into. This
+ * will call keyslot_manager_evict_key on the queue's keyslot manager, if one
+ * exists, and supports the crypto algorithm with the specified data unit size.
+ * Otherwise, it will evict the key from the blk_crypto_ksm.
+ *
+ * Return: 0 on success, -err on error.
+ */
+int blk_crypto_evict_key(struct request_queue *q, const u8 *key,
+			 enum blk_crypto_mode_num mode,
+			 unsigned int data_unit_size)
+{
+	struct keyslot_manager *ksm = blk_crypto_ksm;
+
+	if (q && q->ksm && keyslot_manager_crypto_mode_supported(q->ksm, mode,
+							    data_unit_size)) {
+		ksm = q->ksm;
+	}
+
+	return keyslot_manager_evict_key(ksm, key, mode, data_unit_size);
+}
+EXPORT_SYMBOL(blk_crypto_evict_key);
+
+int __init blk_crypto_init(void)
+{
+	int i;
+	int err = -ENOMEM;
+
+	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
+
+	blk_crypto_ksm = keyslot_manager_create(blk_crypto_num_keyslots,
+						&blk_crypto_ksm_ll_ops,
+						NULL);
+	if (!blk_crypto_ksm)
+		goto out;
+
+	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
+					WQ_UNBOUND | WQ_HIGHPRI |
+					WQ_MEM_RECLAIM,
+					num_online_cpus());
+	if (!blk_crypto_wq)
+		goto out_free_ksm;
+
+	blk_crypto_keyslots = kcalloc(blk_crypto_num_keyslots,
+				      sizeof(*blk_crypto_keyslots),
+				      GFP_KERNEL);
+	if (!blk_crypto_keyslots)
+		goto out_free_workqueue;
+
+	for (i = 0; i < blk_crypto_num_keyslots; i++) {
+		blk_crypto_keyslots[i].crypto_mode =
+						BLK_ENCRYPTION_MODE_INVALID;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(blk_crypto_modes); i++)
+		mutex_init(&tfms_lock[i]);
+
+	blk_crypto_page_pool =
+		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
+	if (!blk_crypto_page_pool)
+		goto out_free_keyslots;
+
+	blk_crypto_work_mem_cache = KMEM_CACHE(work_mem, SLAB_RECLAIM_ACCOUNT);
+	if (!blk_crypto_work_mem_cache)
+		goto out_free_page_pool;
+
+	return 0;
+
+out_free_page_pool:
+	mempool_destroy(blk_crypto_page_pool);
+	blk_crypto_page_pool = NULL;
+out_free_keyslots:
+	kzfree(blk_crypto_keyslots);
+	blk_crypto_keyslots = NULL;
+out_free_workqueue:
+	destroy_workqueue(blk_crypto_wq);
+	blk_crypto_wq = NULL;
+out_free_ksm:
+	keyslot_manager_destroy(blk_crypto_ksm);
+	blk_crypto_ksm = NULL;
+out:
+	pr_warn("No memory for blk-crypto crypto API fallback.");
+	return err;
+}
diff --git a/include/linux/bio-crypt-ctx.h b/include/linux/bio-crypt-ctx.h
index 5cd569f77c31..7c389f310bab 100644
--- a/include/linux/bio-crypt-ctx.h
+++ b/include/linux/bio-crypt-ctx.h
@@ -53,6 +53,8 @@ static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
 	}
 }
 
+extern bool bio_crypt_swhandled(struct bio *bio);
+
 static inline bool bio_crypt_has_keyslot(struct bio *bio)
 {
 	return bio->bi_crypt_context->keyslot >= 0;
@@ -170,6 +172,11 @@ static inline void bio_crypt_set_ctx(struct bio *bio,
 				     unsigned int dun_bits,
 				     gfp_t gfp_mask) { }
 
+static inline bool bio_crypt_swhandled(struct bio *bio)
+{
+	return false;
+}
+
 static inline void bio_set_data_unit_num(struct bio *bio, u64 dun) { }
 
 static inline bool bio_crypt_has_keyslot(struct bio *bio)
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
new file mode 100644
index 000000000000..2a07401244a6
--- /dev/null
+++ b/include/linux/blk-crypto.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_H
+#define __LINUX_BLK_CRYPTO_H
+
+#include <linux/types.h>
+#include <linux/bio.h>
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+int blk_crypto_init(void);
+
+int blk_crypto_submit_bio(struct bio **bio_ptr);
+
+bool blk_crypto_endio(struct bio *bio);
+
+int blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+				unsigned int data_unit_size,
+				struct request_queue *q);
+
+int blk_crypto_evict_key(struct request_queue *q, const u8 *key,
+			 enum blk_crypto_mode_num mode,
+			 unsigned int data_unit_size);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline int blk_crypto_init(void)
+{
+	return 0;
+}
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
+static inline int
+blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
+			    unsigned int data_unit_size,
+			    struct request_queue *q)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int blk_crypto_evict_key(struct request_queue *q, const u8 *key,
+				       enum blk_crypto_mode_num mode,
+				       unsigned int data_unit_size)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#endif /* __LINUX_BLK_CRYPTO_H */
-- 
2.24.0.rc0.303.g954a862665-goog

