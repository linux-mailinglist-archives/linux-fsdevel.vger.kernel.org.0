Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF736803
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 01:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFEX24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 19:28:56 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54469 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfFEX24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:28:56 -0400
Received: by mail-qt1-f202.google.com with SMTP id r57so416152qtj.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=zlpr7FV7n4P+etjz80QPzBchcvy1X99YPGazX6truUg=;
        b=CQ5sjo5ube1ZJtqhv+MyIZaKfb8BjwlGLmmUereBxRwTD8m5zbIft+cen/TJlCuugi
         UEBfXh/8o0zQRf1KrHDBktYw/D0MRkZSw3owIxnWrIoULRwaTpQxrAzUamauUi2J9mi6
         0Vwp14+h2IcvOdCPc1s/9+mxPXX+GwaNkP293biA364h78PW85HCNDXIe4jvc8pnuAol
         IZE7Om3iIOw4lUXrakeb17uJHNNI1vjqFRGOJAS3RPs/VaWfIeCQQ0GRRmvJRZOMzUpt
         ZI0h166WnPcpVAic0ZwO279hd+TqssetrN7ETGp9ps+LLRIxAa1KabTGmFHpUrgFjDcy
         wHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zlpr7FV7n4P+etjz80QPzBchcvy1X99YPGazX6truUg=;
        b=Rh1K8Pqu39kZLPUPr6XuSk6cNjOrwPxiAeTd93xgZijsjbtqXc+8yZfmeeWRFlFGBB
         XxYtTNWTUr3GBGB3XdFdaiR9IS9I/WsI3nUIb7doSXjzYUGyY6G1VaW5Amke0rLz33uX
         dwEd7FYlosoFKJ3kcNx7PjLer2guf0lIdYZDgQeXcokdti3KZEZvTnKirZ66vapx/Lbl
         DZ96Z0pj1WAZFMfsdEkmi5mAPOQn0gujUzrdg/MzfolTTNJxLoyUDTLPiLcJqanvqhw5
         fTlUUCds+sJjUeSxw7qd+gLJBbOmafegf5v6hPosmABUTbGgUWVwcRmVV2ighGLzmb2G
         Cp1A==
X-Gm-Message-State: APjAAAVdde/hVl8Wz0fs/7oUAF9d0lsDeqr9792zs9clcd5n+KTVHPxK
        LR5hNCQVCoxojrMVp0ZNLJhn9Dm4jv8=
X-Google-Smtp-Source: APXvYqyv++D+9KtngIi0FGLsk/ZdWaxROeZlSbZQsFvj8c9zB7m6E8rS3cLvcSfPMfvWCeqNW8ANubEzP6U=
X-Received: by 2002:ac8:33d1:: with SMTP id d17mr16860068qtb.327.1559777334234;
 Wed, 05 Jun 2019 16:28:54 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:32 -0700
In-Reply-To: <20190605232837.31545-1-satyat@google.com>
Message-Id: <20190605232837.31545-4-satyat@google.com>
Mime-Version: 1.0
References: <20190605232837.31545-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 3/8] block: blk-crypto for Inline Encryption
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
Content-Transfer-Encoding: quoted-printable
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
For more details, refer to Documentation/block/blk-crypto.txt.

Known issues:
1) We're allocating crypto_skcipher in blk_crypto_keyslot_program, which
   uses GFP_KERNEL to allocate memory, but this function is on the write
   path for IO - we need to add support for specifying a different flags
   to the crypto API.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/block/blk-crypto.txt | 185 ++++++++++
 block/Kconfig                      |   8 +
 block/Makefile                     |   2 +
 block/bio.c                        |   5 +
 block/blk-core.c                   |  11 +-
 block/blk-crypto.c                 | 558 +++++++++++++++++++++++++++++
 include/linux/blk-crypto.h         |  40 +++
 7 files changed, 808 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/block/blk-crypto.txt
 create mode 100644 block/blk-crypto.c
 create mode 100644 include/linux/blk-crypto.h

