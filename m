Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638874E4A72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiCWBYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiCWBYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:24:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441B6D867;
        Tue, 22 Mar 2022 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647998585;
        bh=pT3B7gqUJGVn/N/yFkw2a83x/1kgjkxVWShE+09AVGs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HAkIq7XybkFU6vY0nbDeA/hPb92guo2fNfUNBn1WkEp6f2U/YjrR0j6wXK76R0M50
         1UBXXdf6ZxeTz1/RpUVZBCv/Hv4l91zsd70rhUCO/z/Hvhgq6sQmpBfmwOsZ5Y8PQN
         8/QYWUye9j/YYDKdWVkFyk7UTy9HYe+rJWF9EJts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MK3Rs-1nmiP823Di-00LZeq; Wed, 23
 Mar 2022 02:23:05 +0100
Message-ID: <1341dbf4-3552-12e4-9e8d-0d4e58fdb821@gmx.com>
Date:   Wed, 23 Mar 2022 09:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 37/40] btrfs: add a btrfs_get_stripe_info helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-38-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-38-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/oV8F3/2BxpYSQEZmfUYfEowMUXnAAqZA4KNSHsRE4hZRwvYbn
 GsblHN4K3JgGgNScYTsrl6stfYjwcRmBNPuzC5E9P4KB1Lee/tlglg4AC2qwCT0/PE9T2FZ
 iKXlH+MxAJpHoy0aSlyCodB6yfVyh8ue1yO2BnInnpHJZMVF3dCDE84FZey8R75JjehNk5j
 F2c0HYankMt8SH9B/xXhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ERt38xMFByQ=:FNeLmgwDj4vW+oqAyFfdR8
 8ccAPyBXWLbwzMF+1+WXUjoPVUXbWZm5UFalnDFsdL7o0zriwJ+YlPU6zZ9852ZzmpQjRMAIn
 cjz0pr6x//g7ImLVvUhWzuVjIjzSUSrJtOhx2GtrhZBBr9eMNuQRuk8/CJPp8ssbEYqQfKHUG
 /tJEhLT6zaj5L1U8c740UojreglSCOvuJ2OL691vCqVF5woVmTxhX00QMxI4oPjPQEbEsBhnH
 zhheev/20TA/POWzbyuCkVRZR+u7OLUF57WcZq2F7omg+HJ/4wIN+bjSD0ItJRFfILvOQIuEE
 jg1apDTFBiOVrXupGJV+mMQdYApwYEJMu275waa4jTHKBYYthPa9bMSsKci8Lj9FlWWo59WM4
 LA9gKkzo9U/DceB1Rx4gyssw+ie9nTABvBbGuKYaBIhuMU01E0JmENmRus3j1X6iB6EjQ0x1m
 Gf/lVjtiJz8RW0pvPSXNnsZBKsyzSKUzCnE+hE+y8NI3+6SeWDeQLjX2AurMOo+D69MOjgOIu
 i4MrhkebQlHlScUfiRTL9l3WthY4sdZfmlEnUnVTj7GkH9z4hX65abptH3N7qqo/+0CkP5Pj4
 hpFnHZRPaQHMDzvyM18jXor10CV1lFT/aCV1n1lqjhMWhg+rjeuFvdtZeMKnQT7Vex6HHx2kV
 Z5tBhc01iKP5tpKV2WKMjzY8NgP6JRPZoqAyNGqhX7RLvPF5TbNrKE4LAxAv4shcWFVR6m7WN
 w53IwHhhE/D4u0e0RNzCJwcG08xW7fMtP5fz04qABCVwmRdLmS2Xb64ToEQV6CGCRJlR0fbrZ
 44AsLrTC4TPOmB5G4ux3/0x3VjfRnzHEG2EwF1gdkpaNggJV9xYd5pGsxhQcqhvBSxC1BLUro
 Bf8pSNB07/RDZ0FatXMrosi7iUtTsLzuAODqmv+E12Nv0HBTaE5yeXqCDWBt5e5ar78O1f5sB
 +jrPjcS2pqiz2srwj+tzrguTOuLNICJFpzDky0kX7roJhwGruE942ChZlY2fkLZg9vElyS5fg
 DvNnQXt73U58ba2GiBSuDPUziU8k/xAITFhsZ7BMCItSZf84ZNfmY++SjHOjQn0V/FG8326ZO
 QiAtcuDEaWaef8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:56, Christoph Hellwig wrote:
