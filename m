Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A974E4A4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiCWBK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWBKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:10:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A25BD1E;
        Tue, 22 Mar 2022 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647997729;
        bh=5jSylG4WAOHUcbnHcIADdGP24F+RvxXAG3L40OfIQfM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DAYtMHg8EW6ZX6MQFHpSHvzyVEOA9YxxkczWYkkaWBpDFtRzYU0Grr8xB5c4bkzXH
         GGrGFA6X9y0NH2ThZvtWGoxD876s6IME2rtzC9U9jip7SApH3VMaGQyBPOaup2CWPd
         pUEWmYG0702F+YM74tPCGjN+OW729z5LsRvEvAO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHGCo-1nJZwW3bFI-00DDtE; Wed, 23
 Mar 2022 02:08:49 +0100
Message-ID: <0bcf1be8-cbbe-1978-9d7b-eed52ebacc57@gmx.com>
Date:   Wed, 23 Mar 2022 09:08:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 27/40] btrfs: clean up the raid map handling
 __btrfs_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-28-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-28-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cm2y+9Ie9BW6DwDtOvMW0wMhfqP21CF/yfenOw7d2Imrys22hzG
 1p6wqErT+a2oL8q6kzw+ETgL1BoaXrJHTndnsZmJRwDv5dH/2lv7lUGlW0wF2vNCo1tpIVl
 qXhy9QdrAJ5plkceTuIrZpLe7U+4kovxyhbwuEb1jYXc01heD+uhqGOdUNj0ipYtq/ljzqp
 7P/elC4mU8ZVALKigcClA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o+z2EkBoFfw=:eBX3xrq7Xxsfsu2X5z9tz+
 /Q1ffZrlB+rWbqL3fRLzYyeUEgaE7JTU8cLruHRHiQRnqMxdQKNBjzFi2PifrUL8bpvZBItNf
 a4zVogX7a9KnFx9olX5qonbzk329GFIlJFmY/g0+OXIQ2x3bBhPTnLPyf3A6sEYWFleMK9PY0
 pYCf5KOSKSMA4s+uLFdEjN4tYAVDLTvvOTv7lehSs2wQivKrPVKiXI45ypPs5aMiGdaFMnty7
 Zavj24UV3JKEj4YHpvHVkAp75kkdIOYq49llcDfxbowmGQQwhUvLLHPt3PJ0vzM3Kv0RvZDY2
 xOAy5A/uPyrGeHCS/fE+c6tY5qWjQEAaMpOrB7iALX1akWOztn9PqI2+Tv7NnLIxoCyhcrFjy
 PiZYPyzvDfLWx0ZZTS7Sz6dlY7qANyo1f+oU28KHIjLr+fPc6KZmaQM4RJZKHWo9TcFJ2CaOV
 CR/zkqZj8vkM1QoxniABUPEGPVWBq427bK06ne8FgPkaoFTeqRUFkCpEGySKnL2WsOYWannVD
 M5y9SFGzjNN7GlX8pw081OdrdFoMbjrmHgWQ1Fyy3HLyANmEpEt0sFOfbYYwiJh6kvj4U3wUf
 MNQ/2+soVh6O1iSaZQMpx/iJ6451lyJI4T5B+PHSnDR64jLHNRYQ8ZkrZ7MpV5h9JQfQUFP0E
 X+XFgo/qIXpUjfzF6pV9kaSezKvK6ThSDEKL0l/TGQFgJjc9uxhrQYHxTP8IIEQyJgp9CXsnR
 I5qpKwtlgMtmmLo5vFTUGBIczvu7x9j7ieoL/k8DGGgRN4E2aEzuXhw6HgEpqi/VECigg/rUy
 j2mav8dOSouh5wciztOnp3jZFi+MeCs7MKWdVePQjAcY//NvQm0X6nYB8AN00vaU3tVkN009n
 juVXfkU7OQ9YU3UEJzUQBewSdnsrnNhKJSCWKr/LP2d6lM00Blv1q+jn/fUBxXQYHZdMIMG28
 Fkgwq2Pn8ajOYbCgBzogdA1sZ5n2YNHmXErInqWdgcB0Sa4HtkrZm2G64JXkEkBHT8IyDtxWE
 OUqSPtsOZNXBqsm0b2Ons8zJCfJ5KvJ8fA3Dl30YTqHoGsbyH0Y3aVaQ5oe1IFebnZyu8koXz
 YVa925zR+8xRczwVtuEYzoYVCP5OalwuK3J1dir4njxU2o35zQzfWA78CVJSPNw+/JU0UMdu/
 l/JpdIJk4Riz7xp2gF971bEpAm
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:55, Christoph Hellwig wrote:
> Clear need_raid_map early instead of repeating the same conditional over
> and over.

