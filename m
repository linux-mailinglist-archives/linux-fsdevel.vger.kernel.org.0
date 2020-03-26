Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D8194530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZRQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 13:16:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kzeGasS7YYQLPvzBhzXfybjPCnozbeaYoOmZNc1qJpM=; b=kJhoAEvLJs13WCqIrUDgq07Con
        n33EYLnv/zbKE+if4MQ6Mim05UMpPiTTnU/c68AY3mz089vkkQPt0xySMVedJZnS4zlOUd6bdNzlU
        iLkLXwvUUDTBtePNzV7EtcQkI3HNSg38QfhfMPGT6s54Dbx4WIj9d1PFg/oLtNaNfYGLG6wBSwJKr
        1w31APKig5PViCmMeBocszEw8JjVeBMPzMGNJERL3WItE/s1Dz0S22pH8tIDx8HPSYpmsjcFWMIRw
        qXjXl6OIRHYEhzghj2HcLetGrvZCQy45OvbqQSC9rZprRrjBCIkFnD3DVO0vuzBwdEKKIQSn5ffYr
        vItOk+6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHW6y-0004lW-M6; Thu, 26 Mar 2020 17:16:08 +0000
Date:   Thu, 26 Mar 2020 10:16:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for
 PageWriteback
Message-ID: <20200326171608.GI22483@bombadil.infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-3-willy@infradead.org>
 <20200326171114.GA6566@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326171114.GA6566@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:11:14AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 26, 2020 at 05:24:29AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By moving PG_writeback down into the low bits of the page flags, we can
> > use clear_bit_unlock_is_negative_byte() for writeback as well as the
> > lock bit.  wake_up_page() then has no more callers.  Given the other
> > code being executed between the clear and the test, this is not going
> > to be as dramatic a win as it was for PageLocked, but symmetry between
> > the two is nice and lets us remove some code.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/page-flags.h |  6 +++---
> >  mm/filemap.c               | 19 ++++++-------------
> >  mm/page-writeback.c        | 37 ++++++++++++++++++++-----------------
> >  3 files changed, 29 insertions(+), 33 deletions(-)
> > 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 222f6f7b2bb3..96c7d220c8cf 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -103,13 +103,14 @@
> >   */
> >  enum pageflags {
> >  	PG_locked,		/* Page is locked. Don't touch. */
> > +	PG_writeback,		/* Page is under writeback */
> 
> Do we need a comment why these need to be in the low bits?

There's some nice build time assertions that they are, next to all the
documentation about why and how it all works:

@@ -1266,6 +1259,7 @@ EXPORT_SYMBOL_GPL(add_page_wait_queue);
 void unlock_page(struct page *page)
 {
        BUILD_BUG_ON(PG_waiters != 7);
+       BUILD_BUG_ON(PG_locked > 7);
        page = compound_head(page);
        VM_BUG_ON_PAGE(!PageLocked(page), page);
        if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
@@ -1279,23 +1273,22 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
+       BUILD_BUG_ON(PG_writeback > 7);

so if anyone moves them out of the bottom byte, they'll see those
assertions fail and hopefully read this comment:

 * Note that this depends on PG_waiters being the sign bit in the byte
 * that contains PG_locked - thus the BUILD_BUG_ON(). That allows us to
 * clear the PG_locked bit and test PG_waiters at the same time fairly
 * portably (architectures that do LL/SC can test any bit, while x86 can
 * test the sign bit).

I'd expect any reviewer to notice a BUILD_BUG_ON() being removed and
query it if not explained in the changelog.
