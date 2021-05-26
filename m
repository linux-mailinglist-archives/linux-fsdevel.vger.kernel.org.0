Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA65391448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhEZKCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 06:02:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhEZKCC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 06:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622023229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NpZhztfJwCutIMFv3VQ6vEMJjD0AVfxWxnPO+A2TgY=;
        b=eE8Wsu0xeqsbjtD1GnjU4gWzyBTkVBEnkA9sxE7DBgQfKRTNDZ50Mhu1ujfbVXyV7SBXhD
        E463+yYqr0Tt4n1TC0hKEF7rsg2M5s+XtjIN53dLD1Ztshc+Zkvb9iR8jNraf5lBVmr+6d
        hTMsVkZEL068aA8SKEzqvS+esp4PPQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622023229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NpZhztfJwCutIMFv3VQ6vEMJjD0AVfxWxnPO+A2TgY=;
        b=Jox07HWy6Uzll5gCvCasSNs+5CnoQOOrJphWYNbSVN+4OG7jeA2CSCjllCQ2h6favDkcW0
        VMxim1zYs0hwWyCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3F3DB22F;
        Wed, 26 May 2021 10:00:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C56731F2CAC; Wed, 26 May 2021 12:00:27 +0200 (CEST)
Date:   Wed, 26 May 2021 12:00:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/13] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210526100027.GA30369@quack2.suse.cz>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-3-jack@suse.cz>
 <20210525210149.GO202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525210149.GO202121@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-05-21 14:01:49, Darrick J. Wong wrote:
> On Tue, May 25, 2021 at 03:50:40PM +0200, Jan Kara wrote:
> > Currently, serializing operations such as page fault, read, or readahead
> > against hole punching is rather difficult. The basic race scheme is
> > like:
> > 
> > fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
> >   truncate_inode_pages_range()
> > 						  <create pages in page
> > 						   cache here>
> >   <update fs block mapping and free blocks>
> > 
> > Now the problem is in this way read / page fault / readahead can
> > instantiate pages in page cache with potentially stale data (if blocks
> > get quickly reused). Avoiding this race is not simple - page locks do
> > not work because we want to make sure there are *no* pages in given
> > range. inode->i_rwsem does not work because page fault happens under
> > mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
> > the performance for mixed read-write workloads suffer.
> > 
> > So create a new rw_semaphore in the address_space - invalidate_lock -
> > that protects adding of pages to page cache for page faults / reads /
> > readahead.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  Documentation/filesystems/locking.rst | 64 ++++++++++++++++++--------
> >  fs/inode.c                            |  2 +
> >  include/linux/fs.h                    |  6 +++
> >  mm/filemap.c                          | 65 ++++++++++++++++++++++-----
> >  mm/readahead.c                        |  2 +
> >  mm/rmap.c                             | 37 +++++++--------
> >  mm/truncate.c                         |  3 +-
> >  7 files changed, 129 insertions(+), 50 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > index 4ed2b22bd0a8..af425bef55d3 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -271,19 +271,19 @@ prototypes::
> >  locking rules:
> >  	All except set_page_dirty and freepage may block
> >  
> > -======================	======================== =========
> > -ops			PageLocked(page)	 i_rwsem
> > -======================	======================== =========
> > +======================	======================== =========	===============
> > +ops			PageLocked(page)	 i_rwsem	invalidate_lock
> > +======================	======================== =========	===============
> >  writepage:		yes, unlocks (see below)
> > -readpage:		yes, unlocks
> > +readpage:		yes, unlocks				shared
> >  writepages:
> >  set_page_dirty		no
> > -readahead:		yes, unlocks
> > -readpages:		no
> > +readahead:		yes, unlocks				shared
> > +readpages:		no					shared
> >  write_begin:		locks the page		 exclusive
> >  write_end:		yes, unlocks		 exclusive
> >  bmap:
> > -invalidatepage:		yes
> > +invalidatepage:		yes					exclusive
> >  releasepage:		yes
> >  freepage:		yes
> >  direct_IO:
> > @@ -378,7 +378,10 @@ keep it that way and don't breed new callers.
> >  ->invalidatepage() is called when the filesystem must attempt to drop
> >  some or all of the buffers from the page when it is being truncated. It
> >  returns zero on success. If ->invalidatepage is zero, the kernel uses
> > -block_invalidatepage() instead.
> > +block_invalidatepage() instead. The filesystem should exclusively acquire
> 
> s/should/must/ ?  It's not really optional to lock out invalidations
> anymore now that the page cache synchronizes on invalidate_lock, right?

Right, updated.

> > +invalidate_lock before invalidating page cache in truncate / hole punch path
> > +(and thus calling into ->invalidatepage) to block races between page cache
> > +invalidation and page cache filling functions (fault, read, ...).
> >  
> >  ->releasepage() is called when the kernel is about to try to drop the
> >  buffers from the page in preparation for freeing it.  It returns zero to
> > @@ -573,6 +576,27 @@ in sys_read() and friends.
> >  the lease within the individual filesystem to record the result of the
> >  operation
> >  
> > +->fallocate implementation must be really careful to maintain page cache
> > +consistency when punching holes or performing other operations that invalidate
> > +page cache contents. Usually the filesystem needs to call
> > +truncate_inode_pages_range() to invalidate relevant range of the page cache.
> > +However the filesystem usually also needs to update its internal (and on disk)
> > +view of file offset -> disk block mapping. Until this update is finished, the
> > +filesystem needs to block page faults and reads from reloading now-stale page
> > +cache contents from the disk. VFS provides mapping->invalidate_lock for this
> > +and acquires it in shared mode in paths loading pages from disk
> > +(filemap_fault(), filemap_read(), readahead paths). The filesystem is
> > +responsible for taking this lock in its fallocate implementation and generally
> > +whenever the page cache contents needs to be invalidated because a block is
> > +moving from under a page.
> > +
> > +->copy_file_range and ->remap_file_range implementations need to serialize
> > +against modifications of file data while the operation is running. For
> > +blocking changes through write(2) and similar operations inode->i_rwsem can be
> > +used. For blocking changes through memory mapping, the filesystem can use
> > +mapping->invalidate_lock provided it also acquires it in its ->page_mkwrite
> > +implementation.
> 
> Once this patch lands, will there be any filesystems that can skip
> taking invalidate_lock in ->page_mkwrite and not have problems?  Now
> that the address_space has an invalidation lock, everyone is strongly
> incentivized to use it unless they have yet another layer of locks to do
> more or less the same thing, right?

Well, I assume btrfs will want to keep their special extent tree locking
and thus invalidate_lock is not necessary for it strictly speaking.  Also
filesystems supporting only read, write, mmap, truncate (such as udf,
reiserfs, ...) do not really need invalidate_lock (they usually don't
bother with any page_mkwrite helper in fact). So there are going to be
exceptions. I want to add invalidate_lock locking around truncate handling
for these filesystem as well to make locking rules simpler and to be able
to add assertions into VFS helpers. I didn't plan to do this for
.page_mkwrite as there it might actually hurt performance noticeably.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
