Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1035B1B6755
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 00:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDWW5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 18:57:41 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48863 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbgDWW5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:57:40 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CA3A8820564;
        Fri, 24 Apr 2020 08:57:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jRkmk-0006uC-DD; Fri, 24 Apr 2020 08:57:34 +1000
Date:   Fri, 24 Apr 2020 08:57:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 10/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200423225734.GY27860@dread.disaster.area>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422212102.3757660-11-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=drOt6m5kAAAA:8
        a=7-415B0cAAAA:8 a=y1ryl40uyaZQ8-5qDf4A:9 a=CjuIK1q_8ugA:10
        a=RMMjzBEyIzXRtoq5n5K6:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 02:21:01PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DCACHE_DONTCACHE indicates a dentry should not be cached on final
> dput().
> 
> Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> pointing to a specific inode when that inode is being set I_DONTCACHE.
> 
> This facilitates dropping dentry references to inodes sooner which
> require eviction to swap S_DAX mode.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Code looks fine....

> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(generic_delete_inode);
>  
> +void mark_inode_dontcache(struct inode *inode)
> +{
> +	struct dentry *de;
> +
> +	spin_lock(&inode->i_lock);
> +	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
> +		spin_lock(&de->d_lock);
> +		de->d_flags |= DCACHE_DONTCACHE;
> +		spin_unlock(&de->d_lock);
> +	}
> +	inode->i_state |= I_DONTCACHE;
> +	spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL(mark_inode_dontcache);

Though I suspect that this should be in fs/dcache.c and not
fs/inode.c. i.e. nothing in fs/inode.c does dentry list walks, but
there are several cases in the dcache code where inode dentry walks
are done under the inode lock (e.g. d_find_alias(inode)).

So perhaps this should be d_mark_dontcache(inode), which also marks
the inode as I_DONTCACHE so that everything is evicted on last
reference...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
