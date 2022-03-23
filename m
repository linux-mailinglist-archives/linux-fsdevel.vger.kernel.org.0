Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB384E4A95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiCWBlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiCWBlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:41:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33B28999;
        Tue, 22 Mar 2022 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647999569;
        bh=hvhgyDLjIajnFbTj4316FGrHwovOLVneKzRvU1uAo/o=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=O9x6g2ED8Rq7v84gnquf6UsY5lLkxFe77cw7AxFb1RiOWNVoIfkC5y3ZoA9WuX0v1
         xUdCmGYSHJKzEYopxlloq+LvcLigBEfgeHGk8gIP7BFlZQva6wG2nJ4pfkQ2ca99/y
         rkrSr6g5IYVVN5nSFoe4cDxi5q3QN9aiOX4WGOe8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacOQ-1o3PdS2QLS-00c8Q0; Wed, 23
 Mar 2022 02:39:29 +0100
Message-ID: <37a6e06f-c8ac-37dc-2f3b-b469e2410a97@gmx.com>
Date:   Wed, 23 Mar 2022 09:39:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-41-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 40/40] btrfs: use the iomap direct I/O bio directly
In-Reply-To: <20220322155606.1267165-41-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmJ/yulUi+/qbWEZbfCnmBKpxkpbBYeGI9sHBTtto1K8zvHE0eg
 m0ZpZkPEu9vM3TXNnl2wzno3zQ47K+LPb5IhR2D7i5KXkJsRbAogJZmZTtDpCiLVZMLgVc2
 v+MojDKIfxLg4RrHtVMri6eFZaHHEE0+BpPzA25rS9yprIVuJUcuuqOI+mZ17NjnNB8y64N
 iOr6puSLO5ntJHnH/fGDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kasrwRZFVyk=:LQ5IaH1/BqYAQ29QW5Yw7L
 t03oDQpS+wruBv1wmQLZtMTZhhbMGlO7TsfknbEU9+OEaREs90VgBAWprKs2EhUOkcBmILG2E
 gWcmrkB+jqyBurNVxLW5S5r9YylVmJZ9OsJYpEzoR6W2R0GzqWulNfSpw50nEx4R2ptsx5PSL
 1DpXzR/OHDpYFVrICmj8nwXWzQZc+9uMbqT+9xKjqdy8K/QzPa6GftluZG0CIICPP3t8hPVcX
 ODREcb9SEpGDfwcjUQcu9DK9SJRrWurV2FJLQzabC/sMnD5C4tbwxNwqP1f6aofNDIk6/7o6Q
 Yekr608clJ+KZ+EMQByqILO9VMEiN0Fp+FBJvfXth1caQgut37pcIHKbzflzYZWipUlGVWVGz
 p13yLwJA5i7beK9i0XtJXXbplCUCKr/HPaZyS/+hjz10IjgeVuaYBDg7a/Mx3Fl6M8eQsiIrz
 SsPXFPlubacIJPOESBniXdUCOIkIjA8tXN3TkuqOvDZC/5Ha3lnJ4FhmADEtEXmj0PPxmSD4Z
 95rseckL8+3TfZM/Ln+sF3xBsY93fLlY3HNTVxDXevHkGWLrJRb/MJt/D5+j3TVIUqLbbtIJT
 BWAWrcNAdeCB9a/hvOq82a0ZMnov78rFfNIF9ZmJCwKf8Bb3wFY/kLX7H1Jb6emjUFhV/jN9/
 dOq4Xc6PGsPmMnAl3uxJW8w2kQ7isETfoW8qxgDxQ1veuRVBx8CExbwCgP4HYgsyoabZMzvA9
 r809s4S8ZWqEpWqltoQOClFB2OuQdadkzpzrEVFT2lt+jQQFV8rP1gKMMay1EnEEANuzGyDXw
 2gIAZYz1tHMiI7B76VZJTf4nCX/MsMqaMaZdVeaEVfZrLJR9PkaEYIhfa1QWqD4IbOI+B9iDi
 dKYyTWJLX0AdHbrezkMILCdFY1wHIV3V72ya6sg8rgk3UjYKaBCIKlEpsX5QEE810w0sOifWy
 yt4nPAMNyjtWvwvacmS9t5LFQLdkPqTvTrHz3Ibkx0AGUNrgVMeHUU5z5ogdXJWIz5XJY75+6
 DJF09bKNm08Y4jzBqAnUBL4yy1f34DLWFwdP0PpOEXTssZydtRDM+PCTwYJIPD8fZLTDpgQ45
 pz7Vu6FqfB70mY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:56, Christoph Hellwig wrote:
