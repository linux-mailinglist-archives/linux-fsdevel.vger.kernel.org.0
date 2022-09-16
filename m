Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6A5BA4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 04:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIPC5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 22:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIPC5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:57:24 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454C9C1F7;
        Thu, 15 Sep 2022 19:57:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPv9JoO_1663297022;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPv9JoO_1663297022)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 10:57:03 +0800
Message-ID: <1c2d28ba-bf4e-cef8-daf8-dc11813b0c4d@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 10:57:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 3/6] erofs: introduce fscache-based domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-4-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-4-zhujia.zj@bytedance.com>
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

>  struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>  						     char *name, bool need_inode)
>  {
> @@ -481,27 +578,18 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  int erofs_fscache_register_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct fscache_volume *volume;
>  	struct erofs_fscache *fscache;
> -	char *name;
> -	int ret = 0;
> -
> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> -	if (!name)
> -		return -ENOMEM;
> -
> -	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> -	if (IS_ERR_OR_NULL(volume)) {
> -		erofs_err(sb, "failed to register volume for %s", name);
> -		kfree(name);
> -		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -	}
> +	int ret;
>  
> -	sbi->volume = volume;
> -	kfree(name);
> +	if (sbi->opt.domain_id)
> +		ret = erofs_fscache_register_domain(sb);
> +	else
> +		ret = erofs_fscache_register_volume(sb);
> +	if (ret)
> +		return ret;
>  
> +	/* acquired domain/volume will be relinquished in kill_sb() if error occurs */

"... in kill_sb() on error" is better to make this line within 80 chars
length.


>  	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> -	/* acquired volume will be relinquished in kill_sb() */
>  	if (IS_ERR(fscache))
>  		return PTR_ERR(fscache);
>  


-- 
Thanks,
Jingbo
