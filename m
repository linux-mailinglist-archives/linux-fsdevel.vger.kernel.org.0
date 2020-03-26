Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC7193656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 04:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCZDIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 23:08:18 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:55030 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgCZDIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:08:17 -0400
Received: by mail-pj1-f74.google.com with SMTP id p14so3424652pjo.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QSQO9a2u8Mzoxj1Arnspovaagjrpy0TzOZ64x81t2d4=;
        b=V5QPTf43kUKuzRdhlSjSEEgN6Pf1gSLylUe2AJA5bk4cCqlcS5nL0Whrh3cWSCU6pA
         e40vJC2zN9CqJBhWkDBCZhtjH2/ZprXT9GectWrPUfvCZkFJ4t/7yulnyYQbHYmFm0zq
         GUXgHtDinInkqGaOte4kw4KETkO8ghY8y8VCDJBHPxR9hKITcIHr39olBmiQR7Fz6qJ2
         DVqx7YLcmVw9TPojSrZMezJRmPjQ5mBBeo4eThMzWd9LF5ETGN7hQN92Za73bme3vSUP
         mjT1q+5SXr7j7LnkWACMyXtCSVtJjh7XUBkIje9O0WbV6e4/DQ5moHhcOwvIV1yx+url
         hfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QSQO9a2u8Mzoxj1Arnspovaagjrpy0TzOZ64x81t2d4=;
        b=GX2M2BZaBcZLOEOw1MMVdMj3nRsTRIQqNm0EfbaV5KXEfBFxkemABlnbt1ymtgSFMY
         eEtabintOgzcWRGUAn7zs9Ul6BoHbYejOW97B6bz6nbbceAJ6+05tJ4PVy5ZqBVX6biE
         tIJJkeQLcxb4jlzNamKBCCapatBW6gbm446wf9gYbL9xE1Yh7A8C+tVsUgjaqUeh/dSf
         /0gF/g95YfZwNov4DYLqtKYwhZ6+gP/ikUqZwzvB8erb3EWhrJUA8NgPOQOjaDb0HOsa
         9a4+THGI5iII2yIo7iUhDtJFdkxKKx5wda0M7Pjcb2P27PQNOQZQ1Re8ZC55KoWd4aRt
         6XXA==
X-Gm-Message-State: ANhLgQ3uBW/pdJd+Vwvld8FpLlDU3ZnUlMgxRWnm3rlli5v3bX9DUEg5
        MR83jUxHPrT9RHPHR9Gvhf9GQe4HrII=
X-Google-Smtp-Source: ADFU+vuP5bTJN9hJvcf+uKv9w4tUCTGklyDIa50VYBBR0130cQbzUM176lZdO2K88x18iLzDEDrE/N8AhJQ=
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr730993pjq.5.1585192096556;
 Wed, 25 Mar 2020 20:08:16 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:06:54 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-4-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v9 03/11] block: Make blk-integrity preclude hardware inline encryption
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
index 3a5f2e445809e..abcd14320a5ce 100644
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
@@ -375,3 +378,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
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
index 167297e153592..f0b4bff9c78a1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1569,6 +1569,12 @@ struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
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
@@ -1649,6 +1655,11 @@ static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
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
@@ -1700,6 +1711,25 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
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
2.25.1.696.g5e7596f4ac-goog

