Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93E1A1914
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 02:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDHAFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 20:05:38 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59319 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbgDHAFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:05:37 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 48A2D7EC2A3;
        Wed,  8 Apr 2020 10:05:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jLyDl-0005kJ-FE; Wed, 08 Apr 2020 10:05:33 +1000
Date:   Wed, 8 Apr 2020 10:05:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 5/8] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200408000533.GG24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407182958.568475-6-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=85zGKsAm-IAguE7VF_oA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:29:55AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_inode_supports_dax() should reflect if the inode can support DAX not
> that it is enabled for DAX.
> 
> Change the use of xfs_inode_supports_dax() to reflect only if the inode
> and underlying storage support dax.
> 
> Add a new function xfs_inode_enable_dax() which reflects if the inode
> should be enabled for DAX.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
....
>  
> +STATIC bool
> +xfs_inode_enable_dax(
> +	struct xfs_inode *ip)
> +{
> +	u32 dax_mode = xfs_mount_dax_mode(ip->i_mount);
> +
> +	if (dax_mode == XFS_DAX_NEVER || !xfs_inode_supports_dax(ip))
> +		return false;
> +	if (dax_mode == XFS_DAX_ALWAYS || ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> +		return true;

These compound || statements are better written as single conditions
as they are all sequential logic checks and we can't skip over
checks.

	if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
		return false;
	if (!xfs_inode_supports_dax(ip))
		return false;
	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
		return true;
	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
		return true;
	return false;

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
