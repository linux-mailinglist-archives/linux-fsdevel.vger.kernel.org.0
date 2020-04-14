Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9058B1A8181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436954AbgDNPJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:09:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436635AbgDNPJe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:09:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D6F4ACB1;
        Tue, 14 Apr 2020 15:09:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2555C1E125F; Tue, 14 Apr 2020 17:09:29 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:09:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, tj@kernel.org,
        bigeasy@linutronix.de, linfeilong <linfeilong@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        renxudong <renxudong1@huawei.com>
Subject: Re: [PATCH] buffer: remove useless comment and
 WB_REASON_FREE_MORE_MEM, reason.
Message-ID: <20200414150929.GD28226@quack2.suse.cz>
References: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 13:12:10, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> free_more_memory func has been completely removed in commit bc48f001de12
> ("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")
> 
> So comment and `WB_REASON_FREE_MORE_MEM` reason about free_more_memory
> are no longer needed.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Thanks. The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                      | 2 +-
>  include/linux/backing-dev-defs.h | 1 -
>  include/trace/events/writeback.h | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b8d28370cfd7..07ab0405f3f5 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -973,7 +973,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
>  	struct page *page;
>  	struct buffer_head *bh;
>  	sector_t end_block;
> -	int ret = 0;		/* Will call free_more_memory() */
> +	int ret = 0;
>  	gfp_t gfp_mask;
> 
>  	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 4fc87dee005a..ee577a83cfe6 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -54,7 +54,6 @@ enum wb_reason {
>  	WB_REASON_SYNC,
>  	WB_REASON_PERIODIC,
>  	WB_REASON_LAPTOP_TIMER,
> -	WB_REASON_FREE_MORE_MEM,
>  	WB_REASON_FS_FREE_SPACE,
>  	/*
>  	 * There is no bdi forker thread any more and works are done
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index d94def25e4dc..85a33bea76f1 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -36,7 +36,6 @@
>  	EM( WB_REASON_SYNC,			"sync")			\
>  	EM( WB_REASON_PERIODIC,			"periodic")		\
>  	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
> -	EM( WB_REASON_FREE_MORE_MEM,		"free_more_memory")	\
>  	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
>  	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")
> 
> -- 
> 2.19.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
