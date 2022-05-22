Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67292530297
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiEVLQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 07:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiEVLQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 07:16:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D02018C
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZNQybKMaaslItNUoQAUvyHXlNNcSXqL8ME22a1luRs=; b=Af26BxXdEn7bREbLfmqD5CC9oR
        Xkco8pgRyDy97krZg4GyNhQeoHMpg5wuGSPA3JIChT6Xhcg1CsQxXLRZfSU+RrM1GaXmh/uVO7kBj
        c6JMI65LV9sbF6nqFua7mlP2xE0h0Y3OW+u3Yr0HpTVG9nQh+Adv5Y/YnnTcOM96Axt7KAOpOGW9e
        JCVJo7/d1BDypVA3+8UYOAFNW6Ol2Cnq0ak2RQOT8dDstrpE8KqUjBP3Nhg2m0nFl3AN1Lugj7SBW
        3aaeL6TgQxFhJTSHHlmEpeyWKE/BrBH+JvyVXNk8dVvYOQVDCphDQMfuEbNH9ubia2n/cv19dTe40
        FDFp8IqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsjZ1-00FKKr-76; Sun, 22 May 2022 11:15:59 +0000
Date:   Sun, 22 May 2022 12:15:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <Yoobb6GZPbNe7s0/@casper.infradead.org>
References: <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de>
 <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 10:36:00AM +0000, Al Viro wrote:
> On Sun, May 22, 2022 at 11:23:43AM +0100, Matthew Wilcox wrote:
> > On Sun, May 22, 2022 at 09:45:09AM +0200, Christoph Hellwig wrote:
> > > On Sat, May 21, 2022 at 04:14:07PM -0600, Jens Axboe wrote:
> > > > Then we're almost on par, and it looks like we just need to special case
> > > > iov_iter_advance() for the nr_segs == 1 as well to be on par. This is on
> > > > top of your patch as well, fwiw.
> > > > 
> > > > It might make sense to special case the single segment cases, for both
> > > > setup, iteration, and advancing. With that, I think we'll be where we
> > > > want to be, and there will be no discernable difference between the iter
> > > > paths and the old style paths.
> > > 
> > > A while ago willy posted patches to support a new ITER type for direct
> > > userspace pointer without iov.  It might be worth looking through the
> > > archives and test that.
> > 
> > https://lore.kernel.org/linux-fsdevel/Yba+YSF6mkM%2FGYlK@casper.infradead.org/
> 
> 	Direct kernel pointer, surely?  And from a quick look,
> iov_iter_is_kaddr() checks for the wrong value...

Indeed.  I didn't test it; it was a quick patch to see if the idea was
worth pursuing.  Neither you nor Christoph thought so at the time, so
I dropped it.  if there are performance improvements to be had from
doing something like that, it's a more compelling idea than just "Hey,
this removes a few lines of code and a bit of stack space from every
caller".
