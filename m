Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA392C4C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 02:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKZBLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 20:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZBLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:11:12 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381EC0613D4;
        Wed, 25 Nov 2020 17:11:12 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so137675pfn.0;
        Wed, 25 Nov 2020 17:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f8bMvE80grJsQDxQbN+SXa4Ok4avPUhhCBLg+N5g7uE=;
        b=CJdcPtV0FUzyxFptDYgR6iAeEpy/fm/U+qwm7MjSAUITShNs3IGjSdma/ci1d+UdB1
         /4QBGWKw7GesxoQFO7vGWULXUqZeTgSL72KBwgOOTOpdW6FEjFkGl8KvyOmWfu5zn3C8
         2D8lQB9/sXcZGuetWYq/y9fJ/4tVoCfZkFM+w/twGxXZf6jIBGOeoFgX3V3eoJ4SxFtL
         DMlA1WjSzrfwym46BYlZOU4NNlAHgEZUyXcv6V6vuCHVbSrKNoE7MZTnCkoIzELetkkK
         3iGfzFOaAaJYntoqnGECTiJfY05IPhrPMzUEVWqaaAGWlk8VKPKZsqmpzgCIg3k/819j
         bQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=f8bMvE80grJsQDxQbN+SXa4Ok4avPUhhCBLg+N5g7uE=;
        b=i9YOxFL6AsFIZk3I5DQpmDz/gDFKvYadt1l12LPL174jiWhKGxn2G+nHRAoZdbPiNK
         tIp9KNCxCM5DNqiPGPy+ppSnvap7tM+DmgSb6mut4BrniebfGuoMaPoAtt5C/RLC+4eR
         aA9WfpNzPuah7gAPJRAo3ZSkVaxJqvAh0lMgg2rbrr4cIdfPzUxfB+bUAXCAOdYVgE2R
         LyzIvpKbpvfFm0hmCRM9GJ9UGichuN8yv2mnSt9ZDRn5ma38hMJVWmzfQ+PToVcBmhBu
         aYtR888KoVd8wG0WGsaU0s/lmkkBOcp+96saw9ipyKnAtwktiuD02nWN4C5xs9+3cBLj
         z+HQ==
X-Gm-Message-State: AOAM532jYN0lMS5UX4AL6+ZeHaa7ZZzrj5+If2Cfmk5sGTkliRRKnd5f
        Blp5e/fVW/nccXM61g0RDzQ=
X-Google-Smtp-Source: ABdhPJy2rvS54nam6WzB3Gos6rktAfztTZ/apost62cNhHmAqWfXtcE8/JRGjAG0GRNN0NDnAydY0Q==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr643556pjn.100.1606353071628;
        Wed, 25 Nov 2020 17:11:11 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id s10sm3915048pjn.35.2020.11.25.17.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:11:10 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 17:11:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 60/78] zram: remove the claim mechanism
Message-ID: <20201126011107.GA57352@google.com>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-61-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-61-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:57:51PM +0100, Christoph Hellwig wrote:
> The zram claim mechanism was added to ensure no new opens come in
> during teardown.  But the proper way to archive that is to call
> del_gendisk first, which takes care of all that.  Once del_gendisk
> is called in the right place, the reset side can also be simplified
> as no I/O can be outstanding on a block device that is not open.

It would be great if it makes the mess simple. Let me have a question
Please see below.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zram/zram_drv.c | 76 ++++++++++-------------------------
>  1 file changed, 21 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6d15d51cee2b7e..3641434a9b154d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1756,64 +1756,33 @@ static ssize_t disksize_store(struct device *dev,
>  static ssize_t reset_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
> -	int ret;
> -	unsigned short do_reset;
> -	struct zram *zram;
> +	struct zram *zram = dev_to_zram(dev);
>  	struct block_device *bdev;
> +	unsigned short do_reset;
> +	int ret = 0;
>  
>  	ret = kstrtou16(buf, 10, &do_reset);
>  	if (ret)
>  		return ret;
> -
>  	if (!do_reset)
>  		return -EINVAL;
>  
> -	zram = dev_to_zram(dev);
>  	bdev = bdget_disk(zram->disk, 0);
>  	if (!bdev)
>  		return -ENOMEM;
>  
>  	mutex_lock(&bdev->bd_mutex);
> -	/* Do not reset an active device or claimed device */
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> -		bdput(bdev);
> -		return -EBUSY;
> -	}
> -
> -	/* From now on, anyone can't open /dev/zram[0-9] */
> -	zram->claim = true;
> +	if (bdev->bd_openers)
> +		ret = -EBUSY;
> +	else
> +		zram_reset_device(zram);
>  	mutex_unlock(&bdev->bd_mutex);
> -
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> -	zram_reset_device(zram);
>  	bdput(bdev);
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	zram->claim = false;
> -	mutex_unlock(&bdev->bd_mutex);
> -
> -	return len;
> -}
> -
> -static int zram_open(struct block_device *bdev, fmode_t mode)
> -{
> -	int ret = 0;
> -	struct zram *zram;
> -
> -	WARN_ON(!mutex_is_locked(&bdev->bd_mutex));
> -
> -	zram = bdev->bd_disk->private_data;
> -	/* zram was claimed to reset so open request fails */
> -	if (zram->claim)
> -		ret = -EBUSY;
> -
> -	return ret;
> +	return ret ? ret : len;
>  }
>  
>  static const struct block_device_operations zram_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.rw_page = zram_rw_page,
> @@ -1821,7 +1790,6 @@ static const struct block_device_operations zram_devops = {
>  };
>  
>  static const struct block_device_operations zram_wb_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.owner = THIS_MODULE
> @@ -1972,34 +1940,32 @@ static int zram_add(void)
>  	return ret;
>  }
>  
> -static int zram_remove(struct zram *zram)
> +static bool zram_busy(struct zram *zram)
>  {
>  	struct block_device *bdev;
> +	bool busy = false;
>  
>  	bdev = bdget_disk(zram->disk, 0);
> -	if (!bdev)
> -		return -ENOMEM;
> -
> -	mutex_lock(&bdev->bd_mutex);
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> +	if (bdev) {
> +		if (bdev->bd_openers)
> +			busy = true;
>  		bdput(bdev);
> -		return -EBUSY;
>  	}
>  
> -	zram->claim = true;
> -	mutex_unlock(&bdev->bd_mutex);
> +	return busy;
> +}
>  
> -	zram_debugfs_unregister(zram);
> +static int zram_remove(struct zram *zram)
> +{
> +	if (zram_busy(zram))
> +		return -EBUSY;
>  
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> +	del_gendisk(zram->disk);
> +	zram_debugfs_unregister(zram);
>  	zram_reset_device(zram);
> -	bdput(bdev);
>  
>  	pr_info("Removed device: %s\n", zram->disk->disk_name);
>  
> -	del_gendisk(zram->disk);
>  	blk_cleanup_queue(zram->disk->queue);
>  	put_disk(zram->disk);
>  	kfree(zram);
> -- 
> 2.29.2
> 

With this patch, how deal with the race?

CPU 1                                     CPU 2

hot_remove_store
  zram_remove
    zram_busy
      return -EBUSY
                                         open /dev/zram0
    del_gendisk
    zram_reset and destroy

