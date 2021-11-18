Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE2455FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhKRP6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 10:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhKRP6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:58:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CAC061574;
        Thu, 18 Nov 2021 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X6u5jOtxjpZsL1qWxw9nRGO399G6h4RYQJk7HMGPx1I=; b=mLGqp9ZQsddZj0NmjOe+oo8jBc
        /J31ihLpooVSx/YC9y/QkUo9Ami7jMajKHrYuVm/s56eou9/mPA48aPjSLZFwvZiQGu0GTyF+Dfw9
        iq5/ZgHn7ewV/3ZpqwGEa3dWiOi+HoPxs7GjRvjZ20opoEn1GZcfW3CN3NRrte5whq42Zxk6BV+7Q
        ClAVVwfQ/drf4Q5EBy81nslpfcCQzK3K+MbfWLseFwjgvZ4x3iItFxKoIvwym+65t7hEvMLCJt+wb
        Yvb3GVe+DhRF+fIDWFp8qYSpTgntZdoyPSCEP6uMSciLKLJscmgbU0kBaa/7Y8kt0HAmRnWy6clQX
        uN08tu4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnjkm-008bOy-3L; Thu, 18 Nov 2021 15:55:12 +0000
Date:   Thu, 18 Nov 2021 15:55:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <YZZ3YJucR/WOpOaF@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
 <20211117044527.GO24307@magnolia>
 <YZUMhDDHott2Q4W+@casper.infradead.org>
 <20211117170707.GW24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117170707.GW24307@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:07:07AM -0800, Darrick J. Wong wrote:
> I've started using 'next', or changing the code to make 'end' be the
> last element in the range the caller wants to act upon.  The thing is,
> those are all iterators, so 'next' fits, whereas it doesn't fit so well
> for range zeroing where that might have been all the zeroing we wanted
> to do.

Yeah, it doesn't really work so well for one of the patches in this
series:

                        if (buffer_new(bh)) {
...
                                        folio_zero_segments(folio,
                                                to, block_end,
                                                block_start, from);

("zero between block_start and block_end, except for the region
specified by 'from' and 'to'").  Except that for some reason the
ranges are specified backwards, so it's not obvious what's going on.
Converting that to folio_zero_ranges() would be a possibility, at the
expense of complexity in the caller, or using 'max' instead of 'end'
would also add complexity to the callers.

> Though.  'xend' (shorthand for 'excluded end') is different enough to
> signal that the reader should pay attention.  Ok, how about xend then?

Done!

@@ -367,26 +367,26 @@ static inline void memzero_page(struct page *page, size_t
offset, size_t len)
  * folio_zero_segments() - Zero two byte ranges in a folio.
  * @folio: The folio to write to.
  * @start1: The first byte to zero.
- * @end1: One more than the last byte in the first range.
+ * @xend1: One more than the last byte in the first range.
  * @start2: The first byte to zero in the second range.
- * @end2: One more than the last byte in the second range.
+ * @xend2: One more than the last byte in the second range.
  */
 static inline void folio_zero_segments(struct folio *folio,
-               size_t start1, size_t end1, size_t start2, size_t end2)
+               size_t start1, size_t xend1, size_t start2, size_t xend2)
 {
-       zero_user_segments(&folio->page, start1, end1, start2, end2);
+       zero_user_segments(&folio->page, start1, xend1, start2, xend2);
 }

 /**
  * folio_zero_segment() - Zero a byte range in a folio.
  * @folio: The folio to write to.
  * @start: The first byte to zero.
- * @end: One more than the last byte in the first range.
+ * @xend: One more than the last byte to zero.
  */
 static inline void folio_zero_segment(struct folio *folio,
-               size_t start, size_t end)
+               size_t start, size_t xend)
 {
-       zero_user_segments(&folio->page, start, end, 0, 0);
+       zero_user_segments(&folio->page, start, xend, 0, 0);
 }

 /**

