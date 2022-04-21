Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A507F50A32C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389490AbiDUOuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389393AbiDUOuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:50:22 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268A2253A;
        Thu, 21 Apr 2022 07:47:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAfplXu_1650552445;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAfplXu_1650552445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 22:47:27 +0800
Message-ID: <62301f0e-8623-80ac-b351-a1b475a7004c@linux.alibaba.com>
Date:   Thu, 21 Apr 2022 22:47:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 02/21] cachefiles: notify user daemon when looking up
 cookie
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com,
        zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1444650.1650549423@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1444650.1650549423@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Thanks for reviewing :)


On 4/21/22 9:57 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	help
>> +	  This permits on-demand read mode of cachefiles.  In this mode, when
>> +	  cache miss, the cachefiles backend instead of netfs, is responsible
>> +	  for fetching data, e.g. through user daemon.
> 
> How about:
> 
> 	help
> 	  This permits userspace to enable the cachefiles on-demand read mode.
> 	  In this mode, when a cache miss occurs, responsibility for fetching
> 	  the data lies with the cachefiles backend instead of with the netfs
> 	  and is delegated to userspace.
> 
>> +	/*
>> +	 * 1) Cache has been marked as dead state, and then 2) flush all
>> +	 * pending requests in @reqs xarray. The barrier inside set_bit()
>> +	 * will ensure that above two ops won't be reordered.
>> +	 */
> 
> What set_bit()?  

"set_bit(CACHEFILES_DEAD, &cache->flags);" in cachefiles_daemon_release()

> What "above two ops"? 

The two operations I mentioned in the comment:
1) Cache has been marked as dead state, and then
2) flush all pending requests in @reqs xarray.


> And that's not how barriers work; they


> provide a partial ordering relative to another pair of barriered ops.
> 
> Also, set_bit() can't be relied upon to imply a barrier - see
> Documentation/memory-barriers.txt.

Yeah, it seems that set_bit() doesn't imply with a memory barrier,
though the x86 implementation (arch/x86/boot/bitops.h) indeed implies a
barrier, which may misleads me. Thanks for pointing it out. Then maybe a
full barrier is needed here before flushing the @reqs xarray.

> 
>> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
>> +	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {
> 
> It might be worth abstracting this into an inline function in internal.h:
> 
> 	static inline bool cachefiles_in_ondemand_mode(cache)
> 	{
> 		return IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> 			test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)
> 	}

Okay, will be fixed in the next version.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> 
> This looks like it ought to be superfluous, given the preceding test - though
> I can see why you need it:

Sorry I can't see the context. But I guess you are referring to the
snippet of cachefiles_daemon_poll()?

```
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+		if (!xa_empty(&cache->reqs))
+			mask |= EPOLLIN;
```

Yes the implementation here is indeed not elegant enough. As you
described below, if @reqs is defined non-conditionally in struct
cachefiles_cache, then the superfluous magic here is not needed then.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
>> +	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>> +	u32				ondemand_id_next;
>> +#endif
> 
> I'm tempted to say that you should just make them non-conditional.  It's not
> like there's likely to be more than one or two cachefiles_cache structs on a
> system.

Okay, sounds reasonable.


-- 
Thanks,
Jeffle
