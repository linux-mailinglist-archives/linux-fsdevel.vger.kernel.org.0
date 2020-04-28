Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB31BC1D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgD1Oub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 10:50:31 -0400
Received: from smtp.infotech.no ([82.134.31.41]:39951 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgD1Oub (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 18AF020416A;
        Tue, 28 Apr 2020 16:50:27 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 45jL8+zCnOjE; Tue, 28 Apr 2020 16:50:21 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 45F1020414E;
        Tue, 28 Apr 2020 16:50:19 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v9 08/11] scsi: sd_zbc: emulate ZONE_APPEND commands
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <20200428104605.8143-9-johannes.thumshirn@wdc.com>
 <92524364-fdd2-c386-9ac4-e4cbb73751f0@suse.de>
 <SN4PR0401MB35985B7C08A21C15DBD515299BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <8413fd2a-75e6-585e-834a-813c8784f302@interlog.com>
Date:   Tue, 28 Apr 2020 10:50:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35985B7C08A21C15DBD515299BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-28 8:09 a.m., Johannes Thumshirn wrote:
> On 28/04/2020 13:42, Hannes Reinecke wrote:
> [...]
>>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
>>> index 50fff0bf8c8e..6009311105ef 100644
>>> --- a/drivers/scsi/sd.h
>>> +++ b/drivers/scsi/sd.h
>>> @@ -79,6 +79,12 @@ struct scsi_disk {
>>>     	u32		zones_optimal_open;
>>>     	u32		zones_optimal_nonseq;
>>>     	u32		zones_max_open;
>>> +	u32		*zones_wp_ofst;
>>> +	spinlock_t	zones_wp_ofst_lock;
>>> +	u32		*rev_wp_ofst;
>>> +	struct mutex	rev_mutex;
>>> +	struct work_struct zone_wp_ofst_work;
>>> +	char		*zone_wp_update_buf;
>>>     #endif
>>>     	atomic_t	openers;
>>>     	sector_t	capacity;	/* size in logical blocks */
>>
>> 'zones_wp_ofst' ?
>>
>> Please replace the cryptic 'ofst' with 'offset'; those three additional
>> characters don't really make a difference ...
> 
> 'zones_wp_ofst' was good to maintain the 80 chars limit and not end up
> with broken up lines, because we crossed the limit. I'll have a look if
> we can make it 'zones_wp_offset' without uglifying the code.

When stuck like that, I have started using "_o" as in "lba_o" for
LBA's octet offset :-)

Good rule of thumb: if you can't write "a = b + c" (a couple of tab
indentations in) then your variable names are too damn long.

Of course the Linux kernel dictating indent_to_8 and restricting lines
to punched card width doesn't help.

Doug Gilbert

> [...]
> 
>>> @@ -396,11 +633,67 @@ static int sd_zbc_check_capacity(struct scsi_disk *sdkp, unsigned char *buf,
>>>     	return 0;
>>>     }
>>>     
>>> +static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
>>> +{
>>> +	struct scsi_disk *sdkp = scsi_disk(disk);
>>> +
>>> +	swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);
>>> +}
>>> +
>>> +static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,
>>> +				   u32 zone_blocks,
>>> +				   unsigned int nr_zones)
>>> +{
>>> +	struct gendisk *disk = sdkp->disk;
>>> +	int ret = 0;
>>> +
>>> +	/*
>>> +	 * Make sure revalidate zones are serialized to ensure exclusive
>>> +	 * updates of the scsi disk data.
>>> +	 */
>>> +	mutex_lock(&sdkp->rev_mutex);
>>> +
>>> +	/*
>>> +	 * Revalidate the disk zones to update the device request queue zone
>>> +	 * bitmaps and the zone write pointer offset array. Do this only once
>>> +	 * the device capacity is set on the second revalidate execution for
>>> +	 * disk scan or if something changed when executing a normal revalidate.
>>> +	 */
>>> +	if (sdkp->first_scan) {
>>> +		sdkp->zone_blocks = zone_blocks;
>>> +		sdkp->nr_zones = nr_zones;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	if (sdkp->zone_blocks == zone_blocks &&
>>> +	    sdkp->nr_zones == nr_zones &&
>>> +	    disk->queue->nr_zones == nr_zones)
>>> +		goto unlock;
>>> +
>>> +	sdkp->rev_wp_ofst = kvcalloc(nr_zones, sizeof(u32), GFP_NOIO);
>>> +	if (!sdkp->rev_wp_ofst) {
>>> +		ret = -ENOMEM;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
>>> +
>>> +	kvfree(sdkp->rev_wp_ofst);
>>> +	sdkp->rev_wp_ofst = NULL;
>>> +
>>> +unlock:
>>> +	mutex_unlock(&sdkp->rev_mutex);
>>
>> I don't really understand this.
>> Passing a callback is fine if things happen asynchronously, and you
>> wouldn't know from the calling context when that happened. Ok.
>> But the above code definitely assumes that blk_revalidate_disk_zones()
>> will be completed upon return, otherwise we'll get a nice crash in the
>> callback function as the 'rev' pointer is invalid.
>> But _if_ blk_revalidata_disk_zones() has completed upon return we might
>> as well kill the callback, have the ->rev_wp_ofst a local variable ans
>> simply the whole thing.
> 
> Sorry but I don't understand your comment. If in
> blk_revalidate_disk_zones() returns an error, all that happens is that
> we free the rev_wp_ofst pointer and return the error to the caller.
> 
> And looking at blk_revalidate_disk_zones() itself, I can't see a code
> path that calls the callback if something went wrong:
> 
> noio_flag = memalloc_noio_save();
>   
> 
> ret = disk->fops->report_zones(disk, 0, UINT_MAX,
>   
> 
>                                  blk_revalidate_zone_cb, &args);
>   
> 
> memalloc_noio_restore(noio_flag);
>   
> 
>   
>   
> 
> /*
>    * Install the new bitmaps and update nr_zones only once the queue is
>   
> 
>    * stopped and all I/Os are completed (i.e. a scheduler is not
>   
> 
>    * referencing the bitmaps).
>    */
> blk_mq_freeze_queue(q);
>   
> 
> if (ret >= 0) {
>   
> 
>           blk_queue_chunk_sectors(q, args.zone_sectors);
>   
> 
>           q->nr_zones = args.nr_zones;
>   
> 
>           swap(q->seq_zones_wlock, args.seq_zones_wlock);
>   
> 
>           swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
>   
> 
>           if (update_driver_data)
>                   update_driver_data(disk);
>   
> 
>           ret = 0;
>   
> 
> } else {
>           pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>   
> 
>           blk_queue_free_zone_bitmaps(q);
> }
> blk_mq_unfreeze_queue(q);
> 
> And even *iff* the callback would be executed, we would have:
> static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
> {
>           struct scsi_disk *sdkp = scsi_disk(disk);
>   
> 
> 
>           swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);
> }
> 
> I.e. we exchange some pointers. I can't see a possible crash here, we're
> not accessing anything.
> 
> Byte,
> 	Johannes
> 

