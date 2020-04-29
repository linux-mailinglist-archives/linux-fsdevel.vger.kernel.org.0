Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C872E1BD5DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD2HWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgD2HVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:21:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F7C035495
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 00:21:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q4so148772qve.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Mo+7MFFBs4sdz9XooTQaPI4Fqr1H1d4GlYPjtWQb8M=;
        b=I7kClOzmTA/wrxEymX9+bQY/uNDPHNXeuBH6wJwB7E9qYl97j1h9k4xUVUJbODo3tO
         JPZ7apzzY/QxnPmjsHNPBCOtBURyQkqwZymtt1uCUNp3xX9ELk1KWfTRAQgfnwlcBNts
         P6pCs01aabeU4M9ciU88WGASxRihBCxwBbNmA3d9P0AcnnCQI4cymkoXFJeYV5rUmFLr
         PRKeMz7xwWnkqZ5Fbull+TOmR8d9R38oSISpq1T+6E8mKArYYo7JBwDA4RDjYqIiJVRb
         S8URvchFKtXCETzCgDab7TavKIsCKuTWBQkdU3yOayOaS3ywEPq72UtGM3DMcZDeaytv
         hQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Mo+7MFFBs4sdz9XooTQaPI4Fqr1H1d4GlYPjtWQb8M=;
        b=WrCG95SJx0O5oJWZ5mSO879biU4HkxsM5d/AUu/5VfV2HHmMmyJzm4AZMj7aPL11l/
         IiFoumFpmV9LwMwWkbRWJyikQVrVLlLfQN95qUzXQYkStushIrk8KWFT3DE5l77yUlq2
         6qE2h1i/N9b5+GaprW1cUKumiJYXDUlZZJfBb38GqN8RwUpuwJkkE3suVR183GoB69G9
         gJIKFC8WafkkrbU5Es9I1FoTmF5g4xGXJm1rRTi3YDc+sqY9GAjc9KQOyuqOoU6mi0rc
         DpiSoX5qghE8+fqG5FPsdtAZvBf4noZJ5avV+Dl15GLJk4/0nJDSKhe/YP67t/cihfAC
         lD7g==
X-Gm-Message-State: AGi0PuY1q0wpZwlMJatPh7O7VUnjVlid9xj6wCbfvW0hmnc3qXG/8VbA
        MrKOMlAPXNiJS4nNlsnThM1uyQAXPLM=
X-Google-Smtp-Source: APiQypKMUvPJ1WDTi+RZxM7ebkhMHyaIPvn+6oN+h7e3EzQfL31PHWMOYerxu68ZIum149zO8oAgKyVAGmM=
X-Received: by 2002:ad4:4e65:: with SMTP id ec5mr32206941qvb.32.1588144893748;
 Wed, 29 Apr 2020 00:21:33 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:21:13 +0000
In-Reply-To: <20200429072121.50094-1-satyat@google.com>
Message-Id: <20200429072121.50094-5-satyat@google.com>
Mime-Version: 1.0
References: <20200429072121.50094-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v11 04/12] block: Make blk-integrity preclude hardware inline encryption
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

Whenever a device supports blk-integrity, the kernel will now always
pretend that the device doesn't support inline encryption (essentially
by setting the keyslot manager in the request queue to NULL).

There's no hardware currently that supports both integrity and inline
encryption. However, it seems possible that there will be such hardware
in the near future (like the NVMe key per I/O support that might support
both inline encryption and PI).

But properly integrating both features is not trivial, and without
real hardware that implements both, it is difficult to tell if it will
be done correctly by the majority of hardware that support both.
So it seems best not to support both features together right now, and
to decide what to do at probe time.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio-integrity.c   |  3 +++
 block/blk-integrity.c   |  7 +++++++
 block/keyslot-manager.c | 19 +++++++++++++++++++
 include/linux/blkdev.h  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f4..3579ac0f6ec1f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -42,6 +42,9 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	struct bio_set *bs = bio->bi_pool;
 	unsigned inline_vecs;
 
+	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
 		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
 		inline_vecs = nr_vecs;
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ff1070edbb400..b45711fc37df4 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (disk->queue->ksm) {
+		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Unregistering keyslot manager from request queue, to disable hardware inline encryption.\n");
+		blk_ksm_unregister(disk->queue);
+	}
+#endif
 }
 EXPORT_SYMBOL(blk_integrity_register);
 
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index b584723b392ad..834f45fdd33e2 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -25,6 +25,9 @@
  * Upper layers will call blk_ksm_get_slot_for_key() to program a
  * key into some slot in the inline encryption hardware.
  */
+
+#define pr_fmt(fmt) "blk_crypto: " fmt
+
 #include <crypto/algapi.h>
 #include <linux/keyslot-manager.h>
 #include <linux/atomic.h>
@@ -378,3 +381,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 	memzero_explicit(ksm, sizeof(*ksm));
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
+
+bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
+{
+	if (blk_integrity_queue_supports_integrity(q)) {
+		pr_warn("Integrity and hardware inline encryption are not supported together. Hardware inline encryption is being disabled.\n");
+		return false;
+	}
+	q->ksm = ksm;
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_register);
+
+void blk_ksm_unregister(struct request_queue *q)
+{
+	q->ksm = NULL;
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98aae4638fda9..17738dab8ae04 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1562,6 +1562,12 @@ struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
 	return blk_get_integrity(bdev->bd_disk);
 }
 
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return q->integrity.profile;
+}
+
 static inline bool blk_integrity_rq(struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
@@ -1642,6 +1648,11 @@ static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
 	return NULL;
 }
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return false;
+}
 static inline int blk_integrity_compare(struct gendisk *a, struct gendisk *b)
 {
 	return 0;
@@ -1693,6 +1704,25 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q);
+
+void blk_ksm_unregister(struct request_queue *q);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool blk_ksm_register(struct blk_keyslot_manager *ksm,
+				    struct request_queue *q)
+{
+	return true;
+}
+
+static inline void blk_ksm_unregister(struct request_queue *q) { }
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+
 struct block_device_operations {
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-- 
2.26.2.303.gf8c07b1a785-goog

