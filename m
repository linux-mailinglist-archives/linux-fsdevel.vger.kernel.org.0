Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458DF983F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfHUTG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 15:06:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:45487 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfHUTG1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:06:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="183631522"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2019 12:06:25 -0700
Date:   Wed, 21 Aug 2019 12:06:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190821190624.GC5965@iweiny-DESK2.sc.intel.com>
References: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:57:03AM -0700, 'Ira Weiny' wrote:
> On Wed, Aug 21, 2019 at 03:13:43PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 21, 2019 at 11:02:00AM -0700, Ira Weiny wrote:
> > > On Tue, Aug 20, 2019 at 08:55:15AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
> > > > > On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> > > > > > On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> > > > > > 
> > > > > > > So that leaves just the normal close() syscall exit case, where the
> > > > > > > application has full control of the order in which resources are
> > > > > > > released. We've already established that we can block in this
> > > > > > > context.  Blocking in an interruptible state will allow fatal signal
> > > > > > > delivery to wake us, and then we fall into the
> > > > > > > fatal_signal_pending() case if we get a SIGKILL while blocking.
> > > > > > 
> > > > > > The major problem with RDMA is that it doesn't always wait on close() for the
> > > > > > MR holding the page pins to be destoyed. This is done to avoid a
> > > > > > deadlock of the form:
> > > > > > 
> > > > > >    uverbs_destroy_ufile_hw()
> > > > > >       mutex_lock()
> > > > > >        [..]
> > > > > >         mmput()
> > > > > >          exit_mmap()
> > > > > >           remove_vma()
> > > > > >            fput();
> > > > > >             file_operations->release()
> > > > > 
> > > > > I think this is wrong, and I'm pretty sure it's an example of why
> > > > > the final __fput() call is moved out of line.
> > > > 
> > > > Yes, I think so too, all I can say is this *used* to happen, as we
> > > > have special code avoiding it, which is the code that is messing up
> > > > Ira's lifetime model.
> > > > 
> > > > Ira, you could try unraveling the special locking, that solves your
> > > > lifetime issues?
> > > 
> > > Yes I will try to prove this out...  But I'm still not sure this fully solves
> > > the problem.
> > > 
> > > This only ensures that the process which has the RDMA context (RDMA FD) is safe
> > > with regard to hanging the close for the "data file FD" (the file which has
> > > pinned pages) in that _same_ process.  But what about the scenario.
> > 
> > Oh, I didn't think we were talking about that. Hanging the close of
> > the datafile fd contingent on some other FD's closure is a recipe for
> > deadlock..
> 
> The discussion between Jan and Dave was concerning what happens when a user
> calls
> 
> fd = open()
> fnctl(...getlease...)
> addr = mmap(fd...)
> ib_reg_mr() <pin>
> munmap(addr...)
> close(fd)
> 
> Dave suggested:
> 
> "I'm of a mind to make the last close() on a file block if there's an
> active layout lease to prevent processes from zombie-ing layout
> leases like this. i.e. you can't close the fd until resources that
> pin the lease have been released."
> 
> 	-- Dave https://lkml.org/lkml/2019/8/16/994

I think this may all be easier if there was a way to block a dup() if it comes
from an SCM_RIGHTS.  Does anyone know if that is easy?  I assume it would just
mean passing some flag through the dup() call chain.

Jason, if we did that would it break RDMA use cases?  I personally don't know
of any.  We could pass data back from vaddr_pin indicating that a file pin has
been taken and predicate the blocking of SCM_RIGHTS on that? 

Of course if the user called:

fd = open()
fnctl(...getlease...)
addr = mmap(fd...)
ib_reg_mr() <pin>
munmap(addr...)
close(fd)
fork() <=== in another thread because close is hanging

Would that dup() "fd" above into the child?  Or maybe that would be part of the
work to make close() hang?  Ensure the fd/file is still in the FD table so it
gets dupped???

Ira


> 
> > 
> > IMHO the pin refcnt is held by the driver char dev FD, that is the
> > object you need to make it visible against.
> 
> I'm sorry but what do you mean by "driver char dev FD"?
> 
> > 
> > Why not just have a single table someplace of all the layout leases
> > with the file they are held on and the FD/socket/etc that is holding
> > the pin? Make it independent of processes and FDs?
> 
> If it is independent of processes how will we know which process is blocking
> the truncate?  Using a global table is an interesting idea but I still believe
> the users are going to want to track this to specific processes.  It's not
> clear to me how that would be done with a global table.
> 
> I agree the XDP/socket case is bothersome...  I was thinking that somewhere the
> fd of the socket could be hooked up in this case.  But taking a look at it
> reveals that is not going to be easy.  And I assume XDP has the same issue WRT
> SCM_RIGHTS and the ability to share the xdp context?
> 
> Ira
> 
> > 
> > Jason
