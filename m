Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8D2B86BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKRVei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:34:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:51916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgKRVe0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:34:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF58DAFFD;
        Wed, 18 Nov 2020 21:34:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BC1911E1321; Wed, 18 Nov 2020 15:22:37 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:22:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 06/20] block: change the hash used for looking up block
 devices
Message-ID: <20201118142237.GK1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:46, Christoph Hellwig wrote:
> Adding the minor to the major creates tons of pointless conflicts. Just
> use the dev_t itself, which is 32-bits and thus is guaranteed to fit
> into ino_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Fair enough. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d8664f5c1ff669..29db12c3bb501c 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -870,35 +870,12 @@ void __init bdev_cache_init(void)
>  	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
>  }
>  
> -/*
> - * Most likely _very_ bad one - but then it's hardly critical for small
> - * /dev and can be fixed when somebody will need really large one.
> - * Keep in mind that it will be fed through icache hash function too.
> - */
> -static inline unsigned long hash(dev_t dev)
> -{
> -	return MAJOR(dev)+MINOR(dev);
> -}
> -
> -static int bdev_test(struct inode *inode, void *data)
> -{
> -	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
> -}
> -
> -static int bdev_set(struct inode *inode, void *data)
> -{
> -	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
> -	return 0;
> -}
> -
>  static struct block_device *bdget(dev_t dev)
>  {
>  	struct block_device *bdev;
>  	struct inode *inode;
>  
> -	inode = iget5_locked(blockdev_superblock, hash(dev),
> -			bdev_test, bdev_set, &dev);
> -
> +	inode = iget_locked(blockdev_superblock, dev);
>  	if (!inode)
>  		return NULL;
>  
> @@ -910,6 +887,7 @@ static struct block_device *bdget(dev_t dev)
>  		bdev->bd_super = NULL;
>  		bdev->bd_inode = inode;
>  		bdev->bd_part_count = 0;
> +		bdev->bd_dev = dev;
>  		inode->i_mode = S_IFBLK;
>  		inode->i_rdev = dev;
>  		inode->i_bdev = bdev;
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
