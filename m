Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC844FBB63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiDKL4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 07:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiDKL4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:56:22 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570336585
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 04:54:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9o33WW_1649678042;
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9o33WW_1649678042)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 19:54:03 +0800
Message-ID: <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 19:54:02 +0800
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
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
 <YlQWkGl1YQ+ioDas@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlQWkGl1YQ+ioDas@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/22 7:52 PM, Vivek Goyal wrote:
> On Mon, Apr 11, 2022 at 10:10:23AM +0800, JeffleXu wrote:
>>
>>
>> On 4/8/22 8:06 PM, Vivek Goyal wrote:
>>> On Fri, Apr 08, 2022 at 07:50:55PM +0800, JeffleXu wrote:
>>>>
>>>>
>>>> On 4/8/22 7:25 PM, Vivek Goyal wrote:
>>>>> On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
>>>>>>
>>>>>>
>>>>>> On 4/7/22 10:10 PM, Vivek Goyal wrote:
>>>>>>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>>>>>>>> Move dmap free worker kicker inside the critical region, so that extra
>>>>>>>> spinlock lock/unlock could be avoided.
>>>>>>>>
>>>>>>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>>>>>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>>>>>
>>>>>>> Looks good to me. Have you done any testing to make sure nothing is
>>>>>>> broken.
>>>>>>
>>>>>> xfstests -g quick shows no regression. The tested virtiofs is mounted
>>>>>> with "dax=always".
>>>>>
>>>>> I think xfstests might not trigger reclaim. You probably will have to
>>>>> run something like blogbench with a small dax window like 1G so that
>>>>> heavy reclaim happens.
>>>>
>>>>
>>>> Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
>>>> xfstests. Thus I think the reclaim path is most likely triggered.
>>>>
>>>>
>>>>>
>>>>> For fun, I sometimes used to run it with a window of just say 16 dax
>>>>> ranges so that reclaim was so heavy that if there was a bug, it will
>>>>> show up.
>>>>>
>>>>
>>>> Yeah, my colleague had ever reported that a DAX window of 4KB will cause
>>>> hang in our internal OS (which is 4.19, we back ported virtiofs to
>>>> 4.19). But then I found that this issue doesn't exist in the latest
>>>> upstream. The reason seems that in the upstream kernel,
>>>> devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
>>>> since the dax window (4KB) is not aligned with the sparse memory section.
>>>
>>> Given our default chunk size is 2MB (FUSE_DAX_SHIFT), may be it is not
>>> a bad idea to enforce some minimum cache window size. IIRC, even one
>>> range is not enough. Minimum 2 are required for reclaim to not deadlock.
>>
>> Curiously, why minimum 1 range is not adequate? In which case minimum 2
>> are required?
> 
> Frankly speaking, right now I don't remember. I have vague memories
> of concluding in the past that 1 range is not sufficient. But if you
> like dive deeper, and try with one range and see if you can introduce
> deadlock.
> 

Alright, thanks.

-- 
Thanks,
Jeffle
