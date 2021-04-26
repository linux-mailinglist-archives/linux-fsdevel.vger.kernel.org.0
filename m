Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8D36B616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhDZPrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 11:47:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234090AbhDZPrX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:47:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55725ABB1;
        Mon, 26 Apr 2021 15:46:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C7AF41E0CB7; Mon, 26 Apr 2021 17:46:39 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:46:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20210426154639.GB23895@quack2.suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-2-jack@suse.cz>
 <20210423230449.GC1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423230449.GC1990290@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 24-04-21 09:04:49, Dave Chinner wrote:
> On Fri, Apr 23, 2021 at 07:29:31PM +0200, Jan Kara wrote:
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
> .....
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a047ab306f9a..43596dd8b61e 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -191,6 +191,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> >  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
> >  	mapping->private_data = NULL;
> >  	mapping->writeback_index = 0;
> > +	init_rwsem(&mapping->invalidate_lock);
> > +	lockdep_set_class(&mapping->invalidate_lock,
> > +			  &sb->s_type->invalidate_lock_key);
> >  	inode->i_private = NULL;
> >  	inode->i_mapping = mapping;
> >  	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
> 
> Oh, lockdep. That might be a problem here.
> 
> The XFS_MMAPLOCK has non-trivial lockdep annotations so that it is
> tracked as nesting properly against the IOLOCK and the ILOCK. When
> you end up using xfs_ilock(XFS_MMAPLOCK..) to lock this, XFS will
> add subclass annotations to the lock and they are going to be
> different to the locking that the VFS does.
> 
> We'll see this from xfs_lock_two_inodes() (e.g. in
> xfs_swap_extents()) and xfs_ilock2_io_mmap() during reflink
> oper.....

Thanks for the pointer. I was kind of wondering what lockdep nesting games
XFS plays but then forgot to look into details. Anyway, I've preserved the
nesting annotations in XFS and fstests run on XFS passed without lockdep
complaining so there isn't at least an obvious breakage. Also as far as I'm
checking the code XFS usage in and lock nesting of MMAPLOCK should be
compatible with the nesting VFS enforces (also see below)...
 
> Oooooh. The page cache copy done when breaking a shared extent needs
> to lock out page faults on both the source and destination, but it
> still needs to be able to populate the page cache of both the source
> and destination file.....
> 
> .... and vfs_dedupe_file_range_compare() has to be able to read
> pages from both the source and destination file to determine that
> the contents are identical and that's done while we hold the
> XFS_MMAPLOCK exclusively so the compare is atomic w.r.t. all other
> user data modification operations being run....

So I started wondering why fstests passed when reading this :) The reason
is that vfs_dedupe_get_page() does not use standard page cache filling path
(neither readahead API nor filemap_read()), instead it uses
read_mapping_page() and so gets into page cache filling path below the
level at which we get invalidate_lock and thus everything works as it
should. So read_mapping_page() is similar to places like e.g.
block_truncate_page() or block_write_begin() which may end up filling in
page cache contents but they rely on upper layers to already hold
appropriate locks. I'll add a comment to read_mapping_page() about this.
Once all filesystems are converted to use invalidate_lock, I also want to
add WARN_ON_ONCE() to various places verifying that invalidate_lock is held
as it should...
 
> I now have many doubts that this "serialise page faults by locking
> out page cache instantiation" method actually works as a generic
> mechanism. It's not just page cache invalidation that relies on
> being able to lock out page faults: copy-on-write and deduplication
> both require the ability to populate the page cache with source data
> while page faults are locked out so the data can be compared/copied
> atomically with the extent level manipulations and so user data
> modifications cannot occur until the physical extent manipulation
> operation has completed.

Hum, that is a good point. So there are actually two different things you
want to block at different places:

1) You really want to block page cache instantiation for operations such as
hole punch as that operation mutates data and thus contents would become
stale.

2) You want to block page cache *modification* for operations such as
dedupe while keeping page cache in place. This is somewhat different
requirement but invalidate_lock can, in principle, cover it as well.
Basically we just need to keep invalidate_lock usage in .page_mkwrite
helpers. The question remains whether invalidate_lock is still a good name
with this usage in mind and I probably need to update a documentation to
reflect this usage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
