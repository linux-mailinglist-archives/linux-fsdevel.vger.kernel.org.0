Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08F4A55D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 05:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiBAEGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 23:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiBAEGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:06:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4DDC061714;
        Mon, 31 Jan 2022 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k45b9PUzgdlnWJkDqXuh5P7g8BNNYdMDwZlCU/JL5kw=; b=HktlgG7drVjfB0DC5kQ/whhiii
        9suDogNl2Uqb/4IgdGu5pTZGd0IGNuDS4yy26LJ9QEBc8zqsPYtpvOM8UJjoB0qL4Sr4impBOcffn
        EHPeLvExnzvdVV/go5UrjFYdHLR4KjBlTaDWA9ftZQd5lEmjZLJAevHBtYkHc+Hnmgud7/IN0oGwC
        jvxBa7elfXBilAOdHqtdgFdU5+OZNFsPUMm2xBUEFtGHZLcD1j6dQq/rpwJGajV1i91m/9ftgTQaZ
        eGgHf44/xhuG10pK5pU1ReQkOaLX4EMSbs1xgqt5fb7OC/0QjuifdQicMKUaY/6LWJ4YSlutnUuWd
        npt7C2Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEkQy-00BNab-1k; Tue, 01 Feb 2022 04:06:24 +0000
Date:   Tue, 1 Feb 2022 04:06:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
Message-ID: <YfixwCAA0TUR7ldD@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown>
 <YfdlbxezYSOSYmJf@casper.infradead.org>
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>
 <YffgKva2Dz3cTwhr@casper.infradead.org>
 <164367002370.18996.7242801209611375112@noble.neil.brown.name>
 <YfiUaJ59A3px+DqP@casper.infradead.org>
 <164368611206.1660.3728723868309208734@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164368611206.1660.3728723868309208734@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:28:32PM +1100, NeilBrown wrote:
> On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> > On Tue, Feb 01, 2022 at 10:00:23AM +1100, NeilBrown wrote:
> > > On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> > > > On Mon, Jan 31, 2022 at 03:47:41PM +1100, NeilBrown wrote:
> > > > > On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > > > > > +++ b/fs/fuse/file.c
> > > > > > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
> > > > > > >  
> > > > > > >  	if (fuse_is_bad(inode))
> > > > > > >  		return;
> > > > > > > +	if (fc->num_background >= fc->congestion_threshold)
> > > > > > > +		return;
> > > > > > 
> > > > > > This seems like a bad idea to me.  If we don't even start reads on
> > > > > > readahead pages, they'll get ->readpage called on them one at a time
> > > > > > and the reading thread will block.  It's going to lead to some nasty
> > > > > > performance problems, exactly when you don't want them.  Better to
> > > > > > queue the reads internally and wait for congestion to ease before
> > > > > > submitting the read.
> > > > > > 
> > > > > 
> > > > > Isn't that exactly what happens now? page_cache_async_ra() sees that
> > > > > inode_read_congested() returns true, so it doesn't start readahead.
> > > > > ???
> > > > 
> > > > It's rather different.  Imagine the readahead window has expanded to
> > > > 256kB (64 pages).  Today, we see congestion and don't do anything.
> > > > That means we miss the async readahed opportunity, find a missing
> > > > page and end up calling into page_cache_sync_ra(), by which time
> > > > we may or may not be congested.
> > > > 
> > > > If the inode_read_congested() in page_cache_async_ra() is removed and
> > > > the patch above is added to replace it, we'll allocate those 64 pages and
> > > > add them to the page cache.  But then we'll return without starting IO.
> > > > When we hit one of those !uptodate pages, we'll call ->readpage on it,
> > > > but we won't do anything to the other 63 pages.  So we'll go through a
> > > > protracted slow period of sending 64 reads, one at a time, whether or
> > > > not congestion has eased.  Then we'll hit a missing page and proceed
> > > > to the sync ra case as above.
> > > 
> > > Hmmm... where is all this documented?
> > > The entry for readahead in vfs.rst says:
> > > 
> > >     If the filesystem decides to stop attempting I/O before reaching the
> > >     end of the readahead window, it can simply return.
> > > 
> > > but you are saying that if it simply returns, it'll most likely just get
> > > called again.  So maybe it shouldn't say that?
> > 
> > That's not what I'm saying at all.  I'm saying that if ->readahead fails
> > to read the page, ->readpage will be called to read the page (if it's
> > actually accessed).
> 
> Yes, I see that now - thanks.
> 
> But looking at the first part of what you wrote - currently if
> congestion means we skip page_cache_async_ra() (and it is the
> WB_sync_congested (not async!) which causes us to skip that) then we end
> up in page_cache_sync_ra() - which also calls ->readahead but without
> the 'congested' protection.
> 
> Presumably the sync readahead asks for fewer pages or something?  What is
> the logic there?

