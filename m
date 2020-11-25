Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72732C413E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 14:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKYNhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 08:37:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:54666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKYNhl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:37:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A70EAC22;
        Wed, 25 Nov 2020 13:37:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 658EF1E130F; Wed, 25 Nov 2020 14:37:39 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:37:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
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
Subject: Re: [PATCH 08/45] loop: do not call set_blocksize
Message-ID: <20201125133739.GK16944@quack2.suse.cz>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 14:27:14, Christoph Hellwig wrote:
> set_blocksize is used by file systems to use their preferred buffer cache
> block size.  Block drivers should not set it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9a27d4f1c08aac..b42c728620c9e4 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1164,9 +1164,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	size = get_loop_size(lo, file);
>  	loop_set_size(lo, size);
>  
> -	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
> -		      block_size(inode->i_bdev) : PAGE_SIZE);
> -
>  	lo->lo_state = Lo_bound;
>  	if (part_shift)
>  		lo->lo_flags |= LO_FLAGS_PARTSCAN;
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
