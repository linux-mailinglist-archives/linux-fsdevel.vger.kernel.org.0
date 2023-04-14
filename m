Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48606E1892
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDNACv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDNACq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:02:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B763C1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso20082003pjs.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681430563; x=1684022563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbgRTE0x4Vz9bKIXx5TwXFxZnllEKND24a06IseMh6w=;
        b=J924py0HmWPxuONvev1tIDUqUjf7hA6nM89DwsvTXcqSkYCCQZLWUjUt/k+HM1FjQC
         G+VDAZC4VQpvgoWnHmV9J+893oVIcJ4VWbWfzgqCWtDzVczJCwZlq14h3qxGBh7BYtIe
         96nys3WELbf5RZXAZkhasmJotINZywaUNgWyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681430563; x=1684022563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbgRTE0x4Vz9bKIXx5TwXFxZnllEKND24a06IseMh6w=;
        b=PQgWqXd6lgYKB4VUC1VqRZGyvLLoLAFZAq6YCokH+dEh4noHUMSqLDs6AAZkmspALy
         0cnL91hIpq1nvVbuxsS7vpU/RRwpIYpeeOXBK64t/+yBGgmTVMmtd7QbfEfVHpogGNWx
         47X5Gba5lQJRh6wYb8h/UV/LpFQEBIxwTorW5mzhOuf24GP082ln1H3Bfa4OuQGBJTO/
         KVlaltoQYkKRyAgiiIk2WXJ+IIUF7xJ5wIXkPUyXdW01EVgWs7wNro0Wf1LdwkhH+Nuk
         bDU1q16+3TK3sWThKtLLtgh1rH4aGbydZbUaIlmIx8UdZuuB1JIxVQ3iITuwFomrvBA3
         8ecg==
X-Gm-Message-State: AAQBX9fUmVv3sn2n/g2o3q0Xyf0r08Ff4lwVZBoqGLQfNHE8r0EBNBLn
        /dQGbzXj0RCbD/vKd2phGnP4/A==
X-Google-Smtp-Source: AKy350a3orAemKhQwWjvUDNZ3/O00wopkJZ0ap82QvyONMfrDVr1qEWggV6UX8mwCxKt9zLwNu4mdQ==
X-Received: by 2002:a17:90a:784e:b0:233:ee67:8eb3 with SMTP id y14-20020a17090a784e00b00233ee678eb3mr3507664pjl.24.1681430563219;
        Thu, 13 Apr 2023 17:02:43 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:72cc:7fa5:adcb:7c02])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090a891200b002470f179b92sm2212939pjn.43.2023.04.13.17.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:02:42 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dm: Add support for block provisioning
Date:   Thu, 13 Apr 2023 17:02:18 -0700
Message-ID: <20230414000219.92640-3-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414000219.92640-1-sarthakkukreti@chromium.org>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org>
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
is to passthrough the request to the underlying device, if it
supports it. dm-thinpool uses the provision request to provision
blocks for a dm-thin device. dm-thinpool currently does not
pass through REQ_OP_PROVISION to underlying devices.

For shared blocks, provision requests will break sharing and copy the
contents of the entire block.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/md/dm-crypt.c         |   4 +-
 drivers/md/dm-linear.c        |   1 +
 drivers/md/dm-snap.c          |   7 +++
 drivers/md/dm-table.c         |  25 ++++++++
 drivers/md/dm-thin.c          | 110 +++++++++++++++++++++++++++++++---
 drivers/md/dm.c               |   4 ++
 include/linux/device-mapper.h |  11 ++++
 7 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3ba53dc3cc3f..5c655bfd4686 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3087,6 +3087,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	if (ret)
 		return ret;
 
