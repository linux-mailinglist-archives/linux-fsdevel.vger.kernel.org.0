Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE32C4146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 14:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgKYNjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 08:39:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgKYNjW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCF50AC23;
        Wed, 25 Nov 2020 13:39:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8ACF21E130F; Wed, 25 Nov 2020 14:39:20 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:39:20 +0100
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
Subject: Re: [PATCH 12/45] block: remove a superflous check in blkpg_do_ioctl
Message-ID: <20201125133920.GL16944@quack2.suse.cz>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-13-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 14:27:18, Christoph Hellwig wrote:
> sector_t is now always a u64, so this check is not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/ioctl.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6b785181344fe1..0c09bb7a6ff35f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -35,15 +35,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  	start = p.start >> SECTOR_SHIFT;
>  	length = p.length >> SECTOR_SHIFT;
>  
> -	/* check for fit in a hd_struct */
> -	if (sizeof(sector_t) < sizeof(long long)) {
> -		long pstart = start, plength = length;
> -
> -		if (pstart != start || plength != length || pstart < 0 ||
> -		    plength < 0 || p.pno > 65535)
> -			return -EINVAL;
> -	}
> -
>  	switch (op) {
>  	case BLKPG_ADD_PARTITION:
>  		/* check if partition is aligned to blocksize */
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
