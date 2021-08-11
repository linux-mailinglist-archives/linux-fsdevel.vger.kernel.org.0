Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82F3E8F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhHKLZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 07:25:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33424 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhHKLZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:25:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A12D120160;
        Wed, 11 Aug 2021 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628681117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvtlkHF7iDVRQSHX2Nfm7jjJKIqvUV90SO9Pow6pFtw=;
        b=nKygt8fhOTlysffsMmdsaOkOrdrv+AUZ6uKwvOWk2O1XaesHiD29zXUgM3YBTTNiGJ9ub+
        +92BDc57n/hjQG4atRRG2VSPnRj5Xn0WnwP7hqNeKRH948kaef5re1DpWBlFiDwPrXzdvB
        Xq4upryfZpyMEinXfr2EshptMI7cTTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628681117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvtlkHF7iDVRQSHX2Nfm7jjJKIqvUV90SO9Pow6pFtw=;
        b=ugtkNHI7S7C94GN1noD2pxe5uiJOg13OW6qwb/ZkgZAviVhtETPQ1lZfcnue5y9g4NT1T1
        iSc+jDcEby0+wIBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8AEDAA3C17;
        Wed, 11 Aug 2021 11:25:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F3081E6204; Wed, 11 Aug 2021 13:25:14 +0200 (CEST)
Date:   Wed, 11 Aug 2021 13:25:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: move the bdi from the request_queue to the gendisk
Message-ID: <20210811112514.GC14725@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
 <20210810200256.GA30809@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810200256.GA30809@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-08-21 22:02:56, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 03:36:39PM -0400, Qian Cai wrote:
> > 
> > 
> > On 8/9/2021 10:17 AM, Christoph Hellwig wrote:
> > > Hi Jens,
> > > 
> > > this series moves the pointer to the bdi from the request_queue
> > > to the bdi, better matching the life time rules of the different
> > > objects.
> > 
> > Reverting this series fixed an use-after-free in bdev_evict_inode().
> 
> Please try the patch below as a band-aid.  Although the proper fix is
> that non-default bdi_writeback structures grab a reference to the bdi,
> as this was a landmine that might have already caused spurious issues
> before.

Well, non-default bdi_writeback structures do hold bdi reference - see
wb_exit() which drops the reference. I think the problem rather was that a
block device's inode->i_wb was pointing to the default bdi_writeback
structure and that got freed after bdi_put() before block device inode was
shutdown through bdput()... So what I think we need is that if the inode
references the default writeback structure, it actually holds a reference
to the bdi.

								Honza
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index f8def1129501..2e4a9d187196 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1086,7 +1086,6 @@ static void disk_release(struct device *dev)
>  
>  	might_sleep();
>  
> -	bdi_put(disk->bdi);
>  	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(MINOR(dev->devt));
>  	disk_release_events(disk);
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 7c969f81327a..c6087dbae6cf 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -849,11 +849,15 @@ static void init_once(void *data)
>  
>  static void bdev_evict_inode(struct inode *inode)
>  {
> +	struct block_device *bdev = I_BDEV(inode);
> +
>  	truncate_inode_pages_final(&inode->i_data);
>  	invalidate_inode_buffers(inode); /* is it needed here? */
>  	clear_inode(inode);
>  	/* Detach inode from wb early as bdi_put() may free bdi->wb */
>  	inode_detach_wb(inode);
> +	if (!bdev_is_partition(bdev))
> +		bdi_put(bdev->bd_disk->bdi);
>  }
>  
>  static const struct super_operations bdev_sops = {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
