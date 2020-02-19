Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2D163903
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBSBIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:08:48 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59344 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgBSBIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:08:48 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6590F3A3346;
        Wed, 19 Feb 2020 12:08:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4Dqy-0004dZ-Qv; Wed, 19 Feb 2020 12:08:40 +1100
Date:   Wed, 19 Feb 2020 12:08:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 09/19] mm: Add page_cache_readahead_limit
Message-ID: <20200219010840.GX10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-16-willy@infradead.org>
 <20200218063110.GO10776@dread.disaster.area>
 <20200218195404.GD24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218195404.GD24185@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=pXOkKLco0wbfc50Nqe8A:9
        a=VBWjYGV6Kxsh7Hhu:21 a=T0X9MdoumZd6j53S:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:54:04AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:31:10PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:56AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > ext4 and f2fs have duplicated the guts of the readahead code so
> > > they can read past i_size.  Instead, separate out the guts of the
> > > readahead code so they can call it directly.
> > 
> > Gross and nasty (hosting non-stale data beyond EOF in the page
> > cache, that is).
> 
> I thought you meant sneaking changes into the VFS (that were rejected) by
> copying VFS code and modifying it ...

Well, now that you mention it... :P

> > > +/**
> > > + * page_cache_readahead_limit - Start readahead beyond a file's i_size.
> > > + * @mapping: File address space.
> > > + * @file: This instance of the open file; used for authentication.
> > > + * @offset: First page index to read.
> > > + * @end_index: The maximum page index to read.
> > > + * @nr_to_read: The number of pages to read.
> > > + * @lookahead_size: Where to start the next readahead.
> > > + *
> > > + * This function is for filesystems to call when they want to start
> > > + * readahead potentially beyond a file's stated i_size.  If you want
> > > + * to start readahead on a normal file, you probably want to call
> > > + * page_cache_async_readahead() or page_cache_sync_readahead() instead.
> > > + *
> > > + * Context: File is referenced by caller.  Mutexes may be held by caller.
> > > + * May sleep, but will not reenter filesystem to reclaim memory.
> > >   */
> > > -void __do_page_cache_readahead(struct address_space *mapping,
> > > -		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
> > > -		unsigned long lookahead_size)
> > > +void page_cache_readahead_limit(struct address_space *mapping,
> > 
> > ... I don't think the function name conveys it's purpose. It's
> > really a ranged readahead that ignores where i_size lies. i.e
> > 
> > 	page_cache_readahead_range(mapping, start, end, nr_to_read)
> > 
> > seems like a better API to me, and then you can drop the "start
> > readahead beyond i_size" comments and replace it with "Range is not
> > limited by the inode's i_size and hence can be used to read data
> > stored beyond EOF into the page cache."
> 
> I'm concerned that calling it 'range' implies "I want to read between
> start and end" rather than "I want to read nr_to_read at start, oh but
> don't go past end".
> 
> Maybe the right way to do this is have the three callers cap nr_to_read.
> Well, the one caller ... after all, f2fs and ext4 have no desire to
> cap the length.  Then we can call it page_cache_readahead_exceed() or
> page_cache_readahead_dangerous() or something else like that to make it
> clear that you shouldn't be calling it.

Fair point.

And in reading this, it occurred to me that what we are enabling is
an "out of bounds" readahead function. so
page_cache_readahead_OOB() or *_unbounded() might be a better name....

>   * Like add_to_page_cache_locked, but used to add newly allocated pages:
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 9dd431fa16c9..cad26287ad8b 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -142,45 +142,43 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  	blk_finish_plug(&plug);
>  }
>  
> -/*
> - * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
> - * the pages first, then submits them for I/O. This avoids the very bad
> - * behaviour which would occur if page allocations are causing VM writeback.
> - * We really don't want to intermingle reads and writes like that.
> +/**
> + * page_cache_readahead_exceed - Start unchecked readahead.
> + * @mapping: File address space.
> + * @file: This instance of the open file; used for authentication.
> + * @index: First page index to read.
> + * @nr_to_read: The number of pages to read.
> + * @lookahead_size: Where to start the next readahead.
> + *
> + * This function is for filesystems to call when they want to start
> + * readahead beyond a file's stated i_size.  This is almost certainly
> + * not the function you want to call.  Use page_cache_async_readahead()
> + * or page_cache_sync_readahead() instead.
> + *
> + * Context: File is referenced by caller.  Mutexes may be held by caller.
> + * May sleep, but will not reenter filesystem to reclaim memory.

Yup, looks much better.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
