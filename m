Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED42C5870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgKZPpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 10:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:42134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgKZPpa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41B9FAD20;
        Thu, 26 Nov 2020 15:45:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C71901E10D0; Thu, 26 Nov 2020 16:45:27 +0100 (CET)
Date:   Thu, 26 Nov 2020 16:45:27 +0100
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
        linux-mm@kvack.org
Subject: Re: [PATCH 23/44] block: remove i_bdev
Message-ID: <20201126154527.GJ422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-24-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:01, Christoph Hellwig wrote:
> Switch the block device lookup interfaces to directly work with a dev_t
> so that struct block_device references are only acquired by the
> blkdev_get variants (and the blk-cgroup special case).  This means that
> we now don't need an extra reference in the inode and can generally
> simplify handling of struct block_device to keep the lookups contained
> in the core block layer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Coly Li <colyli@suse.de>		[bcache]

Looks good to me. Just two nits about comments below. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

>  /**
> - * blkdev_get - open a block device
> - * @bdev: block_device to open
> + * blkdev_get_by_dev - open a block device by device number
> + * @dev: device number of block device to open
>   * @mode: FMODE_* mask
>   * @holder: exclusive holder identifier
>   *
> - * Open @bdev with @mode.  If @mode includes %FMODE_EXCL, @bdev is
> - * open with exclusive access.  Specifying %FMODE_EXCL with %NULL
> - * @holder is invalid.  Exclusive opens may nest for the same @holder.
> + * Open the block device described by device number @dev.  If @mode includes
> + * If @mode includes %FMODE_EXCL, the block device is opened with exclusive
      ^^^ twice "If @mode includes" - here and on previous line...

...
> @@ -776,19 +770,6 @@ struct super_block *__get_super(struct block_device *bdev, bool excl)
>  	return NULL;
>  }
>  
> -/**
> - *	get_super - get the superblock of a device
> - *	@bdev: device to get the superblock for
> - *
> - *	Scans the superblock list and finds the superblock of the file system
> - *	mounted on the device given. %NULL is returned if no match is found.
> - */

I think it would be nice to preserve this comment?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
