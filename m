Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706C31A1927
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 02:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDHANe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 20:13:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:14879 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHANd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:13:33 -0400
IronPort-SDR: F39ue/fKrtY/EimQVXXVJcTJPLk4URNj1B2VRa1/c7k3/OROszMgYlmzx1L/SjHAp2PAtcPepE
 mz8XbX6U9JrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:13:33 -0700
IronPort-SDR: meCSMCCsHwJL76gliCNHsz/xIRX6N0gXA0H4qHmwyncRdARH0D4hQj9BdM4PIyZOmj6XPOEX4V
 Icft9yISo17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="286383509"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2020 17:13:33 -0700
Date:   Tue, 7 Apr 2020 17:13:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 5/8] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200408001332.GB569068@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-6-ira.weiny@intel.com>
 <20200408000533.GG24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408000533.GG24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:05:33AM +1000, Dave Chinner wrote:
> On Tue, Apr 07, 2020 at 11:29:55AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_inode_supports_dax() should reflect if the inode can support DAX not
> > that it is enabled for DAX.
> > 
> > Change the use of xfs_inode_supports_dax() to reflect only if the inode
> > and underlying storage support dax.
> > 
> > Add a new function xfs_inode_enable_dax() which reflects if the inode
> > should be enabled for DAX.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ....
> >  
> > +STATIC bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	u32 dax_mode = xfs_mount_dax_mode(ip->i_mount);
> > +
> > +	if (dax_mode == XFS_DAX_NEVER || !xfs_inode_supports_dax(ip))
> > +		return false;
> > +	if (dax_mode == XFS_DAX_ALWAYS || ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> > +		return true;
> 
> These compound || statements are better written as single conditions
> as they are all sequential logic checks and we can't skip over
> checks.
> 
> 	if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
> 		return false;
> 	if (!xfs_inode_supports_dax(ip))
> 		return false;
> 	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> 		return true;
> 	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> 		return true;
> 	return false;

Updated for V7

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
