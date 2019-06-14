Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83D45314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFNDne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 23:43:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53103 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbfFNDnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:43:33 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 505E11AD622;
        Fri, 14 Jun 2019 13:43:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hbd6k-0005oM-Ah; Fri, 14 Jun 2019 13:42:30 +1000
Date:   Fri, 14 Jun 2019 13:42:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190614034230.GP14363@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190612233024.GD14336@iweiny-DESK2.sc.intel.com>
 <20190613005552.GI14363@dread.disaster.area>
 <20190613203406.GB32404@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613203406.GB32404@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=k35vKodN1J5BDQ_Sz-4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 01:34:06PM -0700, Ira Weiny wrote:
> On Thu, Jun 13, 2019 at 10:55:52AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 04:30:24PM -0700, Ira Weiny wrote:
> > > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > > On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > > > > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > > > > Are you suggesting that we have something like this from user space?
> > > > > > 
> > > > > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > > > > 
> > > > > Rather than "unbreakable", perhaps a clearer description of the
> > > > > policy it entails is "exclusive"?
> > > > > 
> > > > > i.e. what we are talking about here is an exclusive lease that
> > > > > prevents other processes from changing the layout. i.e. the
> > > > > mechanism used to guarantee a lease is exclusive is that the layout
> > > > > becomes "unbreakable" at the filesystem level, but the policy we are
> > > > > actually presenting to uses is "exclusive access"...
> > > > 
> > > > That's rather different from the normal meaning of 'exclusive' in the
> > > > context of locks, which is "only one user can have access to this at
> > > > a time".  As I understand it, this is rather more like a 'shared' or
> > > > 'read' lock.  The filesystem would be the one which wants an exclusive
> > > > lock, so it can modify the mapping of logical to physical blocks.
> > > > 
> > > > The complication being that by default the filesystem has an exclusive
> > > > lock on the mapping, and what we're trying to add is the ability for
> > > > readers to ask the filesystem to give up its exclusive lock.
> > > 
> > > This is an interesting view...
> > > 
> > > And after some more thought, exclusive does not seem like a good name for this
> > > because technically F_WRLCK _is_ an exclusive lease...
> > > 
> > > In addition, the user does not need to take the "exclusive" write lease to be
> > > notified of (broken by) an unexpected truncate.  A "read" lease is broken by
> > > truncate.  (And "write" leases really don't do anything different WRT the
> > > interaction of the FS and the user app.  Write leases control "exclusive"
> > > access between other file descriptors.)
> > 
> > I've been assuming that there is only one type of layout lease -
> > there is no use case I've heard of for read/write layout leases, and
> > like you say there is zero difference in behaviour at the filesystem
> > level - they all have to be broken to allow a non-lease truncate to
> > proceed.
> > 
> > IMO, taking a "read lease" to be able to modify and write to the
> > underlying mapping of a file makes absolutely no sense at all.
> > IOWs, we're talking exaclty about a revokable layout lease vs an
> > exclusive layout lease here, and so read/write really doesn't match
> > the policy or semantics we are trying to provide.
> 
> I humbly disagree, at least depending on how you look at it...  :-D
> 
> The patches as they stand expect the user to take a "read" layout lease which
> indicates they are currently using "reading" the layout as is.
> They are not
> changing ("writing" to) the layout.

As I said in a another email in the thread, a layout lease does not
make the layout "read only". It just means the lease owner will be
notified when someone else is about to modify it. The lease owner
can modify the mapping themselves, and they will not get notified
about their own modifications.

> They then pin pages which locks parts of
> the layout and therefore they expect no "writers" to change the layout.

Except they can change the layout themselves. It's perfectly valid
to get a layout lease, write() from offset 0 to EOF and fsync() to
intiialise the file and allocate all the space in the file, then
mmap() it and hand to off to RMDA, all while holding the layout
lease.

> The "write" layout lease breaks the "read" layout lease indicating that the
> layout is being written to.

Layout leases do not work this way.

> In fact, this is what NFS does right now.  The lease it puts on the file is of
> "read" type.
> 
> nfs4layouts.c:
> static int
> nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
> {
> ...
>         fl->fl_flags = FL_LAYOUT;
>         fl->fl_type = F_RDLCK;
> ...
> }

Yes, the existing /implementation/ uses F_RDLCK, but that doesn't
mean the layout is "read only". Look at the pNFS mapping layout code
- the ->map_blocks export operation:

       int (*map_blocks)(struct inode *inode, loff_t offset,
                          u64 len, struct iomap *iomap,
                          bool write, u32 *device_generation);
                          ^^^^^^^^^^

Yup, it has a write variable that, when set, causes the filesystem
to _allocate_ blocks if the range to be written to falls over a hole
in the file.  IOWs, a pNFS layout lease can modify the file layout -
you're conflating use of a "read lock" API to mean that what the
lease _manages_ is "read only". That is not correct.

Layouts are /always writeable/ by the lease owner(s), the question
here is what we do with third parties attempting to modify a layout
covered by an "exclusive" layout lease. Hence, I'll repeat:

> > we're talking exaclty about a revokable layout lease vs an
> > exclusive layout lease here, and so read/write really doesn't match
> > the policy or semantics we are trying to provide.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
