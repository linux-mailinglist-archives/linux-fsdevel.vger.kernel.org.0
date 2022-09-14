Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A505B892B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiINNag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINNae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:30:34 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204BD57216;
        Wed, 14 Sep 2022 06:30:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPosRE2_1663162226;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VPosRE2_1663162226)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 21:30:29 +0800
Date:   Wed, 14 Sep 2022 21:30:26 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
Subject: Re: [PATCH V3 6/6] erofs: Support sharing cookies in the same domain
Message-ID: <YyHXcuFPVtn+dzR1@B-P7TQMD6M-0146.lan>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-7-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914105041.42970-7-zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:50:41PM +0800, Jia Zhu wrote:
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

	struct erofs_domain *domain = EROFS_SB(sb)->domain;

> +
> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		return ERR_PTR(-ENOMEM);
> +	}
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

	struct erofs_domain *domain = EROFS_SB(sb)->domain;

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

		if (!ctx || ctx->domain != domain ||
		    strcmp(ctx->name, name))
			continue;
		igrab(inode);
		mutex_unlock(&erofs_domain_cookies_lock);
		return ctx;

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

	if (EROFS_SB(sb)->opt.domain_id)
		return erofs_domain_register_cookie(sb, name, need_inode);
	Return erofs_fscache_acquire_cookie(sb, name, need_inode);

Thanks,
Gao Xiang
