Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76877AA8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHMS0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 14:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHMS0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:26:44 -0400
Received: from out-74.mta0.migadu.com (out-74.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EAB10E5
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 11:26:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691951204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JvFlUnJNg/19MdiHLNUIX73kgMJww+dfgCblmEcu1U=;
        b=H6ar8w0qqJyDT/pzbs4w2qdhUMfhrAw3GgXKRnVTTEQQi1uE+SWtcEdd/u4HfiAz7QT8Td
        IkF9//SFZo4OB092up3FDh9LWs/KX60tz/6ABOIlvZr+fQY9ySQR4qSO+ppX47RG5CqNTp
        9smTJUeKp4wreVFMJW/GKyXEBCVrF50=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/3] block: Add some exports for bcachefs
Date:   Sun, 13 Aug 2023 14:26:34 -0400
Message-Id: <20230813182636.2966159-2-kent.overstreet@linux.dev>
In-Reply-To: <20230813182636.2966159-1-kent.overstreet@linux.dev>
References: <20230813182636.2966159-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

 - bio_set_pages_dirty(), bio_check_pages_dirty() - dio path
 - blk_status_to_str() - error messages
 - bio_add_folio() - this should definitely be exported for everyone,
   it's the modern version of bio_add_page()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/bio.c            | 2 ++
 block/blk-core.c       | 1 +
 block/blk.h            | 1 -
 include/linux/blkdev.h | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46..1e75840d17 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1481,6 +1481,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
@@ -1540,6 +1541,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 static inline bool bio_remaining_done(struct bio *bio)
 {
diff --git a/block/blk-core.c b/block/blk-core.c
index 1da77e7d62..b7b0237c36 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -205,6 +205,7 @@ const char *blk_status_to_str(blk_status_t status)
 		return "<null>";
 	return blk_errors[idx].name;
 }
+EXPORT_SYMBOL_GPL(blk_status_to_str);
 
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
diff --git a/block/blk.h b/block/blk.h
index 45547bcf11..f20f9ca03e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -251,7 +251,6 @@ static inline void bio_integrity_free(struct bio *bio)
 
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
-const char *blk_status_to_str(blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c0ffe203a6..7a32dc98e1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -854,6 +854,7 @@ extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
+const char *blk_status_to_str(blk_status_t status);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
-- 
2.40.1

