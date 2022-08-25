Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2344A5A12CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiHYN7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiHYN67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:58:59 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47B29DFA5;
        Thu, 25 Aug 2022 06:58:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNDo9.X_1661435929;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNDo9.X_1661435929)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 21:58:52 +0800
Date:   Thu, 25 Aug 2022 21:58:49 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Sun Ke <sunke32@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Linux-cachefs] [PATCH v3] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Message-ID: <YweAGTuBw1hWm8PW@B-P7TQMD6M-0146.local>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
References: <20220818125038.2247720-1-sunke32@huawei.com>
 <3700079.1661336363@warthog.procyon.org.uk>
 <c6fd70dd-2b0b-ea9f-f0f8-9d727cde2718@linux.alibaba.com>
 <20220825133620.GB2071@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220825133620.GB2071@kadam>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:36:20PM +0300, Dan Carpenter wrote:
> I spent a long time looking at this as well...  It's really inscrutable
> code.  It would be more readable if we just spelled things out in the
> most pedantic way possible:
> 

Yeah, the following code looks much better. Ke, would you mind
sending a version like below instead?

Thanks,
Gao Xiang

> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..7e1586bd5cf3 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -158,9 +158,13 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  
>  	/* fail OPEN request if daemon reports an error */
>  	if (size < 0) {
> -		if (!IS_ERR_VALUE(size))
> -			size = -EINVAL;
> -		req->error = size;
> +		if (!IS_ERR_VALUE(size)) {
> +			req->error = -EINVAL;
> +			ret = -EINVAL;
> +		} else {
> +			req->error = size;
> +			ret = 0;
> +		}
>  		goto out;
>  	}
>  
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
