Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA99BBEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfHXFIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 01:08:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:26578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfHXFIi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 01:08:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 22:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,424,1559545200"; 
   d="scan'208";a="191147429"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2019 22:08:36 -0700
Date:   Fri, 23 Aug 2019 22:08:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
References: <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824001124.GI1119@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
> On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:
> > 
> > > > But the fact that RDMA, and potentially others, can "pass the
> > > > pins" to other processes is something I spent a lot of time trying to work out.
> > > 
> > > There's nothing in file layout lease architecture that says you
> > > can't "pass the pins" to another process.  All the file layout lease
> > > requirements say is that if you are going to pass a resource for
> > > which the layout lease guarantees access for to another process,
> > > then the destination process already have a valid, active layout
> > > lease that covers the range of the pins being passed to it via the
> > > RDMA handle.
> > 
> > How would the kernel detect and enforce this? There are many ways to
> > pass a FD.
> 
> AFAIC, that's not really a kernel problem. It's more of an
> application design constraint than anything else. i.e. if the app
> passes the IB context to another process without a lease, then the
> original process is still responsible for recalling the lease and
> has to tell that other process to release the IB handle and it's
> resources.
> 
> > IMHO it is wrong to try and create a model where the file lease exists
> > independently from the kernel object relying on it. In other words the
> > IB MR object itself should hold a reference to the lease it relies
> > upon to function properly.
> 
> That still doesn't work. Leases are not individually trackable or
> reference counted objects objects - they are attached to a struct
> file bUt, in reality, they are far more restricted than a struct
> file.
> 
> That is, a lease specifically tracks the pid and the _open fd_ it
> was obtained for, so it is essentially owned by a specific process
> context.  Hence a lease is not able to be passed to a separate
> process context and have it still work correctly for lease break
> notifications.  i.e. the layout break signal gets delivered to
> original process that created the struct file, if it still exists
> and has the original fd still open. It does not get sent to the
> process that currently holds a reference to the IB context.
>

The fcntl man page says:

"Leases are associated with an open file description (see open(2)).  This means
that duplicate file descriptors (created by, for example, fork(2) or dup(2))
refer to the same lease, and this lease may be modified or released using any
of these descriptors.  Furthermore,  the lease is released by either an
explicit F_UNLCK operation on any of these duplicate file descriptors, or when
all such file descriptors have been closed."

From this I took it that the child process FD would have the lease as well
_and_ could release it.  I _assumed_ that applied to SCM_RIGHTS but it does not
seem to work the same way as dup() so I'm not so sure.

Ira

> 
> So while a struct file passed to another process might still have
> an active lease, and you can change the owner of the struct file
> via fcntl(F_SETOWN), you can't associate the existing lease with a
> the new fd in the new process and so layout break signals can't be
> directed at the lease fd....
> 
> This really means that a lease can only be owned by a single process
> context - it can't be shared across multiple processes (so I was
> wrong about dup/pass as being a possible way of passing them)
> because there's only one process that can "own" a struct file, and
> that where signals are sent when the lease needs to be broken.
> 
> So, fundamentally, if you want to pass a resource that pins a file
> layout between processes, both processes need to hold a layout lease
> on that file range. And that means exclusive leases and passing
> layouts between processes are fundamentally incompatible because you
> can't hold two exclusive leases on the same file range....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