diff --git a/Documentation/block/blk-crypto.txt b/Documentation/block/blk-c=
rypto.txt
new file mode 100644
index 000000000000..96a7983a117d
--- /dev/null
+++ b/Documentation/block/blk-crypto.txt
@@ -0,0 +1,185 @@
+BLK-CRYPTO and KEYSLOT MANAGER
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+CONTENTS
+1. Objective
+2. Constraints and notes
+3. Design
+4. Blk-crypto
+ 4-1 What does blk-crypto do on bio submission
+5. Layered Devices
+6. Future optimizations for layered devices
+
+1. Objective
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+We want to support inline encryption (IE) in the kernel.
+To allow for testing, we also want a software fallback when actual
+IE hardware is absent. We also want IE to work with layered devices
+like dm and loopback (i.e. we want to be able to use the IE hardware
+of the underlying devices if present, or else fall back to software
+en/decryption).
+
+
+2. Constraints and notes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+1) IE hardware have a limited number of =E2=80=9Ckeyslots=E2=80=9D that ca=
n be programmed
+with an encryption context (key, algorithm, data unit size, etc.) at any t=
ime.
+One can specify a keyslot in a data request made to the device, and the
+device will en/decrypt the data using the encryption context programmed in=
to
+that specified keyslot. When possible, we want to make multiple requests w=
ith
+the same encryption context share the same keyslot.
+
+2) We need a way for filesystems to specify an encryption context to use f=
or
+en/decrypting a struct bio, and a device driver (like UFS) needs to be abl=
e
+to use that encryption context when it processes the bio.
+
+3) We need a way for device drivers to expose their capabilities in a unif=
ied
+way to the upper layers.
+
+
+3. Design
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+We add a struct bio_crypt_context to struct bio that can represent an
+encryption context, because we need to able to pass this encryption contex=
t
+from the FS layer to the device driver to act upon.
+
+While IE hardware works on the notion of keyslots, the FS layer has no
+knowledge of keyslots - it simply wants to specify an encryption context t=
o
+use while en/decrypting a bio.
+
+We introduce a keyslot manager (KSM) that handles the translation from
+encryption contexts specified by the FS to keyslots on the IE hardware.
+This KSM also serves as the way IE hardware can expose their capabilities =
to
+upper layers. The generic mode of operation is: each device driver that wa=
nts
+to support IE will construct a KSM and set it up in its struct request_que=
ue.
+Upper layers that want to use IE on this device can then use this KSM in
+the device=E2=80=99s struct request_queue to translate an encryption conte=
xt into
+a keyslot. The presence of the KSM in the request queue shall be used to m=
ean
+that the device supports IE.
+
+On the device driver end of the interface, the device driver needs to tell=
 the
+KSM how to actually manipulate the IE hardware in the device to do things =
like
+programming the crypto key into the IE hardware into a particular keyslot.=
 All
+this is achieved through the struct keyslot_mgmt_ll_ops that the device dr=
iver
+passes to the KSM when creating it.
+
+It uses refcounts to track which keyslots are idle (either they have no
+encryption context programmed, or there are no in flight struct bios
+referencing that keyslot). When a new encryption context needs a keyslot, =
it
+tries to find a keyslot that has already been programmed with the same
+encryption context, and if there is no such keyslot, it evicts the least
+recently used idle keyslot and programs the new encryption context into th=
at
+one. If no idle keyslots are available, then the caller will sleep until t=
here
+is at least one.
+
+
+4. Blk-crypto
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The above is sufficient for simple cases, but does not work if there is a
+need for a software fallback, or if we are want to use IE with layered dev=
ices.
+To these ends, we introduce blk-crypto. Blk-crypto allows us to present a
+unified view of encryption to the FS (so FS only needs to specify an
+encryption context and not worry about keyslots at all), and blk-crypto ca=
n
+decide whether to delegate the en/decryption to IE hardware or to software
+(i.e. to the kernel crypto API). Blk-crypto maintains an internal KSM that
+serves as the software fallback to the kernel crypto API.
+
+Blk-crypto needs to ensure that the encryption context is programmed into =
the
+"correct" keyslot manager for IE. If a bio is submitted to a layered devic=
e
+that eventually passes the bio down to a device that really does support I=
E, we
+want the encryption context to be programmed into a keyslot for the KSM of=
 the
+device with IE support. However, blk-crypto does not know a priori whether=
 a
+particular device is the final device in the layering structure for a bio =
or
+not. So in the case that a particular device does not support IE, since it=
 is
