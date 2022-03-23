Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D34E4A14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbiCWAbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:31:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B52D1FA;
        Tue, 22 Mar 2022 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647995375;
        bh=WqxLOU0CxpvzOIvs8f609g2mFCcYNo2rqWGb3QscDW8=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=U3Sfk8Ee0Xx+Toc/MwbbT6Z6vDAtQNCBuooGkYNFP7/7VkBJesTPZtZlVPmRMWAvI
         EfTIbIhjCkpXH1NjPQTFf0aVTFQJ0+t2siyAUOgkB8tnHcy/UcZVgGbf+YGgp9eorw
         7cBdDoL08WIfgmYiDwdppFDQHaRhtuuk9rxhJLf0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCtZ-1o6z6n1IDX-00bK1Q; Wed, 23
 Mar 2022 01:29:35 +0100
Message-ID: <5c6320e4-a130-79bf-4229-e5e12bedd921@gmx.com>
Date:   Wed, 23 Mar 2022 08:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-19-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 18/40] btrfs: move more work into btrfs_end_bioc
In-Reply-To: <20220322155606.1267165-19-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jXxdJEg/4y9ZWOTSvSDW1TOXbYlUY12G1dwQglM6FVSNCKbBWr1
 HCLRsPqnc2z8mSiKXxRkPQkQWSue7cAozVdBhfSW7yj+bgc49nuTpRZBrw4xdIJ8qjoJ7Oh
 ndQsE/AXi+k+SbnUUyQAQ7r3vj6Z9NoAYUwRfDx+/ZaS3Q7W3HbNaWzKieLopoQIpNNPGv0
 0pTlvyfvvk3vqjDEuEeYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l9K6+b2kyg0=:+gUXFNqHZQMl2sEqzaHoZQ
 r/jBlZVqbju4V37gKmJw6FQXY18gRW9oypscI7JP7H2trVLlmAFM9Er/DYYJL/VOlScyMvmBL
 eLyZ6fg6dD72SMOd4fGUY9CipcS12HCgpTpH1bl7KmRlJHA8aI3sN932vkz6o4+gkp5iy7FXE
 qRDdyZWITEPOnUzpyUTbrSx1xdzkbu5EQZVD7AkLi/p+zOOzQiyB6kVi+EdbmVfvDyS8C6rd5
 t8TgBBZVFjhYZiHGyyQ3C+JX/kVo1J6QiWsUCMGz/ZPTedNJeKrLlzC9s2p5iZe9RRjSqr6sl
 ST6upFvibINU7gPLhtl8HC8klZOkwBCPG4S7f7gQb3Xhz7v/3inzw62p8o+WprYVNcNiDfxBv
 ChKVzwAcSOQixE5Uf4N1txH0fmCEHCsAxvvt7Kn9upB8mt+Wg1/eLGyzPlUH0uu1SLkGYwEv5
 /+DpO8lXXlGs5+VW1a2txp5xa6ZRz7JGwQcqM7BjwiRLBIi/6j8znDwbW8VmvB+IGNuGUhXpp
 FVJFNFx7ftvf/55HiDW2ThBcqWKNZKG6N+wccvvBsV6zw3XSfeHXui+pgm34kTUaWKwXZzT2j
 j0zFDwQH4DOGdU5+c7JD0Jv/0N2j9BXYOp5aNc6tJ3VnmZHiSIxxAJtX6bMM3a27sKU3ReLF8
 4ENNsqK2RHioxSPi8sHmgHBs9/a3y3cA3YUVnNFTMpxx0UGi8nF61ns5VK+Q7NAoNON//Robi
 q1QplPWq/D/IlLOw57et/f95xQzfJ/rw5xpVumdeY1ZzSsSd8oHoWZbr1jE+RoExgYO2MUO4v
 s1aE9TeN25RAf9944JaN/+gL+vNatAI43CtsXt+8IhqDQZC8qKvwmzivcWh9irFbvWNslspKQ
 0AWdlGpGby/IOQbOEU+O3GT6JOSJafOyCQp+eGAqWaC/VWW9p+Z9Xcvv2iCGALeXlbipJr24T
 vdo8xGygdppxBlARctWNZShmJnuK5bk697np+GtKwKYViduUQ75jH1jeXjWjyIkUSLOJdUTlY
 x27wpB+6DnwU9i0BKQvwgBC7ihvIKu4+rD3RXA7cdxSzNlbmPUDrnXOUq17nja1ERm2zi1Xd0
 rg+oPzOVbrxyJA=
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
> Assign ->mirror_num and ->bi_status in btrfs_end_bioc instead of
> duplicating the logic in the callers.  Also remove the bio argument as
> it always must be bioc->orig_bio and the now pointless bioc_error that
> did nothing but assign bi_sector to the same value just sampled in the
> caller.

