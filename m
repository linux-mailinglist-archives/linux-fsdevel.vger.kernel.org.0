Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C58A561
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHLSIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:08:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:56925 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHLSIn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:08:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="175965853"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 11:08:42 -0700
Date:   Mon, 12 Aug 2019 11:08:42 -0700
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
Subject: Re: [RFC PATCH v2 08/19] fs/xfs: Fail truncate if page lease can't
 be broken
Message-ID: <20190812180841.GD19746@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-9-ira.weiny@intel.com>
 <20190809232209.GA7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809232209.GA7777@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 10, 2019 at 09:22:09AM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 03:58:22PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > If pages are under a lease fail the truncate operation.  We change the order of
> > lease breaks to directly fail the operation if the lease exists.
> > 
> > Select EXPORT_BLOCK_OPS for FS_DAX to ensure that xfs_break_lease_layouts() is
> > defined for FS_DAX as well as pNFS.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/Kconfig        | 1 +
> >  fs/xfs/xfs_file.c | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 14cd4abdc143..c10b91f92528 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -48,6 +48,7 @@ config FS_DAX
> >  	select DEV_PAGEMAP_OPS if (ZONE_DEVICE && !FS_DAX_LIMITED)
> >  	select FS_IOMAP
> >  	select DAX
> > +	select EXPORTFS_BLOCK_OPS
> >  	help
> >  	  Direct Access (DAX) can be used on memory-backed block devices.
> >  	  If the block device supports DAX and the filesystem supports DAX,
> 
> That looks wrong.

It may be...

>
> If you require xfs_break_lease_layouts() outside
> of pnfs context, then move the function in the XFS code base to a
> file that is built in. It's only external dependency is on the
> break_layout() function, and XFS already has other unconditional
> direct calls to break_layout()...

I'll check.  This patch was part of the original series and I must admit I
don't remember why I did it this way...

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
