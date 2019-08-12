Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109D68A549
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfHLSF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:05:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:56621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfHLSF4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:05:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="177558391"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2019 11:05:51 -0700
Date:   Mon, 12 Aug 2019 11:05:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 07/19] fs/xfs: Teach xfs to use new
 dax_layout_busy_page()
Message-ID: <20190812180551.GC19746@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-8-ira.weiny@intel.com>
 <20190809233037.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809233037.GB7777@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 10, 2019 at 09:30:37AM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 03:58:21PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > dax_layout_busy_page() can now operate on a sub-range of the
> > address_space provided.
> > 
> > Have xfs specify the sub range to dax_layout_busy_page()
> 
> Hmmm. I've got patches that change all these XFS interfaces to
> support range locks. I'm not sure the way the ranges are passed here
> is the best way to do it, and I suspect they aren't correct in some
> cases, either....
> 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index ff3c1fae5357..f0de5486f6c1 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1042,10 +1042,16 @@ xfs_vn_setattr(
> >  		xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> >  		iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> >  
> > -		error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
> > -		if (error) {
> > -			xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > -			return error;
> > +		if (iattr->ia_size < inode->i_size) {
> > +			loff_t                  off = iattr->ia_size;
> > +			loff_t                  len = inode->i_size - iattr->ia_size;
> > +
> > +			error = xfs_break_layouts(inode, &iolock, off, len,
> > +						  BREAK_UNMAP);
> > +			if (error) {
> > +				xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > +				return error;
> > +			}
> 
> This isn't right - truncate up still needs to break the layout on
> the last filesystem block of the file,

I'm not following this?  From a user perspective they can't have done anything
with the data beyond the EOF.  So isn't it safe to allow EOF to grow without
changing the layout of that last block?

> and truncate down needs to
> extend to "maximum file offset" because we remove all extents beyond
> EOF on a truncate down.

Ok, I was trying to allow a user to extend the file without conflicts if they
were to have a pin on the 'beginning' of the original file.  This sounds like
you are saying that a layout lease must be dropped to do that?  In some ways I
think I understand what you are driving at and I think I see how I may have
been playing "fast and loose" with the strictness of the layout lease.  But
from a user perspective if there is a part of the file which "does not exist"
(beyond EOF) does it matter that the layout there may change?

> 
> i.e. when we use preallocation, the extent map extends beyond EOF,
> and layout leases need to be able to extend beyond the current EOF
> to allow the lease owner to do extending writes, extending truncate,
> preallocation beyond EOF, etc safely without having to get a new
> lease to cover the new region in the extended file...

I'm not following this.  What determines when preallocation is done?

Forgive my ignorance on file systems but how can we have a layout for every
file which is "maximum file offset" for every file even if a file is only 1
page long?

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
