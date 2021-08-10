Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1756A3E7DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 18:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhHJQoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 12:44:37 -0400
Received: from verein.lst.de ([213.95.11.211]:37040 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236256AbhHJQod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:44:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 898A268B05; Tue, 10 Aug 2021 18:44:07 +0200 (CEST)
Date:   Tue, 10 Aug 2021 18:44:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
Message-ID: <20210810164407.GA20662@lst.de>
References: <20210809141744.1203023-1-hch@lst.de> <20210809141744.1203023-5-hch@lst.de> <20210809154728.GH30319@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809154728.GH30319@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 05:47:28PM +0200, Jan Kara wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 2c4ac51e54eb..d2725f94491d 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -525,7 +525,7 @@ void blk_mq_free_request(struct request *rq)
> >  		__blk_mq_dec_active_requests(hctx);
> >  
> >  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
> > -		laptop_io_completion(q->backing_dev_info);
> > +		laptop_io_completion(queue_to_disk(q)->bdi);
> > 
> 
> E.g. cannot this get called for a queue that is without a disk?

As Jens already explained we need the gendisk for non-passthrough
commands.  Same for the wbt case.
