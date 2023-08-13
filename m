Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B077AA93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHMS0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHMS0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:26:45 -0400
Received: from out-91.mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBB10CE
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 11:26:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691951205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hovXn5ip36DS/VfaxiJk0ApcnzjAAiHK50gEPXD0AU=;
        b=smDf044WC19eh3eqFCYUrnKUUiiGvZZmbA+EBT5Fd7adDUWrAxoIEBVNqEHQGa6D4SDDPR
        2BiFU0WBFfR8saWKeuF928gbWW2kwuIirUc4AK3TG3yMU+onNR3y/SWh7uK7CPpjPwcuHT
        qBXdszf6xdTqPQlqWoD2HnjB6ociBik=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/3] block: Bring back zero_fill_bio_iter
Date:   Sun, 13 Aug 2023 14:26:36 -0400
Message-Id: <20230813182636.2966159-4-kent.overstreet@linux.dev>
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

This reverts 6f822e1b5d9dda3d20e87365de138046e3baa03a - this helper is
used by bcachefs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bio.c         | 6 +++---
 include/linux/bio.h | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e74a04ea14..70b5c987bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -606,15 +606,15 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-void zero_fill_bio(struct bio *bio)
+void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
-	bio_for_each_segment(bv, bio, iter)
+	__bio_for_each_segment(bv, bio, iter, start)
 		memzero_bvec(&bv);
 }
-EXPORT_SYMBOL(zero_fill_bio);
+EXPORT_SYMBOL(zero_fill_bio_iter);
 
 /**
  * bio_truncate - truncate the bio to small size of @new_size
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3e7529ff5..f2620f8d18 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,7 +484,12 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
-void zero_fill_bio(struct bio *bio);
+void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
+
+static inline void zero_fill_bio(struct bio *bio)
+{
+	zero_fill_bio_iter(bio, bio->bi_iter);
+}
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-- 
2.40.1

