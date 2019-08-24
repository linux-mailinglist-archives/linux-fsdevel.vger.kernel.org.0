Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997E89B97F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 02:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfHXATy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 20:19:54 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47613 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfHXATy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:19:54 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A5FD843E73B;
        Sat, 24 Aug 2019 10:19:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i1JlP-0007eP-Cg; Sat, 24 Aug 2019 10:18:39 +1000
Date:   Sat, 24 Aug 2019 10:18:39 +1000
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
Message-ID: <20190824001839.GJ1119@dread.disaster.area>
References: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190823005914.GF1119@dread.disaster.area>
 <20190823171504.GA1092@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823171504.GA1092@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=QZy_m0AoVJ59bLp0kawA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:15:04AM -0700, Ira Weiny wrote:
> On Fri, Aug 23, 2019 at 10:59:14AM +1000, Dave Chinner wrote:
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
> > > 
> > > Process A has the RDMA context FD and data file FD (with lease) open.
> > > 
> > > Process A uses SCM_RIGHTS to pass the RDMA context FD to Process B.
> > 
> > Passing the RDMA context dependent on a file layout lease to another
> > process that doesn't have a file layout lease or a reference to the
> > original lease should be considered a violation of the layout lease.
> > Process B does not have an active layout lease, and so by the rules
> > of layout leases, it is not allowed to pin the layout of the file.
> > 
> 
> I don't disagree with the semantics of this.  I just don't know how to enforce
> it.
> 
> > > Process A attempts to exit (hangs because data file FD is pinned).
> > > 
> > > Admin kills process A.  kill works because we have allowed for it...
> > > 
> > > Process B _still_ has the RDMA context FD open _and_ therefore still holds the
> > > file pins.
> > > 
> > > Truncation still fails.
> > > 
> > > Admin does not know which process is holding the pin.
> > > 
> > > What am I missing?
> > 
> > Application does not hold the correct file layout lease references.
> > Passing the fd via SCM_RIGHTS to a process without a layout lease
> > is equivalent to not using layout leases in the first place.
> 
> Ok, So If I understand you correctly you would support a failure of SCM_RIGHTS
> in this case?  I'm ok with that but not sure how to implement it right now.
> 
> To that end, I would like to simplify this slightly because I'm not convinced
> that SCM_RIGHTS is a problem we need to solve right now.  ie I don't know of a
> user who wants to do this.

I don't think we can support it, let alone want to. SCM_RIGHTS was a
mistake made years ago that has been causing bugs and complexity to
try and avoid those bugs ever since.  I'm only taking about it
because someone else raised it and I asummed they raised it because
they want it to "work".

> Right now duplication via SCM_RIGHTS could fail if _any_ file pins (and by
> definition leases) exist underneath the "RDMA FD" (or other direct access FD,
> like XDP etc) being duplicated.

Sounds like a fine idea to me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
