Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A532BAADF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKTNN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTNN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:13:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8CC0613CF;
        Fri, 20 Nov 2020 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UNGYsBY/khY0Vu+YBGbKVPOSDJ0AVIn1YTEZ9g4Y9NU=; b=UFK+VqXdAyM/fiUFLEwvgS9cYv
        Lt0w/nGUYPGfjiVsCtRcFlR+bCMSSdPxNOokr9C1goXukwNlLOZSyD9qBgOvD7t9dU/HJ5vCZ5uX0
        aHbE0IUexhUHm4x7S0/7nEo4yCkwCFUto4HKGHfPIK7OoPe25yfJZ18ZdTED0uROjK4SG3fD4aOP6
        1ewgRqusB6X/bfbJ00cHBPVOlsgW2hUuLcRH07bIIUbRx9XSfTD4VbN8NLcFQHeSxeCSVOG/TVuTv
        QSrPzrSrvubCvZNdJ34P01iMvzVQ+Y9E+qimQakF8sNxFfiEkKNnurv2HYWl5ocFrFn4TNlvpuAZY
        2hGx0/uw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg6Ea-0002Am-Lh; Fri, 20 Nov 2020 13:13:52 +0000
Date:   Fri, 20 Nov 2020 13:13:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120131352.GO29991@casper.infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
 <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
 <20201120025457.GM29991@casper.infradead.org>
 <20201120081429.GA30801@infradead.org>
 <20201120123931.GN29991@casper.infradead.org>
 <c14607c3-2fdd-4acf-e379-a8cde461c753@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14607c3-2fdd-4acf-e379-a8cde461c753@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:00:37PM +0000, Pavel Begunkov wrote:
> On 20/11/2020 12:39, Matthew Wilcox wrote:
> > On Fri, Nov 20, 2020 at 08:14:29AM +0000, Christoph Hellwig wrote:
> >> On Fri, Nov 20, 2020 at 02:54:57AM +0000, Matthew Wilcox wrote:
> >>> On Fri, Nov 20, 2020 at 02:25:08AM +0000, Pavel Begunkov wrote:
> >>>> On 20/11/2020 02:22, Ming Lei wrote:
> >>>>> iov_iter_npages(bvec) still can be improved a bit by the following way:
> >>>>
> >>>> Yep, was doing exactly that, +a couple of other places that are in my way.
> >>>
> >>> Are you optimising the right thing here?  Assuming you're looking at
> >>> the one in do_blockdev_direct_IO(), wouldn't we be better off figuring
> >>> out how to copy the bvecs directly from the iov_iter into the bio
> >>> rather than calling dio_bio_add_page() for each page?
> >>
> >> Which is most effectively done by stopping to to use *blockdev_direct_IO
> >> and switching to iomap instead :)
> > 
> > But iomap still calls iov_iter_npages().  So maybe we need something like
> > this ...
> 
> Yep, all that are not mutually exclusive optimisations.
> Why `return 1`? It seems to be used later in bio_alloc(nr_pages)

because 0 means "no pages".  It does no harm to allocate one biovec
that we then don't use.

> > -	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> > +	nr_pages = bio_iov_iter_npages(dio->submit.iter);
> >  	if (nr_pages <= 0) {
            ^^^^^^^^^^^^^

> > -		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> > +		nr_pages = bio_iov_iter_npages(dio->submit.iter);
> >  		iomap_dio_submit_bio(dio, iomap, bio, pos);
> >  		pos += n;
> >  	} while (nr_pages);
                 ^^^^^^^^

