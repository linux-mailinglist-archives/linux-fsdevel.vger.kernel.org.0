Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA91A18C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGXq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 19:46:28 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35741 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgDGXq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:46:27 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DA3287ECC36;
        Wed,  8 Apr 2020 09:46:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jLxvB-0005aB-PY; Wed, 08 Apr 2020 09:46:21 +1000
Date:   Wed, 8 Apr 2020 09:46:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 1/8] fs/xfs: Remove unnecessary initialization of
 i_rwsem
Message-ID: <20200407234621.GD24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407182958.568475-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=-IQXNzbcgNwCz_NF7soA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:29:51AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> An earlier call of xfs_reinit_inode() from xfs_iget_cache_hit() already
> handles initialization of i_rwsem.
> 
> Doing so again is unneeded.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V4:
> 	Update commit message to make it clear the xfs_iget_cache_hit()
> 	is actually doing the initialization via xfs_reinit_inode()
> 
> New for V4:
> 
> NOTE: This was found while ensuring the new i_aops_sem was properly
> handled.  It seems like this is a layering violation so I think it is
> worth cleaning up so as to not confuse others.
> ---
>  fs/xfs/xfs_icache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..836a1f09be03 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -419,6 +419,7 @@ xfs_iget_cache_hit(
>  		spin_unlock(&ip->i_flags_lock);
>  		rcu_read_unlock();
>  
> +		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
>  		error = xfs_reinit_inode(mp, inode);
>  		if (error) {
>  			bool wake;
> @@ -452,9 +453,6 @@ xfs_iget_cache_hit(
>  		ip->i_sick = 0;
>  		ip->i_checked = 0;
>  
> -		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> -		init_rwsem(&inode->i_rwsem);
> -
>  		spin_unlock(&ip->i_flags_lock);
>  		spin_unlock(&pag->pag_ici_lock);
>  	} else {

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
