Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B284B2DB0F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgLOQJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgLOQJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:09:04 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F6C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:08:24 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id g1so19716528ilk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQmwzXNcBTe5VjW71QoUmpz6SomoCpKhVIWAHUA2E80=;
        b=yzLRDwKPewdNk7Nn5YimtjTViXiiyo8K/pyLPCwvEy0yOsae5wtrlMK5V56l8ObLDi
         w0JJyvTJ9v/FkVvN049wXR0zQFI4R7YKug38jouT07ExP1se/m9pMSE3wkX1oMGccJgJ
         M2fNG8CDf8JeQdlFXR5bnc5TXXdcDFJb4S3r/kxphAX737hlfopR+ggb5H3nqW9QuRTk
         YLojXcD1tnADX3tT8DSyIuTYWicG26Khbds5aZ2MD9LG3RcZcx9bSbTOXojGoyP9vAyw
         3FbtubFjZhtOrLbQxEyEFWtmi9eMXEO5SaWQ0yryIxCitz4q5AjjgglSWthzwmivJ+mB
         EmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQmwzXNcBTe5VjW71QoUmpz6SomoCpKhVIWAHUA2E80=;
        b=gJChukqnpHtDTiiI2ig4zDIgb2nRBWone7zM92MYMxujSZZepOzv6ImjiwpR/WN7Tq
         32H5G5/VpyNgBmTOHhDYBM/RCBINEELj4LTMEa6jtiIaBXwDasFzteAxN5te8XFH/put
         otm/3e/788BSXaPBYgWoUR6mlmnX8e/57jktd+JdgWYBz62aKPhE0a3iJuD45xKU+5pO
         oQOfe48X9jCdfdYNCuLBpC0SezuahoD88fZazJJzrctF4e4pMwCNA/DU9TpBBz+2psyh
         Qo9s8zsYLbxIFiJ4JnNmDLJD6vRtilTYJ5lulFuJWfEY0Pp+aOYZpjAt2YsPBp1CGY9r
         OgtQ==
X-Gm-Message-State: AOAM533L3RZGUK3nsdAmtve4BPRg/3HCqxJA90oT0Ptmpxd4Y0wV9Tix
        wxSWGmJ2C6hRi6CJ8UEuHosex5UnLTwTjQ==
X-Google-Smtp-Source: ABdhPJy4Kr3da9CKg3WVA7V3lzAe8T78KppiLE0U1X/8DQySS7B21eS+JxQYAAFlI5HLk2r6PIRuZA==
X-Received: by 2002:a05:6e02:ecc:: with SMTP id i12mr27176647ilk.0.1608048503548;
        Tue, 15 Dec 2020 08:08:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l6sm14227702ili.78.2020.12.15.08.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:08:23 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
 <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org>
 <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
Message-ID: <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
Date:   Tue, 15 Dec 2020 09:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 8:37 AM, Jens Axboe wrote:
> On 12/15/20 8:33 AM, Matthew Wilcox wrote:
>> On Tue, Dec 15, 2020 at 08:29:40AM -0700, Jens Axboe wrote:
>>> On 12/15/20 5:24 AM, Matthew Wilcox wrote:
>>>> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>>>>> +++ b/fs/namei.c
>>>>> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>>>>>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>>>>>  
>>>>>  	nd->flags &= ~LOOKUP_RCU;
>>>>> +	if (nd->flags & LOOKUP_NONBLOCK)
>>>>> +		goto out1;
>>>>
>>>> If we try a walk in a non-blocking context, it fails, then we punt to
>>>> a thread, do we want to prohibit that thread trying an RCU walk first?
>>>> I can see arguments both ways -- this may only be a temporary RCU walk
>>>> failure, or we may never be able to RCU walk this path.
>>>
>>> In my opinion, it's not worth it trying to over complicate matters by
>>> handling the retry side differently. Better to just keep them the
>>> same. We'd need a lookup anyway to avoid aliasing.
>>
>> but by clearing LOOKUP_RCU here, aren't you making the retry handle
>> things differently?  maybe i got lost.
> 
> That's already how it works, I'm just clearing LOOKUP_NONBLOCK (which
> relies on LOOKUP_RCU) when we're clearing LOOKUP_RCU. I can try and
> benchmark skipping LOOKUP_RCU when we do the blocking retry, but my gut
> tells me it'll be noise.

OK, ran some numbers. The test app benchmarks opening X files, I just
used /usr on my test box. That's 182677 files. To mimic real worldy
kind of setups, 33% of the files can be looked up hot, so LOOKUP_NONBLOCK
will succeed.

Patchset as posted:

Method		Time (usec)
---------------------------
openat		2,268,930
openat		2,274,256
openat		2,274,256
io_uring	  917,813
io_uring	  921,448 
io_uring	  915,233

And with a LOOKUP_NO_RCU flag, which io_uring sets when it has to do
retry, and which will make namei skip the first LOOKUP_RCU for path
resolution:

Method		Time (usec)
---------------------------
io_uring	  902,410
io_uring	  902,725
io_uring	  896,289

Definitely not faster - whether that's just reboot noise, or if it's
significant, I'd need to look deeper to figure out.

-- 
Jens Axboe

