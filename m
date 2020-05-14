Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF11D23FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbgENAiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733184AbgENAhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 20:37:42 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47E3C05BD0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 17:37:41 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e43so1714809qtc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2a1/6iexsVaAsJm0zmzLMWWLusJiPio4DT5jdk5JBwA=;
        b=qgIaOplrCikSNBkGIriRGFSxoWJE0hZrycHHNLysncx+37fXhnpldyi9/GJf5pfkD9
         uQRYBh2+FA3JBYi5/Ev1m3DYPjlmv0HUKs50wtVzYWcoIHmLy6MKRybf6uo1SnhKyP65
         xsc4pofml5pz/fSKk3SUTvZ8qTZRC7t1XEmiC7ZlKHvvUVEdU+cgR0kaRXfaD7wGmgVj
         Rz+dmRwXO7wIOwy6Z+aPSiBgKUkM3n6jYV5ORzOlOI+qe7iv/jFC+YL6eabgxMA+Fpr1
         Tr8NIi/4cWJ0SJ4DYAhRJYc0Sy5YsvRWIpEYJfFRk/4dkFGjEeHRGgYkUcnmpVN/5a4F
         WGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2a1/6iexsVaAsJm0zmzLMWWLusJiPio4DT5jdk5JBwA=;
        b=Qu0Ruyz9D1Lgp9rqgww4Oen6YIFscxkiB4+3yOTkH2fKzzs/LjDDJpbFxGZ81vvdLr
         CWjmjCOqSu56ISFuGZ07c+13rGJj5Ws7eXRFYi2gpLy0LimVhWMK+0NnCFyYVDukApKm
         xFhiZ9rzPctKUokOhMr8jpcaE+K820ecBSReSDyhoTg5uB2/27KPxsagUqIeBo1+qWFN
         kO4cby1NjijSNoWNDB08IlkJoiWofm7XZIDWG/16+EqU40UPzgEvCDhv4BALrnawiL5t
         3B4O5dZigsuUK/CH0L7ncVm9AsSk8Yaoel/Vj7Zct8OhTU6ZYem8H1yRKC0MaOvTpMmD
         evWA==
X-Gm-Message-State: AOAM532Si/KV3LnU9EwAB5FcmAJ20dGsVJ9LNEQhR+CopOJnMXy5mbeG
        eBan0ya/V/MyBylZyHazGkDkN1Vqhos=
X-Google-Smtp-Source: ABdhPJxasO7CuvbgVMrryShWRnajhNBFChEkNUrrAJjMb5JoLsPu1wFEEDlrSFyCr2M5sCz96zL9uZgIBPw=
X-Received: by 2002:a05:6214:1262:: with SMTP id r2mr2374970qvv.126.1589416660998;
 Wed, 13 May 2020 17:37:40 -0700 (PDT)
Date:   Thu, 14 May 2020 00:37:19 +0000
In-Reply-To: <20200514003727.69001-1-satyat@google.com>
Message-Id: <20200514003727.69001-5-satyat@google.com>
Mime-Version: 1.0
References: <20200514003727.69001-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v13 04/12] block: Make blk-integrity preclude hardware inline encryption
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Whenever a device supports blk-integrity, make the kernel pretend that
the device doesn't support inline encryption (essentially by setting the
keyslot manager in the request queue to NULL).

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
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index ff1070edbb400..c03705cbb9c9f 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (disk->queue->ksm) {
+		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
+		blk_ksm_unregister(disk->queue);
+	}
+#endif
 }
 EXPORT_SYMBOL(blk_integrity_register);
 
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index fcd3fd469d7c1..c2ef41b3147ba 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -25,6 +25,9 @@
  * Upper layers will call blk_ksm_get_slot_for_key() to program a
  * key into some slot in the inline encryption hardware.
  */
+
+#define pr_fmt(fmt) "blk-crypto: " fmt
+
 #include <linux/keyslot-manager.h>
 #include <linux/atomic.h>
 #include <linux/mutex.h>
@@ -376,3 +379,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 	memzero_explicit(ksm, sizeof(*ksm));
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
+
+bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
+{
+	if (blk_integrity_queue_supports_integrity(q)) {
+		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
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
index de38318a7acf0..d8f85fe696752 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1582,6 +1582,12 @@ struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
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
@@ -1662,6 +1668,11 @@ static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
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
@@ -1713,6 +1724,25 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
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
2.26.2.645.ge9eca65c58-goog

