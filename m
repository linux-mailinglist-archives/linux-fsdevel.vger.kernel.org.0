Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5A273DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIVIoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 04:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgIVIod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:44:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC920ACBF;
        Tue, 22 Sep 2020 08:45:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FB371E12E3; Tue, 22 Sep 2020 10:44:31 +0200 (CEST)
Date:   Tue, 22 Sep 2020 10:44:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/13] bcache: inherit the optimal I/O size
Message-ID: <20200922084431.GA16464@quack2.suse.cz>
References: <20200921080734.452759-1-hch@lst.de>
 <20200921080734.452759-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921080734.452759-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-09-20 10:07:24, Christoph Hellwig wrote:
> Inherit the optimal I/O size setting just like the readahead window,
> as any reason to do larger I/O does not apply to just readahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/bcache/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 1bbdc410ee3c51..48113005ed86ad 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1430,6 +1430,8 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  	dc->disk.disk->queue->backing_dev_info->ra_pages =
>  		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
>  		    q->backing_dev_info->ra_pages);
> +	blk_queue_io_opt(dc->disk.disk->queue,
> +		max(queue_io_opt(dc->disk.disk->queue), queue_io_opt(q)));
>  
>  	atomic_set(&dc->io_errors, 0);
>  	dc->io_disable = false;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
