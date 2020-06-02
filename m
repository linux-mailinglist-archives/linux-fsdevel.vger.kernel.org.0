Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F51EC58B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFBXPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 19:15:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:57326 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgFBXPL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:15:11 -0400
IronPort-SDR: +yXGausVvQonlRJjYFNgJZe4YKcSALxXM9n3JD5uSKZGsHqntXxNZ8u4EGmsMSxpRtDzEJY4IL
 avCFhDf1YEKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:15:10 -0700
IronPort-SDR: VFcvTWOtbz3dkiPRuW2/npw0KipzrpAkLGxUts2YewEMQROQ4Rd+aVaZH1ioqP86z6ajt4JZpo
 vq36BdR9KjCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="312421829"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2020 16:15:10 -0700
Date:   Tue, 2 Jun 2020 16:15:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 11/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200602231510.GH1505637@iweiny-DESK2.sc.intel.com>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-12-ira.weiny@intel.com>
 <20200428201138.GD6742@magnolia>
 <20200602172353.GC8230@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602172353.GC8230@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:23:53AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 28, 2020 at 01:11:38PM -0700, Darrick J. Wong wrote:
> > On Mon, Apr 27, 2020 at 05:21:42PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 

...

> > > -out_unlock:
> > > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > > -	return error;
> > > +	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
> > > +	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
> > > +		return;
> > >  
> > > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > > +		d_mark_dontcache(inode);
> 
> Now that I think about this further, are we /really/ sure that we want
> to let unprivileged userspace cause inode evictions?

This code only applies to files they have access to.  And it does not directly
cause an eviction.  It only hints that those inodes (for which they have access
to) will not be cached thus causing them to be reloaded sooner than they might
otherwise be.

So I think we are fine here.

Ira

> 
> --D
> 
