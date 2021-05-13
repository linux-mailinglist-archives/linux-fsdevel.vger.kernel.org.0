Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11A737FDBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEMTC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 15:02:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhEMTC1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 15:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 252DCB175;
        Thu, 13 May 2021 19:01:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D21E21E0E33; Thu, 13 May 2021 21:01:14 +0200 (CEST)
Date:   Thu, 13 May 2021 21:01:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
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
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210513190114.GJ2734@quack2.suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <YJvo1bGG1tG+gtgC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJvo1bGG1tG+gtgC@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 15:40:21, Matthew Wilcox wrote:
> On Wed, May 12, 2021 at 03:46:11PM +0200, Jan Kara wrote:
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
> 
> Remind me (or, rather, add to the documentation) why we have to hold the
> invalidate_lock during the call to readpage / readahead, and we don't just
> hold it around the call to add_to_page_cache / add_to_page_cache_locked
> / add_to_page_cache_lru ?  I appreciate that ->readpages is still going
> to suck, but we're down to just three implementations of ->readpages now
> (9p, cifs & nfs).

There's a comment in filemap_create_page() trying to explain this. We need
to protect against cases like: Filesystem with 1k blocksize, file F has
page at index 0 with uptodate buffer at 0-1k, rest not uptodate. All blocks
underlying page are allocated. Now let read at offset 1k race with hole
punch at offset 1k, length 1k.

read()					hole punch
...
  filemap_read()
    filemap_get_pages()
      - page found in the page cache but !Uptodate
      filemap_update_page()
					  locks everything
					  truncate_inode_pages_range()
					    lock_page(page)
					    do_invalidatepage()
					    unlock_page(page)
        locks page
          filemap_read_page()
            ->readpage()
              block underlying offset 1k
	      still allocated -> map buffer
					  free block under offset 1k
	      submit IO -> corrupted data

If you think I should expand it to explain more details, please tell.
Or maybe I can put more detailed discussion like above into the changelog?

> Also, could I trouble you to run the comments through 'fmt' (or
> equivalent)?  It's easier to read if you're not kissing right up on 80
> columns.

Sure, will do.

> > +++ b/fs/inode.c
> > @@ -190,6 +190,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> >  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
> >  	mapping->private_data = NULL;
> >  	mapping->writeback_index = 0;
> > +	init_rwsem(&mapping->invalidate_lock);
> > +	lockdep_set_class(&mapping->invalidate_lock,
> > +			  &sb->s_type->invalidate_lock_key);
> 
> Why not:
> 
> 	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
> 			&sb->s_type->invalidate_lock_key);

I replicated what we do for i_rwsem but you're right, this is better.
Updated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
