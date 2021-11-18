Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3557145616A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhKRR3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 12:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhKRR3Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:29:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2082361A07;
        Thu, 18 Nov 2021 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637256376;
        bh=QE4r16+cz7m3BK89h/Sjb1ZqaoOg/LCERqDrH6tb69Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAA+BTIPwj1adxXFbA5+bQGhBP32aJ1fDxcdEl60hrmRyXDRXH5SK8ucWoVXYYOqv
         oIv3bz01ICv3R2TXeLiTZfXhQJ/zRwfRhElcF/1MAgbR6+KHGhLURtF0yoW/9JDorz
         HpWmoliNaGsGZf9j6/fLbZwqxYxTbxB0ua9PUvdtk7OGTpyeET9KmSwTRocXr2NqhL
         D6h263kakpuVQYWYFuNmVBG24ZNomOZRiN7qH3uEp2ZEE4C/+T4FkRKJZLesdJOoU7
         D//wsaBt4SrwQLMEtbT0a4LMP6mhRMjBba20MXgoqivoDPQ4TVMUTZw0iug/C289ZR
         SgKMwgFKWGfDQ==
Date:   Thu, 18 Nov 2021 09:26:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <20211118172615.GA24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
 <20211117044527.GO24307@magnolia>
 <YZUMhDDHott2Q4W+@casper.infradead.org>
 <20211117170707.GW24307@magnolia>
 <YZZ3YJucR/WOpOaF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZZ3YJucR/WOpOaF@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 03:55:12PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 17, 2021 at 09:07:07AM -0800, Darrick J. Wong wrote:
> > I've started using 'next', or changing the code to make 'end' be the
> > last element in the range the caller wants to act upon.  The thing is,
> > those are all iterators, so 'next' fits, whereas it doesn't fit so well
> > for range zeroing where that might have been all the zeroing we wanted
> > to do.
> 
> Yeah, it doesn't really work so well for one of the patches in this
> series:
> 
>                         if (buffer_new(bh)) {
> ...
>                                         folio_zero_segments(folio,
>                                                 to, block_end,
>                                                 block_start, from);
> 
> ("zero between block_start and block_end, except for the region
> specified by 'from' and 'to'").  Except that for some reason the
> ranges are specified backwards, so it's not obvious what's going on.
> Converting that to folio_zero_ranges() would be a possibility, at the
> expense of complexity in the caller, or using 'max' instead of 'end'
> would also add complexity to the callers.

The call above looks like it is preparing to copy some data into the
middle of a buffer by zero-initializing the bytes before and the bytes
after that middle region.

Admittedly my fs-addled brain actually finds this hot mess easier to
understand:

folio_zero_segments(folio, to, blocksize - 1, block_start, from - 1);

but I suppose the xend method involves less subtraction everywhere.

> 
> > Though.  'xend' (shorthand for 'excluded end') is different enough to
> > signal that the reader should pay attention.  Ok, how about xend then?
> 
> Done!
> 
> @@ -367,26 +367,26 @@ static inline void memzero_page(struct page *page, size_t
> offset, size_t len)
>   * folio_zero_segments() - Zero two byte ranges in a folio.
>   * @folio: The folio to write to.
>   * @start1: The first byte to zero.
> - * @end1: One more than the last byte in the first range.
> + * @xend1: One more than the last byte in the first range.
>   * @start2: The first byte to zero in the second range.
> - * @end2: One more than the last byte in the second range.
> + * @xend2: One more than the last byte in the second range.
>   */
>  static inline void folio_zero_segments(struct folio *folio,
> -               size_t start1, size_t end1, size_t start2, size_t end2)
> +               size_t start1, size_t xend1, size_t start2, size_t xend2)
>  {
> -       zero_user_segments(&folio->page, start1, end1, start2, end2);
> +       zero_user_segments(&folio->page, start1, xend1, start2, xend2);
>  }
> 
>  /**
>   * folio_zero_segment() - Zero a byte range in a folio.
>   * @folio: The folio to write to.
>   * @start: The first byte to zero.
> - * @end: One more than the last byte in the first range.
> + * @xend: One more than the last byte to zero.
>   */
>  static inline void folio_zero_segment(struct folio *folio,
> -               size_t start, size_t end)
> +               size_t start, size_t xend)
>  {
> -       zero_user_segments(&folio->page, start, end, 0, 0);
> +       zero_user_segments(&folio->page, start, xend, 0, 0);

Works for me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  }
> 
>  /**
> 
