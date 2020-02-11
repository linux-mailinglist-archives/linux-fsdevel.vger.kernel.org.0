Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40812159494
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgBKQNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 11:13:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:58156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBKQNu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:13:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347303924"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 08:13:49 -0800
Date:   Tue, 11 Feb 2020 08:13:49 -0800
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
Subject: Re: [PATCH v3 03/12] fs/xfs: Separate functionality of
 xfs_inode_supports_dax()
Message-ID: <20200211161348.GA12866@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-4-ira.weiny@intel.com>
 <20200211054748.GF10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211054748.GF10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:47:48PM +1100, Dave Chinner wrote:
> On Sat, Feb 08, 2020 at 11:34:36AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> >  
> > +static bool
> > +xfs_inode_is_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	return (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX) == XFS_DIFLAG2_DAX;
> > +}
> 
> I don't think these wrappers add any value at all - the naming of
> them is entirely confusing, too. e.g. "inode is dax" doesn't tell me
> that it is checking the on disk flags - it doesn't tell me how it is
> different to IS_DAX, or why I'd use one versus the other. And then
> xfs_inode_mount_is_dax() is just... worse.
> 
> Naming is hard. :)

Sure...  I'm particularly bad as well...

FWIW I don't see how xfs_inode_mount_is_dax() is worse, I rather think that is
pretty clear but I'm not going to quibble over names because I know I'm rubbish
at it and I'm certainly not enough of a FS person to make them clear...  ;-)

> 
> > +
> > +static bool
> > +xfs_inode_use_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	return xfs_inode_supports_dax(ip) &&
> > +		(xfs_inode_mount_is_dax(ip) ||
> > +		 xfs_inode_is_dax(ip));
> > +}
> 
> Urk. Naming - we're not "using dax" here, we are checkign to see if
> we should enable DAX on this inode. IOWs:

Well just to defend myself a little bit.  My thought was:

"When setting i_flags, should I use dax?"

> 
> static bool
> xfs_inode_enable_dax(
> 	struct xfs_inode *ip)
> {
> 	if (!xfs_inode_supports_dax(ip))
> 		return false;
> 
> 	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> 		return true;
> 	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> 		return true;
> 	return false;
> }

Anyway, I'm good with this.

Changed for V4.

Thanks!
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
