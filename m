Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6D4E4C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 06:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiCWFee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 01:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCWFed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:34:33 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09104F7F;
        Tue, 22 Mar 2022 22:33:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7zuNYS_1648013577;
Received: from 30.225.24.115(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7zuNYS_1648013577)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 13:32:58 +0800
Message-ID: <8f93abf9-2c3e-51cd-9afa-ee2b68e61a4b@linux.alibaba.com>
Date:   Wed, 23 Mar 2022 13:32:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
References: <YjiX5oXYkmN6WrA3@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
 <1035025.1647876652@warthog.procyon.org.uk>
 <YjoBpm8mUHX/w/rK@casper.infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjoBpm8mUHX/w/rK@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/23/22 1:04 AM, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 03:30:52PM +0000, David Howells wrote:
>> Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> Absolutely; just use xa_lock() to protect both setting & testing the
>>> flag.
>>
>> How should Jeffle deal with xarray dropping the lock internally in order to do
>> an allocation and then taking it again (actually in patch 5)?
> 
> There are a number of ways to handle this.  I'll outline two; others
> are surely possible.

Thanks.


> 
> option 1:
> 
> add side:
> 
> xa_lock();
> if (!DEAD)
> 	xa_store(GFP_KERNEL);
> 	if (DEAD)
> 		xa_erase();
> xa_unlock();
> 
> destroy side:
> 
> xa_lock();
> set DEAD;
> xa_for_each()
> 	xa_erase();
> xa_unlock();
> 
> That has the problem (?) that it might be temporarily possible to see
> a newly-added entry in a DEAD array.

I think this problem doesn't matter in our scenario.


> 
> If that is a problem, you can use xa_reserve() on the add side, followed
> by overwriting it or removing it, depending on the state of the DEAD flag.

Right. Then even the normal path (when memory allocation succeeds) needs
to call xa_reserve() once.


> 
> If you really want to, you can decompose the add side so that you always
> check the DEAD flag before doing the store, ie:
> 
> do {
> 	xas_lock();
> 	if (DEAD)
> 		xas_set_error(-EINVAL);
> 	else
> 		xas_store();
> 	xas_unlock();
> } while (xas_nomem(GFP_KERNEL));

This way is more cleaner from the locking semantics, with the cost of
code duplication. However, after decomposing the __xa_alloc(), we can
also reuse the xas when setting CACHEFILES_REQ_NEW mark.

```
+	xa_lock(xa);
+	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (!ret)
+		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
+	xa_unlock(xa);
```

So far personally I prefer the decomposing way in our scenario.


-- 
Thanks,
Jeffle
