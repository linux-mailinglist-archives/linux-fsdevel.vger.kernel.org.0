Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8770015623
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEFWmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 18:42:33 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33094 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEFWmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 18:42:33 -0400
Received: by mail-qk1-f202.google.com with SMTP id t63so16107818qkh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4ZcSxrL1h5PDztEi+CrfoN1N6A+Lu+HcrFRnq1cZqDY=;
        b=uWQb/JHyhlWmotXrhfaH1SEZ9wy6ZKp0wm1NrmaoQSSMXsMyxXq+L/GAyUN4RYqpWZ
         Ac8UTqmRIg73+eUc8PqjLRoIxCDxueSpbZiUT1Zjk7OLV9nZKvbF+7ux6NfVaMp6UPoR
         +/4XYklsVx0OSksn246LSxoaKSmuV63fwXP7ecR+jiou1/EyfzArLP6dl+kuY/xvz9pO
         J91vmybTR16DZVr7lCPjF1i3xeUKVZRLGhvnhUYqEnu8guFI6RtJouGsQlEkBjHXnzDw
         H/McPZxpx1cHgwhk90Md5kDjCzGJG9NJBM/6nRlcXIwNFwZP8lxjPifs9W47Uuk4C7SZ
         DTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4ZcSxrL1h5PDztEi+CrfoN1N6A+Lu+HcrFRnq1cZqDY=;
        b=OYsriJsQzY29LzqFcJfatxvM3AdJVPyOU+Yl3fQL9VqXDfYNBvbeZ1u4TGFqQJ5yUy
         1LckZL6Zhv9nk7t341hr/iFBJu/581aU/p/lgvZmQZQuMm5voXq4X88bPTGrsu7O0dKV
         wsZADrM5ZFAhWQ8XcF8FGzY42nAsQ6RVU9Oxcfuc8mhKqND+YnWEo8ft7NLd324Rr0V/
         DiAlUPc8Kf4IYFLgeQvgzx9oZr6EAk8jTSy4xMoxjGloPTn4z+iFX7oEJFasQpxsifUz
         buke+IwjVWtmLogNlrn9buvZ0uqUzAgo1DkRVR/VIGk6400Ef7vMW6eN4LVb9AC1QuZf
         SZ6w==
X-Gm-Message-State: APjAAAXvcQNBsR57G2WCIeayukF5uJS7Ds6jCrq9GP4NlDOw0GycsVo1
        mvttI+oaUFAYs8KuwrZu/IzHwDeyuX4=
X-Google-Smtp-Source: APXvYqzxU7qZPjMMoqUBmD0svP+WEceEi+urD3vqe+C2X2PSy4xFX1rLiVvDId2I2u0dG9GJQS/6xa8OeTA=
X-Received: by 2002:a37:7b05:: with SMTP id w5mr20811431qkc.354.1557182550683;
 Mon, 06 May 2019 15:42:30 -0700 (PDT)
Date:   Mon,  6 May 2019 15:35:41 -0700
In-Reply-To: <20190506223544.195371-1-satyat@google.com>
Message-Id: <20190506223544.195371-2-satyat@google.com>
Mime-Version: 1.0
References: <20190506223544.195371-1-satyat@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 1/4] block: Block Layer changes for Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

Inline Encryption hardware allows software to specify an encryption context
(an encryption key, crypto algorithm, data unit num, data unit size, etc.)
along with a data transfer request to a storage device, and the inline
encryption hardware will use that context to en/decrypt the data. The
inline encryption hardware is part of the storage device, and it
conceptually sits on the data path between system memory and the storage
device.

To do this, we must have some way of letting a storage device driver know
what encryption context it should use for en/decrypting a request.
However, it's the filesystem/fscrypt that knows about and manages
encryption contexts. As such, when the filesystem layer submits a bio to
the block layer, and this bio eventually reaches a device driver with
support for inline encryption, the device driver will need to know what
the encryption context for that bio is. We want to communicate the
encryption context from the filesystem layer to the storage device along
with the bio, when the bio is submitted to the block layer. To do this, we
add a struct bio_crypt_ctx to struct bio, which can represent an
encryption context (note that we can't use the bi_private field in struct
bio to do this because that field does not function to pass information
across layers in the storage stack).

Inline Encryption hardware implementations often function around the
concept of "keyslots". These implementations often have a limited number
of "keyslots", each of which can hold an encryption context (we say that
an encryption context can be "programmed" into a keyslot). Requests made
to the storage device may have a keyslot associated with them, and the
inline encryption hardware will en/decrypt the data in the requests using
the encryption context programmed into that associated keyslot. As
keyslots are limited, and programming keys may be expensive in many
implementations, and multiple requests may use exactly the same encryption
contexts, we introduce a Keyslot Manager to efficiently manage keyslots.
The keyslot manager also functions as the interface that upper layers will
use to program keys into inline encryption hardware. For more information
on the Keyslot Manager, refer to documentation found in
block/keyslot-manager.c and linux/keyslot-manager.h.

We also want to be able to make use of inline encryption hardware with
layered devices like device mapper. To this end, we introduce blk-crypto.
Blk-crypto delegates crypto operations to inline encryption hardware when
available, and also contains a software fallback to the kernel crypto API.
For more details, refer to Documentation/block/blk-crypto.txt.

Known issues:
1) We are adding a relatively large struct (bio_crypt_ctx) to struct bio
	- we should instead add just a pointer to that struct.
2) Keyslot Manager has a performance bug where the same encryption
   context may be programmed into multiple keyslots at the same time in
   certain situations when all keyslots are being used.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/block/blk-crypto.txt | 185 ++++++++++
 block/Kconfig                      |  16 +
 block/Makefile                     |   3 +
 block/bio.c                        |  45 +++
 block/blk-core.c                   |  14 +-
 block/blk-crypto.c                 | 573 +++++++++++++++++++++++++++++
 block/blk-merge.c                  |  87 ++++-
 block/bounce.c                     |   1 +
 block/keyslot-manager.c            | 314 ++++++++++++++++
 include/linux/bio.h                | 166 +++++++++
 include/linux/blk-crypto.h         |  40 ++
 include/linux/blk_types.h          |  49 +++
 include/linux/blkdev.h             |   9 +
 include/linux/keyslot-manager.h    | 131 +++++++
 14 files changed, 1628 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/block/blk-crypto.txt
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

