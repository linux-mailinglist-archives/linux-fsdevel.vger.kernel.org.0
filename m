Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627C4FB19E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 04:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiDKCMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiDKCMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:12:39 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA9B865
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 19:10:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9gdvlU_1649643023;
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9gdvlU_1649643023)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 10:10:24 +0800
Message-ID: <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 10:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlAlR0xVDqQzl98w@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/8/22 8:06 PM, Vivek Goyal wrote:
> On Fri, Apr 08, 2022 at 07:50:55PM +0800, JeffleXu wrote:
>>
>>
>> On 4/8/22 7:25 PM, Vivek Goyal wrote:
>>> On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
>>>>
>>>>
>>>> On 4/7/22 10:10 PM, Vivek Goyal wrote:
>>>>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>>>>>> Move dmap free worker kicker inside the critical region, so that extra
>>>>>> spinlock lock/unlock could be avoided.
>>>>>>
>>>>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>>>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>>>
>>>>> Looks good to me. Have you done any testing to make sure nothing is
>>>>> broken.
>>>>
>>>> xfstests -g quick shows no regression. The tested virtiofs is mounted
>>>> with "dax=always".
>>>
>>> I think xfstests might not trigger reclaim. You probably will have to
>>> run something like blogbench with a small dax window like 1G so that
>>> heavy reclaim happens.
>>
>>
>> Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
>> xfstests. Thus I think the reclaim path is most likely triggered.
>>
>>
>>>
>>> For fun, I sometimes used to run it with a window of just say 16 dax
>>> ranges so that reclaim was so heavy that if there was a bug, it will
>>> show up.
>>>
>>
>> Yeah, my colleague had ever reported that a DAX window of 4KB will cause
>> hang in our internal OS (which is 4.19, we back ported virtiofs to
>> 4.19). But then I found that this issue doesn't exist in the latest
>> upstream. The reason seems that in the upstream kernel,
>> devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
>> since the dax window (4KB) is not aligned with the sparse memory section.
> 
> Given our default chunk size is 2MB (FUSE_DAX_SHIFT), may be it is not
> a bad idea to enforce some minimum cache window size. IIRC, even one
> range is not enough. Minimum 2 are required for reclaim to not deadlock.

Curiously, why minimum 1 range is not adequate? In which case minimum 2
are required?


-- 
Thanks,
Jeffle