> Make the iomap code allocate btrfs dios by setting the bio_set field,
> and then feed these directly into btrfs_map_dio.
>
> For this to work iomap_begin needs to report a range that only contains
> a single chunk, and thus is changed to a two level iteration.
>
> This needs another extra field in struct btrfs_dio.  We culd overlay
> it with other fields not used after I/O submittion, or split out a
> new btrfs_dio_bio for the file_offset, iter and repair_refs, but
> compared to the overall saving of the series this is a minor detail.
>
> The per-iomap csum lookup is gone for now as well.  At least for
> small I/Os this just creates a lot of overhead, but for large I/O
> we could look into optimizing this in one for or another, but I'd
> love to see a reproducer where it actually matters first.  With the
> state as of this patch the direct I/O bio submission is so close
> to the buffered one that they could be unified with very little
> work, so diverging again would be a bit counterproductive.  OTOH
> if the optimization is indeed very useful we should do it in a way
> that also works for buffered reads.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not familar with iomap thus I can be totally wrong, but isn't the idea
of iomap to separate more code from fs?

My (mostly poor) understanding of iomap is, iomap just crafting a bio
(with the help from fs callbacks).

For btrfs or stacked drivers, they can do whatever to split/clone the
bio, as long as the original bio can be fullfiled, how btrfs/stacked
drivers do the work is their own business.


I'm really not sure if it's a good idea to expose btrfs internal bio_set
just for iomap.

Personally speaking I didn't see much problem of cloning an iomap bio,
it only causes extra memory of btrfs_bio, which is pretty small previously=
.

Or did I miss something specific to iomap?

