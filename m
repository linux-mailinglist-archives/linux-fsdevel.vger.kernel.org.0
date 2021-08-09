Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0B3E491B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhHIPrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:47:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56086 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:47:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3473620022;
        Mon,  9 Aug 2021 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628524049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmshEYCepuicqe7nGBsgApKga31dwcT/zEh+RqblNMs=;
        b=agM0VX0VPGuoPOIl/2H+VcE1o5AGK3BCM4UnBUI6MYNqlkRAI/3H4VoB5qA84W3kjSlTfD
        Z9ggSkT9XnFWSO25m6csQs3+JNzxpFQnZJeOuJ1+mk1sBUpUe2/ceH/SsQh8Hr5QZ8dKFK
        jN+xSHRj4A3B7EHDhGEf6s7R+YbGGrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628524049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmshEYCepuicqe7nGBsgApKga31dwcT/zEh+RqblNMs=;
        b=XLUJqXiPPDvzdKKUd1LQ7osqEEWYNMxwNToii1Ge7QTyGP+5QXUiWk9L9Qv6u3Ke1QAWD4
        0w33iFAws9hdA+DA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1FCC2A3B81;
        Mon,  9 Aug 2021 15:47:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F2C0A1E3BFC; Mon,  9 Aug 2021 17:47:28 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:47:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
Message-ID: <20210809154728.GH30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141744.1203023-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 16:17:43, Christoph Hellwig wrote:
> The backing device information only makes sense for file system I/O,
> and thus belongs into the gendisk and not the lower level request_queue
> structure.  Move it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks mostly good. I'm just unsure whether some queue_to_disk() calls are
safe.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c4ac51e54eb..d2725f94491d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -525,7 +525,7 @@ void blk_mq_free_request(struct request *rq)
>  		__blk_mq_dec_active_requests(hctx);
>  
>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
> -		laptop_io_completion(q->backing_dev_info);
> +		laptop_io_completion(queue_to_disk(q)->bdi);
> 

E.g. cannot this get called for a queue that is without a disk?

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 3ed71b8da887..31086afaad9c 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -97,7 +97,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
>   */
>  static bool wb_recent_wait(struct rq_wb *rwb)
>  {
> -	struct bdi_writeback *wb = &rwb->rqos.q->backing_dev_info->wb;
> +	struct bdi_writeback *wb = &queue_to_disk(rwb->rqos.q)->bdi->wb;
>  
>  	return time_before(jiffies, wb->dirty_sleep + HZ);
>  }
> @@ -234,7 +234,7 @@ enum {
>  
>  static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  {
> -	struct backing_dev_info *bdi = rwb->rqos.q->backing_dev_info;
> +	struct backing_dev_info *bdi = queue_to_disk(rwb->rqos.q)->bdi;
>  	struct rq_depth *rqd = &rwb->rq_depth;
>  	u64 thislat;
>  
> @@ -287,7 +287,7 @@ static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  
>  static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
>  {
> -	struct backing_dev_info *bdi = rwb->rqos.q->backing_dev_info;
> +	struct backing_dev_info *bdi = queue_to_disk(rwb->rqos.q)->bdi;
>  	struct rq_depth *rqd = &rwb->rq_depth;
>  
>  	trace_wbt_step(bdi, msg, rqd->scale_step, rwb->cur_win_nsec,
> @@ -359,8 +359,8 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
>  
>  	status = latency_exceeded(rwb, cb->stat);
>  
> -	trace_wbt_timer(rwb->rqos.q->backing_dev_info, status, rqd->scale_step,
> -			inflight);
> +	trace_wbt_timer(queue_to_disk(rwb->rqos.q)->bdi, status,
> +			rqd->scale_step, inflight);
>  
>  	/*
>  	 * If we exceeded the latency target, step down. If we did not,

Or all these calls - is wbt guaranteed to only be setup for a queue with
disk?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
