Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61C8736252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 05:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFTDu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 23:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjFTDuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:50:20 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298D10F3;
        Mon, 19 Jun 2023 20:50:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vla3ivZ_1687233008;
Received: from 30.221.149.68(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vla3ivZ_1687233008)
          by smtp.aliyun-inc.com;
          Tue, 20 Jun 2023 11:50:09 +0800
Message-ID: <067578f0-9e3a-e2cf-f7c8-ff7eeda2694a@linux.alibaba.com>
Date:   Tue, 20 Jun 2023 11:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap
 in error path
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        gerry@linux.alibaba.com, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
References: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
 <ZHeoIFrp303f0E8d@redhat.com>
 <33fd8e03-7c99-c12d-255d-b7190612379b@linux.alibaba.com>
 <ZHiE2zkFJKBl9GZ+@redhat.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZHiE2zkFJKBl9GZ+@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/1/23 7:45 PM, Vivek Goyal wrote:
> On Thu, Jun 01, 2023 at 09:45:52AM +0800, Jingbo Xu wrote:
>>
>>
>> On 6/1/23 4:03 AM, Vivek Goyal wrote:
>>> On Mon, Apr 24, 2023 at 08:32:50PM +0800, Jingbo Xu wrote:
>>>> When range already got reclaimed by somebody else, return NULL so that
>>>> the caller could retry to allocate or reclaim another range, instead of
>>>> mistakenly returning the range already got reclaimed and reused by
>>>> others.
>>>>
>>>> Reported-by: Liu Jiang <gerry@linux.alibaba.com>
>>>> Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>
>>> Hi Jingbo,
>>>
>>> This patch looks correct to me.
>>>
>>> Are you able to reproduce the problem? Or you are fixing it based on
>>> code inspection?
>>
>> It's spotted by Liu Jiang during code review.  Not tested yet.
>>
>>>
>>> How are you testing this? We don't have virtiofsd DAX implementation yet
>>> in rust virtiofsd yet. 
>>>
>>> I am not sure how to test this chagne now. We had out of tree patches
>>> in qemu and now qemu has gotten rid of C version of virtiofsd so these
>>> patches might not even work now.
>>
>> Yeah this exception path may not be so easy to be tested as it is only
>> triggered in the race condition.  I have the old branch (of qemu) with
>> support for DAX, and maybe I could try to reproduce the exception path
>> by configuring limited DAX window and heavy IO workload.
> 
> That would be great. Please test it with really small DAX window size.
> Also put some pr_debug() statements to make sure you are hitting this
> particular path during testing.

I tried to reproduce it but failed.  It seems the race is impossible
theoretically.

In theory, the race occurs when a freeable dmap is found in inode's
interval tree but found it is removed from the interval tree in the
second query.

However the above procedure is protected with
filemap_invalidate_lock(inode->i_mapping) held in
inode_inline_reclaim_one_dmap().  Given the dmap deletion operations
from inode's interval tree are all protected with
filemap_invalidate_lock(inode->i_mapping) held, e.g. inside
inode_inline_reclaim_one_dmap() and lookup_and_reclaim_dmap(), the above
race seems impossible then.

-- 
Thanks,
Jingbo
