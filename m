Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3814504F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgAVJpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 04:45:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:38274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbgAVJou (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:44:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30423BA2F;
        Wed, 22 Jan 2020 09:44:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBCEA1E0A4F; Wed, 22 Jan 2020 10:44:14 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:44:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200122094414.GC12845@quack2.suse.cz>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200121113627.GA1746@quack2.suse.cz>
 <20200121214845.GA14467@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121214845.GA14467@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-01-20 13:48:45, Matthew Wilcox wrote:
> On Tue, Jan 21, 2020 at 12:36:27PM +0100, Jan Kara wrote:
> > > v2: Chris asked me to show what this would look like if we just have
> > > the implementation look up the pages in the page cache, and I managed
> > > to figure out some things I'd done wrong last time.  It's even simpler
> > > than v1 (net 104 lines deleted).
> > 
> > I have an unfinished patch series laying around that pulls the ->readpage
> > / ->readpages API in somewhat different direction so I'd like to discuss
> > whether it's possible to solve my problem using your API. The problem I
> > have is that currently some operations such as hole punching can race with
> > ->readpage / ->readpages like:
> > 
> > CPU0						CPU1
> > fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
> >   filemap_write_and_wait_range()
> >   down_write(inode->i_rwsem);
> >   truncate_pagecache_range();
> > 						readahead(fd, off, len)
> > 						  creates pages in page cache
> > 						  looks up block mapping
> >   removes blocks from inode and frees them
> > 						  issues bio
> > 						    - reads stale data -
> > 						      potential security
> > 						      issue
> > 
> > Now how I wanted to address this is that I'd change the API convention for
> > ->readpage() so that we call it with the page unlocked and the function
> > would lock the page, check it's still OK, and do what it needs. And this
> > will allow ->readpage() and also ->readpages() to grab lock
> > (EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
> > while we are adding pages to page cache and mapping underlying blocks.
> > 
> > Now your API makes even ->readpages() (actually ->readahead) called with
> > pages locked so that makes this approach problematic because of lock
> > inversions. So I'd prefer if we could keep the situation that ->readpages /
> > ->readahead gets called without any pages in page cache locked...
> 
> I'm not a huge fan of that approach because it increases the number of
> atomic ops (right now, we __SetPageLocked on the page before adding it
> to i_pages).

Yeah, good point. The per-page cost of locking may be noticeable.

> Holepunch is a rather rare operation while readpage and
> readpages/readahead are extremely common, so can we make holepunch take a
> lock that will prevent new readpage(s) succeeding?

I'm not opposed - in fact my solution would do exactly that (with
EXT4_I(inode)->i_mmap_sem), just the lock ordering wrt page lock and
mmap_sem is causing troubles and that's why I need the change in the
API for readpage and friends.

> I have an idea to move the lock entries from DAX to being a generic page
> cache concept.  That way, holepunch could insert lock entries into the
> pagecache to cover the range being punched, and readpage(s) would either
> skip lock entries or block on them.

Two notes on the entry locks:

The additional traffic in the xarray creating locked entries and then
removing them is going to cost as well. But if that's only for hole
punching, it would be bearable I guess.

This does not solve the problem with the lock ordering. There are quite
some constraints on this synchronization scheme. Generally we want to
prevent creation of pages in the page cache in a certain range. That means
we need to block read(2), readahead(2), madvise(2) MADV_WILLNEED, page
faults.  The page faults constrain us that the lock has to rank below
mmap_sem. On the other hand hole punching needs to hold the lock while
evicting pages so that mandates that the lock needs to rank above page
lock. Also note that read(2) can cause page faults (to copy data to
userspace) so to avoid lock inversion against mmap_sem, any protection must
not cover that part of the read path which basically leaves us with
->readpage()/->readpages() as the only place where we can grab the lock.
Which nicely covers also all the other places creating pages in the page
cache we need to block. Except that ->readpage has the unfortunate property
of being called under page lock. But maybe we could create a new hook
somewhere in the paths creating pages to acquire the lock early. But so far
I don't have an idea for something nice.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
