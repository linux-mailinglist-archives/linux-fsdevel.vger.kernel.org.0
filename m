Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBDD2C59DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbgKZRBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:01:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:36028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391546AbgKZRBb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:01:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8F99ACC4;
        Thu, 26 Nov 2020 17:01:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DBAB1E10D0; Thu, 26 Nov 2020 18:01:29 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:01:29 +0100
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
Subject: Re: [PATCH 34/44] block: move make_it_fail to struct block_device
Message-ID: <20201126170129.GT422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-35-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-35-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:12, Christoph Hellwig wrote:
> Move the make_it_fail flag to struct block_device an turn it into a bool
> in preparation of killing struct hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c          | 3 ++-
>  block/genhd.c             | 4 ++--
>  include/linux/blk_types.h | 3 +++
>  include/linux/genhd.h     | 3 ---
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9a3793d5ce38d4..9121390be97a76 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -668,7 +668,8 @@ __setup("fail_make_request=", setup_fail_make_request);
>  
>  static bool should_fail_request(struct hd_struct *part, unsigned int bytes)
>  {
> -	return part->make_it_fail && should_fail(&fail_make_request, bytes);
> +	return part->bdev->bd_make_it_fail &&
> +		should_fail(&fail_make_request, bytes);
>  }
>  
>  static int __init fail_make_request_debugfs(void)
> diff --git a/block/genhd.c b/block/genhd.c
> index a964e7532fedd5..0371558ccde14c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1284,7 +1284,7 @@ ssize_t part_fail_show(struct device *dev,
>  {
>  	struct hd_struct *p = dev_to_part(dev);
>  
> -	return sprintf(buf, "%d\n", p->make_it_fail);
> +	return sprintf(buf, "%d\n", p->bdev->bd_make_it_fail);
>  }
>  
>  ssize_t part_fail_store(struct device *dev,
> @@ -1295,7 +1295,7 @@ ssize_t part_fail_store(struct device *dev,
>  	int i;
>  
>  	if (count > 0 && sscanf(buf, "%d", &i) > 0)
> -		p->make_it_fail = (i == 0) ? 0 : 1;
> +		p->pdev->bd_make_it_fail = (i == 0) ? 0 : 1;
>  
>  	return count;
>  }
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index c0591e52d7d7ce..b237f1e4081405 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -52,6 +52,9 @@ struct block_device {
>  	struct super_block	*bd_fsfreeze_sb;
>  
>  	struct partition_meta_info *bd_meta_info;
> +#ifdef CONFIG_FAIL_MAKE_REQUEST
> +	bool			bd_make_it_fail;
> +#endif
>  } __randomize_layout;
>  
>  #define bdev_whole(_bdev) \
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index b4a5c05593b99c..349cf6403ccddc 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -56,9 +56,6 @@ struct hd_struct {
>  	struct block_device *bdev;
>  	struct device __dev;
>  	int policy, partno;
> -#ifdef CONFIG_FAIL_MAKE_REQUEST
> -	int make_it_fail;
> -#endif
>  	struct rcu_work rcu_work;
>  };
>  
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
