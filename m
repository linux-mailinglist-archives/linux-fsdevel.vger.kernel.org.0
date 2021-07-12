Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAA3C5B83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGLLjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhGLLjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:39:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55CC0613DD;
        Mon, 12 Jul 2021 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D5qx3dVKgrH7eIQyjcDlzzDy7QOQdnxbowoXaJPlgMg=; b=iblrGfKdeb6Ro1mum0SxNGam0d
        omVYWRsSb97CvbeOIJvvAlaDSBTMePy5R9s/R4m5pUq4MFYqa+WPxpSHStpTmiCaWOQUpmJL2FrlT
        d8yEVAcmAeiik2gIVICzs+BMVab1AVPku6G1jjkYwF3Az6+bjtrGfjbDV4ICBtV0Lh3DNv/29dPnH
        nofbAeZ+HSKFzkDxOAy9OcN7uyjGm3LN7WukrdmYul2G5ed44zzN/ucmvq65RG2hz2SH7WaHYKJ9U
        SBv8crZhOC4WA0PjOPwOY+j3oud3NG4H0QgW+wZYzAk5rgBpesPt2Xc3ErC8eN7BnD6CpRCZ046w5
        oyPCjVxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2uE7-00HYKa-C6; Mon, 12 Jul 2021 11:36:01 +0000
Date:   Mon, 12 Jul 2021 12:35:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 000/137] Memory folios
Message-ID: <YOwpG1fuEJt8hS+U@casper.infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
 <YOvXHZ7tCxV2Ex2m@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOvXHZ7tCxV2Ex2m@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 06:46:05AM +0100, Christoph Hellwig wrote:
> On Mon, Jul 12, 2021 at 04:04:44AM +0100, Matthew Wilcox (Oracle) wrote:
> > Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> > benefit from a larger "page size".  As an example, an earlier iteration
> > of this idea which used compound pages (and wasn't particularly tuned)
> > got a 7% performance boost when compiling the kernel.
> > 
> > Using compound pages or THPs exposes a weakness of our type system.
> > Functions are often unprepared for compound pages to be passed to them,
> > and may only act on PAGE_SIZE chunks.  Even functions which are aware of
> > compound pages may expect a head page, and do the wrong thing if passed
> > a tail page.
> > 
> > We also waste a lot of instructions ensuring that we're not looking at
> > a tail page.  Almost every call to PageFoo() contains one or more hidden
> > calls to compound_head().  This also happens for get_page(), put_page()
> > and many more functions.
> > 
> > This patch series uses a new type, the struct folio, to manage memory.
> > It converts enough of the page cache, iomap and XFS to use folios instead
> > of pages, and then adds support for multi-page folios.  It passes xfstests
> > (running on XFS) with no regressions compared to v5.14-rc1.
> 
> This seems to miss a changelog vs the previous version.  It also
> includes a lot of the follow ups.  I think reviewing a series gets
> rather hard at more than 30-ish patches, so chunking it up a little
> more would be useful.

I'm not seriously expecting anybody to review 137 patches.  It's more
for the bots to chew on (which they have done and I'm about to look
at their output).  I'll be sending mergable subsets (three rounds; the
base code, the memcg series and the pagecache series) later this week,
once I've addressed the build bot complaints.  You've seen all those
patches individually by now.

My plan is that once those are merged, the rest can proceed in parallel.
The block + iomap series is independent, then there's the second pagecache
series.  The last dozen or so patches still need a bit of work as they
were pulled across from the THP tree and at least need better changelogs.

Since this works for me, I'm hoping some people will also test and
confirm it works for them, and maybe post their own performance numbers
to justify all this.
