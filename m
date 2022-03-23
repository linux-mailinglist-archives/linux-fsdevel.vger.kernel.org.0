Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464844E4A60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiCWBPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCWBPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:15:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F615DE51;
        Tue, 22 Mar 2022 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647998051;
        bh=ykcwfs7duRpr37wVxMlQmEsne5oDW/w50F3NWdKc6TU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Iow8RUIgJjzZuucw97dkTkkKQjPBs+Y/x3iGtcSwfDDe+7M6eg5yS/yyfj5fRIOtf
         Li8gP+tXGWIZgmIyv4PZZ0l9ndfWdRMAo80xhCG4jlxjU+b3c6BaiRMVtPxId70krw
         S3DGD3rdm7c8FNXmwTdXpIhvFttJRZgh41NQnmWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1o1CaG2GxO-00eLLK; Wed, 23
 Mar 2022 02:14:11 +0100
Message-ID: <d9062a7d-c83c-06d7-50ac-272ffc0788f1@gmx.com>
Date:   Wed, 23 Mar 2022 09:14:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 28/40] btrfs: do not allocate a btrfs_io_context in
 btrfs_map_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-29-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-29-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CjENuyd4KxWbZaAQaKOA3MX5iN0J0p/Pkb2hhU3HqY7zgeRaUQd
 IZveiG3tbV9n/DNDZcm/ydN9hXGePXQTM+g/yIJCFlpwSlNIxr2MRWhUrGUnmBPYHdgsC/B
 oBJcVV73A+N9AlGli3j3W3M3TiT9rIHYdyD+8MRSmzCpAvUWTmBPpS0gKcS/XXchsnztq2n
 EAPhZgPUiA5mB9kKsSi1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dm6JimvR9TA=:Pg+tvAmFrXOVyExFu4hBAb
 hL/Guyt1xftlW5BWyzb46GEPMPailFahtyzKLn0vJBnI+IsbEmzDwg1bFo07YuWdBjVQR8PTL
 YrM3dKz6JRgbR1nMks5F0XXc+TVfel+eeMfW3073PQwAI23JebmRB0WTpj6H4ab6hyulODgGj
 ShpDwPutwaRoA/0Dy8ZOAajbjsHVFV/txs5vbikq9Fzm73oz3VNlGXlUD/xj4fvPwZ4Y1EGKq
 kcAl9hpLXFgEyaCm12wg+7RwxGjzyEGOFOLOVGjcvE3+LWMEoAjpmwhDE+mcQG/WExGq+Sb+i
 RN8Vx/FmoS8g+oxLR4ak2W/3zE2XqJWmEBhVRYeZDVFYUEWnNXiTYltYq8RFKEVRx+Uzj6siY
 G6T05CURuHUsOpAG759tFSg/jBqZT04Z1nLYRCrCBj5gkg6zpkHownJlGE/JqAwmOTzf7bknr
 MIl9EVDYB1TyZWl+iURx4f/qvPWK7UncSKrCIS6KkdqJKl0Idccp0o5WP3/2N4lJChRkeCH/p
 WDWli9Y3w72crA5sWEde3QixmssPjeTC60yjqBm/G7ZA+rUzbaA+1MjNMrI85Bn2zkaAXWXW9
 ntWkevkDVvKu5LrDBTCphkfix5q4q5tdtlDLoWB/Xv38VsStm8pztilHs29pz1lp9y9xBt7XO
 URn5/FrPqzd3CgF8sO3fIQXTjEvkQXNYWqvonylSAk+mTwhUVuk2sC071+gy05mkr2dweWsgQ
 FBqxRuiTMb4GBjwHyQCnau8FPy+Z9KXN+xmaPnPg7xdsYAa9qZuT+cKsRnvlFNTlukzRhRM+b
 ExsWcJEc0HkNrMh6DM27xm352wRFqZA3C48sFvdA5Tms+3Rbvz7cdufuxaP9P/dBuGOtBPE25
 nUQrxE99bxnvImTSzCOhgGaDJhzOzQMFuucZn+ndMhza8S/IY5O5zW6jf0ktSD+s0YbzfU1VU
 Fd2fHKUmL67RuSswcxJwW8YculEFUF4VFbuRJ/dZlvYKQdzYpBf4cYEB/1kd2kr+q2iLgJl0B
 Reb7oAvKwlwGrz2oUvmiDMxK66VgENXt50IIHzQwF8oVeXNVbfoHVuAqc+PBFH4vXclGAQJ7n
 zkmiCfHUYIzGCg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:55, Christoph Hellwig wrote:
