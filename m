Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB765B5232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 02:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiILAVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiILAVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:21:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEE237FE;
        Sun, 11 Sep 2022 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662942045;
        bh=HdL+ioQHZlHJV/W14BR1XcKMLnPmOrjwUHI1bHGSOrE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bOWcnn/xzBPGXTL7fHFv44aK510hPPDxhC7XVFGnf4VhSTuEneaO42n3LmhwpqZxP
         vRnmmq5K5JsT4UNdW+elYn+1UXcO83EP4I3GKZbPyjnZ1lRG5pzTgCGANwXUorvRcY
         BgS67FVG0GKfjSZh816Y/hVHyYuXXo1BAiVsfb6w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1ocRXu2x9a-00Cg5k; Mon, 12
 Sep 2022 02:20:45 +0200
Message-ID: <9a34f412-59eb-7bcd-5d09-7afd468c81af@gmx.com>
Date:   Mon, 12 Sep 2022 08:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
In-Reply-To: <20220901074216.1849941-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aY7xygooCRb1g41VxXoN/T681vLhk6wKU4Bfj6og7/49ByzmgXm
 v6+cPcgUqzp6SUx3ZThcD97LxLOJ/3HnCb/NePqh5x49pu6pK8NIATvUlAoQHPbRV1Sd3pR
 WGG6puvkQpBnPAh/Y27JHeneV80WVaVGlaFWQZfcEUfoRRH01otfSk889MOUo/LXAAWGYSR
 tlkTIr3hs9Odcy6/siPkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oHHLhIkhdGQ=:9uy/l5mR3GZTcANqq651eN
 pZ+38xc1bMacLFc073pHTFcnkX2pPkwLkGeOUY2BGtOyi6zCMkO+CcHO5exV8N+qJFSegGOFo
 dCGvF1VXv5j7NCP56jkZa6sKUe5B2o54Yn0lF1EFsV9pBdW7vvH/28yabuYOxvWLSP939OqDs
 WX4LZMTBXiNX/ASvM3jysU3eRYlmgYZbjPFx63ZhgR74CL275CUllviciD+ll9TiM1UhjduGJ
 MZvKuBJUZgrp5chcEruSLCQLzXWt19Spc8BxKkxLXmEo8a/AbcdJK6N3xkVus2t69yYuvEeNy
 Fo7D0/Tlq3IEnTlRZXMKmceOq2nOZTu+/b25wE3AXrjQRcvjNGVvN1JVkDyuF5oSWlcG5Q9mr
 qYwnuCrLHN4dr2OL2jfV71sFG0Zh4u8Dgi8+EUbnCJ0uKF4Xl8s804Lrk+b8rAdP+wVIH9Owf
 xzuu6RnaFMUT37WtSL1LWBKrpBrBXDJbjirkDRJ1prOPzrivKOxRItNRETBB6lcG7ufCYivfL
 n5Fbn5nARD+CIVj57RZ+vRMN7dfSxEKdUx0Vya/gvFvwfi697jq92Cg/dE3sjwgtGgm/rXuvE
 aNZ9shW3xk9EVPP59o/oc+JxlQUMEhdd+V47duWmYHHcaYKcjxf12oF5oSqHUaNyi0w3ZzbG4
 mnUKXd01i9CVjnjc+ke1PIy79uPxhRrr2sEdOVZdu6Ka+CIUnTKXZmNUJVweUI81wp1lv8Z/R
 0thuoZ523EsfH/7jJwhDK7q8BHRzOaQ6NOpG+3xPvjtgYndAyAIE0kRKYAtq166Cj2F85Mnzd
 weM6Gol8tSLJFJj6U9/Q1npJKEroPi3TtkMGNxkij+UYj0I7p83um+okfqkp1bJJ+H4sffU7l
 /Dl9J6HFW0l/QF19ribwnO9o1Ph+gOQncxaNB98mjXgfXSDhhLRAzyxc7Kbi+W4Eif4iVzKe0
 cTEGl1J7AHV3akYc+0qG9zYWCkGRgeBQUDOnB7vobEBqKw0WzokpMwzJYusqwqkSITYgHLmDv
 ycT5kgDyLyf8Cbhxrh2dr+A9xo15Z2N/e0/BwVUfO+CEPEPHQWatoHsSifhcKCZLWn2SzFnHU
 peaJs9SeTWBVOO+ju9i2TuMhBUzPPOdvr2wXVrpU0avLlwgmLmYk69gxvzDvpRg1qHsPlG9HQ
 s21RBTRL0hUjjZTs1ZfsbDv4Em
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/1 15:42, Christoph Hellwig wrote:
> Currently the I/O submitters have to split bios according to the
> chunk stripe boundaries.  This leads to extra lookups in the extent
> trees and a lot of boilerplate code.
>
> To drop this requirement, split the bio when __btrfs_map_block
> returns a mapping that is smaller than the requested size and
> keep a count of pending bios in the original btrfs_bio so that
> the upper level completion is only invoked when all clones have
> completed.

