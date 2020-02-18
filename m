Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A391620E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 07:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgBRGbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 01:31:16 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53608 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgBRGbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:31:16 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5BBFE3A2633;
        Tue, 18 Feb 2020 17:31:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3wPX-0006P4-0T; Tue, 18 Feb 2020 17:31:11 +1100
Date:   Tue, 18 Feb 2020 17:31:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 09/19] mm: Add page_cache_readahead_limit
Message-ID: <20200218063110.GO10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-16-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=ven5Kus8yXOb1GZ9o24A:9
        a=H2SKM-hdKVZ4IyYU:21 a=MGgw-NAvouSNSaNI:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:56AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ext4 and f2fs have duplicated the guts of the readahead code so
> they can read past i_size.  Instead, separate out the guts of the
> readahead code so they can call it directly.

Gross and nasty (hosting non-stale data beyond EOF in the page
cache, that is).

Code is pretty simple, but...

>  }
>  
> -/*
> - * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
> - * the pages first, then submits them for I/O. This avoids the very bad
> - * behaviour which would occur if page allocations are causing VM writeback.
> - * We really don't want to intermingle reads and writes like that.
> +/**
> + * page_cache_readahead_limit - Start readahead beyond a file's i_size.
> + * @mapping: File address space.
> + * @file: This instance of the open file; used for authentication.
> + * @offset: First page index to read.
> + * @end_index: The maximum page index to read.
> + * @nr_to_read: The number of pages to read.
> + * @lookahead_size: Where to start the next readahead.
> + *
> + * This function is for filesystems to call when they want to start
> + * readahead potentially beyond a file's stated i_size.  If you want
> + * to start readahead on a normal file, you probably want to call
> + * page_cache_async_readahead() or page_cache_sync_readahead() instead.
> + *
> + * Context: File is referenced by caller.  Mutexes may be held by caller.
> + * May sleep, but will not reenter filesystem to reclaim memory.
>   */
> -void __do_page_cache_readahead(struct address_space *mapping,
> -		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
> -		unsigned long lookahead_size)
> +void page_cache_readahead_limit(struct address_space *mapping,

... I don't think the function name conveys it's purpose. It's
really a ranged readahead that ignores where i_size lies. i.e

	page_cache_readahead_range(mapping, start, end, nr_to_read)

seems like a better API to me, and then you can drop the "start
readahead beyond i_size" comments and replace it with "Range is not
limited by the inode's i_size and hence can be used to read data
stored beyond EOF into the page cache."

Also: "This is almost certainly not the function you want to call.
Use page_cache_async_readahead or page_cache_sync_readahead()
instead."

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
