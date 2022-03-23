Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8974E49E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiCWAHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:07:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB025DE5A;
        Tue, 22 Mar 2022 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647993972;
        bh=7Nf1JV0phPvLNTc4msgNf8Y3ObhL0GNy29aVpe+PbBU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QM0aJegFuh6n5BIJ85fFJLN1Kh7HDMAGFmN0A3bZbh7DMfhC+psKmFD/GV8kdtg4j
         lT9PXbToHTZiv7p1dNNSWmkn4sSyWU9ZIFlY7xlUKnMLKQN+lZJMo5rgfWTTQe+KfC
         v4sL9xxpjT75ggZ62vJmNeg/G3/n28EnjEvnx5O4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0FxV-1oK7Xf05qh-00xNY4; Wed, 23
 Mar 2022 01:06:12 +0100
Message-ID: <d988da45-3965-8c03-d615-3bfd37e7ce3a@gmx.com>
Date:   Wed, 23 Mar 2022 08:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/40] btrfs: simplify repair_io_failure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fT4XP7CdgxvH1l7c3o8vCi9ADKEU3VXbAl6+2YW8W3ucKVauWmC
 TN41bDfLPIsD/NxwNhDZroYkXjCSaYNRaVmZRo+TVRUv8G4qFptvCGZGcZMe4/OALxPBpGJ
 I/t4mY8bDgFsMZhsSs4gIZ5DAn3U3PgzL6ViKskvvz/h39FurD9wSClgl7H56WRhkltD8NN
 V6+uWkh/C6OQq1Qo6PYEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P2KOJnq1ZPI=:/DkuyD3dgA08rpHrCL2lmf
 50s8wAqmtKQlZcT/b0ZMknQ/zpjWOJTR9e+hppG0hgSy++3LE7NK2aMz1NYbQs6CycEF0ocl/
 qXg57l/zFqREjtmjQW8kVlEmmgBrwGjEGOia0Al+cGMG0QzymmpTC8DBq1XIrbby6tv4NxADS
 f/F73qOYR7W50lO7LBXY6TJTUIyYh9K8GwLqvPhMBeUYc5NAm8ofFRpngJEtkfW0OLJlhrJhE
 MhUOmK05HRAZWbL3h1OxAjLHy+8AZuKtK1zOL/hCr9qRqO1jN+5rpS01kJGlE+Gp158Pk+Zyv
 ZGbvkOGThrcdf6Qb4Q/6OsNqXFO8/jRZcOvI4J3A5TfhOU4jdzZYvleu4525i44u+kOIv5B/F
 HDSiVlAIWlqmjoqYpKRv9cwsC2e4RKKwGNACfZmk6U0lr4kiT+KT7sN2m3pOZkmVoKK1WEKvc
 UFvCK3PuOQ5OLL+FSB6RWwJKSdOHAYPI3NJ73gAAQEcgPrH5P4pi0rR4/KGQLsONI1Cv/qAiJ
 B0wz/5w5sk57GiD3juOYedtqac2eNwwX7FJTeZe1zlAPTigWTTdkFJKWQhewV9Nn3J5kboUMd
 68VQSdEvA3qs8HmtsS98pLigJ3iGKTO9yYPxrB12pCsL/ArJ7r0RPVEZfWeOdbfE9mcSlf7zu
 lxv+KFn2njGMM3XYo5bb5oCGk1Xb92bRXLc/0LezGgYKmyYLqy9tJx3qLaBD5sagOFQAtDPmb
 nuUFFLSCehVF8mdJ3x0SKsSVXjxwNtQzgI+kvPbRiOvWmDjyHCmE71yyc/E7xtAUEbKr0eHux
 aO/sjA0CXMrU8KZBe/fn3v8XM2EjEILipKnK5QEE4d664rQzpIqH7kaiJbut+AvrvN9+LQUU6
 6E1yJouWafGWsHxJ9m/Ilf4v6vPX3/xgxOBSJ++J0P+AVXAZ+AsiEwRbcFgRtitwSAaX2WKHE
 2DqvgOCXUXFtE7XMIYXDzX0bwVdJPAkW117SgY58+a7dl52jc6ndmlaDn/4gndN8W8IzDLkDg
 qEOpPxB9GVTK5RTdwEh1G5xjL9Nmq1cmkmM5u5vu+9sNWlzmZx07uRwoNkm5parDfyUf6KR8O
 kU8o3Oriz3L160=
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
> The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
> so just use an on-stack bio.  Also cleanup the error handling to use got=
o
> labels and not discard the actual return values.