Thanks,
Qu
> ---
>   fs/btrfs/btrfs_inode.h |  25 ---
>   fs/btrfs/ctree.h       |   1 -
>   fs/btrfs/extent_io.c   |  22 +-
>   fs/btrfs/extent_io.h   |   4 +-
>   fs/btrfs/inode.c       | 451 ++++++++++++++++-------------------------
>   fs/btrfs/volumes.h     |   1 +
>   6 files changed, 184 insertions(+), 320 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b3e46aabc3d86..a3199020f0001 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -346,31 +346,6 @@ static inline bool btrfs_inode_in_log(struct btrfs_=
inode *inode, u64 generation)
>   	return ret;
>   }
>
> -struct btrfs_dio_private {
> -	struct inode *inode;
> -
> -	/*
> -	 * Since DIO can use anonymous page, we cannot use page_offset() to
> -	 * grab the file offset, thus need a dedicated member for file offset.
> -	 */
> -	u64 file_offset;
> -	u64 disk_bytenr;
> -	/* Used for bio::bi_size */
> -	u32 bytes;
> -
> -	/*
> -	 * References to this structure. There is one reference per in-flight
> -	 * bio plus one while we're still setting up.
> -	 */
> -	refcount_t refs;
> -
> -	/* dio_bio came from fs/direct-io.c */
> -	struct bio *dio_bio;
> -
> -	/* Array of checksums */
> -	u8 csums[];
> -};
> -
>   /*
>    * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in =
two
>    * separate u32s. These two functions convert between the two represen=
tations.
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 196f308e3e0d7..64ef20b84f694 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3136,7 +3136,6 @@ int btrfs_del_orphan_item(struct btrfs_trans_handl=
e *trans,
>   int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
>
>   /* file-item.c */
> -struct btrfs_dio_private;
>   int btrfs_del_csums(struct btrfs_trans_handle *trans,
>   		    struct btrfs_root *root, u64 bytenr, u64 len);
>   blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bi=
o, u8 *dst);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5a1447db28228..f705e4ec9b961 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -31,7 +31,7 @@
>
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> -static struct bio_set btrfs_bioset;
> +struct bio_set btrfs_bioset;
>
>   static inline bool extent_state_in_tree(const struct extent_state *sta=
te)
>   {
> @@ -3150,26 +3150,6 @@ struct bio *btrfs_bio_alloc(struct inode *inode, =
unsigned int nr_iovecs,
>   	return bio;
>   }
>
> -struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *or=
ig,
> -		u64 offset, u64 size)
> -{
> -	struct bio *bio;
> -	struct btrfs_bio *bbio;
> -
> -	ASSERT(offset <=3D UINT_MAX && size <=3D UINT_MAX);
> -
> -	/* this will never fail when it's backed by a bioset */
> -	bio =3D bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
> -	ASSERT(bio);
> -
> -	bbio =3D btrfs_bio(bio);
> -	btrfs_bio_init(btrfs_bio(bio), inode);
> -
> -	bio_trim(bio, offset >> 9, size >> 9);
> -	bbio->iter =3D bio->bi_iter;
> -	return bio;
> -}
> -
>   /**
>    * Attempt to add a page to bio
>    *
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 54e54269cfdba..b416531721dfb 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -279,8 +279,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode=
 *inode, u64 start, u64 end,
>   				  u32 bits_to_clear, unsigned long page_ops);
>   struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovec=
s,
>   		unsigned int opf);
> -struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *or=
ig,
> -		u64 offset, u64 size);
>
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 e=
nd);
>   int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mir=
ror_num);
> @@ -323,4 +321,6 @@ void btrfs_extent_buffer_leak_debug_check(struct btr=
fs_fs_info *fs_info);
>   #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
>   #endif
>
> +extern struct bio_set btrfs_bioset;
> +
>   #endif
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e25d9d860c679..6ea6ef214abdb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -62,8 +62,8 @@ struct btrfs_iget_args {
>   };
>
>   struct btrfs_dio_data {
> -	ssize_t submitted;
>   	struct extent_changeset *data_reserved;
> +	struct iomap extent;
>   };
>
>   static const struct inode_operations btrfs_dir_inode_operations;
> @@ -7507,16 +7507,16 @@ static int btrfs_get_blocks_direct_write(struct =
extent_map **map,
>   	return ret;
>   }
>
> -static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
> +static int btrfs_dio_iomap_begin_extent(struct iomap_iter *iter)
>   {
>   	struct inode *inode =3D iter->inode;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	loff_t start =3D iter->pos;
>   	loff_t length =3D iter->len;
> -	struct iomap *iomap =3D &iter->iomap;
>   	struct extent_map *em;
>   	struct extent_state *cached_state =3D NULL;
>   	struct btrfs_dio_data *dio_data =3D iter->private;
> +	struct iomap *iomap =3D &dio_data->extent;
>   	u64 lockstart, lockend;
>   	bool write =3D (iter->flags & IOMAP_WRITE);
>   	int ret =3D 0;
> @@ -7543,7 +7543,6 @@ static int btrfs_dio_iomap_begin(struct iomap_iter=
 *iter)
>   			return ret;
>   	}
>
> -	dio_data->submitted =3D 0;
>   	dio_data->data_reserved =3D NULL;
>
>   	/*
> @@ -7647,14 +7646,12 @@ static int btrfs_dio_iomap_begin(struct iomap_it=
er *iter)
>   		iomap->type =3D IOMAP_MAPPED;
>   	}
>   	iomap->offset =3D start;
> -	iomap->bdev =3D fs_info->fs_devices->latest_dev->bdev;
>   	iomap->length =3D len;
>
>   	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
>   		iomap->flags |=3D IOMAP_F_ZONE_APPEND;
>
>   	free_extent_map(em);
> -
>   	return 0;
>
>   unlock_err:
> @@ -7663,53 +7660,95 @@ static int btrfs_dio_iomap_begin(struct iomap_it=
er *iter)
>   	return ret;
>   }
>
> -static int btrfs_dio_iomap_end(struct iomap_iter *iter)
> +static void btrfs_dio_unlock_remaining_extent(struct btrfs_inode *bi,
> +		u64 pos, u64 len, u64 processed, bool write)
>   {
> -	struct btrfs_dio_data *dio_data =3D iter->private;
> +	if (write)
> +		__endio_write_update_ordered(bi, pos + processed,
> +				len - processed, false);
> +	else
> +		unlock_extent(&bi->io_tree, pos + processed,
> +				pos + len - 1);
> +}
> +
> +static int btrfs_dio_iomap_begin_chunk(struct iomap_iter *iter)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(iter->inode->i_sb);
>   	struct btrfs_inode *bi =3D BTRFS_I(iter->inode);
> -	bool write =3D (iter->flags & IOMAP_WRITE);
> -	loff_t length =3D iomap_length(iter);
> -	loff_t pos =3D iter->pos;
> -	int ret =3D 0;
> +	struct btrfs_dio_data *dio_data =3D iter->private;
> +	struct block_device *bdev;
> +	u64 len;
> +
> +	iter->iomap =3D dio_data->extent;
>
> -	if (!write && iter->iomap.type =3D=3D IOMAP_HOLE) {
> -		/* If reading from a hole, unlock and return */
> -		unlock_extent(&bi->io_tree, pos, pos + length - 1);
> +	if (dio_data->extent.type !=3D IOMAP_MAPPED)
>   		return 0;
> +
> +	bdev =3D btrfs_get_stripe_info(fs_info, (iter->flags & IOMAP_WRITE) ?
> +			BTRFS_MAP_WRITE : BTRFS_MAP_READ,
> +			iter->iomap.addr, iter->iomap.length, &len);
> +	if (WARN_ON_ONCE(IS_ERR(bdev))) {
> +		btrfs_dio_unlock_remaining_extent(bi, dio_data->extent.offset,
> +						  dio_data->extent.length, 0,
> +						  iter->flags & IOMAP_WRITE);
> +		return PTR_ERR(bdev);
>   	}
>
> -	if (dio_data->submitted < length) {
> -		pos +=3D dio_data->submitted;
> -		length -=3D dio_data->submitted;
> -		if (write)
> -			__endio_write_update_ordered(bi, pos, length, false);
> -		else
> -			unlock_extent(&bi->io_tree, pos, pos + length - 1);
> -		ret =3D -ENOTBLK;
> +	iter->iomap.bdev =3D bdev;
> +	iter->iomap.length =3D min(iter->iomap.length, len);
> +	return 0;
> +}
> +
> +static bool btrfs_dio_iomap_end(struct iomap_iter *iter)
> +{
> +	struct btrfs_inode *bi =3D BTRFS_I(iter->inode);
> +	struct btrfs_dio_data *dio_data =3D iter->private;
> +	struct iomap *extent =3D &dio_data->extent;
> +	loff_t processed =3D iomap_processed(iter);
> +	loff_t length =3D iomap_length(iter);
> +
> +	if (iter->iomap.type =3D=3D IOMAP_HOLE) {
> +		ASSERT(!(iter->flags & IOMAP_WRITE));
> +
> +		/* If reading from a hole, unlock the whole range here */
> +		unlock_extent(&bi->io_tree, iter->pos, iter->pos + length - 1);
> +	} else if (processed < length) {
> +		btrfs_dio_unlock_remaining_extent(bi, extent->offset,
> +						  extent->length, processed,
> +						  iter->flags & IOMAP_WRITE);
> +	} else if (iter->pos + processed < extent->offset + extent->length) {
> +		extent->offset +=3D processed;
> +		extent->addr +=3D processed;
> +		extent->length -=3D processed;
> +		return true;
>   	}
>
> -	if (write)
> +	if (iter->flags & IOMAP_WRITE)
>   		extent_changeset_free(dio_data->data_reserved);
> -	return ret;
> +	return false;
>   }
>
>   static int btrfs_dio_iomap_iter(struct iomap_iter *iter)
>   {
> +	bool keep_extent =3D false;
>   	int ret;
>
> -	if (iter->iomap.length) {
> -		ret =3D btrfs_dio_iomap_end(iter);
> -		if (ret < 0 && !iter->processed)
> -			return ret;
> -	}
> +	if (iter->iomap.length)
> +		keep_extent =3D btrfs_dio_iomap_end(iter);
>
>   	ret =3D iomap_iter_advance(iter);
>   	if (ret <=3D 0)
>   		return ret;
>
> -	ret =3D btrfs_dio_iomap_begin(iter);
> -	if (ret < 0)
> +	if (!keep_extent) {
> +		ret =3D btrfs_dio_iomap_begin_extent(iter);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	ret =3D btrfs_dio_iomap_begin_chunk(iter);
> +	if (ret < 0)
>   		return ret;
> +
>   	iomap_iter_done(iter);
>   	return 1;
>   }
> @@ -7718,54 +7757,40 @@ static const struct iomap_ops btrfs_dio_iomap_op=
s =3D {
>   	.iomap_iter		=3D btrfs_dio_iomap_iter,
>   };
>
> -static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
> +static void btrfs_end_read_dio_bio(struct btrfs_bio *bbio,
> +		struct btrfs_bio *main_bbio);
> +
> +static void btrfs_dio_repair_end_io(struct bio *bio)
>   {
> -	/*
> -	 * This implies a barrier so that stores to dio_bio->bi_status before
> -	 * this and loads of dio_bio->bi_status after this are fully ordered.
> -	 */
> -	if (!refcount_dec_and_test(&dip->refs))
> -		return;
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> +	struct btrfs_inode *bi =3D BTRFS_I(bbio->inode);
> +	struct btrfs_bio *failed_bbio =3D bio->bi_private;
>
> -	if (btrfs_op(dip->dio_bio) =3D=3D BTRFS_MAP_WRITE) {
> -		__endio_write_update_ordered(BTRFS_I(dip->inode),
> -					     dip->file_offset,
> -					     dip->bytes,
> -					     !dip->dio_bio->bi_status);
> -	} else {
> -		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
> -			      dip->file_offset,
> -			      dip->file_offset + dip->bytes - 1);
> +	if (bio->bi_status) {
> +		btrfs_warn(bi->root->fs_info,
> +			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d"=
,
> +			   btrfs_ino(bi), bio_op(bio), bio->bi_opf,
> +			   bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
> +			   bio->bi_status);
>   	}
> +	btrfs_end_read_dio_bio(bbio, failed_bbio);
>
> -	bio_endio(dip->dio_bio);
> -	kfree(dip);
> +	bio_put(bio);
>   }
>
>   static blk_status_t submit_dio_repair_bio(struct inode *inode, struct =
bio *bio,
>   					  int mirror_num,
>   					  unsigned long bio_flags)
>   {
> -	struct btrfs_dio_private *dip =3D bio->bi_private;
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	blk_status_t ret;
> -
>   	BUG_ON(bio_op(bio) =3D=3D REQ_OP_WRITE);
> -
>   	btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_WRITE;
> -
> -	refcount_inc(&dip->refs);
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	if (ret)
> -		refcount_dec(&dip->refs);
> -	return ret;
> +	return btrfs_map_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
>   }
>
> -static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *=
dip,
> -					     struct btrfs_bio *bbio,
> -					     const bool uptodate)
> +static void btrfs_end_read_dio_bio(struct btrfs_bio *this_bbio,
> +		struct btrfs_bio *main_bbio)
>   {
> -	struct inode *inode =3D dip->inode;
> +	struct inode *inode =3D main_bbio->inode;
>   	struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
>   	const u32 sectorsize =3D fs_info->sectorsize;
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
> @@ -7773,20 +7798,22 @@ static blk_status_t btrfs_check_read_dio_bio(str=
uct btrfs_dio_private *dip,
>   	const bool csum =3D !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
>   	struct bio_vec bvec;
>   	struct bvec_iter iter;
> +	bool uptodate =3D !this_bbio->bio.bi_status;
>   	u32 bio_offset =3D 0;
> -	blk_status_t err =3D BLK_STS_OK;
>
> -	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
> +	main_bbio->bio.bi_status =3D BLK_STS_OK;
> +
> +	__bio_for_each_segment(bvec, &this_bbio->bio, iter, this_bbio->iter) {
>   		unsigned int i, nr_sectors, pgoff;
>
>   		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
>   		pgoff =3D bvec.bv_offset;
>   		for (i =3D 0; i < nr_sectors; i++) {
> -			u64 start =3D bbio->file_offset + bio_offset;
> +			u64 start =3D this_bbio->file_offset + bio_offset;
>
>   			ASSERT(pgoff < PAGE_SIZE);
>   			if (uptodate &&
> -			    (!csum || !check_data_csum(inode, bbio,
> +			    (!csum || !check_data_csum(inode, this_bbio,
>   						       bio_offset, bvec.bv_page,
>   						       pgoff, start))) {
>   				clean_io_failure(fs_info, failure_tree, io_tree,
> @@ -7796,21 +7823,56 @@ static blk_status_t btrfs_check_read_dio_bio(str=
uct btrfs_dio_private *dip,
>   			} else {
>   				blk_status_t ret;
>
> -				ret =3D btrfs_repair_one_sector(inode, &bbio->bio,
> -						bio_offset, bvec.bv_page, pgoff,
> -						start, bbio->mirror_num,
> +				atomic_inc(&main_bbio->repair_refs);
> +				ret =3D btrfs_repair_one_sector(inode,
> +						&this_bbio->bio, bio_offset,
> +						bvec.bv_page, pgoff, start,
> +						this_bbio->mirror_num,
>   						submit_dio_repair_bio,
> -						bbio->bio.bi_private,
> -						bbio->bio.bi_end_io);
> -				if (ret)
> -					err =3D ret;
> +						main_bbio,
> +						btrfs_dio_repair_end_io);
> +				if (ret) {
> +					main_bbio->bio.bi_status =3D ret;
> +					atomic_dec(&main_bbio->repair_refs);
> +				}
>   			}
>   			ASSERT(bio_offset + sectorsize > bio_offset);
>   			bio_offset +=3D sectorsize;
>   			pgoff +=3D sectorsize;
>   		}
>   	}
> -	return err;
> +
> +	if (atomic_dec_and_test(&main_bbio->repair_refs)) {
> +		unlock_extent(&BTRFS_I(inode)->io_tree, main_bbio->file_offset,
> +			main_bbio->file_offset + main_bbio->iter.bi_size - 1);
> +		iomap_dio_bio_end_io(&main_bbio->bio);
> +	}
> +}
> +
> +static void btrfs_dio_bio_end_io(struct bio *bio)
> +{
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> +	struct btrfs_inode *bi =3D BTRFS_I(bbio->inode);
> +
> +	if (bio->bi_status) {
> +		btrfs_warn(bi->root->fs_info,
> +			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d"=
,
> +			   btrfs_ino(bi), bio_op(bio), bio->bi_opf,
> +			   bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
> +			   bio->bi_status);
> +	}
> +
> +	if (bio_op(bio) =3D=3D REQ_OP_READ) {
> +		atomic_set(&bbio->repair_refs, 1);
> +		btrfs_end_read_dio_bio(bbio, bbio);
> +	} else {
> +		btrfs_record_physical_zoned(bbio->inode, bbio->file_offset,
> +					    bio);
> +		__endio_write_update_ordered(bi, bbio->file_offset,
> +					     bbio->iter.bi_size,
> +					     !bio->bi_status);
> +		iomap_dio_bio_end_io(bio);
> +	}
>   }
>
>   static void __endio_write_update_ordered(struct btrfs_inode *inode,
> @@ -7829,47 +7891,47 @@ static void btrfs_submit_bio_start_direct_io(str=
uct btrfs_work *work)
>   			&bbio->bio, bbio->file_offset, 1);
>   }
>
> -static void btrfs_end_dio_bio(struct bio *bio)
> +/*
> + * If we are submitting more than one bio, submit them all asynchronous=
ly.  The
> + * exception is RAID 5 or 6, as asynchronous checksums make it difficul=
t to
> + * collect full stripe writes.
> + */
> +static bool btrfs_dio_allow_async_write(struct btrfs_fs_info *fs_info,
> +		struct btrfs_inode *bi)
>   {
> -	struct btrfs_dio_private *dip =3D bio->bi_private;
> -	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> -	blk_status_t err =3D bio->bi_status;
> -
> -	if (err)
> -		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
> -			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d"=
,
> -			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
> -			   bio->bi_opf, bio->bi_iter.bi_sector,
> -			   bio->bi_iter.bi_size, err);
> -
> -	if (bio_op(bio) =3D=3D REQ_OP_READ)
> -		err =3D btrfs_check_read_dio_bio(dip, bbio, !err);
> -
> -	if (err)
> -		dip->dio_bio->bi_status =3D err;
> -
> -	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
> -
> -	bio_put(bio);
> -	btrfs_dio_private_put(dip);
> +	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
> +		return false;
> +	if (atomic_read(&bi->sync_writers))
> +		return false;
> +	return true;
>   }
>
> -static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
> -		struct inode *inode, u64 file_offset, int async_submit)
> +static void btrfs_dio_submit_io(const struct iomap_iter *iter,
> +		struct bio *bio, loff_t file_offset, bool more)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	struct btrfs_inode *bi =3D BTRFS_I(inode);
> -	struct btrfs_dio_private *dip =3D bio->bi_private;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(iter->inode->i_sb);
> +	struct btrfs_inode *bi =3D BTRFS_I(iter->inode);
>   	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	blk_status_t ret;
>
> +	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +	bbio->inode =3D iter->inode;
> +	bbio->file_offset =3D file_offset;
> +	bbio->iter =3D bio->bi_iter;
> +	bio->bi_end_io =3D btrfs_dio_bio_end_io;
> +
>   	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> +			ret =3D extract_ordered_extent(bi, bio, file_offset);
> +			if (ret)
> +				goto out_err;
> +		}
> +
>   		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
> -			/* See btrfs_submit_data_bio for async submit rules */
> -			if (async_submit && !atomic_read(&bi->sync_writers)) {
> +			if (more && btrfs_dio_allow_async_write(fs_info, bi)) {
>   				btrfs_submit_bio_async(bbio,
>   					btrfs_submit_bio_start_direct_io);
> -				return BLK_STS_OK;
> +				return;
>   			}
>
>   			/*
> @@ -7878,189 +7940,36 @@ static inline blk_status_t btrfs_submit_dio_bio=
(struct bio *bio,
>   			 */
>   			ret =3D btrfs_csum_one_bio(bi, bio, file_offset, 1);
>   			if (ret)
> -				return ret;
> +				goto out_err;
>   		}
>   	} else {
>   		bbio->end_io_type =3D BTRFS_ENDIO_WQ_DATA_READ;
>
> -		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
> -			u64 csum_offset;
> -
> -			csum_offset =3D file_offset - dip->file_offset;
> -			csum_offset >>=3D fs_info->sectorsize_bits;
> -			csum_offset *=3D fs_info->csum_size;
> -			btrfs_bio(bio)->csum =3D dip->csums + csum_offset;
> -		}
> -	}
> -
> -	return btrfs_map_bio(fs_info, bio, 0);
> -}
> -
> -/*
> - * If this succeeds, the btrfs_dio_private is responsible for cleaning =
up locked
> - * or ordered extents whether or not we submit any bios.
> - */
> -static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *d=
io_bio,
> -							  struct inode *inode,
> -							  loff_t file_offset)
> -{
> -	const bool write =3D (btrfs_op(dio_bio) =3D=3D BTRFS_MAP_WRITE);
> -	const bool csum =3D !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
> -	size_t dip_size;
> -	struct btrfs_dio_private *dip;
> -
> -	dip_size =3D sizeof(*dip);
> -	if (!write && csum) {
> -		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -		size_t nblocks;
> -
> -		nblocks =3D dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
> -		dip_size +=3D fs_info->csum_size * nblocks;
> -	}
> -
> -	dip =3D kzalloc(dip_size, GFP_NOFS);
> -	if (!dip)
> -		return NULL;
> -
> -	dip->inode =3D inode;
> -	dip->file_offset =3D file_offset;
> -	dip->bytes =3D dio_bio->bi_iter.bi_size;
> -	dip->disk_bytenr =3D dio_bio->bi_iter.bi_sector << 9;
> -	dip->dio_bio =3D dio_bio;
> -	refcount_set(&dip->refs, 1);
> -	return dip;
> -}
> -
> -static void btrfs_submit_direct(const struct iomap_iter *iter,
> -		struct bio *dio_bio, loff_t file_offset, bool more)
> -{
> -	struct inode *inode =3D iter->inode;
> -	const bool write =3D (btrfs_op(dio_bio) =3D=3D BTRFS_MAP_WRITE);
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	const bool raid56 =3D (btrfs_data_alloc_profile(fs_info) &
> -			     BTRFS_BLOCK_GROUP_RAID56_MASK);
> -	struct btrfs_dio_private *dip;
> -	struct bio *bio;
> -	u64 start_sector;
> -	int async_submit =3D 0;
> -	u64 submit_len;
> -	u64 clone_offset =3D 0;
> -	u64 clone_len;
> -	blk_status_t status;
> -	struct btrfs_dio_data *dio_data =3D iter->private;
> -	u64 len;
> -
> -	dip =3D btrfs_create_dio_private(dio_bio, inode, file_offset);
> -	if (!dip) {
> -		if (!write) {
> -			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
> -				file_offset + dio_bio->bi_iter.bi_size - 1);
> -		}
> -		dio_bio->bi_status =3D BLK_STS_RESOURCE;
> -		bio_endio(dio_bio);
> -		return;
> -	}
> -
> -	if (!write) {
> -		/*
> -		 * Load the csums up front to reduce csum tree searches and
> -		 * contention when submitting bios.
> -		 *
> -		 * If we have csums disabled this will do nothing.
> -		 */
> -		status =3D btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
> -		if (status !=3D BLK_STS_OK)
> +		ret =3D btrfs_lookup_bio_sums(iter->inode, bio, NULL);
> +		if (ret)
>   			goto out_err;
>   	}
>
> -	start_sector =3D dio_bio->bi_iter.bi_sector;
> -	submit_len =3D dio_bio->bi_iter.bi_size;
> -
> -	do {
> -		struct block_device *bdev;
> -
> -		bdev =3D btrfs_get_stripe_info(fs_info, btrfs_op(dio_bio),
> -				      start_sector << 9, submit_len, &len);
> -		if (IS_ERR(bdev)) {
> -			status =3D errno_to_blk_status(PTR_ERR(bdev));
> -			goto out_err;
> -		}
> -
> -		clone_len =3D min(submit_len, len);
> -		ASSERT(clone_len <=3D UINT_MAX);
> -
> -		/*
> -		 * This will never fail as it's passing GPF_NOFS and
> -		 * the allocation is backed by btrfs_bioset.
> -		 */
> -		bio =3D btrfs_bio_clone_partial(inode, dio_bio, clone_offset,
> -					      clone_len);
> -		bio->bi_private =3D dip;
> -		bio->bi_end_io =3D btrfs_end_dio_bio;
> -		btrfs_bio(bio)->file_offset =3D file_offset;
> -
> -		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> -			status =3D extract_ordered_extent(BTRFS_I(inode), bio,
> -							file_offset);
> -			if (status) {
> -				bio_put(bio);
> -				goto out_err;
> -			}
> -		}
> -
> -		ASSERT(submit_len >=3D clone_len);
> -		submit_len -=3D clone_len;
> -
> -		/*
> -		 * Increase the count before we submit the bio so we know
> -		 * the end IO handler won't happen before we increase the
> -		 * count. Otherwise, the dip might get freed before we're
> -		 * done setting it up.
> -		 *
> -		 * We transfer the initial reference to the last bio, so we
> -		 * don't need to increment the reference count for the last one.
> -		 */
> -		if (submit_len > 0) {
> -			refcount_inc(&dip->refs);
> -			/*
> -			 * If we are submitting more than one bio, submit them
> -			 * all asynchronously. The exception is RAID 5 or 6, as
> -			 * asynchronous checksums make it difficult to collect
> -			 * full stripe writes.
> -			 */
> -			if (!raid56)
> -				async_submit =3D 1;
> -		}
> -
> -		status =3D btrfs_submit_dio_bio(bio, inode, file_offset,
> -						async_submit);
> -		if (status) {
> -			bio_put(bio);
> -			if (submit_len > 0)
> -				refcount_dec(&dip->refs);
> -			goto out_err;
> -		}
> +	ret =3D btrfs_map_bio(fs_info, bio, 0);
> +	if (ret)
> +		goto out_err;
>
> -		dio_data->submitted +=3D clone_len;
> -		clone_offset +=3D clone_len;
> -		start_sector +=3D clone_len >> 9;
> -		file_offset +=3D clone_len;
> -	} while (submit_len > 0);
>   	return;
>
>   out_err:
> -	dip->dio_bio->bi_status =3D status;
> -	btrfs_dio_private_put(dip);
> +	bio->bi_status =3D ret;
> +	bio_endio(bio);
>   }
>
>   static const struct iomap_dio_ops btrfs_dio_ops =3D {
> -	.submit_io		=3D btrfs_submit_direct,
> +	.submit_io		=3D btrfs_dio_submit_io,
> +	.bio_set		=3D &btrfs_bioset,
>   };
>
>   ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   		size_t done_before)
>   {
> -	struct btrfs_dio_data data;
> +	struct btrfs_dio_data data =3D {};
>
>   	iocb->private =3D &data;
>   	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c6425760f69da..e9d775398141b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -341,6 +341,7 @@ struct btrfs_bio {
>
>   	/* for direct I/O */
>   	u64 file_offset;
> +	atomic_t repair_refs;
>
>   	/* @device is for stripe IO submission. */
>   	struct btrfs_device *device;
