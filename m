Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E627E1A2BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 00:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHWHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 18:07:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:59699 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDHWHh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:07:37 -0400
IronPort-SDR: 3KdoTt4VgvH52W/mwTz8YkQUaDPjTVsBR6HJQza2JXYI5g1puUX3Ss5Elj/wVFr4G22Kcadg+j
 TwjRv7TfTPLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 15:07:35 -0700
IronPort-SDR: xpWLvKMUDOBpguasXWBlaLt37tIpZR/h2WIIcnBXMOV8v0k0hyFTK0fAuE+I+mpptJTco46//+
 Dz/b07FIQeiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="269882952"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2020 15:07:35 -0700
Date:   Wed, 8 Apr 2020 15:07:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408210236.GK24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:02:36AM +1000, Dave Chinner wrote:
> On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:

[snip]

> > 
> > This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> > 
> > void
> > xfs_diflags_to_iflags(
> >         struct xfs_inode        *ip,
> >         bool init)
> > {
> >         struct inode            *inode = VFS_I(ip);
> >         unsigned int            xflags = xfs_ip2xflags(ip);
> >         unsigned int            flags = 0;
> > 
> >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> >                             S_DAX);
> 
> We don't want to clear the dax flag here, ever, if it is already
> set. That is an externally visible change and opens us up (again) to
> races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> clearing the DAX flag was something I did explicitly in the above
> code fragment.

<sigh> yes... you are correct.

But I don't like depending on the caller to clear the S_DAX flag if
xfs_inode_enable_dax() is false.  IMO this function should clear the flag in
that case for consistency...

This is part of the reason I used the if/else logic from xfs_diflags_to_linux()
originally.  It is very explicit.

> 
> And it makes the logic clearer by pre-calculating the new flags,
> then clearing and setting the inode flags together, rather than
> having the spearated at the top and bottom of the function.

But this will not clear the S_DAX flag even if init is true.  To me that is a
potential for confusion down the road.

> 
> THis leads to an obvious conclusion: if we never clear the in memory
> S_DAX flag, we can actually clear the on-disk flag safely, so that
> next time the inode cycles into memory it won't be using DAX. IOWs,
> admins can stop the applications, clear the DAX flag and drop
> caches. This should result in the inode being recycled and when the
> app is restarted it will run without DAX. No ned for deleting files,
> copying large data sets, etc just to turn off an inode flag.

We already discussed evicting the inode and it was determined to be too
confusing.[*]

Furthermore, if we did want an interface like that why not allow the on-disk
flag to be set as well as cleared?

IMO, this function should set all of the flags consistently including S_DAX.

Ira

[*] https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
