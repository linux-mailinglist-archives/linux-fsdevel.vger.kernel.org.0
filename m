Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C835444DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 04:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhKDDrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhKDDrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:47:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879ABC061714;
        Wed,  3 Nov 2021 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cnhGo81+/Ft3W318LxOJ86hyjf+30Zc+kGoqFQuytcs=; b=Vx/zAxB+JeDPoimpTG7jtXsasE
        HC05BdpaUL3S+bzRlf9/foDJ4xpkfkF8aaN1uji8zCwY5rr2l6KnuawISqxz6I1X8bwq1KtN3QbN8
        tM7v3iSm0+qzSpMkm8A3/S83siOGhCJbLTdWniVREHn2Fk0FBzntbqyY8zeEN2Ew/+24WDKK5DuCh
        OSmXYGrJ40Wwbdb5kOq/qIgHR0UE9UOtFzFZPbfd4Le0RGGmtyXzr12DPyitNWZRBo9e/TTcSGX+y
        TiCNsbmqZwvXWdnjVE9iAt1WdHebh7wXT72p986IUJgTwUw1GPemdGfBpLILYcYFEvd4G5WTudUBG
        SCgfrLjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miTeA-005duZ-0r; Thu, 04 Nov 2021 03:43:05 +0000
Date:   Thu, 4 Nov 2021 03:42:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYNWrSyPCabrcRfr@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
 <20211103160057.GH24333@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103160057.GH24333@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 09:00:57AM -0700, Darrick J. Wong wrote:
> > -			wpc->ops->discard_folio(page_folio(page), file_offset);
> > +			wpc->ops->discard_folio(folio, pos);
> 
> /me wonders why this wouldn't have been done in whichever patch added
> folio as a local variable, but fmeh, the end result is the same:

Found it and fixed it.

> > @@ -1474,17 +1474,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> >  		 * memory is zeroed when mapped, and writes to that region are
> >  		 * not written out to the file."
> >  		 */
> > -		zero_user_segment(page, poff, PAGE_SIZE);
> > -
> > -		/* Adjust the end_offset to the end of file */
> > +		zero_user_segment(&folio->page, poff, folio_size(folio));
> 
> Question: is &folio->page != page here?  I guess the idea is that we
> have a (potentially multi-page) folio straddling i_size, and we need to
> zero everything in the whole folio after i_size.  But then why not pass
> the whole folio?

Ugh, thanks.  You made me realise that zero_user_segments() is still
conditional on CONFIG_TRANSPARENT_HUGEPAGE.  It's a relic of when I
was going to do all of this with THP; before I switched to the folio
mental model.

So now we're going to get folio_zero_segments(), folio_zero_segment()
and folio_zero_range().

