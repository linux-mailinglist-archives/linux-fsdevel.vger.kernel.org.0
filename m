Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EA4E4A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiCWATq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWATp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:19:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CC5EDCC;
        Tue, 22 Mar 2022 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647994689;
        bh=b8ijpSxqrnvW06L1nxOIkc37LaKHaIXWvHDGf0n0NS0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H5l2oH0LfdccKw6F+e9AUE41Gz6YVJEzb37HFpZmugddQaMffZEELu/Wwp1vWchty
         YMlk21AF9i22SVg2JCv+tmA0prHIPrJWvXKEJClZa4RvTYs8LBHb8IcArdwFIfLJ3l
         CKa/jlk60c/l5MyO02Ut40TNyjjfHxddv9NWfDFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1o7isk46CQ-016zZJ; Wed, 23
 Mar 2022 01:18:09 +0100
Message-ID: <120ba8d5-10a5-8893-0d36-22e1f805e742@gmx.com>
Date:   Wed, 23 Mar 2022 08:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 15/40] btrfs: don't allocate a btrfs_bio for scrub bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-16-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:La+m8g5VadFm6uOxqQ7OIuvdLju7ZbVwqX/mGa3xoF+rw/0p1NM
 jj4NmPtijld3xNpf2p/GeGkg6QUEUSITPTLaKe2xiZzz9rSwZJHkm1XcFCqzrL+fH2bg86n
 rnuduwEBO62oi/DxoDZA8g1lMsYzFDh5EDRcZiAlzlR1Op3XP5QeAqNqCK82CDVIwbsAmgM
 4SkdqxP4sIrgpxmxTPfCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UhSd3wkU3pg=:aZdaXveYZzVGs5MirKIcUn
 31fODnoEZ0D1duaRRnFa7krhhyBUOeG6PwfzubgLB4j3N/DuUU2LYPRiGPI2gbOsaw9hCKjOS
 YasK8d2p+55ThcZyAAQh1yP9hpMBkqfBi7XiwLt0UYjKq9XCDanHSPBcsF6LyRamhpTsFl8pB
 LvsH75oHsykYoPfjp3KPZMdjwe11FoptVfdCCkTGTmDrPsvSIJPAb1EjFpMTx3PKyb0+P/b6/
 SUJ6i8fY2I3/CiK3FopYUcfYpKCqgwQlz/BBixGc+SPN8uDIhICpVKIMV27uoJnePS7hA/Iq1
 BuuERJieGLIjNC8KfxIt4uXxTkmWzHVSJbRyXQIQ12YoqvzrnmePYFqbqjEnz/QsxIIjlqmu9
 CxJ78TbNf2fKDeou3ywOSh9R/BaGG/muFG9elQjNvyJeZEVtTTEYA4ezBZ3BB7r2TbNM0krPz
 tAGTJayQFR+7XAb9DxaGTkhQFBLsQ6Gh0CJ5oSVpTYW7aocID4rJDwj9e62Tmoa1Edx3JPMDN
 qRCgoXirW5Dm6BBmUdDIIo6xEYHrjbGkJ+kIi2jAeXvrc/kLLe96Seq9mDWO3+7zLOM9HuyMY
 +uuOzvZOzmaa7yH1w9wSyP/j1ZWONVIy0tWyqwjTnLLZaEglJ3RUHn8hzriNkk50ewCeZQs3g
 12fewfaIFIxgGTBluAkPLFLz5WPUimUphN5bPNONNrqg7oPK1deZT1T7XG7IPHAr2T4G9gJhW
 WihH8KdJhxrq3xNJY5Z7QbXqXw7LYJXcxZ0S0UVOWZlpCFfM5fTojPKY9+XQf496c0/d/z/Xp
 BKvtQZQX491yLhmD7jy/94ny7K24pNCL+k3n1WAwVuVDUZvOA5fk1q66FT83eHOmygYfNwd5J
 AQ/aJ4/FH267lfS+sRKiYxV6JphR2XAmdhoBmtQTEyB0Nv+Df5u/Ust7kbsrqYx2aHWt5ca2w
 hiaF1HsKe3DUp6vR3nioPyZbOdXJrUveEmuffQFIH96yUtiAoTOy1m71m/rX8azjclpefnl1H
 nbCgOSUcFidqYfGwalZOt/oWg9009SgdQiRylGjMctNK8uGKL7/dYUgNtkdBAigyWLl6E0d2x
 wgOQsiNVyCfDQs=
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
> All the scrub bios go straight to the block device or the raid56 code,
> none of which looks at the btrfs_bio.