> ---

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>   fs/btrfs/compression.c | 26 ++++++++-----------------
>   fs/btrfs/extent_io.c   | 24 ++++++++---------------
>   fs/btrfs/inode.c       | 32 ++++++++++--------------------
>   fs/btrfs/volumes.c     | 44 +++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/volumes.h     | 20 ++-----------------
>   5 files changed, 69 insertions(+), 77 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ae6f986058c75..fca025c327a7e 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -445,10 +445,9 @@ static struct bio *alloc_compressed_bio(struct comp=
ressed_bio *cb, u64 disk_byte
>   					u64 *next_stripe_start)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(cb->inode->i_sb);
> -	struct btrfs_io_geometry geom;
> -	struct extent_map *em;
> +	struct block_device *bdev;
>   	struct bio *bio;
> -	int ret;
> +	u64 len;
>
>   	bio =3D btrfs_bio_alloc(cb->inode, BIO_MAX_VECS, opf);
>   	bio->bi_iter.bi_sector =3D disk_bytenr >> SECTOR_SHIFT;
> @@ -459,23 +458,14 @@ static struct bio *alloc_compressed_bio(struct com=
pressed_bio *cb, u64 disk_byte
>   	else
>   		btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_READ;
>
> -	em =3D btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
> -	if (IS_ERR(em)) {
> -		bio_put(bio);
> -		return ERR_CAST(em);
> -	}
> +	bdev =3D btrfs_get_stripe_info(fs_info, btrfs_op(bio), disk_bytenr,
> +			      fs_info->sectorsize, &len);
> +	if (IS_ERR(bdev))
> +		return ERR_CAST(bdev);
>
>   	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
> -		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
> -
> -	ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr,=
 &geom);
