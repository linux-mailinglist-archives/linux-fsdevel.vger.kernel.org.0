Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9F1A8CBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633328AbgDNUny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 16:43:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:32111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgDNUnx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:43:53 -0400
IronPort-SDR: tY3mnLJJMZ37LeY2lerYR74iByqJPSo7WPVr0ZmzcmKklgwAoNBdpSi6z/xIs915+wgeko6NpR
 T5d4xGyLj44w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:43:50 -0700
IronPort-SDR: jvkuPtTN/g4RAWjWQMPkUlO26mLy522pbJdALXipvnoDStHxBiGv8bGZfJMVMTIjUsa/dZ4LGa
 Idxxc5Q9+WDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="298809188"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2020 13:43:50 -0700
Date:   Tue, 14 Apr 2020 13:43:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 5/9] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200414204349.GB1982089@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-6-ira.weiny@intel.com>
 <20200414062718.GE23154@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414062718.GE23154@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:27:18AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 12, 2020 at 10:40:42PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > index 81f2f93caec0..37bd15b55878 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1244,12 +1244,11 @@ xfs_inode_supports_dax(
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
> 
> To me it would make sense to check S_ISREG before reflink, as it seems
> more logical.

Done.

> 
> > +#ifdef CONFIG_FS_DAX
> > +static bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	if (ip->i_mount->m_flags & XFS_MOUNT_NODAX)
> > +		return false;
> > +	if (!xfs_inode_supports_dax(ip))
> > +		return false;
> > +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> > +		return true;
> > +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> > +		return true;
> > +	return false;
> > +}
> > +#else /* !CONFIG_FS_DAX */
> > +static bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_FS_DAX */
> 
> Just throw in a
> 
> 	if (!IS_ENABLED(CONFIG_FS_DAX))
> 		return false;
> 
> as the first statement of the full version and avoid the stub entirely?

Sure, less code that way.  Done.

Ira

