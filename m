Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF475B94BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOGxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOGxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:53:13 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0ED52E59;
        Wed, 14 Sep 2022 23:53:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPrhg1A_1663224787;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPrhg1A_1663224787)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 14:53:08 +0800
Message-ID: <82473542-7810-3474-3f78-b61f9927d682@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 14:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 6/6] erofs: Support sharing cookies in the same domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-7-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220914105041.42970-7-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/14/22 6:50 PM, Jia Zhu wrote:
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.
> 
> Users could specify domain_id mount option to create or join into a
> domain.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 89 +++++++++++++++++++++++++++++++++++++++++++--
>  fs/erofs/internal.h |  4 +-
>  2 files changed, 89 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 4e0a441afb7d..e9ae1ee963e2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,7 @@
>  #include "internal.h"
>  
>  static DEFINE_MUTEX(erofs_domain_list_lock);
> +static DEFINE_MUTEX(erofs_domain_cookies_lock);
>  static LIST_HEAD(erofs_domain_list);
>  static struct vfsmount *erofs_pseudo_mnt;
>  
> @@ -504,7 +505,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>  
>  	domain->volume = sbi->volume;
>  	refcount_set(&domain->ref, 1);
> -	mutex_init(&domain->mutex);

This needs to be folded into patch 4.


>  	list_add(&domain->list, &erofs_domain_list);
>  	return 0;
>  out:
> @@ -534,8 +534,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>  	return err;
>  }
>  
> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						     char *name, bool need_inode)
> +struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> +						    char *name, bool need_inode)
>  {
>  	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>  	struct erofs_fscache *ctx;
> @@ -585,13 +585,96 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>  	return ERR_PTR(ret);
>  }
>  
> +static
> +struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> +							char *name, bool need_inode)
> +{
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +
> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name)
> +		return ERR_PTR(-ENOMEM);

The previously registered erofs_fscache needs to be cleaned up in the
error path.

> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		return ERR_PTR(-ENOMEM);
> +	}

Ditto.

> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	erofs_fscache_domain_get(domain);
> +	return ctx;
> +}
> +
> +static
> +struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> +						    char *name, bool need_inode)
> +{
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
> +
> +	mutex_lock(&erofs_domain_cookies_lock);
> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> +		ctx = inode->i_private;
> +		if (!ctx)
> +			continue;
> +		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
> +			igrab(inode);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return ctx;
> +		}
> +	}
> +	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
> +	mutex_unlock(&erofs_domain_cookies_lock);
> +	return ctx;
> +}
> +
> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> +						     char *name, bool need_inode)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	if (sbi->opt.domain_id)
> +		return erofs_domain_register_cookie(sb, name, need_inode);
> +	else
> +		return erofs_fscache_acquire_cookie(sb, name, need_inode);
> +}
> +
>  void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  {
> +	struct erofs_domain *domain;
> +
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&erofs_domain_cookies_lock);
> +		/* Cookie is still in use */
> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
> +			iput(ctx->anon_inode);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return;
> +		}
> +		iput(ctx->anon_inode);
> +		kfree(ctx->name);
> +		mutex_unlock(&erofs_domain_cookies_lock);

		mutex_lock(&erofs_domain_cookies_lock);
		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
		iput(ctx->anon_inode);
		mutex_unlock(&erofs_domain_cookies_lock);

		if (!drop)
			return;
> +	}
>  >  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	ctx->cookie = NULL;

	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
	fscache_relinquish_cookie(ctx->cookie, false);
	erofs_fscache_domain_put(domain);
	kfree(ctx->name);

>  
>  	iput(ctx->inode);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4dd0b545755a..8a6f94b27a23 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -101,7 +101,6 @@ struct erofs_sb_lz4_info {
>  
>  struct erofs_domain {
>  	refcount_t ref;
> -	struct mutex mutex;
>  	struct list_head list;
>  	struct fscache_volume *volume;
>  	char *domain_id;
> @@ -110,6 +109,9 @@ struct erofs_domain {
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
>  	struct inode *inode;
> +	struct inode *anon_inode;
> +	struct erofs_domain *domain;
> +	char *name;
>  };
>  
>  struct erofs_sb_info {

-- 
Thanks,
Jingbo
