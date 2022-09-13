Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFE5B67E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiIMG2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 02:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIMG16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:27:58 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E1CE2B;
        Mon, 12 Sep 2022 23:27:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPduYe-_1663050471;
Received: from 30.221.130.76(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPduYe-_1663050471)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 14:27:52 +0800
Message-ID: <097a8ffb-c8b0-ed10-6c82-8a6de9bed09b@linux.alibaba.com>
Date:   Tue, 13 Sep 2022 14:27:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 5/5] erofs: support fscache based shared domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-6-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-6-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/2/22 6:53 PM, Jia Zhu wrote:
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.
> 
> Users could specify domain_id mount option to create or join into a domain.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h | 12 ++++++++
>  fs/erofs/super.c    | 10 +++++--
>  3 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 439dd3cc096a..c01845808ede 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -559,12 +559,27 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  {
>  	struct erofs_fscache *ctx = *fscache;
> +	struct erofs_domain *domain;
>  
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&domain->mutex);
> +		/* Cookie is still in use */
> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
> +			iput(ctx->anon_inode);
> +			mutex_unlock(&domain->mutex);
> +			return;
> +		}
> +		iput(ctx->anon_inode);
> +		kfree(ctx->name);
> +		mutex_unlock(&domain->mutex);
> +	}
>  
>  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	ctx->cookie = NULL;
>  
>  	iput(ctx->inode);
> @@ -609,3 +624,61 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>  	sbi->volume = NULL;
>  	sbi->domain = NULL;
>  }
> +
> +static int erofs_fscache_domain_init_cookie(struct super_block *sb,
> +		struct erofs_fscache **fscache, char *name, bool need_inode)
> +{
> +	int ret;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +
> +	ret = erofs_fscache_register_cookie(sb, &ctx, name, need_inode);
> +	if (ret)
> +		return ret;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name)
> +		return -ENOMEM;

Shall we clean up the above registered cookie in the error path?

> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		return -ENOMEM;
> +	}

Ditto.

> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	erofs_fscache_domain_get(domain);
> +	*fscache = ctx;
> +	return 0;
> +}
> +
> +int erofs_domain_register_cookie(struct super_block *sb,
> +	struct erofs_fscache **fscache, char *name, bool need_inode)
> +{
> +	int err;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
> +
> +	mutex_lock(&domain->mutex);

What is domain->mutex used for?


> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> +		ctx = inode->i_private;
> +		if (!ctx)
> +			continue;
> +		if (!strcmp(ctx->name, name)) {
> +			*fscache = ctx;
> +			igrab(inode);
> +			mutex_unlock(&domain->mutex);
> +			return 0;
> +		}
> +	}
> +	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
> +	mutex_unlock(&domain->mutex);
> +	return err;
> +}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2790c93ffb83..efa4f4ad77cc 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -110,6 +110,9 @@ struct erofs_domain {
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
>  	struct inode *inode;
> +	struct inode *anon_inode;

Why can't we reuse @inode for anon_inode?


> +	struct erofs_domain *domain;
> +	char *name;
>  };
>  
>  struct erofs_sb_info {
> @@ -625,6 +628,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
>  int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode);
> +int erofs_domain_register_cookie(struct super_block *sb,
> +				  struct erofs_fscache **fscache,
> +				  char *name, bool need_inode);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  
>  extern const struct address_space_operations erofs_fscache_access_aops;
> @@ -646,6 +652,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int erofs_domain_register_cookie(struct super_block *sb,
> +						struct erofs_fscache **fscache,
> +						char *name, bool need_inode)
> +{
> +	return -EOPNOTSUPP;
> +}
>  
>  static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 667a78f0ee70..11c5ba84567c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -245,8 +245,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  	}
>  
>  	if (erofs_is_fscache_mode(sb)) {
> -		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
> -				dif->path, false);
> +		if (sbi->opt.domain_id)
> +			ret = erofs_domain_register_cookie(sb, &dif->fscache, dif->path,
> +					false);
> +		else
> +			ret = erofs_fscache_register_cookie(sb, &dif->fscache, dif->path,
> +					false);
>  		if (ret)
>  			return ret;
>  	} else {
> @@ -726,6 +730,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			err = erofs_fscache_register_domain(sb);
>  			if (err)
>  				return err;
> +			err = erofs_domain_register_cookie(sb, &sbi->s_fscache,
> +					sbi->opt.fsid, true);
>  		} else {
>  			err = erofs_fscache_register_fs(sb);
>  			if (err)

-- 
Thanks,
Jingbo
