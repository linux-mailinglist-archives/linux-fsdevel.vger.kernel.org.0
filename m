Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE96E6F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 00:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjDRWND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjDRWMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:12:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697A658E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:12:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a66b9bd893so22335735ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681855952; x=1684447952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaRkZLFdq6iB8YT++07ypsMh1Ei2+nMtmkI0wjjAr+E=;
        b=DQxEwxdTqSrQyz/SgsBzZ6okN7gyJQO3UEeTgDqlG4shx1at6GNtFMWZP0Xx+pTQGz
         Ilf4zV000pnVNKruIpgGSZlb4tckfCgiBZLVdYBXjSt54mBUr2b4Evz0qRwj5nxJZqoh
         ZQ8vFOkG3NZB3jG0OH6W3o7du9HnNEQzRmwQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681855952; x=1684447952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaRkZLFdq6iB8YT++07ypsMh1Ei2+nMtmkI0wjjAr+E=;
        b=KOeuSSH8zfy/SOyqjLanbb/MqiCSJfmr31rUByu2O6FGqVEAcOos+aWWyfbIMi7u7O
         7OTYuNX+Neh7xnLenWKGQJcpPSrM+cQFuBj7BNZmi2XoKFYQ9JHLgoc+2yf13vC4J3CA
         PRZP3XQUtpEWCqta0ujWrQFfluxr2Y6hngMnTgDKJVcL2nrA5EQOxZHaRtra9Hkcv061
         an9WxLZG26B6JRIG4BjEjnUCwNuoI+cEBBtNWbhJjdVwHZNljpdXdZuIKvp9J4wMlaUe
         7739DxF1WP5klhIhgdnee3qDijABm1a3kpXy/0o0taAAgjtLnuaYJRRaxcMr73UdtJ5v
         wzEg==
X-Gm-Message-State: AAQBX9e1pahKIIw1RoOKjsdFskk1W5Y8xhfgHBKXP4KJIq9VaaFxhm0m
        SkiAO7/6gE22iyvvsvQvXGsbVQ==
X-Google-Smtp-Source: AKy350ZNl1P6gh+h3LisQBWkv2V6BS3Dybx8F/XFSOU7jDsCn71Yzyg3gK6TDeF5J2qCV9WWeruX4A==
X-Received: by 2002:a17:903:230c:b0:1a8:d7a:9248 with SMTP id d12-20020a170903230c00b001a80d7a9248mr2391802plh.41.1681855952618;
        Tue, 18 Apr 2023 15:12:32 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:e38b:ca5e:3203:48d3])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001a687c505e9sm9911892plv.237.2023.04.18.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:12:32 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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
Subject: [PATCH v4 3/4] dm-thin: Add REQ_OP_PROVISION support
Date:   Tue, 18 Apr 2023 15:12:06 -0700
Message-ID: <20230418221207.244685-4-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418221207.244685-1-sarthakkukreti@chromium.org>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dm-thinpool uses the provision request to provision
blocks for a dm-thin device. dm-thinpool currently does not
pass through REQ_OP_PROVISION to underlying devices.

For shared blocks, provision requests will break sharing and copy the
contents of the entire block. Additionally, if 'skip_block_zeroing'
is not set, dm-thin will opt to zero out the entire range as a part
of provisioning.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/md/dm-thin.c | 73 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 2b13c949bd72..58d633f5c928 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -274,6 +274,7 @@ struct pool {
 
 	process_bio_fn process_bio;
 	process_bio_fn process_discard;
+	process_bio_fn process_provision;
 
 	process_cell_fn process_cell;
 	process_cell_fn process_discard_cell;
@@ -913,7 +914,8 @@ static void __inc_remap_and_issue_cell(void *context,
 	struct bio *bio;
 
 	while ((bio = bio_list_pop(&cell->bios))) {
-		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD)
+		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+		    bio_op(bio) == REQ_OP_PROVISION)
 			bio_list_add(&info->defer_bios, bio);
 		else {
 			inc_all_io_entry(info->tc->pool, bio);
@@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
 
 static int io_overwrites_block(struct pool *pool, struct bio *bio)
 {
-	return (bio_data_dir(bio) == WRITE) &&
-		io_overlaps_block(pool, bio);
+	return (bio_data_dir(bio) == WRITE) && io_overlaps_block(pool, bio) &&
+	       bio_op(bio) != REQ_OP_PROVISION;
 }
 
 static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
@@ -1891,7 +1893,8 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
 
 	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size) {
 		break_sharing(tc, bio, block, &key, lookup_result, data_cell);
-		cell_defer_no_holder(tc, virt_cell);
+		if (bio_op(bio) != REQ_OP_PROVISION)
+			cell_defer_no_holder(tc, virt_cell);
 	} else {
 		struct dm_thin_endio_hook *h = dm_per_bio_data(bio, sizeof(struct dm_thin_endio_hook));
 
@@ -1953,6 +1956,51 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
 	}
 }
 
