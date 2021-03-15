Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0391433AF3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhCOJsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:48:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhCOJsG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:48:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AD2CAE27;
        Mon, 15 Mar 2021 09:48:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EAFE61E423D; Mon, 15 Mar 2021 10:48:01 +0100 (CET)
Date:   Mon, 15 Mar 2021 10:48:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        viro@zeniv.linux.org.uk, hch@infradead.org, axboe@kernel.dk,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Subject: Re: [RFC PATCH 2/3] block_dump: remove block_dump feature
Message-ID: <20210315094801.GB3227@quack2.suse.cz>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
 <20210313030146.2882027-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313030146.2882027-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 13-03-21 11:01:45, zhangyi (F) wrote:
> We have already delete block_dump feature in mark_inode_dirty() because
> it can be replaced by tracepoints, now we also remove the part in
> submit_bio() for the same reason. The part of block dump feature in
> submit_bio() dump the write process, write region and sectors on the
> target disk into kernel message. it can be replaced by
> block_bio_queue tracepoint in submit_bio_checks(), so we do not need
> block_dump anymore, remove the whole block_dump feature.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c          | 9 ---------
>  include/linux/writeback.h | 1 -
>  kernel/sysctl.c           | 8 --------
>  mm/page-writeback.c       | 5 -----
>  4 files changed, 23 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..9731b0ca8166 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1086,15 +1086,6 @@ blk_qc_t submit_bio(struct bio *bio)
>  			task_io_account_read(bio->bi_iter.bi_size);
>  			count_vm_events(PGPGIN, count);
>  		}
> -
> -		if (unlikely(block_dump)) {
> -			char b[BDEVNAME_SIZE];
> -			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
> -			current->comm, task_pid_nr(current),
> -				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
> -				(unsigned long long)bio->bi_iter.bi_sector,
> -				bio_devname(bio, b), count);
> -		}
>  	}
>  
>  	/*
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 8e5c5bb16e2d..9ef50176f3a1 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -360,7 +360,6 @@ extern unsigned int dirty_writeback_interval;
>  extern unsigned int dirty_expire_interval;
>  extern unsigned int dirtytime_expire_interval;
>  extern int vm_highmem_is_dirtyable;
> -extern int block_dump;
>  extern int laptop_mode;
>  
>  int dirty_background_ratio_handler(struct ctl_table *table, int write,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09b5dc1..35fce9a8402f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2957,14 +2957,6 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{
> -		.procname	= "block_dump",
> -		.data		= &block_dump,
> -		.maxlen		= sizeof(block_dump),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -	},
>  	{
>  		.procname	= "vfs_cache_pressure",
>  		.data		= &sysctl_vfs_cache_pressure,
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eb34d204d4ee..b72da123f242 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -108,11 +108,6 @@ EXPORT_SYMBOL_GPL(dirty_writeback_interval);
>   */
>  unsigned int dirty_expire_interval = 30 * 100; /* centiseconds */
>  
> -/*
> - * Flag that makes the machine dump writes/reads and block dirtyings.
> - */
> -int block_dump;
> -
>  /*
>   * Flag that puts the machine in "laptop mode". Doubles as a timeout in jiffies:
>   * a full sync is triggered after this time elapses without any disk activity.
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
