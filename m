Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B939CF75
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFOQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFOP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 10:15:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7ABC061766;
        Sun,  6 Jun 2021 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tnxs2YjjeULJjYGX8rw24Ya3I/595FxFYvh2Ucj44wg=; b=ohqxNgljMMWf4rGHBLqed8U4TK
        aamqngWDDwb5RSH1wSeFe4yMf05jx0WsgrfEOMNqYk9HWUAH3/jusymOKwa1Rlho34kQrLCl1wVMU
        F7HNu0iPn+0SkvTIQlbA6ETJl0LuzGtcNZORnyE3NhQUk0cw/cLB11ina9Pk26i3ebQo/QJQm4RsS
        lUcrrhGa1VvqrGz5FuN32enwWzpxhniv9+QpKggpoHg62pB9T5qRpa68QCTgfnSLmQZvi4huvpNjS
        BDhZphWW1GS8doH49k/RxUMxaSAz1MD4g25svFeH3Jq8Og0uRJg+VGLTQ3BYwl+VCn3IIoRGbi81J
        yvEuB+fQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lptXD-00Et44-D0; Sun, 06 Jun 2021 14:13:53 +0000
Date:   Sun, 6 Jun 2021 15:13:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/33] mm: Add folio_try_get_rcu
Message-ID: <YLzYH3G3Jg7K2jpE@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-9-willy@infradead.org>
 <YK9VagEO+bKurYlz@infradead.org>
 <YLr9E4tWle9Qa1Xy@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLr9E4tWle9Qa1Xy@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 05, 2021 at 05:26:59AM +0100, Matthew Wilcox wrote:
> On Thu, May 27, 2021 at 09:16:42AM +0100, Christoph Hellwig wrote:
> > On Tue, May 11, 2021 at 10:47:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > > +static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
> > 
> > Should this have a __ prefix and/or a don't use direct comment?
> 
> I think it will get used directly ... its page counterpart is:
> 
> mm/gup.c:       if (unlikely(!page_cache_add_speculative(head, refs)))
> 
> I deliberately left kernel-doc off this function so it's not described,
> but described folio_try_get_rcu() in excruciating detail.  I hope that's
> enough.  There's no comment on page_cache_add_speculative() today, so
> again, we're status quo.

Ok.  Seems a little weird, but so does much in this area.

> > Is this really a good place for the comment?  I'd expect it either near
> > a relevant function or at the top of a file.
> 
> It's right before mapping_get_entry() which is the main lookup function
> for the page cache, so I think it meets your first criteria?

I guess it does, yes.
