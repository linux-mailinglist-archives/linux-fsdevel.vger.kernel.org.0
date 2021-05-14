Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89262380813
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhENLIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 07:08:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLIP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 07:08:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 724A5AF11;
        Fri, 14 May 2021 11:07:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB2D71F2B4A; Fri, 14 May 2021 13:07:00 +0200 (CEST)
Date:   Fri, 14 May 2021 13:07:00 +0200
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
Message-ID: <20210514110700.GA27655@quack2.suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <YJvo1bGG1tG+gtgC@casper.infradead.org>
 <20210513190114.GJ2734@quack2.suse.cz>
 <YJ2AR0IURFzz+52G@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ2AR0IURFzz+52G@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-05-21 20:38:47, Matthew Wilcox wrote:
> On Thu, May 13, 2021 at 09:01:14PM +0200, Jan Kara wrote:
> > On Wed 12-05-21 15:40:21, Matthew Wilcox wrote:
> > > Remind me (or, rather, add to the documentation) why we have to hold the
> > > invalidate_lock during the call to readpage / readahead, and we don't just
> > > hold it around the call to add_to_page_cache / add_to_page_cache_locked
> > > / add_to_page_cache_lru ?  I appreciate that ->readpages is still going
> > > to suck, but we're down to just three implementations of ->readpages now
> > > (9p, cifs & nfs).
> > 
> > There's a comment in filemap_create_page() trying to explain this. We need
> > to protect against cases like: Filesystem with 1k blocksize, file F has
> > page at index 0 with uptodate buffer at 0-1k, rest not uptodate. All blocks
> > underlying page are allocated. Now let read at offset 1k race with hole
> > punch at offset 1k, length 1k.
> > 
> > read()					hole punch
> > ...
> >   filemap_read()
> >     filemap_get_pages()
> >       - page found in the page cache but !Uptodate
> >       filemap_update_page()
> > 					  locks everything
> > 					  truncate_inode_pages_range()
> > 					    lock_page(page)
> > 					    do_invalidatepage()
> > 					    unlock_page(page)
> >         locks page
> >           filemap_read_page()
> 
> Ah, this is the partial_start case, which means that page->mapping
> is still valid.  But that means that do_invalidatepage() was called
> with (offset 1024, length 1024), immediately after we called
> zero_user_segment().  So isn't this a bug in the fs do_invalidatepage()?
> The range from 1k-2k _is_ uptodate.  It's been zeroed in memory,
> and if we were to run after the "free block" below, we'd get that
> memory zeroed again.

Well, yes, do_invalidatepage() could mark zeroed region as uptodate. But I
don't think we want to rely on 'uptodate' not getting spuriously cleared
(which would reopen the problem). Generally the assumption is that there's
no problem clearing (or not setting) uptodate flag of a clean buffer
because the fs can always provide the data again. Similarly, fs is free to
refetch data into clean & uptodate page, if it thinks it's worth it. Now
all these would become correctness issues. So IMHO the fragility is not
worth the shorter lock hold times. That's why I went for the rule that
read-IO submission is still protected by invalidate_lock to make things
simple.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
