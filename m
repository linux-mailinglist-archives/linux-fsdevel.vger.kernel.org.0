Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731363E4E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhHIVaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 17:30:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57106 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhHIV37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:29:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C2FB21F6C;
        Mon,  9 Aug 2021 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628544577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMQNCsfM55EcDNGyuVeZ/Y95f0u1E88irWEda0U0VhM=;
        b=Qyhsi29JZSoTngsj/2wl6iGcB+tfYHcXf9Ibdj+Ogl0+YMIdj/OQQtMaOPJKbd5P2fcrsk
        x34It64TOdssJNHD7D20il83KqmH2nMT5KrNzMP1XnqA86V3DOyWeqGIR1LE/BRoGCkKJj
        UGhvprc0zfFwj2dypqr5JDNQFfLgeTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628544577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMQNCsfM55EcDNGyuVeZ/Y95f0u1E88irWEda0U0VhM=;
        b=j/p5lE3P0VRMmomkyOqEGMqgyc6eC5IkwVwcnBe9Wd0S4rFC5df1no8lez/Y4/5kbgyQR9
        BZLBIkZcvF54ELCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 692E8A3B81;
        Mon,  9 Aug 2021 21:29:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 16E9C1E3BFC; Mon,  9 Aug 2021 23:29:34 +0200 (CEST)
Date:   Mon, 9 Aug 2021 23:29:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
Message-ID: <20210809212934.GK30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-5-hch@lst.de>
 <20210809154728.GH30319@quack2.suse.cz>
 <2c007f99-b8f1-3f84-7575-cb6934704388@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c007f99-b8f1-3f84-7575-cb6934704388@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 11:57:42, Jens Axboe wrote:
> On 8/9/21 9:47 AM, Jan Kara wrote:
> > On Mon 09-08-21 16:17:43, Christoph Hellwig wrote:
> >> The backing device information only makes sense for file system I/O,
> >> and thus belongs into the gendisk and not the lower level request_queue
> >> structure.  Move it there.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Looks mostly good. I'm just unsure whether some queue_to_disk() calls are
> > safe.
> > 
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 2c4ac51e54eb..d2725f94491d 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -525,7 +525,7 @@ void blk_mq_free_request(struct request *rq)
> >>  		__blk_mq_dec_active_requests(hctx);
> >>  
> >>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
> >> -		laptop_io_completion(q->backing_dev_info);
> >> +		laptop_io_completion(queue_to_disk(q)->bdi);
> >>
> > 
> > E.g. cannot this get called for a queue that is without a disk?
> 
> Should be fine, as it's checking for passthrough. Maybe famous last
> words, but we should not be seeing regular IO before disk is setup.
> 
> >> @@ -359,8 +359,8 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
> >>  
> >>  	status = latency_exceeded(rwb, cb->stat);
> >>  
> >> -	trace_wbt_timer(rwb->rqos.q->backing_dev_info, status, rqd->scale_step,
> >> -			inflight);
> >> +	trace_wbt_timer(queue_to_disk(rwb->rqos.q)->bdi, status,
> >> +			rqd->scale_step, inflight);
> >>  
> >>  	/*
> >>  	 * If we exceeded the latency target, step down. If we did not,
> > 
> > Or all these calls - is wbt guaranteed to only be setup for a queue with
> > disk?
> 
> Same for this one.

OK, fair enough then. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
