Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFD8BFC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHMRlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 13:41:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:57181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfHMRln (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:41:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 10:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="376374540"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2019 10:41:42 -0700
Date:   Tue, 13 Aug 2019 10:41:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 16/19] RDMA/uverbs: Add back pointer to system
 file object
Message-ID: <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-17-ira.weiny@intel.com>
 <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
 <20190812175615.GI24457@ziepe.ca>
 <20190812211537.GE20634@iweiny-DESK2.sc.intel.com>
 <20190813114842.GB29508@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813114842.GB29508@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:48:42AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2019 at 02:15:37PM -0700, Ira Weiny wrote:
> > On Mon, Aug 12, 2019 at 02:56:15PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 12, 2019 at 10:28:27AM -0700, Ira Weiny wrote:
> > > > On Mon, Aug 12, 2019 at 10:00:40AM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, Aug 09, 2019 at 03:58:30PM -0700, ira.weiny@intel.com wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > 
> > > > > > In order for MRs to be tracked against the open verbs context the ufile
> > > > > > needs to have a pointer to hand to the GUP code.
> > > > > > 
> > > > > > No references need to be taken as this should be valid for the lifetime
> > > > > > of the context.
> > > > > > 
> > > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > >  drivers/infiniband/core/uverbs.h      | 1 +
> > > > > >  drivers/infiniband/core/uverbs_main.c | 1 +
> > > > > >  2 files changed, 2 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> > > > > > index 1e5aeb39f774..e802ba8c67d6 100644
> > > > > > +++ b/drivers/infiniband/core/uverbs.h
> > > > > > @@ -163,6 +163,7 @@ struct ib_uverbs_file {
> > > > > >  	struct page *disassociate_page;
> > > > > >  
> > > > > >  	struct xarray		idr;
> > > > > > +	struct file             *sys_file; /* backpointer to system file object */
> > > > > >  };
> > > > > 
> > > > > The 'struct file' has a lifetime strictly shorter than the
> > > > > ib_uverbs_file, which is kref'd on its own lifetime. Having a back
> > > > > pointer like this is confouding as it will be invalid for some of the
> > > > > lifetime of the struct.
> > > > 
> > > > Ah...  ok.  I really thought it was the other way around.
> > > > 
> > > > __fput() should not call ib_uverbs_close() until the last reference on struct
> > > > file is released...  What holds references to struct ib_uverbs_file past that?
> > > 
> > > Child fds hold onto the internal ib_uverbs_file until they are closed
> > 
> > The FDs hold the struct file, don't they?
> 
> Only dups, there are other 'child' FDs we can create
> 
> > > Now this has unlocked updates to that data.. you'd need some lock and
> > > get not zero pattern
> > 
> > You can't call "get" here because I'm 99% sure we only get here when struct
> > file has no references left...
> 
> Nope, like I said the other FDs hold the uverbs_file independent of
> the struct file it is related too. 

<sigh>

We don't allow memory registrations to be created with those other FDs...

And I was pretty sure uverbs_destroy_ufile_hw() would take care of (or ensure
that some other thread is) destroying all the MR's we have associated with this
FD.

I'll have to think on this more since uverbs_destroy_ufile_hw() does not
block...  Which means there is a window here within the GUP code...  :-/

> 
> This is why having a back pointer like this is so ugly, it creates a
> reference counting cycle

Yep...  I worked through this...  and it was giving me fits...

Anyway, the struct file is the only object in the core which was reasonable to
store this information in since that is what is passed around to other
processes...

Another idea I explored was to create a callback into the driver from the core
which put the responsibility of printing the pin information on the driver.

But that started to be (and is likely going to be) a pretty complicated "dance"
between the core and the drivers so I went this way...

I also thought about holding some other reference on struct file which would
allow release to be called while keeping struct file around.  But that seemed
crazy...

Ira

