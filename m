Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0230750F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhA1LoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 06:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhA1Lnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:43:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B678C061574;
        Thu, 28 Jan 2021 03:42:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u14so4045032wml.4;
        Thu, 28 Jan 2021 03:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5ruvM3Pi2TwZL/KAf2g8R8ehK0uJHZDo1/BwXoSTqM=;
        b=PoweDyPOoq5w4h8ke1eXu7ZpkY9b+VEeYHSkn64n+gEfrI5nxeXycdK8vMlOJDIXzE
         3uJZkLfkS5Ln1qHhLTZu1O8ultXfrqNpGNwaBa/2YvzOHb0jIl1Pp4wwcW7F9sKM/2C9
         sjvM0n7mdfGKve0oQwLU8bRIw6oU3NB+21XSrHbD9jabto4/4/RFRCI3KDuoPilYSRt3
         NK2RHEyXSaHaEB0vCzKWvnT8nycZWZOYg6n4VXEsKTo+vxRqmnsdJdOgzA1eItjyn/FP
         c6Dd8FFyPMYSBKTI6W4az1jdGAcy4Ns3/zhjqdD3V8ipI3X9wfQbPUFfKELELQNBc9Nz
         YEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p5ruvM3Pi2TwZL/KAf2g8R8ehK0uJHZDo1/BwXoSTqM=;
        b=BcpT+Vg8cOcxqD37k1bNCLJbhdhaC/LxxX+bC/VAQa4LO+rE72/1uaJD9DSeuT7PKC
         wmvGHyjbDYMXC/SsGMN/wc0YNpmqh3LuoAqlJwhIHfPAHAhgqa4fYSoC3mB1ttYsCMDc
         oMmqkyP75izxtYjwQt/pHe5lq0ADUCB7BTYpF3T9Qm3kGSvBgF9sFD7otcP1NHzQLrod
         zp7WwRjRAKJugcfyJZEH8ygRjgO9fNdz1CzvYscRLZaVr0rr5NfJgDfg4jJxAYQC9Xqd
         lYrVKADFPP6rBaHiLluRqYYbjD7pju2HprVHU/EKZG18Y79zJ9xQ8DwXTyZg6XnOrt12
         AB1w==
X-Gm-Message-State: AOAM532eF6ONDmPFJhK9E3Ar0WepLIDBMAtNY+BdWdr9CfLo7qph7Lht
        z8GlrWRCyyRE60Oo5GYtpUTVzcKy3kQ=
X-Google-Smtp-Source: ABdhPJw+0u+6NvKGOp5YbUibO+/KUDdk0GXChzlYTyhRGWutrdddJlrVUVv1liWEX+tN3hxZ0rij+w==
X-Received: by 2002:a05:600c:2a47:: with SMTP id x7mr8219554wme.145.1611834177646;
        Thu, 28 Jan 2021 03:42:57 -0800 (PST)
Received: from [192.168.8.160] ([148.252.132.131])
        by smtp.gmail.com with ESMTPSA id v4sm7454860wrw.42.2021.01.28.03.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 03:42:56 -0800 (PST)
Subject: Re: [PATCH] iov_iter: optimise iter type checking
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
 <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
 <20210127183152.GP740243@zeniv-ca>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <baa41253-bf9b-5bac-d044-5264dd8808f7@gmail.com>
Date:   Thu, 28 Jan 2021 11:39:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210127183152.GP740243@zeniv-ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/01/2021 18:31, Al Viro wrote:
> On Wed, Jan 27, 2021 at 03:48:10PM +0000, Pavel Begunkov wrote:
>> On 16/01/2021 05:18, Al Viro wrote:
>>> On Sat, Jan 09, 2021 at 10:11:09PM +0000, Pavel Begunkov wrote:
>>>
>>>>> Does any code actually look at the fields as a pair?
>>>>> Would it even be better to use separate bytes?
>>>>> Even growing the on-stack structure by a word won't really matter.
>>>>
>>>> u8 type, rw;
>>>>
>>>> That won't bloat the struct. I like the idea. If used together compilers
>>>> can treat it as u16.
>>>
>>> Reasonable, and from what I remember from looking through the users,
>>> no readers will bother with looking at both at the same time.
>>
>> Al, are you going turn it into a patch, or prefer me to take over?
> 
> I'll massage that a bit and put into #work.iov_iter - just need to dig my
> way from under the pile of ->d_revalidate() review...

Perfect, thanks

-- 
Pavel Begunkov
