Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3371F4476A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfFMQ7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:59:20 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:36961 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729826AbfFMA1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:27:01 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id D76D33DB9FA;
        Thu, 13 Jun 2019 10:26:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hbDYx-00046z-Ci; Thu, 13 Jun 2019 10:25:55 +1000
Date:   Thu, 13 Jun 2019 10:25:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190613002555.GH14363@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612123751.GD32656@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=0tDtZe7MyfZ8QGwI5qwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > Are you suggesting that we have something like this from user space?
> > > 
> > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > 
> > Rather than "unbreakable", perhaps a clearer description of the
> > policy it entails is "exclusive"?
> > 
> > i.e. what we are talking about here is an exclusive lease that
> > prevents other processes from changing the layout. i.e. the
> > mechanism used to guarantee a lease is exclusive is that the layout
> > becomes "unbreakable" at the filesystem level, but the policy we are
> > actually presenting to uses is "exclusive access"...
> 
> That's rather different from the normal meaning of 'exclusive' in the
> context of locks, which is "only one user can have access to this at
> a time".


Layout leases are not locks, they are a user access policy object.
It is the process/fd which holds the lease and it's the process/fd
that is granted exclusive access.  This is exactly the same semantic
as O_EXCL provides for granting exclusive access to a block device
via open(), yes?

> As I understand it, this is rather more like a 'shared' or
> 'read' lock.  The filesystem would be the one which wants an exclusive
> lock, so it can modify the mapping of logical to physical blocks.

ISTM that you're conflating internal filesystem implementation with
application visible semantics. Yes, the filesystem uses internal
locks to serialise the modification of the things the lease manages
access too, but that has nothing to do with the access policy the
lease provides to users.

e.g. Process A has an exclusive layout lease on file F. It does an
IO to file F. The filesystem IO path checks that Process A owns the
lease on the file and so skips straight through layout breaking
because it owns the lease and is allowed to modify the layout. It
then takes the inode metadata locks to allocate new space and write
new data.

Process B now tries to write to file F. The FS checks whether
Process B owns a layout lease on file F. It doesn't, so then it
tries to break the layout lease so the IO can proceed. The layout
breaking code sees that process A has an exclusive layout lease
granted, and so returns -ETXTBSY to process B - it is not allowed to
break the lease and so the IO fails with -ETXTBSY.

i.e. the exclusive layout lease prevents other processes from
performing operations that may need to modify the layout from
performing those operations. It does not "lock" the file/inode in
any way, it just changes how the layout lease breaking behaves.

Further, the "exclusiveness" of a layout lease is completely
irrelevant to the filesystem that is indicating that an operation
that may need to modify the layout is about to be performed. All the
filesystem has to do is handle failures to break the lease
appropriately.  Yes, XFS serialises the layout lease validation
against other IO to the same file via it's IO locks, but that's an
internal data IO coherency requirement, not anything to do with
layout lease management.

Note that I talk about /writes/ here. This is interchangable with
any other operation that may need to modify the extent layout of the
file, be it truncate, fallocate, etc: the attempt to break the
layout lease by a non-owner should fail if the lease is "exclusive"
to the owner.

> The complication being that by default the filesystem has an exclusive
> lock on the mapping, and what we're trying to add is the ability for
> readers to ask the filesystem to give up its exclusive lock.

The filesystem doesn't even lock the "mapping" until after the
layout lease has been validated or broken.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
