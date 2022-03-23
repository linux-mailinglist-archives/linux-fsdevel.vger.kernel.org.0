Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51F4E4A37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiCWA4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiCWA4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:56:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6EDF83;
        Tue, 22 Mar 2022 17:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647996866;
        bh=Hy00S/9FCWStDFkCJIPtXkimLYZvipnqVmgQwtBcnP4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j5RbSEqTz1PQRVTf1t8r4tu+qasqCXANWlHlt6973tJeLhjG9lWlLTvOOBcHXJsbZ
         tkae0Qz6Uhu1OpAKNBnsxit3MXPvs0k2necJwvxjwHO0HxTSYfIRtVQQwtNu365GAt
         LByYzvQa7vSDktoLMncitYS0n7ONobGyhRCTS+mA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1nvw5e2rj5-00mGVW; Wed, 23
 Mar 2022 01:54:26 +0100
Message-ID: <35f1ef04-53b4-83ec-2f2f-be8893ffd258@gmx.com>
Date:   Wed, 23 Mar 2022 08:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 23/40] btrfs: store an inode pointer in struct btrfs_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-24-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-24-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Et88YU5ZVlGs/YxXZPlMZMlj9IxKrNUunKz+16vQqb2tFuWPrCv
 v5zI8yiZHFhprHafWYHXD2YxmCXdGjdOj08M3OLrdoqQ45JMMMFFS/C3vx7PPOd5xAkxjfA
 0dY4a6Tr81PnghL+kBVzTsOvqdVWGzWybXJhsV0rDRI7xMIDYXeQmGU/jrkp8CgVuVJKGBh
 o6CkxGpIz+rIRlU8hwLaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFUkaqT/rUA=:9zLil0pR8+OW/OM74AK5qg
 3ih06tZzgVZ6QlxL8pe2y6tZTGWf+ud7PvWRhhMHkKOH8Etx1YYvZQR81lAPfnpatfJom25PM
 1+yxabi1ibQBfO1SPKHa3gFc9aaW3fDrgZvVsaRz7ajcVLZ+GbK4TEuO7Q+jiQIyoKFPa8zZM
 qEa6hAJz3pnHDon3UrM1dK0ZmwxjRg9Zv5aCr93KG6rPg0+9vHnDrNy2TdjISPbhREC+xVuum
 5dcWGyw8cMcPJpdGbBuZOPdw36camNV/7vi2MOBCEwSZNfyUJSir1RYMk0NjtWiyzgi1Iuauh
 0XAYBC7ghFuzvaUWOC1TYkYZ9UNC24zz9vNqa248uSD55vfGvUWnIA6DEUlni6oCrgjwOsJ5g
 rIKKHOZOPpVexV7MmOTOkCp93uoyo/hWRu3YgmVUxE5c/IutQE+i2HGP9IijOwKQc+twRD+9g
 gFizVtG/kMDfln9piQDBD3ccKXYkj95Mn37dAzsWysUI+6RUM352i/eOCDW0fmRb7HN4vNS5R
 7R0NaJUzs+ER92uaatMmLVwoA0PbwWJQ1LdIysTFGwXnQLDuXO+Wc6BZrVSg93Lcrj4YzQJA/
 cp8NwsJZPSOwUhUN8s9Ww7YrzPmumhmvMZnY7SMs53ZwD94vqtWuJK2Y5uHTQeQYsBQrXXZxT
 QvzkoIfBsWsPH0eeQVDpgbDrUhoYMBdefTO4JDmMGeCweK5kl9koIu7QsNamc1un/YjyDWl3p
 FReQXmHxZgfr+LfziGBO1QaBi5zlSYFC4i7fqnFadu1klqy7EkTkB8I6829y6RbNI7bME+OFU
 KXW9WHL8vHeW1BlD/VEH1RxOS1Zyz/Qi6hvCh2HGuHGNAWE37RLENPvydfvQXQDRNslC6xxgA
 oh0kqD0ZY0JtnCGHTaFg6zSn0u2IK5/ie9n/IS0n6MR29Z5GEae5Ec5z/Aqgi9eL7PXn/oC4D
 sT0IOJPHcazJOiTmKlv/IWv/SgDSwj+UG+tGcKJJM5I2nrusHbOikPE4Vn1pdlsZ4bOpeJ3xY
 MAQK6sqm0Ei8iRg7WmuhsX7/9sdb/c7+N4R5UtCFS1MKMp7/2J+XIaJfKdXV4rqRZyV9aENp2
 0gMKlVFYuoMi+s=
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
> All the I/O going through the btrfs_bio based path are associated with a=
n
> inode.  Add a pointer to it to simplify a few things soon.  Also pass th=
e
> bio operation to btrfs_bio_alloc given that we have to touch it anyway.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Something I want to avoid is to futher increasing the size of btrfs_bio.

