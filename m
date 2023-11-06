Return-Path: <linux-fsdevel+bounces-2101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDD7E2780
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99568B20F06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCA28DB3;
	Mon,  6 Nov 2023 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSDNx7Pr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959319BA3
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D32DC433C8;
	Mon,  6 Nov 2023 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699282080;
	bh=NbG9LobHKx4M+DgwpqcL4EQ1C+67EgVNxWBQ5IyC8Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSDNx7PrJ6RAX3b2chmxrEWpWHyFxUov+iA7LLvQzfDHsO3OgyrgRdnHpOU2+FIAi
	 SaIqI+X//CZpPaOrE2Y/3oHMyyAM2GtJpWB+rfc+zjq5K1f3ZsnYh8/eqlTEdCrmlW
	 XJ9p4wddF43aAUrr4RfZqUO+wvBe0+5CxzSA7l1tBT3JZkvciiRbWVBdRCGHA1LK0e
	 TKnpW7ihvkg1VofShx6zeEFHnxd5F3KzUodrg2ss3vI96DHDiLLGOQ+mHThxt5jM8/
	 lA8CXqWDC+HGdl16t9rQ1c+IMV4iBT0EgR6LPsrCbfoyoQCb7uu5H41GFV/emJXqNA
	 Dkmvx+qBH4XlQ==
Date: Mon, 6 Nov 2023 15:47:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 3/7] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231106-einladen-macht-30a9ad957294@brauner>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-3-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101174325.10596-3-jack@suse.cz>

On Wed, Nov 01, 2023 at 06:43:08PM +0100, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether other writeable opens to block devices
> open with BLK_OPEN_RESTRICT_WRITES flag are allowed. We will make
> filesystems use this flag for used devices.
> 
> Note that this effectively only prevents modification of the particular
> block device's page cache by other writers. The actual device content
> can still be modified by other means - e.g. by issuing direct scsi
> commands, by doing writes through devices lower in the storage stack
> (e.g. in case loop devices, DM, or MD are involved) etc. But blocking
> direct modifications of the block device page cache is enough to give
> filesystems a chance to perform data validation when loading data from
> the underlying storage and thus prevent kernel crashes.
> 
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
> 
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

A few minor tweaks I would do in-tree. Please see below.
I know it's mostly stylistic that's why I would do it so there's no
resend dance for non-technical reasons.

>  block/Kconfig             | 20 +++++++++++++
>  block/bdev.c              | 62 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |  1 +
>  include/linux/blkdev.h    |  2 ++
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index f1364d1c0d93..ca04b657e058 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -78,6 +78,26 @@ config BLK_DEV_INTEGRITY_T10
>  	select CRC_T10DIF
>  	select CRC64_ROCKSOFT
>  
> +config BLK_DEV_WRITE_MOUNTED
> +	bool "Allow writing to mounted block devices"
> +	default y

Let's hope that this can become the default one day.

> +static void bdev_unblock_writes(struct block_device *bdev)
> +{
> +	bdev->bd_writers = 0;
> +}
> +
> +static bool blkdev_open_compatible(struct block_device *bdev, blk_mode_t mode)

I would like to mirror our may_{open,create}() routines here and call
this:

    bdev_may_open()

This is a well-known vfs pattern and also easy to understand for block
devs as well.

> @@ -800,12 +834,21 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		goto abort_claiming;
>  	if (!try_module_get(disk->fops->owner))
>  		goto abort_claiming;
> +	ret = -EBUSY;
> +	if (!blkdev_open_compatible(bdev, mode))
> +		goto abort_claiming;
>  	if (bdev_is_partition(bdev))
>  		ret = blkdev_get_part(bdev, mode);
>  	else
>  		ret = blkdev_get_whole(bdev, mode);
>  	if (ret)
>  		goto put_module;
> +	if (!bdev_allow_write_mounted) {
> +		if (mode & BLK_OPEN_RESTRICT_WRITES)
> +			bdev_block_writes(bdev);
> +		else if (mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers++;
> +	}

I would like to move this to a tiny helper for clarity:

static void bdev_claim_write_access(struct block_device *bdev)
{
        if (!bdev_allow_write_mounted)
                return;

        /* Claim exclusive or shared write access to the block device. */
        if (mode & BLK_OPEN_RESTRICT_WRITES)
                bdev_block_writes(bdev);
        else if (mode & BLK_OPEN_WRITE)
                bdev->bd_writers++;
}

>  	if (holder) {
>  		bd_finish_claiming(bdev, holder, hops);
>  
> @@ -901,6 +944,14 @@ void bdev_release(struct bdev_handle *handle)
>  		sync_blockdev(bdev);
>  
>  	mutex_lock(&disk->open_mutex);
> +	if (!bdev_allow_write_mounted) {
> +		/* The exclusive opener was blocking writes? Unblock them. */
> +		if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
> +			bdev_unblock_writes(bdev);
> +		else if (handle->mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers--;
> +	}

static void bdev_yield_write_access(struct block_device *bdev)
{
        if (!bdev_allow_write_mounted)
                return;

        /* Yield exclusive or shared write access. */
        if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
                bdev_unblock_writes(bdev);
        else if (handle->mode & BLK_OPEN_WRITE)
                bdev->bd_writers--;
}

