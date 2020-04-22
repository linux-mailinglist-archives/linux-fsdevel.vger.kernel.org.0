Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026541B4867
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDVPTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:19:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:64492 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVPTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:19:22 -0400
IronPort-SDR: g+e2neNjlNXJtBW9uKW9uy8+Awxlpb8mM0A/r6lyEuRck4O/ltEvJJu4eOaXKaLiej1cWVSNPU
 YwSqKMhBsGgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 08:19:21 -0700
IronPort-SDR: wMPMyCQV2sgAciecf8sXYl3SWjc2saJ4LqbMT56FLKqAmumQ/4HvXD4XYPl3wlKIgUpqX21BcU
 IR8A9zpPLkGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="291974599"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2020 08:19:20 -0700
Date:   Wed, 22 Apr 2020 08:19:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200422151920.GI3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-10-ira.weiny@intel.com>
 <20200422084647.GC8775@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422084647.GC8775@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:46:47AM +0200, Jan Kara wrote:
> On Tue 21-04-20 12:17:51, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DCACHE_DONTCACHE indicates a dentry should not be cached on final
> > dput().
> > 
> > Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> > pointing to a specific inode when that inode is being set I_DONTCACHE.
> > 
> > This facilitates dropping dentry references to inodes sooner which
> > require eviction to swap S_DAX mode.
> > 
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V8:
> > 	Update commit message
> > 	Use mark_inode_dontcache in XFS
> > 	Fix locking...  can't use rcu here.
> > 	Change name to mark_inode_dontcache
> > ---
> >  fs/dcache.c            |  4 ++++
> >  fs/inode.c             | 15 +++++++++++++++
> >  fs/xfs/xfs_icache.c    |  2 +-
> >  include/linux/dcache.h |  2 ++
> >  include/linux/fs.h     |  1 +
> >  5 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index b280e07e162b..0030fabab2c4 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -647,6 +647,10 @@ static inline bool retain_dentry(struct dentry *dentry)
> >  		if (dentry->d_op->d_delete(dentry))
> >  			return false;
> >  	}
> > +
> > +	if (unlikely(dentry->d_flags & DCACHE_DONTCACHE))
> > +		return false;
> > +
> >  	/* retain; LRU fodder */
> >  	dentry->d_lockref.count--;
> >  	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 93d9252a00ab..da7f3c4926cd 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(generic_delete_inode);
> >  
> > +void mark_inode_dontcache(struct inode *inode)
> > +{
> > +	struct dentry *de;
> > +
> > +	spin_lock(&inode->i_lock);
> > +	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
> > +		spin_lock(&de->d_lock);
> > +		de->d_flags |= DCACHE_DONTCACHE;
> > +		spin_unlock(&de->d_lock);
> > +	}
> > +	spin_unlock(&inode->i_lock);
> > +	inode->i_state |= I_DONTCACHE;
> 
> Modification of i_state should happen under i_lock.

Done.

> 
> > +}
> > +EXPORT_SYMBOL(mark_inode_dontcache);
> > +
> >  /*
> >   * Called when we're dropping the last reference
> >   * to an inode.
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index de76f7f60695..3c8f44477804 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -559,7 +559,7 @@ xfs_iget_cache_miss(
> >  	 */
> >  	iflags = XFS_INEW;
> >  	if (flags & XFS_IGET_DONTCACHE)
> > -		VFS_I(ip)->i_state |= I_DONTCACHE;
> > +		mark_inode_dontcache(VFS_I(ip));
> 
> And I know here modification of i_state didn't happen under i_lock but
> that's a special case because we are just instantiating the inode so it was
> not a real issue.

Thanks!
Ira

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
