Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54BA2C595E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbgKZQgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 11:36:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390021AbgKZQgW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:36:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF4D3ACE0;
        Thu, 26 Nov 2020 16:36:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E13A1E10D0; Thu, 26 Nov 2020 17:36:20 +0100 (CET)
Date:   Thu, 26 Nov 2020 17:36:20 +0100
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
Subject: Re: [PATCH 27/44] block: simplify part_to_disk
Message-ID: <20201126163620.GM422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-28-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:05, Christoph Hellwig wrote:
> Now that struct hd_struct has a block_device pointer use that to
> find the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Tejun Heo <tj@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/genhd.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 42a51653c7303e..6ba91ee54cb2f6 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -218,13 +218,9 @@ struct gendisk {
>  
>  static inline struct gendisk *part_to_disk(struct hd_struct *part)
>  {
> -	if (likely(part)) {
> -		if (part->partno)
> -			return dev_to_disk(part_to_dev(part)->parent);
> -		else
> -			return dev_to_disk(part_to_dev(part));
> -	}
> -	return NULL;
> +	if (unlikely(!part))
> +		return NULL;
> +	return part->bdev->bd_disk;
>  }
>  
>  static inline int disk_max_parts(struct gendisk *disk)
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
