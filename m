Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917C5302FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiEVMVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiEVMVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:21:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF912D33
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TRaJ+WxtTKiWzQ2HHXgCSRjcxXfzUt+lZEwV5j4uP+8=; b=swNRVIOWC9fR6rk8M5b3WSVvIk
        BFRfT779TH+FURGy7G5nMLv68E255YxMyV4mzytdpWUi3oUKdZHdbTHyGyteyAGeozdY8HVDGQiuv
        zopzZ3qw2fM3AhL/DwPO6Af90Fns96uY3RrkW0E3WlNmq/Ow3yWMfkduEXitMMa/CzHRPqKOY6vep
        8ZwxO7bfg4d9fplXunqY0/cC26Hk8wljFA5DiC8ewMGnaLrUs1eCuR74hLyWNB8MNBChUOBEuJ7E1
        XZvWKf5uQJ2eJAuMn7Tgu73YvnzlyMkhFAahR9u36LD+si95jLRuA7DLQ732AzUK0nlebRc0Tu1aR
        4qcZwPNQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nskaO-00HApY-9Y; Sun, 22 May 2022 12:21:28 +0000
Date:   Sun, 22 May 2022 12:21:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YooqyNJ3NbX5p8mx@zeniv-ca.linux.org.uk>
References: <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de>
 <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoobb6GZPbNe7s0/@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:15:59PM +0100, Matthew Wilcox wrote:
> On Sun, May 22, 2022 at 10:36:00AM +0000, Al Viro wrote:
> > On Sun, May 22, 2022 at 11:23:43AM +0100, Matthew Wilcox wrote:
> > > On Sun, May 22, 2022 at 09:45:09AM +0200, Christoph Hellwig wrote:
> > > > On Sat, May 21, 2022 at 04:14:07PM -0600, Jens Axboe wrote:
> > > > > Then we're almost on par, and it looks like we just need to special case
> > > > > iov_iter_advance() for the nr_segs == 1 as well to be on par. This is on
> > > > > top of your patch as well, fwiw.
> > > > > 
> > > > > It might make sense to special case the single segment cases, for both
> > > > > setup, iteration, and advancing. With that, I think we'll be where we
> > > > > want to be, and there will be no discernable difference between the iter
> > > > > paths and the old style paths.
> > > > 
> > > > A while ago willy posted patches to support a new ITER type for direct
> > > > userspace pointer without iov.  It might be worth looking through the
> > > > archives and test that.
> > > 
> > > https://lore.kernel.org/linux-fsdevel/Yba+YSF6mkM%2FGYlK@casper.infradead.org/
> > 
> > 	Direct kernel pointer, surely?  And from a quick look,
> > iov_iter_is_kaddr() checks for the wrong value...
> 
> Indeed.  I didn't test it; it was a quick patch to see if the idea was
> worth pursuing.  Neither you nor Christoph thought so at the time, so
> I dropped it.  if there are performance improvements to be had from
> doing something like that, it's a more compelling idea than just "Hey,
> this removes a few lines of code and a bit of stack space from every
> caller".

Depends; I rather doubt that it would be useful for kvec case, but iovec
one like that...  The only thing that worries me here is the code generation
for the cascades of ifs in lib/iov_iter.c - that'd need profiling.

And it's orthogonal to the overhead in new_sync_{read,write}(), obviously.
