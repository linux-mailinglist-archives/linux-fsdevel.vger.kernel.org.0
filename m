Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04072C4C7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgKZBQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 20:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgKZBQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:16:22 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07397C0613D4;
        Wed, 25 Nov 2020 17:16:22 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so269912pgi.11;
        Wed, 25 Nov 2020 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ffbgfORDd1J1xm3xxXp8xWzEs5sXbivtuhWMZ6CRpX8=;
        b=QvBDhQabcPJJmll9n1XSftf1/oCdc4AbjJKr3e1lsYr3oC6BYqnsjBtTeyYy83i7U3
         CiBd9FBSulwPjxAjN7h2emgRFMFS1h+Lw6DqhxGTuZzg7+z7LjtCeMG+R8Iu7GvPbymk
         ToF3QU0Kl5XY8lJh/Qkx9aL7d+kCec25ZtdGP0mSVt69+sY7dMUe9kHgs59VUC7F5d4d
         nBojS3btHNUmyJAhv9TgzqtLgQeQkeeQKwwl8KyW2EiBpga6aEsYA+VodfFczjdFHus+
         VDSakrHxOOPEEYbfR18sM6jijaOJSIrXZ6isVycVVCHpctMR7iHPW0kXlgmPrbk46btj
         mYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ffbgfORDd1J1xm3xxXp8xWzEs5sXbivtuhWMZ6CRpX8=;
        b=Iv/bUsqeQSLy+OkXsfKmGmruNyD1Z8EkFz/Ci+EJdMwZLkL+8tkaFsoCtyCsRGzaNE
         txw7vNplI5Adbh8FSFwyHekTyjwzZ0C5VIUbK8DLqUZ0/1tMa0b1PPjxZAV03g38cmMq
         z2RkW3jxAD4DxePn6oNQU3mxVNPbVUiZEEwnN8Q6/S4CS1LfUWyU1r0aTgEPgm9oSArY
         EH+i6leygslsyLAB9Z8jZ6ykVAY/U1EomqEXzEl4N1+ILvHEKKfPGeX1T0SFTQSvKJ9I
         435E7ZwEvnOexItytvVXsRHdxnkIBor94qAVSWNzw5+33OJcfMeDsA57IEFQHMBuLJrD
         Fjvw==
X-Gm-Message-State: AOAM532rWmIkXxXFfCZn5jX9T8P9Al4KHIdYf9cVm87PnePXWipIuFXM
        +1o9lol4sfX0IiiDydi618E=
X-Google-Smtp-Source: ABdhPJxuwzDVcKoe4o/wMgwyIQrHY+YPGkp4YxJA+sp/vPwpgqgEvxXOvnlOmZ0BtRJFwRde4WH8Zg==
X-Received: by 2002:a62:8cc6:0:b029:19a:87b1:99bb with SMTP id m189-20020a628cc60000b029019a87b199bbmr637857pfd.6.1606353381534;
        Wed, 25 Nov 2020 17:16:21 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id e128sm2978987pfe.154.2020.11.25.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:16:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 17:16:16 -0800
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
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH 61/78] zram:  do not call set_blocksize
Message-ID: <20201126011616.GB57352@google.com>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-62-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-62-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:57:52PM +0100, Christoph Hellwig wrote:
> set_blocksize is used by file systems to use their preferred buffer cache
> block size.  Block drivers should not set it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.

> ---
>  drivers/block/zram/zram_drv.c | 11 +----------
>  drivers/block/zram/zram_drv.h |  1 -
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3641434a9b154d..d00b5761ec0b21 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -403,13 +403,10 @@ static void reset_bdev(struct zram *zram)
>  		return;
>  
>  	bdev = zram->bdev;
> -	if (zram->old_block_size)
> -		set_blocksize(bdev, zram->old_block_size);
>  	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>  	/* hope filp_close flush all of IO */
>  	filp_close(zram->backing_dev, NULL);
>  	zram->backing_dev = NULL;
> -	zram->old_block_size = 0;
>  	zram->bdev = NULL;
>  	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
> @@ -454,7 +451,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	struct file *backing_dev = NULL;
>  	struct inode *inode;
>  	struct address_space *mapping;
> -	unsigned int bitmap_sz, old_block_size = 0;
> +	unsigned int bitmap_sz;
>  	unsigned long nr_pages, *bitmap = NULL;
>  	struct block_device *bdev = NULL;
>  	int err;
> @@ -509,14 +506,8 @@ static ssize_t backing_dev_store(struct device *dev,
>  		goto out;
>  	}
>  
> -	old_block_size = block_size(bdev);
> -	err = set_blocksize(bdev, PAGE_SIZE);
> -	if (err)
> -		goto out;
> -
>  	reset_bdev(zram);
>  
> -	zram->old_block_size = old_block_size;
>  	zram->bdev = bdev;
>  	zram->backing_dev = backing_dev;
>  	zram->bitmap = bitmap;
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index f2fd46daa76045..712354a4207c77 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -118,7 +118,6 @@ struct zram {
>  	bool wb_limit_enable;
>  	u64 bd_wb_limit;
>  	struct block_device *bdev;
> -	unsigned int old_block_size;
>  	unsigned long *bitmap;
>  	unsigned long nr_pages;
>  #endif
> -- 
> 2.29.2
> 
