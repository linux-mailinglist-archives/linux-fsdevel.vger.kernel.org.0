Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC24E49F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiCWAMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:12:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A946D1B9;
        Tue, 22 Mar 2022 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647994256;
        bh=2s0S9unTKRQ5tkL2QW7GMq4B2420iVohjikTWul4ZrA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fiVkudl+VOvVv37/gAMnULZ5uDvw8aqrGX+KbNCy0kwkpQ5Xh1k0xPoS2lQ2Y5e+o
         krlgaDYAvqe+Uptc7hWPrKqIGf6IE5r7fXAGO7wVJ+Vv74akNw6/AGBSpvzfdBMxV7
         z9Z5WSfbfx8ceQSXJy4idj5ntF4lmFR/n3ZRlaj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1oOEBd3Hq2-00shZN; Wed, 23
 Mar 2022 01:10:56 +0100
Message-ID: <2e4640cc-4b21-bbcb-9ba3-23267efb582a@gmx.com>
Date:   Wed, 23 Mar 2022 08:10:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 09/40] btrfs: simplify scrub_recheck_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-10-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zVbkGnVpagHKmyPyWKtuYEvUp/PONalSgVFKiVmcBTLO+qsdyCS
 6uUUl2SDhBxloA2L9v0UxhEQQ57h3NtKybKabk77xQYOCwCv/CR+5wmSCBBdUs8k7Tzr4AS
 SGfM0YzQxTNBxJHBaxwRWgR3jRsrI6UHXRm6DZehvIksYFavFCAYmAaO4HszeU28Ug9uwnp
 dic6txvVkT+eO2bEbpmsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:htgLtKPG9Yc=:fcbnmJmYbXSUIYtTfF3mFq
 eyuOAM9zqQ9DCXr5tBC9PRr4yMv/RJ8YJCm89TjZ4VLeI0eS+yr59nMmhNX9yJjjznEqp67AM
 G78pPmph+xDMD0wzEftcboXGROKa+xmlwSRvLLTSoQw/zMvAJaQ629Sfkhy/0nHTkUY5dmZwf
 XLqPZWTUe0qu7bPp5s8HFkSZu97eccYULHm+dB0pXP4lwg8IXDKINai36nYa9WmQnm4FzvZWr
 /1CNUCZUdiQnyBcnDTzSgO1+BrfitymJuZVjAiIa2ZDSK8/rUAJ/S6oUYZ2uLfaGBupZtgxM0
 L/+/IcuMOUbr6QV97NTllChZtcFBI1eqlyXOc2w31GTYXy1ZWHoGclag9XyjDm3KpNSHz9Ft3
 hvyIe+KfJUuplbMLrN9f7M7gsLcayJvvL1rkRJ/ydZot8zXaISx6q/+/z5q4lBzTNCGvkFciC
 wEkuSt/0ng6YsUT0roc54v17TCCYK0HmleIp2ICE5E+S5ab3dYc7PICJ6ZxTMtfCAdY2ii8aQ
 VJp+OaZQR0i5NImjdvmBC8RSBKMwddixVwgsHiNNIsaEPP/6kbL7GSZf4cVQFrcqFpcVHYaZh
 w4uTmWm1C63iBLqafpQFHCtmKo06XV/531yNa8wBbJb2ApA9c9Im+SbeD8FYJKIxFsEoA+yyc
 YOToaNXZUfu4cW0xzomFglR5JveyAr5VWPEY7jTAzP/sI0k20KJt+cYSdeBWqS6GBugpdYX2K
 lOdgKhmR/8Al0YWiuwBcirztPF+qDakBJIHJOMc/Tg1xZ4DyuPeBKvidbp+BeXXob3v+YETa2
 IKsZOyILbMTQvliONT4X5g+lrp7YNkFAx5edpdFzLdCn0v3GN19lbHu6RpfwBJs2p1/+17Ejx
 U4C+Zw9hynzySAgecm5WGLRAmP5Tei5VT0HWz9CI6adujug55NA6MwqkEEGZcZezj+dmxsjxJ
 +kcFPdqZJhrzV6s6tZZH5U0IJDjARjnVANjI3t1mAJ9RUjricEP3npIgjK3Tuwj8ExiBShi0c
 qrKrXeQoKcSiJ/ZWu3KYZ0zEGhrfq3NxK27JI2qGN/MS2Zzb5P+yfbRmwVn+vQXzSwoXTFTMk
 THLPF+w6UvS3fE=
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
> The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
> so just use an on-stack bio.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just an unrelated question below.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/scrub.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 605ecc675ba7c..508c91e26b6e9 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1462,8 +1462,9 @@ static void scrub_recheck_block(struct btrfs_fs_in=
fo *fs_info,
>   		return scrub_recheck_block_on_raid56(fs_info, sblock);
>
>   	for (page_num =3D 0; page_num < sblock->page_count; page_num++) {
> -		struct bio *bio;
>   		struct scrub_page *spage =3D sblock->pagev[page_num];
> +		struct bio bio;
> +		struct bio_vec bvec;
>
>   		if (spage->dev->bdev =3D=3D NULL) {
>   			spage->io_error =3D 1;
> @@ -1472,20 +1473,17 @@ static void scrub_recheck_block(struct btrfs_fs_=
info *fs_info,
>   		}
>
>   		WARN_ON(!spage->page);
> -		bio =3D btrfs_bio_alloc(1);
> -		bio_set_dev(bio, spage->dev->bdev);
> -
> -		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
> -		bio->bi_iter.bi_sector =3D spage->physical >> 9;
> -		bio->bi_opf =3D REQ_OP_READ;
> +		bio_init(&bio, spage->dev->bdev, &bvec, 1, REQ_OP_READ);
> +		__bio_add_page(&bio, spage->page, fs_info->sectorsize, 0);

Can we make the naming for __bio_add_page() better?

With more on-stack bio usage, such __bio_add_page() is really a little
embarrassing.

Thanks,
Qu

> +		bio.bi_iter.bi_sector =3D spage->physical >> 9;
>
> -		btrfsic_check_bio(bio);
> -		if (submit_bio_wait(bio)) {
> +		btrfsic_check_bio(&bio);
> +		if (submit_bio_wait(&bio)) {
>   			spage->io_error =3D 1;
>   			sblock->no_io_error_seen =3D 0;
>   		}
>
> -		bio_put(bio);
> +		bio_uninit(&bio);
>   	}
>
>   	if (sblock->no_io_error_seen)
