Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1A6E9B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjDTRos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDTRor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:44:47 -0400
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453E133;
        Thu, 20 Apr 2023 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682012678;
        bh=8Z9tCQrE4IZ72nzfVNAMoGMKCT3xO74OPin8ygG6pIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=xNbPuIB9sLG0YJREqQTbUKXwuFi/u+hqaPRmje1xAiL39CPg3wL6bkHthgcwPAD0g
         Ivt2t483c/xjBzT/Ak+3ZEk1f9unsjJmIi5wF7YG0NWw0dRx+NFh5GHmVeTx5KZzJf
         erIv7qQSKTx4o2WDfikC8hMdI/09mJ/3wPC7GXds=
Received: from [172.31.255.72] ([116.236.146.234])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id B23390B6; Fri, 21 Apr 2023 01:44:35 +0800
X-QQ-mid: xmsmtpt1682012675tpqexjue7
Message-ID: <tencent_31DEA62F31CFF96D3ED356F1508707594C0A@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3XK2ZbEjTQ9bEnhxrsMrydezzJEFx+hnTkisG+lwe3A0n1DcDma
         HTiYw0z2yK24gTEbt+IH/9b7urHKJuApXRzmGpNveZ4dJXtlvy37ze3tG0WDakcWkTviY1iRd+Lc
         +5OUi1c8OjrTHuzAe+QObESnDDejeA6FV4c4JgbCpsbj7lVGK/J9S/KU44b8is+UXS5VbD0R3i5D
         x4AoWGAAxHIP6RxaquqYTLhSIlq0rkflTpMqb9Tx/Vxk3uMptwsS4K0X1/EOx3eDiBh7A9FZAk8a
         0QjRvQW3i7AwgadA8ldLITHNKQEU9dIpq3BPY/0Sl5iaLX213eS06A+PKEdRnPa1YNCJg3io9nMf
         aaVNrb/f7ds90wT2fEGK4zrLjMDhzmDNhdjADiVYV/uJE0/16Gm+sjjHR6iwG/gG1yT1yvgWOMv7
         V4VNnr9ggGqrdqZubJ0HBI7H6Z4UqXHzOvu5/IH1WfDOAH8Ca6ckCRsxHv0cgGP/gw67ueND7F2e
         eZEhB/pUQ4l2qk0DgDMAneKbtG5CasVzt1FBhoqa3izWLhe+BKrsuVyZmNy1ah2gUDBiC5aFt6W/
         q0HcAGwC0cfoa2LdWyJanKrFmzmFe6B14CGo+5SdgZUDqzfkTc7IpbPFctzHpNwlV2JP9/mgMGul
         89UhZCpt8BnyDurPuZTrhM6ESPpaSRAiQJwvCbwC4yyVsEqCPaocnvpzwwEv01T9DCwwK6q0Vkmo
         6wYMpPd+1MsEBDB7Hf+guNs4g+/r5J6dkt0xSieKlz8UMfk/gKPp+gzc5FT8/jlddHO8ZFUaMxkg
         lWgE9+MU4RCKnPcPa1kIgE8qFioP7PW81CunJuMOVXPhp77N4hGu/s3jEzUCjZbwYKPH3Jh+ReHh
         r5oVk7K4/K41D0K2FX7xF68ERD5LaEcr/cklwvOb3Hq3vqYO7q+H2lSZX5R/4WjHu03SYgVCQPUI
         nbmraS81l7JpKw9HmF6ivrMyB9ASR2DsFOO3nC7Ok=
X-OQ-MSGID: <45756597-a0eb-79f1-0706-1c2bf7e08d19@foxmail.com>
Date:   Fri, 21 Apr 2023 01:44:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
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
 <868ceaa3-4854-345f-900e-52a79b924aa6@kernel.dk>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <868ceaa3-4854-345f-900e-52a79b924aa6@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/4/20 00:42, Jens Axboe 写道:
> On 4/19/23 3:12?AM, Christian Brauner wrote:
>> On Tue, Apr 18, 2023 at 08:15:03PM -0600, Jens Axboe wrote:
>>> On 4/17/23 10:32?AM, Wen Yang wrote:
>>>> ? 2023/4/17 22:38, Jens Axboe ??:
>>>>> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>>>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>>>
>>>>>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>>>>>> then a read(2) returns 8 bytes containing that value, and the counter's
>>>>>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>>>>>> N event_writes vs ONE event_read is possible.
>>>>>>
>>>>>> However, the current implementation wakes up the read thread immediately
>>>>>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>>>>>
>>>>>> By adding a configurable delay after eventfd_write, these unnecessary
>>>>>> wakeup operations are avoided, thereby reducing cpu utilization.
>>>>> What's the real world use case of this, and what would the expected
>>>>> delay be there? With using a delayed work item for this, there's
>>>>> certainly a pretty wide grey zone in terms of delay where this would
>>>>> perform considerably worse than not doing any delayed wakeups at all.
>>>>
>>>> Thanks for your comments.
>>>>
>>>> We have found that the CPU usage of the message middleware is high in
>>>> our environment, because sensor messages from MCU are very frequent
>>>> and constantly reported, possibly several hundred thousand times per
>>>> second. As a result, the message receiving thread is frequently
>>>> awakened to process short messages.
>>>>
>>>> The following is the simplified test code:
>>>> https://github.com/w-simon/tests/blob/master/src/test.c
>>>>
>>>> And the test code in this patch is further simplified.
>>>>
>>>> Finally, only a configuration item has been added here, allowing users
>>>> to make more choices.
>>> I think you'd have a higher chance of getting this in if the delay
>>> setting was per eventfd context, rather than a global thing.
>> That patch seems really weird. Is that an established paradigm to
>> address problems like this through a configured wakeup delay? Because
>> naively this looks like a pretty brutal hack.
> It is odd, and it is a brutal hack. My worries were outlined in an
> earlier reply, there's quite a big gap where no delay would be better
> and the delay approach would be miserable because it'd cause extra
> latency and extra context switches. It'd be much cleaner if you KNEW
> there'd be more events coming, as you could then get rid of that delayed
> work item completely. And I suspect, if this patch makes sense, that
> it'd be better to have a number+time limit as well and if you hit the
> event number count that you'd notify inline and put some smarts in the
> delayed work handling to just not do anything if nothing is pending.

Thank you very much for your suggestion.

We will improve the implementation according to your suggestion and send 
the v2 later.


--

Best wishes,

Wen


