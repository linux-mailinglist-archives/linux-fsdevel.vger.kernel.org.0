Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC61465C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAWKb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 05:31:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:54946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgAWKb0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0256B220;
        Thu, 23 Jan 2020 10:31:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60F471E0B01; Thu, 23 Jan 2020 11:31:21 +0100 (CET)
Date:   Thu, 23 Jan 2020 11:31:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200123103121.GB5728@quack2.suse.cz>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200121113627.GA1746@quack2.suse.cz>
 <20200121214845.GA14467@bombadil.infradead.org>
 <20200122094414.GC12845@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122094414.GC12845@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-01-20 10:44:14, Jan Kara wrote:
> On Tue 21-01-20 13:48:45, Matthew Wilcox wrote:
> > On Tue, Jan 21, 2020 at 12:36:27PM +0100, Jan Kara wrote:
> > > > v2: Chris asked me to show what this would look like if we just have
> > > > the implementation look up the pages in the page cache, and I managed
> > > > to figure out some things I'd done wrong last time.  It's even simpler
> > > > than v1 (net 104 lines deleted).
> > > 
> > > I have an unfinished patch series laying around that pulls the ->readpage
> > > / ->readpages API in somewhat different direction so I'd like to discuss
> > > whether it's possible to solve my problem using your API. The problem I
> > > have is that currently some operations such as hole punching can race with
> > > ->readpage / ->readpages like:
> > > 
> > > CPU0						CPU1
> > > fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
> > >   filemap_write_and_wait_range()
> > >   down_write(inode->i_rwsem);
> > >   truncate_pagecache_range();
> > > 						readahead(fd, off, len)
> > > 						  creates pages in page cache
> > > 						  looks up block mapping
> > >   removes blocks from inode and frees them
> > > 						  issues bio
> > > 						    - reads stale data -
> > > 						      potential security
> > > 						      issue
> > > 
> > > Now how I wanted to address this is that I'd change the API convention for
> > > ->readpage() so that we call it with the page unlocked and the function
> > > would lock the page, check it's still OK, and do what it needs. And this
> > > will allow ->readpage() and also ->readpages() to grab lock
> > > (EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
> > > while we are adding pages to page cache and mapping underlying blocks.
> > > 
> > > Now your API makes even ->readpages() (actually ->readahead) called with
> > > pages locked so that makes this approach problematic because of lock
> > > inversions. So I'd prefer if we could keep the situation that ->readpages /
> > > ->readahead gets called without any pages in page cache locked...
> > 
> > I'm not a huge fan of that approach because it increases the number of
> > atomic ops (right now, we __SetPageLocked on the page before adding it
> > to i_pages).
> 
> Yeah, good point. The per-page cost of locking may be noticeable.

Thinking about this a bit more, we should be using ->readpages() to fill
most of the data. And for ->readpages() there would be no additional
overhead. Just for ->readpage() which should be rarely needed. We just need
to come up with a good solution for filesystems that have ->readpage but
not ->readpages.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
