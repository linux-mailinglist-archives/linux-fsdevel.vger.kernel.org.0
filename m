Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B714E49FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiCWANx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWANw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:13:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0356D1B9;
        Tue, 22 Mar 2022 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647994337;
        bh=ZiNmQTc7CZHmIy+Wn+zB9VS+Bv405CkFmfWWnck8MKE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QYQ7tE16hzC0icWHsu4exHLdXIAtlFJ6dmN+SOo0EFOlWnWAWUaBqUXZrx+7hvD/q
         lrgsVSrgeKCYipes/LknoCAXEsa9FMuQFPx0eQYu1btt/RIyfPUxnJTRyRn5o0k1hz
         PGzvv37OxbHYLmP33Y/zhzD7UIzhKqSCdHhyrLCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1nSQtc00bQ-004Rj4; Wed, 23
 Mar 2022 01:12:16 +0100
Message-ID: <d1c8f520-db6d-8a8f-5717-e1845de9dd25@gmx.com>
Date:   Wed, 23 Mar 2022 08:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/40] btrfs: simplify scrub_repair_page_from_good_copy
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A+/UdUPTOuk10arqCk2tDdJrwWaFukFXfRjU0/Ya3LAZw5jpE4U
 qtALWx2q4iSsV2keTgmbK0SG6iw0RB7xTHa+pKzsgRYJsG1HA1tsJqxhq1GTOqv45ICfZAC
 z8OJEO+64qmpr1QW7QlIO5iZlmeFt72wbJt1kdjFDw+CDP0MeRB3eh9wMFc3JOVKWmCK03b
 odZRY37K8+IKUH9YOmhoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+9RWJzXTL2k=:dFr5V/Tpkwrkpj6JGlQ44e
 cMVzSx/QbTdfwpZr5dxw8uzuNT6ZFGOXLIpQdX3JEWy9D4aTvh0usiqmOhM27N9IjlAGiFWXN
 rcndiRhxjxxr/UNDy4PNHcq1U19ZBiDxCQTvDlNb/crOpe58Z5M+RWUcO3nOBUg2xJuBCVTgr
 9m9bhJqSuPtCn9XKQLIqaHNIvsFutE8TILU55BPWMc1El3ek2DF0QeBaL+MAXJWb1PqK1R7bQ
 YhfQQAxiRM8Jk1zxgWJk/Zymw5AFN5CcFpE7CoaSVTQuMU374A4ogA3x/a7Bvwgo6HurYjNZa
 rnASzFau8zbtJSvBbrBt1nLDkB00UznrUvAlNNuSv/bBcUmZvNG91GLgdrhavXY3gpwTEvmpb
 y0JdsI4GA+NuUbtYnZuoK3jj+ds4okJlFq4bPYDGD47cE9RQQUIu1Nd2v5wG+aNqdCZBXAXYG
 ZCY+Va3G1Hn+eNpqv9oE586TTcVVqnz4y8IE11634e3TM3SYcHp4IDbt0lwOCnjtChhhV0WPm
 UhwujiB7OEfwSxkJodb/roO732utjMlBT1knVhqvAZgJQ6M16+a4s/BwGWW54BcOh5PMAMAEq
 dNgT/1skDzPV3nMGbD9WI06fW7QO1LAQfAG8ZunWEyQ+2kWp1tlvQC4gUi5tk7+CkWuLtbQOr
 TLXSkyvPLFsDmDhpsKAT4IkSCSWq2ed2ToWrKoLhzFy7VxbUvtqeVHV6+gpZLJ9TW1nTXv3RH
 atJrfww0qYFQ3TlkJX//4WzuK6IcxQwK/YZbDpCxPuvLwKkP3lBytUQFgrM41pwZEKHcVjAMU
 igamed+nCMORGA0V53aXZm83ZXDdRhQJr2FvvWIC5PgIGFlh0/SXUKq89/nmbmFUTcitX01Oz
 /eW/GlV8HGKM4HXGr1TVBnzbQfMARaKVrmYaA0Ir8FfT2aBv67OHx0FUsWUbLlSlXtA9a0WSW
 h1p5geryrnrWTOdBylxEWrmp3sVo6/KMKongPHcxPD/ed5Cpf4t8VgcknZ/FS1+V88nc7EWfR
 5EHi1SH8VKA3Go6053cQJW7+YNIEcDQPz4q5fAojJwZSi/pSDr0sW9u3b5AVZGrnJPGjlUPG3
 JLz9SeuBdsoiN0=
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
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 508c91e26b6e9..bb9382c02714f 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1544,7 +1544,8 @@ static int scrub_repair_page_from_good_copy(struct=
 scrub_block *sblock_bad,
>   	BUG_ON(spage_good->page =3D=3D NULL);
>   	if (force_write || sblock_bad->header_error ||
>   	    sblock_bad->checksum_error || spage_bad->io_error) {
> -		struct bio *bio;
> +		struct bio bio;
> +		struct bio_vec bvec;
>   		int ret;
>
>   		if (!spage_bad->dev->bdev) {
> @@ -1553,26 +1554,20 @@ static int scrub_repair_page_from_good_copy(stru=
ct scrub_block *sblock_bad,
>   			return -EIO;
>   		}
>
> -		bio =3D btrfs_bio_alloc(1);
> -		bio_set_dev(bio, spage_bad->dev->bdev);
> -		bio->bi_iter.bi_sector =3D spage_bad->physical >> 9;
> -		bio->bi_opf =3D REQ_OP_WRITE;
> +		bio_init(&bio, spage_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
> +		bio.bi_iter.bi_sector =3D spage_bad->physical >> 9;
> +		__bio_add_page(&bio, spage_good->page, sectorsize, 0);
>
> -		ret =3D bio_add_page(bio, spage_good->page, sectorsize, 0);
> -		if (ret !=3D sectorsize) {
> -			bio_put(bio);
> -			return -EIO;
> -		}
> +		btrfsic_check_bio(&bio);
> +		ret =3D submit_bio_wait(&bio);
> +		bio_uninit(&bio);
>
> -		btrfsic_check_bio(bio);
> -		if (submit_bio_wait(bio)) {
> +		if (ret) {
>   			btrfs_dev_stat_inc_and_print(spage_bad->dev,
>   				BTRFS_DEV_STAT_WRITE_ERRS);
>   			atomic64_inc(&fs_info->dev_replace.num_write_errors);
> -			bio_put(bio);
>   			return -EIO;
>   		}
> -		bio_put(bio);
>   	}
>
>   	return 0;
