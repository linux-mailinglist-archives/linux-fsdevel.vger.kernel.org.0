Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F311C792A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFSQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 14:16:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgEFSQW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 14:16:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 662F1AEC5;
        Wed,  6 May 2020 18:16:23 +0000 (UTC)
Subject: Re: [PATCH v10 1/9] block: rename __bio_add_pc_page to
 bio_add_hw_page
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
 <20200506161145.9841-2-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <df3cc93b-0e71-868a-30a9-dac7048e15b5@suse.de>
Date:   Wed, 6 May 2020 20:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506161145.9841-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/20 6:11 PM, Johannes Thumshirn wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Rename __bio_add_pc_page() to bio_add_hw_page() and explicitly pass in a
> max_sectors argument.
> 
> This max_sectors argument can be used to specify constraints from the
> hardware.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [ jth: rebased and made public for blk-map.c ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/bio.c     | 65 ++++++++++++++++++++++++++++++-------------------
>   block/blk-map.c |  5 ++--
>   block/blk.h     |  4 +--
>   3 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 21cbaa6a1c20..aad0a6dad4f9 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -748,9 +748,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>   	return true;
>   }
>   
> -static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
> -		struct page *page, unsigned len, unsigned offset,
> -		bool *same_page)
> +/*
> + * Try to merge a page into a segment, while obeying the hardware segment
> + * size limit.  This is not for normal read/write bios, but for passthrough
> + * or Zone Append operations that we can't split.
> + */
> +static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
> +				 struct page *page, unsigned len,
> +				 unsigned offset, bool *same_page)
>   {
>   	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>   	unsigned long mask = queue_segment_boundary(q);
> @@ -765,38 +770,32 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
>   }
>   
>   /**
> - *	__bio_add_pc_page	- attempt to add page to passthrough bio
> - *	@q: the target queue
> - *	@bio: destination bio
> - *	@page: page to add
> - *	@len: vec entry length
> - *	@offset: vec entry offset
> - *	@same_page: return if the merge happen inside the same page
> - *
> - *	Attempt to add a page to the bio_vec maplist. This can fail for a
> - *	number of reasons, such as the bio being full or target block device
> - *	limitations. The target block device must allow bio's up to PAGE_SIZE,
> - *	so it is always possible to add a single page to an empty bio.
> + * bio_add_hw_page - attempt to add a page to a bio with hw constraints
> + * @q: the target queue
> + * @bio: destination bio
> + * @page: page to add
> + * @len: vec entry length
> + * @offset: vec entry offset
> + * @max_sectors: maximum number of sectors that can be added
> + * @same_page: return if the segment has been merged inside the same page
>    *
> - *	This should only be used by passthrough bios.
> + * Add a page to a bio while respecting the hardware max_sectors, max_segment
> + * and gap limitations.
>    */
> -int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
> +int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset,
> -		bool *same_page)
> +		unsigned int max_sectors, bool *same_page)
>   {
>   	struct bio_vec *bvec;
>   
> -	/*
> -	 * cloned bio must not modify vec list
> -	 */
> -	if (unlikely(bio_flagged(bio, BIO_CLONED)))
> +	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>   		return 0;
>   
> -	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
> +	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
>   		return 0;
>   
>   	if (bio->bi_vcnt > 0) {
> -		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
> +		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
>   			return len;
>   
>   		/*
> @@ -823,11 +822,27 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
>   	return len;
>   }
>   
> +/**
> + * bio_add_pc_page	- attempt to add page to passthrough bio
> + * @q: the target queue
> + * @bio: destination bio
> + * @page: page to add
> + * @len: vec entry length
> + * @offset: vec entry offset
> + *
> + * Attempt to add a page to the bio_vec maplist. This can fail for a
> + * number of reasons, such as the bio being full or target block device
> + * limitations. The target block device must allow bio's up to PAGE_SIZE,
> + * so it is always possible to add a single page to an empty bio.
> + *
> + * This should only be used by passthrough bios.
> + */
>   int bio_add_pc_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset)
>   {
>   	bool same_page = false;
> -	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
> +	return bio_add_hw_page(q, bio, page, len, offset,
> +			queue_max_hw_sectors(q), &same_page);
>   }
>   EXPORT_SYMBOL(bio_add_pc_page);
>   
> diff --git a/block/blk-map.c b/block/blk-map.c
> index b6fa343fea9f..e3e4ac48db45 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -257,6 +257,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
>   static struct bio *bio_map_user_iov(struct request_queue *q,
>   		struct iov_iter *iter, gfp_t gfp_mask)
>   {
> +	unsigned int max_sectors = queue_max_hw_sectors(q);
>   	int j;
>   	struct bio *bio;
>   	int ret;
> @@ -294,8 +295,8 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
>   				if (n > bytes)
>   					n = bytes;
>   
> -				if (!__bio_add_pc_page(q, bio, page, n, offs,
> -						&same_page)) {
> +				if (!bio_add_hw_page(q, bio, page, n, offs,
> +						     max_sectors, &same_page)) {
>   					if (same_page)
>   						put_page(page);
>   					break;
> diff --git a/block/blk.h b/block/blk.h
> index 73bd3b1c6938..1ae3279df712 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -453,8 +453,8 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
>   
>   struct request_queue *__blk_alloc_queue(int node_id);
>   
> -int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
> +int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset,
> -		bool *same_page);
> +		unsigned int max_sectors, bool *same_page);
>   
>   #endif /* BLK_INTERNAL_H */
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
