Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCAF658A47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiL2INb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiL2INT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A4B48F
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so18285398pjo.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGTS43jY2w8jm4acf0IFMpzxibmXYw0wZeBsvWcE3NI=;
        b=ESIIlie7g6zZ/ES0wwvkxs/yh+YarKylqT2dcIkLBDXtSdlLAhLNtDyTEOYOzqRvTt
         yvleBhwtt6piRkZ1AbUwgXVyMufcEl99TQn0HFQM5kyqn7av3cLbbu+S49Ahav6yLl0l
         33VPN8E+sneh7QckXjjA0GLOp5T4gOlao+cPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGTS43jY2w8jm4acf0IFMpzxibmXYw0wZeBsvWcE3NI=;
        b=fvU1qvS7nunkX4y6uhP2dGnClw5VW44gJ61TnmnQQYK2YdH40sZQxUAySOTKlwueyB
         vkYqPuXbCiKTkn8ZGNh7wFKJiEAEgmY7hS9marKh2c16V8bHqCuc52HLFnusNCQgSfRa
         khMn5b50CpmluVmzwFBUzoDKiNWu+B2PqdTicCAZPhFhsaFKgdFzQI0O+v4wtvahXYa1
         selea3brl+wj/Y1KhgcS2MIur9m4z8m/XksfxiKhq6Ix8uJSvwQF8/DoPdxnQQQS7tDP
         3Fgrk1O5a6dJfz/vmOb4udIqPRnYZt84Io4TZI8NsFQA8wc8C9k7DKgM0JsmW09JJcns
         5nAQ==
X-Gm-Message-State: AFqh2kp++ppVkpaWjhnAHiK1xglLJB3gZ3quRLp8ZyFbWuQ+GPdz2hIz
        pfGhKfR21XGmO6CJ8CJAaLchsw==
X-Google-Smtp-Source: AMrXdXtCqORihZF9SwuWUqetXWe9iVm3jlR8L/IVs3risC7ggBVbqn40CWo00UuzV3AXBqtcxJtPjg==
X-Received: by 2002:a17:902:f08a:b0:189:c19a:2cd9 with SMTP id p10-20020a170902f08a00b00189c19a2cd9mr27993581pla.25.1672301583922;
        Thu, 29 Dec 2022 00:13:03 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:03 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 2/7] dm: Add support for block provisioning
Date:   Thu, 29 Dec 2022 00:12:47 -0800
Message-Id: <20221229081252.452240-3-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
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

Add support to dm devices for REQ_OP_PROVISION. The default mode
is to pass through the request and dm-thin will utilize it to provision
blocks.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/md/dm-crypt.c         |  4 +-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-snap.c          |  7 +++
 drivers/md/dm-table.c         | 25 ++++++++++
 drivers/md/dm-thin.c          | 90 ++++++++++++++++++++++++++++++++++-
 drivers/md/dm.c               |  4 ++
 include/linux/device-mapper.h | 11 +++++
 7 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2653516bcdef..7089a414c3d1 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	if (ret)
 		return ret;
 