diff --git a/Documentation/block/blk-crypto.txt b/Documentation/block/blk-c=
rypto.txt
new file mode 100644
index 000000000000..a1b82361cb16
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
+One can specify a keyslot in a data requests made to the device, and when =
the
+device will en/decrypt the data using the encryption context programmed in=
to
+that specified keyslot. Of course, when possible, we want to make multiple
+requests with the the same encryption context share the same keyslot.
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
+encryption context and not worry about keyslots at all), and block crypto =
can
+decide whether to delegate the en/decryption to IE hardware or to software
+(i.e. to the kernel crypto API). Block crypto maintains an internal KSM th=
at
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
+device with IE support. However, blk-crypto does not know a-priori whether=
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
+Once the bio passes through block crypto, its encryption context is progra=
mmed
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
index 028bc085dac8..65213769d2a2 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -187,6 +187,22 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
=20
+config BLK_CRYPT_CTX
+	bool
+
+config BLK_KEYSLOT_MANAGER
+	bool
+
+config BLK_CRYPTO
+	bool "Enable encryption in block layer"
+	select BLK_CRYPT_CTX
+	select BLK_KEYSLOT_MANAGER
+	help
+	Build the blk-crypto subsystem.
+	Enabling this lets the block layer handle encryption,
+	so users can take advantage of inline encryption
+	hardware if present.
+
 menu "Partition Types"
=20
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index eee1b4ceecf9..b265506cdf3a 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -35,3 +35,6 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+=3D blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+=3D blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+=3D sed-opal.o
 obj-$(CONFIG_BLK_PM)		+=3D blk-pm.o
+obj-$(CONFIG_BLK_CRYPTO)	+=3D blk-crypto.o
+
+obj-$(CONFIG_BLK_KEYSLOT_MANAGER) +=3D keyslot-manager.o
diff --git a/block/bio.c b/block/bio.c
index 716510ecd7ff..ef975389ecce 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -29,6 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/keyslot-manager.h>
=20
 #include <trace/events/block.h>
 #include "blk.h"
@@ -271,6 +272,44 @@ static void bio_free(struct bio *bio)
 	}
 }
