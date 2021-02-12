Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753131A241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBLQBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 11:01:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhBLQBw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:01:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 558E9B773;
        Fri, 12 Feb 2021 16:01:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D4CEA1E62E4; Fri, 12 Feb 2021 17:01:08 +0100 (CET)
Date:   Fri, 12 Feb 2021 17:01:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2 RFC v2] fs: Hole punch vs page cache filling races
Message-ID: <20210212160108.GW19070@quack2.suse.cz>
References: <20210208163918.7871-1-jack@suse.cz>
 <20210209014357.GR4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209014357.GR4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-02-21 12:43:57, Dave Chinner wrote:
> On Mon, Feb 08, 2021 at 05:39:16PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > Amir has reported [1] a that ext4 has a potential issues when reads can race
> > with hole punching possibly exposing stale data from freed blocks or even
> > corrupting filesystem when stale mapping data gets used for writeout. The
> > problem is that during hole punching, new page cache pages can get instantiated
> > and block mapping from the looked up in a punched range after
> > truncate_inode_pages() has run but before the filesystem removes blocks from
> > the file. In principle any filesystem implementing hole punching thus needs to
> > implement a mechanism to block instantiating page cache pages during hole
> > punching to avoid this race. This is further complicated by the fact that there
> > are multiple places that can instantiate pages in page cache.  We can have
> > regular read(2) or page fault doing this but fadvise(2) or madvise(2) can also
> > result in reading in page cache pages through force_page_cache_readahead().
> > 
> > There are couple of ways how to fix this. First way (currently
> > implemented by XFS) is to protect read(2) and *advise(2) calls with
> > i_rwsem so that they are serialized with hole punching. This is easy to
> > do but as a result all reads would then be serialized with writes and
> > thus mixed read-write workloads suffer heavily on ext4. Thus this
> > series introduces inode->i_mapping_sem and uses it when creating new
> > pages in the page cache and looking up their corresponding block
> > mapping. We also replace EXT4_I(inode)->i_mmap_sem with this new rwsem
> > which provides necessary serialization with hole punching for ext4. If
> > this approach looks viable, I'll convert also other equivalent fs locks
> > to use this new VFS semaphore instead - in particular XFS'
> > XFS_MMAPLOCK, f2fs's i_mmap_sem, fuse's i_mmap_sem and maybe others as
> > well.
> 
> So a page cache read needs to take this lock.

Currently, the rules implemented in this patch set are: A page cache read
needs to hold either i_mapping_sem or i_rwsem. And I fully agree with your
comment below that rules need to be spelled out exactly and written
somewhere in the code / documentation. My attempt at that is below.

> What happens if a hole punch range is not block aligned and needs to
> zero part of a block that is not in cache? i.e. we do this:
> 
> fallocate(punch_hole)
> down_write(i_mapping_sem)
> invalidate whole cached pages within the punched range
> zero sub-block edges of range
> punch extents out extents
> up_write(i_mapping_sem)
> 
> The question that comes to mind for me is about the zeroing of the
> edges of the range. If those pages are not in cache, we have to read
> them in, and that goes through the page cache, which according to
> the rules you mention above should be taking
> down_read(i_mapping_sem)....

Well, not all paths are taking i_mapping_sem themselves. The read(2),
fallocate(2) and page fault paths do but e.g. write(2) path which may need
to fetch pages into page cache as well does not grab i_mapping_sem and
leaves all the locking on the caller (and usually i_rwsem makes sure we are
fine). This case (both logically and in terms of code) is actually more
similar to partial block write and hence locking is left on the filesystem
and i_rwsem covers it.

> Of course, if we are now requiring different locking for page cache
> instantiation done by read() call patchs vs those done by, say,
> iomap_zero_range(), then this seems like it is opening up a
> can of worms with some interfaces requiring the caller to hold
> i_mapping_sem and others taking it internally so the caller must not
> hold it....

I agree it's a bit messy. That's why this is RFC and I'm mostly
brainstorming about the least messy way to implement this :).

> Can you spell out the way this lock is supposed to nest amongst
> other locks, and where and how it is expected to be taken, what the
> rules are for doing atomic RMW operations through the page cache
> while we have IO and page faults locked out, etc?

Sure. Let me start with an abstract specification of i_mapping_sem so that
the rest is hopefully better understandable - it is a lock that protects
consistency of page cache information with filesystem's internal
file_offset -> disk_block mapping (both in terms of page contents and
metadata infomation cached with a page - e.g. buffer heads attached to a
page). Now you can observe that on the "loading / using cache info" side
this is a subset of what i_rwsem protects so if you hold i_rwsem, there's
no need to bother with i_mapping_sem.

In terms of lock ordering the relevant locks we have at VFS level are:
mm->mmap_sem, inode->i_rwsem, inode->i_mapping_sem, page lock. The lock
ordering among them is:

i_rwsem --> mmap_sem --> i_mapping_sem --> page_lock
        (1)          (2)               (3)

(1) is enforced by buffered write path where writes may need to fault in
pages from user buffers.
(2) is enforced by the page fault path where we need to synchronize page
faults with hole punching
(3) is enforced by the hole punching path where we need to block page
faults but need to traverse and lock page cache pages.

In terms of when i_mapping_sem is expected to be taken: 
When you are mapping file_offset -> disk_block and using this information
to load data into page cache i_mapping_sem or i_rwsem must be held (for
reading is enough in either case). Given the lock ordering this means you
have to grab i_mapping_sem or i_rwsem before you start looking up / adding
pages to page cache. Page lock needs to protect data loading itself.

When you are going to be modifying file_offset -> disk_block mapping (or
unwritten extent state which is the same from page cache POV), you
must hold i_rwsem for writing. Additionally you must either hold page lock
(usually the case for write path) or i_mapping_sem for writing (usually the
case of hole punching) during the time when page cache contents (both in
terms of data and attached mapping information) is inconsistent with
filesystem's internal file_offset -> disk_block mapping.

In terms of which functions do the lock grabbing for you and which expect
locks to be held the current situation is:

filemap_fault(), generic_file_buffered_read() (or filemap_read() how
Matthew renamed it), all readahead calls take the i_mapping_sem on their
own. All other calls expect i_mapping_sem to be acquired by the caller as
needed. Originally I thought i_mapping_sem would be always up to the caller
to grab but there's no suitable hook in filemap_read() path to grab it and
Christoph didn't want to introduce a new hook just for this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
