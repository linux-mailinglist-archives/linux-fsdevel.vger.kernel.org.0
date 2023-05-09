Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7E6FCBFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjEIQ6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjEIQ5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:31 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A5524E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eEGjYouYQ7iaZLNOVNtoto5kM+J4djsghn1OaVu7vs=;
        b=Li1A9oMVL5H+4ABVWOa/qXbmjoZ3SFYys6CVbgJMR6AEj6aRIewZzsTnOivgBM+vgvd0sR
        z8F2iTs2lJ0sNRombbYIDq2texP8GzEjWWA/R7gEEkxwVlS36I4S9u2K3D9FRaMqndkjgG
        6fqR0yEbyle22UucUC6Zb7BQrsGrrII=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 09/32] block: Add some exports for bcachefs
Date:   Tue,  9 May 2023 12:56:34 -0400
Message-Id: <20230509165657.1735798-10-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 block/bio.c            | 3 +++
 block/blk-core.c       | 1 +
 block/blk.h            | 1 -
 include/linux/blkdev.h | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba..1e75840d17 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1159,6 +1159,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		return false;
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
+EXPORT_SYMBOL(bio_add_folio);
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
@@ -1480,6 +1481,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
@@ -1539,6 +1541,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 static inline bool bio_remaining_done(struct bio *bio)
 {
diff --git a/block/blk-core.c b/block/blk-core.c
index 42926e6cb8..f19bcc684b 100644
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
index cc4e8873df..cc04dc73e9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -259,7 +259,6 @@ static inline void blk_integrity_del(struct gendisk *disk)
 
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
-const char *blk_status_to_str(blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f174..7cac183112 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -867,6 +867,7 @@ extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
+const char *blk_status_to_str(blk_status_t status);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
-- 
2.40.1