=20
+#ifdef CONFIG_BLK_CRYPT_CTX
+static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
+{
+	if (bio_is_encrypted(bio)) {
+		bio->bi_crypt_context.data_unit_num +=3D
+			bytes >> bio->bi_crypt_context.data_unit_size_bits;
+	}
+}
+
+void bio_clone_crypt_context(struct bio *dst, struct bio *src)
+{
+	if (bio_crypt_swhandled(src))
+		return;
+	dst->bi_crypt_context =3D src->bi_crypt_context;
+
+	if (!bio_crypt_has_keyslot(src))
+		return;
+
+	/**
+	 * This should always succeed because the src bio should already
+	 * have a reference to the keyslot.
+	 */
+	BUG_ON(!keyslot_manager_get_slot(src->bi_crypt_context.processing_ksm,
+					  src->bi_crypt_context.keyslot));
+}
+
+bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
+{
+	if (!bio_is_encrypted(bio))
+		return false;
+
+	WARN_ON(!bio_crypt_has_keyslot(bio));
+	return q->ksm =3D=3D bio->bi_crypt_context.processing_ksm;
+}
+EXPORT_SYMBOL(bio_crypt_should_process);
+
+#endif /* CONFIG_BLK_CRYPT_CTX */
+
 /*
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
@@ -608,6 +647,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_=
src)
 	bio->bi_write_hint =3D bio_src->bi_write_hint;
 	bio->bi_iter =3D bio_src->bi_iter;
 	bio->bi_io_vec =3D bio_src->bi_io_vec;
+	bio_clone_crypt_context(bio, bio_src);
=20
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
@@ -1006,6 +1046,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 		bio_integrity_advance(bio, bytes);
=20
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
+	bio_crypt_advance(bio, bytes);
 }
 EXPORT_SYMBOL(bio_advance);
=20
@@ -1832,6 +1873,10 @@ void bio_endio(struct bio *bio)
 again:
 	if (!bio_remaining_done(bio))
 		return;
+
+	if (blk_crypto_endio(bio) =3D=3D -EAGAIN)
+		return;
+
 	if (!bio_integrity_endio(bio))
 		return;
=20
diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..3361acbbbe48 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -35,6 +35,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
+#include <linux/blk-crypto.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -524,6 +525,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_m=
ask, int node_id)
=20
 	init_waitqueue_head(&q->mq_freeze_wq);
=20
+#ifdef CONFIG_BLK_KEYSLOT_MANAGER
+	q->ksm =3D NULL;
+#endif
+
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
@@ -1086,7 +1091,9 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] =3D bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret =3D q->make_request_fn(q, bio);
+
+			if (!blk_crypto_submit_bio(&bio))
+				ret =3D q->make_request_fn(q, bio);
=20
 			/* sort new bios into those for a lower level
 			 * and those for the same level
@@ -1139,6 +1146,9 @@ blk_qc_t direct_make_request(struct bio *bio)
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
=20
+	if (blk_crypto_submit_bio(&bio))
+		return BLK_QC_T_NONE;
+
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
 			bio->bi_status =3D BLK_STS_AGAIN;
@@ -1815,5 +1825,7 @@ int __init blk_dev_init(void)
 	blk_debugfs_root =3D debugfs_create_dir("block", NULL);
 #endif
=20
+	blk_crypto_init();
+
 	return 0;
 }
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
new file mode 100644
index 000000000000..503f9e3a770b
--- /dev/null
+++ b/block/blk-crypto.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+#include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
+#include <linux/mempool.h>
+#include <linux/blk-cgroup.h>
+#include <crypto/skcipher.h>
+#include <crypto/aes.h>
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
+	int crypto_alg_id;
+	union {
+		u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
+		u32 key_words[BLK_CRYPTO_MAX_KEY_SIZE/4];
+	};
+} *slot_mem;
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
+/* TODO: handle modes that need essiv */
+static int blk_crypto_keyslot_program(void *priv, const u8 *key,
+			      unsigned int data_unit_size,
+			      unsigned int crypto_alg_id,
+			      unsigned int slot)
+{
+	struct crypto_skcipher *tfm =3D slot_mem[slot].tfm;
+	int err;
+	size_t keysize =3D blk_crypt_modes[crypto_alg_id].keysize;
+
+	if (crypto_alg_id !=3D slot_mem[slot].crypto_alg_id || !tfm) {
+		crypto_free_skcipher(slot_mem[slot].tfm);
+		slot_mem[slot].tfm =3D NULL;
+		slot_mem[slot].crypto_alg_id =3D crypto_alg_id;
+		tfm =3D crypto_alloc_skcipher(
+			blk_crypt_modes[crypto_alg_id].cipher_str, 0, 0);
+		if (IS_ERR(tfm))
+			return PTR_ERR(tfm);
+
+		crypto_skcipher_set_flags(tfm,
+					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+		slot_mem[slot].tfm =3D tfm;
+	}
+
+
+	err =3D crypto_skcipher_setkey(tfm, key, keysize);
+
+	if (err) {
+		crypto_free_skcipher(slot_mem[slot].tfm);
+		slot_mem[slot].tfm =3D NULL;
+		return err;
+	}
+
+	memcpy(slot_mem[slot].key, key, keysize);
+
+	return 0;
+}
+
+static int blk_crypto_keyslot_evict(void *priv, unsigned int slot,
+				    const u8 *key,
+				    unsigned int data_unit_size,
+				    unsigned int crypto_alg_id)
+{
+	crypto_free_skcipher(slot_mem[slot].tfm);
+	slot_mem[slot].tfm =3D NULL;
+	memset(slot_mem[slot].key, 0, BLK_CRYPTO_MAX_KEY_SIZE);
+
+	return 0;
+}
+
+static int blk_crypto_keyslot_find(void *priv,
+				   const u8 *key,
+				   unsigned int data_unit_size_bytes,
+				   unsigned int crypto_alg_id)
+{
+	int slot;
+
+	/* TODO: hashmap? */
+	for (slot =3D 0; slot < BLK_CRYPTO_NUM_KEYSLOTS; slot++) {
+		if (slot_mem[slot].crypto_alg_id =3D=3D crypto_alg_id &&
+		    crypto_memneq(slot_mem[slot].key, key,
+			blk_crypt_modes[crypto_alg_id].keysize) =3D=3D 0) {
+			return slot;
+		}
+	}
+
+	return -ENOKEY;
+}
+
+static int blk_crypto_alg_find(void *priv,
+			       enum blk_crypt_mode_index crypt_mode,
+			       unsigned int data_unit_size)
+{
+	/**
+	 * Blk-crypto supports all data unit sizes, so we can use
+	 * the crypt_mode directly as the internal crypto_alg_id.
+	 * Refer to comment in keyslot_manager.h for details
+	 * on this crypto_alg_id.
+	 */
+	return crypt_mode;
+}
+
+const struct keyslot_mgmt_ll_ops blk_crypto_ksm_ll_ops =3D {
+	.keyslot_program	=3D blk_crypto_keyslot_program,
+	.keyslot_evict		=3D blk_crypto_keyslot_evict,
+	.keyslot_find		=3D blk_crypto_keyslot_find,
+	.crypto_alg_find	=3D blk_crypto_alg_find,
+};
+
+static void blk_crypto_release_keyslot(struct bio *bio)
+{
+	struct bio_crypt_ctx *crypt_ctx =3D &bio->bi_crypt_context;
+
+	keyslot_manager_put_slot(crypt_ctx->processing_ksm,
+				 crypt_ctx->keyslot);
+	bio_crypt_unset_keyslot(bio);
+}
+
+static int blk_crypto_program_keyslot(struct bio *bio,
+				      struct keyslot_manager *ksm)
+{
+	int slot;
+	enum blk_crypt_mode_index crypt_mode =3D bio_crypt_mode(bio);
+
+	slot =3D keyslot_manager_get_slot_for_key(ksm,
+						bio_crypt_raw_key(bio),
+						crypt_mode, PAGE_SIZE);
+	if (slot >=3D 0) {
+		bio_crypt_set_keyslot(bio, slot, ksm);
+		return 0;
+	}
+
+	return slot;
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
+	struct crypto_wait wait;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	int err =3D 0;
+	__le64 curr_dun;
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
+			err =3D -ENOMEM;
+			goto out;
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
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	err =3D blk_crypto_program_keyslot(src_bio, blk_crypto_ksm);
+	if (err) {
+		src_bio->bi_status =3D BLK_STS_IOERR;
+		bio_put(enc_bio);
+		goto out;
+	}
+	bio_crypt_set_swhandled(src_bio);
+	slot =3D bio_crypt_get_slot(src_bio);
+
+	ciph_req =3D skcipher_request_alloc(slot_mem[slot].tfm, GFP_NOFS);
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
+	curr_dun =3D cpu_to_le64(bio_crypt_sw_data_unit_num(src_bio));
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
+		iv.dun =3D curr_dun;
+
+		sg_set_page(&src, page, enc_bvec->bv_len, enc_bvec->bv_offset);
+		sg_set_page(&dst, ciphertext_page, enc_bvec->bv_len,
+			    enc_bvec->bv_offset);
+
+		skcipher_request_set_crypt(ciph_req, &src, &dst,
+					   enc_bvec->bv_len, iv.bytes);
+		crypto_init_wait(&wait);
+		err =3D crypto_wait_req(crypto_skcipher_encrypt(ciph_req), &wait);
+		if (err)
+			goto no_mem_for_ciph_page;
+
+		le64_add_cpu(&curr_dun, 1);
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
+	blk_crypto_release_keyslot(src_bio);
+out:
+	return err;
+}
+
+/* TODO: assumption right now is:
+ * each segment in bio has length =3D=3D the data_unit_size
+ */
+static void blk_crypto_decrypt_bio(struct work_struct *w)
+{
+	struct work_mem *work_mem =3D
+		container_of(w, struct work_mem, crypto_work);
+	struct bio *bio =3D work_mem->bio;
+	int slot =3D bio_crypt_get_slot(bio);
+	struct skcipher_request *ciph_req;
+	struct crypto_wait wait;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	__le64 curr_dun;
+	union {
+		__le64 dun;
+		u8 bytes[16];
+	} iv;
+	struct scatterlist src;
+
+	curr_dun =3D cpu_to_le64(bio_crypt_sw_data_unit_num(bio));
+
+	kmem_cache_free(blk_crypto_work_mem_cache, work_mem);
+	ciph_req =3D skcipher_request_alloc(slot_mem[slot].tfm, GFP_NOFS);
+	if (!ciph_req) {
+		bio->bi_status =3D BLK_STS_RESOURCE;
+		goto out_ciph_req;
+	}
+
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
+
+	sg_init_table(&src, 1);
+	__bio_for_each_segment(bv, bio, iter,
+			       bio->bi_crypt_context.crypt_iter) {
+		struct page *page =3D bv.bv_page;
+		int err;
+
+		memset(&iv, 0, sizeof(iv));
+		iv.dun =3D curr_dun;
+
+		sg_set_page(&src, page, bv.bv_len, bv.bv_offset);
+		skcipher_request_set_crypt(ciph_req, &src, &src,
+					   bv.bv_len, iv.bytes);
+		crypto_init_wait(&wait);
+		err =3D crypto_wait_req(crypto_skcipher_decrypt(ciph_req), &wait);
+		if (err) {
+			bio->bi_status =3D BLK_STS_IOERR;
+			goto out;
+		}
+		le64_add_cpu(&curr_dun, 1);
+	}
+
+out:
+	skcipher_request_free(ciph_req);
+out_ciph_req:
+	blk_crypto_release_keyslot(bio);
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
+/**
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
+	enum blk_crypt_mode_index crypt_mode;
+	struct bio_crypt_ctx *crypt_ctx;
+
+	if (!bio_has_data(bio))
+		return 0;
+
+	if (!bio_is_encrypted(bio) || bio_crypt_swhandled(bio))
+		return 0;
+
+	crypt_ctx =3D &bio->bi_crypt_context;
+	q =3D bio->bi_disk->queue;
+	crypt_mode =3D bio_crypt_mode(bio);
+
+	if (bio_crypt_has_keyslot(bio)) {
+		if (q->ksm) {
+			if (q->ksm =3D=3D crypt_ctx->processing_ksm)
+				return 0;
+
+			blk_crypto_release_keyslot(bio);
+
+			err =3D blk_crypto_program_keyslot(bio, q->ksm);
+			if (!err)
+				return 0;
+			/* Fallback to software */
+		} else {
+			/**
+			 * We have been lied to. A device on upper layer
+			 * claimed to support ICE, but passed the crypt
+			 * ctx to a device below that doesn't claim to
+			 * support ICE, and the upper layer itself didn't
+			 * handle the crypt either. If this was the bio that
+			 * set up the keyslot, free it up. In either case,
+			 * fallback to software.
+			 */
+			blk_crypto_release_keyslot(bio);
+		}
+	} else if (q->ksm) {
+		/**
+		 * We haven't programmed the key anywhere,
+		 * and the device claims to have ICE.
+		 * Try using it.
+		 */
+		err =3D blk_crypto_program_keyslot(bio, q->ksm);
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
+		err =3D blk_crypto_program_keyslot(bio, blk_crypto_ksm);
+		if (err)
+			goto out_err;
+		bio_crypt_set_swhandled(bio);
+	}
+	return 0;
+out_err:
+	bio->bi_status =3D BLK_STS_IOERR;
+out_encrypt_err:
+	bio_endio(bio);
+	return err;
+}
+
+/**
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
+int blk_crypto_endio(struct bio *bio)
+{
+	if (!bio_crypt_has_keyslot(bio))
+		return 0;
+
+	if (!bio_crypt_swhandled(bio)) {
+		blk_crypto_release_keyslot(bio);
+		return 0;
+	}
+
+	/* bio_data_dir(bio) =3D=3D READ. So decrypt bio */
+	blk_crypto_queue_decrypt_bio(bio);
+	return -EAGAIN;
+}
+
+int __init blk_crypto_init(void)
+{
+	blk_crypto_ksm =3D keyslot_manager_create(BLK_CRYPTO_NUM_KEYSLOTS,
+				       &blk_crypto_ksm_ll_ops,
+				       NULL);
+	if (!blk_crypto_ksm)
+		goto out_ksm;
+
+	blk_crypto_wq =3D alloc_workqueue("blk_crypto_wq",
+			       WQ_UNBOUND | WQ_HIGHPRI,
+			       num_online_cpus());
+	if (!blk_crypto_wq)
+		goto out_wq;
+
+	slot_mem =3D kzalloc(sizeof(*slot_mem) * BLK_CRYPTO_NUM_KEYSLOTS,
+			   GFP_KERNEL);
+	if (!slot_mem)
+		goto out_slot_mem;
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
+	kzfree(slot_mem);
+	slot_mem =3D NULL;
+out_slot_mem:
+	destroy_workqueue(blk_crypto_wq);
+	blk_crypto_wq =3D NULL;
+out_wq:
+	keyslot_manager_destroy(blk_crypto_ksm);
+	blk_crypto_ksm =3D NULL;
+out_ksm:
+	pr_warn("No memory for block crypto software fallback.");
+	return -ENOMEM;
+}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1c9d4f0f96ea..55133c547bdf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -614,6 +614,59 @@ int blk_rq_map_sg(struct request_queue *q, struct requ=
est *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
=20
+#ifdef CONFIG_BLK_CRYPT_CTX
+/*
+ * Checks that two bio crypt contexts are compatible - i.e. that
+ * they are mergeable except for data_unit_num continuity.
+ */
+static inline bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b=
_2)
+{
+	struct bio_crypt_ctx *bc1 =3D &b_1->bi_crypt_context;
+	struct bio_crypt_ctx *bc2 =3D &b_2->bi_crypt_context;
+
+	if (bio_is_encrypted(b_1) !=3D bio_is_encrypted(b_2) ||
+	    bc1->keyslot !=3D bc2->keyslot)
+		return false;
+
+	return !bio_is_encrypted(b_1) ||
+		bc1->data_unit_size_bits =3D=3D bc2->data_unit_size_bits;
+}
+
+/*
+ * Checks that two bio crypt contexts are compatible, and also
+ * that their data_unit_nums are continuous (and can hence be merged)
+ */
+static inline bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
+						unsigned int b1_sectors,
+						struct bio *b_2)
+{
+	struct bio_crypt_ctx *bc1 =3D &b_1->bi_crypt_context;
+	struct bio_crypt_ctx *bc2 =3D &b_2->bi_crypt_context;
+
+	if (!bio_crypt_ctx_compatible(b_1, b_2))
+		return false;
+
+	return !bio_is_encrypted(b_1) ||
+		(bc1->data_unit_num +
+		(b1_sectors >> (bc1->data_unit_size_bits - 9)) =3D=3D
+		bc2->data_unit_num);
+}
+
+#else /* CONFIG_BLK_CRYPT_CTX */
+static inline bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b=
_2)
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
+#endif /* CONFIG_BLK_CRYPT_CTX */
+
 static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct request *req,
 				    struct bio *bio)
