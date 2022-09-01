Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6409A5A8BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIADcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIADb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:31:59 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4D012A5E7;
        Wed, 31 Aug 2022 20:31:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNvAXN-_1662003112;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNvAXN-_1662003112)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:31:54 +0800
Date:   Thu, 1 Sep 2022 11:31:52 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
Subject: Re: [RFC PATCH 1/5] erofs: add 'domain_id' mount option for
 on-demand read sementics
Message-ID: <YxAnqC8pYf75epr1@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
 <20220831123125.68693-2-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831123125.68693-2-zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:31:21PM +0800, Jia Zhu wrote:
> Introduce 'domain_id' mount option to enable shared domain sementics.
> In which case, the related cookie is shared if two mountpoints in the
> same domain have the same data blob. Users could specify the name of
> domain by this mount option.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index cfee49d33b95..fe435d077f1a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -76,6 +76,7 @@ struct erofs_mount_opts {
>  #endif
>  	unsigned int mount_opt;
>  	char *fsid;
> +	char *domain_id;
>  };
>  
>  struct erofs_dev_context {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3173debeaa5a..fb5a84a07bd5 100644
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
> +		kfree(ctx->opt.domain_id);
> +		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!ctx->opt.domain_id)
> +			return -ENOMEM;
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +#else
> +		errorfc(fc, "domain_id option not supported");

Just one question, why not write as below?

#ifdef CONFIG_EROFS_FS_ONDEMAND
		kfree(ctx->opt.domain_id);
		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
		if (!ctx->opt.domain_id)
			return -ENOMEM;
#else
		errorfc(fc, "domain_id option not supported");
#endif

Thanks,
Gao Xiang

>  #endif
>  		break;
>  	default:
> @@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
>  	ctx->opt.fsid = NULL;
> +	ctx->opt.domain_id = NULL;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> @@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
>  
>  	erofs_free_dev_context(ctx->devs);
>  	kfree(ctx->opt.fsid);
> +	kfree(ctx->opt.domain_id);
>  	kfree(ctx);
>  }
>  
> @@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
> +	kfree(sbi->opt.domain_id);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
>  }
> @@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	if (opt->fsid)
>  		seq_printf(seq, ",fsid=%s", opt->fsid);
> +	if (opt->domain_id)
> +		seq_printf(seq, ",domain_id=%s", opt->domain_id);
>  #endif
>  	return 0;
>  }
> -- 
> 2.20.1
