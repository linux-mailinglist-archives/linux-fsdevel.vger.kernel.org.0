Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC929203B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHSJZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 05:25:26 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38302 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfHSJZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:25:26 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C3A4743DB5F;
        Mon, 19 Aug 2019 19:25:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hzdtZ-0003uw-KP; Mon, 19 Aug 2019 19:24:09 +1000
Date:   Mon, 19 Aug 2019 19:24:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190819092409.GM7777@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819063412.GA20455@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=uRkhnK3tQF7xzalHlfoA:9 a=qxnrrwIs3tiBhskk:21
        a=zvn5vesPaJoFCDyj:21 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
> On Sat 17-08-19 12:26:03, Dave Chinner wrote:
> > On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> > > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > > 2) Second reason is that I thought I did not have a good way to tell if the
> > >    lease was actually in use.  What I mean is that letting the lease go should
> > >    be ok IFF we don't have any pins...  I was thinking that without John's code
> > >    we don't have a way to know if there are any pins...  But that is wrong...
> > >    All we have to do is check
> > > 
> > > 	!list_empty(file->file_pins)
> > > 
> > > So now with this detail I think you are right, we should be able to hold the
> > > lease through the struct file even if the process no longer has any
> > > "references" to it (ie closes and munmaps the file).
> > 
> > I really, really dislike the idea of zombie layout leases. It's a
> > nasty hack for poor application behaviour. This is a "we allow use
> > after layout lease release" API, and I think encoding largely
> > untraceable zombie objects into an API is very poor design.
> > 
> > From the fcntl man page:
> > 
> > LEASES
> > 	Leases are associated with an open file description (see
> > 	open(2)).  This means that duplicate file descriptors
> > 	(created by, for example, fork(2) or dup(2))  re‐ fer  to
> > 	the  same  lease,  and this lease may be modified or
> > 	released using any of these descriptors.  Furthermore, the
> > 	lease is released by either an explicit F_UNLCK operation on
> > 	any of these duplicate file descriptors, or when all such
> > 	file descriptors have been closed.
> > 
> > Leases are associated with *open* file descriptors, not the
> > lifetime of the struct file in the kernel. If the application closes
> > the open fds that refer to the lease, then the kernel does not
> > guarantee, and the application has no right to expect, that the
> > lease remains active in any way once the application closes all
> > direct references to the lease.
> > 
> > IOWs, applications using layout leases need to hold the lease fd
> > open for as long as the want access to the physical file layout. It
> > is a also a requirement of the layout lease that the holder releases
> > the resources it holds on the layout before it releases the layout
> > lease, exclusive lease or not. Closing the fd indicates they do not
> > need access to the file any more, and so the lease should be
> > reclaimed at that point.
> > 
> > I'm of a mind to make the last close() on a file block if there's an
> > active layout lease to prevent processes from zombie-ing layout
> > leases like this. i.e. you can't close the fd until resources that
> > pin the lease have been released.
> 
> Yeah, so this was my initial though as well [1]. But as the discussion in
> that thread revealed, the problem with blocking last close is that kernel
> does not really expect close to block. You could easily deadlock e.g. if
> the process gets SIGKILL, file with lease has fd 10, and the RDMA context
> holding pages pinned has fd 15.

Sure, I did think about this a bit about it before suggesting it :)

The last close is an interesting case because the __fput() call
actually runs from task_work() context, not where the last reference
is actually dropped. So it already has certain specific interactions
with signals and task exit processing via task_add_work() and
task_work_run().

task_add_work() calls set_notify_resume(task), so if nothing else
triggers when returning to userspace we run this path:

exit_to_usermode_loop()
  tracehook_notify_resume()
    task_work_run()
      __fput()
	locks_remove_file()
	  locks_remove_lease()
	    ....

It's worth noting that locks_remove_lease() does a
percpu_down_read() which means we can already block in this context
removing leases....

If there is a signal pending, the task work is run this way (before
the above notify path):

exit_to_usermode_loop()
  do_signal()
    get_signal()
      task_work_run()
        __fput()

We can detect this case via signal_pending() and even SIGKILL via
fatal_signal_pending(), and so we can decide not to block based on
the fact the process is about to be reaped and so the lease largely
doesn't matter anymore. I'd argue that it is close and we can't
easily back out, so we'd only break the block on a fatal signal....

And then, of course, is the call path through do_exit(), which has
the PF_EXITING task flag set:

do_exit()
  exit_task_work()
    task_work_run()
      __fput()

and so it's easy to avoid blocking in this case, too.

So that leaves just the normal close() syscall exit case, where the
application has full control of the order in which resources are
released. We've already established that we can block in this
context.  Blocking in an interruptible state will allow fatal signal
delivery to wake us, and then we fall into the
fatal_signal_pending() case if we get a SIGKILL while blocking.

Hence I think blocking in this case would be OK - it indicates an
application bug (releasing a lease before releasing the resources)
but leaves SIGKILL available to administrators to resolve situations
involving buggy applications.

This requires applications to follow the rules: any process
that pins physical resources must have an active reference to a
layout lease, either via a duplicated fd or it's own private lease.
If the app doesn't play by the rules, it hangs in close() until it
is killed.

> Or you could wait for another process to
> release page pins and blocking SIGKILL on that is also bad.

Again, each individual process that pins pages from the layout must
have it's own active layout lease reference.

> So in the end
> the least bad solution we've come up with were these "zombie" leases as you
> call them and tracking them in /proc so that userspace at least has a way
> of seeing them. But if you can come up with a different solution, I'm
> certainly not attached to the current one...

It might be the "least bad" solution, but it's still a pretty bad
one. And one that I don't think is necessary if we simply enforce
the "process must have active references for the entire time the
process uses the resource" rule. That's the way file access has
always worked, I don't see why we should be doing anything different
for access to the physical layout of files...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
