Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0974D970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjGJPCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjGJPCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:02:49 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F68129;
        Mon, 10 Jul 2023 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689001358;
        bh=hgNhXpc7ON719n/BAnJCAE0Wc7Q+VA9TcYyqyUuMzX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ftni3GNPkSSAEgTEdirZ5smT4QRkb9cDNszTdrx/HpPjtrvyhNR9HsOfzaBf0JDIk
         rOGlFaiSnedkeQ0Wx2ZnGWcdKMo9/UCMv+7hmc/ZJtcoSR0+GLs7gfsjNLNlB118qu
         4RLct33XgAldR3R/gfoNuCipiFbZNx0vgbZln7+o=
Received: from [IPV6:240e:331:c17:7600:7fd7:927f:92b2:f7cd] ([240e:331:c17:7600:7fd7:927f:92b2:f7cd])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id A33EE37; Mon, 10 Jul 2023 23:02:35 +0800
X-QQ-mid: xmsmtpt1689001355tauxx8as0
Message-ID: <tencent_BCEA8520DBC99F741C6666BF8167B32A2007@qq.com>
X-QQ-XMAILINFO: MPAlP4yRn0xgBJaWcGPriWHJZPSE/dw9E5ADYZc0TBANPUF6VU/Yek6CZojUaD
         8p7W8OPzBDruPNmcFplOnY4fEG6UhK9Koml7Iz4H1xWTJyf5U2dohki6xYWetN6oTZM+6l7rnAig
         yEJp3XvwaElki/t21SPy8J40Ca5oH4dMSAQha9rGs5/ThfowiydViIkremYbG6CZbFkqSq7F/PT7
         aqIQtEigWZN4ZAmQcONTUoCuISEijYOlRBKVhcl4BD7zl2G4Q6ix2yK6xNZMDmwyMfKerPCX2pas
         0B5LI45tLhi9C+lmtRd1NLuRg7ogvkV2lJqJfDsJqoHFWYZCI2FOaGaQ7uunXBPvIvfxNbca7hNA
         zYYIGK4EHEe+eZjCK8MDk8biqt40Q5L8iqv/6pi7KaUS+uswuSv4VNZqeJIexDi7qINVyJyvMXwc
         42uvrChYtk/bpEdD2Rs+8XDqe/nIuHrde4CWIdymkr2GqKkw3kE5PhpJ2/Y9kFaSuvhUTxV6cbow
         DzfTO4tJUSjiR1oA78QxrEZZ2dHXGP/h9C3zcuI/reDzniqNPR94+Ye6J80CjTwcukOYfXawaBLw
         nOSW4PlV6oUlxEutsKcs22eBKIgnoNgVhEBD1s/NjM8jBKFF1o3ixI8EKHi35ndz/4pA8t5pTRCt
         qMSME6APs4rm0MOM9e6IT6t4dmDx9Ehbrrm8xA+14JCRuNyXWXWlt7fUS4vCZ4bgcp8Ew5AAEOxn
         QPtTzVYCwny0s9FtW4P3+l9Ab+hHLC/26CXI1K2P0mi9O9D0WGTS8LX15YBmRMQuElk6OCgoIYRP
         yot64pbmL54Ya6a+whW4TveGX7Xq0kBeBb0COK/FjeCeNB4Fs5eXjdm9ehxRzfSUBznKn44hL6VR
         G78ibB7eKrpVGTPoclZvA0smGqtlOORt/RPuU3XY9sIsQFrgPDIBvDiym1Mls5qdwDSbXjA9mOEc
         i6L2JCUaG5si8HToBZZI7advVXeGgFIrnmaH6AW5a53FeyQadhK8evnOYdfJRrpGCL1P8MaDM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <864af946-1785-795c-1fd5-57ef67779447@foxmail.com>
Date:   Mon, 10 Jul 2023 23:02:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is
 0
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
 <20230710-fahrbahn-flocken-03818a6b2e91@brauner>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230710-fahrbahn-flocken-03818a6b2e91@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/7/10 22:12, Christian Brauner wrote:
> On Sun, Jul 09, 2023 at 02:54:51PM +0800, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
>> eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
>>
>> Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Dylan Yudaken <dylany@fb.com>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
> So this looks ok but I would like to see an analysis how the overflow
> can happen. I'm looking at the callers and it seems that once ctx->count
> hits 0 eventfd_read() won't call eventfd_ctx_do_read() anymore. So is
> there a caller that can call directly or indirectly
> eventfd_ctx_do_read() on a ctx->count == 0?
eventfd_read() ensures that ctx->count is not 0 before calling 
eventfd_ctx_do_read() and it is correct.

But it is not appropriate for eventfd_ctx_remove_wait_queue() to call 
eventfd_ctx_do_read() unconditionally,

as it may not only causes ctx->count to overflow, but also unnecessarily 
calls wake_up_locked_poll().


I am sorry for just adding the following string in the patch:
Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")


Looking forward to your suggestions.

--

Best wishes,

Wen


> I'm just slightly skeptical about patches that fix issues without an
> analysis how this can happen.
>
>>   fs/eventfd.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>> index 8aa36cd37351..10a101df19cd 100644
>> --- a/fs/eventfd.c
>> +++ b/fs/eventfd.c
>> @@ -189,7 +189,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
>>   {
>>   	lockdep_assert_held(&ctx->wqh.lock);
>>   
>> -	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
>> +	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
>>   	ctx->count -= *cnt;
>>   }
>>   EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
>> @@ -269,6 +269,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
>>   		return -EFAULT;
>>   	if (ucnt == ULLONG_MAX)
>>   		return -EINVAL;
>> +	if ((ctx->flags & EFD_SEMAPHORE) && !ucnt)
>> +		return -EINVAL;
>>   	spin_lock_irq(&ctx->wqh.lock);
>>   	res = -EAGAIN;
>>   	if (ULLONG_MAX - ctx->count > ucnt)
>> -- 
>> 2.25.1
>>

