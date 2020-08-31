Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BB257F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgHaRND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:13:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:45914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgHaRNC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:13:02 -0400
IronPort-SDR: dfkRCZWL5j641E5QWBkEgOypzc5Y+42uo89zke1iEls5xve07dGl+G9A9fLqA8P4R6H7/FPUMe
 UX1BaYxfmtBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="241838518"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="241838518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:12:59 -0700
IronPort-SDR: Y41XvCv6aivpF6BcwaaJivkQ0Jd2PyWIKbmvWPSvEAOkXy+DJxzAzfn8LfU6MWpD59gSRgXXqf
 uvR5w9wPR7IQ==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="301118539"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:12:58 -0700
Date:   Mon, 31 Aug 2020 10:12:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
Message-ID: <20200831171257.GF1422350@iweiny-DESK2.sc.intel.com>
References: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:13:13PM +0800, Hao Li wrote:
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
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>

Thanks!  I think this looks good, but shouldn't we add?  It seems like this is
a bug right?

Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  fs/inode.c         | 3 ++-
>  include/linux/fs.h | 3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..4e45d5ea3d0f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1625,7 +1625,8 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = generic_drop_inode(inode);
>  
> -	if (!drop && (sb->s_flags & SB_ACTIVE)) {
> +	if (!drop && !(inode->i_state & I_DONTCACHE) &&
> +			(sb->s_flags & SB_ACTIVE)) {
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
