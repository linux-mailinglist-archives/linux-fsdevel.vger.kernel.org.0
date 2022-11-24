Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94D56370E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 04:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKXDT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 22:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKXDT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:19:56 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DCCB680;
        Wed, 23 Nov 2022 19:19:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVZ9.-D_1669259990;
Received: from 30.221.132.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVZ9.-D_1669259990)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 11:19:51 +0800
Message-ID: <25cfb176-ff2d-36e5-d12e-a2413ad2d5c2@linux.alibaba.com>
Date:   Thu, 24 Nov 2022 11:19:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     xiang@kernel.org, chao@kernel.org, jlayton@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221117053017.21074-2-jefflexu@linux.alibaba.com>
 <20221117053017.21074-1-jefflexu@linux.alibaba.com>
 <1609247.1669221883@warthog.procyon.org.uk>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <1609247.1669221883@warthog.procyon.org.uk>
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

Hi David,

Really thanks for the comment.

On 11/24/22 12:44 AM, David Howells wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> -/*
>> - * Prepare a read operation, shortening it to a cached/uncached
>> - * boundary as appropriate.
>> - */
>> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
>> -						      loff_t i_size)
>> +static inline enum netfs_io_source
>> +cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
>> +			   loff_t start, size_t *_len, loff_t i_size,
>> +			   unsigned long *_flags)
> 
> That's not exactly what I meant, but I guess it would work as the compiler
> would probably inline it into both callers.

Yeah, I just have no better way if we don't want another function
calling introduced by this patch.  If we keep cachefiles_prepare_read()
untouched, the on-demand users need to construct a temporary subrequest
on the stack, and Jeff pointed out that this way is somewhat fragile and
not robust enough.

Anyway I would keep moving forward in the direction of current patch,
and add back the netfs_inode number to the tracepoint.  I would send v5
soon.

Thanks again for the reply :-)

> 
>> -		      __entry->netfs_inode, __entry->cache_inode)
>> +		      __entry->cache_inode)
> 
> Can you not lose the netfs_inode number from the tracepoint, please?  Feel
> free to display 0 there for your purposes.
> 

Sure.


-- 
Thanks,
Jingbo
