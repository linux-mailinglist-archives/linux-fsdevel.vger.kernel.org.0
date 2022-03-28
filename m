Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173C4E8C74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 05:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiC1DNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 23:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiC1DN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:13:29 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA83135A97;
        Sun, 27 Mar 2022 20:11:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8Kie8j_1648437104;
Received: from 30.225.24.93(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8Kie8j_1648437104)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 11:11:46 +0800
Message-ID: <f1455f47-dbeb-46cb-69bd-5edf193f69fe@linux.alibaba.com>
Date:   Mon, 28 Mar 2022 11:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v6 12/22] erofs: add cookie context helper functions
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-13-jefflexu@linux.alibaba.com>
 <Yj3GlpvjL3u0RTjN@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yj3GlpvjL3u0RTjN@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/25/22 9:41 PM, Gao Xiang wrote:
> Hi Jeffle,
> 
> On Fri, Mar 25, 2022 at 08:22:13PM +0800, Jeffle Xu wrote:
>> Introduce "struct erofs_fscache" for managing cookie for backinig file,
>> and helper functions for initializing and cleaning up this context
>> structure.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/internal.h | 14 +++++++++++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 08cf570a0810..73235fd43bf6 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -7,6 +7,67 @@
>>  
>>  static struct fscache_volume *volume;
>>  
>> +static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
>> +{
>> +	struct fscache_cookie *cookie;
>> +
>> +	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
>> +					path, strlen(path),
>> +					NULL, 0, 0);
> 
> It'd be better to rearrange in one line?

Sure.

> 
> 					path, strlen(path), NULL, 0, 0);
> 
>> +	if (!cookie)
>> +		return -EINVAL;
>> +
>> +	fscache_use_cookie(cookie, false);
>> +	ctx->cookie = cookie;
>> +	return 0;
>> +}
>> +
>> +static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
>> +{
>> +	struct fscache_cookie *cookie = ctx->cookie;
>> +
>> +	fscache_unuse_cookie(cookie, NULL, NULL);
>> +	fscache_relinquish_cookie(cookie, false);
>> +	ctx->cookie = NULL;
>> +}
>> +
>> +/*
>> + * erofs_fscache_get - create an fscache context for blob file
>> + * @sb:		superblock
>> + * @path:	name of blob file
>> + *
>> + * Return: fscache context on success, ERR_PTR() on failure.
>> + */
>> +struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
> 
> erofs_fscache_register?

OK.


> 
>> +{
>> +	struct erofs_fscache *ctx;
>> +	int ret;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = erofs_fscache_init_cookie(ctx, path);
> 
> Can we fold it here? No need to introduce such simple wrapper..
> 
>> +	if (ret) {
>> +		erofs_err(sb, "failed to init cookie");
> 
> It would be better to print the path?

OK.

> 
>> +		goto err;
> 
> 		kfree(ctx);
> 		return ERR_PTR(ret);
> 
> At least for now.

Yeah, it's better.

> 
>> +	}
>> +
>> +	return ctx;
>> +err:
>> +	kfree(ctx);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +void erofs_fscache_put(struct erofs_fscache *ctx)
> 
> erofs_fscache_unregister?

OK.

> 
>> +{
>> +	if (!ctx)
>> +		return;
>> +
>> +	erofs_fscache_cleanup_cookie(ctx);
> 
> Fold it too, since such helper doesn't simplify code a lot but need
> to take one more time to redirect..

OK.

-- 
Thanks,
Jeffle