Sorry for the late reply, but I still have a question related the
chained bio way.

Since we go the chained method, it means, if we hit an error for the
splitted bio, the whole bio will be marked error.

Especially for read bios, that can be a problem (currently only for
RAID10 though), which can affect the read repair behavior.

E.g. we have a 4-disks RAID10 looks like this:

Disk 1 (unreliable): Mirror 1 of logical range [X, X + 64K)
Disk 2 (reliable):   Mirror 2 of logical range [X, X + 64K)
Disk 3 (reliable):   Mirror 1 of logical range [X + 64K, X + 128K)
Disk 4 (unreliable): Mirror 2 of logical range [X + 64K, X + 128K)

And we submit a read for range [X, X + 128K)

The first 64K will use mirror 1, thus reading from Disk 1.
The second 64K will also use mirror 1, thus read from Disk 2.

But the first 64K read failed due to whatever reason, thus we mark the
whole range error, and needs to go repair code.

Note that, the original bio is using mirror 1, thus for read-repair we
can only read from mirror 2 to repair.

But in that case, Disk 4 is also unreliable, if at read-repair time, we
didn't try all mirrors, including the failed one (which is no longer a
reliable mirror_num for all ranges), we may failed to repair some range.

Does the read-repair code now has something to compensate the chained
behavior?

Thanks,
Qu

