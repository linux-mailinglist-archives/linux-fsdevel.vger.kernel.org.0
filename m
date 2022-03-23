Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7F4E4A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiCWA6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiCWA6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:58:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9723B22B32;
        Tue, 22 Mar 2022 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647997028;
        bh=57arried7sbe+HDIzxAWn822gqQrZaz/GzT5YCt5yuA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YpFZSjS08QB5QlG0DbkZwXVoAc2WVCr7eUORIJ7c/Ujyyn3Sf/Qr1CyOxpLLR2ZCo
         IFd6IkAcNogGV5RKOQEL0NoBm5MzVqKfPLOUIhDFlX+6i/46NR4/4jx/cIJGpArOir
         4DKNtGKVebeR2qK/LbA46s/NeVNYK/JYAChtHusY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1nLWtk2KKJ-00BpGD; Wed, 23
 Mar 2022 01:57:08 +0100
Message-ID: <1c79e3ba-b9eb-d0df-748a-438abe705384@gmx.com>
Date:   Wed, 23 Mar 2022 08:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 24/40] btrfs: remove btrfs_end_io_wq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-25-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-25-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kZqWZLJq4/wwLq+PLqRhyT+ZBEUsb5O4lQ0tOCjEVaQh2FIVDys
 6ce2+asYGCdgAzYyZGn9hdsZi4aRgvn1TPxCBFadiMJflPmX+RiReS5tgELllo+itiI9jEr
 qa9huFyvTJ3FFVHyyeW83tqRooRzg4s4btjP6mJ6pDgoe3eaoWz949SJmsZftIZvZW03M8Z
 Tf0rzDSTvaCHsfdV09b7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1aJZEyVjMI=:86KoRTq8qk6g+RiT7UZRti
 nmjg0RDed6Dz0A7OqWPY03EoK3flysEdZyhgdnRjTeARSykX1RBUGwz3ZmBRvHTGZdVWQzo0J
 qJw9oEac9x2W1J0hkSqQWz+FminpPxYspQd//E6fYDg6cgBkOxTUHerF8Gq3yFPv+XZtUuiJD
 zk/ezUsveewRyDDID/c71OfqkZCEu/alptixZ5U9b8H5yJugeD2Rs8l78CLcGaBvwYknMPvxi
 WmbOpoR4swh8YzUJEJPcalkZPUjwIu6ri8gzfdKRvc7Eok6CQjsqOP/wpwnQPI2rZqo7/eWhR
 Ow7zhyEx0x/zLnwGwEXhQgRLIteT8VEcMWap+KHZjBo8CA17J0EgAmjGGWyxqi+UkNQz6GTYP
 22TewWZMOqgMIOVprW9N8LrrrGmwnTbuTt47bG6U4OUwAPmZ8fUYeliMtUdgDSVxli1qcAvuF
 eYLlK/ntxBivmoK2rH9r/mXZ0sv+Xel79PW93OqV4xosPvLUes5Z5vzvf+hSmtwe6GUqeElYz
 w17MpjRm44DTiR+NkymVWEMMXOhbyZSACPU8yjs2U4iVJw+IqRPfRWd6G44fHJKN8j5ZuLLMF
 GWMXB558ourEu492fdsNjo3SQZInPuIG7bhAobHGFQ4amGU7x8JF0tQjLQLKZLPJbqsllDXE1
 xbj0WA3B5fynn5oTOinVuKealDO7UTXkxEv0WeQHsnZWsObKHW7MwF4pasJLiKbVElMIX0lUD
 e8vQyJNlxqu2T70vfGpr3XDU9crbA0bLbDzhjrl6ILMvO3cypThlW/cAl1Xv/tIb4SWjJDlHD
 fIF0H0J5w4vEh9N7sSmeu2WZXdOfpQ5XXjddvhCAvXUt9G6L75q8UsxO62+Vxvq/tpiTwksRR
 t2E4ENjCL+aK41pUuiZu8yinyg8fU7qQXPtJ1tc3ErnoG+DPb8xaQtF13VbCO6CpuI4K6VmgY
 Rolrx0S5JZVUIoW0lhNcQ2U0hjr9HxmeYmG+EPpYQ1CcCeQd2qqVRDTBPW0kmwrh6MkwXqWx+
 CKDFAA38fDO5dBAOtzUlIVO6N2swlPupJEBAqBegFUjjkjHU+wb68opAVDVmDZ6UPE4P3G7cK
 fcxz1oOLQS7THo=
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
> Avoid the extra allocation for all read bios by embedding a btrfs_work
> and I/O end type into the btrfs_bio structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do we really need to bump the size of btrfs_bio furthermore?

