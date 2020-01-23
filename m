Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F088114658A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAWKVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 05:21:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:48334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAWKVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:21:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3F63AF6E;
        Thu, 23 Jan 2020 10:21:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E8DF1E0B01; Thu, 23 Jan 2020 11:21:01 +0100 (CET)
Date:   Thu, 23 Jan 2020 11:21:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200123102101.GA5728@quack2.suse.cz>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200121113627.GA1746@quack2.suse.cz>
 <20200121214845.GA14467@bombadil.infradead.org>
 <20200122234740.GI9407@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122234740.GI9407@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-01-20 10:47:40, Dave Chinner wrote:
> On Tue, Jan 21, 2020 at 01:48:45PM -0800, Matthew Wilcox wrote:
> > On Tue, Jan 21, 2020 at 12:36:27PM +0100, Jan Kara wrote:
> > > > v2: Chris asked me to show what this would look like if we just have
> > > > the implementation look up the pages in the page cache, and I managed
> > > > to figure out some things I'd done wrong last time.  It's even simpler
> > > > than v1 (net 104 lines deleted).
> > > 
> > > I have an unfinished patch series laying around that pulls the ->readpage
> > > / ->readpages API in somewhat different direction so I'd like to discuss
> > > whether it's possible to solve my problem using your API. The problem I
> > > have is that currently some operations such as hole punching can race with
> > > ->readpage / ->readpages like:
> > > 
> > > CPU0						CPU1
> > > fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
> > >   filemap_write_and_wait_range()
> > >   down_write(inode->i_rwsem);
> > >   truncate_pagecache_range();
> 
> shouldn't fallocate be holding EXT4_I(inode)->i_mmap_sem before it
> truncates the page cache? Otherwise it's not serialised against
> page faults. Looks at code ... oh, it does hold the i_mmap_sem in
> write mode, so....

Yes.

> > > 						readahead(fd, off, len)
> > > 						  creates pages in page cache
> > > 						  looks up block mapping
> > >   removes blocks from inode and frees them
> > > 						  issues bio
> > > 						    - reads stale data -
> > > 						      potential security
> > > 						      issue
> 
> .... I'm not sure that this race condition should exist anymore
> as readahead should not run until the filesystem drops it's inode
> and mmap locks after the entire extent freeing operation is
> complete...

Not for XFS but for all the other filesystems see below..

> > > Now how I wanted to address this is that I'd change the API convention for
> > > ->readpage() so that we call it with the page unlocked and the function
> > > would lock the page, check it's still OK, and do what it needs. And this
> > > will allow ->readpage() and also ->readpages() to grab lock
> > > (EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
> > > while we are adding pages to page cache and mapping underlying blocks.
> > > 
> > > Now your API makes even ->readpages() (actually ->readahead) called with
> > > pages locked so that makes this approach problematic because of lock
> > > inversions. So I'd prefer if we could keep the situation that ->readpages /
> > > ->readahead gets called without any pages in page cache locked...
> > 
> > I'm not a huge fan of that approach because it increases the number of
> > atomic ops (right now, we __SetPageLocked on the page before adding it
> > to i_pages).  Holepunch is a rather rare operation while readpage and
> > readpages/readahead are extremely common, so can we make holepunch take
> > a lock that will prevent new readpage(s) succeeding?
> > 
> > I have an idea to move the lock entries from DAX to being a generic page
> > cache concept.  That way, holepunch could insert lock entries into the
> > pagecache to cover the range being punched, and readpage(s) would either
> > skip lock entries or block on them.
> > 
> > Maybe there's a better approach though.
> 
> Can we step back for a moment and look at how we already serialise
> readahead against truncate/hole punch? While the readahead code
> itself doesn't serialise against truncate, in all cases we should be
> running through the filesystem at a higher layer and provides the
> truncate/holepunch serialisation before we get to the readahead
> code.
> 
> The read() syscall IO path:
> 
>   read()
>     ->read_iter()
>       filesystem takes truncate serialisation lock
>       generic_file_read_iter()
>         generic_file_buffered_read()
> 	  page_cache_sync_readahead()
> 	    ....
> 	  page_cache_async_readahead()
> 	    ....
>       .....
>       filesystem drops truncate serialisation lock

Yes, this is the scheme XFS uses. But ext4 and other filesystems use a
scheme where read is serialized against truncate only by page locks and
i_size checks. Which works for truncate but is not enough for hole
punching. And locking read(2) and readahead(2) in all these filesystem with
i_rwsem is going to cause heavy regressions with mixed read-write workloads
and unnecessarily so because we don't need to lock reads against writes,
just against truncate or hole punching.

So I wanted to use i_mmap_sem for the serialization of the read path against
truncate. But due to lock ordering with mmap_sem and because reads do take
page faults to copy data it is not straightforward - hence my messing with
->readpage(). Now that I'm thinking about it, there's also a possibility of
introducing yet another rwsem into the inode that would rank above
mmap_sem and be used to serialize ->read_iter and ->fadvise against
truncate. But having three rwsems in the inode for serialization seems a
bit too convoluted for my taste.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
