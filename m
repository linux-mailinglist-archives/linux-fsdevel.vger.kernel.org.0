Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89C9C8D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 07:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfHZFzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 01:55:21 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36676 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfHZFzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:55:21 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1199A43F692;
        Mon, 26 Aug 2019 15:55:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i27yA-0002Rg-EJ; Mon, 26 Aug 2019 15:55:10 +1000
Date:   Mon, 26 Aug 2019 15:55:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20190826055510.GL1119@dread.disaster.area>
References: <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
 <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=l-5HZ6ThFU8XlB48y_YA:9 a=qRlaua0cGjGJrKa9:21
        a=OEwtXWmnxFRK9C0v:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:08:36PM -0700, Ira Weiny wrote:
> On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
> > On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:
> > > 
> > > > > But the fact that RDMA, and potentially others, can "pass the
> > > > > pins" to other processes is something I spent a lot of time trying to work out.
> > > > 
> > > > There's nothing in file layout lease architecture that says you
> > > > can't "pass the pins" to another process.  All the file layout lease
> > > > requirements say is that if you are going to pass a resource for
> > > > which the layout lease guarantees access for to another process,
> > > > then the destination process already have a valid, active layout
> > > > lease that covers the range of the pins being passed to it via the
> > > > RDMA handle.
> > > 
> > > How would the kernel detect and enforce this? There are many ways to
> > > pass a FD.
> > 
> > AFAIC, that's not really a kernel problem. It's more of an
> > application design constraint than anything else. i.e. if the app
> > passes the IB context to another process without a lease, then the
> > original process is still responsible for recalling the lease and
> > has to tell that other process to release the IB handle and it's
> > resources.
> > 
> > > IMHO it is wrong to try and create a model where the file lease exists
> > > independently from the kernel object relying on it. In other words the
> > > IB MR object itself should hold a reference to the lease it relies
> > > upon to function properly.
> > 
> > That still doesn't work. Leases are not individually trackable or
> > reference counted objects objects - they are attached to a struct
> > file bUt, in reality, they are far more restricted than a struct
> > file.
> > 
> > That is, a lease specifically tracks the pid and the _open fd_ it
> > was obtained for, so it is essentially owned by a specific process
> > context.  Hence a lease is not able to be passed to a separate
> > process context and have it still work correctly for lease break
> > notifications.  i.e. the layout break signal gets delivered to
> > original process that created the struct file, if it still exists
> > and has the original fd still open. It does not get sent to the
> > process that currently holds a reference to the IB context.
> >
> 
> The fcntl man page says:
> 
> "Leases are associated with an open file description (see open(2)).  This means
> that duplicate file descriptors (created by, for example, fork(2) or dup(2))
> refer to the same lease, and this lease may be modified or released using any
> of these descriptors.  Furthermore,  the lease is released by either an
> explicit F_UNLCK operation on any of these duplicate file descriptors, or when
> all such file descriptors have been closed."

Right, the lease is attached to the struct file, so it follows
where-ever the struct file goes. That doesn't mean it's actually
useful when the struct file is duplicated and/or passed to another
process. :/

AFAICT, the problem is that when we take another reference to the
struct file, or when the struct file is passed to a different
process, nothing updates the lease or lease state attached to that
struct file.

> From this I took it that the child process FD would have the lease as well
> _and_ could release it.  I _assumed_ that applied to SCM_RIGHTS but it does not
> seem to work the same way as dup() so I'm not so sure.

Sure, that part works because the struct file is passed. It doesn't
end up with the same fd number in the other process, though.

The issue is that layout leases need to notify userspace when they
are broken by the kernel, so a lease stores the owner pid/tid in the
file->f_owner field via __f_setown(). It also keeps a struct fasync
attached to the file_lock that records the fd that the lease was
created on.  When a signal needs to be sent to userspace for that
lease, we call kill_fasync() and that walks the list of fasync
structures on the lease and calls:

	send_sigio(fown, fa->fa_fd, band);

And it does for every fasync struct attached to a lease. Yes, a
lease can track multiple fds, but it can only track them in a single
process context. The moment the struct file is shared with another
process, the lease is no longer capable of sending notifications to
all the lease holders.

Yes, you can change the owning process via F_SETOWNER, but that's
still only a single process context, and you can't change the fd in
the fasync list. You can add new fd to an existing lease by calling
F_SETLEASE on the new fd, but you still only have a single process
owner context for signal delivery.

As such, leases that require callbacks to userspace are currently
only valid within the process context the lease was taken in.
Indeed, even closing the fd the lease was taken on without
F_UNLCKing it first doesn't mean the lease has been torn down if
there is some other reference to the struct file. That means the
original lease owner will still get SIGIO delivered to that fd on a
lease break regardless of whether it is open or not. ANd if we
implement "layout lease not released within SIGIO response timeout"
then that process will get killed, despite the fact it may not even
have a reference to that file anymore.

So, AFAICT, leases that require userspace callbacks only work within
their original process context while they original fd is still open.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
