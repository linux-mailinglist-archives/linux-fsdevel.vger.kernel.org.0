Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6F4E4A2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiCWAqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCWAqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:46:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCB37A23;
        Tue, 22 Mar 2022 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647996264;
        bh=NDcFyonfnO1USv89T5Yp4KeiVcJbVT995X5g0Vybnwo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WT1gyhZWUaFkHh4uDdzshgasixhG/RQkCeGPzeDN2m9lYHvLqoVJW7jLo1LUGM1Vw
         U4ShkatjE7RARHckkfWl/caOr90HWIp69kNzgw6jcGGdFtyBMF4DOZVd16mt8AyqQp
         qDtRDnEQkc4xEYMzri1SvZZM4nYq1yd4Q5kbfuQc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1oIl6L2wnS-00w0Fe; Wed, 23
 Mar 2022 01:44:24 +0100
Message-ID: <eba7673d-9364-a60e-9243-811162b76ddd@gmx.com>
Date:   Wed, 23 Mar 2022 08:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-22-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 21/40] btrfs: cleanup btrfs_submit_data_bio
In-Reply-To: <20220322155606.1267165-22-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2bWXRqnNVHQGNQrtRiNrshoFiNrepH7TLXo8fgTP7XSHTL4G2X
 WxLHAkE6lPrLUawQnKzt9UeowZYs9RpdfE4YzxZNqmBoznf1OUR4LitL5M9TmOJta0UeuDO
 uiryvhU+d/6FuwzAI9Ui9Di5hU5vkhtkidfXMkdztUJgaUiNjQ9r1jmUFrpq3wJ2gJQPPjW
 mVzCLp3gWX54xffXCbGpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qdf8R82ilxg=:OgPqIECYk6CjfQL5dTlluG
 JiJ7LhN1gKesCBRa3R2i8aF1aHWpIy7co96C0ZS8JGEnbPka8EIWnJtMr1Buw+yCMau3zQHZs
 9S48oVkHmSh6Rg4h5sbf1IXuZo20TBovQTdeuutY57vR/Obuy/C4S9+DAY2DD1e+qldjbtchp
 mmJusF9Vxl38VXEJoW51wyALRrxyYXA3D9XmYhZljYUH5fLPDcyDp702+sKxQb5+u9YGg+DjA
 PI8qjqukvMdw/k7YcT9agclwP1dJWhhfmMjPxjV8t1wynTUBGe2sZN5VNJJ9Hr7JHct9ig7GT
 lkcv1eCBt1Xw1N085ab81k50UiqR9irI8KeuEuc4teSaHTC+GljIpzg49Z9Nt0n6kCVNUHt6p
 BGloF9JzoFcRkBs6btURZf1+bs3KLLvnMKgi8gquuyvFdtoiLo7RVkk080vw78vSRJ5uEivPL
 FjCaES9B0qeUQF9Kh8/tuEnyLiCcla+6wD7RRSF5oXve+kgca/v6iYvV44S6BU/F/hD2sAQg4
 WxkKuvRBePxjzQAYaA7Nd+NvKpd/P6NnCaTBqyxq8Yd390NvzLCWqjwCCd1TC4I+zT+7VIO0n
 KpMJ55dfUc5ns22Q32G7etO27zTDnNA4ooDmqeovFQXJqmh1BcYjzfXkG2gD4aWUN8izcBUrR
 Z0VcTUE514qvT5c6Hzy511TxZQx32qvDzm4aATtglU8O5l3fL8FcqLDvfsw+xTVSwr7XHVmi0
 d8UXFP0Z5V5gUVO9iI9BwyQvHcAsbUsuE0NuNUC0M7M2Fj5moy0jBPYkpxZNGJcTNJ/Ou30Sd
 UevKrW3bzNrA3OtnrK4u4NZVlRmoAAYpfor0WJb+5k/wTlM+UexzlUzG/ZLAlxkywqLc5meUB
 JoesyzFBNbEsWg8DEop0NoYt6Wz7mPDSC/LA/TozJNPh5TDHeQj8Z6WE66+bOI6t/MEAg8Urz
 kX83fFd+IjZEfHY2G8Vn2zwdrlTo5i7MrWpSFfHRSpAMil8PYZKCHveRPku8NfVU/CCmptBxy
 tmSOsKbVUgXaKyocU3eOo6NN0lOBGrcGkIr4FGTwvRBU/tiqV28+v5KlGQHvp4QgpbzVkuYnp
 rVtzg0dQp6xmnk=
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
> Clean up the code flow to be straight forward.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/inode.c | 85 +++++++++++++++++++++---------------------------
>   1 file changed, 37 insertions(+), 48 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 325e773c6e880..a54b7fd4658d0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2511,67 +2511,56 @@ blk_status_t btrfs_submit_data_bio(struct inode =
*inode, struct bio *bio,
>
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> -	enum btrfs_wq_endio_type metadata =3D BTRFS_WQ_ENDIO_DATA;
> -	blk_status_t ret =3D 0;
> -	int skip_sum;
> -	int async =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> -
> -	skip_sum =3D (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> -		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
> -
> -	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
> -		metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> +	struct btrfs_inode *bi =3D BTRFS_I(inode);
> +	blk_status_t ret;
>
>   	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> -		struct page *page =3D bio_first_bvec_all(bio)->bv_page;
> -		loff_t file_offset =3D page_offset(page);
> -
> -		ret =3D extract_ordered_extent(BTRFS_I(inode), bio, file_offset);
> +		ret =3D extract_ordered_extent(bi, bio,
> +				page_offset(bio_first_bvec_all(bio)->bv_page));
>   		if (ret)
> -			goto out;
> +			return ret;
>   	}
>
> -	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> +		if ((bi->flags & BTRFS_INODE_NODATASUM) ||
> +		    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
> +			goto mapit;
> +
> +		if (!atomic_read(&bi->sync_writers)) {
> +			/* csum items have already been cloned */
> +			if (btrfs_is_data_reloc_root(bi->root))
> +				goto mapit;
> +			return btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
> +						  0, btrfs_submit_bio_start);
> +		}
> +		ret =3D btrfs_csum_one_bio(bi, bio, 0, 0);
> +		if (ret)
> +			return ret;

Previously we would also call bio_endio() on the bio, do we miss the
endio call on it?


> +	} else {
> +		enum btrfs_wq_endio_type metadata =3D BTRFS_WQ_ENDIO_DATA;
> +
> +		if (btrfs_is_free_space_inode(bi))
> +			metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> +
>   		ret =3D btrfs_bio_wq_end_io(fs_info, bio, metadata);
>   		if (ret)
> -			goto out;
> +			return ret;
>
> -		if (bio_flags & EXTENT_BIO_COMPRESSED) {
> -			ret =3D btrfs_submit_compressed_read(inode, bio,
> +		if (bio_flags & EXTENT_BIO_COMPRESSED)
> +			return btrfs_submit_compressed_read(inode, bio,
>   							   mirror_num,
>   							   bio_flags);
> -			goto out;

Previously the out tag also ends the io for the bio.
Now we don't.

> -		} else {
> -			/*
> -			 * Lookup bio sums does extra checks around whether we
> -			 * need to csum or not, which is why we ignore skip_sum
> -			 * here.
> -			 */
> -			ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
> -			if (ret)
> -				goto out;
> -		}
> -		goto mapit;
> -	} else if (async && !skip_sum) {
> -		/* csum items have already been cloned */
> -		if (btrfs_is_data_reloc_root(root))
> -			goto mapit;
> -		/* we're doing a write, do the async checksumming */
> -		ret =3D btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
> -					  0, btrfs_submit_bio_start);
> -		goto out;
> -	} else if (!skip_sum) {
> -		ret =3D btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
> +
> +		/*
> +		 * Lookup bio sums does extra checks around whether we need to
> +		 * csum or not, which is why we ignore skip_sum here.
> +		 */
> +		ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
>   		if (ret)
> -			goto out;
> +			return ret;

The same missing endio call for error path.

Thanks,
Qu
>   	}
> -
>   mapit:
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -
> -out:
> -	return ret;
> +	return btrfs_map_bio(fs_info, bio, mirror_num);
>   }
>
>   /*