Reviewed-by: Qu Wenruo <wqu@suse.com>

It may be better to rename @first_bio or the @bio parameter, as it takes
me several seconds to realize that @bio get reused for RAID1*/DUP bio
cloned submission.

Thanks,
Qu

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 68 ++++++++++++++--------------------------------
>   1 file changed, 20 insertions(+), 48 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4dd54b80dac81..9d1f8c27eff33 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6659,19 +6659,29 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>   	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1=
);
>   }
>
> -static inline void btrfs_end_bioc(struct btrfs_io_context *bioc, struct=
 bio *bio)
> +static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
>   {
> +	struct bio *bio =3D bioc->orig_bio;
> +
> +	btrfs_bio(bio)->mirror_num =3D bioc->mirror_num;
>   	bio->bi_private =3D bioc->private;
>   	bio->bi_end_io =3D bioc->end_io;
> -	bio_endio(bio);
>
> +	/*
> +	 * Only send an error to the higher layers if it is beyond the toleran=
ce
> +	 * threshold.
> +	 */
> +	if (atomic_read(&bioc->error) > bioc->max_errors)
> +		bio->bi_status =3D BLK_STS_IOERR;
> +	else
> +		bio->bi_status =3D BLK_STS_OK;
> +	bio_endio(bio);
>   	btrfs_put_bioc(bioc);
>   }
>
>   static void btrfs_end_bio(struct bio *bio)
>   {
>   	struct btrfs_io_context *bioc =3D bio->bi_private;
> -	int is_orig_bio =3D 0;
>
>   	if (bio->bi_status) {
>   		atomic_inc(&bioc->error);
> @@ -6692,35 +6702,12 @@ static void btrfs_end_bio(struct bio *bio)
>   		}
>   	}
>
> -	if (bio =3D=3D bioc->orig_bio)
> -		is_orig_bio =3D 1;
> +	if (bio !=3D bioc->orig_bio)
> +		bio_put(bio);
>
>   	btrfs_bio_counter_dec(bioc->fs_info);
> -
> -	if (atomic_dec_and_test(&bioc->stripes_pending)) {
> -		if (!is_orig_bio) {
> -			bio_put(bio);
> -			bio =3D bioc->orig_bio;
> -		}
> -
> -		btrfs_bio(bio)->mirror_num =3D bioc->mirror_num;
> -		/* only send an error to the higher layers if it is
> -		 * beyond the tolerance of the btrfs bio
> -		 */
> -		if (atomic_read(&bioc->error) > bioc->max_errors) {
> -			bio->bi_status =3D BLK_STS_IOERR;
> -		} else {
> -			/*
> -			 * this bio is actually up to date, we didn't
> -			 * go over the max number of errors
> -			 */
> -			bio->bi_status =3D BLK_STS_OK;
> -		}
> -
> -		btrfs_end_bioc(bioc, bio);
> -	} else if (!is_orig_bio) {
> -		bio_put(bio);
> -	}
> +	if (atomic_dec_and_test(&bioc->stripes_pending))
> +		btrfs_end_bioc(bioc);
>   }
>
>   static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bi=
o *bio,
> @@ -6758,23 +6745,6 @@ static void submit_stripe_bio(struct btrfs_io_con=
text *bioc, struct bio *bio,
>   	submit_bio(bio);
>   }
>
> -static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, =
u64 logical)
> -{
> -	atomic_inc(&bioc->error);
> -	if (atomic_dec_and_test(&bioc->stripes_pending)) {
> -		/* Should be the original bio. */
> -		WARN_ON(bio !=3D bioc->orig_bio);
> -
> -		btrfs_bio(bio)->mirror_num =3D bioc->mirror_num;
> -		bio->bi_iter.bi_sector =3D logical >> 9;
> -		if (atomic_read(&bioc->error) > bioc->max_errors)
> -			bio->bi_status =3D BLK_STS_IOERR;
> -		else
> -			bio->bi_status =3D BLK_STS_OK;
> -		btrfs_end_bioc(bioc, bio);
> -	}
> -}
> -
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *=
bio,
>   			   int mirror_num)
>   {
> @@ -6833,7 +6803,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   						   &dev->dev_state) ||
>   		    (btrfs_op(first_bio) =3D=3D BTRFS_MAP_WRITE &&
>   		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -			bioc_error(bioc, first_bio, logical);
> +			atomic_inc(&bioc->error);
> +			if (atomic_dec_and_test(&bioc->stripes_pending))
> +				btrfs_end_bioc(bioc);
>   			continue;
>   		}
>
