Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D32C6332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgK0KhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 05:37:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgK0KhQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:37:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E166AF38;
        Fri, 27 Nov 2020 10:37:14 +0000 (UTC)
Subject: Re: [PATCH 11/44] block: remove a superflous check in blkpg_do_ioctl
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
 <20201126130422.92945-12-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <af25c440-de15-3ba0-9f29-df708106c7d3@suse.de>
Date:   Fri, 27 Nov 2020 11:37:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126130422.92945-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/20 2:03 PM, Christoph Hellwig wrote:
> sector_t is now always a u64, so this check is not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>   block/ioctl.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6b785181344fe1..0c09bb7a6ff35f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -35,15 +35,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>   	start = p.start >> SECTOR_SHIFT;
>   	length = p.length >> SECTOR_SHIFT;
>   
> -	/* check for fit in a hd_struct */
> -	if (sizeof(sector_t) < sizeof(long long)) {
> -		long pstart = start, plength = length;
> -
> -		if (pstart != start || plength != length || pstart < 0 ||
> -		    plength < 0 || p.pno > 65535)
> -			return -EINVAL;
> -	}
> -
>   	switch (op) {
>   	case BLKPG_ADD_PARTITION:
>   		/* check if partition is aligned to blocksize */
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
