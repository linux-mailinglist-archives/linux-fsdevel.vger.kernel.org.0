Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CA7169845
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBWPHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 10:07:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:36914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBWPHl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:07:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 07:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="229631897"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2020 07:07:39 -0800
Date:   Sun, 23 Feb 2020 07:07:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 06/13] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200223150739.GE29607@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-7-ira.weiny@intel.com>
 <20200222002821.GD9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222002821.GD9506@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:28:21PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 20, 2020 at 04:41:27PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_inode_supports_dax() should reflect if the inode can support DAX not
> > that it is enabled for DAX.
> > 
> > Change the use of xfs_inode_supports_dax() to reflect only if the inode
> > and underlying storage support dax.
> > 
> > Add a new function xfs_inode_enable_dax() which reflects if the inode
> 
> Heavily into bikeshedding here, but "enable" sounds like a verb, but
> this function doesn't actually turn dax on for a file, it merely decides
> if we /should/ turn it on.

heheheheh...  As Dave said "names are hard"...  :-/

> 
> xfs_inode_wants_dax() ?

I viewed this as a question as in "enable dax"?

And I _think_ Dave actually suggested the name.

I'll contemplate it some,
Ira

> 
> --D
> 
> > should be enabled for DAX.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v3:
> > 	Update functions and names to be more clear
> > 	Update commit message
> > 	Merge with
> > 		'fs/xfs: Clean up DAX support check'
> > 		don't allow IS_DAX() on a directory
> > 		use STATIC macro for static
> > 		make xfs_inode_supports_dax() static
> > ---
> >  fs/xfs/xfs_iops.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 81f2f93caec0..ff711efc5247 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1237,19 +1237,18 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
> >  };
> >  
> >  /* Figure out if this file actually supports DAX. */
> > -static bool
> > +STATIC bool
> >  xfs_inode_supports_dax(
> >  	struct xfs_inode	*ip)
> >  {
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  
> >  	/* Only supported on non-reflinked files. */
> > -	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
> > +	if (xfs_is_reflink_inode(ip))
> >  		return false;
> >  
> > -	/* DAX mount option or DAX iflag must be set. */
> > -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> > -	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> > +	/* Only supported on regular files. */
> > +	if (!S_ISREG(VFS_I(ip)->i_mode))
> >  		return false;
> >  
> >  	/* Block size must match page size */
> > @@ -1260,6 +1259,20 @@ xfs_inode_supports_dax(
> >  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
> >  }
> >  
> > +STATIC bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	if (!xfs_inode_supports_dax(ip))
> > +		return false;
> > +
> > +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> > +		return true;
> > +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> > +		return true;
> > +	return false;
> > +}
> > +
> >  STATIC void
> >  xfs_diflags_to_iflags(
> >  	struct inode		*inode,
> > @@ -1278,7 +1291,7 @@ xfs_diflags_to_iflags(
> >  		inode->i_flags |= S_SYNC;
> >  	if (flags & XFS_DIFLAG_NOATIME)
> >  		inode->i_flags |= S_NOATIME;
> > -	if (xfs_inode_supports_dax(ip))
> > +	if (xfs_inode_enable_dax(ip))
> >  		inode->i_flags |= S_DAX;
> >  }
> >  
> > -- 
> > 2.21.0
> > 
