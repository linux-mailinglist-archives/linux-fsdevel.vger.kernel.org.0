Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1349619625
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 13:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiKDMWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiKDMWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:22:54 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B42D1F6;
        Fri,  4 Nov 2022 05:22:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTxEyHi_1667564569;
Received: from 30.221.128.121(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTxEyHi_1667564569)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 20:22:50 +0800
Message-ID: <71907c21-bd3f-81a1-86d6-a757e4484be2@linux.alibaba.com>
Date:   Fri, 4 Nov 2022 20:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
 <20221104072637.72375-2-jefflexu@linux.alibaba.com>
 <c0d893bf6f52702a0bd2056a8cb005861b8324ea.camel@kernel.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <c0d893bf6f52702a0bd2056a8cb005861b8324ea.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/4/22 7:18 PM, Jeff Layton wrote:
> On Fri, 2022-11-04 at 15:26 +0800, Jingbo Xu wrote:
>> Add prepare_ondemand_read() callback dedicated for the on-demand read
>> scenario, so that callers from this scenario can be decoupled from
>> netfs_io_subrequest.
>>
>> To reuse the hole detecting logic as mush as possible, both the
>> implementation of prepare_read() and prepare_ondemand_read() inside
>> Cachefiles call a common routine.
>>
>> In the near future, prepare_read() will get enhanced and more
>> information will be needed and then returned to callers. Thus
>> netfs_io_subrequest is a reasonable candidate for holding places for all
>> these information needed in the internal implementation.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/cachefiles/io.c                | 42 +++++++++++++++++++++++++------
>>  include/linux/netfs.h             |  7 ++++++
>>  include/trace/events/cachefiles.h |  4 +--
>>  3 files changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
>> index 000a28f46e59..6427259fcba9 100644
>> --- a/fs/cachefiles/io.c
>> +++ b/fs/cachefiles/io.c
>> @@ -385,16 +385,11 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
>>  				  term_func, term_func_priv);
>>  }
>>  
>> -/*
>> - * Prepare a read operation, shortening it to a cached/uncached
>> - * boundary as appropriate.
>> - */
>> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
>> -						      loff_t i_size)
>> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_io_subrequest *subreq,
>> +						       struct netfs_cache_resources *cres,
>> +						       loff_t i_size)
>>  {
>>  	enum cachefiles_prepare_read_trace why;
>> -	struct netfs_io_request *rreq = subreq->rreq;
>> -	struct netfs_cache_resources *cres = &rreq->cache_resources;
>>  	struct cachefiles_object *object;
>>  	struct cachefiles_cache *cache;
>>  	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
>> @@ -501,6 +496,36 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Prepare a read operation, shortening it to a cached/uncached
>> + * boundary as appropriate.
>> + */
>> +static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
>> +						      loff_t i_size)
>> +{
>> +	return cachefiles_do_prepare_read(subreq,
>> +			&subreq->rreq->cache_resources, i_size);
>> +}
>> +
>> +/*
>> + * Prepare an on-demand read operation, shortening it to a cached/uncached
>> + * boundary as appropriate.
>> + */
>> +static enum netfs_io_source cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
>> +		loff_t start, size_t *_len, loff_t i_size)
>> +{
>> +	enum netfs_io_source source;
>> +	struct netfs_io_subrequest subreq = {
>> +		.start	= start,
>> +		.len	= *_len,
>> +		.flags	= 1 << NETFS_SREQ_ONDEMAND,
>> +	};
>> +
> 
> Faking up a struct like this is sort of fragile. What if we change
> cachefiles_do_prepare_read to consult other fields in this structure
> later?

Indeed it's not robust somehow.


> 
> It might be best to have cachefiles_do_prepare_read take individual
> start, len, and flags values instead of doing this.
> 

I will give it a try if nobody objects this.


Thank you for your suggestions :)


-- 
Thanks,
Jingbo
