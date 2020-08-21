Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49224DEB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHURkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:40:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:59643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHURko (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:40:44 -0400
IronPort-SDR: vKsYkXIRI/Msm3XfA1lpSSFhJpf+SvU2HF95vsK1G57tK80c1gcMkMhUHI+rdS3OqeGkGrN7Jn
 P5tvpLB4nCrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="155578918"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="155578918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 10:40:41 -0700
IronPort-SDR: BfK+1av7mzeYf3wx3u4NXslDuTo1SpMAF+P1dA7jFE9gU5U9v79MCdvXhyl7In84C1bc3R1SyV
 m5esAyFO0A5g==
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="321333466"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 10:40:41 -0700
Date:   Fri, 21 Aug 2020 10:40:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
Message-ID: <20200821174040.GG3142014@iweiny-DESK2.sc.intel.com>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
> Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
> set from being killed, so the corresponding inode can't be evicted. If
> the DAX policy of an inode is changed, we can't make policy changing
> take effects unless dropping caches manually.
> 
> This patch fixes this problem and flushes the inode to disk to prepare
> for evicting it.

This looks intriguing and I really hope this helps but I don't think this will
guarantee that the state changes immediately will it?

Do you have a test case which fails before and passes after?  Perhaps one of
the new xfstests submitted by Xiao?

Ira

> 
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
>  fs/dcache.c | 3 ++-
>  fs/inode.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ea0485861d93..486c7409dc82 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
>  	 */
>  	smp_rmb();
>  	d_flags = READ_ONCE(dentry->d_flags);
> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
> +			| DCACHE_DONTCACHE;
>  
>  	/* Nothing to do? Dropping the reference was all we needed? */
>  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..5218a8aebd7f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
>  	}
>  
>  	state = inode->i_state;
> -	if (!drop) {
> +	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
>  
> -- 
> 2.28.0
> 
> 
> 
