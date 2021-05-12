Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B167437B6CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhELHYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 03:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhELHYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 03:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620804204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vg/cll4jMfmP1m7tM5YSccYAw8vElQEoOqiM7v+Lw54=;
        b=gV1qTN5zBhJItWDz/uKryN2+6nh7Pwul7vRVlsSYzlH7U6Z3cFCoTDrg4bnKidFWHg5xfW
        ppZgh95wrdoms3JvmWeuGNN58S4bV22dH7MiJpxGL2q2h+srlYtAHB5R7ZK1IsrQpmBDzf
        3PQpOZuZ+SJ3oMgNdScCmORsZnmPJXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-FrlSMN87OIaCe4JumnKwJw-1; Wed, 12 May 2021 03:23:23 -0400
X-MC-Unique: FrlSMN87OIaCe4JumnKwJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38411854E26;
        Wed, 12 May 2021 07:23:21 +0000 (UTC)
Received: from T590 (ovpn-13-214.pek2.redhat.com [10.72.13.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1800114103;
        Wed, 12 May 2021 07:23:14 +0000 (UTC)
Date:   Wed, 12 May 2021 15:23:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH V1 1/1] Fix race between iscsi logout and systemd-udevd
Message-ID: <YJuCXh2ykAuDcuTb@T590>
References: <20210511181558.380764-1-gulam.mohamed@oracle.com>
 <YJtKT7rLi2CFqDsV@T590>
 <20210512063505.GA18367@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512063505.GA18367@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 08:35:05AM +0200, Christoph Hellwig wrote:
> On Wed, May 12, 2021 at 11:23:59AM +0800, Ming Lei wrote:
> > 
> > 1) code path BLKRRPART:
> > 	mutex_lock(bdev->bd_mutex)
> > 	down_read(&bdev_lookup_sem);
> > 
> > 2) del_gendisk():
> > 	down_write(&bdev_lookup_sem);
> > 	mutex_lock(&disk->part0->bd_mutex);
> > 
> > Given GENHD_FL_UP is only checked when opening one bdev, and
> > fsync_bdev() and __invalidate_device() needn't to open bdev, so
> > the following way may work for your issue:
> 
> If we move the clearing of GENHD_FL_UP earlier we can do away with
> bdev_lookup_sem entirely I think.  Something like this untested patch:
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index a5847560719c..ef717084b343 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -29,8 +29,6 @@
>  
>  static struct kobject *block_depr;
>  
> -DECLARE_RWSEM(bdev_lookup_sem);
> -
>  /* for extended dynamic devt allocation, currently only one major is used */
>  #define NR_EXT_DEVT		(1 << MINORBITS)
>  static DEFINE_IDA(ext_devt_ida);
> @@ -609,13 +607,8 @@ void del_gendisk(struct gendisk *disk)
>  	blk_integrity_del(disk);
>  	disk_del_events(disk);
>  
> -	/*
> -	 * Block lookups of the disk until all bdevs are unhashed and the
> -	 * disk is marked as dead (GENHD_FL_UP cleared).
> -	 */
> -	down_write(&bdev_lookup_sem);
> -
>  	mutex_lock(&disk->open_mutex);
> +	disk->flags &= ~GENHD_FL_UP;
>  	blk_drop_partitions(disk);
>  	mutex_unlock(&disk->open_mutex);
>  
> @@ -627,10 +620,7 @@ void del_gendisk(struct gendisk *disk)
>  	 * up any more even if openers still hold references to it.
>  	 */
>  	remove_inode_hash(disk->part0->bd_inode);
> -
>  	set_capacity(disk, 0);
> -	disk->flags &= ~GENHD_FL_UP;
> -	up_write(&bdev_lookup_sem);
>  
>  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>  		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 8dd8e2fd1401..bde23940190f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1377,33 +1377,24 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>  	struct block_device *bdev;
>  	struct gendisk *disk;
>  
> -	down_read(&bdev_lookup_sem);
>  	bdev = bdget(dev);
>  	if (!bdev) {
> -		up_read(&bdev_lookup_sem);
>  		blk_request_module(dev);
> -		down_read(&bdev_lookup_sem);
> -
>  		bdev = bdget(dev);
>  		if (!bdev)
> -			goto unlock;
> +			return NULL;
>  	}
>  
>  	disk = bdev->bd_disk;
>  	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
>  		goto bdput;
> -	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> -		goto put_disk;
>  	if (!try_module_get(bdev->bd_disk->fops->owner))
>  		goto put_disk;
> -	up_read(&bdev_lookup_sem);
>  	return bdev;
>  put_disk:
>  	put_disk(disk);
>  bdput:
>  	bdput(bdev);
> -unlock:
> -	up_read(&bdev_lookup_sem);
>  	return NULL;
>  }
>  
> @@ -1462,7 +1453,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
>  
>  	disk_block_events(disk);
>  
> +	ret = -ENXIO;
>  	mutex_lock(&disk->open_mutex);
> +	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> +		goto abort_claiming;
>  	if (bdev_is_partition(bdev))
>  		ret = blkdev_get_part(bdev, mode);
>  	else

This patch looks fine, and new openers can be prevented really with help
of ->open_mutex.

Thanks, 
Ming

