Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B704E2A17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiCUONp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351573AbiCUOLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:11:09 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068749F27;
        Mon, 21 Mar 2022 07:08:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7qO7VJ_1647871727;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7qO7VJ_1647871727)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 22:08:49 +0800
Message-ID: <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 22:08:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjiAVezd5B9auhcP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/21/22 9:40 PM, Matthew Wilcox wrote:
> On Wed, Mar 16, 2022 at 09:17:04PM +0800, Jeffle Xu wrote:
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
>> +	rwlock_t			reqs_lock;	/* Lock for reqs xarray */
> 
> Why do you have a separate rwlock when the xarray already has its own
> spinlock?  This is usually a really bad idea.

Hi,

Thanks for reviewing.

reqs_lock is also used to protect the check of cache->flags. Please
refer to patch 4 [1] of this patchset.

```
+	/*
+	 * Enqueue the pending request.
+	 *
+	 * Stop enqueuing the request when daemon is dying. So we need to
+	 * 1) check cache state, and 2) enqueue request if cache is alive.
+	 *
+	 * The above two ops need to be atomic as a whole. @reqs_lock is used
+	 * here to ensure that. Otherwise, request may be enqueued after xarray
+	 * has been flushed, in which case the orphan request will never be
+	 * completed and thus netfs will hang there forever.
+	 */
+	read_lock(&cache->reqs_lock);
+
+	/* recheck dead state under lock */
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		read_unlock(&cache->reqs_lock);
+		ret = -EIO;
+		goto out;
+	}
+
+	xa_lock(xa);
+	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (!ret)
+		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
+	xa_unlock(xa);
+
+	read_unlock(&cache->reqs_lock);
```

It's mainly used to protect against the xarray flush.

Besides, IMHO read-write lock shall be more performance friendly, since
most cases are the read side.


[1] https://lkml.org/lkml/2022/3/16/351

-- 
Thanks,
Jeffle
