Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D350256B4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 05:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgH3DxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgH3DxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 23:53:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B06C061573;
        Sat, 29 Aug 2020 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbMAzbTAVAIQl6lHjgeLTj8i/9ypXVT0o1tVe85oxSw=; b=Q/IHlZYM18zzXoBEEPcSMvjsjE
        fS/Ekpw9afXvbBIWA+DTiEAP/XFm9LWtboYB901Qg2ZyHDW9pwD9Xbxx28RG4UxWouWvSyldWoLx1
        kEyknipx3XgZjbyHDRBdTX4GHgzCIgVkoVjGXB+r9Mamfa6AHKZbej4zXiqBlRbbYW+Pd/4XxYd6q
        9pG540fXcCocL45QTzM+tbl9LUyJHuCDVDtKx63z9lB9/dGNSafRi2MAkkSskk54MjW9rkVmcstf9
        pIvnIYxgo3N2lesyLKIF8B8DZN2Wr3Yyo6XWOzbpyv2fDwe5pJ+aP5WJHKV8EWiY9TdWm6D5e2FO9
        DTA21FAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCEOr-000380-CY; Sun, 30 Aug 2020 03:53:01 +0000
Date:   Sun, 30 Aug 2020 04:53:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
Message-ID: <20200830035300.GX14765@casper.infradead.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
 <20200830012151.GW14765@casper.infradead.org>
 <874kokq4o4.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kokq4o4.fsf@mail.parknet.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 10:54:35AM +0900, OGAWA Hirofumi wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Sun, Aug 30, 2020 at 09:59:41AM +0900, OGAWA Hirofumi wrote:
> >> On one system, there was bdi->io_pages==0. This seems to be the bug of
> >> a driver somewhere, and should fix it though. Anyway, it is better to
> >> avoid the divide-by-zero Oops.
> >> 
> >> So this check it.
> >> 
> >> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  fs/fat/fatent.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> >> index f7e3304..98a1c4f 100644
> >> --- a/fs/fat/fatent.c	2020-08-30 06:52:47.251564566 +0900
> >> +++ b/fs/fat/fatent.c	2020-08-30 06:54:05.838319213 +0900
> >> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
> >>  	if (fatent->entry >= ent_limit)
> >>  		return;
> >>  
> >> -	if (ra_pages > sb->s_bdi->io_pages)
> >> +	if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
> >>  		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
> >
> > Wait, rounddown?  ->io_pages is supposed to be the maximum number of
> > pages to readahead.  Shouldn't this be max() instead of rounddown()?

Sorry, I meant 'min', not 'max'.

> Hm, io_pages is limited by driver setting too, and io_pages can be lower
> than ra_pages, e.g. usb storage.
> 
> Assuming ra_pages is user intent of readahead window. So if io_pages is
> lower than ra_pages, this try ra_pages to align of io_pages chunk, but
> not bigger than ra_pages. Because if block layer splits I/O requests to
> hard limit, then I/O is not optimal.
> 
> So it is intent, I can be misunderstanding though.

Looking at this some more, I'm not sure it makes sense to consult ->io_pages
at all.  I see how it gets set to 0 -- the admin can write '1' to
/sys/block/<device>/queue/max_sectors_kb and that gets turned into 0
in ->io_pages.

But I'm not sure it makes any sense to respect that.  Looking at mm/readahead.c, all it does is limit the size of a read request which exceeds the current readahead window.  It's not used to limit the readahead window itself.  For
example:

        unsigned long max_pages = ra->ra_pages;
...
        if (req_size > max_pages && bdi->io_pages > max_pages)
                max_pages = min(req_size, bdi->io_pages);

Setting io_pages below ra_pages has no effect.  So maybe fat should also
disregard it?
