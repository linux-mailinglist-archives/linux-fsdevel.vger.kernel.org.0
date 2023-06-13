Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825172EC25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjFMTn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFMTn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A242119;
        Tue, 13 Jun 2023 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SbOrBNl7cmyaiQLaX1HMgZ6eU0QFBLUBum9wQQkMpbs=; b=lkJbXxtjGI00bYILWss7q3hiER
        lCDoKDKohBwlFT7TUzLMhICaVuCdIyKHyHLJQhJ1r6MDoehEPUg/ezzBqZjRSZ6uZqcM5QIjgEWgq
        SazmGTJz/yjMgprtZD9PCGQpBC3eNW726A+MlYZNOV9PZbVcPgBeg5cz7G1uFNRqIet5mBLZTdKAh
        Z7FRcdMwK945mjcdx2VClecWmgkIuRNTylyqBb2nw7CeN6G+TFUD8dfRM2BwFRZwyWYsZKdgK7GhR
        pTi1CzBC1WEYOEyTe1R1KZ9tJq7Qz0WfQhycAR80DRZTQXutG0jFvwU6FuIBc19YbqD4BvbZD+UQZ
        p15/+CxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q99vh-004G58-WF; Tue, 13 Jun 2023 19:43:50 +0000
Date:   Tue, 13 Jun 2023 20:43:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Message-ID: <ZIjG9Rc7s89oUbxF@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-9-willy@infradead.org>
 <ZIf3jom4xteSmj5/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIf3jom4xteSmj5/@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:58:54PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 12, 2023 at 09:39:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
> > Start at the maximum page cache size and shrink by half every time we
> > hit the "we are short on memory" problem.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index a5d62c9640cf..818dc350ffc5 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -768,6 +768,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  {
> >  	loff_t length = iomap_length(iter);
> > +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
> 
> This could overflow if the chunk size ends up bigger than 4GB, but
> I guess that's mostly theoretical.

I don't think it can ... we currently restrict it to PMD_SIZE if THP are
enabled and order-8 if they're not.  I could add a MAX_PAGECACHE_SIZE if
needed, but PAGE_SIZE is 'unsigned long' on most if not all platforms,
so it's always the same size as size_t.  We definitely can't create
folios larger than size_t, so MAX_PAGECACHE_ORDER is never going to be
defined such that PAGE_SIZE << MAX_PAGECACHE_ORDER cannot fit in size_t.

The largest I can see it going would be on something like PowerPC with
its 16GB page size, and there we definitely have 1UL << PAGE_SHIFT.

> > -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> > +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> 
> Would be nice t avoid the overly long line here

The plan is to turn that into:

		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);

in the fairly near future.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
