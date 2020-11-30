Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115B32C7E76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgK3HJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:09:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgK3HJT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:09:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 205A9AC55;
        Mon, 30 Nov 2020 07:08:37 +0000 (UTC)
Subject: Re: [PATCH 08/45] dm: simplify flush_bio initialization in
 __send_empty_flush
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8e58e368-5772-6d97-06d0-f58346cc1865@suse.de>
Date:   Mon, 30 Nov 2020 08:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> We don't really need the struct block_device to initialize a bio.  So
> switch from using bio_set_dev to manually setting up bi_disk (bi_partno
> will always be zero and has been cleared by bio_init already).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>
> ---
>   drivers/md/dm.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 50541d336c719b..ab0a8335f098d9 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1422,18 +1422,12 @@ static int __send_empty_flush(struct clone_info *ci)
>   	 */
>   	bio_init(&flush_bio, NULL, 0);
>   	flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
> +	flush_bio.bi_disk = ci->io->md->disk;
> +	bio_associate_blkg(&flush_bio);
> +
>   	ci->bio = &flush_bio;
>   	ci->sector_count = 0;
>   
> -	/*
> -	 * Empty flush uses a statically initialized bio, as the base for
> -	 * cloning.  However, blkg association requires that a bdev is
> -	 * associated with a gendisk, which doesn't happen until the bdev is
> -	 * opened.  So, blkg association is done at issue time of the flush
> -	 * rather than when the device is created in alloc_dev().
> -	 */
> -	bio_set_dev(ci->bio, ci->io->md->bdev);
> -
>   	BUG_ON(bio_has_data(ci->bio));
>   	while ((ti = dm_table_get_target(ci->map, target_nr++)))
>   		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
