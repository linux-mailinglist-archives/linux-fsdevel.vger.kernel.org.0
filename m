Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABA52DB115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgLOQPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgLOQPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:15:10 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BCC06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:14:29 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so21013084iov.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ubxv+1J1kVFYsWuRdnbdv5L+KsfvgIzY4voGGvEw60c=;
        b=zVSHYgnFdcDMCfKglv83CReFebKn9F12SuzPQaEKIDDDObTXR7JA2bRtmz5Mt/4Qn8
         YshJkuf0fkLMxqtnx7TWybqW9pGLS0oakmKU0aC1N6ZILNvnX6fJsqEHal8qxEBiISl3
         iS/Ysglq70JH+MQyDdF3d/ZQNBRIsV4GoA6qUDD6WAA4tmEtpVVyEYUSNa5IOFLT+1H5
         bfwD3/i25GOwLDrrvIIF/kR4F7BOrSVWKLIsQCZ7KkI6ZaZkcwCgNzhhoD7QASYuOqYm
         HJQdJzK5AcgHaJwVF+Cf6wHCiPLZjiKM3wKjzFC4QrPeZ6n/DLxUu2oWiCQukGk25JAm
         fuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ubxv+1J1kVFYsWuRdnbdv5L+KsfvgIzY4voGGvEw60c=;
        b=CvkiaOi13f0fRnApNScG0ngos1oIBBwWE/VSh85p7zmXNLuLuFnFP62JkzA8H3fIfM
         wD008mTr8OxoP6R4oestCQbb1bl86JDLb6mMSjNGE5sZ4R8F/L+p+1AoyEHFXJBQ1Eu3
         DQ7qdQcYq6slifJN4aBH2h1Y9skpxpu8dmPfv6GIti7MjVWlz5CCxKEa9zyJYFoVMijN
         iDj7p+LXAx0pkesMXoji4pYcNK9FAh+dMjFoEwdgsBhHoMLyIqtpdzmB/v/T1z5mcpRP
         /qpMwY2/8feyMz1H7h6f2z478hUL6EVfB0obVjhiW3LA+/9O6B+bEggRTBB4XvI5eM39
         tznw==
X-Gm-Message-State: AOAM533AAfbXFffGLrY3wDalkwOkbF1xSHrZ0ZEAcXe70TiD29issIVT
        oZePe/2SVOcj+5eh/n94tuo7uw==
X-Google-Smtp-Source: ABdhPJzx1DtxnAz/GhZ6w08NzII8UfpM+4XZzXVWPoBv29AxKk8t5ChGv8elaLAJ7WU7b/HNiI1uUQ==
X-Received: by 2002:a6b:b2c3:: with SMTP id b186mr37468737iof.126.1608048869010;
        Tue, 15 Dec 2020 08:14:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j65sm14040717ilg.53.2020.12.15.08.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:14:28 -0800 (PST)
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
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
Message-ID: <2b7242dc-0cdf-80ea-18bd-fa00cc3295be@kernel.dk>
Date:   Tue, 15 Dec 2020 09:14:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 9:08 AM, Jens Axboe wrote:
> On 12/15/20 8:37 AM, Jens Axboe wrote:
>> On 12/15/20 8:33 AM, Matthew Wilcox wrote:
>>> On Tue, Dec 15, 2020 at 08:29:40AM -0700, Jens Axboe wrote:
>>>> On 12/15/20 5:24 AM, Matthew Wilcox wrote:
>>>>> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>>>>>> +++ b/fs/namei.c
>>>>>> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>>>>>>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>>>>>>  
>>>>>>  	nd->flags &= ~LOOKUP_RCU;
>>>>>> +	if (nd->flags & LOOKUP_NONBLOCK)
>>>>>> +		goto out1;
>>>>>
>>>>> If we try a walk in a non-blocking context, it fails, then we punt to
>>>>> a thread, do we want to prohibit that thread trying an RCU walk first?
>>>>> I can see arguments both ways -- this may only be a temporary RCU walk
>>>>> failure, or we may never be able to RCU walk this path.
>>>>
>>>> In my opinion, it's not worth it trying to over complicate matters by
>>>> handling the retry side differently. Better to just keep them the
>>>> same. We'd need a lookup anyway to avoid aliasing.
>>>
>>> but by clearing LOOKUP_RCU here, aren't you making the retry handle
>>> things differently?  maybe i got lost.
>>
>> That's already how it works, I'm just clearing LOOKUP_NONBLOCK (which
>> relies on LOOKUP_RCU) when we're clearing LOOKUP_RCU. I can try and
>> benchmark skipping LOOKUP_RCU when we do the blocking retry, but my gut
>> tells me it'll be noise.
> 
> OK, ran some numbers. The test app benchmarks opening X files, I just
> used /usr on my test box. That's 182677 files. To mimic real worldy
> kind of setups, 33% of the files can be looked up hot, so LOOKUP_NONBLOCK
> will succeed.
> 
> Patchset as posted:
> 
> Method		Time (usec)
> ---------------------------
> openat		2,268,930
> openat		2,274,256
> openat		2,274,256
> io_uring	  917,813
> io_uring	  921,448 
> io_uring	  915,233
> 
> And with a LOOKUP_NO_RCU flag, which io_uring sets when it has to do
> retry, and which will make namei skip the first LOOKUP_RCU for path
> resolution:
> 
> Method		Time (usec)
> ---------------------------
> io_uring	  902,410
> io_uring	  902,725
> io_uring	  896,289
> 
> Definitely not faster - whether that's just reboot noise, or if it's
> significant, I'd need to look deeper to figure out.

If you're puzzled by the conclusion based on the numbers, there's a good
reason. The first table is io_uring + LOOKUP_NO_RCU for retry, second
table is io_uring as posted. I mistakenly swapped the numbers around...

So conclusion still stands, I just pasted in the wrong set for the
table.

-- 
Jens Axboe