+possibly the final destination device for the bio, if the bio requires
+encryption (i.e. the bio is doing a write operation), blk-crypto must fall=
back
+to software *before* sending the bio to the device.
+
+Blk-crypto ensures that
+1) The bio=E2=80=99s encryption context is programmed into a keyslot in th=
e KSM of the
+request queue that the bio is being submitted to (or the software fallback=
 KSM
+if the request queue doesn=E2=80=99t have a KSM), and that the processing_=
ksm in the
+bi_crypt_context is set to this KSM
+
+2) That the bio has its own individual reference to the keyslot in this KS=
M.
+Once the bio passes through blk-crypto, its encryption context is programm=
ed
+in some KSM. The =E2=80=9Cits own individual reference to the keyslot=E2=
=80=9D ensures that
+keyslots can be released by each bio independently of other bios while ens=
uring
+that the bio has a valid reference to the keyslot when, for e.g., the soft=
ware
+fallback KSM in blk-crypto performs crypto for on the device=E2=80=99s beh=
alf. The
+individual references are ensured by increasing the refcount for the keysl=
ot in
+the processing_ksm when a bio with a programmed encryption context is clon=
ed.
+
+
+4-1. What blk-crypto does on bio submission
+-------------------------------------------
+
+Case 1: blk-crypto is given a bio with only an encryption context that has=
n=E2=80=99t
+been programmed into any keyslot in any KSM (for e.g. a bio from the FS). =
In
+this case, blk-crypto will program the encryption context into the KSM of =
the
+request queue the bio is being submitted to (and if this KSM does not exis=
t,
+then it will program it into blk-crypto=E2=80=99s internal KSM for softwar=
e fallback).
+The KSM that this encryption context was programmed into is stored as the
+processing_ksm in the bio=E2=80=99s bi_crypt_context.
+
+Case 2: blk-crypto is given a bio whose encryption context has already bee=
n
+programmed into a keyslot in the *software fallback KSM*. In this case,
+blk-crypto does nothing; it treats the bio as not having specified an
+encryption context. Note that we cannot do what we will do in Case 3 here
+because we would have already encrypted the bio in software by this point.
+
+Case 3: blk-crypto is given a bio whose encryption context has already bee=
n
+programmed into a keyslot in some KSM (that is *not* the software fallback
+KSM). In this case, blk-crypto first releases that keyslot from that KSM a=
nd
+then treats the bio as in Case 1.
+
+This way, when a device driver is processing a bio, it can be sure that
+the bio=E2=80=99s encryption context has been programmed into some KSM (ei=
ther the
+device driver=E2=80=99s request queue=E2=80=99s KSM, or blk-crypto=E2=80=
=99s software fallback KSM).
+It then simply needs to check if the bio=E2=80=99s processing_ksm is the d=
evice=E2=80=99s
+request queue=E2=80=99s KSM. If so, then it should proceed with IE. If not=
, it should
+simply do nothing with respect to crypto, because some other KSM (perhaps =
the
+blk-crypto software fallback KSM) is handling the en/decryption.
+
+Blk-crypto will release the keyslot that is being held by the bio (and als=
o
+decrypt it if the bio is using the software fallback KSM) once
+bio_remaining_done returns true for the bio.
+
+
+5. Layered Devices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Layered devices that wish to support IE need to create their own keyslot
+manager for their request queue, and expose whatever functionality they ch=
oose.
+When a layered device wants to pass a bio to another layer (either by
+resubmitting the same bio, or by submitting a clone), it doesn=E2=80=99t n=
eed to do
+anything special because the bio (or the clone) will once again pass throu=
gh
+blk-crypto, which will work as described in Case 3. If a layered device wa=
nts
+for some reason to do the IO by itself instead of passing it on to a child
+device, but it also chose to expose IE capabilities by setting up a KSM in=
 its
+request queue, it is then responsible for en/decrypting the data itself. I=
n
+such cases, the device can choose to call the blk-crypto function
+blk_crypto_fallback_to_software (TODO: Not yet implemented), which will
+cause the en/decryption to be done via software fallback.
+
+
+6. Future Optimizations for layered devices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Creating a keyslot manager for the layered device uses up memory for each
+keyslot, and in general, a layered device (like dm-linear) merely passes t=
he
+request on to a =E2=80=9Cchild=E2=80=9D device, so the keyslots in the lay=
ered device itself
+might be completely unused. We can instead define a new type of KSM; the
+=E2=80=9Cpassthrough KSM=E2=80=9D, that layered devices can use to let blk=
-crypto know that
+this layered device *will* pass the bio to some child device (and hence
+through blk-crypto again, at which point blk-crypto can program the encryp=
tion
+context, instead of programming it into the layered device=E2=80=99s KSM).=
 Again, if
+the device =E2=80=9Clies=E2=80=9D and decides to do the IO itself instead =
of passing it on to
+a child device, it is responsible for doing the en/decryption (and can cho=
ose
+to call blk_crypto_fallback_to_software). Another use case for the
+"passthrough KSM" is for IE devices that want to manage their own keyslots=
/do
+not have a limited number of keyslots.
diff --git a/block/Kconfig b/block/Kconfig
index 1b220101a9cb..0bd4b5060bf8 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -163,6 +163,14 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
=20
+config BLK_INLINE_ENCRYPTION
+	bool "Enable inline encryption support in block layer"
+	help
+	  Build the blk-crypto subsystem.
+	  Enabling this lets the block layer handle encryption,
+	  so users can take advantage of inline encryption
+	  hardware if present.
+
 menu "Partition Types"
