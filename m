Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEC369D1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhDWXFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 19:05:35 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56364 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232992AbhDWXFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 19:05:32 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id A7DB51AF798;
        Sat, 24 Apr 2021 09:04:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1la4qv-004cCW-Fb; Sat, 24 Apr 2021 09:04:49 +1000
Date:   Sat, 24 Apr 2021 09:04:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Ted Tso <tytso@mit.edu>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 02/12] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210423230449.GC1990290@dread.disaster.area>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423173018.23133-2-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=fwWlK0ynS9Jva5SY9FMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 07:29:31PM +0200, Jan Kara wrote:
> Currently, serializing operations such as page fault, read, or readahead
> against hole punching is rather difficult. The basic race scheme is
> like:
> 
> fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
>   truncate_inode_pages_range()
> 						  <create pages in page
> 						   cache here>
>   <update fs block mapping and free blocks>
> 
> Now the problem is in this way read / page fault / readahead can
> instantiate pages in page cache with potentially stale data (if blocks
> get quickly reused). Avoiding this race is not simple - page locks do
> not work because we want to make sure there are *no* pages in given
> range. inode->i_rwsem does not work because page fault happens under
> mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
> the performance for mixed read-write workloads suffer.
> 
> So create a new rw_semaphore in the address_space - invalidate_lock -
> that protects adding of pages to page cache for page faults / reads /
> readahead.
.....
> diff --git a/fs/inode.c b/fs/inode.c
> index a047ab306f9a..43596dd8b61e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -191,6 +191,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> +	init_rwsem(&mapping->invalidate_lock);
> +	lockdep_set_class(&mapping->invalidate_lock,
> +			  &sb->s_type->invalidate_lock_key);
>  	inode->i_private = NULL;
>  	inode->i_mapping = mapping;
>  	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */

Oh, lockdep. That might be a problem here.

The XFS_MMAPLOCK has non-trivial lockdep annotations so that it is
tracked as nesting properly against the IOLOCK and the ILOCK. When
you end up using xfs_ilock(XFS_MMAPLOCK..) to lock this, XFS will
add subclass annotations to the lock and they are going to be
different to the locking that the VFS does.

We'll see this from xfs_lock_two_inodes() (e.g. in
xfs_swap_extents()) and xfs_ilock2_io_mmap() during reflink
oper.....

Oooooh. The page cache copy done when breaking a shared extent needs
to lock out page faults on both the source and destination, but it
still needs to be able to populate the page cache of both the source
and destination file.....

.... and vfs_dedupe_file_range_compare() has to be able to read
pages from both the source and destination file to determine that
the contents are identical and that's done while we hold the
XFS_MMAPLOCK exclusively so the compare is atomic w.r.t. all other
user data modification operations being run....

I now have many doubts that this "serialise page faults by locking
out page cache instantiation" method actually works as a generic
mechanism. It's not just page cache invalidation that relies on
being able to lock out page faults: copy-on-write and deduplication
both require the ability to populate the page cache with source data
while page faults are locked out so the data can be compared/copied
atomically with the extent level manipulations and so user data
modifications cannot occur until the physical extent manipulation
operation has completed.

Having only just realised this is a problem, no solution has
immediately popped into my mind. I'll chew on it over the weekend,
but I'm not hopeful at this point...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
