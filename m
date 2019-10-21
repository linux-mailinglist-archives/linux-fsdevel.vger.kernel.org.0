Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E02DF835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 00:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJUWtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 18:49:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:59581 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbfJUWtd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:49:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 15:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="209483476"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2019 15:49:31 -0700
Date:   Mon, 21 Oct 2019 15:49:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/xfs: Allow toggle of physical DAX flag
Message-ID: <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
 <20191021004536.GD8015@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021004536.GD8015@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:45:36AM +1100, Dave Chinner wrote:
> On Sun, Oct 20, 2019 at 08:59:35AM -0700, ira.weiny@intel.com wrote:
> > @@ -1232,12 +1233,10 @@ xfs_diflags_to_linux(
> >  		inode->i_flags |= S_NOATIME;
> >  	else
> >  		inode->i_flags &= ~S_NOATIME;
> > -#if 0	/* disabled until the flag switching races are sorted out */
> >  	if (xflags & FS_XFLAG_DAX)
> >  		inode->i_flags |= S_DAX;
> >  	else
> >  		inode->i_flags &= ~S_DAX;
> > -#endif
> 
> This code has bit-rotted. See xfs_setup_iops(), where we now have a
> different inode->i_mapping->a_ops for DAX inodes.

:-(

> 
> That, fundamentally, is the issue here - it's not setting/clearing
> the DAX flag that is the issue, it's doing a swap of the
> mapping->a_ops while there may be other code using that ops
> structure.
> 
> IOWs, if there is any code anywhere in the kernel that
> calls an address space op without holding one of the three locks we
> hold here (i_rwsem, MMAPLOCK, ILOCK) then it can race with the swap
> of the address space operations.
> 
> By limiting the address space swap to file sizes of zero, we rule
> out the page fault path (mmap of a zero length file segv's with an
> access beyond EOF on the first read/write page fault, right?).

Yes I checked that and thought we were safe here...

> However, other aops callers that might run unlocked and do the wrong
> thing if the aops pointer is swapped between check of the aop method
> existing and actually calling it even if the file size is zero?
> 
> A quick look shows that FIBMAP (ioctl_fibmap())) looks susceptible
> to such a race condition with the current definitions of the XFS DAX
> aops. I'm guessing there will be others, but I haven't looked
> further than this...

I'll check for others and think on what to do about this.  ext4 will have the
same problem I think.  :-(

I don't suppose using a single a_ops for both DAX and non-DAX is palatable?

> 
> >  	/* lock, flush and invalidate mapping in preparation for flag change */
> >  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > +
> > +	if (i_size_read(inode) != 0) {
> > +		error = -EOPNOTSUPP;
> > +		goto out_unlock;
> > +	}
> 
> Wrong error. Should be the same as whatever is returned when we try
> to change the extent size hint and can't because the file is
> non-zero in length (-EINVAL, I think). Also needs a comment
> explainging why this check exists, and probably better written as
> i_size_read() > 0 ....

Done, done, and done.

Thank you,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