@@ -626,6 +679,9 @@ static inline int ll_new_hw_segment(struct request_queu=
e *q,
 	if (blk_integrity_merge_bio(q, req, bio) =3D=3D false)
 		goto no_merge;
=20
+	if (WARN_ON(!bio_crypt_ctx_compatible(bio, req->bio)))
+		goto no_merge;
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
@@ -801,8 +857,13 @@ static enum elv_merge blk_try_req_merge(struct request=
 *req,
 {
 	if (blk_discard_mergable(req))
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next))
+	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next)) {
+		if (!bio_crypt_ctx_back_mergeable(
+			req->bio, blk_rq_sectors(req), next->bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_BACK_MERGE;
+	}
=20
 	return ELEVATOR_NO_MERGE;
 }
@@ -838,6 +899,9 @@ static struct request *attempt_merge(struct request_que=
ue *q,
 	if (req->ioprio !=3D next->ioprio)
 		return NULL;
=20
+	if (!bio_crypt_ctx_compatible(req->bio, next->bio))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -970,16 +1034,31 @@ bool blk_rq_merge_ok(struct request *rq, struct bio =
*bio)
 	if (rq->ioprio !=3D bio_prio(bio))
 		return false;
=20
+	/* Only merge if the crypt contexts are compatible */
+	if (!bio_crypt_ctx_compatible(bio, rq->bio))
+		return false;
+
 	return true;
 }
=20
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
+	if (blk_discard_mergable(rq)) {
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_secto=
r)
+	} else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D
+		   bio->bi_iter.bi_sector) {
+		if (!bio_crypt_ctx_back_mergeable(rq->bio,
+						  blk_rq_sectors(rq), bio)) {
+			return ELEVATOR_NO_MERGE;
+		}
 		return ELEVATOR_BACK_MERGE;
-	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_sector)
+	} else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D
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
index 47eb7e936e22..6866e6a04beb 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -277,6 +277,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src=
, gfp_t gfp_mask,
 			return NULL;
 		}
 	}
