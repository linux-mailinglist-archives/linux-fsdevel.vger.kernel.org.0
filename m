Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D347160BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjE3M5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjE3M4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:56:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23EDE74;
        Tue, 30 May 2023 05:56:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F3E321AA0;
        Tue, 30 May 2023 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685451340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qz6VxSG6Me8cMILTxPNvLBOuIKtS1BXIYbnFAOzFU88=;
        b=RNM/5v9I0cJcxe2sgHVWKvoJ27BJ/3BbwFUlVHziTd7W/RqzpgPEKRvFcNBwwBMvYv+gDS
        lqz36elGppGr6JcTnA6KRI7+KEvgmr46pD8DmL2tigbtQ8YArVKOKHdZzD1cxJONnJlzPH
        yOx+bng3UCPGQr7a2XRluMW9OmAUfX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685451340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qz6VxSG6Me8cMILTxPNvLBOuIKtS1BXIYbnFAOzFU88=;
        b=E0j6eqL4WpPaYkWdFKYUucEWYhdWrYqciFAO8En1dOpC19SmzyWLmu2enr5ip67P2d1fWA
        SN0mmS3X+MiEm1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 405A713478;
        Tue, 30 May 2023 12:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I5esD0zydWTlLQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 12:55:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CAEB4A0754; Tue, 30 May 2023 14:55:39 +0200 (CEST)
Date:   Tue, 30 May 2023 14:55:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] block: delete partitions later in del_gendisk
Message-ID: <20230530125539.fmby32cz3grnueu6@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-8-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 06:23:16, Christoph Hellwig wrote:
> Delay dropping the block_devices for partitions in del_gendisk until
> after the call to blk_mark_disk_dead, so that we can implementat
> notification of removed devices in blk_mark_disk_dead.
> 
> This requires splitting a lower-level drop_partition helper out of
> delete_partition and using that from del_gendisk, while having a
> common loop for the whole device and partitions that calls
> remove_inode_hash, fsync_bdev and __invalidate_device before the
> call to blk_mark_disk_dead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk.h             |  2 +-
>  block/genhd.c           | 24 +++++++++++++++++++-----
>  block/partitions/core.c | 19 ++++++++++++-------
>  3 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 45547bcf111938..4363052f90416a 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -409,7 +409,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  int bdev_del_partition(struct gendisk *disk, int partno);
>  int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
>  		sector_t length);
> -void blk_drop_partitions(struct gendisk *disk);
> +void drop_partition(struct block_device *part);
>  
>  void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index a744daeed55318..bd4c4eca31363e 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -615,6 +615,8 @@ EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>  void del_gendisk(struct gendisk *disk)
>  {
>  	struct request_queue *q = disk->queue;
> +	struct block_device *part;
> +	unsigned long idx;
>  
>  	might_sleep();
>  
> @@ -623,16 +625,28 @@ void del_gendisk(struct gendisk *disk)
>  
>  	disk_del_events(disk);
>  
> +	/*
> +	 * Prevent new openers by unlinked the bdev inode, and write out
> +	 * dirty data before marking the disk dead and stopping all I/O.
> +	 */
>  	mutex_lock(&disk->open_mutex);
> -	remove_inode_hash(disk->part0->bd_inode);
> -	blk_drop_partitions(disk);
> +	xa_for_each(&disk->part_tbl, idx, part) {
> +		remove_inode_hash(part->bd_inode);
> +		fsync_bdev(part);
> +		__invalidate_device(part, true);
> +	}
>  	mutex_unlock(&disk->open_mutex);
>  
> -	fsync_bdev(disk->part0);
> -	__invalidate_device(disk->part0, true);
> -
>  	blk_mark_disk_dead(disk);
>  
> +	/*
> +	 * Drop all partitions now that the disk is marked dead.
> +	 */
> +	mutex_lock(&disk->open_mutex);
> +	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> +		drop_partition(part);
> +	mutex_unlock(&disk->open_mutex);
> +
>  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>  		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
>  
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index fa5c707fe0ad2f..31ac815d77a83c 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -263,10 +263,19 @@ struct device_type part_type = {
>  	.uevent		= part_uevent,
>  };
>  
> -static void delete_partition(struct block_device *part)
> +void drop_partition(struct block_device *part)
>  {
>  	lockdep_assert_held(&part->bd_disk->open_mutex);
>  
> +	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
> +	kobject_put(part->bd_holder_dir);
> +
> +	device_del(&part->bd_device);
> +	put_device(&part->bd_device);
> +}
> +
> +static void delete_partition(struct block_device *part)
> +{
>  	/*
>  	 * Remove the block device from the inode hash, so that it cannot be
>  	 * looked up any more even when openers still hold references.
> @@ -276,11 +285,7 @@ static void delete_partition(struct block_device *part)
>  	fsync_bdev(part);
>  	__invalidate_device(part, true);
>  
> -	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
> -	kobject_put(part->bd_holder_dir);
> -	device_del(&part->bd_device);
> -
> -	put_device(&part->bd_device);
> +	drop_partition(part);
>  }
>  
>  static ssize_t whole_disk_show(struct device *dev,
> @@ -519,7 +524,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
>  	return true;
>  }
>  
> -void blk_drop_partitions(struct gendisk *disk)
> +static void blk_drop_partitions(struct gendisk *disk)
>  {
>  	struct block_device *part;
>  	unsigned long idx;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
