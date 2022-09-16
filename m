Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE15BA515
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIPDTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPDTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:19:08 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710ED356F2;
        Thu, 15 Sep 2022 20:19:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPvGrTJ_1663298342;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPvGrTJ_1663298342)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 11:19:03 +0800
Message-ID: <6a716712-4a82-32d7-ddcd-3252f69c6454@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 11:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 4/6] erofs: introduce a pseudo mnt to manage shared
 cookies
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-5-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-5-zhujia.zj@bytedance.com>
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

>  static int erofs_init_fs_context(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	struct erofs_fs_context *ctx;
> +

We'd better add a simple comment here:

+	/* pseudo mount for anon inodes */
> +	if (fc->sb_flags & SB_KERNMOUNT) {
> +		fc->ops = &erofs_anon_context_ops;
> +		return 0;
> +	}

which will be more friendly to those not familiar with the background.

>  
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
> @@ -874,6 +896,11 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
> +	if (sb->s_flags & SB_KERNMOUNT) {
> +		kill_litter_super(sb);

I think kill_anon_super() is enough. At least in our case, there's only
one root dentry inside the anon super and thus d_genocide() is actually
a noop.


Otherwise LGTM.
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
