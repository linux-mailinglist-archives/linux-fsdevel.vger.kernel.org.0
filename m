Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192F835FD7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhDNV6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 17:58:06 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:59054 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhDNV6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:58:06 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 6F85C1140474;
        Thu, 15 Apr 2021 07:57:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWnVz-008Dty-Ua; Thu, 15 Apr 2021 07:57:39 +1000
Date:   Thu, 15 Apr 2021 07:57:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210414215739.GH63242@dread.disaster.area>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210414000113.GG63242@dread.disaster.area>
 <20210414122319.GD31323@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414122319.GD31323@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=okFlZK5Gy1F5i8BF3G8A:9 a=FPZG3ZJ8YKhqHbYJ:21 a=YwUA21l3Sj-Qg0rY:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:23:19PM +0200, Jan Kara wrote:
> On Wed 14-04-21 10:01:13, Dave Chinner wrote:
> > On Tue, Apr 13, 2021 at 01:28:46PM +0200, Jan Kara wrote:
> > > index c5b0457415be..ac5bb50b3a4c 100644
> > > --- a/mm/readahead.c
> > > +++ b/mm/readahead.c
> > > @@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > >  	 */
> > >  	unsigned int nofs = memalloc_nofs_save();
> > >  
> > > +	down_read(&mapping->host->i_mapping_sem);
> > >  	/*
> > >  	 * Preallocate as many pages as we will need.
> > >  	 */
> > 
> > I can't say I'm a great fan of having the mapping reach back up to
> > the host to lock the host. THis seems the wrong way around to me
> > given that most of the locking in the IO path is in "host locks
> > mapping" and "mapping locks internal mapping structures" order...
> > 
> > I also come back to the naming confusion here, in that when we look
> > at this in long hand from the inode perspective, this chain actually
> > looks like:
> > 
> > 	lock(inode->i_mapping->inode->i_mapping_sem)
> > 
> > i.e. the mapping is reaching back up outside it's scope to lock
> > itself against other inode->i_mapping operations. Smells of layering
> > violations to me.
> > 
> > So, next question: should this truncate semanphore actually be part
> > of the address space, not the inode? This patch is actually moving
> > the page fault serialisation from the inode into the address space
> > operations when page faults and page cache operations are done, so
> > maybe the lock should also make that move? That would help clear up
> > the naming problem, because now we can name it based around what it
> > serialises in the address space, not the address space as a whole...
> 
> I think that moving the lock to address_space makes some sence although the
> lock actually protects consistency of inode->i_mapping->i_pages with
> whatever the filesystem has in its file_offset->disk_block mapping
> structures (which are generally associated with the inode).

Well, I look at is as a mechanism that the filesystem uses to ensure
coherency of the page cache accesses w.r.t. physical layout changes.
The layout is a property of the inode, but changes to the physical
layout of the inode are serialised by other inode based mechanisms.
THe page cache isn't part of the inode - it's part of the address
space - but coherency with the inode is required. Hence inode
operations need to be able to ensure coherency of the address space
content and accesses w.r.t. physical layout changes of the inode,
but the address space really knows nothing about the physical layout
of the inode or how it gets changed...

Hence it's valid for the inode operations to lock the address space
to ensure coherency of the page cache when making physical layout
changes, but locking the address space, by itself, is not sufficient
to safely serialise against physical changes to the inode layout.

> So it is not
> only about inode->i_mapping contents but I agree that struct address_space
> is probably a bit more logical place than struct inode.

Yup. Remember that the XFS_MMAPLOCK arose at the inode level because
that was the only way the filesystem could acheive the necessary
serialisation of page cache accesses whilst doing physical layout
changes. So the lock became an "inode property" because of
implementation constraints, not because it was the best way to
implement the necessary coherency hooks.

> Regarding the name: How about i_pages_rwsem? The lock is protecting
> invalidation of mapping->i_pages and needs to be held until insertion of
> pages into i_pages is safe again...

I don't actually have a good name for this right now. :(

The i_pages structure has it's own internal locking, so
i_pages_rwsem implies things that aren't necessarily true, and
taking a read lock for insertion for something that is named like a
structure protection lock creates cognitive dissonance...

I keep wanting to say "lock for invalidation" and "lock to exclude
invalidation" because those are the two actions that we need for
coherency of operations. But they are way too verbose for an actual
API...

So I want to call this an "invalidation lock" of some kind (no need
to encode the type in the name!), but haven't worked out a good
shorthand for "address space invalidation coherency mechanism"...

Naming is hard. :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
