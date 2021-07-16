Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2629A3CB5E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhGPKWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhGPKWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:22:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7563C06175F;
        Fri, 16 Jul 2021 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k1yI3xZMljuco026FxHxM/0j0phJa/QvjQkg48mc0YE=; b=hzHCW9Y+Aa/rEziRwzmIBnqaTy
        3aGyHM7oQkEp6gNB0sIw64hQAAkuK8YBie4CGCsFOp1fI1N+pPtgHf8rI0Beuu6tdFq1MN9S7GDn6
        h89UVfXfYi34Dq03MW4rWT5aL//dnILUjzaBH9BhrimyB5ZJrA83uuPBoJPlcTFKz90yitnj+l54R
        GiWDuVltR1MaThRQQh3I4ToK8R2QD7mtuOKKX9muCX0n2wCTu/grpUIu1qEGlgGfrxAb1yZ9GnCwb
        29+V/IGdQ/9RKK/21Oe0yk9hMkTBPn293fjpj9kCztD5Fvk52CO02qt/2x4RU2Em/eRD0IL9PWETO
        2lnnID2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4KwM-000Njv-Kw; Fri, 16 Jul 2021 10:19:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EACC9877DF; Fri, 16 Jul 2021 12:19:29 +0200 (CEST)
Date:   Fri, 16 Jul 2021 12:19:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, paulmck@kernel.org, will@kernel.org
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
Message-ID: <20210716101929.GD4717@worktop.programming.kicks-ass.net>
References: <20210701113537.582120-1-houtao1@huawei.com>
 <20210715070148.GA8088@lst.de>
 <20210715081348.GG2725@worktop.programming.kicks-ass.net>
 <36a122ea-d18a-9317-aadd-b6b69a6f0283@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a122ea-d18a-9317-aadd-b6b69a6f0283@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 05:02:33PM +0800, Hou Tao wrote:

> > Cachelines don't guarantee anything, you can get partial forwards.
> 
> Could you please point me to any reference ? I can not google
> 
> any memory order things by using "partial forwards".

I'm not sure I have references, but there are CPUs that can do, for
example, store forwarding at a granularity below cachelines (ie at
register size).

In such a case a CPU might observe the stored value before it is
committed to memory.


> >>> @@ -224,7 +224,11 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
> >>>  {
> >>>  	struct task_struct *waiter = bio->bi_private;
> >>>  
> >>> -	WRITE_ONCE(bio->bi_private, NULL);
> >>> +	/*
> >>> +	 * Paired with smp_load_acquire in __blkdev_direct_IO_simple()
> >>> +	 * to ensure the order between bi_private and bi_xxx
> >>> +	 */
> > This comment doesn't help me; where are the other stores? Presumably
> > somewhere before this is called, but how does one go about finding them?
> 
> Yes, the change log is vague and it will be corrected. The other stores
> 
> happen in req_bio_endio() and its callees when the request completes.

Aaah, right. So initially I was wondering if it would make sense to put
the barrier there, but having looked at this a little longer, this
really seems to be about these two DIO methods.

> > The Changelog seems to suggest you only care about bi_css, not bi_xxx in
> > general. In specific you can only care about stores that happen before
> > this; is all of bi_xxx written before here? If not, you have to be more
> > specific.
> 
> Actually we care about all bi_xxx which are written in req_bio_endio,
> and all writes to bi_xxx happen before blkdev_bio_end_io_simple().
> Here I just try to use bi_status as one example.

I see req_bio_endio() change bi_status, bi_flags and bi_iter, but afaict
there's more bi_ fields.

> >>> @@ -283,7 +287,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> >>>  	qc = submit_bio(&bio);
> >>>  	for (;;) {
> >>>  		set_current_state(TASK_UNINTERRUPTIBLE);
> >>> -		if (!READ_ONCE(bio.bi_private))
> >>> +		/* Refer to comments in blkdev_bio_end_io_simple() */
> >>> +		if (!smp_load_acquire(&bio.bi_private))
> >>>  			break;
> >>>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> >>>  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> > That comment there doesn't help me find any relevant later loads and is
> > thus again inadequate.
> >
> > Here the purpose seems to be to ensure the bi_css load happens after the
> > bi_private load, and this again is cheaper done using smp_rmb().
> Yes and thanks again.
> >
> > Also, the implication seems to be -- but is not spelled out anywhere --
> > that if bi_private is !NULL, it is stable.
> 
> What is the meaning of "it is stable" ? Do you mean if bi_private is NULL,
> the values of bi_xxx should be ensured ?

With stable I mean that if it is !NULL the value is always the same.

I've read more code and this is indeed the case, specifically, here
bi_private seems to be 'current' and will only be changed to NULL.
