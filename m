Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618C72C7E7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgK3HKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:10:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:38576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgK3HKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:10:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30C1EAC6A;
        Mon, 30 Nov 2020 07:09:28 +0000 (UTC)
Subject: Re: [PATCH 14/45] block: use put_device in put_disk
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
 <20201128161510.347752-15-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1322a5be-2434-cd0f-f0c0-53444c96c6bd@suse.de>
Date:   Mon, 30 Nov 2020 08:09:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-15-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> Use put_device to put the device instead of poking into the internals
> and using kobject_put.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   block/genhd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 0bd9c41dd4cb69..f46e89226fdf91 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1803,7 +1803,7 @@ EXPORT_SYMBOL(__alloc_disk_node);
>   void put_disk(struct gendisk *disk)
>   {
>   	if (disk)
> -		kobject_put(&disk_to_dev(disk)->kobj);
> +		put_device(disk_to_dev(disk));
>   }
>   EXPORT_SYMBOL(put_disk);
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
