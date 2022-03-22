Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA04E49D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 00:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiCWAA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:00:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14033BA7A;
        Tue, 22 Mar 2022 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647993560;
        bh=XfExHlb8PQB1JEp1SratK4AGqpE2fCv/TRvqFxxWGA0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=TwMHBtxcWFpBSO9RuRFdjwFqw53G/8b5Ija2ODReRWlo/yJ2NOK4X7g/NH0mS3eS4
         gdWJZ+Aqw5ZLEvBBLbRBxqHnAP5ZFiu3uif1+oeWrsQYYcEuKzeUl4d+qsgdcbjXSj
         +LGMYYAO8P1C61wsGT+84/3mzJh6CTBEYi6Iak9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS9I-1nuZNl2lb8-00ktlO; Wed, 23
 Mar 2022 00:59:20 +0100
Message-ID: <dd6a7675-71b5-b127-2012-9a5801d188fb@gmx.com>
Date:   Wed, 23 Mar 2022 07:59:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 02/40] btrfs: fix direct I/O read repair for split bios
In-Reply-To: <20220322155606.1267165-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoC8Cdk3U7GDOi5WvIeU0ugzAftrSibKqNII4beoShCflAjjz2x
 /ies2pSPMMiSNFSq9x8hSqsVTo21EzbOopSRSljTL3uaZ1lFB1RG2TT8wynuks8vsk1b6xg
 I6IXKA1D3sJ5vxMNEby92yo6vJeFneI/RtlyqJpkkipWqZUSE8Wv2By+p1FPLDCkEIM21WC
 l/Z6znZpy3k9XHgAdCY8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ihUXGMClITE=:AkYtArAQhKNJ4/UJd+RkSZ
 i9QdCJnGUgTM23Qqb5Swn83AiIAD9e+WoqLab9eMpsSTBhCzxB9df/wJeVAHZgLnHew5rtht9
 2PIcL3P+fsDL76i6NTtV4V1HHAsJg6wrX3Y7ij95/CGy+ciPXomBEO2buVN9Z5ImzWLpsXg/l
 FBrfMJDgD7eeK8yW7igBJpdI/PxhcgnuUz9KJE/fjXCReK9a4Xa07ppZ0b4fQ+B54AoZn7c+o
 4GUL/oNWmSLnOVPIi+D5urYF2RhoiI7/2rErgABGdk0zBia7uBIPT1/AR5DWFjSwMdiBPvIx2
 MhxlRMcgMzJuwzVeQymbpHkfIox9JmXtT6wUe4EikqPw3XN9oiL47J0TxKcs1zPPfn9hvYKMu
 OvFBfBWFbW8HPy2FdnZPK0Yo555hr/HNmcJQDTs2WTYs/5rff2jBAHCgJM5EqmtzmC2PE356X
 4cU09nisk2TVHoWsDue83dOTkC1QrKaYPJ0ZH9SXajcnv7Au7T2+NM1+RXxEWENorJ7FO6jD/
 rYO7DI4K6zVTSlaxQdpeQgDVfMUSj6E9RqboEcRGIr+HFB+gyraQ2NCe0PlBiucYzcre3q0WA
 Vfgrpi/7MXMTni0Ery2Yit5hmDZy/2USzMYAnNW8j4Hiz7gMSASqwp5ePUt0pZmA1nNQxJXE5
 IsV6JP1gGgNLOD6h2cT4fFdcbwEt3IeZHGz94gB9HrJg+cH2mTsAHh4Yav3VQ330fhPmhDjVA
 ldInJYuTInLD85EgU3Czaq0LbkagfofJESa8Jzhg7eptypuI3bmJJU1ZAyOOlhyEwKBwSeGrS
 QPvwc4NbdGZUedc9Lu6oWuQhfiN8qw5/j8gPDo+OiwPNpOnpmZtfIISEvfQZO6UDkAwEbJOUE
 UquXcAqmGcrXLEmdTH1AUjuuRYfAcWirqV3ZSe1P/haDCcLEJUK0J1O1cvi4WoLR0sN0+fKDY
 UvZ4nwCk5S7NWwgytsEh6ZzUBqIm+c4T7QuzUQQGuqyZj3z9encClRSLiFhp4CuuPePLWGCnG
 4U+Ifeb83U/uDK7PcjmJrjbu1XH/88u0XLAJXWV7QlkObbmTlZZ51ZbWRuRxgy7SMWoiMWVzg
 3pg6g4/8VIwzZg=
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
> When a bio is split in btrfs_submit_direct, dip->file_offset contains
> the file offset for the first bio.  But this means the start value used
> in btrfs_check_read_dio_bio is incorrect for subsequent bios.  Add
> a file_offset field to struct btrfs_bio to pass along the correct offset=
.
>
> Given that check_data_csum only uses start of an error message this
> means problems with this miscalculation will only show up when I/O
> fails or checksums mismatch. >
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Personally speaking, I really hate to add DIO specific value into btrfs_bi=
o.

