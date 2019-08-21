Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC0985DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfHUUoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 16:44:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:7963 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfHUUoW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:44:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196076495"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:44:21 -0700
Date:   Wed, 21 Aug 2019 13:44:21 -0700
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
Message-ID: <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
References: <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821194810.GI8653@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:48:10PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:
> 
> > > Oh, I didn't think we were talking about that. Hanging the close of
> > > the datafile fd contingent on some other FD's closure is a recipe for
> > > deadlock..
> > 
> > The discussion between Jan and Dave was concerning what happens when a user
> > calls
> > 
> > fd = open()
> > fnctl(...getlease...)
> > addr = mmap(fd...)
> > ib_reg_mr() <pin>
> > munmap(addr...)
> > close(fd)
> 
> I don't see how blocking close(fd) could work.

Well Dave was saying this _could_ work.  FWIW I'm not 100% sure it will but I
can't prove it won't..  Maybe we are all just touching a different part of this
elephant[1] but the above scenario or one without munmap is very reasonably
something a user would do.  So we can either allow the close to complete (my
current patches) or try to make it block like Dave is suggesting.

I don't disagree with Dave with the semantics being nice and clean for the
filesystem.  But the fact that RDMA, and potentially others, can "pass the
pins" to other processes is something I spent a lot of time trying to work out.

>
> Write it like this:
> 
>  fd = open()
>  uverbs = open(/dev/uverbs)
>  fnctl(...getlease...)
>  addr = mmap(fd...)
>  ib_reg_mr() <pin>
>  munmap(addr...)
>   <sigkill>
> 
> The order FD's are closed during sigkill is not deterministic, so when
> all the fputs happen during a kill'd exit we could end up blocking in
> close(fd) as close(uverbs) will come after in the close
> list. close(uverbs) is the thing that does the dereg_mr and releases
> the pin.

Of course, that is a different scenario which needs to be fixed in my patch
set.  Now that my servers are back up I can hopefully make progress.  (Power
was down for them yesterday).

> 
> We don't need complexity with dup to create problems.

No but that complexity _will_ come unless we "zombie" layout leases.

Ira

[1] https://en.wikipedia.org/wiki/Blind_men_and_an_elephant

> 
> Jason
> 
