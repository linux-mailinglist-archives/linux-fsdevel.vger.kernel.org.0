Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29121BDA05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438957AbfIYIkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 04:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406899AbfIYIkT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:40:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6A4FAF9C;
        Wed, 25 Sep 2019 08:40:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DD041E481F; Wed, 25 Sep 2019 10:40:31 +0200 (CEST)
Date:   Wed, 25 Sep 2019 10:40:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190925084031.GA23277@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190923211011.GH20367@quack2.suse.cz>
 <20190924102926.GC17526@bobrowski>
 <20190924141321.GC11819@quack2.suse.cz>
 <20190925071429.GA27699@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925071429.GA27699@bobrowski>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-09-19 17:14:29, Matthew Bobrowski wrote:
> On Tue, Sep 24, 2019 at 04:13:21PM +0200, Jan Kara wrote:
> > On Tue 24-09-19 20:29:26, Matthew Bobrowski wrote:
> > > On Mon, Sep 23, 2019 at 11:10:11PM +0200, Jan Kara wrote:
> > > > On Thu 12-09-19 21:04:46, Matthew Bobrowski wrote:
> > > > > +	if (offset + count > i_size_read(inode) ||
> > > > > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > > > > +		ext4_update_i_disksize(inode, inode->i_size);
> > > > > +		extend = true;
> > > > > +	}
> > > > 
> > > > This call to ext4_update_i_disksize() is definitely wrong. If nothing else,
> > > > you need to also have transaction started and call ext4_mark_inode_dirty()
> > > > to actually journal the change of i_disksize (ext4_update_i_disksize()
> > > > updates only the in-memory copy of the entry). Also the direct IO code
> > > > needs to add the inode to the orphan list so that in case of crash, blocks
> > > > allocated beyond EOF get truncated on next mount. That is the whole point
> > > > of this excercise with i_disksize after all.
> > > > 
> > > > But I'm wondering if i_disksize update is needed. Truncate cannot be in
> > > > progress (we hold i_rwsem) and dirty pages will be flushed by
> > > > iomap_dio_rw() before we start to allocate any blocks. So it should be
> > > > enough to have here:
> > > 
> > > Well, I initially thought the same, however doing some research shows that we
> > > have the following edge case:
> > >      - 45d8ec4d9fd54
> > >      and
> > >      - 73fdad00b208b
> > > 
> > > In fact you can reproduce the exact same i_size corruption issue by running
> > > the generic/475 xfstests mutitple times, as articulated within
> > > 45d8ec4d9fd54. So with that, I'm kind of confused and thinking that there may
> > > be a problem that resides elsewhere that may need addressing?
> > 
> > Right, I forgot about the special case explained in 45d8ec4d9fd54 where
> > there's unwritted delalloc write beyond range where DIO write happens.
> > 
> > > > 	if (offset + count > i_size_read(inode)) {
> > > > 		/*
> > > > 		 * Add inode to orphan list so that blocks allocated beyond
> > > > 		 * EOF get properly truncated in case of crash.
> > > > 		 */
> > > > 		start transaction handle
> > > > 		add inode to orphan list
> > > > 		stop transaction handle
> > > > 	}
> > > > 
> > > > And just leave i_disksize at whatever it currently is.
> > > 
> > > I originally had the code which added the inode to the orphan list here, but
> > > then I thought to myself that it'd make more sense to actually do this step
> > > closer to the point where we've managed to successfully allocate the required
> > > blocks for the write. This prevents the need to spray orphan list clean up
> > > code all over the place just to cover the case that a write which had intended
> > > to extend the inode beyond i_size had failed prematurely (i.e. before block
> > > allocation). So, hence the reason why I thought having it in
> > > ext4_iomap_begin() would make more sense, because at that point in the write
> > > path, there is enough/or more assurance to make the call around whether we
> > > will in fact be able to perform the write which will be extending beyond
> > > i_size, or not and consequently whether the inode should be placed onto the
> > > orphan list?
> > > 
> > > Ideally I'd like to turn this statement into:
> > > 
> > > 	if (offset + count > i_size_read(inode))
> > > 	        extend = true;
> > > 
> > > Maybe I'm missing something here and there's actually a really good reason for
> > > doing this nice and early? What are your thoughts about what I've mentioned
> > > above?
> > 
> > Well, the slight trouble with adding inode to orphan list in
> > ext4_iomap_begin() is that then it is somewhat difficult to tell whether
> > you need to remove it when IO is done because there's no way how to
> > propagate that information from ext4_iomap_begin() and checking against
> > i_disksize is unreliable because it can change (due to writeback of
> > delalloc pages) while direct IO is running. But I think we can overcome
> > that by splitting our end_io functions to two - ext4_dio_write_end_io() and
> > ext4_dio_extend_write_end_io(). So:
> > 
> > 	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> > 	/*
> > 	 * Need to check against i_disksize as there may be dellalloc writes
> > 	 * pending.
> > 	 */
> >  	if (offset + count > EXT4_I(inode)->i_disksize)
> > 		extend = true;
> 
> Hm... I'm not entirely convinced that EXT4_I(inode)->i_disksize is what we
> should be using to determine whether an extension will be performed or
> not? Because, my understanding is that i_size is what holds the actual value
> of what the file size is expected to be and hence the reason why we previously
> updated the i_disksize to i_size using ext4_update_i_disksize().

