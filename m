Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98022C30CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 20:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKXTha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 14:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKXTh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:37:29 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA14BC0613D6;
        Tue, 24 Nov 2020 11:37:28 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f15so13481030qto.13;
        Tue, 24 Nov 2020 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOALJb5ZWPUh3aGAOfM0OVshborSGP7hJGfOxgGOGv8=;
        b=F5LkT6+P6W0m+3hlLX1OTdLAaWDWNPd5qU0zVXgoS6irqhQG1KPClCgLDacxdrz201
         tuSkOD3Pi7npw/jwH1Nvh11d7rq8LRNxgjQNm41OqnMYV7uCJqaXEwyai41Uj47dAbX3
         JK7du1QUlRFM6taLlQQ447SfHtDJsH8zezvU1GOUPlebgL174F6/7EsV7OtuCUoF3f9x
         Bkfc9gd/0KWs5FVV7usVufNl9+blVTvGwiyUy7osMlVAVbdFXgSTZohKeNl02jc4WQz4
         A0OAp0Qtsho7RAxf4m3roj9E2ZLkZ4zwUy7kn8kRWPQltha8Qf/YzRNO/2ELqU44tB/d
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MOALJb5ZWPUh3aGAOfM0OVshborSGP7hJGfOxgGOGv8=;
        b=OFBDMuOUXRXPL6O+snhd0jNzm5ht1Hdjn40do35M6aaGChn62EajuDBwtsFcjVkjvf
         NVv0gdynJ3DOhihvnB0FxdASCuOfcd7UDlo0knXMYFfQziyg0bFzV1uyIGIb8iQefZ+R
         5uAHjwNUoKOgNlQSFw9QN/XFKb0OuwX8aUDJ26xYNvSKcr6YMghvknkAKZobGF62Jv0U
         T2y1bcm22UUbhmDozFDLuPeMX1sWd2SDzsZeZzbE8oZOaCSqrs7MvH7RufklbzSAIfc0
         iagtbhnK5BijEDdiPZIJ4s54fLuXvE0dA6hq0H3PTaCsA6+ASDw4QF5PIIk5z+3Aypcr
         dsUQ==
X-Gm-Message-State: AOAM532bRtw74OALlfUjASzxdS39LCYz7ffn62w5ieKHrQFMfXp3GwQI
        TPlxvgKGDuV/8PljjO/7+D4=
X-Google-Smtp-Source: ABdhPJybxY5/E0+KDq94c9P/N9IKjFDU+Ct8NW6WiHsGOrtJ7iW5aHJE2Msrh+VJOHLo1ru6UJnxSg==
X-Received: by 2002:ac8:7192:: with SMTP id w18mr6129290qto.149.1606246647881;
        Tue, 24 Nov 2020 11:37:27 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id t126sm68819qkh.133.2020.11.24.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:37:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 14:37:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 23/45] block: remove i_bdev
Message-ID: <X71g4Tm+3RiRg4Gf@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-24-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:29PM +0100, Christoph Hellwig wrote:
> Switch the block device lookup interfaces to directly work with a dev_t
> so that struct block_device references are only acquired by the
> blkdev_get variants (and the blk-cgroup special case).  This means that
> we not don't need an extra reference in the inode and can generally
     ^
     now
> simplify handling of struct block_device to keep the lookups contained
> in the core block layer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
...
> @@ -1689,14 +1599,12 @@ static int blkdev_open(struct inode * inode, struct file * filp)
>  	if ((filp->f_flags & O_ACCMODE) == 3)
>  		filp->f_mode |= FMODE_WRITE_IOCTL;
>  
> -	bdev = bd_acquire(inode);
> -	if (bdev == NULL)
> -		return -ENOMEM;
> -
> +	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
> +	if (IS_ERR(bdev))
> +		return PTR_ERR(bdev);
>  	filp->f_mapping = bdev->bd_inode->i_mapping;
>  	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
> -
> -	return blkdev_get(bdev, filp->f_mode, filp);
> +	return 0;
>  }

I was wondering whether losing the stale bdev flushing in bd_acquire() would
cause user-visible behavior changes but can't see how it would given that
userland has no way of holding onto a specific instance of block inode.
Maybe it's something worth mentioning in the commit message?

Other than that, for the block part:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
