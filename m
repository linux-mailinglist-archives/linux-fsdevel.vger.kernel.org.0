Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58149294545
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 00:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410456AbgJTWxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 18:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410448AbgJTWxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:53:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB2C0613CE;
        Tue, 20 Oct 2020 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mxYffo07Ge2wakqggHCWFtNzUjwK3+PtgxM1aE+D8V8=; b=mfmb+Y65izog0kLPLK0QYN2SZY
        4S+WK9v/S2wqAB+xTZp6GwFDNbz6ypSX6/Cdj+qmp9N1ZhyYtcg6ploUTHL/y8pJnN9WErLvQGYWU
        29Obc8z9IGS5lZF4G1hOI8cagRiZFBjbR6Sz+bi2EXyJTORvdvR9nK6PZftkoIfTVpKbcDppzSH3S
        GCXJBUMmCzDiV8KQrjx3e98zNjTDZXofQCASmDA+4jnfCJe7P0SqZ4IlCLDO7FKRK1S4TAedrssvz
        B6CM73YFphkLWKxzqu/iECM2F3WV9qg+dzgwuIV88iPyCC01FmciQMzevS8z/G/J90uEBYLKhyHl2
        bRfPoMxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV0VX-00055s-Gn; Tue, 20 Oct 2020 22:53:31 +0000
Date:   Tue, 20 Oct 2020 23:53:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201020225331.GE20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
 <20201020112138.GZ20115@casper.infradead.org>
 <20201020211634.GQ7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020211634.GQ7391@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:16:34AM +1100, Dave Chinner wrote:
> On Tue, Oct 20, 2020 at 12:21:38PM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 20, 2020 at 03:59:28PM +1100, Dave Chinner wrote:
> > > On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> > > > This is a weird one ... which is good because it means the obvious
> > > > ones have been fixed and now I'm just tripping over the weird cases.
> > > > And fortunately, xfstests exercises the weird cases.
> > > > 
> > > > 1. The file is 0x3d000 bytes long.
> > > > 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> > > > 3. We simulate a read error for 0x3c000-0x3cfff
> > > > 4. Userspace writes to 0x3d697 to 0x3dfaa
> > > 
> > > So this is a write() beyond EOF, yes?
> > > 
> > > If yes, then we first go through this path:
> > > 
> > > 	xfs_file_buffered_aio_write()
> > > 	  xfs_file_aio_write_checks()
> > > 	    iomap_zero_range(isize, pos - isize)
> > > 
> > > To zero the region between the current EOF and where the new write
> > > starts. i.e. from 0x3d000 to 0x3d696.
> > 
> > Yes.  That calls iomap_write_begin() which calls iomap_split_page()
> > which is where we run into trouble.  I elided the exact path from the
> > description of the problem.
> > 
> > > > 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
> > > >    so it calls iomap_split_page() (passing page 0x3d)
> > > 
> > > Splitting the page because it's !Uptodate seems rather drastic to
> > > me.  Why does it need to split the page here?
> > 
> > Because we can't handle Dirty, !Uptodate THPs in the truncate path.
> > Previous discussion:
> > https://lore.kernel.org/linux-mm/20200821144021.GV17456@casper.infradead.org/
> 
> Maybe I'm just dense, but this doesn't explain the reason for
> needing to split THPs during partial THP invalidation, nor the
> reason why we need to split THPs when the write path sees a
> partially up to date THP. iomap is supposed to be tracking the
> sub-page regions that are not up to date, so why would we ever need
> to split the page to get sub-page regions into the correct state?

True, we don't _have to_ split THP on holepunch/truncation/... but it's
a better implementation to free pages which cover blocks that no longer
have data associated with them.

> FWIW, didn't you change the dirty tracking to be done sub-page and
> held in the iomap_page? If so, releasing the iomap_page on a partial
> page invalidation looks ... problematic. i.e. not only are you
> throwing away the per-block up-to-date state on a THP, you're alos
> throwing away the per-block dirty state.

That wasn't my patch.  Also, discarding the iomap_page causes the entire
page to be treated as a single unit.  So if we lose per-block state,
and the page is marked as dirty, then each subpage (that remains after
the holepunch) will be treated as dirty.

> i.e. we still need that per-block state to be maintained once the
> THP has been split - the split pages should be set to the correct
> state held on the THP as the split progresses. IOWs, I suspect that
> split_huge_page() needs to call into iomap to determine the actual
> state of each individual sub-page from the iomap_page state attached
> to the huge page.

That would be ideal, but we only have the ability to do that for uptodate
sub-page state right now.  It's all a bit messy, and it's on my list
of things to improve at some point.  But there's no bug that I know of
in this.

> > The current assumption is that a !Uptodate THP is due to a read error,
> > and so the sensible thing to do is split it and handle read errors at
> > a single-page level.
> 
> Why? Apart from the range of the file coverd by the page, how is
> handling a read error at a single page level any different from
> handling it at a THP level?
> 
> Alternatively, if there's a read error on THP-based readahead, then
> why isn't the entire THP tossed away when a subsequent read sees
> PageError() so it can then be re-read synchronously into the cache
> using single pages?

Splitting the page instead of throwing it away makes sense once we can
transfer the Uptodate bits to each subpage.  If we don't have that,
it doesn't really matter which we do.

> > We do that in iomap_readpage_actor().  Had the readahead I/O not "failed",
> > we'd've had an Uptodate THP which straddled EOF.
> 
> If the IO error in a THP is the trigger for bad things here, then
> surely the correct thing to do is trash the THP on IO error, not
> leave a landmine that every path has to handle specially...

Can't split a page on I/O error -- split_huge_page() has to be called
from process context and we get notified about the error in BH context.