> -	free_extent_map(em);
> -	if (ret < 0) {
> -		bio_put(bio);
> -		return ERR_PTR(ret);
> -	}
> -	*next_stripe_start =3D disk_bytenr + geom.len;
> -
> +		bio_set_dev(bio, bdev);
> +	*next_stripe_start =3D disk_bytenr + len;
>   	return bio;
>   }
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bfd91ed27bd14..10fc5e4dd14a3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3235,11 +3235,10 @@ static int calc_bio_boundaries(struct btrfs_bio_=
ctrl *bio_ctrl,
>   			       struct btrfs_inode *inode, u64 file_offset)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	struct btrfs_io_geometry geom;
>   	struct btrfs_ordered_extent *ordered;
> -	struct extent_map *em;
>   	u64 logical =3D (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
> -	int ret;
> +	struct block_device *bdev;
> +	u64 len;
>
>   	/*
>   	 * Pages for compressed extent are never submitted to disk directly,
> @@ -3253,19 +3252,12 @@ static int calc_bio_boundaries(struct btrfs_bio_=
ctrl *bio_ctrl,
>   		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;
>   		return 0;
>   	}
> -	em =3D btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
> -	if (IS_ERR(em))
> -		return PTR_ERR(em);
> -	ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
> -				    logical, &geom);
> -	free_extent_map(em);
> -	if (ret < 0) {
> -		return ret;
> -	}
> -	if (geom.len > U32_MAX)
> -		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;
> -	else
> -		bio_ctrl->len_to_stripe_boundary =3D (u32)geom.len;
> +
> +	bdev =3D btrfs_get_stripe_info(fs_info, btrfs_op(bio_ctrl->bio), logic=
al,
> +			      fs_info->sectorsize, &len);
> +	if (IS_ERR(bdev))
> +		return PTR_ERR(bdev);
> +	bio_ctrl->len_to_stripe_boundary =3D min(len, (u64)U32_MAX);
>
>   	if (bio_op(bio_ctrl->bio) !=3D REQ_OP_ZONE_APPEND) {
>   		bio_ctrl->len_to_oe_boundary =3D U32_MAX;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d4faed31d36a4..3f7e1779ff19f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7944,12 +7944,9 @@ static void btrfs_submit_direct(const struct ioma=
p_iter *iter,
>   	u64 submit_len;
>   	u64 clone_offset =3D 0;
>   	u64 clone_len;
> -	u64 logical;
> -	int ret;
>   	blk_status_t status;
> -	struct btrfs_io_geometry geom;
>   	struct btrfs_dio_data *dio_data =3D iter->private;
> -	struct extent_map *em =3D NULL;
> +	u64 len;
>
>   	dip =3D btrfs_create_dio_private(dio_bio, inode, file_offset);
>   	if (!dip) {
> @@ -7978,21 +7975,16 @@ static void btrfs_submit_direct(const struct iom=
ap_iter *iter,
>   	submit_len =3D dio_bio->bi_iter.bi_size;
>
>   	do {
> -		logical =3D start_sector << 9;
> -		em =3D btrfs_get_chunk_map(fs_info, logical, submit_len);
> -		if (IS_ERR(em)) {
> -			status =3D errno_to_blk_status(PTR_ERR(em));
> -			em =3D NULL;
> -			goto out_err_em;
> -		}
> -		ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
> -					    logical, &geom);
> -		if (ret) {
> -			status =3D errno_to_blk_status(ret);
> -			goto out_err_em;
> +		struct block_device *bdev;
> +
> +		bdev =3D btrfs_get_stripe_info(fs_info, btrfs_op(dio_bio),
> +				      start_sector << 9, submit_len, &len);
> +		if (IS_ERR(bdev)) {
> +			status =3D errno_to_blk_status(PTR_ERR(bdev));
> +			goto out_err;
>   		}
>
> -		clone_len =3D min(submit_len, geom.len);
> +		clone_len =3D min(submit_len, len);
>   		ASSERT(clone_len <=3D UINT_MAX);
>
>   		/*
> @@ -8044,20 +8036,16 @@ static void btrfs_submit_direct(const struct iom=
ap_iter *iter,
>   			bio_put(bio);
>   			if (submit_len > 0)
>   				refcount_dec(&dip->refs);
> -			goto out_err_em;
> +			goto out_err;
>   		}
>
>   		dio_data->submitted +=3D clone_len;
>   		clone_offset +=3D clone_len;
>   		start_sector +=3D clone_len >> 9;
>   		file_offset +=3D clone_len;
> -
> -		free_extent_map(em);
>   	} while (submit_len > 0);
>   	return;
>
> -out_err_em:
> -	free_extent_map(em);
>   out_err:
>   	dip->dio_bio->bi_status =3D status;
>   	btrfs_dio_private_put(dip);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7392b9f2a3323..f70bb3569a7ae 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6301,6 +6301,21 @@ static bool need_full_stripe(enum btrfs_map_op op=
)
>   	return (op =3D=3D BTRFS_MAP_WRITE || op =3D=3D BTRFS_MAP_GET_READ_MIR=
RORS);
>   }
>
> +struct btrfs_io_geometry {
> +	/* remaining bytes before crossing a stripe */
> +	u64 len;
> +	/* offset of logical address in chunk */
> +	u64 offset;
> +	/* length of single IO stripe */
> +	u64 stripe_len;
> +	/* number of stripe where address falls */
> +	u64 stripe_nr;
> +	/* offset of address in stripe */
> +	u64 stripe_offset;
> +	/* offset of raid56 stripe into the chunk */
> +	u64 raid56_stripe_offset;
> +};
> +
>   /*
>    * Calculate the geometry of a particular (address, len) tuple. This
>    * information is used to calculate how big a particular bio can get b=
efore it
> @@ -6315,9 +6330,10 @@ static bool need_full_stripe(enum btrfs_map_op op=
)
>    * Returns < 0 in case a chunk for the given logical address cannot be=
 found,
>    * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
>    */
> -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_=
map *em,
> -			  enum btrfs_map_op op, u64 logical,
> -			  struct btrfs_io_geometry *io_geom)
> +static int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info,
> +		struct extent_map *em,
> +		enum btrfs_map_op op, u64 logical,
> +		struct btrfs_io_geometry *io_geom)
>   {
>   	struct map_lookup *map;
>   	u64 len;
> @@ -6394,6 +6410,28 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *f=
s_info, struct extent_map *em,
>   	return 0;
>   }
>
> +struct block_device *btrfs_get_stripe_info(struct btrfs_fs_info *fs_inf=
o,
> +		enum btrfs_map_op op, u64 logical, u64 len, u64 *lenp)
> +{
> +	struct btrfs_io_geometry geom;
> +	struct block_device *bdev;
> +	struct extent_map *em;
> +	int ret;
> +
> +	em =3D btrfs_get_chunk_map(fs_info, logical, len);
> +	if (IS_ERR(em))
> +		return ERR_CAST(em);
> +
> +	bdev =3D em->map_lookup->stripes[0].dev->bdev;
> +
> +	ret =3D btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
> +	free_extent_map(em);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	*lenp =3D geom.len;
> +	return bdev;
> +}
> +
>   static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   		enum btrfs_map_op op, u64 logical, u64 *length,
>   		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5b0e7602434b0..c6425760f69da 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -17,21 +17,6 @@ extern struct mutex uuid_mutex;
>
>   #define BTRFS_STRIPE_LEN	SZ_64K
>
> -struct btrfs_io_geometry {
> -	/* remaining bytes before crossing a stripe */
> -	u64 len;
> -	/* offset of logical address in chunk */
> -	u64 offset;
> -	/* length of single IO stripe */
> -	u64 stripe_len;
> -	/* number of stripe where address falls */
> -	u64 stripe_nr;
> -	/* offset of address in stripe */
> -	u64 stripe_offset;
> -	/* offset of raid56 stripe into the chunk */
> -	u64 raid56_stripe_offset;
> -};
> -
>   /*
>    * Use sequence counter to get consistent device stat data on
>    * 32-bit processors.
> @@ -520,9 +505,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, e=
num btrfs_map_op op,
>   int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
>   		     u64 logical, u64 *length,
>   		     struct btrfs_io_context **bioc_ret);
> -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_=
map *map,
> -			  enum btrfs_map_op op, u64 logical,
> -			  struct btrfs_io_geometry *io_geom);
> +struct block_device *btrfs_get_stripe_info(struct btrfs_fs_info *fs_inf=
o,
> +		enum btrfs_map_op op, u64 logical, u64 length, u64 *lenp);
>   int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
>   int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
>   struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle=
 *trans,
