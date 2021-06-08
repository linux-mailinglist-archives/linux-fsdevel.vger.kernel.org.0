Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6239F645
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhFHMVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:21:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40962 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhFHMVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:21:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8DB101FD46;
        Tue,  8 Jun 2021 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623154755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gX+FqIGbLzH7Df0aDpilgfPqa5jp+2x0O0Dq2GScA/w=;
        b=KmRVHQ5+eR/D68RNgyB5xqEUQDaqcQqU3/DEnGMciUAKR23nxPjvOV8jc9mUj+j4mpbKkR
        Lv+ZgNiPi3HkId2Fw9ZdzoixgegRoPUsKgKc6PqFoywzWqoPqQ05G/Vtr2p/bP/v7A9DUJ
        iAW7WgczZtH9yytwp+giynzFLBLau4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623154755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gX+FqIGbLzH7Df0aDpilgfPqa5jp+2x0O0Dq2GScA/w=;
        b=j7Q267F20vgcAERTkfcT3mAjx5Fvz3Q43MRpV441Cp/5gRV1if/+naEY6l28Qaymueg/Ex
        tPMoFbA1xdeL5vDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4ABA8A3B84;
        Tue,  8 Jun 2021 12:19:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2C36B1F2C94; Tue,  8 Jun 2021 14:19:15 +0200 (CEST)
Date:   Tue, 8 Jun 2021 14:19:15 +0200
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
Subject: Re: [PATCH 03/14] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210608121915.GG5562@quack2.suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
 <20210607145236.31852-3-jack@suse.cz>
 <20210607160922.GA2945763@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607160922.GA2945763@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-06-21 09:09:22, Darrick J. Wong wrote:
> On Mon, Jun 07, 2021 at 04:52:13PM +0200, Jan Kara wrote:
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
...
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
> 
> Having a page cache invalidation lock isn't optional anymore, so I think
> these last two sentences could be condensed:
> 
> "...from reloading now-stale page cache contents from disk.  Since VFS
> acquires mapping->invalidate_lock in shared mode when loading pages from
> disk (filemap_fault(), filemap_read(), readahead), the fallocate
> implementation must take the invalidate_lock to prevent reloading."
> 
> > +
> > +->copy_file_range and ->remap_file_range implementations need to serialize
> > +against modifications of file data while the operation is running. For
> > +blocking changes through write(2) and similar operations inode->i_rwsem can be
> > +used. For blocking changes through memory mapping, the filesystem can use
> > +mapping->invalidate_lock provided it also acquires it in its ->page_mkwrite
> > +implementation.
> 
> Following the same line of reasoning, if taking the invalidate_lock is
> no longer optional, then the conditional language in this last sentence
> is incorrect.  How about:
> 
> "To block changes to file contents via a memory mapping during the
> operation, the filesystem must take mapping->invalidate_lock to
> coordinate with ->page_mkwrite."
> 
> The code changes look fine to me, though I'm no mm expert. ;)

OK, I've updated the documentation as you suggested. Thanks for review.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
