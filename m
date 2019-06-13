Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71B944619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfFMQtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:49:06 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41045 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727662AbfFMEhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:37:55 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BEAB014A744;
        Thu, 13 Jun 2019 14:37:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hbHTl-0005bp-W0; Thu, 13 Jun 2019 14:36:49 +1000
Date:   Thu, 13 Jun 2019 14:36:49 +1000
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
Message-ID: <20190613043649.GJ14363@dread.disaster.area>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613032320.GG32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613032320.GG32656@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=VVmKscACqtQWyMykWwEA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:23:20PM -0700, Matthew Wilcox wrote:
> On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > That's rather different from the normal meaning of 'exclusive' in the
> > > context of locks, which is "only one user can have access to this at
> > > a time".
> > 
> > Layout leases are not locks, they are a user access policy object.
> > It is the process/fd which holds the lease and it's the process/fd
> > that is granted exclusive access.  This is exactly the same semantic
> > as O_EXCL provides for granting exclusive access to a block device
> > via open(), yes?
> 
> This isn't my understanding of how RDMA wants this to work, so we should
> probably clear that up before we get too far down deciding what name to
> give it.
> 
> For the RDMA usage case, it is entirely possible that both process A
> and process B which don't know about each other want to perform RDMA to
> file F.  So there will be two layout leases active on this file at the
> same time.  It's fine for IOs to simultaneously be active to both leases.

Yes, it is.

> But if the filesystem wants to move blocks around, it has to break
> both leases.

No, the _lease layer_ needs to break both leases when the filesystem
calls break_layout().

The filesystem is /completely unaware/ of whether a lease is held,
how many leases are held, what is involved in revoking leases or
whether they are exclusive or not. The filesystem only knows that it
is about to perform an operation that may require a layout lease to
be broken, so it's _asking permission_ from the layout lease layer
whether it is OK to go ahead with the operation.

See what I mean about the layout lease being an /access arbitration/
layer? It's the layer that decides whether a modification can be
made or not, not the filesystem. The layout lease layer tells the
filesystem what it should do, the filesystem just has to ensure it
adds layout breaking callouts in places that can block safely and
are serialised to ensure operations from new layouts can't race with
the operation that broke the existing layouts.

> If Process C tries to do a write to file F without a lease, there's no
> problem, unless a side-effect of the write would be to change the block
> mapping,

That's a side effect we cannot predict ahead of time. But it's
also _completely irrelevant_ to the layout lease layer API and
implementation.(*)

> in which case either the leases must break first, or the write
> must be denied.

Which is exactly how I'm saying layout leases already interact with
the filesystem: that if the lease cannot be broken, break_layout()
returns -ETXTBSY to the filesystem, and the filesystem returns that
to the application having made no changes at all. Layout leases are
the policy engine, the filesystem just has to implement the
break_layout() callouts such that layout breaking is consistent,
correct, and robust....

Cheers,

Dave.

(*) In the case of XFS, we don't know if a layout change will be
necessary until we are deep inside the actual IO path and hold inode
metadata locks. We can't block here to break the layout because IO
completion and metadata commits need to occur to allow the
application to release it's lease and IO completion requires that
same inode metadata lock. i.e. if we block once we know a layout
change needs to occur, we will deadlock the filesystem on the inode
metadata lock.

Hence the filesystem implementation dictates when the filesystem
issues layout lease break notifications. However, these filesystem
implementation issues do not dictate how applications interact with
layout leases, how layout leases are managed, whether concurrent
leases are allowed, whether leases can be broken, etc.  That's all
managed by the layout lease layer and that's where the go/no go
decision is made and communicated to the filesystem as the return
value from the break_layout() call.

-- 
Dave Chinner
david@fromorbit.com
