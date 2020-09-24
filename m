Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458827733D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgIXN7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIXN7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4ECC0613CE;
        Thu, 24 Sep 2020 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hug6s8+8lq9lwcdzlq9aErM3rYYYEQGQn5xx+p5VjoI=; b=AI34F+XbZgxnfiPgroDkfneKcW
        s2GFVLoXhb/roI3d9dnsEH70J71FeLFYt9F6fVuUlpphyTpKaDQ3If84LY2oI9+AL+E8oY6CEhCWY
        BPIFVaSjdYXGWoZWvrAiB5XOGEo9ITC6Bf3jfSIO6nf2FGfMM7La+jU58FjOJM1D+gzbUtfK7Ks/u
        rS0GdYfYy6xL5gAV1oNblTedh+yxzSzpehbGmiihAzpUvNZM4EXSU/FScnDoqQoK6C2XmAYaDTBk9
        eF2hgTrueXk5YLVDtUTiE00kF4tVVT8jP2ettssUE+5m73qbLYNYx64L1QP5GIigXFLR0XROBt7rV
        ddJiaNfA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRm0-0003vc-GP; Thu, 24 Sep 2020 13:59:01 +0000
Date:   Thu, 24 Sep 2020 14:59:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924135900.GV32101@casper.infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
 <20200924131235.GA2603692@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924131235.GA2603692@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:12:35AM -0400, Brian Foster wrote:
> On Thu, Sep 24, 2020 at 01:56:08PM +0100, Matthew Wilcox (Oracle) wrote:
> > For filesystems with block size < page size, we need to set all the
> > per-block uptodate bits if the page was already uptodate at the time
> > we create the per-block metadata.  This can happen if the page is
> > invalidated (eg by a write to drop_caches) but ultimately not removed
> > from the page cache.
> > 
> > This is a data corruption issue as page writeback skips blocks which
> > are marked !uptodate.
> 
> Thanks. Based on my testing of clearing PageUptodate here I suspect this
> will similarly prevent the problem, but I'll give this a test
> nonetheless. 
> 
> I am a little curious why we'd prefer to fill the iop here rather than
> just clear the page state if the iop data has been released. If the page
> is partially uptodate, then we end up having to re-read the page
> anyways, right? OTOH, I guess this behavior is more consistent with page
> size == block size filesystems where iop wouldn't exist and we just go
> by page state, so perhaps that makes more sense.

Well, it's _true_ ... the PageUptodate bit means that every byte in this
page is at least as new as every byte on storage.  There's no need to
re-read it, which is what we'll do if we ClearPageUptodate.

My original motivation for this was splitting a THP.  In that case,
we have, let's say, 16 * 4kB pages, and an iop for 64 blocks.  When we
split that 64kB page into 16 4kB pages, we can't afford to allocate 16
iops for them, so we just drop the iop and copy the uptodate state from
the head page to all subpages.

So now we have 16 pages, all marked uptodate (and with valid data) but
no iop.  So we need to create an iop for each page during the writeback
path, and that has to be created with uptodate bits or we'll skip the
entire page.  When I wrote the patch below, I had no idea we could
already get an iop allocated for an uptodate page, or I would have
submitted this patch months ago.

http://git.infradead.org/users/willy/pagecache.git/commitdiff/bc503912d4a9aad4496a4591e9992f0ada47a9c9