+static void process_provision_bio(struct thin_c *tc, struct bio *bio)
+{
+	int r;
+	struct pool *pool = tc->pool;
+	dm_block_t block = get_bio_block(tc, bio);
+	struct dm_bio_prison_cell *cell;
+	struct dm_cell_key key;
+	struct dm_thin_lookup_result lookup_result;
+
+	/*
+	 * If cell is already occupied, then the block is already
+	 * being provisioned so we have nothing further to do here.
+	 */
+	build_virtual_key(tc->td, block, &key);
+	if (bio_detain(pool, &key, bio, &cell))
+		return;
+
+	if (tc->requeue_mode) {
+		cell_requeue(pool, cell);
+		return;
+	}
+
+	r = dm_thin_find_block(tc->td, block, 1, &lookup_result);
+	switch (r) {
+	case 0:
+		if (lookup_result.shared) {
+			process_shared_bio(tc, bio, block, &lookup_result, cell);
+		} else {
+			bio_endio(bio);
+			cell_defer_no_holder(tc, cell);
+		}
+		break;
+	case -ENODATA:
+		provision_block(tc, bio, block, cell);
+		break;
+
+	default:
+		DMERR_LIMIT("%s: dm_thin_find_block() failed: error = %d",
+			    __func__, r);
+		cell_defer_no_holder(tc, cell);
+		bio_io_error(bio);
+		break;
+	}
+}
+
 static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
 {
 	int r;
@@ -2228,6 +2276,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			pool->process_discard(tc, bio);
+		else if (bio_op(bio) == REQ_OP_PROVISION)
+			pool->process_provision(tc, bio);
 		else
 			pool->process_bio(tc, bio);
 
@@ -2579,6 +2629,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_fail;
 		pool->process_discard = process_bio_fail;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_fail;
 		pool->process_discard_cell = process_cell_fail;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
@@ -2592,6 +2643,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_bio_success;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_read_only;
 		pool->process_discard_cell = process_cell_success;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
@@ -2612,6 +2664,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		pool->out_of_data_space = true;
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_discard_bio;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_read_only;
 		pool->process_prepared_mapping = process_prepared_mapping;
 		set_discard_callbacks(pool);
@@ -2628,6 +2681,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_write(pool->pmd);
 		pool->process_bio = process_bio;
 		pool->process_discard = process_discard_bio;
+		pool->process_provision = process_provision_bio;
 		pool->process_cell = process_cell;
 		pool->process_prepared_mapping = process_prepared_mapping;
 		set_discard_callbacks(pool);
@@ -2749,7 +2803,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_SUBMITTED;
 	}
 
-	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
+	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_PROVISION) {
 		thin_defer_bio_with_throttle(tc, bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -3396,6 +3451,9 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	pt->adjusted_pf = pt->requested_pf = pf;
 	ti->num_flush_bios = 1;
 	ti->limit_swap_bios = true;
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+	ti->max_provision_granularity = true;
 
 	/*
 	 * Only need to enable discards if the pool should pass
@@ -4288,6 +4346,9 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->max_discard_granularity = true;
 	}
 
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	spin_lock_irq(&tc->pool->lock);
@@ -4502,6 +4563,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
 	limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
+
+	limits->max_provision_sectors = pool->sectors_per_block;
 }
 
 static struct target_type thin_target = {
-- 
2.40.0.634.g4ca3ef3211-goog

