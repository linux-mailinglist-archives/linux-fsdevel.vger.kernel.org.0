Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41CF4B95A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 02:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiBQBtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 20:49:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBQBtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:49:49 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B2DB48C;
        Wed, 16 Feb 2022 17:49:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V4fQwYM_1645062566;
Received: from 30.225.24.49(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4fQwYM_1645062566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 09:49:27 +0800
Message-ID: <a3da9289-665d-ea37-5ab9-b97b883f694f@linux.alibaba.com>
Date:   Thu, 17 Feb 2022 09:49:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v4 05/23] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <20220215111335.123528-1-jefflexu@linux.alibaba.com>
 <YgzWkhXCnlNDADvb@kroah.com>
 <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
 <Yg0421B10PPwunI+@kroah.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yg0421B10PPwunI+@kroah.com>
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



On 2/17/22 1:48 AM, Greg KH wrote:
> On Wed, Feb 16, 2022 at 08:49:35PM +0800, JeffleXu wrote:
>>>> +struct cachefiles_req_in {
>>>> +	uint64_t id;
>>>> +	uint64_t off;
>>>> +	uint64_t len;
>>>
>>> For structures that cross the user/kernel boundry, you have to use the
>>> correct types.  For this it would be __u64.
>>
>> OK I will change to __xx style in the next version.
>>
>> By the way, I can't understand the disadvantage of uintxx_t style.
> 
> The "uint*" types are not valid kernel types.  They are userspace types
> and do not transfer properly in all arches and situations when crossing
> the user/kernel boundry.  They are also in a different C "namespace", so
> should not even be used in kernel code, although a lot of people do
> because they are used to writing userspace C code :(

OK. "uint*" types are defined in ISO C library, while it seems that
linux kernel doesn't expect any C library [1].

[1] https://kernelnewbies.org/FAQ/LibraryFunctionsInKernel

Thanks for explaining it.

-- 
Thanks,
Jeffle
