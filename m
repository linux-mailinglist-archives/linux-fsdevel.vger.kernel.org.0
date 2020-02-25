Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032C316B650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 01:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgBYAJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 19:09:46 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54329 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgBYAJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:09:45 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 899633A1961;
        Tue, 25 Feb 2020 11:09:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j6Nn7-0004kt-Lc; Tue, 25 Feb 2020 11:09:37 +1100
Date:   Tue, 25 Feb 2020 11:09:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200225000937.GA10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de>
 <20200221224419.GW10776@dread.disaster.area>
 <20200224175603.GE7771@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224175603.GE7771@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=Nhs22OFJWa-oc4Q03hQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:56:03PM +0100, Christoph Hellwig wrote:
> On Sat, Feb 22, 2020 at 09:44:19AM +1100, Dave Chinner wrote:
> > > I am very much against this.  There is a reason why we don't support
> > > changes of ops vectors at runtime anywhere else, because it is
> > > horribly complicated and impossible to get right.  IFF we ever want
> > > to change the DAX vs non-DAX mode (which I'm still not sold on) the
> > > right way is to just add a few simple conditionals and merge the
> > > aops, which is much easier to reason about, and less costly in overall
> > > overhead.
> > 
> > *cough*
> > 
> > That's exactly what the original code did. And it was broken
> > because page faults call multiple aops that are dependent on the
> > result of the previous aop calls setting up the state correctly for
> > the latter calls. And when S_DAX changes between those calls, shit
> > breaks.
> 
> No, the original code was broken because it didn't serialize between
> DAX and buffer access.
> 
> Take a step back and look where the problems are, and they are not
> mostly with the aops.  In fact the only aop useful for DAX is
> is ->writepages, and how it uses ->writepages is actually a bit of
> an abuse of that interface.

The races are all through the fops, too, which is one of the reasons
Darrick mentioned we should probably move this up to file ops
level...

> So what we really need it just a way to prevent switching the flag
> when a file is mapped,

That's not sufficient.

We also have to prevent the file from being mapped *while we are
switching*. Nothing in the mmap() path actually serialises against
filesystem operations, and the initial behavioural checks in the
page fault path are similarly unserialised against changing the
S_DAX flag.

e.g. there's a race against ->mmap() with switching the the S_DAX
flag. In xfs_file_mmap():

        file_accessed(file);
        vma->vm_ops = &xfs_file_vm_ops;
        if (IS_DAX(inode))
                vma->vm_flags |= VM_HUGEPAGE;

So if this runs while a switch from true to false is occurring,
we've got a non-dax VMA with huge pages enabled, and the non-dax
page fault path doesn't support this.

If we are really lucky, we'll have IS_DAX() set just long
enough to get through this check in xfs_filemap_huge_fault():

        if (!IS_DAX(file_inode(vmf->vma->vm_file)))
                return VM_FAULT_FALLBACK;

and then we'll get into __xfs_filemap_fault() and block on the
MMAPLOCK. When we actually get that lock, S_DAX will now be false
and we have a huge page fault running through a path (page cache IO)
that doesn't support huge pages...

This is the sort of landmine switching S_DAX without serialisation
causes. The methods themselves look sane, but it's cross-method
dependencies for a stable S_DAX flag that is the real problem.

Yes, we can probably fix this by adding XFS_MMAPLOCK_SHARED here,
but means every filesystem has to solve the same race conditions
itself. That's hard to get right and easy to get wrong. If the
VFS/mm subsystem provides the infrastructure needed to use this
functionality safely, then that is hard for filesystem developers to
get wrong.....

> and in the normal read/write path ensure the
> flag can't be switch while I/O is going on, which could either be
> done by ensuring it is only switched under i_rwsem or equivalent
> protection, or by setting the DAX flag once in the iocb similar to
> IOCB_DIRECT.

The iocb path is not the problem - that's entirely serialised
against S_DAX changes by the i_rwsem. The problem is that we have no
equivalent filesystem level serialisation for the entire mmap/page
fault path, and it checks S_DAX all over the place.

It's basically the same limitation that we have with mmap vs direct
IO - we can't lock out mmap when we do direct IO, so we cannot
guarantee coherency between the two. Similar here - we cannot
lockout mmap in any sane way, so we cannot guarantee coherency
between mmap and changing the S_DAX flag.

That's the underlying problem we need to solve here.

/me wonders if the best thing to do is to add a ->fault callout to
tell the filesystem to lock/unlock the inode right up at the top of
the page fault path, outside even the mmap_sem.  That means all the
methods that the page fault calls are protected against S_DAX
changes, and it gives us a low cost method of serialising page
faults against DIO (e.g. via inode_dio_wait())....

> And they easiest way to get all this done is as a first step to
> just allowing switching the flag when no blocks are allocated at
> all, similar to how the rt flag works.

False equivalence - it is not similar because the RT flag changes
and their associated state checks are *already fully serialised* by
the XFS_ILOCK_EXCL. S_DAX accesses have no such serialisation, and
that's the problem we need to solve...

In reality, I don't really care how we solve this problem, but we've
been down the path you are suggesting at least twice before and each
time we've ended up in a "that doesn't work" corner and had to
persue other solutions. I don't like going around in circles.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