+	bio_clone_crypt_context(bio, bio_src);
=20
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
new file mode 100644
index 000000000000..ed8d290831f3
--- /dev/null
+++ b/block/keyslot-manager.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DOC: The Keyslot Manager
+ *
+ * Many devices with inline encryption support have a limited number of "s=
lots"
+ * into which encryption contexts may be programmed, and requests can be t=
agged
+ * with a slot number to specify the key to use for en/decryption.
+ *
+ * As the number of slots are limited, and programming keys is expensive o=
n
+ * many inline encryption hardware, we don't want to program the same key =
into
+ * multiple slots - if multiple requests are using the same key, we want t=
o
+ * program just one slot with that key and use that slot for all requests.
+ *
+ * The keyslot manager manages these keyslots appropriately, and also acts=
 as
+ * an abstraction between the inline encryption hardware and the upper lay=
ers.
+ *
+ * Lower layer devices will set up a keyslot manager in their request queu=
e
+ * and tell it how to perform device specific operations like programming/
+ * evicting keys from keyslots.
+ *
+ * Upper layers will call keyslot_manager_get_slot_for_key() to program a
+ * key into some slot in the inline encryption hardware.
+ *
+ * Copyright 2019 Google LLC
+ */
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/keyslot-manager.h>
+#include <linux/atomic.h>
+
+/**
+ * keyslot_manager_create() - Create a keyslot manager
+ * @num_slots: The number of key slots to manage.
+ * @ksm_ll_ops: The struct keyslot_mgmt_ll_ops for the device that this ke=
yslot
+ *		manager will use to perform operations like programming and
+ *		evicting keys.
+ * @ll_priv_data: Private data passed as is to the functions in ksm_ll_ops=
.
+ *
+ * Allocate memory for and initialize a keyslot manager. Called by for e.g=
.
+ * storage drivers to set up a keyslot manager in their request_queue.
+ *
+ * Context: This function may sleep
+ * Return: Pointer to constructed keyslot manager or NULL on error.
+ */
+struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
+				const struct keyslot_mgmt_ll_ops *ksm_ll_ops,
+				void *ll_priv_data)
+{
+	struct keyslot_manager *ksm;
+
+	if (num_slots =3D=3D 0)
+		return NULL;
+
+	/* Check that all ops are specified */
+	if (ksm_ll_ops->keyslot_program =3D=3D NULL ||
+	    ksm_ll_ops->keyslot_evict =3D=3D NULL ||
+	    ksm_ll_ops->crypto_alg_find =3D=3D NULL ||
+	    ksm_ll_ops->keyslot_find =3D=3D NULL) {
+		return NULL;
+	}
+
+	ksm =3D kzalloc(struct_size(ksm, slot_refs, num_slots), GFP_KERNEL);
+	if (!ksm)
+		return NULL;
+
+	ksm->num_slots =3D num_slots;
+	atomic_set(&ksm->num_idle_slots, num_slots);
+	ksm->ksm_ll_ops =3D *ksm_ll_ops;
+	ksm->ll_priv_data =3D ll_priv_data;
+
+	mutex_init(&ksm->lock);
+	init_waitqueue_head(&ksm->wait_queue);
+
+	ksm->last_used_seq_nums =3D kcalloc(num_slots, sizeof(u64), GFP_KERNEL);
+	if (!ksm->last_used_seq_nums) {
+		kzfree(ksm);
+		ksm =3D NULL;
+	}
+
+	return ksm;
+}
+EXPORT_SYMBOL(keyslot_manager_create);
+
+/**
+ * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
+ * @ksm: The keyslot manager to program the key into.
+ * @key: Pointer to the bytes of the key to program. Must be of the length
+ *	 specified according to blk_crypt_modes in blk-crypto.c.
+ * @crypt_mode: The index into blk_crypt_modes representing the crypto alg=
 to
+ *		use.
+ * @data_unit_size: The data unit size to use for en/decryption.
+ *
+ * Program a key into a keyslot with the specified crypt_mode and
+ * data_unit_size as follows: If the specified key has already been progra=
mmed
+ * into a keyslot, then this function increments the refcount on that keys=
lot
+ * and returns that keyslot. Otherwise, it waits for a keyslot to become i=
dle
+ * and programs the key into an idle keyslot, increments its refcount, and
+ * returns that keyslot
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ * Return: The keyslot that the key was programmed into, or a negative err=
or
+ *         code otherwise.
+ */
+int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_index crypt_mode,
+				     unsigned int data_unit_size)
+{
+	int crypto_alg_id;
+	int slot;
+	int err;
+	int c;
+	int lru_idle_slot;
+	u64 min_seq_num;
+
+	crypto_alg_id =3D ksm->ksm_ll_ops.crypto_alg_find(ksm->ll_priv_data,
+							crypt_mode,
+							data_unit_size);
+	if (crypto_alg_id < 0)
+		return crypto_alg_id;
+
+	mutex_lock(&ksm->lock);
+	slot =3D ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    data_unit_size,
+					    crypto_alg_id);
+
+	if (slot < 0 && slot !=3D -ENOKEY) {
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	if (WARN_ON(slot >=3D (int)ksm->num_slots)) {
+		mutex_unlock(&ksm->lock);
+		return -EINVAL;
+	}
+
+	/* Try to use the returned slot */
+	if (slot !=3D -ENOKEY) {
+		/**
+		 * NOTE: We may fail to get a slot if the number of refs
+		 * overflows UINT_MAX. I don't think we care enough about
+		 * that possibility to make the refcounts u64, considering
+		 * the only way for that to happen is for at least UINT_MAX
+		 * requests to be in flight at the same time.
+		 */
+		if ((unsigned int)atomic_read(&ksm->slot_refs[slot]) =3D=3D
+		    UINT_MAX) {
+			mutex_unlock(&ksm->lock);
+			return -EBUSY;
+		}
+
+		if (atomic_fetch_inc(&ksm->slot_refs[slot]) =3D=3D 0)
+			atomic_dec(&ksm->num_idle_slots);
+
+		ksm->last_used_seq_nums[slot] =3D ++ksm->seq_num;
+
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	/*
+	 * If we're here, that means there wasn't a slot that
+	 * was already programmed with the key
+	 */
+
+	/* Wait till there is a free slot available */
+	while (atomic_read(&ksm->num_idle_slots) =3D=3D 0) {
+		mutex_unlock(&ksm->lock);
+		wait_event(ksm->wait_queue,
+			   (atomic_read(&ksm->num_idle_slots) > 0));
+		mutex_lock(&ksm->lock);
+	}
+
+	/* Todo: fix linear scan? */
+	/* Find least recently used idle slot (i.e. slot with minimum number) */
+	lru_idle_slot  =3D -1;
+	min_seq_num =3D 0;
+	for (c =3D 0; c < ksm->num_slots; c++) {
+		if (atomic_read(&ksm->slot_refs[c]) !=3D 0)
+			continue;
+
+		if (lru_idle_slot =3D=3D -1 ||
+		    ksm->last_used_seq_nums[c] < min_seq_num) {
+			lru_idle_slot =3D c;
+			min_seq_num =3D ksm->last_used_seq_nums[c];
+		}
+	}
+
+	if (WARN_ON(lru_idle_slot =3D=3D -1)) {
+		mutex_unlock(&ksm->lock);
+		return -EBUSY;
+	}
+
+	atomic_dec(&ksm->num_idle_slots);
+	atomic_inc(&ksm->slot_refs[lru_idle_slot]);
+	err =3D ksm->ksm_ll_ops.keyslot_program(ksm->ll_priv_data, key,
+					      data_unit_size,
+					      crypto_alg_id,
+					      lru_idle_slot);
+
+	if (err) {
+		atomic_dec(&ksm->slot_refs[lru_idle_slot]);
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->wait_queue);
+		mutex_unlock(&ksm->lock);
+		return err;
+	}
+
+	ksm->seq_num++;
+	ksm->last_used_seq_nums[lru_idle_slot] =3D ksm->seq_num;
+
+	mutex_unlock(&ksm->lock);
+	return lru_idle_slot;
+}
+EXPORT_SYMBOL(keyslot_manager_get_slot_for_key);
+
+/**
+ * keyslot_manager_get_slot() - Increment the refcount on the specified sl=
ot.
+ * @ksm - The keyslot manager that we want to modify.
+ * @slot - The slot to increment the refcount of.
+ *
+ * This function assumes that there is already an active reference to that=
 slot
+ * and simply increments the refcount. This is useful when cloning a bio t=
hat
+ * already has a reference to a keyslot, and we want the cloned bio to als=
o have
+ * its own reference.
+ *
+ * Context: Any context.
+ */
+bool keyslot_manager_get_slot(struct keyslot_manager *ksm, unsigned int sl=
ot)
+{
+	if (WARN_ON(slot >=3D ksm->num_slots))
+		return false;
+
+	return atomic_inc_not_zero(&ksm->slot_refs[slot]);
+}
+EXPORT_SYMBOL(keyslot_manager_get_slot);
+
+/**
+ * keyslot_manager_put_slot() - Release a reference to a slot
+ * @ksm: The keyslot manager to release the reference from.
+ * @slot: The slot to release the reference from.
+ *
+ * Context: Any context.
+ */
+void keyslot_manager_put_slot(struct keyslot_manager *ksm, unsigned int sl=
ot)
+{
+	if (WARN_ON(slot >=3D ksm->num_slots))
+		return;
+
+	if (atomic_dec_and_test(&ksm->slot_refs[slot])) {
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->wait_queue);
+	}
+}
+EXPORT_SYMBOL(keyslot_manager_put_slot);
+
+/**
+ * keyslot_manager_evict_key() - Evict a key from the lower layer device.
+ * @ksm - The keyslot manager to evict from
+ * @key - The key to evict
+ * @crypt_mode - The crypto algorithm the key was programmed with.
+ * @data_unit_size - The data_unit_size the key was programmed with.
+ *
+ * Finds the slot that the specified key, crypto_mode, data_unit_size comb=
o
+ * was programmed into, and evicts that slot from the lower layer device i=
f
+ * the refcount on the slot is 0. Returns -EBUSY if the refcount is not 0,=
 and
+ * negative error code on error.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ */
+int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+			      const u8 *key,
+			      enum blk_crypt_mode_index crypt_mode,
+			      unsigned int data_unit_size)
+{
+	int slot;
+	int crypto_alg_id;
+	int err =3D 0;
+
+	crypto_alg_id =3D ksm->ksm_ll_ops.crypto_alg_find(ksm->ll_priv_data,
+							crypt_mode,
+							data_unit_size);
+	if (crypto_alg_id < 0)
+		return -EINVAL;
+
+	mutex_lock(&ksm->lock);
+	slot =3D ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    data_unit_size,
+					    crypto_alg_id);
+
+	if (slot < 0) {
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	if (atomic_read(&ksm->slot_refs[slot]) =3D=3D 0) {
+		err =3D ksm->ksm_ll_ops.keyslot_evict(ksm->ll_priv_data, slot,
+						    key, data_unit_size,
+						    crypto_alg_id);
+	} else {
+		err =3D -EBUSY;
+	}
+
+	mutex_unlock(&ksm->lock);
+	return err;
+}
+EXPORT_SYMBOL(keyslot_manager_evict_key);
+
+void keyslot_manager_destroy(struct keyslot_manager *ksm)
+{
+	kzfree(ksm->last_used_seq_nums);
+	kzfree(ksm);
+}
+EXPORT_SYMBOL(keyslot_manager_destroy);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index e584673c1881..4f2c54742b04 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -575,6 +575,172 @@ static inline void bvec_kunmap_irq(char *buffer, unsi=
gned long *flags)
 }
 #endif
