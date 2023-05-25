Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138A71197E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbjEYVtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbjEYVs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:48:56 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1753187
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:48:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685051323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+22zFUlhJ4/Nilv6vd89LkwuBMkrL2eqeqGA9rGrBE=;
        b=fn2krtHuT8UMeFih/swTHt8b6yF3vM7g70Hi+yB4MJM5KG865506387QlEFttRFCJtp2Nw
        QnZcy0m7WmMazGm4KKVMQJEdiuumzhkQizBcKtLl4+C/JtgZiVbldhOViVQzlQd3ZGnFHb
        vxPRXiDQJDvu6UPYtVwmui1S3uhIFho=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/7] block: Add documentation for bio iterator macros
Date:   Thu, 25 May 2023 17:48:21 -0400
Message-Id: <20230525214822.2725616-7-kent.overstreet@linux.dev>
In-Reply-To: <20230525214822.2725616-1-kent.overstreet@linux.dev>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
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

We've now got 3x2 interfaces for iterating over bios: by page, by bvec,
or by folio, and variants that iterate over what bi_iter points to, or
the entire bio as created by the filesystem/originator.

This adds more detailed kerneldoc comments for each variant.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
---
 include/linux/bio.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7ced281734..e9d4d9e776 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -103,9 +103,14 @@ static inline void bio_iter_all_advance(const struct bio *bio,
 		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
 	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
 
-/*
- * drivers should _never_ use the all version - the bio may have been split
- * before it got to the driver and the driver won't own all of it
+/**
+ * bio_for_each_segment_all - iterate over single pages in a bio
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_segment_all(bvl, bio, iter)			\
 	for (bvec_iter_all_init(&iter);					\
@@ -166,6 +171,13 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
+/**
+ * bio_for_each_segment - iterate over single pages in a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
@@ -202,6 +214,13 @@ static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
 		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
 	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))
 
+/**
+ * bio_for_each_folio - iterate over folios within a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_folio(bvl, bio, iter)				\
 	__bio_for_each_folio(bvl, bio, iter, (bio)->bi_iter)
 
@@ -211,13 +230,30 @@ static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
 		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
-/* iterate over multi-page bvec */
+/**
+ * bio_for_each_bvec - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_bvec(bvl, bio, iter)			\
 	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
 
 /*
- * Iterate over all multi-page bvecs. Drivers shouldn't use this version for the
- * same reasons as bio_for_each_segment_all().
+ * bio_for_each_bvec_all - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
@@ -323,6 +359,12 @@ static inline struct folio_vec bio_folio_iter_all_peek(const struct bio *bio,
  * bio_for_each_folio_all - Iterate over each folio in a bio.
  * @fi: struct bio_folio_iter_all which is updated for each folio.
  * @bio: struct bio to iterate over.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_folio_all(fv, bio, iter)				\
 	for (bvec_iter_all_init(&iter);					\
-- 
2.40.1

