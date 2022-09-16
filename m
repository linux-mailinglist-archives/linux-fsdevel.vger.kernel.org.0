Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E65BA588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIPDpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIPDpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:45:18 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F052444;
        Thu, 15 Sep 2022 20:45:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPvH1tx_1663299912;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPvH1tx_1663299912)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 11:45:14 +0800
Message-ID: <1ccf326e-dd47-d5cf-02ab-5f033892a7d4@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 11:45:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 5/6] erofs: Support sharing cookies in the same domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-6-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-6-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/15/22 8:42 PM, Jia Zhu wrote:

> +static
> +struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> +							char *name, bool need_inode)
> +{
> +	int err;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> +
> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	refcount_inc(&domain->ref);
> +	return ctx;
> +out:
> +	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> +	fscache_relinquish_cookie(ctx->cookie, false);
> +	if (need_inode)
> +		iput(ctx->inode);
> +	kfree(ctx);
> +	return ERR_PTR(err);

Could you please abstract the cleanup logic into one helper? like:

erofs_fscache_relinquish_cookie()
{
	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
	fscache_relinquish_cookie(ctx->cookie, false);
	iput(ctx->inode);
	kfree(ctx->name);
	kfree(ctx);
}

which could also be called in erofs_fscache_unregister_cookie().


>  void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  {
> +	bool drop;
> +	struct erofs_domain *domain;
> +
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&erofs_domain_cookies_lock);
> +		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
> +		iput(ctx->anon_inode);
> +		mutex_unlock(&erofs_domain_cookies_lock);
> +		if (!drop)
> +			return;
> +	}
>  
>  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	iput(ctx->inode);
> +	kfree(ctx->name);
>  	kfree(ctx);
>  }


-- 
Thanks,
Jingbo