=20
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index eee1b4ceecf9..5d38ea437937 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -35,3 +35,5 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+=3D blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+=3D blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+=3D sed-opal.o
 obj-$(CONFIG_BLK_PM)		+=3D blk-pm.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+=3D blk-crypt-ctx.o blk-crypto.o \
+					     keyslot-manager.o
diff --git a/block/bio.c b/block/bio.c
index 87aa87288b39..711b026d5159 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/keyslot-manager.h>
+#include <linux/blk-crypto.h>
=20
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1829,6 +1830,10 @@ void bio_endio(struct bio *bio)
 again:
 	if (!bio_remaining_done(bio))
 		return;
+
+	if (!blk_crypto_endio(bio))
+		return;
+
 	if (!bio_integrity_endio(bio))
 		return;
=20
diff --git a/block/blk-core.c b/block/blk-core.c
index ee1b35fe8572..1892c3904b8c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -36,6 +36,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
+#include <linux/blk-crypto.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1005,7 +1006,9 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] =3D bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret =3D q->make_request_fn(q, bio);
+
+			if (!blk_crypto_submit_bio(&bio))
+				ret =3D q->make_request_fn(q, bio);
=20
 			blk_queue_exit(q);
=20
@@ -1058,6 +1061,9 @@ blk_qc_t direct_make_request(struct bio *bio)
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
=20
+	if (blk_crypto_submit_bio(&bio))
+		return BLK_QC_T_NONE;
+
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
 			bio->bi_status =3D BLK_STS_AGAIN;
@@ -1737,5 +1743,8 @@ int __init blk_dev_init(void)
 	blk_debugfs_root =3D debugfs_create_dir("block", NULL);
 #endif
