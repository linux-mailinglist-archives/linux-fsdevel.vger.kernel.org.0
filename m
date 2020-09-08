Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F42262356
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIHXDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 19:03:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:3380 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIHXDd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:03:33 -0400
IronPort-SDR: KXmxaC3UVxZLwULecv6fkS53R/eH9se7ZByKVy/H7FNuFD/1XBSvb+dGCtLH3Ni72660k42Fyy
 dKY8dFkg6tFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219796745"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="219796745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 16:03:32 -0700
IronPort-SDR: 9CYmSfmkWviePX5p7KwYaXifK/q+2XkQ5bulAb3vFhdiemgUZzUFwwnpAlvFUFOBQe/TWT6sUb
 NlUy7JhvWtQg==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="317351952"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 16:03:32 -0700
Date:   Tue, 8 Sep 2020 16:03:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH v2] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
Message-ID: <20200908230331.GF1930795@iweiny-DESK2.sc.intel.com>
References: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:59:39PM +0800, Hao Li wrote:
> If generic_drop_inode() returns true, it means iput_final() can evict
> this inode regardless of whether it is dirty or not. If we check
> I_DONTCACHE in generic_drop_inode(), any inode with this bit set will be
> evicted unconditionally. This is not the desired behavior because
> I_DONTCACHE only means the inode shouldn't be cached on the LRU list.
> As for whether we need to evict this inode, this is what
> generic_drop_inode() should do. This patch corrects the usage of
> I_DONTCACHE.
> 
> This patch was proposed in [1].
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
> 
> Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changes in v2:
>  - Adjust code format
>  - Add Fixes tag in commit message
> 
>  fs/inode.c         | 4 +++-
>  include/linux/fs.h | 3 +--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..19ad823f781c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1625,7 +1625,9 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = generic_drop_inode(inode);
>  
> -	if (!drop && (sb->s_flags & SB_ACTIVE)) {
> +	if (!drop &&
> +	    !(inode->i_state & I_DONTCACHE) &&
> +	    (sb->s_flags & SB_ACTIVE)) {
>  		inode_add_lru(inode);
>  		spin_unlock(&inode->i_lock);
>  		return;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e019ea2f1347..93caee80ce47 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2922,8 +2922,7 @@ extern int inode_needs_sync(struct inode *inode);
>  extern int generic_delete_inode(struct inode *inode);
>  static inline int generic_drop_inode(struct inode *inode)
>  {
> -	return !inode->i_nlink || inode_unhashed(inode) ||
> -		(inode->i_state & I_DONTCACHE);
> +	return !inode->i_nlink || inode_unhashed(inode);
>  }
>  extern void d_mark_dontcache(struct inode *inode);
>  
> -- 
> 2.28.0
> 
> 
> 
