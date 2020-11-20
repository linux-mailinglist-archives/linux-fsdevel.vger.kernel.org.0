Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2C2BA3A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgKTHlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:34936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgKTHlV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C348AC23;
        Fri, 20 Nov 2020 07:41:19 +0000 (UTC)
Subject: Re: [PATCH 64/78] dm: simplify flush_bio initialization in
 __send_empty_flush
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-65-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <38ac9782-a563-b7ea-595a-124159fb755d@suse.de>
Date:   Fri, 20 Nov 2020 08:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-65-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> We don't really need the struct block_device to initialize a bio.  So
> switch from using bio_set_dev to manually setting up bi_disk (bi_partno
> will always be zero and has been cleared by bio_init already).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 54739f1b579bc8..6d7eb72d41f9ea 100644
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
Ah, thought as much. I've stumbled across this while debugging 
blk-interposer.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