> There is very little of the I/O context that is actually needed for
> issuing a bio.  Add the few needed fields to struct btrfs_bio instead.
>
> The stripes array is still allocated on demand when more than a single
> I/O is needed, but for single leg I/O (e.g. all reads) there is no
> additional memory allocation now.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Really not a fan of enlarging btrfs_bio again and again.

Especially for the btrfs_bio_stripe and btrfs_bio_stripe * part.

Considering how many bytes we waste for SINGLE profile, now we need an
extra pointer which we will never really use.

Thanks,
Qu


> ---
>   fs/btrfs/volumes.c | 147 ++++++++++++++++++++++++++++-----------------
>   fs/btrfs/volumes.h |  20 ++++--
>   2 files changed, 107 insertions(+), 60 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cc9e2565e4b64..cec3f6b9f5c21 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -253,10 +253,9 @@ static int btrfs_relocate_sys_chunks(struct btrfs_f=
s_info *fs_info);
>   static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
>   static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
>   static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
> -			     enum btrfs_map_op op,
> -			     u64 logical, u64 *length,
> -			     struct btrfs_io_context **bioc_ret,
> -			     int mirror_num, int need_raid_map);
> +		enum btrfs_map_op op, u64 logical, u64 *length,
> +		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
> +		int mirror_num, int need_raid_map);
>
>   /*
>    * Device locking
> @@ -5926,7 +5925,6 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   		sizeof(u64) * (total_stripes),
>   		GFP_NOFS|__GFP_NOFAIL);
>
> -	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
>
>   	bioc->fs_info =3D fs_info;
> @@ -6128,7 +6126,7 @@ static int get_extra_mirror_from_replace(struct bt=
rfs_fs_info *fs_info,
>   	int ret =3D 0;
>
>   	ret =3D __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> -				logical, &length, &bioc, 0, 0);
> +				logical, &length, &bioc, NULL, 0, 0);
>   	if (ret) {
>   		ASSERT(bioc =3D=3D NULL);
>   		return ret;
> @@ -6397,10 +6395,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *f=
s_info, struct extent_map *em,
>   }
>
>   static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
> -			     enum btrfs_map_op op,
> -			     u64 logical, u64 *length,
> -			     struct btrfs_io_context **bioc_ret,
> -			     int mirror_num, int need_raid_map)
> +		enum btrfs_map_op op, u64 logical, u64 *length,
> +		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
> +		int mirror_num, int need_raid_map)
>   {
>   	struct extent_map *em;
>   	struct map_lookup *map;
> @@ -6566,6 +6563,48 @@ static int __btrfs_map_block(struct btrfs_fs_info=
 *fs_info,
>   		tgtdev_indexes =3D num_stripes;
>   	}
>
> +	if (need_full_stripe(op))
> +		max_errors =3D btrfs_chunk_max_errors(map);
> +
> +	if (bbio && !need_raid_map) {
> +		int replacement_idx =3D num_stripes;
> +
> +		if (num_alloc_stripes > 1) {
> +			bbio->stripes =3D kmalloc_array(num_alloc_stripes,
> +					sizeof(*bbio->stripes),
> +					GFP_NOFS | __GFP_NOFAIL);
> +		} else {
> +			bbio->stripes =3D &bbio->__stripe;
> +		}
> +
> +		atomic_set(&bbio->stripes_pending, num_stripes);
> +		for (i =3D 0; i < num_stripes; i++) {
> +			struct btrfs_bio_stripe *s =3D &bbio->stripes[i];
> +
> +			s->physical =3D map->stripes[stripe_index].physical +
> +				stripe_offset + stripe_nr * map->stripe_len;
> +			s->dev =3D map->stripes[stripe_index].dev;
> +			stripe_index++;
> +
> +			if (op =3D=3D BTRFS_MAP_WRITE && dev_replace_is_ongoing &&
> +			    dev_replace->tgtdev &&
> +			    !is_block_group_to_copy(fs_info, logical) &&
> +			    s->dev->devid =3D=3D dev_replace->srcdev->devid) {
> +				struct btrfs_bio_stripe *r =3D
> +					&bbio->stripes[replacement_idx++];
> +
> +				r->physical =3D s->physical;
> +				r->dev =3D dev_replace->tgtdev;
> +				max_errors++;
> +				atomic_inc(&bbio->stripes_pending);
> +			}
> +		}
> +
> +		bbio->max_errors =3D max_errors;
> +		bbio->mirror_num =3D mirror_num;
> +		goto out;
> +	}
> +
>   	bioc =3D alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_in=
dexes);
>   	if (!bioc) {
>   		ret =3D -ENOMEM;
> @@ -6601,9 +6640,6 @@ static int __btrfs_map_block(struct btrfs_fs_info =
*fs_info,
>   		sort_parity_stripes(bioc, num_stripes);
>   	}
>
> -	if (need_full_stripe(op))
> -		max_errors =3D btrfs_chunk_max_errors(map);
> -
>   	if (dev_replace_is_ongoing && dev_replace->tgtdev !=3D NULL &&
>   	    need_full_stripe(op)) {
>   		handle_ops_on_dev_replace(op, &bioc, dev_replace, logical,
> @@ -6646,7 +6682,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   						     length, bioc_ret);
>
>   	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
> -				 mirror_num, 0);
> +				 NULL, mirror_num, 0);
>   }
>
>   /* For Scrub/replace */
> @@ -6654,14 +6690,15 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>   		     u64 logical, u64 *length,
>   		     struct btrfs_io_context **bioc_ret)
>   {
> -	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1)=
;
> +	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, NULL,
> +				 0, 1);
>   }
>
> -static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_io_context =
*bioc)
> +static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_bio *bbio)
>   {
> -	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(bbio->inode->i_sb);
>
> -	switch (btrfs_bio(bioc->orig_bio)->end_io_type) {
> +	switch (bbio->end_io_type) {
>   	case BTRFS_ENDIO_WQ_DATA_READ:
>   		return fs_info->endio_workers;
>   	case BTRFS_ENDIO_WQ_DATA_WRITE:
> @@ -6682,21 +6719,22 @@ static void btrfs_end_bio_work(struct btrfs_work=
 *work)
>   	bio_endio(&bbio->bio);
>   }
>
> -static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
> +static void btrfs_end_bbio(struct btrfs_bio *bbio, bool async)
>   {
> -	struct btrfs_workqueue *wq =3D async ? btrfs_end_io_wq(bioc) : NULL;
> -	struct bio *bio =3D bioc->orig_bio;
> -	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> +	struct btrfs_workqueue *wq =3D async ? btrfs_end_io_wq(bbio) : NULL;
> +	struct bio *bio =3D &bbio->bio;
>
> -	bbio->mirror_num =3D bioc->mirror_num;
> -	bio->bi_private =3D bioc->private;
> -	bio->bi_end_io =3D bioc->end_io;
> +	bio->bi_private =3D bbio->private;
> +	bio->bi_end_io =3D bbio->end_io;
> +
> +	if (bbio->stripes !=3D &bbio->__stripe)
> +		kfree(bbio->stripes);
>
>   	/*
>   	 * Only send an error to the higher layers if it is beyond the tolera=
nce
>   	 * threshold.
>   	 */
> -	if (atomic_read(&bioc->error) > bioc->max_errors)
> +	if (atomic_read(&bbio->error) > bbio->max_errors)
>   		bio->bi_status =3D BLK_STS_IOERR;
>   	else
>   		bio->bi_status =3D BLK_STS_OK;
> @@ -6707,16 +6745,14 @@ static void btrfs_end_bioc(struct btrfs_io_conte=
xt *bioc, bool async)
>   	} else {
>   		bio_endio(bio);
>   	}
> -
> -	btrfs_put_bioc(bioc);
>   }
>
>   static void btrfs_end_bio(struct bio *bio)
>   {
> -	struct btrfs_io_context *bioc =3D bio->bi_private;
> +	struct btrfs_bio *bbio =3D bio->bi_private;
>
>   	if (bio->bi_status) {
> -		atomic_inc(&bioc->error);
> +		atomic_inc(&bbio->error);
>   		if (bio->bi_status =3D=3D BLK_STS_IOERR ||
>   		    bio->bi_status =3D=3D BLK_STS_TARGET) {
>   			struct btrfs_device *dev =3D btrfs_bio(bio)->device;
> @@ -6734,40 +6770,39 @@ static void btrfs_end_bio(struct bio *bio)
>   		}
>   	}
>
> -	if (bio !=3D bioc->orig_bio)
> +	if (bio !=3D &bbio->bio)
>   		bio_put(bio);
>
> -	btrfs_bio_counter_dec(bioc->fs_info);
> -	if (atomic_dec_and_test(&bioc->stripes_pending))
> -		btrfs_end_bioc(bioc, true);
> +	btrfs_bio_counter_dec(btrfs_sb(bbio->inode->i_sb));
> +	if (atomic_dec_and_test(&bbio->stripes_pending))
> +		btrfs_end_bbio(bbio, true);
>   }
>
> -static void submit_stripe_bio(struct btrfs_io_context *bioc,
> -		struct bio *orig_bio, int dev_nr, bool clone)
> +static void submit_stripe_bio(struct btrfs_bio *bbio, int dev_nr, bool =
clone)
>   {
> -	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> -	struct btrfs_device *dev =3D bioc->stripes[dev_nr].dev;
> -	u64 physical =3D bioc->stripes[dev_nr].physical;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(bbio->inode->i_sb);
> +	struct btrfs_device *dev =3D bbio->stripes[dev_nr].dev;
> +	u64 physical =3D bbio->stripes[dev_nr].physical;
>   	struct bio *bio;
>
>   	if (!dev || !dev->bdev ||
>   	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> -	    (btrfs_op(orig_bio) =3D=3D BTRFS_MAP_WRITE &&
> +	    (btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE &&
>   	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -		atomic_inc(&bioc->error);
> -		if (atomic_dec_and_test(&bioc->stripes_pending))
> -			btrfs_end_bioc(bioc, false);
> +		atomic_inc(&bbio->error);
> +		if (atomic_dec_and_test(&bbio->stripes_pending))
> +			btrfs_end_bbio(bbio, false);
>   		return;
>   	}
>
>   	if (clone) {
> -		bio =3D btrfs_bio_clone(dev->bdev, orig_bio);
> +		bio =3D btrfs_bio_clone(dev->bdev, &bbio->bio);
>   	} else {
> -		bio =3D orig_bio;
> +		bio =3D &bbio->bio;
>   		bio_set_dev(bio, dev->bdev);
>   	}
>
> -	bio->bi_private =3D bioc;
> +	bio->bi_private =3D bbio;
>   	btrfs_bio(bio)->device =3D dev;
>   	bio->bi_end_io =3D btrfs_end_bio;
>   	bio->bi_iter.bi_sector =3D physical >> 9;
> @@ -6800,6 +6835,7 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc,
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *=
bio,
>   			   int mirror_num)
>   {
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	u64 logical =3D bio->bi_iter.bi_sector << 9;
>   	u64 length =3D bio->bi_iter.bi_size;
>   	u64 map_length =3D length;
> @@ -6809,18 +6845,17 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info =
*fs_info, struct bio *bio,
>   	struct btrfs_io_context *bioc =3D NULL;
>
>   	btrfs_bio_counter_inc_blocked(fs_info);
> -	ret =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical,
> -				&map_length, &bioc, mirror_num, 1);
> +	ret =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length=
,
> +				&bioc, bbio, mirror_num, 1);
>   	if (ret)
>   		goto out_dec;
>
> -	total_devs =3D bioc->num_stripes;
> -	bioc->orig_bio =3D bio;
> -	bioc->private =3D bio->bi_private;
> -	bioc->end_io =3D bio->bi_end_io;
> -	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
> +	bbio->private =3D bio->bi_private;
> +	bbio->end_io =3D bio->bi_end_io;
> +
> +	if (bioc) {
> +		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
>
> -	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>   		/*
>   		 * In this case, map_length has been set to the length of a
>   		 * single stripe; not the whole write.
> @@ -6834,6 +6869,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   						    mirror_num, 1);
>   			goto out_dec;
>   		}
> +		ASSERT(0);
>   	}
>
>   	if (map_length < length) {
> @@ -6843,8 +6879,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   		BUG();
>   	}
>
> +	total_devs =3D atomic_read(&bbio->stripes_pending);
>   	for (dev_nr =3D 0; dev_nr < total_devs; dev_nr++)
> -		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
> +		submit_stripe_bio(bbio, dev_nr, dev_nr < total_devs - 1);
>   out_dec:
>   	btrfs_bio_counter_dec(fs_info);
>   	return errno_to_blk_status(ret);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 51a27180004eb..cd71cd33a9df2 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -323,6 +323,11 @@ enum btrfs_endio_type {
>   	BTRFS_ENDIO_WQ_FREE_SPACE_READ,
>   };
>
> +struct btrfs_bio_stripe {
> +	struct btrfs_device *dev;
> +	u64 physical;
> +};
> +
>   /*
>    * Additional info to pass along bio.
>    *
> @@ -333,6 +338,16 @@ struct btrfs_bio {
>
>   	unsigned int mirror_num;
>
> +	atomic_t stripes_pending;
> +	atomic_t error;
> +	int max_errors;
> +
> +	struct btrfs_bio_stripe *stripes;
> +	struct btrfs_bio_stripe __stripe;
> +
> +	bio_end_io_t *end_io;
> +	void *private;
> +
>   	enum btrfs_endio_type end_io_type;
>   	struct btrfs_work work;
>
> @@ -389,13 +404,8 @@ struct btrfs_io_stripe {
>    */
>   struct btrfs_io_context {
>   	refcount_t refs;
> -	atomic_t stripes_pending;
>   	struct btrfs_fs_info *fs_info;
>   	u64 map_type; /* get from map_lookup->type */
> -	bio_end_io_t *end_io;
> -	struct bio *orig_bio;
> -	void *private;
> -	atomic_t error;
>   	int max_errors;
>   	int num_stripes;
>   	int mirror_num;
