Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCBDF8BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfJUXqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 19:46:15 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45110 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbfJUXqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:46:15 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E32A73629FF;
        Tue, 22 Oct 2019 10:46:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMhNE-0007QX-Aa; Tue, 22 Oct 2019 10:46:04 +1100
Date:   Tue, 22 Oct 2019 10:46:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/xfs: Allow toggle of physical DAX flag
Message-ID: <20191021234604.GB2681@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
 <20191021004536.GD8015@dread.disaster.area>
 <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=YPogiMHmU-6fRLEyw_MA:9
        a=z-c3JQe-jSBONlfH:21 a=Z1gFN9eyTm15yBDe:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:49:31PM -0700, Ira Weiny wrote:
> On Mon, Oct 21, 2019 at 11:45:36AM +1100, Dave Chinner wrote:
> > On Sun, Oct 20, 2019 at 08:59:35AM -0700, ira.weiny@intel.com wrote:
> > > @@ -1232,12 +1233,10 @@ xfs_diflags_to_linux(
> > >  		inode->i_flags |= S_NOATIME;
> > >  	else
> > >  		inode->i_flags &= ~S_NOATIME;
> > > -#if 0	/* disabled until the flag switching races are sorted out */
> > >  	if (xflags & FS_XFLAG_DAX)
> > >  		inode->i_flags |= S_DAX;
> > >  	else
> > >  		inode->i_flags &= ~S_DAX;
> > > -#endif
> > 
> > This code has bit-rotted. See xfs_setup_iops(), where we now have a
> > different inode->i_mapping->a_ops for DAX inodes.
> 
> :-(
> 
> > 
> > That, fundamentally, is the issue here - it's not setting/clearing
> > the DAX flag that is the issue, it's doing a swap of the
> > mapping->a_ops while there may be other code using that ops
> > structure.
> > 
> > IOWs, if there is any code anywhere in the kernel that
> > calls an address space op without holding one of the three locks we
> > hold here (i_rwsem, MMAPLOCK, ILOCK) then it can race with the swap
> > of the address space operations.
> > 
> > By limiting the address space swap to file sizes of zero, we rule
> > out the page fault path (mmap of a zero length file segv's with an
> > access beyond EOF on the first read/write page fault, right?).
> 
> Yes I checked that and thought we were safe here...
> 
> > However, other aops callers that might run unlocked and do the wrong
> > thing if the aops pointer is swapped between check of the aop method
> > existing and actually calling it even if the file size is zero?
> > 
> > A quick look shows that FIBMAP (ioctl_fibmap())) looks susceptible
> > to such a race condition with the current definitions of the XFS DAX
> > aops. I'm guessing there will be others, but I haven't looked
> > further than this...
> 
> I'll check for others and think on what to do about this.  ext4 will have the
> same problem I think.  :-(
> 
> I don't suppose using a single a_ops for both DAX and non-DAX is palatable?

IMO, no. It means we have to check IS_DAX() in every aops,
and replicate a bunch of callouts to generic code. i.e this sort of
thing:

	if (aops->method)
		return aops->method(...)

	/* do something else */

results in us having to replicate that logic as something like:

	if (!IS_DAX)
		return filesystem_aops_method()

	/* do something else */

Indeed, the calling code may well do the wrong thing if we have
methods defined just to add IS_DAX() checks to avoid using that
functionality because the caller now thinks that functionality is
supported when in fact it isn't.

So it seems to me like an even bigger can of worms to try to use a
single aops structure for vastly different functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
