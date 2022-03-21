Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AB4E2A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiCUOZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiCUOXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:23:08 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88201AF51C;
        Mon, 21 Mar 2022 07:17:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7rRN9d_1647872182;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7rRN9d_1647872182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 22:16:23 +0800
Message-ID: <eb558006-e5f2-59fe-9c58-844c6deff4dd@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 22:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
References: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <1027872.1647869684@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1027872.1647869684@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thanks for reviewing.


On 3/21/22 9:34 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Fscache/cachefiles used to serve as a local cache for remote fs. This
>> patch, along with the following patches, introduces a new on-demand read
>> mode for cachefiles, which can boost the scenario where on-demand read
>> semantics is needed, e.g. container image distribution.
>>
>> The essential difference between the original mode and on-demand read
>> mode is that, in the original mode, when cache miss, netfs itself will
>> fetch data from remote, and then write the fetched data into cache file.
>> While in on-demand read mode, a user daemon is responsible for fetching
>> data and then writing to the cache file.
>>
>> This patch only adds the command to enable on-demand read mode. An optional
>> parameter to "bind" command is added. On-demand mode will be turned on when
>> this optional argument matches "ondemand" exactly, i.e.  "bind
>> ondemand". Otherwise cachefiles will keep working in the original mode.
> 
> You're not really adding a command, per se.  Also, I would recommend
> starting the paragraph with a verb.  How about:
> 
> 	Make it possible to enable on-demand read mode by adding an
> 	optional parameter to the "bind" command.  On-demand mode will be
> 	turned on when this parameter is "ondemand", i.e. "bind ondemand".
> 	Otherwise cachefiles will work in the original mode.
> 
> Also, I'd add a note something like the following:
> 
> 	This is implemented as a variation on the bind command so that it
> 	can't be turned on accidentally in /etc/cachefilesd.conf when
> 	cachefilesd isn't expecting it.	

Alright, looks much better :)

> 
>> The following patches will implement the data plane of on-demand read
>> mode.
> 
> I would remove this line.  If ondemand mode is not fully implemented in
> cachefiles at this point, I would be tempted to move this to the end of the
> cachefiles subset of the patchset.  That said, I'm not sure it can be made
> to do anything much before that point.


Alright.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache)
>> +{
>> +	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
>> +	rwlock_init(&cache->reqs_lock);
>> +}
> 
> Just merge that into the caller.
> 
>> +static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache)
>> +{
>> +	xa_destroy(&cache->reqs);
>> +}
> 
> Ditto.
> 
>> +static inline
>> +bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
>> +{
>> +	if (!strcmp(args, "ondemand")) {
>> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> ...
>> +	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
>> +		pr_err("'bind' command doesn't take an argument\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> I would merge these together, I think, and say something like "Ondemand
> mode not enabled in kernel" if CONFIG_CACHEFILES_ONDEMAND=n.
> 

The reason why I extract all these logic into small sized function is
that, the **callers** can call cachefiles_ondemand_daemon_bind()
directly without any clause like:

```
#ifdef CONFIG_CACHEFILES_ONDEMAND
	...
#else
	...
```



Another choice is like

```
if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND))
	...
else
	...
```


-- 
Thanks,
Jeffle
