Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDF4E4A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbiCWAgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiCWAgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:36:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FD506FE;
        Tue, 22 Mar 2022 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647995696;
        bh=fb36oWCaCw2TjxfDorPgSTWQqKmnuSFZU2xsBDlL6NY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Rl/km/c6TE5htDEz4HTTcwgDhwY3mWARm9zTfetbn9a2DSyeKCJtAJL+n8ekqldBs
         PEeNLQ6007C+2phiWjzKRuNmbzGiHMsDoiKrYFp/wQhmdzFyd0Uanv2I/P9jxMvOi/
         yfqbjHMBZ4fdGOYCxqTJ0dZgCF11faCoyM8OVDlo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsIv-1oOVsO3y7z-00szGm; Wed, 23
 Mar 2022 01:34:56 +0100
Message-ID: <aadb202d-0a45-ac49-4f5c-3b7a89f93c02@gmx.com>
Date:   Wed, 23 Mar 2022 08:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 20/40] btrfs: cleanup btrfs_submit_metadata_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-21-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-21-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZP7kLU7Sgtnc3nvdxeyf+uLd2vGWRPWZsknPq0ZkHoAifeWMj1X
 aqwZ+pmwb1ELjvPdpUYfQKN4z2w+JhSSp9ugLxZSdoYmNSHIbdMpm1+8VbQvyzrYC4vuCj2
 fooxG/b0z64i0BFlRMtQvXdnx4zMt7lVY+LsOlxEmKXD4EeelLLpwo9PNgN9Mz5nS8uHHkA
 XQSwEU9x2IRZLgaDAXASQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dbPIb5jW+W4=:5n0zpG8l8E8mAtGqMNt/0V
 W0Pe5XQ8SICZ80vlr11lgj60dpJBrQrzdm9EXnJAnjF8U5zsgxdGKZDZJKkVwmdaR+JI4V90n
 AjC/olerRjz2Gq1jcWRJQLez/dXESjGtg7KtU4pE/wh1aVHyKxa0hYE2K03yoLmVTMaQRS8t0
 BzpWrp4dqWDW3bXhpx0vDzgFtMZZn0a8/h4KD69yDeXXWepk5yqbfD/ancKqzXAICcvzx6Dwo
 Qhb7h+3iVuDkhEw+P2yEjAUdS1WrjpjhLslaCF9iqm+SyKRZzfLZJLcmprYTYPJt8PXnGXAAl
 SdNqqSygNo6Ok/itYUsyJi+Wm3emtOoN+KiMFJDSx4YGde/h7xb/HuPB1/Wc9RhYeOZBu02gs
 R6Babfpx1pBkHccABXv6z6POUb0QX9NJtP8nh0nleJJz+//S5gfqgLa2ju7z05J3Oyp6Z6pR4
 LWI3gokQ6D2T1GD00GsoOkS/Yxm+hI7B6w1b8yi6l/q5hG9pL+2UuRg22yZWQqLf50nR13QZP
 lgJI44o44H8l+nVKjU1pottjtHV8rcmAXuTbfbICBcoehzdwSI0+b2knChudxvGewk8qRvu/K
 O0uQIz6LOspmi6IR5S5dXZxmxydwlfXEb0I48dvm7I7jTfhG0c7TIUmohRKDcmec9+2iu6cPu
 GNy58sqnRngBEvRAvmq0LY2ziuuP1bcUdS4JNRtKbPl0zwpCOneV+vGHocuBsIfR/hXtEiS7A
 qowsOCTwmjBwMy13nI22gtC/n3WSjhssWwNaDXT1pIye/5nbCCKeyeCpjO9zlNA/7An/ps6gq
 zzdsD163QwpebINP22ZVv3n2wI0xv9ZpkCq6aKhosWfkcJvqNaDXbNPNsQJaJa3S0f4G0YmC9
 6OqvCzK11m+FQyuyRdBU8+AQqxkAZNrLVLCBJKMduYaEv0zcmFhyqBKZUY8JmKrYz63vI/+pM
 8U0jMXv0CEScNmYzc4qN3P8VGpUYvOc5tePp/DI5DjG3TAKWtL3c0PGw/x3fe0DRxxAoQAW8y
 Lb7vtY/i3hGywR/XEbZFxcvwsrEvep+eetIVmBuYp8crYJKlk7Z03cQByIN9qyC/mEO5C4KDX
 0+ezjRmtyO0mqQ=
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
> Remove the unused bio_flags argument and clean up the code flow to be
> straight forward.

