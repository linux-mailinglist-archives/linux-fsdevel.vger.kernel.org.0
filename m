Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E781A82A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439678AbgDNP0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:52362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgDNP0d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:26:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61AF7AB8F;
        Tue, 14 Apr 2020 15:26:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2631D1E125F; Tue, 14 Apr 2020 17:26:30 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:26:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200414152630.GE28226@quack2.suse.cz>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-04-20 22:40:44, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DAX effective mode changes (setting of S_DAX) require inode eviction.
> 
> Define a flag which can be set to inform the VFS layer that inodes
> should not be cached.  This will expedite the eviction of those nodes
> requiring reload.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

This inode flag will have a limited impact because usually dentry will
still hold inode reference. So until dentry is evicted, inode stays as
well. So I think we'd need something like DCACHE_DONTCACHE flag as well to
discard a dentry whenever dentry usecount hits zero (which will be
generally on last file close). What do you think?

And I'd note that checking for I_DONTCACHE flag in dput() isn't
straightforward because of locking so that's why I suggest separate dentry
flag.

								Honza

> ---
>  include/linux/fs.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a818ced22961..e2db71d150c3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *
>   * I_CREATING		New object's inode in the middle of setting up.
>   *
> + * I_DONTCACHE		Do not cache the inode
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   */
>  #define I_DIRTY_SYNC		(1 << 0)
> @@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_WB_SWITCH		(1 << 13)
>  #define I_OVL_INUSE		(1 << 14)
>  #define I_CREATING		(1 << 15)
> +#define I_DONTCACHE		(1 << 16)
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> @@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
>  extern int generic_delete_inode(struct inode *inode);
>  static inline int generic_drop_inode(struct inode *inode)
>  {
> -	return !inode->i_nlink || inode_unhashed(inode);
> +	return !inode->i_nlink || inode_unhashed(inode) ||
> +		(inode->i_state & I_DONTCACHE);
>  }
>  
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
