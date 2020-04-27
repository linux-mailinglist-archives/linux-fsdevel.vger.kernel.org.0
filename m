Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269FF1BA2F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgD0LxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0LxM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C021AAC5F;
        Mon, 27 Apr 2020 11:53:09 +0000 (UTC)
Subject: Re: [PATCH v8 02/11] block: provide fallbacks for
 blk_queue_zone_is_seq and blk_queue_zone_no
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-3-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3f03e7b7-77ad-eff5-5e97-a4436eb0500a@suse.de>
Date:   Mon, 27 Apr 2020 13:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
> blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
> CONFIG_BLK_DEV_ZONED disabled until now.
> 
> The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
> provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/blkdev.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f00bd4042295..91c6e413bf6b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -721,6 +721,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>   {
>   	return 0;
>   }
> +static inline bool blk_queue_zone_is_seq(struct request_queue *q,
> +					 sector_t sector)
> +{
> +	return false;
> +}
> +static inline unsigned int blk_queue_zone_no(struct request_queue *q,
> +					     sector_t sector)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_BLK_DEV_ZONED */
>   
>   static inline bool rq_is_sync(struct request *rq)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
