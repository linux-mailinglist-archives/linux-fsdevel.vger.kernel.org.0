Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984637B479
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhELDZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 23:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELDZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 23:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620789858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83RC2qtc5cEihhWItsXrcoyXmMoP0cw+w8BGnKZsq/4=;
        b=WDCphuP01ynz1MmB44EN6CcUA2lgJSbzjatgSb6FG4+j65ni/pJDe0Mktwz1/TNK6Za0y5
        KhFpjOWO5FHOPwZ0AB3h8caC9FP/ugIbgYHRuXj0M4/7BuLtq11d/lUQK9B9MB3KKnfJQz
        dXaZHWlzvamivzeesalJYmdiRkh939c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-L_Rd4dvCOzqELtSY7GHHIA-1; Tue, 11 May 2021 23:24:14 -0400
X-MC-Unique: L_Rd4dvCOzqELtSY7GHHIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF651883522;
        Wed, 12 May 2021 03:24:12 +0000 (UTC)
Received: from T590 (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 648725D9D7;
        Wed, 12 May 2021 03:24:04 +0000 (UTC)
Date:   Wed, 12 May 2021 11:23:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gulam Mohamed <gulam.mohamed@oracle.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH V1 1/1] Fix race between iscsi logout and systemd-udevd
Message-ID: <YJtKT7rLi2CFqDsV@T590>
References: <20210511181558.380764-1-gulam.mohamed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511181558.380764-1-gulam.mohamed@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 06:15:58PM +0000, Gulam Mohamed wrote:
> Problem description:
> 
> During the kernel patching, customer was switching between the iscsi
> disks. To switch between the iscsi disks, it was logging out the
> currently connected iscsi disk and then logging in to the new iscsi
> disk. This was being done using a script. Customer was also using the
> "parted" command in the script to list the partition details just
> before the iscsi logout. This usage of "parted" command was creating
> an issue and we were seeing stale links of the
> disks in /sys/class/block.
> 
> Analysis:
> 
> As part of iscsi logout, the partitions and the disk will be removed
> in the function del_gendisk() which is done through a kworker. The
> parted command, used to list the partitions, will open the disk in
> RW mode which results in systemd-udevd re-reading the partitions. The
> ioctl used to re-read partitions is BLKRRPART. This will trigger the
> rescanning of partitions which will also delete and re-add the
> partitions. So, both iscsi logout processing (through kworker) and the
> "parted" command (through systemd-udevd) will be involved in
> add/delete of partitions. In our case, the following sequence of
> operations happened (the iscsi device is /dev/sdb with partition sdb1):
> 
> 1. sdb1 was removed by PARTED
> 2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was
>    already removed by PARTED
> 3. sdb1 was added by parted
> 4. sdb was NOW removed as part of iscsi logout (the last part of the
>    device removal after remoing the partitions)
> 
> Since the symlink /sys/class/block/sdb1 points to
> /sys/class/devices/platform/hostx/sessionx/targetx:x/block/sdb/sdb1
> and since sdb is already removed, the symlink /sys/class/block/sdb1
> will be orphan and stale. So, this stale link is a result of the race
> condition in kernel between the systemd-udevd and iscsi-logout
> processing as described above. We were able to reproduce this even
> with latest upstream kernel.
> 
> Fix:
> 
> While Dropping/Adding partitions as part of BLKRRPART ioctl, take the
> read lock for "bdev_lookup_sem" to sync with del_gendisk().
> 
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
>  fs/block_dev.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 09d6f7229db9..e903a7edfd63 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1245,9 +1245,17 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  	lockdep_assert_held(&bdev->bd_mutex);
>  
>  rescan:
> +	down_read(&bdev_lookup_sem);
> +	if (!(disk->flags & GENHD_FL_UP)) {
> +		up_read(&bdev_lookup_sem);
> +		return -ENXIO;
> +	}

This way might cause deadlock:

1) code path BLKRRPART:
	mutex_lock(bdev->bd_mutex)
	down_read(&bdev_lookup_sem);

2) del_gendisk():
	down_write(&bdev_lookup_sem);
	mutex_lock(&disk->part0->bd_mutex);

Given GENHD_FL_UP is only checked when opening one bdev, and
fsync_bdev() and __invalidate_device() needn't to open bdev, so
the following way may work for your issue:


diff --git a/block/genhd.c b/block/genhd.c
index 39ca97b0edc6..5eb27995d4ab 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -617,6 +617,7 @@ void del_gendisk(struct gendisk *disk)
 
 	mutex_lock(&disk->part0->bd_mutex);
 	blk_drop_partitions(disk);
+	disk->flags &= ~GENHD_FL_UP;
 	mutex_unlock(&disk->part0->bd_mutex);
 
 	fsync_bdev(disk->part0);
@@ -629,7 +630,6 @@ void del_gendisk(struct gendisk *disk)
 	remove_inode_hash(disk->part0->bd_inode);
 
 	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
 	up_write(&bdev_lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8abccd03e5d..06b70b8e3f67 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1245,6 +1245,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	lockdep_assert_held(&bdev->bd_mutex);
 
 rescan:
+	if(!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
 	if (bdev->bd_part_count)
 		return -EBUSY;
 	sync_blockdev(bdev);



Thanks,
Ming

