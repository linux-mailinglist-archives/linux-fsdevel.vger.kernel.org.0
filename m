Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB132C6438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 13:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgK0MEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 07:04:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:46724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgK0MEl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:04:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D8BFADCA;
        Fri, 27 Nov 2020 12:04:40 +0000 (UTC)
Subject: Re: [PATCH 13/44] block: use disk_part_iter_exit in
 disk_part_iter_next
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
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-14-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1624f174-4182-744c-56ad-b50a391a6bb7@suse.de>
Date:   Fri, 27 Nov 2020 13:04:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126130422.92945-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/20 2:03 PM, Christoph Hellwig wrote:
> Call disk_part_iter_exit in disk_part_iter_next instead of duplicating
> the functionality.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   block/genhd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 4e039524f92b8f..0bd9c41dd4cb69 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -227,8 +227,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
>   	int inc, end;
>   
>   	/* put the last partition */
> -	disk_put_part(piter->part);
> -	piter->part = NULL;
> +	disk_part_iter_exit(piter);
>   
>   	/* get part_tbl */
>   	rcu_read_lock();
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
