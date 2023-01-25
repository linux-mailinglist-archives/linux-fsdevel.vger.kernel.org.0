Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35B67BF3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjAYVwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjAYVwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:52:11 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEF62D31
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:51:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d3so2729215qte.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgsCQlRUGcWI5JnQRUEGtA2jtSlTDLEUjgR4o4pTY94=;
        b=CsQcGY+AOyVgL0Me0p7QeI9qtfhIv5oLuhnNsbnGy+PWyRq932My6i/cyB1zUaUzhd
         WKKTwX/UlFvcAfFDrntHittQYY6mEmq0GRy1BchKNaKwu62hz0sSV8t0iK716DL8qQsH
         dW2+/6dHX91yeG90B37PoDFS1xksCoRyIx6CFtoso3I5h+UQOkh5QhQi1LMI+BLzvrPL
         2aUO7NEfqyCk/fzEp5HeIkDIA7XgGqVUJ7CE4CIT4OILkksqf7Epc4A014yILaaxBJCI
         BcCBcEIqD+RaQgyBzFjJ0EYsd2N08/0QHAmQ7DnCrdn8w3ZnAcnMoclqCreBsGOnQ0b2
         pxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgsCQlRUGcWI5JnQRUEGtA2jtSlTDLEUjgR4o4pTY94=;
        b=ma4duWVlI97jeO1kmAvgQZQPp4YgZ/MJW4uAggDaidipZbIiNrQ1U0QPIKrVlXSz7R
         zWvdO6XkkK+d2srvVfQ/zrQqDk3+2ZkEOVh789SQsqr1jxmhOSCdDGvAMFV5Lbnv2xe/
         gfrmBtb3PQYKOhdOtlVoxmsDyxOnQPulV6bIKHJ9gVG8coN77sSHG5mBIQesBOrDCGZ3
         RW2LHyfHe50uJbVz+Eo0oQBg8v1kwPo8cczinWDviWE4vApAEzgrcM7Km5EQ3saIvZWV
         zilX05+o70pxCduVg5ACDxEMpnF2xsTzwVl3Rq69xl88GXkUa96KcyVyG921NN4nd/xV
         9sVA==
X-Gm-Message-State: AFqh2krT+ObkGpolqQ8pByAGdQDIiD6mZRnTFajBSGaBmDQCnj5xi4Qa
        s7ajMHo2LeP4C6it0cMUPdcRdw==
X-Google-Smtp-Source: AMrXdXtsHkFQR0+yTSH5dM/mytsQi+RmWVRbBr9mbGQY3LBRgO+hvvGRMg5HND4nM8Q8fWLrirYVow==
X-Received: by 2002:ac8:750e:0:b0:3b5:7af4:87b3 with SMTP id u14-20020ac8750e000000b003b57af487b3mr47105856qtq.38.1674683478562;
        Wed, 25 Jan 2023 13:51:18 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8704c000000b003b6302f2580sm4098202qtm.22.2023.01.25.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:51:17 -0800 (PST)
