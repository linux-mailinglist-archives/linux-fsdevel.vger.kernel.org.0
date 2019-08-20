Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3ED95303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 03:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfHTBNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 21:13:25 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55616 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbfHTBNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:13:25 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 26BC943CF13;
        Tue, 20 Aug 2019 11:13:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hzsh0-0001Xw-UC; Tue, 20 Aug 2019 11:12:10 +1000
Date:   Tue, 20 Aug 2019 11:12:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
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
Message-ID: <20190820011210.GP7777@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819123841.GC5058@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=3RYR1JOu_4gKP4_ft30A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> 
> > So that leaves just the normal close() syscall exit case, where the
> > application has full control of the order in which resources are
> > released. We've already established that we can block in this
> > context.  Blocking in an interruptible state will allow fatal signal
> > delivery to wake us, and then we fall into the
> > fatal_signal_pending() case if we get a SIGKILL while blocking.
> 
> The major problem with RDMA is that it doesn't always wait on close() for the
> MR holding the page pins to be destoyed. This is done to avoid a
> deadlock of the form:
> 
>    uverbs_destroy_ufile_hw()
>       mutex_lock()
>        [..]
>         mmput()
>          exit_mmap()
>           remove_vma()
>            fput();
>             file_operations->release()

I think this is wrong, and I'm pretty sure it's an example of why
the final __fput() call is moved out of line.

		fput()
		  fput_many()
		    task_add_work(f, __fput())

and the call chain ends there.

Before the syscall returns to userspace, it then runs the __fput()
call through the task_work_run() interfaces, and hence the call
chain is just:

	task_work_run
	  __fput
>             file_operations->release()
>              ib_uverbs_close()
>               uverbs_destroy_ufile_hw()
>                mutex_lock()   <-- Deadlock

And there is no deadlock because nothing holds the mutex at this
point.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