That flag is a legacy when we use a function pointer for both data and
metadata bio submission.

After commit 953651eb308f ("btrfs: factor out helper adding a page to
bio") and commit 1b36294a6cd5 ("btrfs: call submit_bio_hook directly for
metadata pages") we get rid of the hook, and no longer needs the extra
@bio_flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/disk-io.c   | 42 ++++++++++++++++--------------------------
>   fs/btrfs/disk-io.h   |  2 +-
>   fs/btrfs/extent_io.c |  2 +-
>   3 files changed, 18 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index dc497e17dcd06..f43c9ab86e617 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -890,6 +890,10 @@ static blk_status_t btree_submit_bio_start(struct i=
node *inode, struct bio *bio,
>   	return btree_csum_one_bio(bio);
>   }
>
> +/*
> + * Check if metadata writes should be submitted by async threads so tha=
t
> + * checksumming can happen in parallel across all CPUs.
> + */
>   static bool should_async_write(struct btrfs_fs_info *fs_info,
>   			     struct btrfs_inode *bi)
>   {
> @@ -903,41 +907,27 @@ static bool should_async_write(struct btrfs_fs_inf=
o *fs_info,
>   }
>
>   blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio=
 *bio,
> -				       int mirror_num, unsigned long bio_flags)
> +				       int mirror_num)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	blk_status_t ret;
>
> -	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
> -		/*
> -		 * called for a read, do the setup so that checksum validation
> -		 * can happen in the async kernel threads
> -		 */
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> -					  BTRFS_WQ_ENDIO_METADATA);
> -		if (ret)
> -			goto out_w_error;
> -		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> +		if (should_async_write(fs_info, BTRFS_I(inode)))
> +			return btrfs_wq_submit_bio(inode, bio, mirror_num, 0, 0,
> +						   btree_submit_bio_start);
>   		ret =3D btree_csum_one_bio(bio);
>   		if (ret)
> -			goto out_w_error;
> -		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +			return ret;
>   	} else {
> -		/*
> -		 * kthread helpers are used to submit writes so that
> -		 * checksumming can happen in parallel across all CPUs
> -		 */
> -		ret =3D btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> -					  0, btree_submit_bio_start);
> +		/* checksum validation should happen in async threads: */
> +		ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> +					  BTRFS_WQ_ENDIO_METADATA);
> +		if (ret)
> +			return ret;
>   	}
>
> -	if (ret)
> -		goto out_w_error;
> -	return 0;
> -
> -out_w_error:
> -	return ret;
> +	return btrfs_map_bio(fs_info, bio, mirror_num);
>   }
>
>   #ifdef CONFIG_MIGRATION
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 2364a30cd9e32..afe3bb96616c9 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -87,7 +87,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *b=
bio,
>   				   struct page *page, u64 start, u64 end,
>   				   int mirror);
>   blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio=
 *bio,
> -				       int mirror_num, unsigned long bio_flags);
> +				       int mirror_num);
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_inf=
o);
>   #endif
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 238252f86d5ad..58ef0f4fca361 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -179,7 +179,7 @@ int __must_check submit_one_bio(struct bio *bio, int=
 mirror_num,
>   					    bio_flags);
>   	else
>   		ret =3D btrfs_submit_metadata_bio(tree->private_data, bio,
> -						mirror_num, bio_flags);
> +						mirror_num);
>
>   	if (ret) {
>   		bio->bi_status =3D ret;
