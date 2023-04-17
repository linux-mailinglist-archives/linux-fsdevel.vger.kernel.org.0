Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F46E4E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDQQia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQQia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:38:30 -0400
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD26A7C;
        Mon, 17 Apr 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681749494;
        bh=LHxEgyl10WmcIT333SoUsp8z3KDb6wZD71PfCxt7yh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ESzEFguZ5FfsIeG6QUk23cYjPlajCCQ8mO3tvfJ/otWOD5ME8jdaUITUkFUkRDKDM
         iyM6N8bI5baHkLYzUlVZAZHOOLIm7oL7jQzIAqqq3vu3QGKpQU2OcJ4RNpDf2qsq3Y
         RtIoVErrEnGHuq+SsktQKVUu5A3ICWWMqEjJ+c+c=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 80035CB5; Tue, 18 Apr 2023 00:32:00 +0800
X-QQ-mid: xmsmtpt1681749120t7id5j917
Message-ID: <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
X-QQ-XMAILINFO: NvgtgL4Jzwx/upYnfLXf7U7DlsJlSs/d9+r8a2gRc+6tpdRWVkDA4f8dgRcfam
         SEIossCNU1bZQBX0xFf8muVKpnniXWlmZv9aibhya8EIP0HiFFaoXaMHttErgSV8Z3/cNKLbMSOv
         tu7ztbwLGmtg16XT4oe2TLRCYmsYLATodtium18HafKwColvcs6CZgt8syO/FJQIgEz6NnxqOgV1
         oCtslRgAoHOLxUGuYMYutVyYU17xhSf/lJla0IsKiLMsvz0bD6x8UnkpCv+rOtU8dUc/NJXuu0fF
         lXok5P87oQQXWr/Iu5FzqRV1PY93/P4VJV+4r8bxBCUxxJnmm2fGyAl4pt/6J/37APSe1WC6kljd
         8VBtsAQk5CNBmFqbRB5ywOWmhkHqzYMQYYcwglU9SO1VzZVG1k1ZEXCg6vG/ZlpcW4QT2tVRXayF
         3zfWAmB15EICjL5C0XkqQVzn76FtqCY/lpl/xC0ftdFYfVCh9IhMqQbuJqxIzz0bCxCa4FE5xGOu
         Mn9zM5K7SmQ2MmAZwXdadxW/k/kglWUTICL0VSCRpofiNtmONwjMbrLy+oPwrc58XpdtdhjIzQJM
         8NhgeG8Rh3e6oh5aQlKNmh3VXDpQbW7TqcBDlZvIywt7k17+E40WkzDQcolhQRTfWrFk1gDIctOI
         1ju96dYGdFNOEzJI/fCcDBQY8rItF/KZkQ6rKsYRhufpDoXjUMgpW2i1Q0bgsmBl9bCmY01V+kIz
         DlVwKoAKzpmVxIlYG1W3wDwMlvElOFIWIC++pgWgqeLG341Sre7yi1rSyhyHJdQdukIjZJTB4rPT
         k+8nsihEYv9oi4EQ2gow0JSh/6AK5jLd2KAGcBowqFBQwP3xWeeSuQGdlTZIXGoqG8tRMErJarnF
         wvSpwNBMTEsrS4YbEP3gk5DHH2su/YW/256j9Xoh7s0Q35Vxe/g4FJra50YQd925zYOMil+wrMu0
         bdo0Hbw3dXKC4pvUxRRyCUOlm0m4pMXNDqhiuqygLMcg0ncI8AeQ==
X-OQ-MSGID: <055f8c62-cf3f-98fe-264e-f7b381c8eaf6@foxmail.com>
Date:   Tue, 18 Apr 2023 00:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/4/17 22:38, Jens Axboe 写道:
> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>> then a read(2) returns 8 bytes containing that value, and the counter's
>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>> N event_writes vs ONE event_read is possible.
>>
>> However, the current implementation wakes up the read thread immediately
>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>
>> By adding a configurable delay after eventfd_write, these unnecessary
>> wakeup operations are avoided, thereby reducing cpu utilization.
> What's the real world use case of this, and what would the expected
> delay be there? With using a delayed work item for this, there's
> certainly a pretty wide grey zone in terms of delay where this would
> perform considerably worse than not doing any delayed wakeups at all.


Thanks for your comments.

We have found that the CPU usage of the message middleware is high in our
environment, because sensor messages from MCU are very frequent and 
constantly
reported, possibly several hundred thousand times per second. As a result,
the message receiving thread is frequently awakened to process short 
messages.

The following is the simplified test code:
https://github.com/w-simon/tests/blob/master/src/test.c

And the test code in this patch is further simplified.

Finally, only a configuration item has been added here, allowing users 
to make
more choices.


--

Best wishes,

Wen



