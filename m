Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DE50A3BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380956AbiDUPOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiDUPOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:14:41 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60BB427E3;
        Thu, 21 Apr 2022 08:11:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAg.y.s_1650553903;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAg.y.s_1650553903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 23:11:45 +0800
Message-ID: <a79e09a0-16d2-4d73-af9f-05a259431040@linux.alibaba.com>
Date:   Thu, 21 Apr 2022 23:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 06/21] cachefiles: enable on-demand read mode
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
References: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1445691.1650550659@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1445691.1650550659@warthog.procyon.org.uk>
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



On 4/21/22 10:17 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
>> +	    !strcmp(args, "ondemand")) {
>> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
>> +	} else if (*args) {
>> +		pr_err("'bind' command doesn't take an argument\n");
> 
> The error message isn't true if CONFIG_CACHEFILES_ONDEMAND=y.  It would be
> better to say "Invalid argument to the 'bind' command".

Right. Or users may gets confused then. Will be fixed in the next version.

> 
>> -retry:
>>  	/* If the caller asked us to seek for data before doing the read, then
>>  	 * we should do that now.  If we find a gap, we fill it with zeros.
>>  	 */
>> @@ -120,16 +119,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
>>  			if (read_hole == NETFS_READ_HOLE_FAIL)
>>  				goto presubmission_error;
>>  
>> -			if (read_hole == NETFS_READ_HOLE_ONDEMAND) {
>> -				ret = cachefiles_ondemand_read(object, off, len);
>> -				if (ret)
>> -					goto presubmission_error;
>> -
>> -				/* fail the read if no progress achieved */
>> -				read_hole = NETFS_READ_HOLE_FAIL;
>> -				goto retry;
>> -			}
>> -
> 

Sorry, it's my mistake when doing "git rebase". The previous version
(v8) actually calls cachefiles_ondemand_read() in cachefiles_read().
However as explained in the commit message of patch 5 ("cachefiles:
implement on-demand read"), fscache_read() can only detect if the
requested file range is fully cache miss, whilst it can't detect if it
is partial cache miss, i.e. there's a hole inside the requested file range.

Thus in this patchset (v9), we move the entry of calling
cachefiles_ondemand_read() from cachefiles_read() to
cachefiles_prepare_read(). The above "deletion of newly added code" is
actually reverting the previous change to cachefiles_read(). It was
mistakenly merged to this patch when I was doing "git rebase"...
Actually it should be merged to patch 5 ("cachefiles: implement
on-demand read"), which initially introduce the change to cachefiles_read().

Apologize for the careless mistake...


-- 
Thanks,
Jeffle
