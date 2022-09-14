Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22875B7F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiINDCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiINDC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:02:28 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FCB6BD60;
        Tue, 13 Sep 2022 20:02:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPlAizs_1663124541;
Received: from 30.221.129.214(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPlAizs_1663124541)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 11:02:22 +0800
Message-ID: <56b0a8c1-94ce-3219-6b43-d91d2e0e85b5@linux.alibaba.com>
Date:   Wed, 14 Sep 2022 11:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 2/5] erofs: introduce fscache-based domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-3-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/2/22 6:53 PM, Jia Zhu wrote:

>  int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode)
> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>  	char *name;
>  	int ret = 0;
>  
> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> +	name = kasprintf(GFP_KERNEL, "erofs,%s",
> +			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
>  	if (!name)
>  		return -ENOMEM;
>  

What if domain_id and fsid has the same value?

How about the format "erofs,<domain_id>,<fsid>"? While in the
non-share-domain mode, is the format like "erofs,,<fsid>" or the default
"erofs,<fsid>"?


-- 
Thanks,
Jingbo
