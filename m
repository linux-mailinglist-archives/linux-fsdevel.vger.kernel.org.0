Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6937182A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbgCLIDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:03:10 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36904 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgCLIDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:09 -0400
Received: by mail-pf1-f201.google.com with SMTP id n28so3242906pfq.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b9K5ZF1QsnMyis2Iwao7Kx/jSimzBrtZiFuBRS+8W2Q=;
        b=kZidW+4uWj572uSVMaga3/kGllNvwppjeLnRckxNsn5ZtGRgpnGQcc6m+YfG02XymY
         7tPFhcGqWEa67J+CmGysa8gt+VL2iS3Dk1nu4qmKVGDtEuGKRdk9OTprEm7Sq7wNTUQb
         jm4UKSAttJSRDGZIUOMetDNaBKuN/8i11J9iBmRO7yzZeRSH+kVX796hnd4X6iRm9js3
         HvIoMDpjRbNuLUCqTwU8dmF6IrTB0Ng1lTyKWjJU9IhHK481X8Sg6flTQ60sYOC/JB9O
         BxfWCBsbLHPhcjl5wrHg34DADUUc+phrttzuJ3JEpwy9v/IFlJAzdCo89bwQ8EnS+BUy
         T/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b9K5ZF1QsnMyis2Iwao7Kx/jSimzBrtZiFuBRS+8W2Q=;
        b=eQpBAg3/ul0MRuZT6PWwFwO7nVgKSvNH0sUnNPbsmOBrU1jxoDLmXBdsh0ProISgtk
         qvIC8OAuJ21VmifcLTjXrmaRxXAMDs61Gub6kCpTjpxtvh1PAsI2WAKkWY4DQVtjW8+V
         SSQyXaFLiPIW0vXVT+ImBIA5WdSBVY8cztEXJMWVl3VHHls3XHVuSA96tu2K/msfOjb+
         ksS1qObaO6KIOWPNu0w6L8c71ATsvrJPeuH/m4RNkTSwo0b0bltD/WJnlNl+n64d37th
         HpqGlUD8tDcMWi9Zk9veujAZGYiBcwlrCCMOX03wvpOP+q/LJPsyQxbEDhYK3eajs+xW
         XV5A==
X-Gm-Message-State: ANhLgQ3PCxbHZx+omEAm4ObPnxh/pc1sWo6L1ROoEnVUYBI10LoZqVdr
        lLD9C401cu0tljJeTxAWzh6IVUQNHRY=
X-Google-Smtp-Source: ADFU+vtoROhgaUUciKRMglgoersUjDrTpk4PeN3QMGxv3qFhvT5zpCtRD+M2MWAfK7e+3A+TCNAAjfUqW68=
X-Received: by 2002:a17:90a:f311:: with SMTP id ca17mr2920448pjb.6.1584000186546;
 Thu, 12 Mar 2020 01:03:06 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:45 -0700
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
Message-Id: <20200312080253.3667-4-satyat@google.com>
Mime-Version: 1.0
References: <20200312080253.3667-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 03/11] block: Make blk-integrity preclude hardware inline encryption
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
encryption. However, it seems possible that there will be in the near
future, based on discussion at
https://lore.kernel.org/r/20200108140730.GC2896@infradead.org/
But properly integrating both features is not trivial, and without
real hardware that implements both, it is difficult to tell if it will
be done correctly by the majority of hardware that support both, and
through discussions at
https://lore.kernel.org/r/20200224233459.GA30288@infradead.org/
it seems best not to support both features together right now, and
to decide what to do at probe time.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio-integrity.c   |  5 +++++
 block/blk-integrity.c   |  7 +++++++
 block/keyslot-manager.c | 20 ++++++++++++++++++++
 include/linux/blkdev.h  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..a5c57991c6fa 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -42,6 +42,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	struct bio_set *bs = bio->bi_pool;
 	unsigned inline_vecs;
 
+	if (bio_has_crypt_ctx(bio)) {
+		pr_warn("blk-integrity can't be used together with inline en/decryption.");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
 		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
 		inline_vecs = nr_vecs;
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ff1070edbb40..793ba23e8688 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+
+#ifdef BLK_INLINE_ENCRYPTION
+	if (disk->queue->ksm) {
+		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Unregistering keyslot manager from request queue, to disable hardware inline encryption.");
+		blk_ksm_unregister(disk->queue);
+	}
+#endif
 }
 EXPORT_SYMBOL(blk_integrity_register);
 
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 38df0652df80..a7970e18a122 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -25,6 +25,9 @@
  * Upper layers will call blk_ksm_get_slot_for_key() to program a
  * key into some slot in the inline encryption hardware.
  */
+
+#define pr_fmt(fmt) "blk_ksm: " fmt
+
 #include <crypto/algapi.h>
 #include <linux/keyslot-manager.h>
 #include <linux/atomic.h>
@@ -375,3 +378,20 @@ void blk_ksm_destroy(struct keyslot_manager *ksm)
 	memzero_explicit(ksm, sizeof(*ksm));
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
+
+bool blk_ksm_register(struct keyslot_manager *ksm, struct request_queue *q)
+{
+	if (blk_integrity_queue_supports_integrity(q)) {
+		pr_warn("Integrity and hardware inline encryption are not supported together. Won't register keyslot manager with request queue.");
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
+EXPORT_SYMBOL_GPL(blk_ksm_unregister);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c6ea578c1f79..abe886d48cc4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1570,6 +1570,12 @@ struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
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
@@ -1650,6 +1656,11 @@ static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
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
@@ -1701,6 +1712,25 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+bool blk_ksm_register(struct keyslot_manager *ksm, struct request_queue *q);
+
+void blk_ksm_unregister(struct request_queue *q);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool blk_ksm_register(struct keyslot_manager *ksm,
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
2.25.1.481.gfbce0eb801-goog

