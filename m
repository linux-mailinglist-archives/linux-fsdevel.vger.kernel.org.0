Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA821A97BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408189AbgDOJB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:01:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:53082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405260AbgDOJB4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:01:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 60116AF92;
        Wed, 15 Apr 2020 09:01:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A4291E1250; Wed, 15 Apr 2020 11:01:53 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:01:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200415090153.GF501@quack2.suse.cz>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-10-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-04-20 23:45:21, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DCACHE_DONTCACHE indicates a dentry should not be cached on final
> dput().
> 
> Also add a helper function which will flag I_DONTCACHE as well ad
> DCACHE_DONTCACHE on all dentries point to a specified inode.

I think this sentence needs more work :). Like: Also add a helper function
which will mark the inode with I_DONTCACHE flag and also mark all dentries
pointing to a specified inode as DCACHE_DONTCACHE.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V7:
> 	new patch
> ---
>  fs/dcache.c            |  4 ++++
>  fs/inode.c             | 15 +++++++++++++++
>  include/linux/dcache.h |  2 ++
>  include/linux/fs.h     |  1 +
>  4 files changed, 22 insertions(+)

...

> diff --git a/fs/inode.c b/fs/inode.c
> index 93d9252a00ab..b8b1917a324e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(generic_delete_inode);
>  
> +void flag_inode_dontcache(struct inode *inode)

mark_inode_dontcache?

> +{
> +	struct dentry *dent;

This is really nitpicking but dentry variables are usually called 'de' or
'dentry' :)

> +
> +	rcu_read_lock();

I don't think this list is safe to traverse under RCU. E.g.
dentry_unlink_inode() does hlist_del_init(&dentry->d_u.d_alias). Usually,
we traverse this list under inode->i_lock protection AFAICS.

								Honza

> +	hlist_for_each_entry(dent, &inode->i_dentry, d_u.d_alias) {
> +		spin_lock(&dent->d_lock);
> +		dent->d_flags |= DCACHE_DONTCACHE;
> +		spin_unlock(&dent->d_lock);
> +	}
> +	rcu_read_unlock();
> +	inode->i_state |= I_DONTCACHE;
> +}
> +EXPORT_SYMBOL(flag_inode_dontcache);
> +
>  /*
>   * Called when we're dropping the last reference
>   * to an inode.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
