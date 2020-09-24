Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781F27753F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgIXP2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:28:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:58165 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgIXP2B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:28:01 -0400
IronPort-SDR: LgHY0KrwQPGYD8SVZHo9lC2CB9hS6VurKlP5T24v6rn3lPQtiPzUQ+fIP3LGZEhGydGACpNRA8
 DUicohK0+Cow==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225381798"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="225381798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 08:28:00 -0700
IronPort-SDR: LA1eFb5xMaqYkH1ryN0Tb0/RIqDte/AgdxwEvMOTpof540OpjqnWCwyWoZf1UHzvpvcAWIRBBU
 sPiUZx0xqZ9Q==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="486940874"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 08:28:00 -0700
Date:   Thu, 24 Sep 2020 08:27:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, y-goto@fujitsu.com
Subject: Re: [PATCH v2] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
Message-ID: <20200924152759.GJ2540965@iweiny-DESK2.sc.intel.com>
References: <20200924055958.825515-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924055958.825515-1-lihao2018.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:59:58PM +0800, Hao Li wrote:
> If DCACHE_REFERENCED is set, fast_dput() will return true, and then
> retain_dentry() have no chance to check DCACHE_DONTCACHE. As a result,
> the dentry won't be killed and the corresponding inode can't be evicted.
> In the following example, the DAX policy can't take effects unless we
> do a drop_caches manually.
> 
>   # DCACHE_LRU_LIST will be set
>   echo abcdefg > test.txt
> 
>   # DCACHE_REFERENCED will be set and DCACHE_DONTCACHE can't do anything
>   xfs_io -c 'chattr +x' test.txt
> 
>   # Drop caches to make DAX changing take effects
>   echo 2 > /proc/sys/vm/drop_caches
> 
> What this patch does is preventing fast_dput() from returning true if
> DCACHE_DONTCACHE is set. Then retain_dentry() will detect the
> DCACHE_DONTCACHE and will return false. As a result, the dentry will be
> killed and the inode will be evicted. In this way, if we change per-file
> DAX policy, it will take effects automatically after this file is closed
> by all processes.
> 
> I also add some comments to make the code more clear.
> 
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> v1 is split into two standalone patch as discussed in [1], and the first
> patch has been reviewed in [2]. This is the second patch.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
> [2]: https://lore.kernel.org/linux-fsdevel/20200906214002.GI12131@dread.disaster.area/
> 
>  fs/dcache.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ea0485861d93..97e81a844a96 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -793,10 +793,17 @@ static inline bool fast_dput(struct dentry *dentry)
>  	 * a reference to the dentry and change that, but
>  	 * our work is done - we can leave the dentry
>  	 * around with a zero refcount.
> +	 *
> +	 * Nevertheless, there are two cases that we should kill
> +	 * the dentry anyway.
> +	 * 1. free disconnected dentries as soon as their refcount
> +	 *    reached zero.
> +	 * 2. free dentries if they should not be cached.
>  	 */
>  	smp_rmb();
>  	d_flags = READ_ONCE(dentry->d_flags);
> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
> +			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
>  
>  	/* Nothing to do? Dropping the reference was all we needed? */
>  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> -- 
> 2.28.0
> 
> 
> 