=20
+#ifdef CONFIG_BLK_CRYPT_CTX
+extern void bio_clone_crypt_context(struct bio *dst, struct bio *src);
+
+static inline bool bio_crypt_test_flag(struct bio *bio, int flag)
+{
+	return !!(bio->bi_crypt_context.flags & flag);
+}
+
+static inline void bio_crypt_set_flag(struct bio *bio, int flag)
+{
+	bio->bi_crypt_context.flags |=3D flag;
+}
+
+static inline void bio_crypt_clear_flag(struct bio *bio, int flag)
+{
+	bio->bi_crypt_context.flags &=3D ~flag;
+}
+
+static inline bool bio_is_encrypted(struct bio *bio)
+{
+	return bio && bio_crypt_test_flag(bio, BIO_CRYPT_ENABLED);
+}
+
+static inline bool bio_crypt_swhandled(struct bio *bio)
+{
+	return bio_crypt_test_flag(bio, BIO_CRYPT_SWHANDLED);
+}
+
+static inline bool bio_crypt_has_keyslot(struct bio *bio)
+{
+	return bio_is_encrypted(bio) &&
+	       bio_crypt_test_flag(bio, BIO_CRYPT_KEYSLOT);
+}
+
+static inline void bio_crypt_set_swhandled(struct bio *bio)
+{
+	WARN_ON(!bio_crypt_has_keyslot(bio));
+	bio_crypt_set_flag(bio, BIO_CRYPT_SWHANDLED);
+
+	bio->bi_crypt_context.crypt_iter =3D bio->bi_iter;
+	bio->bi_crypt_context.sw_data_unit_num =3D
+		bio->bi_crypt_context.data_unit_num;
+}
+
+static inline void bio_crypt_set_ctx(struct bio *bio,
+				     u8 *raw_key,
+				     enum blk_crypt_mode_index crypt_mode,
+				     u64 dun,
+				     unsigned int dun_bits)
+{
+	bio_crypt_set_flag(bio, BIO_CRYPT_ENABLED);
+	bio_crypt_clear_flag(bio, BIO_CRYPT_KEYSLOT);
+	bio_crypt_clear_flag(bio, BIO_CRYPT_SWHANDLED);
+	bio->bi_crypt_context.raw_key =3D raw_key;
+	bio->bi_crypt_context.data_unit_num =3D dun;
+	bio->bi_crypt_context.data_unit_size_bits =3D dun_bits;
+	bio->bi_crypt_context.crypt_mode =3D crypt_mode;
+	bio->bi_crypt_context.processing_ksm =3D NULL;
+	bio->bi_crypt_context.keyslot =3D 0;
+}
+
+static inline int bio_crypt_get_slot(struct bio *bio)
+{
+	return bio->bi_crypt_context.keyslot;
+}
+
+static inline void bio_crypt_set_keyslot(struct bio *bio,
+					 unsigned int keyslot,
+					 struct keyslot_manager *ksm)
+{
+	bio->bi_crypt_context.keyslot =3D keyslot;
+	bio_crypt_set_flag(bio, BIO_CRYPT_KEYSLOT);
+	bio->bi_crypt_context.processing_ksm =3D ksm;
+}
+
+static inline void bio_crypt_unset_keyslot(struct bio *bio)
+{
+	bio_crypt_clear_flag(bio, BIO_CRYPT_KEYSLOT);
+	bio_crypt_clear_flag(bio, BIO_CRYPT_SWHANDLED);
+	bio->bi_crypt_context.processing_ksm =3D NULL;
+	bio->bi_crypt_context.keyslot =3D 0;
+}
+
+static inline u8 *bio_crypt_raw_key(struct bio *bio)
+{
+	return bio->bi_crypt_context.raw_key;
+}
+
+static inline enum blk_crypt_mode_index bio_crypt_mode(struct bio *bio)
+{
+	return bio->bi_crypt_context.crypt_mode;
+}
+
+static inline u64 bio_crypt_data_unit_num(struct bio *bio)
+{
+	WARN_ON(!bio_is_encrypted(bio));
+	return bio->bi_crypt_context.data_unit_num;
+}
+
+static inline u64 bio_crypt_sw_data_unit_num(struct bio *bio)
+{
+	WARN_ON(!bio_is_encrypted(bio));
+	return bio->bi_crypt_context.sw_data_unit_num;
+}
+
+extern bool bio_crypt_should_process(struct bio *bio, struct request_queue=
 *q);
