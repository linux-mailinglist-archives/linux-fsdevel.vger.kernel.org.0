Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C621B3304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 01:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDUXZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 19:25:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:38670 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUXZA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:25:00 -0400
IronPort-SDR: eld7CtTw7O2a7bvAIF+0BhiPeZvh57Vl4bM8ybQ8dmLe4Gq99UxsIoca9+sbEHjee2ezTWHJch
 irnYcTMRz3sQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 16:24:59 -0700
IronPort-SDR: VXNYjUbp1WCc/LfcdAKiNjlSOSCA8YZ41iRNh2oDn5LaX5tYLMUtFRO/qjhJ2f6zWA2A4hTGQ1
 txFZzouil5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="290639115"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2020 16:24:59 -0700
Date:   Tue, 21 Apr 2020 16:24:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 10/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200421232459.GF3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-11-ira.weiny@intel.com>
 <20200421203140.GD6742@magnolia>
 <20200421213049.GC27860@dread.disaster.area>
 <20200421214328.GD3372712@iweiny-DESK2.sc.intel.com>
 <20200421231343.GD27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421231343.GD27860@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:13:43AM +1000, Dave Chinner wrote:
> On Tue, Apr 21, 2020 at 02:43:29PM -0700, Ira Weiny wrote:
> > On Wed, Apr 22, 2020 at 07:30:49AM +1000, Dave Chinner wrote:
> > > On Tue, Apr 21, 2020 at 01:31:40PM -0700, Darrick J. Wong wrote:
> > > > On Tue, Apr 21, 2020 at 12:17:52PM -0700, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> > > > 
> > > > That's a ... strange name.  Set cache on what?
> > > > 
> > > > Oh, this is the function that sets I_DONTCACHE if an FS_XFLAG_DAX change
> > > > could have an immediate effect on S_DAX (assuming no other users).  What
> > > > do you think of the following?
> > > > 
> > > > 	/*
> > > > 	 * If a change to FS_XFLAG_DAX will result in an change to S_DAX
> > > > 	 * the next time the incore inode is initialized, set the VFS
> > > > 	 * I_DONTCACHE flag to try to hurry that along.
> > > > 	 */
> > > > 	static void
> > > > 	xfs_ioctl_try_change_vfs_dax(...)
> > > 
> > > That doesn't seem any better. This is a preparation function now, in
> > > that it can't fail and doesn't change the outcome of the operation
> > > being performed. So, IMO, calling it something like
> > > xfs_ioctl_setattr_prepare_dax() would be a better name for it.
> > 
> > But it does potentially (after a check) set I_DONTCACHE.
> 
> That is an implementation detail - it doesn't change the outcome of
> the function, the current behaviour of the inode, or the result of
> the ioctl....

I'm confused.  This function does potentially flag the inode to not be cached.
How is that not changing the behavior of the inode?

> 
> > What about?
> > 
> > xfs_ioctl_dax_check_set_dontcache()?
> 
> Then we have to rename it again the moment we change it's
> functionality. i.e. we have exactly the same problem we have now
> where the function name describes the implementation, not the
> operational reason the function is being called...

Ok, I see what you are driving at.  You want this function to potentially do
other things and it should 'prepare' the inode for 'dax stuff'.  Is that about
it?

I'm ok with xfs_ioctl_setattr_prepare_dax() then.

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
