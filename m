Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483B6E2BEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNV7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDNV7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:59:39 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DCE2681
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:58:50 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id e9so15215122qvv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509529; x=1684101529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYsZjFHL3385A5xW3T523pPMndVQEYtBtF4AehY0ljE=;
        b=R+0BANVfVWCW/nBQdhUFDgI/PdrZoXEuSNihtEAsePkByoS6rysYXv+garshjZxKxz
         myFxB8X0vsBHaytAvfE9Clyq/HLYEMYjTU8xeRn2cQ/SQOP/VwL1nF/lqWUXHbWjjfSU
         jXz0qkfeRd9RVE2dJ3WUmv7Qz+zEu/9UFebVvPXYLQL0ODuiF4VgVE8wVO56X2CCDRhu
         0oLD9qWD02cBaEy59OBUYjiWMLzhJpNVVWa7LlEq9qReA0z3usCDMEsQ4ob+YR81VhQN
         Tl96NlnHLj8w5uCzbEcA87h8CsLdvTMtqJwZRnGWvn4cs8ZS+vq/MLKQs5EcBXXt44/a
         rEag==
X-Gm-Message-State: AAQBX9cI1t00UxaK5OcQprfRFgZx2p5JoOCmYQn7AJI1fGVeZI1kX1X/
        ChnBbY7wv1MI+cVDEtN29Jsq
X-Google-Smtp-Source: AKy350bkdBenhmQ8XJxwQy3NRYjH902yYfwXndzGXDpv2HiCaBBymjdRgwPDALalTF9nY8wGV83+Gw==
X-Received: by 2002:a05:6214:2504:b0:5a9:ed32:1765 with SMTP id gf4-20020a056214250400b005a9ed321765mr7034056qvb.23.1681509529341;
        Fri, 14 Apr 2023 14:58:49 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id r2-20020a0cf802000000b005ef5b1006c5sm511080qvn.38.2023.04.14.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:58:48 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:58:47 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 2/3] dm: Add support for block provisioning
Message-ID: <ZDnMl8A1B1+Tfn5S@redhat.com>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414000219.92640-3-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13 2023 at  8:02P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Add support to dm devices for REQ_OP_PROVISION. The default mode
> is to passthrough the request to the underlying device, if it
> supports it. dm-thinpool uses the provision request to provision
> blocks for a dm-thin device. dm-thinpool currently does not
> pass through REQ_OP_PROVISION to underlying devices.
> 
> For shared blocks, provision requests will break sharing and copy the
> contents of the entire block.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-crypt.c         |   4 +-
>  drivers/md/dm-linear.c        |   1 +
>  drivers/md/dm-snap.c          |   7 +++

Have you tested REQ_OP_PROVISION with these targets?  Just want to
make sure you have an explicit need (and vested interest) for them
passing through REQ_OP_PROVISION.

> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 2055a758541d..5985343384a7 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1850,6 +1850,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
>  	return true;
>  }
>  
> +static int device_provision_capable(struct dm_target *ti, struct dm_dev *dev,
> +				    sector_t start, sector_t len, void *data)
> +{
> +	return !bdev_max_provision_sectors(dev->bdev);
> +}
> +
> +static bool dm_table_supports_provision(struct dm_table *t)
> +{
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->provision_supported ||
> +		    (ti->type->iterate_devices &&
> +		    ti->type->iterate_devices(ti, device_provision_capable, NULL)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
>  				     sector_t start, sector_t len, void *data)
>  {
> @@ -1983,6 +2003,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  	if (!dm_table_supports_write_zeroes(t))
>  		q->limits.max_write_zeroes_sectors = 0;
>  
> +	if (dm_table_supports_provision(t))
> +		blk_queue_max_provision_sectors(q, UINT_MAX >> 9);

This doesn't seem correct in that it'll override whatever
max_provision_sectors was set by a target (like thinp).

I think you only need the if (!dm_table_supports_provision)) case:

> +	else
> +		q->limits.max_provision_sectors = 0;
> +
>  	dm_table_verify_integrity(t);
>  
>  	/*
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 13d4677baafd..b08b7ae617be 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c

I think it'll make the most sense to split out the dm-thin.c changes
in a separate patch.

> @@ -909,7 +909,8 @@ static void __inc_remap_and_issue_cell(void *context,
>  	struct bio *bio;
>  
>  	while ((bio = bio_list_pop(&cell->bios))) {
> -		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD)
> +		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> +		    bio_op(bio) == REQ_OP_PROVISION)
>  			bio_list_add(&info->defer_bios, bio);
>  		else {
>  			inc_all_io_entry(info->tc->pool, bio);
> @@ -1013,6 +1014,15 @@ static void process_prepared_mapping(struct dm_thin_new_mapping *m)
>  		goto out;
>  	}
>  
> +	/*
> +	 * For provision requests, once the prepared block has been inserted
> +	 * into the mapping btree, return.
> +	 */
> +	if (bio && bio_op(bio) == REQ_OP_PROVISION) {
> +		bio_endio(bio);
> +		return;
> +	}
> +
>  	/*
>  	 * Release any bios held while the block was being provisioned.
>  	 * If we are processing a write bio that completely covers the block,
> @@ -1241,7 +1251,7 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
>  
>  static int io_overwrites_block(struct pool *pool, struct bio *bio)
>  {
> -	return (bio_data_dir(bio) == WRITE) &&
> +	return (bio_data_dir(bio) == WRITE) && bio_op(bio) != REQ_OP_PROVISION &&
>  		io_overlaps_block(pool, bio);
>  }
>  
> @@ -1334,10 +1344,11 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
>  	/*
>  	 * IO to pool_dev remaps to the pool target's data_dev.
>  	 *
> -	 * If the whole block of data is being overwritten, we can issue the
> -	 * bio immediately. Otherwise we use kcopyd to clone the data first.
> +	 * If the whole block of data is being overwritten and if this is not a
> +	 * provision request, we can issue the bio immediately.
> +	 * Otherwise we use kcopyd to clone the data first.
>  	 */
> -	if (io_overwrites_block(pool, bio))
> +	if (io_overwrites_block(pool, bio) && bio_op(bio) != REQ_OP_PROVISION)
>  		remap_and_issue_overwrite(tc, bio, data_dest, m);
>  	else {
>  		struct dm_io_region from, to;
> @@ -1356,7 +1367,8 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
>  		/*
>  		 * Do we need to zero a tail region?
>  		 */
> -		if (len < pool->sectors_per_block && pool->pf.zero_new_blocks) {
> +		if (len < pool->sectors_per_block && pool->pf.zero_new_blocks &&
> +		    bio_op(bio) != REQ_OP_PROVISION) {
>  			atomic_inc(&m->prepare_actions);
>  			ll_zero(tc, m,
>  				data_dest * pool->sectors_per_block + len,
> @@ -1390,6 +1402,10 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
>  	m->data_block = data_block;
>  	m->cell = cell;
>  
> +	/* Provision requests are chained on the original bio. */
> +	if (bio && bio_op(bio) == REQ_OP_PROVISION)
> +		m->bio = bio;
> +
>  	/*
>  	 * If the whole block of data is being overwritten or we are not
>  	 * zeroing pre-existing data, we can issue the bio immediately.
> @@ -1865,7 +1881,8 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
>  
>  	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size) {
>  		break_sharing(tc, bio, block, &key, lookup_result, data_cell);
> -		cell_defer_no_holder(tc, virt_cell);
> +		if (bio_op(bio) != REQ_OP_PROVISION)
> +			cell_defer_no_holder(tc, virt_cell);
>  	} else {
>  		struct dm_thin_endio_hook *h = dm_per_bio_data(bio, sizeof(struct dm_thin_endio_hook));
>  

Not confident in the above changes given the request that we only
handle REQ_OP_PROVISION one thinp block at a time.  So I'll gloss over
them for now.

> @@ -1982,6 +1999,73 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
>  	}
>  }
>  
> +static void process_provision_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
> +{
> +	int r;
> +	struct pool *pool = tc->pool;
> +	struct bio *bio = cell->holder;
> +	dm_block_t begin, end;
> +	struct dm_thin_lookup_result lookup_result;
> +
> +	if (tc->requeue_mode) {
> +		cell_requeue(pool, cell);
> +		return;
> +	}
> +
> +	get_bio_block_range(tc, bio, &begin, &end);
> +
> +	while (begin != end) {
> +		r = ensure_next_mapping(pool);
> +		if (r)
> +			/* we did our best */
> +			return;
> +
> +		r = dm_thin_find_block(tc->td, begin, 1, &lookup_result);
> +		switch (r) {
> +		case 0:
> +			if (lookup_result.shared)
> +				process_shared_bio(tc, bio, begin,
> +						   &lookup_result, cell);
> +			begin++;
> +			break;
> +		case -ENODATA:
> +			bio_inc_remaining(bio);
> +			provision_block(tc, bio, begin, cell);
> +			begin++;
> +			break;
> +		default:
> +			DMERR_LIMIT(
> +				"%s: dm_thin_find_block() failed: error = %d",
> +				__func__, r);
> +			cell_defer_no_holder(tc, cell);
> +			bio_io_error(bio);
> +			begin++;
> +			break;
> +		}
> +	}
> +	bio_endio(bio);
> +	cell_defer_no_holder(tc, cell);
> +}
> +
> +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> +{
> +	dm_block_t begin, end;
> +	struct dm_cell_key virt_key;
> +	struct dm_bio_prison_cell *virt_cell;
> +
> +	get_bio_block_range(tc, bio, &begin, &end);
> +	if (begin == end) {
> +		bio_endio(bio);
> +		return;
> +	}

Like Joe mentioned, this pattern was fine for discards because they
are advisory/optional.  But we need to make sure we don't truncate
REQ_OP_PROVISION -- so we need to round up if we partially bleed into
the blocks to the left or right.

BUT ranged REQ_OP_PROVISION support is for later, this can be dealt
with more simply in that each REQ_OP_PROVISION will be handled a block
at a time initially.  SO you'll want to honor _all_ REQ_OP_PROVISION,
never returning early.

> +
> +	build_key(tc->td, VIRTUAL, begin, end, &virt_key);
> +	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
> +		return;
> +
> +	process_provision_cell(tc, virt_cell);
> +}
> +
>  static void process_bio(struct thin_c *tc, struct bio *bio)
>  {
>  	struct pool *pool = tc->pool;
> @@ -2202,6 +2286,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
>  
>  		if (bio_op(bio) == REQ_OP_DISCARD)
>  			pool->process_discard(tc, bio);
> +		else if (bio_op(bio) == REQ_OP_PROVISION)
> +			process_provision_bio(tc, bio);

This should be pool->process_provision() (or ->process_provision_bio
if you like).  Point is, you need to be switching these methods
if/when the pool_mode transitions in set_pool_mode().

>  		else
>  			pool->process_bio(tc, bio);
>  
> @@ -2723,7 +2809,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
>  		return DM_MAPIO_SUBMITTED;
>  	}
>  
> -	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
> +	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> +	    bio_op(bio) == REQ_OP_PROVISION) {
>  		thin_defer_bio_with_throttle(tc, bio);
>  		return DM_MAPIO_SUBMITTED;
>  	}
> @@ -3370,6 +3457,8 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	pt->adjusted_pf = pt->requested_pf = pf;
>  	ti->num_flush_bios = 1;
>  	ti->limit_swap_bios = true;
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
>  
>  	/*
>  	 * Only need to enable discards if the pool should pass
> @@ -4068,6 +4157,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
>  	}
>  
> +

Please fix this extra whitespace damage.

>  	/*
>  	 * pt->adjusted_pf is a staging area for the actual features to use.
>  	 * They get transferred to the live pool in bind_control_target()
> @@ -4261,6 +4351,9 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		ti->num_discard_bios = 1;
>  	}
>  
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
> +
>  	mutex_unlock(&dm_thin_pool_table.mutex);
>  
>  	spin_lock_irq(&tc->pool->lock);
> @@ -4475,6 +4568,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
>  	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
> +	limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */

Building on my previous reply, with suggested update to
dm.c:__process_abnormal_io(), once you rebase on dm-6.4's dm-thin.c
you'll want to instead:

limits->max_provision_sectors = pool->sectors_per_block << SECTOR_SHIFT;

And you'll want to drop any of the above code that deals with handling
bio-prison range locking and processing of REQ_OP_PROVISION for
multiple thinp blocks at once.

Simple REQ_OP_PROVISION processing one thinp block at a time first and
then we can worry about handling REQ_OP_PROVISION that span blocks
later.

>  static struct target_type thin_target = {
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index dfde0088147a..d8f1803062b7 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1593,6 +1593,7 @@ static bool is_abnormal_io(struct bio *bio)
>  		case REQ_OP_DISCARD:
>  		case REQ_OP_SECURE_ERASE:
>  		case REQ_OP_WRITE_ZEROES:
> +		case REQ_OP_PROVISION:
>  			return true;
>  		default:
>  			break;
> @@ -1617,6 +1618,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
>  	case REQ_OP_WRITE_ZEROES:
>  		num_bios = ti->num_write_zeroes_bios;
>  		break;
> +	case REQ_OP_PROVISION:
> +		num_bios = ti->num_provision_bios;
> +		break;
>  	default:
>  		break;
>  	}

Please be sure to include my suggested __process_abnormal_io change
from my previous reply.

> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 7975483816e4..e9f687521ae6 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -334,6 +334,12 @@ struct dm_target {
>  	 */
>  	unsigned int num_write_zeroes_bios;
>  
> +	/*
> +	 * The number of PROVISION bios that will be submitted to the target.
> +	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
> +	 */
> +	unsigned int num_provision_bios;
> +
>  	/*
>  	 * The minimum number of extra bytes allocated in each io for the
>  	 * target to use.
> @@ -358,6 +364,11 @@ struct dm_target {
>  	 */
>  	bool discards_supported:1;
>  
> +	/* Set if this target needs to receive provision requests regardless of
> +	 * whether or not its underlying devices have support.
> +	 */
> +	bool provision_supported:1;
> +
>  	/*
>  	 * Set if we need to limit the number of in-flight bios when swapping.
>  	 */

You'll need to add max_provision_granularity bool too (as implied by
the dm.c:__process_abnormal_io() change suggested in my first reply to
this patch).

I'm happy to wait for you to consume the v3 feedback we've provided so
you can create a v4.  I'm thinking I can base dm-thin.c's WRITE_ZEROES
support ontop of your REQ_OP_PROVISION v4 changes -- they should be
complementary.

Thanks,
Mike
