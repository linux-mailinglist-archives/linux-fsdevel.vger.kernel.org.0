Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2AC4E4A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiCWBFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCWBFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:05:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD876EC47;
        Tue, 22 Mar 2022 18:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647997451;
        bh=rr8BhoskNUtNFaaC2Mpn8xLYZWRGAZSp9myku4zz2vs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SdT+7cElXYl76FH28qYSDyhExuuCV9EGtTsLrIkYbA0sE75o/+iDSKjDie3z0YiSt
         +CZzQ2Ued+KOFkZ1N8Ra/610XxWUue4aK1tWUQygOS5Jst/ocfH6UQjHPpxJ2ydXHa
         8p+SLD5dDxeSiRlMHRbVDCjr3drtm7hgatotKoI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6UZv-1nQUpX1NFZ-006veG; Wed, 23
 Mar 2022 02:04:11 +0100
Message-ID: <a1471bb3-aeca-934e-7970-8688371769e6@gmx.com>
Date:   Wed, 23 Mar 2022 09:03:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 26/40] btrfs: refactor btrfs_map_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-27-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-27-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IFakkNiqfOlD5D3+3UGrOyqlliSwYie0dXLBWCZe5mUZWsq6Bmm
 XQLHQfs67dLHa+czEhvX439TYwkebDD76WIBOc+VZKHpxtbUJR88XdMcIm0emnpO86Qfg/i
 tnesNx/zlMR+FC410iNBXIddznIcO0ZeTQyISdVbVxMbE301cCtFbk+U+kKCTkk5aI+RLvy
 l4YQ8rQezuWEfQvbYz/UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t2Rlx5LlLOw=:8gPKPByLO9kjLLSFaS+S8c
 m7H61YpXFAOiHIgpAaVwFQIH7lhek2ZQFXHonsgW3tZgHQmYtj73DuRiX74H7Qp5Amj2Y3xwh
 4IgRnhLx2RnCvY11M0puODGfXRwjbem9LrFawvW46zYvcifo2beyhs8Sse1A1bNz5gK+7iAm6
 9MadzjcNVs+rDoi17nslE3mvsMDuo5l/mfZPe02nfwikT8/XdzADcwTo+GmsYXi+moLI2rEiP
 wEfW6JHzN3SmdnhhsDE5njZaS+ryNqcIShyh9npknU0fWTpLP/KGByjIj4hlAIYGv+1/zA72g
 iRVV6uPFNUspK+0KsEKfY0dM5zSrL0xJ0BMhvpLeHDRJGuBt5z73x2d4xPRmZUHScGHYhcJko
 PHEwf3qvlbtQMp7kkTkgB2q5e8Q+f03j8dn1qaeD/6P2kpvnPif4XF+8PdTsh+DJqmR39BUMt
 voubpHQap2PpxuBmF65SRcuAkQS48+0uXqzmDs9YdB/oLWxzH0CkLUwFjuL88+KF1Y/vZXj8/
 bdAMBc4EMn0Y/bACYQ0Sgdb/CEixgctdM7BakWX7hbCo7F57MYzuT8IZM3Pd7Dz/8joamaW9u
 Hr17t7QTuHlIuVMZvLKlctoD7tlEo7oL3oFkwB09WAqEzXXyJX8pt0Mosf0BLkLOSqXMSaLRj
 dRA8Pd5hy154/Ys0ODedWDHZxar0dkqzQDRj2Y0d3UfO/wFjmd0cGY4J8E/IECoAKDcZT7e9Z
 TZ9+SdGDVOn006VM3ADQ3JTJ/PXmVKwi7d9WUpMNeP8Kqd8fKdaDkjXsGj5S7bFqdoTDEe4Rs
 OlO3YbHhQBbboUBF7Ao+l1jCUQ5WFLqL73OoZAdg1t5Bzsz1z7l872wPZnFGvtuFaN5+oeZt4
 XfoC2DdrI5ZegP2ocZAoHyErmcfe/zie+4xYonRgQBgY2n27QeGL1PUt/JXSGQ2kwcsuRuiTY
 HMyTXGPe5ql9mgYH+lqDnue88rV287xWrTR75WI26BUcZdBhsZuv+XhoW3tMNey155oOU81t7
 5YtZvjTZNDP8ERYw4A3MCEH2CODR2m+oe3XBbAUWOI/bBHpJDrcjRWCGaTYdUkCy4HDShx+h5
 36EJ5ZtrwamCKU=
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
> Use a label for common cleanup, untangle the conditionals for parity
> RAID and move all per-stripe handling into submit_stripe_bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 88 ++++++++++++++++++++++------------------------
>   1 file changed, 42 insertions(+), 46 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9a1eb1166d72f..1cf0914b33847 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6744,10 +6744,30 @@ static void btrfs_end_bio(struct bio *bio)
>   		btrfs_end_bioc(bioc, true);
>   }
>
> -static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio=
 *bio,
