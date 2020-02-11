Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4262F159AA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgBKUlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 15:41:13 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48892 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgBKUlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:41:12 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 437473A30A3;
        Wed, 12 Feb 2020 07:41:08 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1cLD-0002wq-H5; Wed, 12 Feb 2020 07:41:07 +1100
Date:   Wed, 12 Feb 2020 07:41:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 05/12] fs: remove unneeded IS_DAX() check
Message-ID: <20200211204107.GM10776@dread.disaster.area>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-6-ira.weiny@intel.com>
 <20200211053401.GE10776@dread.disaster.area>
 <20200211163831.GC12866@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211163831.GC12866@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=oagkb_tiXJ3G83dhfBYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:38:31AM -0800, Ira Weiny wrote:
> On Tue, Feb 11, 2020 at 04:34:01PM +1100, Dave Chinner wrote:
> > On Sat, Feb 08, 2020 at 11:34:38AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The IS_DAX() check in io_is_direct() causes a race between changing the
> > > DAX state and creating the iocb flags.
> > > 
> > > Remove the check because DAX now emulates the page cache API and
> > > therefore it does not matter if the file state is DAX or not when the
> > > iocb flags are created.
> > 
> > This statement is ... weird.
> > 
> > DAX doesn't "emulate" the page cache API at all
> 
> ah...  yea emulate is a bad word here.
> 
> > - it has it's own
> > read/write methods that filesystems call based on the iomap
> > infrastructure (dax_iomap_rw()). i.e. there are 3 different IO paths
> > through the filesystems: the DAX IO path, the direct IO path, and
> > the buffered IO path.
> > 
> > Indeed, it seems like this works a bit by luck: Ext4 and XFS always
> > check IS_DAX(inode) in the read/write_iter methods before checking
> > for IOCB_DIRECT, and hence the IOCB_DIRECT flag is ignored by the
> > filesystems. i.e. when we got rid of the O_DIRECT paths from DAX, we
> > forgot to clean up io_is_direct() and it's only due to the ordering
> > of checks that we went down the DAX path correctly....
> > 
> > That said, the code change is good, but the commit message needs a
> > rewrite.
> 
> How about?
> 
> <commit msg>
>   fs: Remove unneeded IS_DAX() check
>   
>   The IS_DAX() check in io_is_direct() causes a race between changing the
>   DAX state and creating the iocb flags.

This is irrelevant - the check is simply wrong and has been since
~2016 when we moved DAX to use the iomap infrastructure...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
