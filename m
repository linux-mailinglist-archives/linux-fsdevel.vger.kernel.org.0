Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3D2C289B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgKXNmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:42:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:43108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387947AbgKXNlz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:41:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE837AC2D;
        Tue, 24 Nov 2020 13:41:53 +0000 (UTC)
Subject: Re: [PATCH 13/45] block: add a bdev_kobj helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-14-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <cb689e01-60dc-9df8-3a94-006bc3c39367@suse.de>
Date:   Tue, 24 Nov 2020 21:41:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124132751.3747337-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 9:27 PM, Christoph Hellwig wrote:
> Add a little helper to find the kobject for a struct block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For the bcache part, Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c |  7 ++-----
>  drivers/md/md.c           |  4 +---
>  fs/block_dev.c            |  6 +++---
>  fs/btrfs/sysfs.c          | 15 +++------------
>  include/linux/blk_types.h |  3 +++
>  5 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 46a00134a36ae1..a6a5e21e4fd136 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1447,8 +1447,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  		goto err;
>  
>  	err = "error creating kobject";
> -	if (kobject_add(&dc->disk.kobj, &part_to_dev(bdev->bd_part)->kobj,
> -			"bcache"))
> +	if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
>  		goto err;
>  	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
>  		goto err;
> @@ -2342,9 +2341,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  		goto err;
>  	}
>  
> -	if (kobject_add(&ca->kobj,
> -			&part_to_dev(bdev->bd_part)->kobj,
> -			"bcache")) {
> +	if (kobject_add(&ca->kobj, bdev_kobj(bdev), "bcache")) {
>  		err = "error calling kobject_add";
>  		ret = -ENOMEM;
>  		goto out;

[snipped]
