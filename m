Return-Path: <linux-fsdevel+bounces-2667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66807E7639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 02:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E622815D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E3D1859;
	Fri, 10 Nov 2023 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/XOAW1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB25136F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 01:01:51 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD03ABF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:01:50 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1263201b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699578110; x=1700182910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpIlXDAK836nj2ayS4Px4IQ+M7LfyqBN0RSk77HlWk0=;
        b=k/XOAW1f2zktIdEXBUiXfdYhwhgWtVlr87eGvmwU2ejrxqU+850JvCg1XcwvC1mEYW
         gP5WDvEj97Obv35crFQ95piifEtQrhQ8GNo+TtEfJCUXdqbq+MD3M8I63sFfMoWdvBrp
         MoTNeKUtOhbfWib9M55IFaaDAZ1z1pPuhkdGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578110; x=1700182910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpIlXDAK836nj2ayS4Px4IQ+M7LfyqBN0RSk77HlWk0=;
        b=wNCgKGqbX/wTB2FChiJ6+t39kAJERMVu3migXYtkPhbQq9NXbzo9P88wiuWLlsEt1+
         XlIQwT0ONTK6d9/+QEbHlOQPku4o7ZnBb+XVTUOkrdb9bII4yAVSVQ8PA+Jx0gCxxWEW
         2txfewhgSZvuuGf6sjLtUj9WzKg7sb4kcgoA6XjhFuq4BomlxaDDRDTLwBORrZgq2Zcp
         Oc9VBVL3wEM6ABIv2V2DMPezTz15TWeKoHW1Tj4tYIHh2yGTTlavyrZmP1556C/Wxxoz
         Mz32xRdgIU+t3xorbaEMukFBXD7ayNW5HFQikYXZke0RZUnuDjJIjcXWAcpOJ+VYrQzK
         vfvw==
X-Gm-Message-State: AOJu0Yz5AKo3OtouZyyfvT1WLOYNgZBMB/dXERJVSz4P1NXXg/gkCnir
	eZgGRKjg+WyRZeRobCsqdG/ohw==
X-Google-Smtp-Source: AGHT+IFs9+3vv5SiURWJQfxLcqgU9CLjws5ou3tIHtJ9h+cXOfzdemON/fbHWOOjBj5e21c6QxkEEw==
X-Received: by 2002:a05:6a00:6592:b0:6bf:15fb:4b32 with SMTP id hd18-20020a056a00659200b006bf15fb4b32mr1401432pfb.8.1699578110109;
        Thu, 09 Nov 2023 17:01:50 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e584:25c0:d29c:54c])
        by smtp.gmail.com with UTF8SMTPSA id k76-20020a636f4f000000b005b529d633b7sm5224838pgc.14.2023.11.09.17.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:01:49 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <david@fromorbit.com>,
	Brian Foster <bfoster@redhat.com>,
	Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v9 2/3] dm: Add block provisioning support
Date: Thu,  9 Nov 2023 17:01:37 -0800
Message-ID: <20231110010139.3901150-3-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 6de107aff331..1d18926ae801 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3365,6 +3365,8 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		cc->tag_pool_max_sectors <<= cc->sector_shift;
 	}
 
+	ti->num_provision_bios = 1;
+
 	ret = -ENOMEM;
 	cc->io_queue = alloc_workqueue("kcryptd_io/%s", WQ_MEM_RECLAIM, 1, devname);
 	if (!cc->io_queue) {
@@ -3419,7 +3421,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2d3e186ca87e..8d2dc9dfe93e 100644
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
index 198d38b53322..f29100fc1a60 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1877,6 +1877,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
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
@@ -2010,6 +2030,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_write_zeroes(t))
 		q->limits.max_write_zeroes_sectors = 0;
 
+	if (!dm_table_supports_provision(t))
+		q->limits.max_provision_sectors = 0;
+
 	dm_table_verify_integrity(t);
 
 	/*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 23c32cd1f1d8..2e207fa0b0f4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1609,6 +1609,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1645,6 +1646,12 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
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
index 772ab4d74d94..c1d674d32444 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -333,6 +333,12 @@ struct dm_target {
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
@@ -357,6 +363,11 @@ struct dm_target {
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
@@ -375,6 +386,12 @@ struct dm_target {
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
2.39.2