Hopes we can later turn that btrfs_bio::file_offset into some union for
other usages.

Despite the extra memory usage, it looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c |  1 +
>   fs/btrfs/inode.c     | 13 +++++--------
>   fs/btrfs/volumes.h   |  3 +++
>   3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e9fa0f6d605ee..7ca4e9b80f023 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2662,6 +2662,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>
>   	repair_bio =3D btrfs_bio_alloc(1);
>   	repair_bbio =3D btrfs_bio(repair_bio);
> +	repair_bbio->file_offset =3D start;
>   	repair_bio->bi_opf =3D REQ_OP_READ;
>   	repair_bio->bi_end_io =3D failed_bio->bi_end_io;
>   	repair_bio->bi_iter.bi_sector =3D failrec->logical >> 9;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3ef8b63bb1b5c..93f00e9150ed0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7773,8 +7773,6 @@ static blk_status_t btrfs_check_read_dio_bio(struc=
t btrfs_dio_private *dip,
>   	const bool csum =3D !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
>   	struct bio_vec bvec;
>   	struct bvec_iter iter;
> -	const u64 orig_file_offset =3D dip->file_offset;
> -	u64 start =3D orig_file_offset;
>   	u32 bio_offset =3D 0;
>   	blk_status_t err =3D BLK_STS_OK;
>
> @@ -7784,6 +7782,8 @@ static blk_status_t btrfs_check_read_dio_bio(struc=
t btrfs_dio_private *dip,
>   		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
>   		pgoff =3D bvec.bv_offset;
>   		for (i =3D 0; i < nr_sectors; i++) {
> +			u64 start =3D bbio->file_offset + bio_offset;
> +
>   			ASSERT(pgoff < PAGE_SIZE);
>   			if (uptodate &&
>   			    (!csum || !check_data_csum(inode, bbio,
> @@ -7796,17 +7796,13 @@ static blk_status_t btrfs_check_read_dio_bio(str=
uct btrfs_dio_private *dip,
>   			} else {
>   				int ret;
>
> -				ASSERT((start - orig_file_offset) < UINT_MAX);
> -				ret =3D btrfs_repair_one_sector(inode,
> -						&bbio->bio,
> -						start - orig_file_offset,
> -						bvec.bv_page, pgoff,
> +				ret =3D btrfs_repair_one_sector(inode, &bbio->bio,
> +						bio_offset, bvec.bv_page, pgoff,
>   						start, bbio->mirror_num,
>   						submit_dio_repair_bio);
>   				if (ret)
>   					err =3D errno_to_blk_status(ret);
>   			}
> -			start +=3D sectorsize;
>   			ASSERT(bio_offset + sectorsize > bio_offset);
>   			bio_offset +=3D sectorsize;
>   			pgoff +=3D sectorsize;
> @@ -8009,6 +8005,7 @@ static void btrfs_submit_direct(const struct iomap=
_iter *iter,
>   		bio =3D btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
>   		bio->bi_private =3D dip;
>   		bio->bi_end_io =3D btrfs_end_dio_bio;
> +		btrfs_bio(bio)->file_offset =3D file_offset;
>
>   		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
>   			status =3D extract_ordered_extent(BTRFS_I(inode), bio,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 005c9e2a491a1..c22148bebc2f5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -323,6 +323,9 @@ struct btrfs_fs_devices {
>   struct btrfs_bio {
>   	unsigned int mirror_num;
>
> +	/* for direct I/O */
> +	u64 file_offset;
> +
>   	/* @device is for stripe IO submission. */
>   	struct btrfs_device *device;
>   	u8 *csum;
