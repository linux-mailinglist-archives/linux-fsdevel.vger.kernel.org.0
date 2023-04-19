Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A746E7E46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjDSPaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjDSP3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:29:50 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA63F1B1;
        Wed, 19 Apr 2023 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681918178;
        bh=i7BLMpTRVsW1BIWO/SL11HsZzSOIh99XjgQg9CbAT8s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jf1nRNEuYP+4tlUlb/v8v3ld6gTH5JVBhgmICHQOqlSGKUHo8kyc5QObMGI+vNiqB
         M9pnlI2DmIsLiRhk0WhyZi4ZiyMLbXda2N4tKX+GjPQ0y7HC5zPeo45X4h7OpcXiDs
         MIAGhBB2eSCFJfB3MSxV8+PJQWOz8eb643G7wiOU=
Received: from [172.31.255.165] ([116.236.146.234])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 5CFB9255; Wed, 19 Apr 2023 23:23:15 +0800
X-QQ-mid: xmsmtpt1681917795tl8sk55p2
Message-ID: <tencent_F479CB8FE699B64A8B7A39E865F23F5D9005@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjNFuHz43Q/JZ/Ie+CatX823q4j9rASO2Z97KutRcJaR5Ckw3yP8
         U2kFHAbG2LvWHdet3BUv4pn00OggEpkdCYVzLNy8zU81/TzzGABrkCVECCNkSj4kbTM6DqnO8M/U
         Hj3crgc/w73BKauDrSXrHvE0evUKcFgbdxxZbj42pxIzU7MRfvK/nUTfbdgwyDxE7IieE6XhtGFt
         SscHw5XM+63qqxov00MlpqDjDRRj76XTklk3xm0lT1p5OSoDJVNA46KGWXbZ8xiONcrWyYfNoWtJ
         WALFHhswvKKSOQ5h4XElkgKhcW6ZVjMNpL9sWe8tKWJ6RBzVn4/bPNYAmKglPgzcxDrysF9Pv/nv
         khqaCjYVp8uVhiThP6rNtn65H2+ogr1FD9FQH/6MTVBFrRsDvy6ZixCPtnlyUtf9y3mdy3y6UnAy
         wPnd0UCcknO3FFHzuxmDqnzYF6k3F5dcXgqyTQCiyd8CPfwqSLAm2kWr+4bth9bBQwBelCm73BXV
         /WziF5R3ZvDnb8AwVQ66x+ICdnBFFBKDH2LervVf8XmumNzGOcNdaF4rNhTB2r9sXo1HpvU3FGNH
         aUwNmQSMg0mxgnOvdiVbEffHDg63VKc/M2GOPUVA4TTnWpy5vMvcjcvEwf+VuBveGPpFoUUZvSN0
         rHBGlUweU12DUdP2fGhG/NOqAdzRadVbWLkzIM2TNy5yyPX520LWExPob6qeVMCPtxh3qmrIdvil
         pALGflz7/0bAeQZ5C/mYJAiXCxEgTzMGfEzV/SoxsQYTM6Fx0IwHZw8X5ZWRjxzl69q5C3ibQVwU
         g33gF3chlRkRFf5aEnzlMzV6bf+xRc5Ywc8YqWRvYN0qs0sSRCEJLpMQa4vYEKGsjjgNNeKcTVuw
         QHa5h71YuoiKWV8qbXvVk+udG3ESphfXotgKSRfNL+7KkmpSGearvpchUWmqtaNSQywoHAaTLRyC
         n9Z2F5s3Isb1YaR+G83oqAHxkUHBKR8bPyM8w+E+I773cOmkC1Qg==
X-OQ-MSGID: <79ed17d1-f79f-3297-6e44-a38865de2f04@foxmail.com>
Date:   Wed, 19 Apr 2023 23:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
To:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
 <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
 <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
 <20230419-blinzeln-sortieren-343826ee30ce@brauner>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230419-blinzeln-sortieren-343826ee30ce@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/4/19 17:12, Christian Brauner 写道:
> On Tue, Apr 18, 2023 at 08:15:03PM -0600, Jens Axboe wrote:
>> On 4/17/23 10:32?AM, Wen Yang wrote:
>>> ? 2023/4/17 22:38, Jens Axboe ??:
>>>> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>>
>>>>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>>>>> then a read(2) returns 8 bytes containing that value, and the counter's
>>>>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>>>>> N event_writes vs ONE event_read is possible.
>>>>>
>>>>> However, the current implementation wakes up the read thread immediately
>>>>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>>>>
>>>>> By adding a configurable delay after eventfd_write, these unnecessary
>>>>> wakeup operations are avoided, thereby reducing cpu utilization.
>>>> What's the real world use case of this, and what would the expected
>>>> delay be there? With using a delayed work item for this, there's
>>>> certainly a pretty wide grey zone in terms of delay where this would
>>>> perform considerably worse than not doing any delayed wakeups at all.
>>>
>>> Thanks for your comments.
>>>
>>> We have found that the CPU usage of the message middleware is high in
>>> our environment, because sensor messages from MCU are very frequent
>>> and constantly reported, possibly several hundred thousand times per
>>> second. As a result, the message receiving thread is frequently
>>> awakened to process short messages.
>>>
>>> The following is the simplified test code:
>>> https://github.com/w-simon/tests/blob/master/src/test.c
>>>
>>> And the test code in this patch is further simplified.
>>>
>>> Finally, only a configuration item has been added here, allowing users
>>> to make more choices.
>> I think you'd have a higher chance of getting this in if the delay
>> setting was per eventfd context, rather than a global thing.

Thank you.
We will follow your suggestion to change the global configuration to per eventfd.

> That patch seems really weird. Is that an established paradigm to
> address problems like this through a configured wakeup delay? Because
> naively this looks like a pretty brutal hack.

Thanks.

Well, what you are concerned about may be that the rough delay may cause 
additional problems, which is indeed worth considering.

Meanwhile, prolonged and frequent write_eventfd calls are actually 
another type of attack.

If we change it to this:

When a continuous write_eventfd reaches a certain threshold in a short 
period of time, a delay is added as a penalty.

Do you think this is acceptable?


--

Best wishes,

Wen

