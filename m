Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072FA7BC3BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjJGB3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjJGB2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:28:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E5102
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 18:28:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6969b391791so2194300b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642113; x=1697246913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqB1hDPxuIIbyhAWdDDt1cqx20h+edShJFHuWVHb1Qc=;
        b=aWgOmSUHwsmMvbEaaTkokkzio5kkq8dXlNqM0Nt2qbGhYfAhtQ3WJb4BaiBliM9EmC
         EQN730lOOGn22sCAAAfEMlGWtZDQMIfZSR5jNUUY6tFGGYtqoTEOoCqUU0ScxrcWTx/n
         4iWRGReDP3MdEdZrnMy5VeiOo5WzN8kmm2dD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642113; x=1697246913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqB1hDPxuIIbyhAWdDDt1cqx20h+edShJFHuWVHb1Qc=;
        b=ehJOv7KoEZ3NXboAta0iA3sA7mUFrRbfT9gBAYy/c47Z7bIS2li9rzFKVZUlROW8RV
         ILjBr6m2UfXICZna3Fv6slDDbLpOx+fKetofo3PQVzLbBmD/RmthN14t14jEsyV55ghc
         1noAYKBMO9mPM6yUDsfA0R4Equ2fWQYtqOXFeeh7pyDhJvcvHYgxBugo13qA54uVechS
         1YTxcgMAcHdCM7mXT/Fx4Qi+HqmX98ig03mkjWd4IbdThGl6t1PKck+FYCVegvw3wQOk
         mpB3XR/4pxobEroWQowuBV3oZ4OaG3duhO48nAZ/o116yeQcSJNAT0Fge8slE5OpPC0n
         SChw==
X-Gm-Message-State: AOJu0YyWPLgoGu1N+KSR0Tpe0F9PK2Tkm5hOb/+27DczRHTf8H4bUOuz
        7hbQ1y3CLutdu3A7YJuFbe/owA==
X-Google-Smtp-Source: AGHT+IHHJGcgIIrRozWFHSOllQB1G3Zxvy1WNHERSyRa8lFXhWz964OB7xksDw6POMFHhHNZ1hgVGg==
X-Received: by 2002:a05:6a00:3a1f:b0:690:d620:7804 with SMTP id fj31-20020a056a003a1f00b00690d6207804mr10717726pfb.13.1696642113085;
        Fri, 06 Oct 2023 18:28:33 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:138c:8976:eb4a:a91c])
        by smtp.gmail.com with UTF8SMTPSA id 20-20020aa79114000000b006969e8dac24sm2118332pfh.68.2023.10.06.18.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:28:32 -0700 (PDT)
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
Subject: [PATCH v8 4/5] dm: Add block provisioning support
Date:   Fri,  6 Oct 2023 18:28:16 -0700
Message-ID: <20231007012817.3052558-5-sarthakkukreti@chromium.org>
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

Add block provisioning support for device-mapper targets.
dm-crypt and dm-linear will, by default, passthrough REQ_OP_PROVISION
requests to the underlying device, if supported.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-crypt.c         |  4 +++-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-table.c         | 23 +++++++++++++++++++++++
 drivers/md/dm.c               |  7 +++++++
 include/linux/device-mapper.h | 17 +++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..8f94d98e241b 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3362,6 +3362,8 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		cc->tag_pool_max_sectors <<= cc->sector_shift;
 	}
 
+	ti->num_provision_bios = 1;
+
 	ret = -ENOMEM;
 	cc->io_queue = alloc_workqueue("kcryptd_io/%s", WQ_MEM_RECLAIM, 1, devname);
 	if (!cc->io_queue) {
@@ -3416,7 +3418,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index f4448d520ee9..74ee27ca551a 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->num_provision_bios = 1;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 37b48f63ae6a..1839317d047e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1856,6 +1856,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static int device_provision_capable(struct dm_target *ti, struct dm_dev *dev,
+				    sector_t start, sector_t len, void *data)
+{
+	return bdev_max_provision_sectors(dev->bdev);
+}
+
+static bool dm_table_supports_provision(struct dm_table *t)
+{
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (ti->provision_supported ||
+		    (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, device_provision_capable, NULL)))
+			return true;
+	}
+
+	return false;
+}
+
 static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
@@ -1989,6 +2009,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_write_zeroes(t))
 		q->limits.max_write_zeroes_sectors = 0;
 
+	if (!dm_table_supports_provision(t))
+		q->limits.max_provision_sectors = 0;
+
 	dm_table_verify_integrity(t);
 
 	/*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 64a1f306c96c..0e6cf1a5a414 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1598,6 +1598,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1634,6 +1635,12 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 		if (ti->max_write_zeroes_granularity)
 			max_granularity = max_sectors;
 		break;
+	case REQ_OP_PROVISION:
+		num_bios = ti->num_provision_bios;
+		max_sectors = limits->max_provision_sectors;
+		if (ti->max_provision_granularity)
+			max_granularity = max_sectors;
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..41fd4e456d1f 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -332,6 +332,12 @@ struct dm_target {
 	 */
 	unsigned int num_write_zeroes_bios;
 
+	/*
+	 * The number of PROVISION bios that will be submitted to the target.
+	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
+	 */
+	unsigned int num_provision_bios;
+
 	/*
 	 * The minimum number of extra bytes allocated in each io for the
 	 * target to use.
@@ -356,6 +362,11 @@ struct dm_target {
 	 */
 	bool discards_supported:1;
 
+	/* Set if this target needs to receive provision requests regardless of
+	 * whether or not its underlying devices have support.
+	 */
+	bool provision_supported:1;
+
 	/*
 	 * Set if this target requires that discards be split on
 	 * 'max_discard_sectors' boundaries.
@@ -374,6 +385,12 @@ struct dm_target {
 	 */
 	bool max_write_zeroes_granularity:1;
 
+	/*
+	 * Set if this target requires that provisions be split on
+	 * 'max_provision_sectors' boundaries.
+	 */
+	bool max_provision_granularity:1;
+
 	/*
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
-- 
2.42.0.609.gbb76f46606-goog