=20
+	if (blk_crypto_init() < 0)
+		panic("Failed to init blk-crypto\n");
+
 	return 0;
 }
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 000000000000..5adb5251ae7e
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+#include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
+#include <linux/mempool.h>
+#include <linux/blk-cgroup.h>
+#include <crypto/skcipher.h>
+#include <crypto/algapi.h>
+
+struct blk_crypt_mode {
+	const char *friendly_name;
+	const char *cipher_str;
+	size_t keysize;
+	size_t ivsize;
+	bool needs_essiv;
+};
+
+static const struct blk_crypt_mode blk_crypt_modes[] =3D {
+	[BLK_ENCRYPTION_MODE_AES_256_XTS] =3D {
+		.friendly_name =3D "AES-256-XTS",
+		.cipher_str =3D "xts(aes)",
+		.keysize =3D 64,
+		.ivsize =3D 16,
+	},
+	/* TODO: the rest of the algs that fscrypt supports */
+};
+
+#define BLK_CRYPTO_MAX_KEY_SIZE 64
+/* TODO: Do we want to make this user configurable somehow? */
+#define BLK_CRYPTO_NUM_KEYSLOTS 100
+
+static struct blk_crypto_keyslot {
+	struct crypto_skcipher *tfm;
+	enum blk_crypt_mode_num crypt_mode;
+	u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
+} *blk_crypto_keyslots;
+
+struct work_mem {
+	struct work_struct crypto_work;
+	struct bio *bio;
+};
+
+static struct keyslot_manager *blk_crypto_ksm;
+static struct workqueue_struct *blk_crypto_wq;
+static mempool_t *blk_crypto_page_pool;
+static struct kmem_cache *blk_crypto_work_mem_cache;
+
+static unsigned int num_prealloc_bounce_pg =3D 32;
+
+bool bio_crypt_swhandled(struct bio *bio)
+{
+	return bio_crypt_has_keyslot(bio) &&
+	       bio->bi_crypt_context->processing_ksm =3D=3D blk_crypto_ksm;
+}
+
+/* TODO: handle modes that need essiv */
+static int blk_crypto_keyslot_program(void *priv, const u8 *key,
+				      enum blk_crypt_mode_num crypt_mode,
+				      unsigned int data_unit_size,
+				      unsigned int slot)
+{
+	struct blk_crypto_keyslot *slotp =3D &blk_crypto_keyslots[slot];
+	struct crypto_skcipher *tfm =3D slotp->tfm;
+	const struct blk_crypt_mode *mode =3D &blk_crypt_modes[crypt_mode];
+	size_t keysize =3D mode->keysize;
+	int err;
+
+	if (crypt_mode !=3D slotp->crypt_mode || !tfm) {
+		crypto_free_skcipher(slotp->tfm);
+		slotp->tfm =3D NULL;
+		memset(slotp->key, 0, BLK_CRYPTO_MAX_KEY_SIZE);
+		tfm =3D crypto_alloc_skcipher(
+			mode->cipher_str, 0, 0);
+		if (IS_ERR(tfm))
+			return PTR_ERR(tfm);
+
+		crypto_skcipher_set_flags(tfm,
+					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+		slotp->crypt_mode =3D crypt_mode;
+		slotp->tfm =3D tfm;
+	}
+
+
+	err =3D crypto_skcipher_setkey(tfm, key, keysize);
+
+	if (err) {
+		crypto_free_skcipher(tfm);
+		slotp->tfm =3D NULL;
+		return err;
+	}
+
+	memcpy(slotp->key, key, keysize);
+
+	return 0;
+}
+
+static int blk_crypto_keyslot_evict(void *priv, const u8 *key,
+				    enum blk_crypt_mode_num crypt_mode,
+				    unsigned int data_unit_size,
+				    unsigned int slot)
+{
+	crypto_free_skcipher(blk_crypto_keyslots[slot].tfm);
+	blk_crypto_keyslots[slot].tfm =3D NULL;
+	memset(blk_crypto_keyslots[slot].key, 0, BLK_CRYPTO_MAX_KEY_SIZE);
+
+	return 0;
+}
+
+static int blk_crypto_keyslot_find(void *priv,
+				   const u8 *key,
+				   enum blk_crypt_mode_num crypt_mode,
+				   unsigned int data_unit_size_bytes)
+{
+	int slot;
+	const size_t keysize =3D blk_crypt_modes[crypt_mode].keysize;
+
+	/* TODO: hashmap? */
+	for (slot =3D 0; slot < BLK_CRYPTO_NUM_KEYSLOTS; slot++) {
+		if (blk_crypto_keyslots[slot].crypt_mode =3D=3D crypt_mode &&
+		    !crypto_memneq(blk_crypto_keyslots[slot].key, key,
+				   keysize)) {
+			return slot;
+		}
+	}
+
+	return -ENOKEY;
+}
+
+static bool blk_crypt_mode_supported(void *priv,
+				     enum blk_crypt_mode_num crypt_mode,
+				     unsigned int data_unit_size)
+{
+	// Of course, blk-crypto supports all blk_crypt_modes.
+	return true;
+}
+
+static const struct keyslot_mgmt_ll_ops blk_crypto_ksm_ll_ops =3D {
+	.keyslot_program	=3D blk_crypto_keyslot_program,
+	.keyslot_evict		=3D blk_crypto_keyslot_evict,
+	.keyslot_find		=3D blk_crypto_keyslot_find,
+	.crypt_mode_supported	=3D blk_crypt_mode_supported,
+};
+
+static void blk_crypto_put_keyslot(struct bio *bio)
+{
+	struct bio_crypt_ctx *crypt_ctx =3D bio->bi_crypt_context;
+
+	keyslot_manager_put_slot(crypt_ctx->processing_ksm, crypt_ctx->keyslot);
+	bio_crypt_unset_keyslot(bio);
+}
+
+static int blk_crypto_get_keyslot(struct bio *bio,
+				      struct keyslot_manager *ksm)
+{
+	int slot;
+	enum blk_crypt_mode_num crypt_mode =3D bio_crypt_mode(bio);
+
+	if (!ksm)
+		return -ENOMEM;
+
+	slot =3D keyslot_manager_get_slot_for_key(ksm,
+						bio_crypt_raw_key(bio),
+						crypt_mode, PAGE_SIZE);
+	if (slot < 0)
+		return slot;
+
+	bio_crypt_set_keyslot(bio, slot, ksm);
+	return 0;
+}
+
+static void blk_crypto_encrypt_endio(struct bio *enc_bio)
+{
+	struct bio *src_bio =3D enc_bio->bi_private;
+	struct bio_vec *enc_bvec, *enc_bvec_end;
+
+	enc_bvec =3D enc_bio->bi_io_vec;
+	enc_bvec_end =3D enc_bvec + enc_bio->bi_vcnt;
+	for (; enc_bvec !=3D enc_bvec_end; enc_bvec++)
+		mempool_free(enc_bvec->bv_page, blk_crypto_page_pool);
+
+	src_bio->bi_status =3D enc_bio->bi_status;
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
+	bio =3D bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
+	if (!bio)
+		return NULL;
+	bio->bi_disk		=3D bio_src->bi_disk;
+	bio->bi_opf		=3D bio_src->bi_opf;
+	bio->bi_ioprio		=3D bio_src->bi_ioprio;
+	bio->bi_write_hint	=3D bio_src->bi_write_hint;
+	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
+	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
+
+	bio_for_each_segment(bv, bio_src, iter)
+		bio->bi_io_vec[bio->bi_vcnt++] =3D bv;
+
+	if (bio_integrity(bio_src)) {
+		int ret;
+
+		ret =3D bio_integrity_clone(bio, bio_src, GFP_NOIO);
+		if (ret < 0) {
+			bio_put(bio);
+			return NULL;
+		}
+	}
+
+	bio_clone_blkg_association(bio, bio_src);
+	blkcg_bio_issue_init(bio);
+
+	return bio;
+}
+
+static int blk_crypto_encrypt_bio(struct bio **bio_ptr)
+{
+	struct bio *src_bio =3D *bio_ptr;
+	int slot;
+	struct skcipher_request *ciph_req =3D NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	int err =3D 0;
+	u64 curr_dun;
+	union {
+		__le64 dun;
+		u8 bytes[16];
+	} iv;
+	struct scatterlist src, dst;
+	struct bio *enc_bio;
+	struct bio_vec *enc_bvec;
+	int i, j;
+	unsigned int num_sectors;
+
+	if (!blk_crypto_keyslots)
+		return -ENOMEM;
+
+	/* Split the bio if it's too big for single page bvec */
+	i =3D 0;
+	num_sectors =3D 0;
+	bio_for_each_segment(bv, src_bio, iter) {
+		num_sectors +=3D bv.bv_len >> 9;
+		if (++i =3D=3D BIO_MAX_PAGES)
+			break;
+	}
+	if (num_sectors < bio_sectors(src_bio)) {
+		struct bio *split_bio;
+
+		split_bio =3D bio_split(src_bio, num_sectors, GFP_NOIO, NULL);
+		if (!split_bio) {
+			src_bio->bi_status =3D BLK_STS_RESOURCE;
+			return -ENOMEM;
+		}
+		bio_chain(split_bio, src_bio);
+		generic_make_request(src_bio);
+		*bio_ptr =3D split_bio;
+	}
+
+	src_bio =3D *bio_ptr;
+
+	enc_bio =3D blk_crypto_clone_bio(src_bio);
+	if (!enc_bio) {
+		src_bio->bi_status =3D BLK_STS_RESOURCE;
+		return -ENOMEM;
+	}
+
+	err =3D blk_crypto_get_keyslot(src_bio, blk_crypto_ksm);
+	if (err) {
+		src_bio->bi_status =3D BLK_STS_IOERR;
+		bio_put(enc_bio);
+		return err;
+	}
+	slot =3D bio_crypt_get_slot(src_bio);
+
+	ciph_req =3D skcipher_request_alloc(blk_crypto_keyslots[slot].tfm,
+					  GFP_NOIO);
+	if (!ciph_req) {
+		src_bio->bi_status =3D BLK_STS_RESOURCE;
+		err =3D -ENOMEM;
+		bio_put(enc_bio);
+		goto out_release_keyslot;
+	}
+
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
+
+	curr_dun =3D bio_crypt_sw_data_unit_num(src_bio);
+	sg_init_table(&src, 1);
+	sg_init_table(&dst, 1);
+	for (i =3D 0, enc_bvec =3D enc_bio->bi_io_vec; i < enc_bio->bi_vcnt;
+	     enc_bvec++, i++) {
+		struct page *page =3D enc_bvec->bv_page;
+		struct page *ciphertext_page =3D
+			mempool_alloc(blk_crypto_page_pool, GFP_NOFS);
+
+		enc_bvec->bv_page =3D ciphertext_page;
+
+		if (!ciphertext_page)
+			goto no_mem_for_ciph_page;
+
+		memset(&iv, 0, sizeof(iv));
+		iv.dun =3D cpu_to_le64(curr_dun);
+
+		sg_set_page(&src, page, enc_bvec->bv_len, enc_bvec->bv_offset);
+		sg_set_page(&dst, ciphertext_page, enc_bvec->bv_len,
+			    enc_bvec->bv_offset);
+
+		skcipher_request_set_crypt(ciph_req, &src, &dst,
+					   enc_bvec->bv_len, iv.bytes);
+		err =3D crypto_wait_req(crypto_skcipher_encrypt(ciph_req), &wait);
+		if (err)
+			goto no_mem_for_ciph_page;
+
+		curr_dun++;
+		continue;
+no_mem_for_ciph_page:
+		err =3D -ENOMEM;
+		for (j =3D i - 1; j >=3D 0; j--) {
+			mempool_free(enc_bio->bi_io_vec->bv_page,
+				     blk_crypto_page_pool);
+		}
+		bio_put(enc_bio);
+		goto out_release_cipher;
+	}
+
+	enc_bio->bi_private =3D src_bio;
+	enc_bio->bi_end_io =3D blk_crypto_encrypt_endio;
+
+	*bio_ptr =3D enc_bio;
+out_release_cipher:
+	skcipher_request_free(ciph_req);
+out_release_keyslot:
+	blk_crypto_put_keyslot(src_bio);
+	return err;
+}
+
+/*
+ * TODO: assumption right now is:
+ * each segment in bio has length =3D=3D the data_unit_size
+ */
+static void blk_crypto_decrypt_bio(struct work_struct *w)
+{
+	struct work_mem *work_mem =3D
+		container_of(w, struct work_mem, crypto_work);
+	struct bio *bio =3D work_mem->bio;
+	int slot =3D bio_crypt_get_slot(bio);
+	struct skcipher_request *ciph_req;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	u64 curr_dun;
+	union {
+		__le64 dun;
+		u8 bytes[16];
+	} iv;
+	struct scatterlist sg;
+
+	curr_dun =3D bio_crypt_sw_data_unit_num(bio);
+
+	kmem_cache_free(blk_crypto_work_mem_cache, work_mem);
+	ciph_req =3D skcipher_request_alloc(blk_crypto_keyslots[slot].tfm,
+					  GFP_NOFS);
+	if (!ciph_req) {
+		bio->bi_status =3D BLK_STS_RESOURCE;
+		goto out;
+	}
+
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
+
+	sg_init_table(&sg, 1);
+	__bio_for_each_segment(bv, bio, iter,
+			       bio->bi_crypt_context->crypt_iter) {
+		struct page *page =3D bv.bv_page;
+		int err;
+
+		memset(&iv, 0, sizeof(iv));
+		iv.dun =3D cpu_to_le64(curr_dun);
+
+		sg_set_page(&sg, page, bv.bv_len, bv.bv_offset);
+		skcipher_request_set_crypt(ciph_req, &sg, &sg,
+					   bv.bv_len, iv.bytes);
+		err =3D crypto_wait_req(crypto_skcipher_decrypt(ciph_req), &wait);
+		if (err) {
+			bio->bi_status =3D BLK_STS_IOERR;
+			goto out;
+		}
+		curr_dun++;
+	}
+
+out:
+	skcipher_request_free(ciph_req);
+	blk_crypto_put_keyslot(bio);
+	bio_endio(bio);
+}
+
+static void blk_crypto_queue_decrypt_bio(struct bio *bio)
+{
+	struct work_mem *work_mem =3D
+		kmem_cache_zalloc(blk_crypto_work_mem_cache, GFP_ATOMIC);
+
+	if (!work_mem) {
+		bio->bi_status =3D BLK_STS_RESOURCE;
+		return bio_endio(bio);
+	}
+
+	INIT_WORK(&work_mem->crypto_work, blk_crypto_decrypt_bio);
+	work_mem->bio =3D bio;
+	queue_work(blk_crypto_wq, &work_mem->crypto_work);
+}
+
+/*
+ * Ensures that:
+ * 1) The bio=E2=80=99s encryption context is programmed into a keyslot in=
 the
+ * keyslot manager (KSM) of the request queue that the bio is being submit=
ted
+ * to (or the software fallback KSM if the request queue doesn=E2=80=99t h=
ave a KSM),
+ * and that the processing_ksm in the bi_crypt_context of this bio is set =
to
+ * this KSM.
+ *
+ * 2) That the bio has a reference to this keyslot in this KSM.
+ */
+int blk_crypto_submit_bio(struct bio **bio_ptr)
+{
+	struct bio *bio =3D *bio_ptr;
+	struct request_queue *q;
+	int err;
+	enum blk_crypt_mode_num crypt_mode;
+	struct bio_crypt_ctx *crypt_ctx;
+
+	if (!bio_has_data(bio))
+		return 0;
+
+	if (!bio_is_encrypted(bio) || bio_crypt_swhandled(bio))
+		return 0;
+
+	crypt_ctx =3D bio->bi_crypt_context;
+	q =3D bio->bi_disk->queue;
+	crypt_mode =3D bio_crypt_mode(bio);
+
+	if (bio_crypt_has_keyslot(bio)) {
+		/* Key already programmed into device? */
+		if (q->ksm =3D=3D crypt_ctx->processing_ksm)
+			return 0;
+
+		/* Nope, release the existing keyslot. */
+		blk_crypto_put_keyslot(bio);
+	}
+
+	/* Get device keyslot if supported */
+	if (q->ksm) {
+		err =3D blk_crypto_get_keyslot(bio, q->ksm);
+		if (!err)
+			return 0;
+	}
+
+	/* Fallback to software crypto */
+	if (bio_data_dir(bio) =3D=3D WRITE) {
+		/* Encrypt the data now */
+		err =3D blk_crypto_encrypt_bio(bio_ptr);
+		if (err)
+			goto out_encrypt_err;
+	} else {
+		err =3D blk_crypto_get_keyslot(bio, blk_crypto_ksm);
+		if (err)
+			goto out_err;
+	}
+	return 0;
+out_err:
+	bio->bi_status =3D BLK_STS_IOERR;
+out_encrypt_err:
+	bio_endio(bio);
+	return err;
+}
+
+/*
+ * If the bio is not en/decrypted in software, this function releases the
+ * reference to the keyslot that blk_crypto_submit_bio got.
+ * If blk_crypto_submit_bio decided to fallback to software crypto for thi=
s
+ * bio, then if the bio is doing a write, we free the allocated bounce pag=
es,
+ * and if the bio is doing a read, we queue the bio for decryption into a
+ * workqueue and return -EAGAIN. After the bio has been decrypted, we rele=
ase
+ * the keyslot before we call bio_endio(bio).
+ */
+bool blk_crypto_endio(struct bio *bio)
+{
+	if (!bio_crypt_has_keyslot(bio))
+		return true;
+
+	if (!bio_crypt_swhandled(bio)) {
+		blk_crypto_put_keyslot(bio);
+		return true;
+	}
+
+	/* bio_data_dir(bio) =3D=3D READ. So decrypt bio */
+	blk_crypto_queue_decrypt_bio(bio);
+	return false;
+}
+
+int __init blk_crypto_init(void)
+{
+	blk_crypto_ksm =3D keyslot_manager_create(BLK_CRYPTO_NUM_KEYSLOTS,
+						&blk_crypto_ksm_ll_ops,
+						NULL);
+	if (!blk_crypto_ksm)
+		goto out_ksm;
+
+	blk_crypto_wq =3D alloc_workqueue("blk_crypto_wq",
+					WQ_UNBOUND | WQ_HIGHPRI,
+					num_online_cpus());
+	if (!blk_crypto_wq)
+		goto out_wq;
+
+	blk_crypto_keyslots =3D kzalloc(sizeof(*blk_crypto_keyslots) *
+				      BLK_CRYPTO_NUM_KEYSLOTS,
+				      GFP_KERNEL);
+	if (!blk_crypto_keyslots)
+		goto out_blk_crypto_keyslots;
+
+	blk_crypto_page_pool =3D
+		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
+	if (!blk_crypto_page_pool)
+		goto out_bounce_pool;
+
+	blk_crypto_work_mem_cache =3D KMEM_CACHE(work_mem, SLAB_RECLAIM_ACCOUNT);
+	if (!blk_crypto_work_mem_cache)
+		goto out_work_mem_cache;
+
+	return 0;
+
+out_work_mem_cache:
+	mempool_destroy(blk_crypto_page_pool);
+	blk_crypto_page_pool =3D NULL;
+out_bounce_pool:
+	kzfree(blk_crypto_keyslots);
+	blk_crypto_keyslots =3D NULL;
+out_blk_crypto_keyslots:
+	destroy_workqueue(blk_crypto_wq);
+	blk_crypto_wq =3D NULL;
+out_wq:
+	keyslot_manager_destroy(blk_crypto_ksm);
+	blk_crypto_ksm =3D NULL;
+out_ksm:
+	pr_warn("No memory for blk-crypto software fallback.");
+	return -ENOMEM;
+}
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
new file mode 100644
index 000000000000..cbb5bea6dcdb
--- /dev/null
+++ b/include/linux/blk-crypto.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_H
+#define __LINUX_BLK_CRYPTO_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+struct bio;
+
+int blk_crypto_init(void);
+
+int blk_crypto_submit_bio(struct bio **bio_ptr);
+
+bool blk_crypto_endio(struct bio *bio);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline int blk_crypto_init(void)
+{
+	return 0;
+}
+
+static inline int blk_crypto_submit_bio(struct bio **bio)
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
+#endif /* __LINUX_BLK_CRYPTO_H */
--=20
2.22.0.rc1.311.g5d7573a151-goog

