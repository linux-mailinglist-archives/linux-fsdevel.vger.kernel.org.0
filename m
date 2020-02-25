Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5481616EC98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgBYRgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 12:36:37 -0500
Received: from verein.lst.de ([213.95.11.211]:44528 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYRgh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:36:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F2B368BE1; Tue, 25 Feb 2020 18:36:33 +0100 (CET)
Date:   Tue, 25 Feb 2020 18:36:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200225173633.GA30843@lst.de>
References: <20200221004134.30599-1-ira.weiny@intel.com> <20200221004134.30599-8-ira.weiny@intel.com> <20200221174449.GB11378@lst.de> <20200221224419.GW10776@dread.disaster.area> <20200224175603.GE7771@lst.de> <20200225000937.GA10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225000937.GA10776@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:09:37AM +1100, Dave Chinner wrote:
> > No, the original code was broken because it didn't serialize between
> > DAX and buffer access.
> > 
> > Take a step back and look where the problems are, and they are not
> > mostly with the aops.  In fact the only aop useful for DAX is
> > is ->writepages, and how it uses ->writepages is actually a bit of
> > an abuse of that interface.
> 
> The races are all through the fops, too, which is one of the reasons
> Darrick mentioned we should probably move this up to file ops
> level...

But the file ops are very simple to use.  Pass the flag in the iocb,
and make sure the flag can only changed with i_rwsem held.  That part
is pretty trivial, the interesting case is mmap because it is so
spread out.

> > So what we really need it just a way to prevent switching the flag
> > when a file is mapped,
> 
> That's not sufficient.
> 
> We also have to prevent the file from being mapped *while we are
> switching*. Nothing in the mmap() path actually serialises against
> filesystem operations, and the initial behavioural checks in the
> page fault path are similarly unserialised against changing the
> S_DAX flag.

And the important part here is ->mmap.  If ->mmap doesn't get through
we are not going to see page faults.

> > and in the normal read/write path ensure the
> > flag can't be switch while I/O is going on, which could either be
> > done by ensuring it is only switched under i_rwsem or equivalent
> > protection, or by setting the DAX flag once in the iocb similar to
> > IOCB_DIRECT.
> 
> The iocb path is not the problem - that's entirely serialised
> against S_DAX changes by the i_rwsem. The problem is that we have no
> equivalent filesystem level serialisation for the entire mmap/page
> fault path, and it checks S_DAX all over the place.

Not right now.  We have various IS_DAX checks outside it.  But it is
easily fixable indeed.

> /me wonders if the best thing to do is to add a ->fault callout to
> tell the filesystem to lock/unlock the inode right up at the top of
> the page fault path, outside even the mmap_sem.  That means all the
> methods that the page fault calls are protected against S_DAX
> changes, and it gives us a low cost method of serialising page
> faults against DIO (e.g. via inode_dio_wait())....

Maybe.  Especially if it solves real problems and isn't just new
overhead to add an esoteric feature.

> 
> > And they easiest way to get all this done is as a first step to
> > just allowing switching the flag when no blocks are allocated at
> > all, similar to how the rt flag works.
> 
> False equivalence - it is not similar because the RT flag changes
> and their associated state checks are *already fully serialised* by
> the XFS_ILOCK_EXCL. S_DAX accesses have no such serialisation, and
> that's the problem we need to solve...

And my point is that if we ensure S_DAX can only be checked if there
are no blocks on the file, is is fairly easy to provide the same
guarantee.  And I've not heard any argument that we really need more
flexibility than that.  In fact I think just being able to change it
on the parent directory and inheriting the flag might be more than
plenty, which would lead to a very simple implementation without any
of the crazy overhead in this series.