Especially btrfs_bio is allocated for each 64K stripe...

Thanks,
Qu
> ---
>   fs/btrfs/compression.c |  24 +++------
>   fs/btrfs/ctree.h       |   1 -
>   fs/btrfs/disk-io.c     | 112 +----------------------------------------
>   fs/btrfs/disk-io.h     |  10 ----
>   fs/btrfs/inode.c       |  19 +++----
>   fs/btrfs/super.c       |  11 +---
>   fs/btrfs/volumes.c     |  44 ++++++++++++++--
>   fs/btrfs/volumes.h     |  11 ++++
>   8 files changed, 66 insertions(+), 166 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 419a09d924290..ae6f986058c75 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -423,20 +423,6 @@ static void end_compressed_bio_write(struct bio *bi=
o)
>   	bio_put(bio);
>   }
>
> -static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info=
,
> -					  struct compressed_bio *cb,
> -					  struct bio *bio, int mirror_num)
> -{
> -	blk_status_t ret;
> -
> -	ASSERT(bio->bi_iter.bi_size);
> -	ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		return ret;
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	return ret;
> -}
> -
>   /*
>    * Allocate a compressed_bio, which will be used to read/write on-disk
>    * (aka, compressed) * data.
> @@ -468,6 +454,10 @@ static struct bio *alloc_compressed_bio(struct comp=
ressed_bio *cb, u64 disk_byte
>   	bio->bi_iter.bi_sector =3D disk_bytenr >> SECTOR_SHIFT;
>   	bio->bi_private =3D cb;
>   	bio->bi_end_io =3D endio_func;
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> +		btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_WRITE;
> +	else
> +		btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_READ;
>
>   	em =3D btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize)=
;
>   	if (IS_ERR(em)) {
> @@ -594,7 +584,8 @@ blk_status_t btrfs_submit_compressed_write(struct bt=
rfs_inode *inode, u64 start,
>   					goto finish_cb;
>   			}
>
> -			ret =3D submit_compressed_bio(fs_info, cb, bio, 0);
> +			ASSERT(bio->bi_iter.bi_size);
> +			ret =3D btrfs_map_bio(fs_info, bio, 0);
>   			if (ret)
>   				goto finish_cb;
>   			bio =3D NULL;
> @@ -930,7 +921,8 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>   						  fs_info->sectorsize);
>   			sums +=3D fs_info->csum_size * nr_sectors;
>
> -			ret =3D submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
> +			ASSERT(comp_bio->bi_iter.bi_size);
> +			ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
>   			if (ret)
>   				goto finish_cb;
>   			comp_bio =3D NULL;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ebb2d109e8bb2..c22a24ca81652 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -823,7 +823,6 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *endio_meta_workers;
>   	struct btrfs_workqueue *endio_raid56_workers;
>   	struct btrfs_workqueue *rmw_workers;
> -	struct btrfs_workqueue *endio_meta_write_workers;
>   	struct btrfs_workqueue *endio_write_workers;
>   	struct btrfs_workqueue *endio_freespace_worker;
>   	struct btrfs_workqueue *caching_workers;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f43c9ab86e617..bb910b78bbc82 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -51,7 +51,6 @@
>   				 BTRFS_SUPER_FLAG_METADUMP |\
>   				 BTRFS_SUPER_FLAG_METADUMP_V2)
>
> -static void end_workqueue_fn(struct btrfs_work *work);
>   static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
>   static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>   				      struct btrfs_fs_info *fs_info);
> @@ -64,40 +63,6 @@ static int btrfs_destroy_pinned_extent(struct btrfs_f=
s_info *fs_info,
>   static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
>   static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
>
> -/*
> - * btrfs_end_io_wq structs are used to do processing in task context wh=
en an IO
> - * is complete.  This is used during reads to verify checksums, and it =
is used
> - * by writes to insert metadata for new file extents after IO is comple=
te.
> - */
> -struct btrfs_end_io_wq {
> -	struct bio *bio;
> -	bio_end_io_t *end_io;
> -	void *private;
> -	struct btrfs_fs_info *info;
> -	blk_status_t status;
> -	enum btrfs_wq_endio_type metadata;
> -	struct btrfs_work work;
> -};
> -
> -static struct kmem_cache *btrfs_end_io_wq_cache;
> -
> -int __init btrfs_end_io_wq_init(void)
> -{
> -	btrfs_end_io_wq_cache =3D kmem_cache_create("btrfs_end_io_wq",
> -					sizeof(struct btrfs_end_io_wq),
> -					0,
> -					SLAB_MEM_SPREAD,
> -					NULL);
> -	if (!btrfs_end_io_wq_cache)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void __cold btrfs_end_io_wq_exit(void)
> -{
> -	kmem_cache_destroy(btrfs_end_io_wq_cache);
> -}
> -
>   static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
>   {
>   	if (fs_info->csum_shash)
> @@ -726,54 +691,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio=
 *bbio,
>   	return ret;
>   }
>
> -static void end_workqueue_bio(struct bio *bio)
> -{
> -	struct btrfs_end_io_wq *end_io_wq =3D bio->bi_private;
> -	struct btrfs_fs_info *fs_info;
> -	struct btrfs_workqueue *wq;
> -
> -	fs_info =3D end_io_wq->info;
> -	end_io_wq->status =3D bio->bi_status;
> -
> -	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> -		if (end_io_wq->metadata =3D=3D BTRFS_WQ_ENDIO_METADATA)
> -			wq =3D fs_info->endio_meta_write_workers;
> -		else if (end_io_wq->metadata =3D=3D BTRFS_WQ_ENDIO_FREE_SPACE)
> -			wq =3D fs_info->endio_freespace_worker;
> -		else
> -			wq =3D fs_info->endio_write_workers;
> -	} else {
> -		if (end_io_wq->metadata)
> -			wq =3D fs_info->endio_meta_workers;
> -		else
> -			wq =3D fs_info->endio_workers;
> -	}
> -
> -	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
> -	btrfs_queue_work(wq, &end_io_wq->work);
> -}
> -
> -blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio=
 *bio,