> -			      u64 physical, struct btrfs_device *dev)
> +static void submit_stripe_bio(struct btrfs_io_context *bioc,
> +		struct bio *orig_bio, int dev_nr, bool clone)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> +	struct btrfs_device *dev =3D bioc->stripes[dev_nr].dev;
> +	u64 physical =3D bioc->stripes[dev_nr].physical;
> +	struct bio *bio;
> +
> +	if (!dev || !dev->bdev ||
> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> +	    (btrfs_op(orig_bio) =3D=3D BTRFS_MAP_WRITE &&
> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> +		atomic_inc(&bioc->error);
> +		if (atomic_dec_and_test(&bioc->stripes_pending))
> +			btrfs_end_bioc(bioc, false);
> +		return;
> +	}
> +
> +	if (clone) {
> +		bio =3D btrfs_bio_clone(dev->bdev, orig_bio);
> +	} else {
> +		bio =3D orig_bio;
> +		bio_set_dev(bio, dev->bdev);
> +	}
>
>   	bio->bi_private =3D bioc;
>   	btrfs_bio(bio)->device =3D dev;
> @@ -6782,46 +6802,40 @@ static void submit_stripe_bio(struct btrfs_io_co=
ntext *bioc, struct bio *bio,
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *=
bio,
>   			   int mirror_num)
>   {
> -	struct btrfs_device *dev;
> -	struct bio *first_bio =3D bio;
>   	u64 logical =3D bio->bi_iter.bi_sector << 9;
> -	u64 length =3D 0;
> -	u64 map_length;
> +	u64 length =3D bio->bi_iter.bi_size;
> +	u64 map_length =3D length;
>   	int ret;
>   	int dev_nr;
>   	int total_devs;
>   	struct btrfs_io_context *bioc =3D NULL;
>
> -	length =3D bio->bi_iter.bi_size;
> -	map_length =3D length;
> -
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	ret =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical,
>   				&map_length, &bioc, mirror_num, 1);
> -	if (ret) {
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);
> -	}
> +	if (ret)
> +		goto out_dec;
>
>   	total_devs =3D bioc->num_stripes;
> -	bioc->orig_bio =3D first_bio;
> -	bioc->private =3D first_bio->bi_private;
> -	bioc->end_io =3D first_bio->bi_end_io;
> +	bioc->orig_bio =3D bio;
> +	bioc->private =3D bio->bi_private;
> +	bioc->end_io =3D bio->bi_end_io;
>   	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
>
> -	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
> -	    ((btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> -		/* In this case, map_length has been set to the length of
> -		   a single stripe; not the whole write */
> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		/*
> +		 * In this case, map_length has been set to the length of a
> +		 * single stripe; not the whole write.
> +		 */
>   		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
>   			ret =3D raid56_parity_write(bio, bioc, map_length);
> -		} else {
> +			goto out_dec;
> +		}
> +		if (mirror_num > 1) {
>   			ret =3D raid56_parity_recover(bio, bioc, map_length,
>   						    mirror_num, 1);
> +			goto out_dec;
>   		}
> -
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);

Can we add some extra comment on the fall through cases?

The read path still needs to go through the regular routine.

Otherwise looks good to me.

Thanks,
Qu

>   	}
>
>   	if (map_length < length) {
> @@ -6831,29 +6845,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info =
*fs_info, struct bio *bio,
>   		BUG();
>   	}
>
> -	for (dev_nr =3D 0; dev_nr < total_devs; dev_nr++) {
> -		dev =3D bioc->stripes[dev_nr].dev;
> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
> -						   &dev->dev_state) ||
> -		    (btrfs_op(first_bio) =3D=3D BTRFS_MAP_WRITE &&
> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -			atomic_inc(&bioc->error);
> -			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc, false);
> -			continue;
> -		}
> -
> -		if (dev_nr < total_devs - 1) {
> -			bio =3D btrfs_bio_clone(dev->bdev, first_bio);
> -		} else {
> -			bio =3D first_bio;
> -			bio_set_dev(bio, dev->bdev);
> -		}
> -
> -		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
> -	}
> +	for (dev_nr =3D 0; dev_nr < total_devs; dev_nr++)
> +		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
> +out_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	return BLK_STS_OK;
> +	return errno_to_blk_status(ret);
>   }
>
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