+	ti->num_provision_bios = 1;
+
 	while (opt_params--) {
 		opt_string = dm_shift_arg(&as);
 		if (!opt_string) {
@@ -3390,7 +3392,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3e622dcc9dbd..7843e548e850 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->num_provision_bios = 1;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index f766c21408f1..f6b224a12000 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1358,6 +1358,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (s->discard_zeroes_cow)
 		ti->num_discard_bios = (s->discard_passdown_origin ? 2 : 1);
 	ti->per_io_data_size = sizeof(struct dm_snap_tracked_chunk);
+	ti->num_provision_bios = 1;
 
 	/* Add snapshot to the list of snapshots for this origin */
 	/* Exceptions aren't triggered till snapshot_resume() is called */
@@ -2003,6 +2004,11 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
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
@@ -2413,6 +2419,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		/* All discards are split on chunk_size boundary */
 		limits->discard_granularity = snap->store->chunk_size;
 		limits->max_discard_sectors = snap->store->chunk_size;
+		limits->max_provision_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
 	}
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2055a758541d..5985343384a7 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1850,6 +1850,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
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
@@ -1983,6 +2003,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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
index 13d4677baafd..b08b7ae617be 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -909,7 +909,8 @@ static void __inc_remap_and_issue_cell(void *context,
 	struct bio *bio;
 
 	while ((bio = bio_list_pop(&cell->bios))) {
-		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD)
+		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+		    bio_op(bio) == REQ_OP_PROVISION)
 			bio_list_add(&info->defer_bios, bio);
 		else {
 			inc_all_io_entry(info->tc->pool, bio);
@@ -1013,6 +1014,15 @@ static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 		goto out;
 	}
 
+	/*
+	 * For provision requests, once the prepared block has been inserted
+	 * into the mapping btree, return.
+	 */
+	if (bio && bio_op(bio) == REQ_OP_PROVISION) {
+		bio_endio(bio);
+		return;
+	}
+
 	/*
 	 * Release any bios held while the block was being provisioned.
 	 * If we are processing a write bio that completely covers the block,
@@ -1241,7 +1251,7 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
 
 static int io_overwrites_block(struct pool *pool, struct bio *bio)
 {
-	return (bio_data_dir(bio) == WRITE) &&
+	return (bio_data_dir(bio) == WRITE) && bio_op(bio) != REQ_OP_PROVISION &&
 		io_overlaps_block(pool, bio);
 }
 
@@ -1334,10 +1344,11 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
 	/*
 	 * IO to pool_dev remaps to the pool target's data_dev.
 	 *
-	 * If the whole block of data is being overwritten, we can issue the
-	 * bio immediately. Otherwise we use kcopyd to clone the data first.
+	 * If the whole block of data is being overwritten and if this is not a
+	 * provision request, we can issue the bio immediately.
+	 * Otherwise we use kcopyd to clone the data first.
 	 */
-	if (io_overwrites_block(pool, bio))
+	if (io_overwrites_block(pool, bio) && bio_op(bio) != REQ_OP_PROVISION)
 		remap_and_issue_overwrite(tc, bio, data_dest, m);
 	else {
 		struct dm_io_region from, to;
@@ -1356,7 +1367,8 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
 		/*
 		 * Do we need to zero a tail region?
 		 */
-		if (len < pool->sectors_per_block && pool->pf.zero_new_blocks) {
+		if (len < pool->sectors_per_block && pool->pf.zero_new_blocks &&
+		    bio_op(bio) != REQ_OP_PROVISION) {
 			atomic_inc(&m->prepare_actions);
 			ll_zero(tc, m,
 				data_dest * pool->sectors_per_block + len,
@@ -1390,6 +1402,10 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
 	m->data_block = data_block;
 	m->cell = cell;
 
+	/* Provision requests are chained on the original bio. */
+	if (bio && bio_op(bio) == REQ_OP_PROVISION)
+		m->bio = bio;
+
 	/*
 	 * If the whole block of data is being overwritten or we are not
 	 * zeroing pre-existing data, we can issue the bio immediately.
@@ -1865,7 +1881,8 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
 
 	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size) {
 		break_sharing(tc, bio, block, &key, lookup_result, data_cell);
-		cell_defer_no_holder(tc, virt_cell);
+		if (bio_op(bio) != REQ_OP_PROVISION)
+			cell_defer_no_holder(tc, virt_cell);
 	} else {
 		struct dm_thin_endio_hook *h = dm_per_bio_data(bio, sizeof(struct dm_thin_endio_hook));
 
@@ -1982,6 +1999,73 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
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
+			if (lookup_result.shared)
+				process_shared_bio(tc, bio, begin,
+						   &lookup_result, cell);
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
@@ -2202,6 +2286,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			pool->process_discard(tc, bio);
+		else if (bio_op(bio) == REQ_OP_PROVISION)
+			process_provision_bio(tc, bio);
 		else
 			pool->process_bio(tc, bio);
 
@@ -2723,7 +2809,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_SUBMITTED;
 	}
 
-	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
+	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_PROVISION) {
 		thin_defer_bio_with_throttle(tc, bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -3370,6 +3457,8 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	pt->adjusted_pf = pt->requested_pf = pf;
 	ti->num_flush_bios = 1;
 	ti->limit_swap_bios = true;
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
 
 	/*
 	 * Only need to enable discards if the pool should pass
@@ -4068,6 +4157,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
 	}
 
+
 	/*
 	 * pt->adjusted_pf is a staging area for the actual features to use.
 	 * They get transferred to the live pool in bind_control_target()
@@ -4261,6 +4351,9 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->num_discard_bios = 1;
 	}
 
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	spin_lock_irq(&tc->pool->lock);
@@ -4475,6 +4568,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
 	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
+	limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */
 }
 
 static struct target_type thin_target = {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dfde0088147a..d8f1803062b7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1593,6 +1593,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1617,6 +1618,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
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
index 7975483816e4..e9f687521ae6 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -334,6 +334,12 @@ struct dm_target {
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
@@ -358,6 +364,11 @@ struct dm_target {
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
2.40.0.634.g4ca3ef3211-goog