For buffered uncompressed IO, we can grab the inode from the first page.
For direct IO we have bio->bi_private (btrfs_dio_private).
For compressed IO, it's bio->bi_private again (compressed_bio).

Do the saved code lines really validate the memory usage for all bios?

Thanks,
Qu

> ---
>   fs/btrfs/compression.c |  4 +---
>   fs/btrfs/extent_io.c   | 23 ++++++++++++-----------
>   fs/btrfs/extent_io.h   |  6 ++++--
>   fs/btrfs/inode.c       |  3 ++-
>   fs/btrfs/volumes.h     |  2 ++
>   5 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 71e5b2e9a1ba8..419a09d924290 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -464,10 +464,8 @@ static struct bio *alloc_compressed_bio(struct comp=
ressed_bio *cb, u64 disk_byte
>   	struct bio *bio;
>   	int ret;
>
> -	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
> -
> +	bio =3D btrfs_bio_alloc(cb->inode, BIO_MAX_VECS, opf);
>   	bio->bi_iter.bi_sector =3D disk_bytenr >> SECTOR_SHIFT;
> -	bio->bi_opf =3D opf;
>   	bio->bi_private =3D cb;
>   	bio->bi_end_io =3D endio_func;
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 58ef0f4fca361..116a65787e314 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2657,10 +2657,9 @@ int btrfs_repair_one_sector(struct inode *inode,
>   		return -EIO;
>   	}
>
> -	repair_bio =3D btrfs_bio_alloc(1);
> +	repair_bio =3D btrfs_bio_alloc(inode, 1, REQ_OP_READ);
>   	repair_bbio =3D btrfs_bio(repair_bio);
>   	repair_bbio->file_offset =3D start;
> -	repair_bio->bi_opf =3D REQ_OP_READ;
>   	repair_bio->bi_end_io =3D failed_bio->bi_end_io;
>   	repair_bio->bi_iter.bi_sector =3D failrec->logical >> 9;
>   	repair_bio->bi_private =3D failed_bio->bi_private;
> @@ -3128,9 +3127,10 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>    * new bio by bio_alloc_bioset as it does not initialize the bytes out=
side of
>    * 'bio' because use of __GFP_ZERO is not supported.
>    */
> -static inline void btrfs_bio_init(struct btrfs_bio *bbio)
> +static inline void btrfs_bio_init(struct btrfs_bio *bbio, struct inode =
*inode)
>   {
>   	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +	bbio->inode =3D inode;
>   }
>
>   /*
> @@ -3138,13 +3138,14 @@ static inline void btrfs_bio_init(struct btrfs_b=
io *bbio)
>    *
>    * The bio allocation is backed by bioset and does not fail.
>    */
> -struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
> +struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs=
,
> +		unsigned int opf)
>   {
>   	struct bio *bio;
>
>   	ASSERT(0 < nr_iovecs && nr_iovecs <=3D BIO_MAX_VECS);
> -	bio =3D bio_alloc_bioset(NULL, nr_iovecs, 0, GFP_NOFS, &btrfs_bioset);
> -	btrfs_bio_init(btrfs_bio(bio));
> +	bio =3D bio_alloc_bioset(NULL, nr_iovecs, opf, GFP_NOFS, &btrfs_bioset=
);
> +	btrfs_bio_init(btrfs_bio(bio), inode);
>   	return bio;
>   }
>
> @@ -3156,12 +3157,13 @@ struct bio *btrfs_bio_clone(struct block_device =
*bdev, struct bio *bio)
>   	/* Bio allocation backed by a bioset does not fail */
>   	new =3D bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
>   	bbio =3D btrfs_bio(new);
> -	btrfs_bio_init(bbio);
> +	btrfs_bio_init(btrfs_bio(new), btrfs_bio(bio)->inode);
>   	bbio->iter =3D bio->bi_iter;
>   	return new;
>   }
>
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 s=
ize)
> +struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *or=
ig,
> +		u64 offset, u64 size)
>   {
>   	struct bio *bio;
>   	struct btrfs_bio *bbio;
> @@ -3173,7 +3175,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *or=
ig, u64 offset, u64 size)
>   	ASSERT(bio);
>
>   	bbio =3D btrfs_bio(bio);
> -	btrfs_bio_init(bbio);
> +	btrfs_bio_init(btrfs_bio(bio), inode);
>
>   	bio_trim(bio, offset >> 9, size >> 9);
>   	bbio->iter =3D bio->bi_iter;
> @@ -3308,7 +3310,7 @@ static int alloc_new_bio(struct btrfs_inode *inode=
,
>   	struct bio *bio;
>   	int ret;
>
> -	bio =3D btrfs_bio_alloc(BIO_MAX_VECS);
> +	bio =3D btrfs_bio_alloc(&inode->vfs_inode, BIO_MAX_VECS, opf);
>   	/*
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
> @@ -3321,7 +3323,6 @@ static int alloc_new_bio(struct btrfs_inode *inode=
,
>   	bio_ctrl->bio_flags =3D bio_flags;
>   	bio->bi_end_io =3D end_io_func;
>   	bio->bi_private =3D &inode->io_tree;
> -	bio->bi_opf =3D opf;
>   	ret =3D calc_bio_boundaries(bio_ctrl, inode, file_offset);
>   	if (ret < 0)
>   		goto error;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 72d86f228c56e..d5f3d9692ea29 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -277,9 +277,11 @@ void extent_range_redirty_for_io(struct inode *inod=
e, u64 start, u64 end);
>   void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start=
, u64 end,
>   				  struct page *locked_page,
>   				  u32 bits_to_clear, unsigned long page_ops);
> -struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
> +struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs=
,
> +		unsigned int opf);
>   struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio=
);
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 s=
ize);
> +struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *or=
ig,
> +		u64 offset, u64 size);
>
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 e=
nd);
>   int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mir=
ror_num);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5c9d8e8a98466..18d54cfedf829 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7987,7 +7987,8 @@ static void btrfs_submit_direct(const struct iomap=
_iter *iter,
>   		 * This will never fail as it's passing GPF_NOFS and
>   		 * the allocation is backed by btrfs_bioset.
>   		 */
> -		bio =3D btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
> +		bio =3D btrfs_bio_clone_partial(inode, dio_bio, clone_offset,
> +					      clone_len);
>   		bio->bi_private =3D dip;
>   		bio->bi_end_io =3D btrfs_end_dio_bio;
>   		btrfs_bio(bio)->file_offset =3D file_offset;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c22148bebc2f5..a4f942547002e 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -321,6 +321,8 @@ struct btrfs_fs_devices {
>    * Mostly for btrfs specific features like csum and mirror_num.
>    */
>   struct btrfs_bio {
> +	struct inode *inode;
> +
>   	unsigned int mirror_num;
>
>   	/* for direct I/O */