+	ti->num_provision_bios = 1;
+
 	while (opt_params--) {
 		opt_string = dm_shift_arg(&as);
 		if (!opt_string) {
@@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3212ef6aa81b..1aa782149428 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->num_provision_bios = 1;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index d1c2f84d27e3..d4d2599e3620 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1357,6 +1357,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (s->discard_zeroes_cow)
 		ti->num_discard_bios = (s->discard_passdown_origin ? 2 : 1);
 	ti->per_io_data_size = sizeof(struct dm_snap_tracked_chunk);
+	ti->num_provision_bios = 1;
 
 	/* Add snapshot to the list of snapshots for this origin */
 	/* Exceptions aren't triggered till snapshot_resume() is called */
@@ -2001,6 +2002,11 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 	/* If the block is already remapped - use that, else remap it */
 	e = dm_lookup_exception(&s->complete, chunk);
 	if (e) {
+		if (unlikely(bio_op(bio) == REQ_OP_PROVISION)) {
+			bio_endio(bio);
+			r = DM_MAPIO_SUBMITTED;
+			goto out_unlock;
+		}
 		remap_exception(s, e, bio, chunk);
 		if (unlikely(bio_op(bio) == REQ_OP_DISCARD) &&
 		    io_overlaps_chunk(s, bio)) {
@@ -2414,6 +2420,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		/* All discards are split on chunk_size boundary */
 		limits->discard_granularity = snap->store->chunk_size;
 		limits->max_discard_sectors = snap->store->chunk_size;
+		limits->max_provision_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
 	}
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8541d5688f3a..35f8d670935e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1853,6 +1853,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static int device_provision_capable(struct dm_target *ti, struct dm_dev *dev,
+				    sector_t start, sector_t len, void *data)
+{
+	return !bdev_max_provision_sectors(dev->bdev);
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
@@ -1987,6 +2007,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_write_zeroes(t))
 		q->limits.max_write_zeroes_sectors = 0;
 
+	if (dm_table_supports_provision(t))
+		blk_queue_max_provision_sectors(q, UINT_MAX >> 9);
+	else
+		q->limits.max_provision_sectors = 0;
+
 	dm_table_verify_integrity(t);
 
 	/*
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 64cfcf46881d..ab3f1abfabaf 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1012,6 +1012,14 @@ static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 		goto out;
 	}
 
+	/* For provision requests, return once the prepared block has been inserted
+	 * into the mapping btree.
+	 */
+	if (bio && bio_op(bio) == REQ_OP_PROVISION) {
+		bio_endio(bio);
+		goto out;
+	}
+
 	/*
 	 * Release any bios held while the block was being provisioned.
 	 * If we are processing a write bio that completely covers the block,
@@ -1239,7 +1247,7 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
 
 static int io_overwrites_block(struct pool *pool, struct bio *bio)
 {
-	return (bio_data_dir(bio) == WRITE) &&
+	return (bio_data_dir(bio) == WRITE) && bio_op(bio) != REQ_OP_PROVISION &&
 		io_overlaps_block(pool, bio);
 }
 
@@ -1388,6 +1396,10 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
 	m->data_block = data_block;
 	m->cell = cell;
 
+	/* Provision requests are chained on the original bio. */
+	if (bio && bio_op(bio) == REQ_OP_PROVISION)
+		m->bio = bio;
+
 	/*
 	 * If the whole block of data is being overwritten or we are not
 	 * zeroing pre-existing data, we can issue the bio immediately.
@@ -1980,6 +1992,70 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
 	}
 }
 
+static void process_provision_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
+{
+	int r;
+	struct pool *pool = tc->pool;
+	struct bio *bio = cell->holder;
+	dm_block_t begin, end;
+	struct dm_thin_lookup_result lookup_result;
+
+	if (tc->requeue_mode) {
+		cell_requeue(pool, cell);
+		return;
+	}
+
+	get_bio_block_range(tc, bio, &begin, &end);
+
+	while (begin != end) {
+		r = ensure_next_mapping(pool);
+		if (r)
+			/* we did our best */
+			return;
+
+		r = dm_thin_find_block(tc->td, begin, 1, &lookup_result);
+		switch (r) {
+		case 0:
+			begin++;
+			break;
+		case -ENODATA:
+			bio_inc_remaining(bio);
+			provision_block(tc, bio, begin, cell);
+			begin++;
+			break;
+		default:
+			DMERR_LIMIT(
+				"%s: dm_thin_find_block() failed: error = %d",
+				__func__, r);
+			cell_defer_no_holder(tc, cell);
+			bio_io_error(bio);
+			begin++;
+			break;
+		}
+	}
+	bio_endio(bio);
+	cell_defer_no_holder(tc, cell);
+}
+
+static void process_provision_bio(struct thin_c *tc, struct bio *bio)
+{
+	dm_block_t begin, end;
+	struct dm_cell_key virt_key;
+	struct dm_bio_prison_cell *virt_cell;
+
+	get_bio_block_range(tc, bio, &begin, &end);
+	if (begin == end) {
+		bio_endio(bio);
+		return;
+	}
+
+	build_key(tc->td, VIRTUAL, begin, end, &virt_key);
+	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
+		return;
+
+	process_provision_cell(tc, virt_cell);
+}
+
 static void process_bio(struct thin_c *tc, struct bio *bio)
 {
 	struct pool *pool = tc->pool;
@@ -2200,6 +2276,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			pool->process_discard(tc, bio);
+		else if (bio_op(bio) == REQ_OP_PROVISION)
+			process_provision_bio(tc, bio);
 		else
 			pool->process_bio(tc, bio);
 
@@ -2716,7 +2794,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_SUBMITTED;
 	}
 
-	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
+	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_PROVISION) {
 		thin_defer_bio_with_throttle(tc, bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -3355,6 +3434,8 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	pt->low_water_blocks = low_water_blocks;
 	pt->adjusted_pf = pt->requested_pf = pf;
 	ti->num_flush_bios = 1;
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
 
 	/*
 	 * Only need to enable discards if the pool should pass
@@ -4053,6 +4134,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
 	}
 
+
 	/*
 	 * pt->adjusted_pf is a staging area for the actual features to use.
 	 * They get transferred to the live pool in bind_control_target()
@@ -4243,6 +4325,9 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		ti->num_discard_bios = 1;
 	}
 
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	spin_lock_irq(&tc->pool->lock);
@@ -4457,6 +4542,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
 	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
+	limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */
 }
 
 static struct target_type thin_target = {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e1ea3a7bd9d9..4d19bae9da4a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1587,6 +1587,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1611,6 +1612,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 	case REQ_OP_WRITE_ZEROES:
 		num_bios = ti->num_write_zeroes_bios;
 		break;
+	case REQ_OP_PROVISION:
+		num_bios = ti->num_provision_bios;
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 04c6acf7faaa..b4d97d5d75b8 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -333,6 +333,12 @@ struct dm_target {
 	 */
 	unsigned num_write_zeroes_bios;
 
+	/*
+	 * The number of PROVISION bios that will be submitted to the target.
+	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
+	 */
+	unsigned num_provision_bios;
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
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
-- 
2.37.3

