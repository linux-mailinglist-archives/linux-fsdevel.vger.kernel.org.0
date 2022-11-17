Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB31862D246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 05:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiKQEYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 23:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiKQEYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:24:46 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FAB5C740;
        Wed, 16 Nov 2022 20:24:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VV-VtWS_1668659080;
Received: from 30.221.128.178(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VV-VtWS_1668659080)
          by smtp.aliyun-inc.com;
          Thu, 17 Nov 2022 12:24:42 +0800
Message-ID: <c529ee21-699d-dfc8-5f7d-2597fa00796d@linux.alibaba.com>
Date:   Thu, 17 Nov 2022 12:24:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
 <20221116104502.107431-1-jefflexu@linux.alibaba.com>
 <20221116104502.107431-2-jefflexu@linux.alibaba.com>
 <2968419.1668606101@warthog.procyon.org.uk>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2968419.1668606101@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/16/22 9:41 PM, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
>>> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
>>> +					loff_t *_start, size_t *_len,
>>> +					unsigned long *_flags, loff_t i_size)
>>
>> _start is never changed, so it should be passed by value instead of by
>> pointer.
> 
> Hmmm.  The intention was that the start pointer should be able to be moved
> backwards by the cache - but that's not necessary in ->prepare_read() and
> ->expand_readahead() is provided for that now.  So yes, the start pointer
> shouldn't get changed at this point.

Okay.


> 
>> I'd also reverse the position of the arguments for _flags and i_size.
>> Otherwise, the CPU/compiler have to shuffle things around more in
>> cachefiles_prepare_ondemand_read before they call this.
> 
> Better to pass the flags in and then ignore them.  That way it can tail call,
> or just call cachefiles_do_prepare_read() directly from erofs.  If you're
> going to have a wrapper, then you might be just as well create a
> netfs_io_subrequest struct on the stack.

I would prefer letting cachefiles_prepare_ondemand_read() pass flags in
and then tail call cachefiles_do_prepare_read() directly.

Many thanks for the suggestion.


-- 
Thanks,
Jingbo
