Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DD5BA471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 04:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIPCCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 22:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIPCCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:02:40 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BE546D9B;
        Thu, 15 Sep 2022 19:02:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPuphHW_1663293726;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPuphHW_1663293726)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 10:02:07 +0800
Message-ID: <cf7c0f78-abaa-de56-3809-17c510018ed5@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 10:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 2/6] erofs: code clean up for fscache
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-3-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-3-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/15/22 8:42 PM, Jia Zhu wrote:

> @@ -502,12 +493,19 @@ int erofs_fscache_register_fs(struct super_block *sb)
>  	volume = fscache_acquire_volume(name, NULL, NULL, 0);
>  	if (IS_ERR_OR_NULL(volume)) {
>  		erofs_err(sb, "failed to register volume for %s", name);
> -		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -		volume = NULL;
> +		kfree(name);
> +		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
>  	}
>  
>  	sbi->volume = volume;
>  	kfree(name);
> +
> +	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> +	/* acquired volume will be relinquished in kill_sb() */
> +	if (IS_ERR(fscache))
> +		return PTR_ERR(fscache);
> +
> +	sbi->s_fscache = fscache;
>  	return ret;

The local variable "ret" is not used in this case.


> @@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
>  	kfree(sbi);
> @@ -909,7 +904,8 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> +	erofs_fscache_unregister_fs(sb);

> +	sbi->s_fscache = NULL;

This line is not needed since we already call
erofs_fscache_unregister_fs() here.


With these fixed:
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