So i_size is how inode size actually appears to user. i_disksize is what
inode size really is on disk. And because of orphan handling and similar
stuff requiring i_rwsem protection, we need to use the slow path waiting
for DIO to complete whenever the direct IO is beyond the on-disk version of
inode size. Possibly there are other places in DIO path that need to use
i_disksize instead of i_size as well - I'll check that once I see new
version of your patches.

> Also, there are cases where offset + count > EXT4_I(inode)->i_disksize,
> however offset + count < i_size_read(inode). So in that case we may take an
> incorrect path somewhere i.e. below where extend clause is true. Also, I feel
> as though we should try stick to using one value as the reference to determine
> whether we're performing an extension and not use i_disksize here and then
> i_size over there kind of thing as that leads to unnecessary confusion?

Well, when DIO extends past i_disksize, it needs to add inode to orphan
list, call truncate in case of failed write, etc. So extension of
i_disksize is what actually matters. I was speaking in the past about
i_size because I thought i_size == i_disksize for the cases we care for but
as you properly pointed out that isn't necessarily the case.

> > 	...
> > 	iomap_dio_rw(...,
> > 		extend ? ext4_dio_extend_write_end_io : ext4_dio_write_end_io);
> > 
> > and ext4_dio_write_end_io() will just take care of conversion of unwritten
> > extents on successful IO completion, while ext4_dio_extend_write_end_io()
> > will take care of all the complex stuff with orphan handling, extension
> > of inode size, and truncation of blocks beyond EOF - and it can do that
> > because it is guaranteed to run under the protection of i_rwsem held in
> > ext4_dio_write_iter().
> > 
> > Alternatively, we could also just pass NULL instead of
> > ext4_dio_extend_write_end_io() and just do all the work explicitely in
> > ext4_dio_write_iter() in the 'extend' case. That might be actually the most
> > transparent option...
> 
> Well, with the changes to ext4_handle_inode_extension() conditions that you
> recommended in patch 2/6, then I can't see why we'd need two separate
> ->end_io() handlers as we'd just abort early if we're not extending?

The problem is that the condition I've suggested for patch 2/6 will be
actually racy if we use i_disksize for comparison. Consider the following
situation:

CPU1					CPU2
fd1 = open("file");			fd2 = open("file", O_DIRECT);
/* Delalloc write */
pwrite(fd1, buf, 4096, 16384);
					/* O_DIRECT write */
					pwrite(fd2, buf, 4096, 4096)
					  i_disksize == 0 so we have to add
					  inode to orphan list
					    submit DIO
writeback happens, i_disksize extended
to 20480.
					    DIO completes ->
					    ext4_dio_write_end_io() - sees
					    big i_disksize so does not
					    touch orphan list and inode is
					    wrongly left there.


And we cannot remove inode unconditionally from the orphan list in
ext4_dio_write_end_io() as when DIO starts already below i_disksize,
ext4_dio_write_end_io() may get called without i_rwsem protection.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
