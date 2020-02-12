Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D352015ACBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 17:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgBLQEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 11:04:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:18375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbgBLQEb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:04:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 08:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="251951787"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2020 08:04:29 -0800
Date:   Wed, 12 Feb 2020 08:04:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 05/12] fs: remove unneeded IS_DAX() check
Message-ID: <20200212160428.GD20214@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-6-ira.weiny@intel.com>
 <20200211053401.GE10776@dread.disaster.area>
 <20200211163831.GC12866@iweiny-DESK2.sc.intel.com>
 <20200211204107.GM10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211204107.GM10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:41:07AM +1100, Dave Chinner wrote:
> On Tue, Feb 11, 2020 at 08:38:31AM -0800, Ira Weiny wrote:
> > On Tue, Feb 11, 2020 at 04:34:01PM +1100, Dave Chinner wrote:
> > > On Sat, Feb 08, 2020 at 11:34:38AM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The IS_DAX() check in io_is_direct() causes a race between changing the
> > > > DAX state and creating the iocb flags.
> > > > 
> > > > Remove the check because DAX now emulates the page cache API and
> > > > therefore it does not matter if the file state is DAX or not when the
> > > > iocb flags are created.
> > > 
> > > This statement is ... weird.
> > > 
> > > DAX doesn't "emulate" the page cache API at all
> > 
> > ah...  yea emulate is a bad word here.
> > 
> > > - it has it's own
> > > read/write methods that filesystems call based on the iomap
> > > infrastructure (dax_iomap_rw()). i.e. there are 3 different IO paths
> > > through the filesystems: the DAX IO path, the direct IO path, and
> > > the buffered IO path.
> > > 
> > > Indeed, it seems like this works a bit by luck: Ext4 and XFS always
> > > check IS_DAX(inode) in the read/write_iter methods before checking
> > > for IOCB_DIRECT, and hence the IOCB_DIRECT flag is ignored by the
> > > filesystems. i.e. when we got rid of the O_DIRECT paths from DAX, we
> > > forgot to clean up io_is_direct() and it's only due to the ordering
> > > of checks that we went down the DAX path correctly....
> > > 
> > > That said, the code change is good, but the commit message needs a
> > > rewrite.
> > 
> > How about?
> > 
> > <commit msg>
> >   fs: Remove unneeded IS_DAX() check
> >   
> >   The IS_DAX() check in io_is_direct() causes a race between changing the
> >   DAX state and creating the iocb flags.
> 
> This is irrelevant - the check is simply wrong and has been since
> ~2016 when we moved DAX to use the iomap infrastructure...

Deleted.
Ira

> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
