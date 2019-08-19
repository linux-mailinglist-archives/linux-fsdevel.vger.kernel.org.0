Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8576B95033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfHSVx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 17:53:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:6061 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfHSVx0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:53:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="189658795"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2019 14:53:23 -0700
Date:   Mon, 19 Aug 2019 14:53:23 -0700
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
Message-ID: <20190819215322.GA2839@iweiny-DESK2.sc.intel.com>
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
User-Agent: Mutt/1.11.1 (2018-12-01)
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
>              ib_uverbs_close()
>               uverbs_destroy_ufile_hw()
>                mutex_lock()   <-- Deadlock
> 
> But, as I said to Ira earlier, I wonder if this is now impossible on
> modern kernels and we can switch to making the whole thing
> synchronous. That would resolve RDMA's main problem with this.

I'm still looking into this...  but my bigger concern is that the RDMA FD can
be passed to other processes via SCM_RIGHTS.  Which means the process holding
the pin may _not_ be the one with the open file and layout lease...

Ira

