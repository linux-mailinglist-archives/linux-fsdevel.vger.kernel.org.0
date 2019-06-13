Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4002144D7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 22:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfFMUcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 16:32:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:5160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFMUco (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:32:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 13:32:43 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2019 13:32:43 -0700
Date:   Thu, 13 Jun 2019 13:34:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20190613203404.GA30404@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613002555.GH14363@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> > > On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > > > Are you suggesting that we have something like this from user space?
> > > > 
> > > > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> > > 
> > > Rather than "unbreakable", perhaps a clearer description of the
> > > policy it entails is "exclusive"?
> > > 
> > > i.e. what we are talking about here is an exclusive lease that
> > > prevents other processes from changing the layout. i.e. the
> > > mechanism used to guarantee a lease is exclusive is that the layout
> > > becomes "unbreakable" at the filesystem level, but the policy we are
> > > actually presenting to uses is "exclusive access"...
> > 
> > That's rather different from the normal meaning of 'exclusive' in the
> > context of locks, which is "only one user can have access to this at
> > a time".
> 
> 
> Layout leases are not locks, they are a user access policy object.
> It is the process/fd which holds the lease and it's the process/fd
> that is granted exclusive access.  This is exactly the same semantic
> as O_EXCL provides for granting exclusive access to a block device
> via open(), yes?
> 
> > As I understand it, this is rather more like a 'shared' or
> > 'read' lock.  The filesystem would be the one which wants an exclusive
> > lock, so it can modify the mapping of logical to physical blocks.
> 
> ISTM that you're conflating internal filesystem implementation with
> application visible semantics. Yes, the filesystem uses internal
> locks to serialise the modification of the things the lease manages
> access too, but that has nothing to do with the access policy the
> lease provides to users.
> 
> e.g. Process A has an exclusive layout lease on file F. It does an
> IO to file F. The filesystem IO path checks that Process A owns the
> lease on the file and so skips straight through layout breaking
> because it owns the lease and is allowed to modify the layout. It
> then takes the inode metadata locks to allocate new space and write
> new data.
> 
> Process B now tries to write to file F. The FS checks whether
> Process B owns a layout lease on file F. It doesn't, so then it
> tries to break the layout lease so the IO can proceed. The layout
> breaking code sees that process A has an exclusive layout lease
> granted, and so returns -ETXTBSY to process B - it is not allowed to
> break the lease and so the IO fails with -ETXTBSY.
> 
> i.e. the exclusive layout lease prevents other processes from
> performing operations that may need to modify the layout from
> performing those operations. It does not "lock" the file/inode in
> any way, it just changes how the layout lease breaking behaves.

Question: Do we expect Process A to get notified that Process B was attempting
to change the layout?

This changes the exclusivity semantics.  While Process A has an exclusive lease
it could release it if notified to allow process B temporary exclusivity.

Question 2: Do we expect other process' (say Process C) to also be able to map
and pin the file?  I believe users will need this and for layout purposes it is
ok to do so.  But this means that Process A does not have "exclusive" access to
the lease.

So given Process C has also placed a layout lease on the file.  Indicating
that it does not want the layout to change.  Both A and C need to be "broken"
by Process B to change the layout.  If there is no Process B; A and C can run
just fine with a "locked" layout.

Ira

> 
> Further, the "exclusiveness" of a layout lease is completely
> irrelevant to the filesystem that is indicating that an operation
> that may need to modify the layout is about to be performed. All the
> filesystem has to do is handle failures to break the lease
> appropriately.  Yes, XFS serialises the layout lease validation
> against other IO to the same file via it's IO locks, but that's an
> internal data IO coherency requirement, not anything to do with
> layout lease management.
> 
> Note that I talk about /writes/ here. This is interchangable with
> any other operation that may need to modify the extent layout of the
> file, be it truncate, fallocate, etc: the attempt to break the
> layout lease by a non-owner should fail if the lease is "exclusive"
> to the owner.
> 
> > The complication being that by default the filesystem has an exclusive
> > lock on the mapping, and what we're trying to add is the ability for
> > readers to ask the filesystem to give up its exclusive lock.
> 
> The filesystem doesn't even lock the "mapping" until after the
> layout lease has been validated or broken.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
