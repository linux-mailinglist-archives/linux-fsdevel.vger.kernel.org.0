Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD894F7563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiDGFdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiDGFdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:33:09 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3EB99EEC;
        Wed,  6 Apr 2022 22:31:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V9PKx-H_1649309460;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V9PKx-H_1649309460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Apr 2022 13:31:03 +0800
Date:   Thu, 7 Apr 2022 13:31:00 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 12/20] erofs: add anonymous inode managing page cache
 for data blob
Message-ID: <Yk53FOjDLzN941b4@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-13-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-13-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:04PM +0800, Jeffle Xu wrote:
> Introduce one anonymous inode managing page cache for data blob. Then
> erofs could read directly from the address space of the anonymous inode
> when cache hit.

Introduce one anonymous inode for data blobs so that erofs
can cache metadata directly within such anonymous inode.

> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Yeah, I think currently we can live with that:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


> ---
>  fs/erofs/fscache.c  | 39 ++++++++++++++++++++++++++++++++++++---
>  fs/erofs/internal.h |  6 ++++--
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 67a3c4935245..1c88614203d2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,17 +5,22 @@
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +static const struct address_space_operations erofs_fscache_meta_aops = {
> +};
> +
>  /*
>   * Create an fscache context for data blob.
>   * Return: 0 on success and allocated fscache context is assigned to @fscache,
>   *	   negative error number on failure.
>   */
>  int erofs_fscache_register_cookie(struct super_block *sb,
> -				  struct erofs_fscache **fscache, char *name)
> +				  struct erofs_fscache **fscache,
> +				  char *name, bool need_inode)
>  {
>  	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>  	struct erofs_fscache *ctx;
>  	struct fscache_cookie *cookie;
> +	int ret;
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -25,15 +30,40 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  					name, strlen(name), NULL, 0, 0);
>  	if (!cookie) {
>  		erofs_err(sb, "failed to get cookie for %s", name);
> -		kfree(name);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err;
>  	}
>  
>  	fscache_use_cookie(cookie, false);
>  	ctx->cookie = cookie;
>  
> +	if (need_inode) {
> +		struct inode *const inode = new_inode(sb);
> +
> +		if (!inode) {
> +			erofs_err(sb, "failed to get anon inode for %s", name);
> +			ret = -ENOMEM;
> +			goto err_cookie;
> +		}
> +
> +		set_nlink(inode, 1);
> +		inode->i_size = OFFSET_MAX;
> +		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +
> +		ctx->inode = inode;
> +	}
> +
>  	*fscache = ctx;
>  	return 0;
> +
> +err_cookie:
> +	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> +	fscache_relinquish_cookie(ctx->cookie, false);
> +	ctx->cookie = NULL;
> +err:
> +	kfree(ctx);
> +	return ret;
>  }
>  
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
> @@ -47,6 +77,9 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  	fscache_relinquish_cookie(ctx->cookie, false);
>  	ctx->cookie = NULL;
>  
> +	iput(ctx->inode);
> +	ctx->inode = NULL;
> +
>  	kfree(ctx);
>  	*fscache = NULL;
>  }
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index c6a3351a4d7d..3a4a344cfed3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -99,6 +99,7 @@ struct erofs_sb_lz4_info {
>  
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
> +	struct inode *inode;
>  };
>  
>  struct erofs_sb_info {
> @@ -632,7 +633,8 @@ int erofs_fscache_register_fs(struct super_block *sb);
>  void erofs_fscache_unregister_fs(struct super_block *sb);
>  
>  int erofs_fscache_register_cookie(struct super_block *sb,
> -				  struct erofs_fscache **fscache, char *name);
> +				  struct erofs_fscache **fscache,
> +				  char *name, bool need_inode);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
> @@ -640,7 +642,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>  
>  static inline int erofs_fscache_register_cookie(struct super_block *sb,
>  						struct erofs_fscache **fscache,
> -						char *name)
> +						char *name, bool need_inode)
>  {
>  	return -EOPNOTSUPP;
>  }
> -- 
> 2.27.0
