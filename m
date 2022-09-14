Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED045B88FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiINNVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiINNVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:21:12 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333594E637;
        Wed, 14 Sep 2022 06:21:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPolzOB_1663161664;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VPolzOB_1663161664)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 21:21:06 +0800
Date:   Wed, 14 Sep 2022 21:21:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
Subject: Re: [PATCH V3 4/6] erofs: introduce fscache-based domain
Message-ID: <YyHVQGftl/0Bf4kW@B-P7TQMD6M-0146.lan>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-5-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914105041.42970-5-zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:50:39PM +0800, Jia Zhu wrote:
> A new fscache-based shared domain mode is going to be introduced for
> erofs. In which case, same data blobs in same domain will be shared
> and reused to reduce on-disk space usage.
> 
> As the first step, we use pseudo mnt to manage and maintain domain's
> lifecycle.
> 
> The implementation of sharing blobs will be introduced in subsequent
> patches.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 134 ++++++++++++++++++++++++++++++++++++++------
>  fs/erofs/internal.h |   9 +++
>  2 files changed, 127 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 4159cf781924..b2100dc67cde 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2022, Alibaba Cloud
> + * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>   */
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +static DEFINE_MUTEX(erofs_domain_list_lock);
> +static LIST_HEAD(erofs_domain_list);
> +
>  static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
>  					     loff_t start, size_t len)
>  {
> @@ -417,6 +421,106 @@ const struct address_space_operations erofs_fscache_access_aops = {
>  	.readahead = erofs_fscache_readahead,
>  };
>  
> +static
> +struct erofs_domain *erofs_fscache_domain_get(struct erofs_domain *domain)
> +{
> +	refcount_inc(&domain->ref);
> +	return domain;
> +}

We can just open-code that.

> +
> +static void erofs_fscache_domain_put(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	if (refcount_dec_and_test(&domain->ref)) {
> +		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_lock(&erofs_domain_list_lock);
> +		list_del(&domain->list);
> +		mutex_unlock(&erofs_domain_list_lock);
> +		kfree(domain->domain_id);
> +		kfree(domain);
> +	}
> +}
> +
> +static int erofs_fscache_register_volume(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	char *domain_id = sbi->opt.domain_id;
> +	struct fscache_volume *volume;
> +	char *name;
> +	int ret = 0;
> +
> +	if (domain_id)
> +		name = kasprintf(GFP_KERNEL, "erofs,%s", domain_id);
> +	else
> +		name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);

I think we could just use

	name = kasprintf(GFP_KERNEL, "erofs,%s",
			 domain_id ? domain_id : sbi->opt.fsid);

here.

> +	if (!name)
> +		return -ENOMEM;
> +
> +	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> +	if (IS_ERR_OR_NULL(volume)) {
> +		erofs_err(sb, "failed to register volume for %s", name);
> +		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> +		volume = NULL;
> +	}
> +
> +	sbi->volume = volume;
> +	kfree(name);
> +	return ret;
> +}
> +
> +static int erofs_fscache_init_domain(struct super_block *sb)
> +{
> +	int err;
> +	struct erofs_domain *domain;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
> +	if (!domain->domain_id) {
> +		kfree(domain);
> +		return -ENOMEM;
> +	}
> +	sbi->domain = domain;
> +	err = erofs_fscache_register_volume(sb);
> +	if (err)
> +		goto out;
> +
> +	domain->volume = sbi->volume;
> +	refcount_set(&domain->ref, 1);
> +	mutex_init(&domain->mutex);
> +	list_add(&domain->list, &erofs_domain_list);
> +	return 0;
> +out:
> +	kfree(domain->domain_id);
> +	kfree(domain);
> +	sbi->domain = NULL;
> +	return err;
> +}
> +
> +static int erofs_fscache_register_domain(struct super_block *sb)
> +{
> +	int err;
> +	struct erofs_domain *domain;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	mutex_lock(&erofs_domain_list_lock);
> +	list_for_each_entry(domain, &erofs_domain_list, list) {
> +		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
> +			sbi->domain = erofs_fscache_domain_get(domain);
> +			sbi->volume = domain->volume;
> +			mutex_unlock(&erofs_domain_list_lock);
> +			return 0;
> +		}
> +	}
> +	err = erofs_fscache_init_domain(sb);

why introduce erofs_fscache_init_domain?

> +	mutex_unlock(&erofs_domain_list_lock);
> +	return err;
> +}
> +
>  struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>  						     char *name, bool need_inode)
>  {
> @@ -486,24 +590,16 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  int erofs_fscache_register_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct fscache_volume *volume;
>  	struct erofs_fscache *fscache;
> -	char *name;
> -	int ret = 0;
> +	int ret;
>  
> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> -	if (!name)
> -		return -ENOMEM;
> +	if (sbi->opt.domain_id)
> +		ret = erofs_fscache_register_domain(sb);
> +	else
> +		ret = erofs_fscache_register_volume(sb);
>  
> -	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> -	if (IS_ERR_OR_NULL(volume)) {
> -		erofs_err(sb, "failed to register volume for %s", name);
> -		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -		volume = NULL;
> -	}
> -
> -	sbi->volume = volume;
> -	kfree(name);
> +	if (ret)
> +		return ret;
>  
>  	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
>  	if (IS_ERR(fscache))
> @@ -518,7 +614,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
>  	erofs_fscache_unregister_cookie(sbi->s_fscache);
> -	fscache_relinquish_volume(sbi->volume, NULL, false);
>  	sbi->s_fscache = NULL;
> +
> +	if (sbi->domain)
> +		erofs_fscache_domain_put(sbi->domain);
> +	else
> +		fscache_relinquish_volume(sbi->volume, NULL, false);
> +

How about using one helper and pass in sb directly instead?

Thanks,
Gao Xiang
