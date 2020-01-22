Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C4145F58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 00:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVXrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 18:47:47 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38071 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgAVXrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:47:47 -0500
Received: from dread.disaster.area (pa49-181-218-253.pa.nsw.optusnet.com.au [49.181.218.253])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CB804820810;
        Thu, 23 Jan 2020 10:47:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iuPim-0008IT-9C; Thu, 23 Jan 2020 10:47:40 +1100
Date:   Thu, 23 Jan 2020 10:47:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200122234740.GI9407@dread.disaster.area>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200121113627.GA1746@quack2.suse.cz>
 <20200121214845.GA14467@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121214845.GA14467@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=TU0PeEMO9XNyODJ+pEfdLw==:117 a=TU0PeEMO9XNyODJ+pEfdLw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=CFKjfQyiDWdJtrgseoEA:9 a=Q-uMpcMcfA-1AsPR:21
        a=OG3NL3sTsLLd4Dzs:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 01:48:45PM -0800, Matthew Wilcox wrote:
> On Tue, Jan 21, 2020 at 12:36:27PM +0100, Jan Kara wrote:
> > > v2: Chris asked me to show what this would look like if we just have
> > > the implementation look up the pages in the page cache, and I managed
> > > to figure out some things I'd done wrong last time.  It's even simpler
> > > than v1 (net 104 lines deleted).
> > 
> > I have an unfinished patch series laying around that pulls the ->readpage
> > / ->readpages API in somewhat different direction so I'd like to discuss
> > whether it's possible to solve my problem using your API. The problem I
> > have is that currently some operations such as hole punching can race with
> > ->readpage / ->readpages like:
> > 
> > CPU0						CPU1
> > fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
> >   filemap_write_and_wait_range()
> >   down_write(inode->i_rwsem);
> >   truncate_pagecache_range();

shouldn't fallocate be holding EXT4_I(inode)->i_mmap_sem before it
truncates the page cache? Otherwise it's not serialised against
page faults. Looks at code ... oh, it does hold the i_mmap_sem in
write mode, so....

> > 						readahead(fd, off, len)
> > 						  creates pages in page cache
> > 						  looks up block mapping
> >   removes blocks from inode and frees them
> > 						  issues bio
> > 						    - reads stale data -
> > 						      potential security
> > 						      issue

.... I'm not sure that this race condition should exist anymore
as readahead should not run until the filesystem drops it's inode
and mmap locks after the entire extent freeing operation is
complete...

> > Now how I wanted to address this is that I'd change the API convention for
> > ->readpage() so that we call it with the page unlocked and the function
> > would lock the page, check it's still OK, and do what it needs. And this
> > will allow ->readpage() and also ->readpages() to grab lock
> > (EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
> > while we are adding pages to page cache and mapping underlying blocks.
> > 
> > Now your API makes even ->readpages() (actually ->readahead) called with
> > pages locked so that makes this approach problematic because of lock
> > inversions. So I'd prefer if we could keep the situation that ->readpages /
> > ->readahead gets called without any pages in page cache locked...
> 
> I'm not a huge fan of that approach because it increases the number of
> atomic ops (right now, we __SetPageLocked on the page before adding it
> to i_pages).  Holepunch is a rather rare operation while readpage and
> readpages/readahead are extremely common, so can we make holepunch take
> a lock that will prevent new readpage(s) succeeding?
> 
> I have an idea to move the lock entries from DAX to being a generic page
> cache concept.  That way, holepunch could insert lock entries into the
> pagecache to cover the range being punched, and readpage(s) would either
> skip lock entries or block on them.
> 
> Maybe there's a better approach though.

Can we step back for a moment and look at how we already serialise
readahead against truncate/hole punch? While the readahead code
itself doesn't serialise against truncate, in all cases we should be
running through the filesystem at a higher layer and provides the
truncate/holepunch serialisation before we get to the readahead
code.

The read() syscall IO path:

  read()
    ->read_iter()
      filesystem takes truncate serialisation lock
      generic_file_read_iter()
        generic_file_buffered_read()
	  page_cache_sync_readahead()
	    ....
	  page_cache_async_readahead()
	    ....
      .....
      filesystem drops truncate serialisation lock

The page fault IO path:

page fault
  ->fault
    xfs_vm_filemap_fault
      filesystem takes mmap truncate serialisation lock
	filemap_fault
	  do_async_mmap_readahead
	    page_cache_async_readahead
	  ....
	  do_sync_mmap_readahead
	    page_cache_sync_readahead
	.....
      filesystem drops mmap truncate serialisation lock

Then there is fadvise(WILLNEED) which calls
force_page_cache_readahead() directly. We now have ->fadvise for
filesystems to add locking around this:

fadvise64
  vfs_fadvise
    ->fadvise
      xfs_file_fadvise
        filesystem takes truncate serialisation lock
	generic_fadvise()
        filesystem drops truncate serialisation lock

XFS and overlay both have ->fadvise methods to provide this
serialisation of readahead, but ext4 does not so users could trigger
the stated race condition through fadvise(WILLNEED) or readahead()
syscalls.

Hence, AFAICT, ext4 only needs to implement ->fadvise and the stated
readahead vs truncate_pagecache_range() race condition goes away.
Unless, of course, I've missed some other entry point into the
readahead code that does not vector through the filesystem first.
What have I missed?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
