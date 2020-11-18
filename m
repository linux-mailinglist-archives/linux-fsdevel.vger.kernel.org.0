Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE12B86A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRVe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:34:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKRVeZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:34:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05AD8B004;
        Wed, 18 Nov 2020 21:34:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F52B1E1325; Wed, 18 Nov 2020 15:37:47 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:37:47 +0100
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
Subject: Re: [PATCH 07/20] init: refactor name_to_dev_t
Message-ID: <20201118143747.GL1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:47, Christoph Hellwig wrote:
> Split each case into a self-contained helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/genhd.h |   7 +-
>  init/do_mounts.c      | 183 +++++++++++++++++++++---------------------
>  2 files changed, 91 insertions(+), 99 deletions(-)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 22f5b9fd96f8bf..ca5e356084c353 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -388,18 +388,13 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
>  }
>  #endif /* CONFIG_SYSFS */
>  
> +dev_t blk_lookup_devt(const char *name, int partno);
>  #ifdef CONFIG_BLOCK
>  void printk_all_partitions(void);
> -dev_t blk_lookup_devt(const char *name, int partno);
>  #else /* CONFIG_BLOCK */
>  static inline void printk_all_partitions(void)
>  {
>  }
> -static inline dev_t blk_lookup_devt(const char *name, int partno)
> -{
> -	dev_t devt = MKDEV(0, 0);
> -	return devt;
> -}
>  #endif /* CONFIG_BLOCK */

This hunk looks unrelated to the change? Also why you move the declaration
outside the CONFIG_BLOCK ifdef? AFAICS blk_lookup_devt() still exists only
when CONFIG_BLOCK is defined? Otherwise the patch looks good to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
