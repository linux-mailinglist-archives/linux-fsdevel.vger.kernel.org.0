Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4845A4A5512
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 03:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiBACC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 21:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiBACBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:01:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134FBC061741;
        Mon, 31 Jan 2022 18:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sm7Yc1CtQBIVZ/GRlT8gqFP2ojSk7fSCO2XvuJwXk+w=; b=aLmub9E/3RVA1+xFe6GB5IgwFa
        KonTAXz5S6wqGq94yXuiVfawT+IlIZKim6M+ABrd3VJMZAYL6q2I1HShpV2MCjDcBHomp1cU10R7t
        44i1b0YiK/p8Whr8CpU7+kHI8CMB8jW1qMCSlLKrFBlKbZx0ggC+mLwWOoA8aWPH1rMghEQtCOtj0
        FyMMeZrqM1Jzy77Qhx13Uybrr7yZJJfFJINGoqCRfceMUsqi9x5huOhgbAg7Tnb1bRRoiD7CgJa4d
        R+dr5qTA+tFPH1/vEboBzowgBYxSw62CD53N+coERAPBHeLHW/uuAvM7YlIPaKL4LkY2BUyZufqSf
        29wVeJKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEiTo-00BAtw-Pj; Tue, 01 Feb 2022 02:01:12 +0000
Date:   Tue, 1 Feb 2022 02:01:12 +0000
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
Message-ID: <YfiUaJ59A3px+DqP@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown>
 <YfdlbxezYSOSYmJf@casper.infradead.org>
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>
 <YffgKva2Dz3cTwhr@casper.infradead.org>
 <164367002370.18996.7242801209611375112@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164367002370.18996.7242801209611375112@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:00:23AM +1100, NeilBrown wrote:
> On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> > On Mon, Jan 31, 2022 at 03:47:41PM +1100, NeilBrown wrote:
> > > On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > > > +++ b/fs/fuse/file.c
> > > > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
> > > > >  
> > > > >  	if (fuse_is_bad(inode))
> > > > >  		return;
> > > > > +	if (fc->num_background >= fc->congestion_threshold)
> > > > > +		return;
> > > > 
> > > > This seems like a bad idea to me.  If we don't even start reads on
> > > > readahead pages, they'll get ->readpage called on them one at a time
> > > > and the reading thread will block.  It's going to lead to some nasty
> > > > performance problems, exactly when you don't want them.  Better to
> > > > queue the reads internally and wait for congestion to ease before
> > > > submitting the read.
> > > > 
> > > 
> > > Isn't that exactly what happens now? page_cache_async_ra() sees that
> > > inode_read_congested() returns true, so it doesn't start readahead.
> > > ???
> > 
> > It's rather different.  Imagine the readahead window has expanded to
> > 256kB (64 pages).  Today, we see congestion and don't do anything.
> > That means we miss the async readahed opportunity, find a missing
> > page and end up calling into page_cache_sync_ra(), by which time
> > we may or may not be congested.
> > 
> > If the inode_read_congested() in page_cache_async_ra() is removed and
> > the patch above is added to replace it, we'll allocate those 64 pages and
> > add them to the page cache.  But then we'll return without starting IO.
> > When we hit one of those !uptodate pages, we'll call ->readpage on it,
> > but we won't do anything to the other 63 pages.  So we'll go through a
> > protracted slow period of sending 64 reads, one at a time, whether or
> > not congestion has eased.  Then we'll hit a missing page and proceed
> > to the sync ra case as above.
> 
> Hmmm... where is all this documented?
> The entry for readahead in vfs.rst says:
> 
>     If the filesystem decides to stop attempting I/O before reaching the
>     end of the readahead window, it can simply return.
> 
> but you are saying that if it simply returns, it'll most likely just get
> called again.  So maybe it shouldn't say that?

That's not what I'm saying at all.  I'm saying that if ->readahead fails
to read the page, ->readpage will be called to read the page (if it's
actually accessed).

> What do other filesystems do?
> ext4 sets REQ_RAHEAD, but otherwise just pushes ahead and submits all
> requests. btrfs seems much the same.
> xfs uses iomp_readahead ..  which again sets REQ_RAHEAD but otherwise
> just does a normal read.
> 
> The effect of REQ_RAHEAD seems to be primarily to avoid retries on
> failure.
> 
> So it seems that core read-ahead code it not set up to expect readahead
> to fail, though it is (begrudgingly) permitted.

Well, yes.  The vast majority of reads don't fail.

> The current inode_read_congested() test in page_cache_async_ra() seems
> to be just delaying the inevitable (and in fairness, the comment does
> say "Defer....").  Maybe just blocking on the congestion is an equally
> good way to delay it...

I don't think we should _block_ for an async read request.  We're in the
context of a process which has read a different page.  Maybe what we
need is a readahead_abandon() call that removes the just-added pages
from the page cache, so we fall back to doing a sync readahead?

> I note that ->readahead isn't told if the read-ahead is async or not, so
> my patch will drop sync read-ahead on congestion, which the current code
> doesn't do.

Now that we have a readahead_control, it's simple to add that
information to it.

> So maybe this congestion tracking really is useful, and we really want
> to keep it.
> 
> I really would like to see that high-level documentation!!

I've done my best to add documentation.  There's more than before
I started.
