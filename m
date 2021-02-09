Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E023145C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBIBok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:44:40 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:60693 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBIBok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:44:40 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 405CC8ED1;
        Tue,  9 Feb 2021 12:43:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9I4L-00DQHu-GB; Tue, 09 Feb 2021 12:43:57 +1100
Date:   Tue, 9 Feb 2021 12:43:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2 RFC v2] fs: Hole punch vs page cache filling races
Message-ID: <20210209014357.GR4626@dread.disaster.area>
References: <20210208163918.7871-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208163918.7871-1-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=swymq8zasdnAYfGG_g4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:39:16PM +0100, Jan Kara wrote:
> Hello,
> 
> Amir has reported [1] a that ext4 has a potential issues when reads can race
> with hole punching possibly exposing stale data from freed blocks or even
> corrupting filesystem when stale mapping data gets used for writeout. The
> problem is that during hole punching, new page cache pages can get instantiated
> and block mapping from the looked up in a punched range after
> truncate_inode_pages() has run but before the filesystem removes blocks from
> the file. In principle any filesystem implementing hole punching thus needs to
> implement a mechanism to block instantiating page cache pages during hole
> punching to avoid this race. This is further complicated by the fact that there
> are multiple places that can instantiate pages in page cache.  We can have
> regular read(2) or page fault doing this but fadvise(2) or madvise(2) can also
> result in reading in page cache pages through force_page_cache_readahead().
> 
> There are couple of ways how to fix this. First way (currently implemented by
> XFS) is to protect read(2) and *advise(2) calls with i_rwsem so that they are
> serialized with hole punching. This is easy to do but as a result all reads
> would then be serialized with writes and thus mixed read-write workloads suffer
> heavily on ext4. Thus this series introduces inode->i_mapping_sem and uses it
> when creating new pages in the page cache and looking up their corresponding
> block mapping. We also replace EXT4_I(inode)->i_mmap_sem with this new rwsem
> which provides necessary serialization with hole punching for ext4. If this
> approach looks viable, I'll convert also other equivalent fs locks to use this
> new VFS semaphore instead - in particular XFS' XFS_MMAPLOCK, f2fs's i_mmap_sem,
> fuse's i_mmap_sem and maybe others as well.

So a page cache read needs to take this lock.

What happens if a hole punch range is not block aligned and needs to
zero part of a block that is not in cache? i.e. we do this:

fallocate(punch_hole)
down_write(i_mapping_sem)
invalidate whole cached pages within the punched range
zero sub-block edges of range
punch extents out extents
up_write(i_mapping_sem)

The question that comes to mind for me is about the zeroing of the
edges of the range. If those pages are not in cache, we have to read
them in, and that goes through the page cache, which according to
the rules you mention above should be taking
down_read(i_mapping_sem)....

Of course, if we are now requiring different locking for page cache
instantiation done by read() call patchs vs those done by, say,
iomap_zero_range(), then this seems like it is opening up a
can of worms with some interfaces requiring the caller to hold
i_mapping_sem and others taking it internally so the caller must not
hold it....

Can you spell out the way this lock is supposed to nest amongst
other locks, and where and how it is expected to be taken, what the
rules are for doing atomic RMW operations through the page cache
while we have IO and page faults locked out, etc?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
