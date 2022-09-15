Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECF5B93FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 07:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIOFnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOFnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:43:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0327CB4D;
        Wed, 14 Sep 2022 22:43:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPrVL78_1663220621;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPrVL78_1663220621)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 13:43:42 +0800
Message-ID: <c566e53c-a27a-9c5a-0b19-c55f6cf45d78@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 13:43:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 5/6] erofs: introduce a pseudo mnt to manage shared
 cookies
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-6-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220914105041.42970-6-zhujia.zj@bytedance.com>
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
> Use a pseudo mnt to manage shared cookies.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 13 +++++++++++++
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 31 +++++++++++++++++++++++++++++--
>  3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index b2100dc67cde..4e0a441afb7d 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -8,6 +8,7 @@
>  
>  static DEFINE_MUTEX(erofs_domain_list_lock);
>  static LIST_HEAD(erofs_domain_list);
> +static struct vfsmount *erofs_pseudo_mnt;
>  
>  static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
>  					     loff_t start, size_t len)
> @@ -436,6 +437,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>  		fscache_relinquish_volume(domain->volume, NULL, false);
>  		mutex_lock(&erofs_domain_list_lock);
>  		list_del(&domain->list);
> +		if (list_empty(&erofs_domain_list)) {
> +			kern_unmount(erofs_pseudo_mnt);
> +			erofs_pseudo_mnt = NULL;
> +		}
>  		mutex_unlock(&erofs_domain_list_lock);
>  		kfree(domain->domain_id);
>  		kfree(domain);
> @@ -489,6 +494,14 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>  	if (err)
>  		goto out;
>  
> +	if (!erofs_pseudo_mnt) {
> +		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
> +		if (IS_ERR(erofs_pseudo_mnt)) {
> +			err = PTR_ERR(erofs_pseudo_mnt);
> +			goto out;

Comment like "sbi->volume will be cleaned up in .kill_sb() in the error
path" is needed here. But personally I prefer the function is
self-maintained, i.e. the error path is handled locally, which is more
intuitive. The same with the error path handling I had pointed in patch 2.

> +		}
> +	}
> +
>  	domain->volume = sbi->volume;
>  	refcount_set(&domain->ref, 1);
>  	mutex_init(&domain->mutex);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5ce6889d6f1d..4dd0b545755a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -403,6 +403,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
>  }
>  
>  extern const struct super_operations erofs_sops;
> +extern struct file_system_type erofs_fs_type;
>  
>  extern const struct address_space_operations erofs_raw_access_aops;
>  extern const struct address_space_operations z_erofs_aops;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 856758ee4869..ced1d2fd6e4b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -688,6 +688,13 @@ static const struct export_operations erofs_export_ops = {
>  	.get_parent = erofs_get_parent,
>  };
>  
> +static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	static const struct tree_descr empty_descr = {""};
> +
> +	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
> +}
> +
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> @@ -789,6 +796,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	return 0;
>  }
>  
> +static int erofs_fc_anon_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
> +}
> +
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> @@ -858,10 +870,20 @@ static const struct fs_context_operations erofs_context_ops = {
>  	.free		= erofs_fc_free,
>  };
>  
> +static const struct fs_context_operations erofs_anon_context_ops = {
> +	.get_tree       = erofs_fc_anon_get_tree,
> +};
> +
>  static int erofs_init_fs_context(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	struct erofs_fs_context *ctx;
> +
> +	if (fc->sb_flags & SB_KERNMOUNT) {
> +		fc->ops = &erofs_anon_context_ops;
> +		return 0;
> +	}
>  
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
> @@ -888,6 +910,11 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
> +	if (sb->s_flags & SB_KERNMOUNT) {
> +		kill_litter_super(sb);
> +		return;
> +	}
> +
>  	if (erofs_is_fscache_mode(sb))
>  		kill_anon_super(sb);
>  	else
> @@ -923,7 +950,7 @@ static void erofs_put_super(struct super_block *sb)
>  	sbi->s_fscache = NULL;
>  }
>  
> -static struct file_system_type erofs_fs_type = {
> +struct file_system_type erofs_fs_type = {
>  	.owner          = THIS_MODULE,
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,

-- 
Thanks,
Jingbo