> -			enum btrfs_wq_endio_type metadata)
> -{
> -	struct btrfs_end_io_wq *end_io_wq;
> -
> -	end_io_wq =3D kmem_cache_alloc(btrfs_end_io_wq_cache, GFP_NOFS);
> -	if (!end_io_wq)
> -		return BLK_STS_RESOURCE;
> -
> -	end_io_wq->private =3D bio->bi_private;
> -	end_io_wq->end_io =3D bio->bi_end_io;
> -	end_io_wq->info =3D info;
> -	end_io_wq->status =3D 0;
> -	end_io_wq->bio =3D bio;
> -	end_io_wq->metadata =3D metadata;
> -
> -	bio->bi_private =3D end_io_wq;
> -	bio->bi_end_io =3D end_workqueue_bio;
> -	return 0;
> -}
> -
>   static void run_one_async_start(struct btrfs_work *work)
>   {
>   	struct async_submit_bio *async;
> @@ -921,10 +838,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode=
 *inode, struct bio *bio,
>   			return ret;
>   	} else {
>   		/* checksum validation should happen in async threads: */
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> -					  BTRFS_WQ_ENDIO_METADATA);
> -		if (ret)
> -			return ret;
> +		btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_METADATA_READ;
>   	}
>
>   	return btrfs_map_bio(fs_info, bio, mirror_num);
> @@ -1888,25 +1802,6 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(=
struct btrfs_fs_info *fs_info,
>   	return root;
>   }
>
> -/*
> - * called by the kthread helper functions to finally call the bio end_i=
o
> - * functions.  This is where read checksum verification actually happen=
s
> - */
> -static void end_workqueue_fn(struct btrfs_work *work)
> -{
> -	struct bio *bio;
> -	struct btrfs_end_io_wq *end_io_wq;
> -
> -	end_io_wq =3D container_of(work, struct btrfs_end_io_wq, work);
> -	bio =3D end_io_wq->bio;
> -
> -	bio->bi_status =3D end_io_wq->status;
> -	bio->bi_private =3D end_io_wq->private;
> -	bio->bi_end_io =3D end_io_wq->end_io;
> -	bio_endio(bio);
> -	kmem_cache_free(btrfs_end_io_wq_cache, end_io_wq);
> -}
> -
>   static int cleaner_kthread(void *arg)
>   {
>   	struct btrfs_root *root =3D arg;
> @@ -2219,7 +2114,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs=
_info *fs_info)
>   	 * queues can do metadata I/O operations.
>   	 */
>   	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
> -	btrfs_destroy_workqueue(fs_info->endio_meta_write_workers);
>   }
>
>   static void free_root_extent_buffers(struct btrfs_root *root)
> @@ -2404,9 +2298,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_i=
nfo *fs_info)
>   	fs_info->endio_meta_workers =3D
>   		btrfs_alloc_workqueue(fs_info, "endio-meta", flags,
>   				      max_active, 4);
> -	fs_info->endio_meta_write_workers =3D
> -		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
> -				      max_active, 2);
>   	fs_info->endio_raid56_workers =3D
>   		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
>   				      max_active, 4);
> @@ -2429,7 +2320,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_i=
nfo *fs_info)
>   	if (!(fs_info->workers && fs_info->delalloc_workers &&
>   	      fs_info->flush_workers &&
>   	      fs_info->endio_workers && fs_info->endio_meta_workers &&
> -	      fs_info->endio_meta_write_workers &&
>   	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &=
&
>   	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
>   	      fs_info->caching_workers && fs_info->fixup_workers &&
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index afe3bb96616c9..e8900c1b71664 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -17,12 +17,6 @@
>    */
>   #define BTRFS_BDEV_BLOCKSIZE	(4096)
>
> -enum btrfs_wq_endio_type {
> -	BTRFS_WQ_ENDIO_DATA,
> -	BTRFS_WQ_ENDIO_METADATA,
> -	BTRFS_WQ_ENDIO_FREE_SPACE,
> -};
> -
>   static inline u64 btrfs_sb_offset(int mirror)
>   {
>   	u64 start =3D SZ_16K;
> @@ -119,8 +113,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf,=
 u64 parent_transid,
>   			  int atomic);
>   int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, i=
nt level,
>   		      struct btrfs_key *first_key);
> -blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio=
 *bio,
> -			enum btrfs_wq_endio_type metadata);
>   blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
>   				 int mirror_num, unsigned long bio_flags,
>   				 u64 dio_file_offset,
> @@ -144,8 +136,6 @@ int btree_lock_page_hook(struct page *page, void *da=
ta,
>   int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
>   int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
>   int btrfs_init_root_free_objectid(struct btrfs_root *root);
> -int __init btrfs_end_io_wq_init(void);
> -void __cold btrfs_end_io_wq_exit(void);
>
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   void btrfs_set_buffer_lockdep_class(u64 objectid,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 18d54cfedf829..5a5474fac0b28 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2512,6 +2512,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *i=
node, struct bio *bio,
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct btrfs_inode *bi =3D BTRFS_I(inode);
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	blk_status_t ret;
>
>   	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> @@ -2537,14 +2538,10 @@ blk_status_t btrfs_submit_data_bio(struct inode =
*inode, struct bio *bio,
>   		if (ret)
>   			return ret;
>   	} else {
> -		enum btrfs_wq_endio_type metadata =3D BTRFS_WQ_ENDIO_DATA;
> -embedding a btrfs_work
and I/O end type
>   		if (btrfs_is_free_space_inode(bi))
> -			metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> -
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio, metadata);
> -		if (ret)
> -			return ret;
> +			bbio->end_io_type =3D BTRFS_ENDIO_WQ_FREE_SPACE_READ;
> +		else
> +			bbio->end_io_type =3D BTRFS_ENDIO_WQ_DATA_READ;
>
>   		if (bio_flags & EXTENT_BIO_COMPRESSED)
>   			return btrfs_submit_compressed_read(inode, bio,
> @@ -7739,9 +7736,7 @@ static blk_status_t submit_dio_repair_bio(struct i=
node *inode, struct bio *bio,
>
>   	BUG_ON(bio_op(bio) =3D=3D REQ_OP_WRITE);
>
> -	ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		return ret;
> +	btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_WRITE;
>
>   	refcount_inc(&dip->refs);
>   	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> @@ -7865,9 +7860,7 @@ static inline blk_status_t btrfs_submit_dio_bio(st=
ruct bio *bio,
>   				return ret;
>   		}
>   	} else {
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -		if (ret)
> -			return ret;
> +		btrfs_bio(bio)->end_io_type =3D BTRFS_ENDIO_WQ_DATA_READ;
>
>   		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
>   			u64 csum_offset;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4d947ba32da9d..33dedca4f0862 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1835,8 +1835,6 @@ static void btrfs_resize_thread_pool(struct btrfs_=
fs_info *fs_info,
>   	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_meta_write_workers,
> -				new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_siz=
e);
>   	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
> @@ -2593,13 +2591,9 @@ static int __init init_btrfs_fs(void)
>   	if (err)
>   		goto free_delayed_ref;
>
> -	err =3D btrfs_end_io_wq_init();
> -	if (err)
> -		goto free_prelim_ref;
> -
>   	err =3D btrfs_interface_init();
>   	if (err)
> -		goto free_end_io_wq;
> +		goto free_prelim_ref;
>
>   	btrfs_print_mod_info();
>
> @@ -2615,8 +2609,6 @@ static int __init init_btrfs_fs(void)
>
>   unregister_ioctl:
>   	btrfs_interface_exit();
> -free_end_io_wq:
> -	btrfs_end_io_wq_exit();
>   free_prelim_ref:
>   	btrfs_prelim_ref_exit();
>   free_delayed_ref:
> @@ -2654,7 +2646,6 @@ static void __exit exit_btrfs_fs(void)
>   	extent_state_cache_exit();
>   	extent_io_exit();
>   	btrfs_interface_exit();
> -	btrfs_end_io_wq_exit();
>   	unregister_filesystem(&btrfs_fs_type);
>   	btrfs_exit_sysfs();
>   	btrfs_cleanup_fs_uuids();
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9d1f8c27eff33..9a1eb1166d72f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6659,11 +6659,38 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>   	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1=
);
>   }
>
> -static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
> +static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_io_context =
*bioc)
>   {
> +	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> +
> +	switch (btrfs_bio(bioc->orig_bio)->end_io_type) {
> +	case BTRFS_ENDIO_WQ_DATA_READ:
> +		return fs_info->endio_workers;
> +	case BTRFS_ENDIO_WQ_DATA_WRITE:
> +		return fs_info->endio_write_workers;
> +	case BTRFS_ENDIO_WQ_METADATA_READ:
> +		return fs_info->endio_meta_workers;
> +	case BTRFS_ENDIO_WQ_FREE_SPACE_READ:
> +		return fs_info->endio_freespace_worker;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static void btrfs_end_bio_work(struct btrfs_work *work)
> +{
> +	struct btrfs_bio *bbio =3D container_of(work, struct btrfs_bio, work);
> +
> +	bio_endio(&bbio->bio);
> +}
> +
> +static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
> +{
> +	struct btrfs_workqueue *wq =3D async ? btrfs_end_io_wq(bioc) : NULL;
>   	struct bio *bio =3D bioc->orig_bio;
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>
> -	btrfs_bio(bio)->mirror_num =3D bioc->mirror_num;
> +	bbio->mirror_num =3D bioc->mirror_num;
>   	bio->bi_private =3D bioc->private;
>   	bio->bi_end_io =3D bioc->end_io;
>
> @@ -6675,7 +6702,14 @@ static inline void btrfs_end_bioc(struct btrfs_io=
_context *bioc)
>   		bio->bi_status =3D BLK_STS_IOERR;
>   	else
>   		bio->bi_status =3D BLK_STS_OK;
> -	bio_endio(bio);
> +
> +	if (wq) {
> +		btrfs_init_work(&bbio->work, btrfs_end_bio_work, NULL, NULL);
> +		btrfs_queue_work(wq, &bbio->work);
> +	} else {
> +		bio_endio(bio);
> +	}
> +
>   	btrfs_put_bioc(bioc);
>   }
>
> @@ -6707,7 +6741,7 @@ static void btrfs_end_bio(struct bio *bio)
>
>   	btrfs_bio_counter_dec(bioc->fs_info);
>   	if (atomic_dec_and_test(&bioc->stripes_pending))
> -		btrfs_end_bioc(bioc);
> +		btrfs_end_bioc(bioc, true);
>   }
>
>   static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bi=
o *bio,
> @@ -6805,7 +6839,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
>   			atomic_inc(&bioc->error);
>   			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc);
> +				btrfs_end_bioc(bioc, false);
>   			continue;
>   		}
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index a4f942547002e..51a27180004eb 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -315,6 +315,14 @@ struct btrfs_fs_devices {
>   				- 2 * sizeof(struct btrfs_chunk))	\
>   				/ sizeof(struct btrfs_stripe) + 1)
>
> +enum btrfs_endio_type {
> +	BTRFS_ENDIO_NONE =3D 0,
> +	BTRFS_ENDIO_WQ_DATA_READ,
> +	BTRFS_ENDIO_WQ_DATA_WRITE,
> +	BTRFS_ENDIO_WQ_METADATA_READ,
> +	BTRFS_ENDIO_WQ_FREE_SPACE_READ,
> +};
> +
>   /*
>    * Additional info to pass along bio.
>    *
> @@ -324,6 +332,9 @@ struct btrfs_bio {
>   	struct inode *inode;
>
>   	unsigned int mirror_num;
> +
> +	enum btrfs_endio_type end_io_type;
> +	struct btrfs_work work;
>
>   	/* for direct I/O */
>   	u64 file_offset;
