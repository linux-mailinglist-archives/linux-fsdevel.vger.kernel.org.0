Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D375124E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGLVMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjGLVLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:42 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC41FFD
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JvFlUnJNg/19MdiHLNUIX73kgMJww+dfgCblmEcu1U=;
        b=ioo7Hlb05gzTDWYnW+QeyN9R+3fGtpTq8//vnD2VrzbgJKDTQEkVCE4P4f2TYbuiCQhSbu
        sec4FOu9SqqU17hb0GbaFF3qcgRtj0mZbf7jTv8vr/R9kAlIggYzlRhurx6BhRUWxiUewA
        qPzUxqlRuNs66nkA93vgzfPg3zuiRmw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 04/20] block: Add some exports for bcachefs
Date:   Wed, 12 Jul 2023 17:10:59 -0400
Message-Id: <20230712211115.2174650-5-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

