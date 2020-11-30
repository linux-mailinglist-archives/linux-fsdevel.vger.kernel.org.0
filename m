Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1552C814A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgK3JpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 04:45:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:43068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgK3JpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:45:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7A4CACBA;
        Mon, 30 Nov 2020 09:44:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E43E1E131B; Mon, 30 Nov 2020 10:44:21 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:44:21 +0100
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
Subject: Re: [PATCH 30/45] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201130094421.GD11250@quack2.suse.cz>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-31-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128161510.347752-31-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 28-11-20 17:14:55, Christoph Hellwig wrote:
> Now that the hd_struct always has a block device attached to it, there is
> no need for having two size field that just get out of sync.
> 
> Additionally the field in hd_struct did not use proper serialization,
> possibly allowing for torn writes.  By only using the block_device field
> this problem also gets fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Coly Li <colyli@suse.de>			[bcache]
> Acked-by: Chao Yu <yuchao0@huawei.com>			[f2fs]

...

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
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(set_capacity_and_notify);

I know I'm like a broken record about this but I still don't understand
here... I'd expect the new code to be:

	if (size == capacity ||
	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
		return false;
	pr_info("%s: detected capacity change from %lld to %lld\n",
		disk->disk_name, size, capacity);
+	if (!capacity || !size)
+		return false;
	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
	return true;

At least that would be equivalent to the original functionality of
set_capacity_and_notify(). And if you indeed intend to change when
"RESIZE=1" events are sent, then I'd expect an explanation in the changelog
why this cannot break userspace (I remember we've already broken some udev
rules in the past by generating unexpected events and we had to revert
those changes in the partition code so I'm more careful now). The rest of
the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