Assuming you open() the file and read() one byte at a time sequentially,
a sufficiently large file will work like this:

 - No page at index 0
   - Sync readahead pages 0-15
   - Set the readahead marker on page 8
   - Wait for page 0 to come uptodate (assume readahead succeeds)
 - Read pages 1-7
 - Notice the readahead mark on page 8
   - Async readahead pages 16-47
   - Set the readahead marker on page 32
 - Read pages 8-15
 - Hopefully the async readahead for page 16 already finished; if not
   wait for it
 - Read pages 17-31
 - Notice the readahead mark on page 32
   - Async readahead pages 48-111
   - Set the readahead marker on page 80
...

The sync readahead is "We need to read this page now, we may as well
start the read for other pages at the same time".  Async readahead is
"We predict we'll need these pages in the future".  Readpage only
gets used if readahead has failed.

> > > So it seems that core read-ahead code it not set up to expect readahead
> > > to fail, though it is (begrudgingly) permitted.
> > 
> > Well, yes.  The vast majority of reads don't fail.
> 
> Which makes one wonder why we have the special-case handling.  The code
> that tests REQ_RAHEAD has probably never been tested.  Fortunately it is
> quite simple code....

I actually did a set of tests while developing folios that failed every
readahead or some proportion of readaheads.  Found some interesting bugs
that way.  Might be a good idea to upstream an error injection so that
people can keep testing it.

> > > The current inode_read_congested() test in page_cache_async_ra() seems
> > > to be just delaying the inevitable (and in fairness, the comment does
> > > say "Defer....").  Maybe just blocking on the congestion is an equally
> > > good way to delay it...
> > 
> > I don't think we should _block_ for an async read request.  We're in the
> > context of a process which has read a different page.  Maybe what we
> > need is a readahead_abandon() call that removes the just-added pages
> > from the page cache, so we fall back to doing a sync readahead?
> 
> Well, we do potentially block - when allocating a bio or other similar
> structure, and when reading an index block to know where to read from.
> But we don't block waiting for the read, and we don't block waiting to
> allocate the page to read-ahead.  Just how much blocking is acceptable,
> I wonder.  Maybe we should punt readahead to a workqueue and let it do
> the small-time waiting.

Right, I meant "block on I/O" rather than "block trying to free memory".
We are under GFP_NOFS during the readahead path, so while we can block
for a previously-submitted I/O to finish, we can't start a new I/O.

> Why does the presence of an unlocked non-uptodate page cause readahead
> to be skipped?  Is this somehow related to the PG_readahead flag?  If we
> set PG_readahead on the first page that we decided to skip in
> ->readahead, would that help?

To go back to the example above, let's suppose the first async read hits
congestion.  Before your patches, we don't even allocate pages 16-47.
So we see a missing page, and the ondemand algorithm will submit a sync
ra for pages 16-31.

After your patches, we allocate pages 16-47, add them to the page cache
and then leave them there !uptodate.  Now each time our read() hits
a !uptodate page, we call ->readpage on it.  We have no idea that the
remaining pages in that readahead batch were also abandoned and could
be profitably read.  I think we'll submit another async readahead
for 48-112, but I'd have to check on that.

> > > I really would like to see that high-level documentation!!
> > 
> > I've done my best to add documentation.  There's more than before
> > I started.
> 
> I guess it's my turn then - if I can manage to understand it.

It always works out better when two people are interested in the
documentation.