I had a more comprehensive cleanup, but only for scrub:
https://lore.kernel.org/linux-btrfs/cover.1646984153.git.wqu@suse.com/

All profiles are split into 3 categories:

- Simple mirror
   Single, DUP, RAID1*.

- Simple stripe
   RAID0 and RAID10
   Inside each data stripe, it's just simple mirror then.

- RAID56
   And for mirror_num =3D=3D 0/1 cases, inside one data stripe it's still
   simple mirror.

Maybe we can follow the same ideas here?

Thanks,
Qu


>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 60 ++++++++++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1cf0914b33847..cc9e2565e4b64 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6435,6 +6435,10 @@ static int __btrfs_map_block(struct btrfs_fs_info=
 *fs_info,
>
>   	map =3D em->map_lookup;
>
> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) ||
> +	    (!need_full_stripe(op) && mirror_num <=3D 1))
> +		need_raid_map =3D 0;
> +
>   	*length =3D geom.len;
>   	stripe_len =3D geom.stripe_len;
>   	stripe_nr =3D geom.stripe_nr;
> @@ -6509,37 +6513,32 @@ static int __btrfs_map_block(struct btrfs_fs_inf=
o *fs_info,
>   					      dev_replace_is_ongoing);
>   			mirror_num =3D stripe_index - old_stripe_index + 1;
>   		}
> +	} else if (need_raid_map) {
> +		/* push stripe_nr back to the start of the full stripe */
> +		stripe_nr =3D div64_u64(raid56_full_stripe_start,
> +				      stripe_len * data_stripes);
>
> -	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
> -			/* push stripe_nr back to the start of the full stripe */
> -			stripe_nr =3D div64_u64(raid56_full_stripe_start,
> -					stripe_len * data_stripes);
> -
> -			/* RAID[56] write or recovery. Return all stripes */
> -			num_stripes =3D map->num_stripes;
> -			max_errors =3D nr_parity_stripes(map);
> -
> -			*length =3D map->stripe_len;
> -			stripe_index =3D 0;
> -			stripe_offset =3D 0;
> -		} else {
> -			/*
> -			 * Mirror #0 or #1 means the original data block.
> -			 * Mirror #2 is RAID5 parity block.
> -			 * Mirror #3 is RAID6 Q block.
> -			 */
> -			stripe_nr =3D div_u64_rem(stripe_nr,
> -					data_stripes, &stripe_index);
> -			if (mirror_num > 1)
> -				stripe_index =3D data_stripes + mirror_num - 2;
> +		/* RAID[56] write or recovery. Return all stripes */
> +		num_stripes =3D map->num_stripes;
> +		max_errors =3D nr_parity_stripes(map);
>
> -			/* We distribute the parity blocks across stripes */
> -			div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
> -					&stripe_index);
> -			if (!need_full_stripe(op) && mirror_num <=3D 1)
> -				mirror_num =3D 1;
> -		}
> +		*length =3D map->stripe_len;
> +		stripe_index =3D 0;
> +		stripe_offset =3D 0;
> +	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		/*
> +		 * Mirror #0 or #1 means the original data block.
> +		 * Mirror #2 is RAID5 parity block.
> +		 * Mirror #3 is RAID6 Q block.
> +		 */
> +		stripe_nr =3D div_u64_rem(stripe_nr, data_stripes, &stripe_index);
> +		if (mirror_num > 1)
> +			stripe_index =3D data_stripes + mirror_num - 2;
> +		/* We distribute the parity blocks across stripes */
> +		div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
> +			    &stripe_index);
> +		if (!need_full_stripe(op) && mirror_num <=3D 1)
> +			mirror_num =3D 1;
>   	} else {
>   		/*
>   		 * after this, stripe_nr is the number of stripes on this
> @@ -6581,8 +6580,7 @@ static int __btrfs_map_block(struct btrfs_fs_info =
*fs_info,
>   	}
>
>   	/* Build raid_map */
> -	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> -	    (need_full_stripe(op) || mirror_num > 1)) {
> +	if (need_raid_map) {
>   		u64 tmp;
>   		unsigned rot;
>
