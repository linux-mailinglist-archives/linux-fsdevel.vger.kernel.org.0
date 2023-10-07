Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326E67BC3C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjJGB3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJGB2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:28:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE4111
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 18:28:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so1790782a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642115; x=1697246915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVF8rK/kC1UjwzLMGR23sx6dhVRDno9128uSIr9eCP0=;
        b=P0+yXjgCOTUKvlSLPHb+2kHOtP+XtZ11kXrFLvwoGtJ66JfgQBSp0acWdl8BISfCSp
         FThOk1VdUlynLlHNHkjSEdN+Bhc6FenoYpFSE41mWxw0YNMUYrLSYcHZAW7sANBRnnbi
         3+mJkHXzd4QQqnItdnay2svjjS4LX9gzP7nT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642115; x=1697246915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVF8rK/kC1UjwzLMGR23sx6dhVRDno9128uSIr9eCP0=;
        b=Pl0RnvaVOxm2bgFG16vur0Ml4EuKgppu/73QOq0vw164dutTN4e/nZ91c0fteuAKZf
         AD1W2yoRsOYA3eewXiNlqtMhsrV6Q/SHFdQcyzqHSYEeTeteDnpRewHo31AcP3DRIypX
         lWM6gBZkgFxeGmyNGW4qUb376SOcZ8BTsguc4pn8VMp0ulY3cjtY612RfjS8ZGKar+YJ
         bpC4tjs1xE+Z/0+QDEmWmBTq0u1djJmNxnT37tOPcofoVQP5lhArypXqPzQBhx58VbM+
         +qv6PHyvqliV9tXaLqZl9GNFBW07i/4HSGmOg56egal3e/uVdsQq6SreNz3cvAyGWTyf
         aV/g==
X-Gm-Message-State: AOJu0YxTLLcAhQOBGBI9IpbgHLwtFbIQmdTaKZ4eAEW/iLPsiYuZ/pIj
        XAutLLcW6yHxIDvzBT1aNsjaMA==
X-Google-Smtp-Source: AGHT+IH2NlEgTF700gNIZ6cKPt2q6/f6H70TDkXk3G6q0Gl7oflk7/S43yTcoNGZnNyMpgrw6cyE+g==
X-Received: by 2002:a05:6830:1bf2:b0:6bb:1036:46de with SMTP id k18-20020a0568301bf200b006bb103646demr10472104otb.30.1696642115522;
        Fri, 06 Oct 2023 18:28:35 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:138c:8976:eb4a:a91c])
        by smtp.gmail.com with UTF8SMTPSA id w25-20020a639359000000b00553dcfc2179sm4002014pgm.52.2023.10.06.18.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:28:35 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
Date:   Fri,  6 Oct 2023 18:28:17 -0700
Message-ID: <20231007012817.3052558-6-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
annotate unshare requests to underlying layers. Layers that support
FALLOC_FL_UNSHARE will be able to use this as an indicator of which
fallocate() mode to use.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/blk-lib.c           |  6 +++++-
 block/fops.c              |  6 ++++--
 drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  3 ++-
 5 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index b1f720e198cd..d6cf572605f5 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -350,6 +350,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
  * @sector:	start sector
  * @nr_sects:	number of sectors to provision
  * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @flags:	controls detailed behavior
  *
  * Description:
  *  Issues a provision request to the block device for the range of sectors.
@@ -357,7 +358,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
  *  underlying storage pool to allocate space for this block range.
  */
 int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp)
+		sector_t nr_sects, gfp_t gfp, unsigned flags)
 {
 	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	unsigned int max_sectors = bdev_max_provision_sectors(bdev);
@@ -380,6 +381,9 @@ int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_iter.bi_size = req_sects << SECTOR_SHIFT;
 
+		if (flags & BLKDEV_PROVISION_UNSHARE_RANGE)
+			bio->bi_opf |= REQ_UNSHARE;
+
 		sector += req_sects;
 		nr_sects -= req_sects;
 		if (!nr_sects) {
diff --git a/block/fops.c b/block/fops.c
index 99b24bd9d461..dd442b6f0486 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,8 +782,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	case FALLOC_FL_UNSHARE_RANGE:
 	case FALLOC_FL_KEEP_SIZE:
 	case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
-					       len >> SECTOR_SHIFT, GFP_KERNEL);
+		error = blkdev_issue_provision(
+				bdev, start >> SECTOR_SHIFT, len >> SECTOR_SHIFT, GFP_KERNEL,
+				(mode & FALLOC_FL_UNSHARE_RANGE) ?
+					BLKDEV_PROVISION_UNSHARE_RANGE : 0);
 		break;
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index abb4dddbd4fd..f30479deb615 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -306,6 +306,30 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static bool validate_fallocate_mode(struct loop_device *lo, int mode)
+{
+	bool ret = true;
+
+	switch (mode) {
+	case FALLOC_FL_PUNCH_HOLE:
+	case FALLOC_FL_ZERO_RANGE:
+		if (!bdev_max_discard_sectors(lo->lo_device))
+			ret = false;
+		break;
+	case 0:
+	case FALLOC_FL_UNSHARE_RANGE:
+		if (!bdev_max_provision_sectors(lo->lo_device))
+			ret = false;
+		break;
+
+	default:
+		ret = false;
+	}
+
+	return ret;
+}
+
+
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
@@ -316,11 +340,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	struct file *file = lo->lo_backing_file;
 	int ret;
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
-	    !bdev_max_discard_sectors(lo->lo_device))
-		return -EOPNOTSUPP;
-
-	if (mode == 0 && !bdev_max_provision_sectors(lo->lo_device))
+	if (!validate_fallocate_mode(lo, mode))
 		return -EOPNOTSUPP;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
@@ -493,7 +513,10 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_PROVISION:
-		return lo_fallocate(lo, rq, pos, 0);
+		return lo_fallocate(lo, rq, pos,
+				    (rq->cmd_flags & REQ_UNSHARE) ?
+					    FALLOC_FL_UNSHARE_RANGE :
+					    0);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e55828ddfafe..f16187ae4c4a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -430,6 +430,8 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	/* for REQ_OP_PROVISION: */
+	__REQ_UNSHARE,		/* unshare blocks */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -458,6 +460,7 @@ enum req_flag_bits {
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
+#define REQ_UNSHARE	(__force blk_opf_t)(1ULL << __REQ_UNSHARE)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dcae5538f99a..0f88ccbde12f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1042,10 +1042,11 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 
 extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask);
+		sector_t nr_sects, gfp_t gfp_mask, unsigned int flags);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_PROVISION_UNSHARE_RANGE	(1 << 2)  /* unshare range on provision */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
-- 
2.42.0.609.gbb76f46606-goog

