Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949F7708BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 00:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjERWeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjERWeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 18:34:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4B1713
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae7033f4e5so1475635ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684449238; x=1687041238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0RjYl/m1xYKkWDD1lX4N49WRpVnJJ8wbKxnpktlyn8=;
        b=lU2Z98AVSCgdcM0/aMT/tYZ4d9YuthlRR0I0JpCnxQmD7LS6B//t6CkdxVppfoIxZj
         jGmarxCXKmU886bWSV2hjLAJTLP8j6tKiO63WZxawmzHuieTa2vbil4oQkUagUzGp9rS
         g/G7CpzZoTy7r0BXfdrJv0rl20/K0MNTJNJmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449238; x=1687041238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0RjYl/m1xYKkWDD1lX4N49WRpVnJJ8wbKxnpktlyn8=;
        b=gEvIe3yL396KspUhIqyvcTo2xFdPXF8mad8GmGQLlBxTztlu2fa0zv16PGKI2CJ2pk
         aMHJeRp9VcXFWJj813/A6d36aCy087+8BdQvVujHNJYHLW9iP3zobk9u5pQ8BF620tTG
         MIMDCyHnLu1Im+CopVoObpL/08CtPMJTIXPL8VQJAXk5zxIsQkgle9urk0WHUgTcqzfz
         ERhsEWlha1hNpqyjVwcxwDrKk5eL6DT+0wuwSzpQ0nj6q7LGeXtyP6Kt0JiIT4uvWj6H
         F0F0NB67QzDSulk561B9QxXv6eMysyn171CLAWKxzeMxRb6Zah+Qqra9H0bNt/b9XdKC
         YXHA==
X-Gm-Message-State: AC+VfDzSOjKR1qDZRPYHheKzmNOBccjd9MyOjEDdXHP3aY7O3L+cxzwr
        zINEN4GtqhXecPgBhnrBOkE7eQ==
X-Google-Smtp-Source: ACHHUZ41Mt0LdJYehtesv6pKDnJiDtvVDpBOIv2PtermPkwVmgzJ8wQgFh4PWlilf6vPStsuMKVTig==
X-Received: by 2002:a17:903:2287:b0:1ad:ea13:1914 with SMTP id b7-20020a170903228700b001adea131914mr4578158plh.30.1684449237781;
        Thu, 18 May 2023 15:33:57 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([100.107.238.113])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aafb802efbsm1996502plr.12.2023.05.18.15.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:33:57 -0700 (PDT)
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
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v7 4/5] dm-thin: Add REQ_OP_PROVISION support
Date:   Thu, 18 May 2023 15:33:25 -0700
Message-ID: <20230518223326.18744-5-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230518223326.18744-1-sarthakkukreti@chromium.org>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/md/dm-thin.c | 74 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 2b13c949bd72..f1b68b558cf0 100644
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
@@ -1394,6 +1396,9 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
 	m->data_block = data_block;
 	m->cell = cell;
 
+	if (bio && bio_op(bio) == REQ_OP_PROVISION)
+		m->bio = bio;
+
 	/*
 	 * If the whole block of data is being overwritten or we are not
 	 * zeroing pre-existing data, we can issue the bio immediately.
@@ -1953,6 +1958,51 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
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
@@ -2228,6 +2278,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			pool->process_discard(tc, bio);
+		else if (bio_op(bio) == REQ_OP_PROVISION)
+			pool->process_provision(tc, bio);
 		else
 			pool->process_bio(tc, bio);
 
@@ -2579,6 +2631,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_fail;
 		pool->process_discard = process_bio_fail;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_fail;
 		pool->process_discard_cell = process_cell_fail;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
@@ -2592,6 +2645,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_bio_success;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_read_only;
 		pool->process_discard_cell = process_cell_success;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
@@ -2612,6 +2666,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		pool->out_of_data_space = true;
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_discard_bio;
+		pool->process_provision = process_bio_fail;
 		pool->process_cell = process_cell_read_only;
 		pool->process_prepared_mapping = process_prepared_mapping;
 		set_discard_callbacks(pool);
@@ -2628,6 +2683,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		dm_pool_metadata_read_write(pool->pmd);
 		pool->process_bio = process_bio;
 		pool->process_discard = process_discard_bio;
+		pool->process_provision = process_provision_bio;
 		pool->process_cell = process_cell;
 		pool->process_prepared_mapping = process_prepared_mapping;
 		set_discard_callbacks(pool);
@@ -2749,7 +2805,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_SUBMITTED;
 	}
 
-	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
+	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_PROVISION) {
 		thin_defer_bio_with_throttle(tc, bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -3396,6 +3453,9 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	pt->adjusted_pf = pt->requested_pf = pf;
 	ti->num_flush_bios = 1;
 	ti->limit_swap_bios = true;
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+	ti->max_provision_granularity = true;
 
 	/*
 	 * Only need to enable discards if the pool should pass
@@ -4094,6 +4154,8 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
 	}
 
+	limits->max_provision_sectors = pool->sectors_per_block;
+
 	/*
 	 * pt->adjusted_pf is a staging area for the actual features to use.
 	 * They get transferred to the live pool in bind_control_target()
@@ -4288,6 +4350,10 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->max_discard_granularity = true;
 	}
 
+	ti->num_provision_bios = 1;
+	ti->provision_supported = true;
+	ti->max_provision_granularity = true;
+
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	spin_lock_irq(&tc->pool->lock);
-- 
2.40.1.698.g37aff9b760-goog