Exactly!

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/scrub.c | 47 ++++++++++++++++++-----------------------------
>   1 file changed, 18 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index bb9382c02714f..250d271b02341 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1415,8 +1415,8 @@ static void scrub_recheck_block_on_raid56(struct b=
trfs_fs_info *fs_info,
>   	if (!first_page->dev->bdev)
>   		goto out;
>
> -	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
> -	bio_set_dev(bio, first_page->dev->bdev);
> +	bio =3D bio_alloc(first_page->dev->bdev, BIO_MAX_VECS, REQ_OP_READ,
> +			GFP_NOFS);
>
>   	for (page_num =3D 0; page_num < sblock->page_count; page_num++) {
>   		struct scrub_page *spage =3D sblock->pagev[page_num];
> @@ -1649,8 +1649,6 @@ static int scrub_add_page_to_wr_bio(struct scrub_c=
tx *sctx,
>   	}
>   	sbio =3D sctx->wr_curr_bio;
>   	if (sbio->page_count =3D=3D 0) {
> -		struct bio *bio;
> -
>   		ret =3D fill_writer_pointer_gap(sctx,
>   					      spage->physical_for_dev_replace);
>   		if (ret) {
> @@ -1661,17 +1659,14 @@ static int scrub_add_page_to_wr_bio(struct scrub=
_ctx *sctx,
>   		sbio->physical =3D spage->physical_for_dev_replace;
>   		sbio->logical =3D spage->logical;
>   		sbio->dev =3D sctx->wr_tgtdev;
> -		bio =3D sbio->bio;
> -		if (!bio) {
> -			bio =3D btrfs_bio_alloc(sctx->pages_per_bio);
> -			sbio->bio =3D bio;
> +		if (!sbio->bio) {
> +			sbio->bio =3D bio_alloc(sbio->dev->bdev,
> +					      sctx->pages_per_bio,
> +					      REQ_OP_WRITE, GFP_NOFS);
>   		}
> -
> -		bio->bi_private =3D sbio;
> -		bio->bi_end_io =3D scrub_wr_bio_end_io;
> -		bio_set_dev(bio, sbio->dev->bdev);
> -		bio->bi_iter.bi_sector =3D sbio->physical >> 9;
> -		bio->bi_opf =3D REQ_OP_WRITE;
> +		sbio->bio->bi_private =3D sbio;
> +		sbio->bio->bi_end_io =3D scrub_wr_bio_end_io;
> +		sbio->bio->bi_iter.bi_sector =3D sbio->physical >> 9;
>   		sbio->status =3D 0;
>   	} else if (sbio->physical + sbio->page_count * sectorsize !=3D
>   		   spage->physical_for_dev_replace ||
> @@ -1712,7 +1707,6 @@ static void scrub_wr_submit(struct scrub_ctx *sctx=
)
>
>   	sbio =3D sctx->wr_curr_bio;
>   	sctx->wr_curr_bio =3D NULL;
> -	WARN_ON(!sbio->bio->bi_bdev);
>   	scrub_pending_bio_inc(sctx);
>   	/* process all writes in a single worker thread. Then the block layer
>   	 * orders the requests before sending them to the driver which
> @@ -2084,22 +2078,17 @@ static int scrub_add_page_to_rd_bio(struct scrub=
_ctx *sctx,
>   	}
>   	sbio =3D sctx->bios[sctx->curr];
>   	if (sbio->page_count =3D=3D 0) {
> -		struct bio *bio;
> -
>   		sbio->physical =3D spage->physical;
>   		sbio->logical =3D spage->logical;
>   		sbio->dev =3D spage->dev;
> -		bio =3D sbio->bio;
> -		if (!bio) {
> -			bio =3D btrfs_bio_alloc(sctx->pages_per_bio);
> -			sbio->bio =3D bio;
> +		if (!sbio->bio) {
> +			sbio->bio =3D bio_alloc(sbio->dev->bdev,
> +					      sctx->pages_per_bio,
> +					      REQ_OP_READ, GFP_NOFS);
>   		}
> -
> -		bio->bi_private =3D sbio;
> -		bio->bi_end_io =3D scrub_bio_end_io;
> -		bio_set_dev(bio, sbio->dev->bdev);
> -		bio->bi_iter.bi_sector =3D sbio->physical >> 9;
> -		bio->bi_opf =3D REQ_OP_READ;
> +		sbio->bio->bi_private =3D sbio;
> +		sbio->bio->bi_end_io =3D scrub_bio_end_io;
> +		sbio->bio->bi_iter.bi_sector =3D sbio->physical >> 9;
>   		sbio->status =3D 0;
>   	} else if (sbio->physical + sbio->page_count * sectorsize !=3D
>   		   spage->physical ||
> @@ -2215,7 +2204,7 @@ static void scrub_missing_raid56_pages(struct scru=
b_block *sblock)
>   		goto bioc_out;
>   	}
>
> -	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
> +	bio =3D bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
>   	bio->bi_iter.bi_sector =3D logical >> 9;
>   	bio->bi_private =3D sblock;
>   	bio->bi_end_io =3D scrub_missing_raid56_end_io;
> @@ -2831,7 +2820,7 @@ static void scrub_parity_check_and_repair(struct s=
crub_parity *sparity)
>   	if (ret || !bioc || !bioc->raid_map)
>   		goto bioc_out;
>
> -	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
> +	bio =3D bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
>   	bio->bi_iter.bi_sector =3D sparity->logic_start >> 9;
>   	bio->bi_private =3D sparity;
>   	bio->bi_end_io =3D scrub_parity_bio_endio;
