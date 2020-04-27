Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD01BA405
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgD0Mx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:53:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgD0Mx1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:53:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34D8DAA55;
        Mon, 27 Apr 2020 12:53:25 +0000 (UTC)
Subject: Re: [PATCH v8 07/11] scsi: sd_zbc: factor out sanity checks for zoned
 commands
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
 <20200427113153.31246-8-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8b936d56-c7a6-50ad-3a71-6e41f403a047@suse.de>
Date:   Mon, 27 Apr 2020 14:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-8-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
> Factor sanity checks for zoned commands from sd_zbc_setup_zone_mgmt_cmnd().
> 
> This will help with the introduction of an emulated ZONE_APPEND command.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/sd_zbc.c | 36 +++++++++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index f45c22b09726..ee156fbf3780 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -209,6 +209,26 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
>   	return ret;
>   }
>   
> +static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
> +{
> +	struct request *rq = cmd->request;
> +	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
> +	sector_t sector = blk_rq_pos(rq);
> +
> +	if (!sd_is_zoned(sdkp))
> +		/* Not a zoned device */
> +		return BLK_STS_IOERR;
> +
> +	if (sdkp->device->changed)
> +		return BLK_STS_IOERR;
> +
> +	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
> +		/* Unaligned request */
> +		return BLK_STS_IOERR;
> +
> +	return BLK_STS_OK;
> +}
> +
>   /**
>    * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
>    *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
> @@ -223,20 +243,14 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>   					 unsigned char op, bool all)
>   {
>   	struct request *rq = cmd->request;
> -	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
>   	sector_t sector = blk_rq_pos(rq);
> +	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
>   	sector_t block = sectors_to_logical(sdkp->device, sector);
> +	blk_status_t ret;
>   
> -	if (!sd_is_zoned(sdkp))
> -		/* Not a zoned device */
> -		return BLK_STS_IOERR;
> -
> -	if (sdkp->device->changed)
> -		return BLK_STS_IOERR;
> -
> -	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
> -		/* Unaligned request */
> -		return BLK_STS_IOERR;
> +	ret = sd_zbc_cmnd_checks(cmd);
> +	if (ret != BLK_STS_OK)
> +		return ret;
>   
>   	cmd->cmd_len = 16;
>   	memset(cmd->cmnd, 0, cmd->cmd_len);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
