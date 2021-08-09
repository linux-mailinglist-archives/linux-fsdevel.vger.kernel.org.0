Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767883E4862
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhHIPLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:11:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50882 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbhHIPLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:11:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 300281FFFE;
        Mon,  9 Aug 2021 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628521851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atlo+NKpDCTCwZ+7e0Seb6ZvJdkbk7+6VcZA+tEAelY=;
        b=c/zsLCNQKeumCIxTiEcdWgfEDGcQHDy91K994MFxGQ4076JkmRJZlYy8Pma2zcJoGNt73A
        +vjbUfTuU6Pl5Thm5zvxkFVY2fYtIKGsrDmAxnbqDLT+cZtc9qgNh+lM8L7NcNNS2ZJL1w
        ZzOCvYkKEeCQ2KLICXZWRuoH7mr94b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628521851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atlo+NKpDCTCwZ+7e0Seb6ZvJdkbk7+6VcZA+tEAelY=;
        b=Dwdl7Ioju78ovvw3zBk5O60RylkYJghFcimUW6fMrUywG8vev4HpLDT8neW8a5v/GqlI9a
        xSkpv15AFa2NQwBA==
Received: from quack2.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1B08FA3B8E;
        Mon,  9 Aug 2021 15:10:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 70ACF1E3BFC; Mon,  9 Aug 2021 17:10:48 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:10:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the
 BDI API
Message-ID: <20210809151048.GE30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809141744.1203023-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 16:17:40, Christoph Hellwig wrote:
> Don't leak the detaіls of the timer into the block layer, instead
> initialize the timer in bdi_alloc and delete it in bdi_unregister.
> Note that this means the timer is initialized (but not armed) for
> non-block queues as well now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c    | 5 -----
>  mm/backing-dev.c    | 3 +++
>  mm/page-writeback.c | 2 --
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 04477697ee4b..5897bc37467d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -394,10 +394,7 @@ void blk_cleanup_queue(struct request_queue *q)
>  	/* for synchronous bio-based driver finish in-flight integrity i/o */
>  	blk_flush_integrity();
>  
> -	/* @q won't process any more request, flush async actions */
> -	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
>  	blk_sync_queue(q);
> -
>  	if (queue_is_mq(q))
>  		blk_mq_exit_queue(q);
>  
> @@ -546,8 +543,6 @@ struct request_queue *blk_alloc_queue(int node_id)
>  
>  	atomic_set(&q->nr_active_requests_shared_sbitmap, 0);
>  
> -	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
> -		    laptop_mode_timer_fn, 0);
>  	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
>  	INIT_WORK(&q->timeout_work, blk_timeout_work);
>  	INIT_LIST_HEAD(&q->icq_list);
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index f5561ea7d90a..cd06dca232c3 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -807,6 +807,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
>  	bdi->capabilities = BDI_CAP_WRITEBACK | BDI_CAP_WRITEBACK_ACCT;
>  	bdi->ra_pages = VM_READAHEAD_PAGES;
>  	bdi->io_pages = VM_READAHEAD_PAGES;
> +	timer_setup(&bdi->laptop_mode_wb_timer, laptop_mode_timer_fn, 0);
>  	return bdi;
>  }
>  EXPORT_SYMBOL(bdi_alloc);
> @@ -928,6 +929,8 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
>  
>  void bdi_unregister(struct backing_dev_info *bdi)
>  {
> +	del_timer_sync(&bdi->laptop_mode_wb_timer);
> +
>  	/* make sure nobody finds us on the bdi_list anymore */
>  	bdi_remove_from_list(bdi);
>  	wb_shutdown(&bdi->wb);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 9f63548f247c..c12f67cbfa19 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2010,7 +2010,6 @@ int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_BLOCK
>  void laptop_mode_timer_fn(struct timer_list *t)
>  {
>  	struct backing_dev_info *backing_dev_info =
> @@ -2045,7 +2044,6 @@ void laptop_sync_completion(void)
>  
>  	rcu_read_unlock();
>  }
> -#endif
>  
>  /*
>   * If ratelimit_pages is too high then we can get into dirty-data overload
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
