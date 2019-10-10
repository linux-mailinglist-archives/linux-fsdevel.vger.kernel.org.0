Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E520D26E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfJJKFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 06:05:31 -0400
Received: from verein.lst.de ([213.95.11.211]:57353 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfJJKFb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:05:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE1A268C65; Thu, 10 Oct 2019 12:05:26 +0200 (CEST)
Date:   Thu, 10 Oct 2019 12:05:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 10/12] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
Message-ID: <20191010100526.GA27209@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-12-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -319,7 +319,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	rq->cmd_flags = op;
>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>  		rq->rq_flags |= RQF_PREEMPT;
> -	if (blk_queue_io_stat(data->q))
> +	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
>  		rq->rq_flags |= RQF_IO_STAT;

This needs a comment why we don't account passthrough requests by
default.  And I'm really curious about the answer, because I don't
know it myself.

>   *	a) it's attached to a gendisk, and
>   *	b) the queue had IO stats enabled when this request was started, and
> - *	c) it's a file system request
> + *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)

c) should just go away now based on your changes.

>  static inline bool blk_do_io_stat(struct request *rq)
>  {
>  	return rq->rq_disk &&
> -	       (rq->rq_flags & RQF_IO_STAT) &&
> -		!blk_rq_is_passthrough(rq);
> +	       (rq->rq_flags & RQF_IO_STAT);

The check can be collapsed onto a single line now.
