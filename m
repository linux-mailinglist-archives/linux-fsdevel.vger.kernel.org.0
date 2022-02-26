Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410784C5887
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 23:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiBZW3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 17:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZW3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:29:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B017208C39
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 14:29:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i11so12216632eda.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vEOwxavlnA6fKuYvSIMYQcxDbxBBdBkPTKzCWXfaLz0=;
        b=SlKcDHIedUvxSqqTDwqgXS+pkGasGqzlcZYqa1BBnZKMPLAteSG+ZyoaMOfBeT+VRi
         LWbzM5nCW/YWkJRkcJkTvqFUFGRh8K4LZu+TPs9+vkEJwVVq499xeUW0dU1P1S7cgBMI
         TRQvJVPWxBp/AzfXGnsM2/kPgLYGRHik8vztvCPXUFFkJt+ZYxm6xOjDjekpgC+wdO/a
         muqaap7qyYW6E9BzhQGUM34IbFX89iSQGCuewEzvtTRNZ5JmHBkiLHT9P0Cxo7EWzDQZ
         g8OeGfHdQ0nG90Ez0FVwAkCjz0Aiok+NYLu7cBEBbE0wuL92bXTucVs5xkl07DVqox6O
         JOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vEOwxavlnA6fKuYvSIMYQcxDbxBBdBkPTKzCWXfaLz0=;
        b=hwN/JA3/JRAIfTWMOj7GuVMHuNMcs5vT0jSCq8YRoTRGhC8nxudpfsj8t1sB13fn9t
         MY8wHLUDKhAPOd0jf7/k0kLgoQ2nEvkDHxPjH2SIhSWrgXmVOHPOIcBkTQ6CgYZpRPla
         6gIgk1KjihH3SLUrE809JJ036yFaakJTeaSxh/PlcDIZ6+0tlugqedZoaQ4FU9XjVbdz
         Bu449UDjgt/Q9iLZH7S/WxQpXgZiDW+bVYnKgAld6ZinNoeJ/3FkgSwco8ggi4/XCgzU
         AdrlJ71h7HKitLXNYSU82+ohOTXRVtV5s7bBvb1wqzbsjZjV58Hmvu9tVWj0D3U0qmH+
         xb5g==
X-Gm-Message-State: AOAM533qztW8f/3EKx9MS3rG0c9D95RN2uVHlj0tFlAhFHTjLr1oSFr9
        BK2BSyB6pNkDQ/YCXCa5Yw4=
X-Google-Smtp-Source: ABdhPJyWKW0wdrOabOr6ZW+3AcYDFCV/WyWU80s7YiduEwfY3VrVNUWWfP7m6uNlTgjPYtSMH0qCOQ==
X-Received: by 2002:a50:ef08:0:b0:413:a9ac:d799 with SMTP id m8-20020a50ef08000000b00413a9acd799mr119527eds.223.1645914544579;
        Sat, 26 Feb 2022 14:29:04 -0800 (PST)
Received: from [192.168.0.59] (178-117-137-225.access.telenet.be. [178.117.137.225])
        by smtp.gmail.com with ESMTPSA id f6-20020a50fc86000000b0040f614e0906sm3492224edq.46.2022.02.26.14.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 14:29:04 -0800 (PST)
Message-ID: <9f5f8241-f3c4-f3ad-a5c1-c7b4637467bd@gmail.com>
Date:   Sat, 26 Feb 2022 23:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] direct-io: prevent possible race condition on bio_list
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220226221748.197800-1-dossche.niels@gmail.com>
 <Yhqo9/695SJbMCBb@casper.infradead.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <Yhqo9/695SJbMCBb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/26/22 23:25, Matthew Wilcox wrote:
> On Sat, Feb 26, 2022 at 11:17:48PM +0100, Niels Dossche wrote:
>> Prevent bio_list from changing in the while loop condition such that the
>> body of the loop won't execute with a potentially NULL pointer for
>> bio_list, which causes a NULL dereference later on.
> 
> Is this something you've seen happen, or something you think might
> happen?
> 

This is something that I think might happen, not something I've seen.

>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> ---
>>  fs/direct-io.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/direct-io.c b/fs/direct-io.c
>> index 654443558047..806f05407019 100644
>> --- a/fs/direct-io.c
>> +++ b/fs/direct-io.c
>> @@ -545,19 +545,22 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
>>  	int ret = 0;
>>  
>>  	if (sdio->reap_counter++ >= 64) {
>> +		unsigned long flags;
>> +
>> +		spin_lock_irqsave(&dio->bio_lock, flags);
>>  		while (dio->bio_list) {
>> -			unsigned long flags;
>>  			struct bio *bio;
>>  			int ret2;
>>  
>> -			spin_lock_irqsave(&dio->bio_lock, flags);
>>  			bio = dio->bio_list;
>>  			dio->bio_list = bio->bi_private;
>>  			spin_unlock_irqrestore(&dio->bio_lock, flags);
>>  			ret2 = blk_status_to_errno(dio_bio_complete(dio, bio));
>>  			if (ret == 0)
>>  				ret = ret2;
>> +			spin_lock_irqsave(&dio->bio_lock, flags);
>>  		}
>> +		spin_unlock_irqrestore(&dio->bio_lock, flags);
>>  		sdio->reap_counter = 0;
>>  	}
>>  	return ret;
>> -- 
>> 2.35.1
>>
