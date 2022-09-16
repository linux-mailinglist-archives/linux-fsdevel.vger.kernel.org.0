Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0335BA643
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 07:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIPFKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIPFKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:10:17 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A642AD8;
        Thu, 15 Sep 2022 22:10:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPvYIal_1663305011;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPvYIal_1663305011)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 13:10:12 +0800
Message-ID: <a866c880-860c-5558-e5fe-e12afd943324@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 13:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 6/6] erofs: introduce 'domain_id' mount option
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-7-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-7-zhujia.zj@bytedance.com>
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
> Introduce 'domain_id' mount option to enable shared domain sementics.
> In which case, the related cookie is shared if two mountpoints in the
> same domain have the same data blob. Users could specify the name of
> domain by this mount option.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/super.c | 17 +++++++++++++++++
>  fs/erofs/sysfs.c | 19 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 24bac58285e8..5e55c4fe6220 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -440,6 +440,7 @@ enum {
>  	Opt_dax_enum,
>  	Opt_device,
>  	Opt_fsid,
> +	Opt_domain_id,
>  	Opt_err
>  };
>  
> @@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>  	fsparam_string("device",	Opt_device),
>  	fsparam_string("fsid",		Opt_fsid),
> +	fsparam_string("domain_id",	Opt_domain_id),
>  	{}
>  };
>  
> @@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  			return -ENOMEM;
>  #else
>  		errorfc(fc, "fsid option not supported");
> +#endif
> +		break;
> +	case Opt_domain_id:
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +		kfree(ctx->opt.domain_id);
> +		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!ctx->opt.domain_id)
> +			return -ENOMEM;
> +#else
> +		errorfc(fc, "domain_id option not supported");
>  #endif
>  		break;
>  	default:
> @@ -702,6 +714,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
>  	ctx->opt.fsid = NULL;
> +	ctx->opt.domain_id = NULL;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> @@ -846,6 +859,7 @@ static void erofs_fc_free(struct fs_context *fc)
>  
>  	erofs_free_dev_context(ctx->devs);
>  	kfree(ctx->opt.fsid);
> +	kfree(ctx->opt.domain_id);
>  	kfree(ctx);
>  }
>  
> @@ -914,6 +928,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	fs_put_dax(sbi->dax_dev, NULL);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
> +	kfree(sbi->opt.domain_id);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
>  }
> @@ -1067,6 +1082,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	if (opt->fsid)
>  		seq_printf(seq, ",fsid=%s", opt->fsid);
> +	if (opt->domain_id)
> +		seq_printf(seq, ",domain_id=%s", opt->domain_id);
>  #endif
>  	return 0;
>  }
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index c1383e508bbe..341fb43ad587 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -201,12 +201,27 @@ static struct kobject erofs_feat = {
>  int erofs_register_sysfs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	char *name;
> +	char *str = NULL;
>  	int err;
>  
> +	if (erofs_is_fscache_mode(sb)) {
> +		if (sbi->opt.domain_id) {
> +			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id,
> +					sbi->opt.fsid);
> +			if (!str)
> +				return -ENOMEM;
> +			name = str;
> +		} else {
> +			name = sbi->opt.fsid;
> +		}
> +	} else {
> +		name = sb->s_id;
> +	}
>  	sbi->s_kobj.kset = &erofs_root;
>  	init_completion(&sbi->s_kobj_unregister);
> -	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
> +	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
> +	kfree(str);
>  	if (err)
>  		goto put_sb_kobj;
>  	return 0;

-- 
Thanks,
Jingbo
