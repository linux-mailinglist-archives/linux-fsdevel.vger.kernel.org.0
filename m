Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE52C5991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbgKZQuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 11:50:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:57802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391465AbgKZQuj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:50:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C2ECACE0;
        Thu, 26 Nov 2020 16:50:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BAA6A1E10D0; Thu, 26 Nov 2020 17:50:36 +0100 (CET)
Date:   Thu, 26 Nov 2020 17:50:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 29/44] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201126165036.GO422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-30-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:07, Christoph Hellwig wrote:
> Now that the hd_struct always has a block device attached to it, there is
> no need for having two size field that just get out of sync.
> 
> Additional the field in hd_struct did not use proper serializiation,
   ^^ Additionaly					^^^ serialization

> possibly allowing for torn writes.  By only using the block_device field
> this problem also gets fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Coly Li <colyli@suse.de>			[bcache]
> Acked-by: Chao Yu <yuchao0@huawei.com>			[f2fs]

Nice, just two nits below.

> @@ -47,18 +57,22 @@ static void disk_release_events(struct gendisk *disk);
>  bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
>  {
>  	sector_t capacity = get_capacity(disk);
> +	char *envp[] = { "RESIZE=1", NULL };
>  
>  	set_capacity(disk, size);
> -	revalidate_disk_size(disk, true);
> -
> -	if (capacity != size && capacity != 0 && size != 0) {
> -		char *envp[] = { "RESIZE=1", NULL };
> -
> -		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> -		return true;
> -	}
>  
> -	return false;
> +	/*
> +	 * Only print a message and send a uevent if the gendisk is user visible
> +	 * and alive.  This avoids spamming the log and udev when setting the
> +	 * initial capacity during probing.
> +	 */
> +	if (size == capacity ||
> +	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> +		return false;
> +	pr_info("%s: detected capacity change from %lld to %lld\n",
> +		disk->disk_name, size, capacity);
> +	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);

I think we don't want to generate resize event for changes from / to 0...
Also the return value of this function is now different.

> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> index 4e37fa9b409d52..a70c33c49f0960 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -1027,12 +1027,7 @@ static u32 pscsi_get_device_type(struct se_device *dev)
>  
>  static sector_t pscsi_get_blocks(struct se_device *dev)
>  {
> -	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
> -
> -	if (pdv->pdv_bd && pdv->pdv_bd->bd_part)
> -		return pdv->pdv_bd->bd_part->nr_sects;
> -
> -	return 0;
> +	return bdev_nr_sectors(PSCSI_DEV(dev)->pdv_bd);

I pdv_bd guaranteed to be non-NULL in pscsi_dev_virt?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
