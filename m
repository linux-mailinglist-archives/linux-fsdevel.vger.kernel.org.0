Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A89B96C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfHXAMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 20:12:40 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45548 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfHXAMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:12:40 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EF9B9361F93;
        Sat, 24 Aug 2019 10:12:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i1JeO-0007di-F2; Sat, 24 Aug 2019 10:11:24 +1000
Date:   Sat, 24 Aug 2019 10:11:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190824001124.GI1119@dread.disaster.area>
References: <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823120428.GA12968@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=G1NtteZr6bW4K8DtrmYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:
> 
> > > But the fact that RDMA, and potentially others, can "pass the
> > > pins" to other processes is something I spent a lot of time trying to work out.
> > 
> > There's nothing in file layout lease architecture that says you
> > can't "pass the pins" to another process.  All the file layout lease
> > requirements say is that if you are going to pass a resource for
> > which the layout lease guarantees access for to another process,
> > then the destination process already have a valid, active layout
> > lease that covers the range of the pins being passed to it via the
> > RDMA handle.
> 
> How would the kernel detect and enforce this? There are many ways to
> pass a FD.

AFAIC, that's not really a kernel problem. It's more of an
application design constraint than anything else. i.e. if the app
passes the IB context to another process without a lease, then the
original process is still responsible for recalling the lease and
has to tell that other process to release the IB handle and it's
resources.

> IMHO it is wrong to try and create a model where the file lease exists
> independently from the kernel object relying on it. In other words the
> IB MR object itself should hold a reference to the lease it relies
> upon to function properly.

That still doesn't work. Leases are not individually trackable or
reference counted objects objects - they are attached to a struct
file bUt, in reality, they are far more restricted than a struct
file.

That is, a lease specifically tracks the pid and the _open fd_ it
was obtained for, so it is essentially owned by a specific process
context. Hence a lease is not able to be passed to a separate
process context and have it still work correctly for lease break
notifications.  i.e. the layout break signal gets delivered to
original process that created the struct file, if it still exists
and has the original fd still open. It does not get sent to the
process that currently holds a reference to the IB context.

So while a struct file passed to another process might still have
an active lease, and you can change the owner of the struct file
via fcntl(F_SETOWN), you can't associate the existing lease with a
the new fd in the new process and so layout break signals can't be
directed at the lease fd....

This really means that a lease can only be owned by a single process
context - it can't be shared across multiple processes (so I was
wrong about dup/pass as being a possible way of passing them)
because there's only one process that can "own" a struct file, and
that where signals are sent when the lease needs to be broken.

So, fundamentally, if you want to pass a resource that pins a file
layout between processes, both processes need to hold a layout lease
on that file range. And that means exclusive leases and passing
layouts between processes are fundamentally incompatible because you
can't hold two exclusive leases on the same file range....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