Didn't even know we can do on-stack bio.

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 52 ++++++++++++++++++++------------------------
>   1 file changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1a39b9ffdd180..be523581c0ac1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2307,12 +2307,13 @@ static int repair_io_failure(struct btrfs_fs_inf=
o *fs_info, u64 ino, u64 start,
>   			     u64 length, u64 logical, struct page *page,
>   			     unsigned int pg_offset, int mirror_num)
>   {
> -	struct bio *bio;
>   	struct btrfs_device *dev;
> +	struct bio_vec bvec;
> +	struct bio bio;
>   	u64 map_length =3D 0;
>   	u64 sector;
>   	struct btrfs_io_context *bioc =3D NULL;
> -	int ret;
> +	int ret =3D 0;
>
>   	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>   	BUG_ON(!mirror_num);
> @@ -2320,8 +2321,6 @@ static int repair_io_failure(struct btrfs_fs_info =
*fs_info, u64 ino, u64 start,
>   	if (btrfs_repair_one_zone(fs_info, logical))
>   		return 0;
>
> -	bio =3D btrfs_bio_alloc(1);
> -	bio->bi_iter.bi_size =3D 0;
>   	map_length =3D length;
>
>   	/*
> @@ -2339,53 +2338,50 @@ static int repair_io_failure(struct btrfs_fs_inf=
o *fs_info, u64 ino, u64 start,
>   		 */
>   		ret =3D btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
>   				      &map_length, &bioc, 0);
> -		if (ret) {
> -			btrfs_bio_counter_dec(fs_info);
> -			bio_put(bio);
> -			return -EIO;
> -		}
> +		if (ret)
> +			goto out_counter_dec;
>   		ASSERT(bioc->mirror_num =3D=3D 1);
>   	} else {
>   		ret =3D btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
>   				      &map_length, &bioc, mirror_num);
> -		if (ret) {
> -			btrfs_bio_counter_dec(fs_info);
> -			bio_put(bio);
> -			return -EIO;
> -		}
> +		if (ret)
> +			goto out_counter_dec;
>   		BUG_ON(mirror_num !=3D bioc->mirror_num);
>   	}
>
>   	sector =3D bioc->stripes[bioc->mirror_num - 1].physical >> 9;
> -	bio->bi_iter.bi_sector =3D sector;
>   	dev =3D bioc->stripes[bioc->mirror_num - 1].dev;
>   	btrfs_put_bioc(bioc);
> +
>   	if (!dev || !dev->bdev ||
>   	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
> -		btrfs_bio_counter_dec(fs_info);
> -		bio_put(bio);
> -		return -EIO;
> +		ret =3D -EIO;
> +		goto out_counter_dec;
>   	}
> -	bio_set_dev(bio, dev->bdev);
> -	bio->bi_opf =3D REQ_OP_WRITE | REQ_SYNC;
> -	bio_add_page(bio, page, length, pg_offset);
>
> -	btrfsic_check_bio(bio);
> -	if (submit_bio_wait(bio)) {
> +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
> +	bio.bi_iter.bi_sector =3D sector;
> +	__bio_add_page(&bio, page, length, pg_offset);
> +
> +	btrfsic_check_bio(&bio);
> +	ret =3D submit_bio_wait(&bio);
> +	if (ret) {
>   		/* try to remap that extent elsewhere? */
> -		btrfs_bio_counter_dec(fs_info);
> -		bio_put(bio);
>   		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
> -		return -EIO;
> +		goto out_bio_uninit;
>   	}
>
>   	btrfs_info_rl_in_rcu(fs_info,
>   		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
>   				  ino, start,
>   				  rcu_str_deref(dev->name), sector);
> +	ret =3D 0;
> +
> +out_bio_uninit:
> +	bio_uninit(&bio);
> +out_counter_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	bio_put(bio);
> -	return 0;
> +	return ret;
>   }
>
>   int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mir=
ror_num)
