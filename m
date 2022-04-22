Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42FA50AE6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 05:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443689AbiDVDNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 23:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443686AbiDVDN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:13:29 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7554C789;
        Thu, 21 Apr 2022 20:10:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAk49Jj_1650597028;
Received: from 30.225.24.197(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAk49Jj_1650597028)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 11:10:30 +0800
Message-ID: <a15c3c93-3472-5bed-c8bb-4416bb809325@linux.alibaba.com>
Date:   Fri, 22 Apr 2022 11:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 08/21] cachefiles: document on-demand read mode
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
References: <20220415123614.54024-9-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447053.1650552451@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1447053.1650552451@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David, thanks for polishing the documents. It's a detailed and
meticulous review again. Really thanks for your time :) I will fix all
these in the next version.

On 4/21/22 10:47 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +The essential difference between these two modes is that, in original mode,
>> +when a cache miss occurs, the netfs will fetch the data from the remote server
>> +and then write it to the cache file.  With on-demand read mode, however,
>> +fetching the data and writing it into the cache is delegated to a user daemon.
> 
> The starting sentence seems off.  How about:
> 
>   The essential difference between these two modes is seen when a cache miss
>   occurs: In the original mode, the netfs will fetch the data from the remote
>   server and then write it to the cache file; in on-demand read mode, fetching
>   data and writing it into the cache is delegated to a user daemon.

Okay, it sounds better.

>> the devnode ('/dev/cachefiles') to check if
>> +there's a pending request to be processed.  A POLLIN event will be returned
>> +when there's a pending request.
>> +
>> +The user daemon then reads the devnode to fetch a request and process it
>> +accordingly.
> 
> Reading the devnode doesn't process the request, so I think something like:
> 
> "... and process it accordingly" -> "... that it can then process."
> 
> or:
> 
> "... and process it accordingly" -> "... to process."

Yeah the original statement is indeed misleading.


>> Each cache file has a unique object_id, while it
>> +may have multiple anonymous fds. The user daemon may duplicate anonymous fds
>> +from the initial anonymous fd indicated by the @fd field through dup(). Thus
>> +each object_id can be mapped to multiple anonymous fds, while the usr daemon
>> +itself needs to maintain the mapping.
>> +
>> +With the given anonymous fd, the user daemon can fetch data and write it to the
>> +cache file in the background, even when kernel has not triggered a cache miss
>> +yet.
>> +
>> +The user daemon should complete the READ request
> 
> READ request -> OPEN request?

Good catch. Will be fixed.


>> in the READ request.  The ioctl is of the form::
>> +
>> +	ioctl(fd, CACHEFILES_IOC_CREAD, msg_id);
>> +
>> +	* ``fd`` is one of the anonymous fds associated with the given object_id
>> +	  in the READ request.
> 
> the given object_id in the READ request -> object_id
> 
>> +
>> +	* ``msg_id`` must match the msg_id field of the previous READ request.
> 
> By "previous READ request" is this referring to something different to "the
> READ request" you mentioned against the fd parameter?

Actually it is referring to the same thing (the same READ request). I
will change the statement simply to:

``msg_id`` must match the msg_id field of the READ request.

-- 
Thanks,
Jeffle