+
+#else
+static inline void bio_clone_crypt_context(struct bio *dst,
+					   struct bio *src) { }
+static inline void bio_crypt_advance(struct bio *bio,
+				     unsigned int bytes) { }
+
+static inline bool bio_is_encrypted(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_set_ctx(struct bio *bio,
+				     u8 *raw_key,
+				     enum blk_crypt_mode_index crypt_mode,
+				     u64 dun,
+				     unsigned int dun_bits) { }
+
+static inline bool bio_crypt_swhandled(struct bio *bio)
+{
+	return false;
+}
+
+static inline void bio_crypt_set_swhandled(struct bio *bio) { }
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
+#endif /* CONFIG_BLK_CRYPT_CTX */
+
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and lo=
op.
  *
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
new file mode 100644
index 000000000000..da189aa26ac9
--- /dev/null
+++ b/include/linux/blk-crypto.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_H
+#define __LINUX_BLK_CRYPTO_H
+
+#include <linux/bio.h>
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+
+#ifdef CONFIG_BLK_CRYPTO
+
+int blk_crypto_init(void);
+
+int blk_crypto_submit_bio(struct bio **bio_ptr);
+
+int blk_crypto_endio(struct bio *bio);
+
+#else /* CONFIG_BLK_CRYPTO */
+
+static inline int blk_crypto_init(void)
+{
+	return 0;
+}
+
+static inline int blk_crypto_submit_bio(struct bio *bio)
+{
+	return 0;
+}
+
+static inline int blk_crypto_endio(struct bio *bio)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BLK_CRYPTO */
+
+#endif /* __LINUX_BLK_CRYPTO_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 791fee35df88..23a133c3e47c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -137,6 +137,50 @@ static inline void bio_issue_init(struct bio_issue *is=
sue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
=20
+/* Flags in bio_crypt_ctx */
+/* If this crypt_ctx is enabled */
+#define BIO_CRYPT_ENABLED BIT(0)
+/* If this crypt_ctx is going to be en/decrypted in software */
+#define BIO_CRYPT_SWHANDLED BIT(1)
+/**
+ * If this crypt_ctx has been programmed into some keyslot
+ * in some keyslot manager
+ */
+#define BIO_CRYPT_KEYSLOT BIT(2)
+
+struct bio;
+enum blk_crypt_mode_index {
+	BLK_ENCRYPTION_MODE_AES_256_XTS	=3D 0,
+	/** TODO: Support these too
+	 * BLK_ENCRYPTION_MODE_AES_256_CTS	=3D 1,
+	 * BLK_ENCRYPTION_MODE_AES_128_CBC	=3D 2,
+	 * BLK_ENCRYPTION_MODE_AES_128_CTS	=3D 3,
+	 * BLK_ENCRYPTION_MODE_ADIANTUM		=3D 4,
+	 */
+};
+
+struct bio_crypt_ctx {
+	u8 flags;
+	int keyslot;
+	u8 *raw_key;
+	enum blk_crypt_mode_index crypt_mode;
+	u64 data_unit_num;
+	unsigned int data_unit_size_bits;
+
+	/* The keyslot manager where the key has been programmed
+	 * with keyslot.
+	 */
+	struct keyslot_manager *processing_ksm;
+
+	/* Copy of the bvec_iter when this bio was submitted.
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
@@ -182,6 +226,11 @@ struct bio {
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
+
+#ifdef CONFIG_BLK_CRYPT_CTX
+	struct bio_crypt_ctx	bi_crypt_context;
+#endif
+
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 		struct bio_integrity_payload *bi_integrity; /* data integrity */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..25e36e3f4f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -385,6 +385,10 @@ static inline int blkdev_reset_zones_ioctl(struct bloc=
k_device *bdev,
=20
 #endif /* CONFIG_BLK_DEV_ZONED */
=20
+#ifdef CONFIG_KEYSLOT_MANAGER
+struct keyslot_manager;
+#endif
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
@@ -473,6 +477,11 @@ struct request_queue {
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
=20
+#ifdef CONFIG_BLK_KEYSLOT_MANAGER
+	/* Inline crypto capabilities */
+	struct keyslot_manager *ksm;
+#endif
+
 	unsigned int		rq_timeout;
 	int			poll_nsec;
=20
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manage=
r.h
new file mode 100644
index 000000000000..30ee9b87b580
--- /dev/null
+++ b/include/linux/keyslot-manager.h
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_KEYSLOT_MANAGER_H
+#define __LINUX_KEYSLOT_MANAGER_H
+
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <linux/blk-crypto.h>
+
+struct keyslot_mgmt_ll_ops {
+	int (*keyslot_program)(void *ll_priv_data, const u8 *key,
+			       unsigned int data_unit_size,
+			       /* crypto_alg_id returned by crypto_alg_find */
+			       unsigned int crypto_alg_id,
+			       unsigned int slot);
+	/**
+	 * Evict key from all keyslots in the keyslot manager.
+	 * The key, data_unit_size and crypto_alg_id are also passed down
+	 * so that for e.g. dm layers that have their own keyslot
+	 * managers can evict keys from the devices that they map over.
+	 * Returns 0 on success, -errno otherwise.
+	 */
+	int (*keyslot_evict)(void *ll_priv_data, unsigned int slot,
+			     const u8 *key, unsigned int data_unit_size,
+			     unsigned int crypto_alg_id);
+	/**
+	 * Get a crypto_alg_id (used internally by the lower layer driver) that
+	 * represents the given blk-crypto crypt_mode and data_unit_size. The
+	 * returned crypto_alg_id will be used in future calls to the lower
+	 * layer driver (in keyslot_program and keyslot_evict) to reference
+	 * this crypt_mode, data_unit_size combo. Returns negative error code
+	 * if a crypt_mode, data_unit_size combo is not supported.
+	 */
+	int (*crypto_alg_find)(void *ll_priv_data,
+			       enum blk_crypt_mode_index crypt_mode,
+			       unsigned int data_unit_size);
+	/**
+	 * Returns the slot number that matches the key,
+	 * or -ENOKEY if no match found, or negative on error
+	 */
+	int (*keyslot_find)(void *ll_priv_data, const u8 *key,
+			    unsigned int data_unit_size,
+			    unsigned int crypto_alg_id);
+};
+
+struct keyslot_manager {
+	unsigned int num_slots;
+	atomic_t num_idle_slots;
+	struct keyslot_mgmt_ll_ops ksm_ll_ops;
+	void *ll_priv_data;
+	struct mutex lock;
+	wait_queue_head_t wait_queue;
+	u64 seq_num;
+	u64 *last_used_seq_nums;
+	atomic_t slot_refs[];
+};
+
+#ifdef CONFIG_BLK_KEYSLOT_MANAGER
+extern struct keyslot_manager *keyslot_manager_create(unsigned int num_slo=
ts,
+				const struct keyslot_mgmt_ll_ops *ksm_ops,
+				void *ll_priv_data);
+
+extern int
+keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				 const u8 *key,
+				 enum blk_crypt_mode_index crypt_mode,
+				 unsigned int data_unit_size);
+
+extern bool keyslot_manager_get_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern void keyslot_manager_put_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_index crypt_mode,
+				     unsigned int data_unit_size);
+
+extern void keyslot_manager_destroy(struct keyslot_manager *ksm);
+
+#else /* CONFIG_BLK_KEYSLOT_MANAGER */
+
+static inline struct keyslot_manager *
+keyslot_manager_create(unsigned int num_slots,
+		       const struct keyslot_mgmt_ll_ops *ksm_ops,
+		       void *ll_priv_data)
+{
+	return NULL;
+}
+
+static inline int
+keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				 const u8 *key,
+				 enum blk_crypt_mode_index crypt_mode,
+				 unsigned int data_unit_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool keyslot_manager_get_slot(struct keyslot_manager *ksm,
+					   unsigned int slot)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int keyslot_manager_put_slot(struct keyslot_manager *ksm,
+					   unsigned int slot)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_index crypt_mode,
+				     unsigned int data_unit_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void keyslot_manager_destroy(struct keyslot_manager *ksm)
+{ }
+
+#endif /* CONFIG_BLK_KEYSLOT_MANAGER */
+
+#endif /* __LINUX_KEYSLOT_MANAGER_H */
--=20
2.21.0.1020.gf2820cf01a-goog

