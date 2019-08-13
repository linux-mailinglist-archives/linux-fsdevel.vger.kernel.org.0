Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE18C235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfHMUjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 16:39:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:6361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfHMUjA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:39:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 13:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="376423872"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2019 13:38:59 -0700
Date:   Tue, 13 Aug 2019 13:38:59 -0700
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
Message-ID: <20190813203858.GA12695@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-17-ira.weiny@intel.com>
 <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
 <20190812175615.GI24457@ziepe.ca>
 <20190812211537.GE20634@iweiny-DESK2.sc.intel.com>
 <20190813114842.GB29508@ziepe.ca>
 <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
 <20190813180022.GF29508@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813180022.GF29508@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 03:00:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 13, 2019 at 10:41:42AM -0700, Ira Weiny wrote:
> 
> > And I was pretty sure uverbs_destroy_ufile_hw() would take care of (or ensure
> > that some other thread is) destroying all the MR's we have associated with this
> > FD.
> 
> fd's can't be revoked, so destroy_ufile_hw() can't touch them. It
> deletes any underlying HW resources, but the FD persists.

I misspoke.  I should have said associated with this "context".  And of course
uverbs_destroy_ufile_hw() does not touch the FD.  What I mean is that the
struct file which had file_pins hanging off of it would be getting its file
pins destroyed by uverbs_destroy_ufile_hw().  Therefore we don't need the FD
after uverbs_destroy_ufile_hw() is done.

But since it does not block it may be that the struct file is gone before the
MR is actually destroyed.  Which means I think the GUP code would blow up in
that case...  :-(

I was thinking it was the other way around.  And in fact most of the time I
think it is.  But we can't depend on that...

>  
> > > This is why having a back pointer like this is so ugly, it creates a
> > > reference counting cycle
> > 
> > Yep...  I worked through this...  and it was giving me fits...
> > 
> > Anyway, the struct file is the only object in the core which was reasonable to
> > store this information in since that is what is passed around to other
> > processes...
> 
> It could be passed down in the uattr_bundle, once you are in file operations

What is "It"?  The struct file?  Or the file pin information?

> handle the file is guarenteed to exist, and we've now arranged things

I don't understand what you mean by "... once you are in file operations handle... "?

> so the uattr_bundle flows into the umem, as umems can only be
> established under a system call.

"uattr_bundle" == uverbs_attr_bundle right?

The problem is that I don't think the core should be handling
uverbs_attr_bundles directly.  So, I think you are driving at the same idea I
had WRT callbacks into the driver.

The drivers could provide some generic object (in RDMA this could be the
uverbs_attr_bundle) which represents their "context".

The GUP code calls back into the driver with file pin information as it
encounters and pins pages.  The driver, RDMA in this case, associates this
information with the "context".

But for the procfs interface, that context then needs to be associated with any
file which points to it...  For RDMA, or any other "FD based pin mechanism", it
would be up to the driver to "install" a procfs handler into any struct file
which _may_ point to this context.  (before _or_ after memory pins).

Then the procfs code can walk the FD array and if this handler is installed it
knows there is file pin information associated with that struct file and it can
be printed...

This is not impossible.  But I think is a lot harder for drivers to make
right...

Ira