>
> Based on a patch from Qu Wenruo.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 106 +++++++++++++++++++++++++++++++++++++--------
>   fs/btrfs/volumes.h |   1 +
>   2 files changed, 90 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5c6535e10085d..0a2d144c20604 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -35,6 +35,7 @@
>   #include "zoned.h"
>
>   static struct bio_set btrfs_bioset;
> +static struct bio_set btrfs_clone_bioset;
>   static struct bio_set btrfs_repair_bioset;
>   static mempool_t btrfs_failed_bio_pool;
>
> @@ -6661,6 +6662,7 @@ static void btrfs_bio_init(struct btrfs_bio *bbio,=
 struct inode *inode,
>   	bbio->inode =3D inode;
>   	bbio->end_io =3D end_io;
>   	bbio->private =3D private;
> +	atomic_set(&bbio->pending_ios, 1);
>   }
>
>   /*
> @@ -6698,6 +6700,57 @@ struct bio *btrfs_bio_clone_partial(struct bio *o=
rig, u64 offset, u64 size,
>   	return bio;
>   }
>
> +static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
> +{
> +	struct btrfs_bio *orig_bbio =3D btrfs_bio(orig);
> +	struct bio *bio;
> +
> +	bio =3D bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> +			&btrfs_clone_bioset);
> +	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
> +
> +	btrfs_bio(bio)->file_offset =3D orig_bbio->file_offset;
> +	orig_bbio->file_offset +=3D map_length;
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
> +	if (bbio->bio.bi_end_io =3D=3D &btrfs_orig_write_end_io) {
> +		struct btrfs_io_stripe *orig_stripe =3D orig_bbio->bio.bi_private;
> +		struct btrfs_io_context *orig_bioc =3D orig_stripe->bioc;
> +
> +		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
> +	} else {
> +		orig_bbio->bio.bi_status =3D bbio->bio.bi_status;
> +	}
> +}
> +
> +static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
> +{
> +	if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
> +		struct btrfs_bio *orig_bbio =3D bbio->private;
> +
> +		if (bbio->bio.bi_status)
> +			btrfs_bbio_propagate_error(bbio, orig_bbio);
> +		bio_put(&bbio->bio);
> +		bbio =3D orig_bbio;
> +	}
> +
> +	if (atomic_dec_and_test(&bbio->pending_ios))
> +		bbio->end_io(bbio);
> +}
> +
>   static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_m=
irror)
>   {
>   	if (cur_mirror =3D=3D fbio->num_copies)
> @@ -6715,7 +6768,7 @@ static int prev_repair_mirror(struct btrfs_failed_=
bio *fbio, int cur_mirror)
>   static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
>   {
>   	if (atomic_dec_and_test(&fbio->repair_count)) {
> -		fbio->bbio->end_io(fbio->bbio);
> +		btrfs_orig_bbio_end_io(fbio->bbio);
>   		mempool_free(fbio, &btrfs_failed_bio_pool);
>   	}
>   }
> @@ -6857,7 +6910,7 @@ static void btrfs_check_read_bio(struct btrfs_bio =
*bbio,
>   	if (unlikely(fbio))
>   		btrfs_repair_done(fbio);
>   	else
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>   }
>
>   static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_devic=
e *dev)
> @@ -6908,7 +6961,7 @@ static void btrfs_simple_end_io(struct bio *bio)
>   	} else {
>   		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
>   			btrfs_record_physical_zoned(bbio);
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>   	}
>   }
>
> @@ -6922,7 +6975,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
>   	if (bio_op(bio) =3D=3D REQ_OP_READ)
>   		btrfs_check_read_bio(bbio, NULL);
>   	else
> -		bbio->end_io(bbio);
> +		btrfs_orig_bbio_end_io(bbio);
>
>   	btrfs_put_bioc(bioc);
>   }
> @@ -6949,7 +7002,7 @@ static void btrfs_orig_write_end_io(struct bio *bi=
o)
>   	else
>   		bio->bi_status =3D BLK_STS_OK;
>
> -	bbio->end_io(bbio);
> +	btrfs_orig_bbio_end_io(bbio);
>   	btrfs_put_bioc(bioc);
>   }
>
> @@ -7190,8 +7243,8 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *=
bbio,
>   	return true;
>   }
>
> -void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -		      int mirror_num)
> +static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bi=
o *bio,
> +			       int mirror_num)
>   {
>   	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	u64 logical =3D bio->bi_iter.bi_sector << 9;
> @@ -7207,11 +7260,10 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_i=
nfo, struct bio *bio,
>   	if (ret)
>   		goto fail;
>
> +	map_length =3D min(map_length, length);
>   	if (map_length < length) {
> -		btrfs_crit(fs_info,
> -			   "mapping failed logical %llu bio len %llu len %llu",
> -			   logical, length, map_length);
> -		BUG();
> +		bio =3D btrfs_split_bio(bio, map_length);
> +		bbio =3D btrfs_bio(bio);
>   	}
>
>   	/*
> @@ -7222,7 +7274,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>   		bbio->saved_iter =3D bio->bi_iter;
>   		ret =3D btrfs_lookup_bio_sums(bbio);
>   		if (ret)
> -			goto fail;
> +			goto fail_put_bio;
>   	}
>
>   	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> @@ -7231,7 +7283,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>   		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
>   			ret =3D btrfs_extract_ordered_extent(btrfs_bio(bio));
>   			if (ret)
> -				goto fail;
> +				goto fail_put_bio;
>   		}
>
>   		/*
> @@ -7243,22 +7295,36 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_i=
nfo, struct bio *bio,
>   		    !btrfs_is_data_reloc_root(bi->root)) {
>   			if (should_async_write(bbio) &&
>   			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
> -				return;
> +				goto done;
>
>   			if (bio->bi_opf & REQ_META)
>   				ret =3D btree_csum_one_bio(bbio);
>   			else
>   				ret =3D btrfs_csum_one_bio(bbio);
>   			if (ret)
> -				goto fail;
> +				goto fail_put_bio;
>   		}
>   	}
>
>   	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
> -	return;
> +done:
> +	return map_length =3D=3D length;
> +
> +fail_put_bio:
> +	if (map_length < length)
> +		bio_put(bio);
>   fail:
>   	btrfs_bio_counter_dec(fs_info);
>   	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
> +	/* Do not submit another chunk */
> +	return true;
> +}
> +
> +void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> +		      int mirror_num)
> +{
> +	while (!btrfs_submit_chunk(fs_info, bio, mirror_num))
> +		;
>   }
>
>   /*
> @@ -8858,10 +8924,13 @@ int __init btrfs_bioset_init(void)
>   			offsetof(struct btrfs_bio, bio),
>   			BIOSET_NEED_BVECS))
>   		return -ENOMEM;
> +	if (bioset_init(&btrfs_clone_bioset, BIO_POOL_SIZE,
> +			offsetof(struct btrfs_bio, bio), 0))
> +		goto out_free_bioset;
>   	if (bioset_init(&btrfs_repair_bioset, BIO_POOL_SIZE,
>   			offsetof(struct btrfs_bio, bio),
>   			BIOSET_NEED_BVECS))
> -		goto out_free_bioset;
> +		goto out_free_clone_bioset;
>   	if (mempool_init_kmalloc_pool(&btrfs_failed_bio_pool, BIO_POOL_SIZE,
>   				      sizeof(struct btrfs_failed_bio)))
>   		goto out_free_repair_bioset;
> @@ -8869,6 +8938,8 @@ int __init btrfs_bioset_init(void)
>
>   out_free_repair_bioset:
>   	bioset_exit(&btrfs_repair_bioset);
> +out_free_clone_bioset:
> +	bioset_exit(&btrfs_clone_bioset);
>   out_free_bioset:
>   	bioset_exit(&btrfs_bioset);
>   	return -ENOMEM;
> @@ -8878,5 +8949,6 @@ void __cold btrfs_bioset_exit(void)
>   {
>   	mempool_exit(&btrfs_failed_bio_pool);
>   	bioset_exit(&btrfs_repair_bioset);
> +	bioset_exit(&btrfs_clone_bioset);
>   	bioset_exit(&btrfs_bioset);
>   }
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 8b248c9bd602b..97877184d0db1 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -386,6 +386,7 @@ struct btrfs_bio {
>
>   	/* For internal use in read end I/O handling */
>   	unsigned int mirror_num;
> +	atomic_t pending_ios;
>   	struct work_struct end_io_work;
>
>   	/*