Date:   Wed, 25 Jan 2023 16:51:16 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/34] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <Y9GkVONZJFXVe8AH@localhost.localdomain>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121065031.1139353-24-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 07:50:20AM +0100, Christoph Hellwig wrote:
> Currently the I/O submitters have to split bios according to the
> chunk stripe boundaries.  This leads to extra lookups in the extent
> trees and a lot of boilerplate code.
> 
> To drop this requirement, split the bio when __btrfs_map_block
> returns a mapping that is smaller than the requested size and
> keep a count of pending bios in the original btrfs_bio so that
> the upper level completion is only invoked when all clones have
> completed.
> 
> Based on a patch from Qu Wenruo.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c | 108 ++++++++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/bio.h |   1 +
>  2 files changed, 91 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index c7522ac7e0e71c..ff42b783902140 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -17,6 +17,7 @@
>  #include "file-item.h"
>  
>  static struct bio_set btrfs_bioset;
> +static struct bio_set btrfs_clone_bioset;
>  static struct bio_set btrfs_repair_bioset;
>  static mempool_t btrfs_failed_bio_pool;
>  
> @@ -38,6 +39,7 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio,
>  	bbio->inode = inode;
>  	bbio->end_io = end_io;
>  	bbio->private = private;
> +	atomic_set(&bbio->pending_ios, 1);
>  }
>  
>  /*
> @@ -75,6 +77,58 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
>  	return bio;
>  }
>  
> +static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
> +{
> +	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
> +	struct bio *bio;
> +
> +	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> +			&btrfs_clone_bioset);
> +	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
> +
> +	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
> +	if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
> +		orig_bbio->file_offset += map_length;
> +
> +	atomic_inc(&orig_bbio->pending_ios);
> +	return bio;
> +}
> +
> +static void btrfs_orig_write_end_io(struct bio *bio);
> +static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> +				       struct btrfs_bio *orig_bbio)
> +{
> +	/*
> +	 * For writes btrfs tolerates nr_mirrors - 1 write failures, so we
> +	 * can't just blindly propagate a write failure here.
> +	 * Instead increment the error count in the original I/O context so
> +	 * that it is guaranteed to be larger than the error tolerance.
> +	 */
> +	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
> +		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
> +		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
> +
> +		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
> +	} else {
> +		orig_bbio->bio.bi_status = bbio->bio.bi_status;
> +	}
> +}
> +
> +static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
> +{
> +	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
> +		struct btrfs_bio *orig_bbio = bbio->private;
> +
> +		if (bbio->bio.bi_status)
> +			btrfs_bbio_propagate_error(bbio, orig_bbio);
> +		bio_put(&bbio->bio);
> +		bbio = orig_bbio;
> +	}
> +
> +	if (atomic_dec_and_test(&bbio->pending_ios))
> +		bbio->end_io(bbio);
> +}
> +
>  static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
>  {
>  	if (cur_mirror == fbio->num_copies)
> @@ -92,7 +146,7 @@ static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
>  static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
>  {
>  	if (atomic_dec_and_test(&fbio->repair_count)) {
> -		fbio->bbio->end_io(fbio->bbio);
> +		btrfs_orig_bbio_end_io(fbio->bbio);
>  		mempool_free(fbio, &btrfs_failed_bio_pool);
>  	}
>  }
> @@ -232,7 +286,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio,
>  	if (unlikely(fbio))
>  		btrfs_repair_done(fbio);
>  	else
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>  }
>  
>  static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
> @@ -286,7 +340,7 @@ static void btrfs_simple_end_io(struct bio *bio)
>  	} else {
>  		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
>  			btrfs_record_physical_zoned(bbio);
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>  	}
>  }
>  
> @@ -300,7 +354,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
>  	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
>  		btrfs_check_read_bio(bbio, NULL);
>  	else
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>  
>  	btrfs_put_bioc(bioc);
>  }
> @@ -327,7 +381,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>  	else
>  		bio->bi_status = BLK_STS_OK;
>  
> -	bbio->end_io(bbio);
> +	btrfs_orig_bbio_end_io(bbio);
>  	btrfs_put_bioc(bioc);
>  }
>  
> @@ -492,7 +546,7 @@ static void run_one_async_done(struct btrfs_work *work)
>  
>  	/* If an error occurred we just want to clean up the bio and move on */
>  	if (bio->bi_status) {
> -		btrfs_bio_end_io(async->bbio, bio->bi_status);
> +		btrfs_orig_bbio_end_io(async->bbio);
>  		return;
>  	}
>  
> @@ -567,8 +621,8 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
>  	return true;
>  }
>  
> -void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -		      int mirror_num)
> +static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
> +			       int mirror_num)
>  {
>  	struct btrfs_bio *bbio = btrfs_bio(bio);
>  	u64 logical = bio->bi_iter.bi_sector << 9;
> @@ -587,11 +641,10 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  		goto fail;
>  	}
>  
> +	map_length = min(map_length, length);
>  	if (map_length < length) {
> -		btrfs_crit(fs_info,
> -			   "mapping failed logical %llu bio len %llu len %llu",
> -			   logical, length, map_length);
> -		BUG();
> +		bio = btrfs_split_bio(bio, map_length);
> +		bbio = btrfs_bio(bio);
>  	}
>  
>  	/*
> @@ -602,14 +655,14 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  		bbio->saved_iter = bio->bi_iter;
>  		ret = btrfs_lookup_bio_sums(bbio);
>  		if (ret)
> -			goto fail;
> +			goto fail_put_bio;
>  	}
>  
>  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
>  		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>  			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
>  			if (ret)
> -				goto fail;
> +				goto fail_put_bio;
>  		}
>  
>  		/*
> @@ -621,20 +674,33 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  		    !btrfs_is_data_reloc_root(bbio->inode->root)) {
>  			if (should_async_write(bbio) &&
>  			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
> -				return;
> +				goto done;
>  
>  			ret = btrfs_bio_csum(bbio);
>  			if (ret)
> -				goto fail;
> +				goto fail_put_bio;
>  		}
>  	}
>  
>  	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
> -	return;
> +done:
> +	return map_length == length;
>  
> +fail_put_bio:
> +	if (map_length < length)
> +		bio_put(bio);

This is causing a panic in btrfs/125 because you set bbio to
btrfs_bio(split_bio), which has a NULL end_io.  You need something like the
following so that we're ending the correct bbio.  Thanks,

Josef

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5d4b67fc44f4..f3a357c48e69 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -607,6 +607,7 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
 			       int mirror_num)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_bio *orig_bbio = bbio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
@@ -673,7 +674,7 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
 		bio_put(bio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_bio_end_io(bbio, ret);
+	btrfs_bio_end_io(orig_bbio, ret);
 	/* Do not submit another chunk */
 	return true;
 }
