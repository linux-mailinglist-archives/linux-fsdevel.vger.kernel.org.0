Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC95972DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiHQPZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiHQPZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:25:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24705E576
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edlU3BExzsRsoCeVpTIwLsOGPOEwh0l0t+arlBBi9+w=; b=dx/mfpfp6rJWVEcc9hWrY+db3v
        Ze83S+bkWfMqxScbAFFDCkzWlHt9miBuQ3Y2ctLa49acGvknqmXae+W504bnEbxVGsLPi+WuoFafy
        Nm6SPKlt8dARBLYA6ZIVVqrGUGYCAuQru/1IzJ/sAT8ADDyvCBOw2VCagHZUGMsZDuKjtCO6xZJpR
        zgGyLPlknGFxmh02IDic++MFQsduHSplp/F9thjbq8xWmoBN1wpvgTE4r2d3bdFoeEGFWDDn8WW5v
        70ymaZF6ETGfIm51PO35dwSWz3RGCUqoMLLU7bQ5Qzsr5Gu99iJny33mzZR5sfbjoFHmxECAFq79B
        iHIfkK/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOKvK-008M4m-0T; Wed, 17 Aug 2022 15:25:38 +0000
Date:   Wed, 17 Aug 2022 16:25:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/filemap.c: fix the timing of asignment of prev_pos
Message-ID: <Yv0IccKJ6Spk/zH4@casper.infradead.org>
References: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:51:57PM +0800, Guixin Liu wrote:
> The prev_pos should be assigned before the iocb->ki_pos is incremented,
> so that the prev_pos is the exact location of the last visit.
> 
> Fixes: 06c0444290cec ("mm/filemap.c: generic_file_buffered_read() now
> uses find_get_pages_contig")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> ---
> Hi guys,
>     When I`m running repetitive 4k read io which has same offset,
> I find that access to folio_mark_accessed is inevitable in the
> read process, the reason is that the prev_pos is assigned after the
> iocb->ki_pos is incremented, so that the prev_pos is always not equal
> to the position currently visited.
>     Is this a bug that needs fixing?

I think you've misunderstood the purpose of 'prev_pos'.  But this has
been the source of bugs, so let's go through it in detail.

In general, we want to mark a folio as accessed each time we read from
it.  So if we do this:

	read(fd, buf, 1024 * 1024);

we want to mark each folio as having been accessed.

But if we're doing lots of short reads, we don't want to mark a folio as
being accessed multiple times (if you dive into the implementation,
you'll see the first time, the 'referenced' flag is set and the second
time, the folio is moved to the active list, so it matters how often
we call mark_accessed).  IOW:

	for (i = 0; i < 1024 * 1024; i++)
		read(fd, buf, 1);

should do the same amount of accessed/referenced/activation as the single
read above.

So when we store ki_pos in prev_pos, we don't want to know "Where did
the previous read start?"  We want to know "Where did the previous read
end".  That's why when we test it, we check whether prev_pos - 1 is in
the same folio as the offset we're looking at:

                if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
                                                        fbatch.folios[0]))
                        folio_mark_accessed(fbatch.folios[0]);

I'm not super-proud of this code, and accept that it's confusing.
But I don't think the patch below is right.  If you could share
your actual test and show what's going wrong, I'm interested.

I think what you're saying is that this loop:

	for (i = 0; i < 1000; i++)
		pread(fd, buf, 4096, 1024 * 1024);

results in the folio at offset 1MB being marked as accessed more than
once.  If so, then I think that's the algorithm behaving as designed.
Whether that's desirable is a different question; when I touched this
code last, I was trying to restore the previous behaviour which was
inadvertently broken.  I'm not taking a position on what the right
behaviour is for such code.

>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 660490c..68fd987 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2703,8 +2703,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			copied = copy_folio_to_iter(folio, offset, bytes, iter);
>  
>  			already_read += copied;
> -			iocb->ki_pos += copied;
>  			ra->prev_pos = iocb->ki_pos;
> +			iocb->ki_pos += copied;
>  
>  			if (copied < bytes) {
>  				error = -EFAULT;
> -- 
> 1.8.3.1
> 
