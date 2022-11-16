Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52DD62BD84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 13:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiKPMUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 07:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKPMTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:19:50 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EFA46D;
        Wed, 16 Nov 2022 04:17:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUxx6gz_1668601073;
Received: from 30.221.128.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUxx6gz_1668601073)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 20:17:54 +0800
Message-ID: <68463af5-952b-a024-21fd-fa9e5fc37eb3@linux.alibaba.com>
Date:   Wed, 16 Nov 2022 20:17:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
 <20221116104502.107431-2-jefflexu@linux.alibaba.com>
 <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

Thanks for the comment!

On 11/16/22 7:58 PM, Jeff Layton wrote:

>>  
>> -/*
>> - * Prepare a read operation, shortening it to a cached/uncached
>> - * boundary as appropriate.
>> - */
>> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
>> -						      loff_t i_size)
>> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
>> +					loff_t *_start, size_t *_len,
>> +					unsigned long *_flags, loff_t i_size)
> 
> _start is never changed, so it should be passed by value instead of by
> pointer. 

Yeah, start is indeed unchanged, and I think it's also reasonable to
pass it by value rather than by pointer.


> I'd also reverse the position of the arguments for _flags and
> i_size.  Otherwise, the CPU/compiler have to shuffle things around more
> in cachefiles_prepare_ondemand_read before they call this.

Yeah I didn't notice the details.


I will fix the above two issues in a quick v4 version.

Many thanks for the feedback.



-- 
Thanks,
Jingbo
