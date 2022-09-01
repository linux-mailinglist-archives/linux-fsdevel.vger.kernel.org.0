Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F35A926D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiIAIzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiIAIzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:55:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120818E11;
        Thu,  1 Sep 2022 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662022480;
        bh=GV/S2fa4BRD9sgfDYFGhgBDWCnIN/LI3VF1N618OQbk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ll2pNi/18AlK3/05pm7AP5+KwYb5rBY7U0zAWtORHV1eyPWDiB7fkNJIAeZxxA4nx
         Puv+9cbPn7cML/qTpbJexC8sdPbsER+dg4YmVxLn/7iwBWRRmd6Y8VnCpkH8CAPuMK
         v5VYLKwpVd1RNq4XKN0GQiYzMH3JzEAVuqroprDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKHc-1pJRB52Bum-00yheR; Thu, 01
 Sep 2022 10:54:40 +0200
Message-ID: <de16bd58-3f14-01d9-9de5-6a79792c62c7@gmx.com>
Date:   Thu, 1 Sep 2022 16:54:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/17] block: export bio_split_rw
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
 <20220901074216.1849941-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220901074216.1849941-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mmM5D6IZ1oaD0qr6/5AZUuLakSmec4LkeDGuyL6NG6UsGRxIShO
 Ol0y89iD+KBDwpfXMslDF2cXH3+0E+O/2N9byrJSY5eMxnLfODCO6ZqqoFAz0yQ0HBYWzzA
 WkCO6XXt73F8mc+bv9K6VS54DzpwmsQxutK3VvCdFw5qHGpF39Um15krwrJzCoQnoyab98Z
 893bUcKMwft9eUfxb5WqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y336Ou2v+Do=:pPFJqieV7LQPq5oYQffwfb
 mCJyCPk/V6kLOQFqynGbuXg+YAsEq2pYyM+a4J3qvLKMCCWqfCuv0oHBfpVKTZe+FrSMitvY5
 VE5V4bcFL7n0/7qWwQJvHNilua4fMIjypUrkEL7ZnNz8o8oVQUibHcivaEcaj8qSFv+9g9H30
 HjEsYWcyxM5CeqPkp8fbE218sVKawmW992ePu6mRFtDOTB+w66QfrRpU6f7Ya0yoIYO6kGUzN
 joXpv/rxQPW39RUmVk4Nq7DDina/OKL7xGYLB4ZXgiaIQHAQJ4DP+JQ0+KmVQ9yxQaYYVfZJ7
 j9pGSkIVyrPfLM90S09TZDcdsMsBp4qBDYAR4I/fnA5XHuSjdBmyHqIsyiWuPKqhsyMYcBBu4
 2U4rkI1COm7PR5YxH+N0JW59xjlz7no2NkcqlBgY+CFOLGFZsH262FSSAoVsUujIME8ECA37R
 N/I0m05BzDxR/rW+CjE7jpiKYfbWF32LuIosG9hP23HxW3z60nfKBFE5pdXzrEYDReCedHVbC
 LMILp2irVwAwceMHrNV0VNpSBPVWo+reYkjb2ZSbrRAvU+ZcG6xuePLiXcIHEpJRL+tMjWuxD
 Trpa/y53ywfSIcH6MCkND0reqQfZhjUYQ/JWoiYJSii8PvOvwSD3+zzFI/7HM56uv5xAcpUGB
 /vi0Fr68WAq1TXqVCFJ57pkSU95kOdxqAlS1Jw0T5gv2GG4+2ZzLuLP9oQbJUSEjL5I+0nTlb
 T9lRPFfkXJ5GYTWm8nEZO0/M4sWb2qSUyDymBK2/Hst3eI7TbLPGAQ9Ve0jBX4b1pWZd3OzWn
 PKmx6QedHW7/EGLKtZHvG5p2V2ZdpwkRWETyGyfThhS5GXvSsqhtIvK+0+pMdSuqANgfOgcXs
 fXtcwjUBrZZAVOiKQuNoBa1cCGrzRd9JY1CAq73kPtf+y6uzlOmWW3+G3dgYkkoqpJmqygs3x
 sUn27DgTVJvKEKd/Lh+sw3UGDXSKs7UBc6pe7xQALpIB5Eg15efbE0OimPpaewtBAzqEvUmyU
 pSpqvz9Mkw72X6qRQUwgOxsxgFuQ85G5H9Fvawhvb6heFsH6Vfot0V5fQqvs604JAAgCbD4hm
 fhcG3UtEotilieWUA9FgMgUFiZgSXV5kfzNSgk26rof6XZCZhV688JBYw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/1 15:42, Christoph Hellwig wrote:
> bio_split_rw can be used by file systems to split and incoming write
> bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
> bios.  Export it for initial use in btrfs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c   | 3 ++-
>   include/linux/bio.h | 4 ++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index ff04e9290715a..e68295462977b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -267,7 +267,7 @@ static bool bvec_split_segs(struct queue_limits *lim=
, const struct bio_vec *bv,
>    * responsible for ensuring that @bs is only destroyed after processin=
g of the
>    * split bio has finished.
>    */
> -static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *l=
im,
> +struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,

I found the queue_limits structure pretty scary, while we only have very
limited members used in this case:

- lim->virt_boundary_mask
   Used in bvec_gap_to_prev()

- lim->max_segments

- lim->seg_boundary_mask
- lim->max_segment_size
   Used in bvec_split_segs()

- lim->logical_block_size

Not familiar with block layer, thus I'm wondering do btrfs really need a
full queue_limits structure to call bio_split_rw().

Or can we have a simplified wrapper?

IIRC inside btrfs we only need two cases for bio split:

- Split for stripe boundary

- Split for OE/zoned boundary

Thanks,
Qu

>   		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
>   {
>   	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
> @@ -317,6 +317,7 @@ static struct bio *bio_split_rw(struct bio *bio, str=
uct queue_limits *lim,
>   	bio_clear_polled(bio);
>   	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
>   }
> +EXPORT_SYMBOL_GPL(bio_split_rw);
>
>   /**
>    * __bio_split_to_limits - split a bio to fit the queue limits
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ca22b06700a94..46890f8235401 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -12,6 +12,8 @@
>
>   #define BIO_MAX_VECS		256U
>
> +struct queue_limits;
> +
>   static inline unsigned int bio_max_segs(unsigned int nr_segs)
>   {
>   	return min(nr_segs, BIO_MAX_VECS);
> @@ -375,6 +377,8 @@ static inline void bip_set_seed(struct bio_integrity=
_payload *bip,
>   void bio_trim(struct bio *bio, sector_t offset, sector_t size);
>   extern struct bio *bio_split(struct bio *bio, int sectors,
>   			     gfp_t gfp, struct bio_set *bs);
> +struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
> +		unsigned *segs, struct bio_set *bs, unsigned max_bytes);
>
>   /**
>    * bio_next_split - get next @sectors from a bio, splitting if necessa=
ry
