Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4A4E4A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiCWAw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiCWAw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:52:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70020F5C;
        Tue, 22 Mar 2022 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647996650;
        bh=fWlG/ZqmOKYiaC4865t9txZ8zZ6+C4YZ9t77WZf3l/Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ThKMpYG5A4yOvQpbrGnqJ+yx/CUbP4pB9l83BvAPyAwSfxd56RMNFHhebtgfvjnFH
         o6G2O9SBrsNELpxFLMwdiDMa6dUmTZuTB/WZvov9M7A9VA49tBLsDA1c9zpxAYgxFu
         Oydz9B7FygxLMeCfvr69EZdPg1iuconUc4kzbDTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1nIUnV13Xw-00GXWA; Wed, 23
 Mar 2022 01:50:49 +0100
Message-ID: <ae266050-6bd4-96a9-1476-2c42fd8cb5c1@gmx.com>
Date:   Wed, 23 Mar 2022 08:50:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 22/40] btrfs: cleanup btrfs_submit_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-23-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-23-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ryhpvNhQDSA88AeRphbg6SO0SSWGZorOsd2Km6yBCXIO/GUM/kE
 9JaeUaLe8sXjzrVV/3kJ6wsHWsXezi7JyYUpvzfFYDUN48wUhDeyMy0+rs2jGgCitpKJguG
 ET0I9JNesCt2wXCrsVGOpDTgbpCE9D86QAR+85hfh5GcAnj1tF39ye2H4NYk9W5d7yL0hNG
 V7KOgeEeQs1dsWYobh5hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nI7zGcgbKKI=:00WTIaV050lmm8ioGmfewj
 3mVpwULXswuZfKI9ZLMuf4eLtW7F5HsZS0Vm623lZ4haSXfgFXrLE1nHCtxdN3dNSpqeofImZ
 1V7hge/npUwayKIpvvMs8SU4XguCdy8sC1IiYmae0j1cBhIySCwa666RfBp/pFjruSJIqNL3b
 PxxNcbI/JH6gJR3UnYq4C4vcB+fPqh9kW1NjQTOhVAX/uFjbHkrBwOsDY6TAmSRoYaf9nvvPd
 ccTP3n3BiEwbC4W3eMH+8cRDueO0KA6qdULVmqi3KjtvlcaqPWvLSrg1aSfk/ukmSddNwe624
 FQITBdEhO58S7nXDQUr5hNBXsagiNo+dZECWOp9fh/i0+mrUgqEw5dbC+Zq3NtfZrt7hGRTl6
 ohjJcrJpnAYYO4jCS6W5gF1G3ZVRMAU43lOvpf9NdVxPNUrX4u2bNRuDs6bQgsGhzq31THXJT
 HtAUfYCkbdskXWXS4h364v03L4Av5uukKUlxByZTNzOwbCszKG9/pRQFyitcVoRBiv4wCPYm5
 jVTWHpG4C/A1xvIZ4d5p9ZOCBAXFwMVIUZwjl6dq2wkVImgupTqESP2KJkx1NVPgTCwZr/fSa
 4noJbuKltxhZkOBDdrS6iOAjFonvaeCjbOhwQTqYdwakTZR7Sb7RE0aRbwZ5NWrtRzjxr5Z3W
 +3P30nejF65h0ABCuoMI1gqOUthPIOp4m3RDvmAguUo0DB52V+D6ytbAlf9ZEGK8GmqtBQqfL
 DQgFaTPg0KaAn19oJVoU11Cj1k4VwxM/CiL9P4eRSPdvww7sVXHhch35cpwLli1VbsNrOsC2L
 Os7Yj7Y1yM3KckcHyF6fIGCo3TAi/+IDFoXov7NYydyJwY6ooncOY0QxaAEBCLx7c612u6XX7
 hBhG8TU1kH2H3rcXgsehhuR32NB64FRZrdvGwUvFckdrfsPz1NYY1sEamOUZAtXNIsMiTBIwu
 fdzR8nnAI/SIlz55tSmiZZr6Q6aXGtPCYE4EVBei/YtIRwFqt/Om2OCau3s32UHWi7wirsbwR
 UoERZHBq154/wxvmEKbGDVaqD16RL9DBPdiszs5u0UDEGl7nJDy8xG4PuF5028gBO6anIsipD
 TYoD0qhp6h4yrQ=
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
> Remove the pointless goto just to return err and clean up the code flow
> to be a little more straight forward.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/inode.c | 59 ++++++++++++++++++++++--------------------------
>   1 file changed, 27 insertions(+), 32 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a54b7fd4658d0..5c9d8e8a98466 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7844,47 +7844,42 @@ static inline blk_status_t btrfs_submit_dio_bio(=
struct bio *bio,
>   		struct inode *inode, u64 file_offset, int async_submit)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	struct btrfs_inode *bi =3D BTRFS_I(inode);
>   	struct btrfs_dio_private *dip =3D bio->bi_private;
> -	bool write =3D btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE;
>   	blk_status_t ret;
>
> -	/* Check btrfs_submit_bio_hook() for rules about async submit. */
> -	if (async_submit)
> -		async_submit =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> +		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
> +			/* See btrfs_submit_data_bio for async submit rules */
> +			if (async_submit && !atomic_read(&bi->sync_writers))
> +				return btrfs_wq_submit_bio(inode, bio, 0, 0,
> +					file_offset,
> +					btrfs_submit_bio_start_direct_io);
>
> -	if (!write) {
> +			/*
> +			 * If we aren't doing async submit, calculate the csum of the
> +			 * bio now.
> +			 */
> +			ret =3D btrfs_csum_one_bio(bi, bio, file_offset, 1);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
>   		ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>   		if (ret)
> -			goto err;
> -	}
> -
> -	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
> -		goto map;
> +			return ret;
>
> -	if (write && async_submit) {
> -		ret =3D btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
> -					  btrfs_submit_bio_start_direct_io);
> -		goto err;
> -	} else if (write) {
> -		/*
> -		 * If we aren't doing async submit, calculate the csum of the
> -		 * bio now.
> -		 */
> -		ret =3D btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
> -		if (ret)
> -			goto err;
> -	} else {
> -		u64 csum_offset;
> +		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
> +			u64 csum_offset;
>
> -		csum_offset =3D file_offset - dip->file_offset;
> -		csum_offset >>=3D fs_info->sectorsize_bits;
> -		csum_offset *=3D fs_info->csum_size;
> -		btrfs_bio(bio)->csum =3D dip->csums + csum_offset;
> +			csum_offset =3D file_offset - dip->file_offset;
> +			csum_offset >>=3D fs_info->sectorsize_bits;
> +			csum_offset *=3D fs_info->csum_size;
> +			btrfs_bio(bio)->csum =3D dip->csums + csum_offset;
> +		}
>   	}
> -map:
> -	ret =3D btrfs_map_bio(fs_info, bio, 0);
> -err:
> -	return ret;
> +
> +	return btrfs_map_bio(fs_info, bio, 0);

Can we just put btrfs_map_bio() call into each read/write branch?

In fact it's the shared single btrfs_map_bio() still requires us to use
if () {} else {}.

I manually checked the code, it looks fine to me.

Although related to btrfs_op(bio), personally I would put some extra
ASSERT()s to make sure in this function we only got either MAP_WRITE or
MAP_READ, no other values allowed.

Thanks,
Qu

>   }
>
>   /*
