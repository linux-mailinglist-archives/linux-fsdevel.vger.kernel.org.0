Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592672D82E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 00:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbgLKXsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 18:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389300AbgLKXsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:48:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F7EC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:47:58 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so7957248pfu.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oISh5Qt+9+qozoHwPiK0LJy1wYKfFRbf1g7sa3wtD80=;
        b=M7t+fFdOFLTW7Fy25J82EvKyA/RadiGz9CwtFthgIL6J5q74/oT3Hnjt5pbEJccDrR
         Dv4iNdeGm+QjOAbsc00ovYeTop+TOcoNnlxSBSPaNGT2Aua70NFEgZ11T/2sW6Bib4l+
         G7A/lYczvJS5ULmTUD0AoJYiJggr+QBDA3Fi80s7q5ALx/TkgEwK7soeVPfe7HP8q+D4
         qG4AJW23BnvgA9Vo/DhfoH2KOZgq/FFSx3UTXBYUAOvop7Nr55il0Uw6S1fyakc8Uk6S
         WoygVAX6jHcfhi5IGCsK9u31IFgNQG1Cf7KNXk0I3aQG0annLeGkpku5XtTfhigHsikx
         3rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oISh5Qt+9+qozoHwPiK0LJy1wYKfFRbf1g7sa3wtD80=;
        b=hAQnVhoTGrB/MkVIM6WS1TcsANb3L3kX3dU6JYnidlNc7+fKz2b2GhJqi3c7uEej6R
         7pA8L9QMCE5t7ZcW3o1yx0hXB6QQq2FkWynN4yLLNowi/pcim0bqkZEIfLYXfDfM7DHW
         LsxQfV8jkvXGLJSjCHR7/36F6tKx3dQXMBBvGmZqtAankGOtAvhlvoSXBfEGGhCPT46m
         jH2AiayA3IBGyKjpsEM7vr0rcZjlISm+lFxDwD6vthgLnEHP3lOsj3uFBQSvJmF+79lo
         xvIlr/mZAw8FZYSdpH5qCt0Arm9cGLQQ8OGNm7nCP8Q4YYvouwW/3p5CB4cF9F13Lmxz
         w7zQ==
X-Gm-Message-State: AOAM531J5c4ashIArj4o7jpiPJPNjgKcw+nk42f/Jcan45qaVSqDCoMZ
        xEWyZ2EjEvtlhJhvff63FDV10LqpcDpKkg==
X-Google-Smtp-Source: ABdhPJz/oUzlrT2856Zu0Dc09zPPJJJygXjqHifFUBIs7QpYPz1HKxb+MqZDpjQjpSGXq4Q99S0T9A==
X-Received: by 2002:aa7:95a6:0:b029:155:336c:3494 with SMTP id a6-20020aa795a60000b0290155336c3494mr13731923pfk.17.1607730477590;
        Fri, 11 Dec 2020 15:47:57 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c199sm12611384pfb.108.2020.12.11.15.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 15:47:56 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
 <20201211172054.GX3579531@ZenIV.linux.org.uk>
 <2b4dbb32-14b0-fe5d-9330-2bae036cbb93@kernel.dk>
 <20201211215141.GA3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <371d1235-74c8-bed7-2ddc-ebb78d2e8be6@kernel.dk>
Date:   Fri, 11 Dec 2020 16:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211215141.GA3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/20 2:51 PM, Al Viro wrote:
> On Fri, Dec 11, 2020 at 11:50:12AM -0700, Jens Axboe wrote:
> 
>> I could filter on O_TRUNC (and O_CREAT) in the caller from the io_uring
>> side, and in fact we may want to do that in general for RESOLVE_LOOKUP
>> as well.
> 
> You do realize that it covers O_RDWR as well, right?  If the object is on
> a frozen filesystem, mnt_want_write() will block until the thing gets thawed.

I do, current patch does have that handled. I was only referring to the
fact that I don't consider O_TRUNC interesting enough to fold in non-block
support for it, I'm quite happy just letting that be as it is and just
disallow it in the flags directly.

>>> AFAICS, without that part it is pretty much worthless.  And details
>>> of what you are going to do in the missing bits *do* matter - unlike the
>>> pathwalk side (which is trivial) it has potential for being very
>>> messy.  I want to see _that_ before we commit to going there, and
>>> a user-visible flag to openat2() makes a very strong commitment.
>>
>> Fair enough. In terms of patch flow, do you want that as an addon before
>> we do RESOLVE_NONBLOCK, or do you want it as part of the core
>> LOOKUP_NONBLOCK patch?
> 
> I want to understand how it will be done.

Of course. I'll post what I have later, easier to discuss an actual
series of patches.

>> Agree, if we're going bool, we should make it the more usually followed
>> success-on-false instead. And I'm happy to see you drop those
>> likely/unlikely as well, not a huge fan. I'll fold this into what I had
>> for that and include your naming change.
> 
> BTW, I wonder if the compiler is able to figure out that
> 
> bool f(void)
> {
> 	if (unlikely(foo))
> 		return false;
> 	if (unlikely(bar))
> 		return false;
> 	return true;
> }
> 
> is unlikely to return false.  We can force that, obviously (provide an inlined
> wrapper and slap likely() there), but...

Not sure, it _should_, but reality may differ with that guess.

-- 
Jens Axboe

