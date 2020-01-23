Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7B14718E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWTOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 14:14:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAWTOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:14:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1977128pfh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+j6n3bLqsywHmHf3IWP7jfMllioYd4CpeP8JoTqsBg4=;
        b=VdZgkZgvc+axYrbN0WmRyJokY3HmJqCNSto/KBRyWcFp+Pq3NHvPFfpH+sYGzX6Mcf
         g22nywECZ1Rmo1bhwF+SNdC7agfaEN1xGSqa3LadFG+de8ugL2qYR5ZXfeelocFesZrv
         /W9uP2k/th0jCtd8sxXpwy8nWxNHNbtVmYtdnTYThMvsagzjZ/1OQ2ZIXj06+UC9ykHA
         KJgvE5QisCvhHIrX1rGIfwsWHkZQUKPkQEsGQM2e53ibX7zxeacbfPOLc+Dfm9lmuFTR
         7au1oO1oKsH0K+ZSQTR5effJiR1/XfGVckuiawtGmcBLc3OjnhUh1UqzMyrgLFaS5mLm
         6svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+j6n3bLqsywHmHf3IWP7jfMllioYd4CpeP8JoTqsBg4=;
        b=GNFR0lvO+yqbx7a+de2ZB9A/nQSLqyhdV2S78I1W2CSM9fzNZEBvW3ZhhM2m+Zg4S4
         c6CEHgrlUhb3/i710M5I8myigNVC0TMB3PKP0CXw97oi6Xx48h4lqcuzL/Zx/iGMXEGL
         w376IVJQkNmdLmahpIaWWDLbVbOOobDACPAQwt7lrXM1UFcdu+y0muu7UykuMPsyE7C7
         rF6u31F2c7SS5Ssh0e7pereUDDZbdh8oIBKb8QCKrUd8ibXawpbvRrAZLKPwyMoURsa+
         4iaEWTsWL4bTudasEbbI84hKL/KucBIXIf5ALlUenuT/veq+9/KuAu41M/YJXN1BnBMu
         M1Lw==
X-Gm-Message-State: APjAAAXyB9Z5klluMsJuHnjQdWhLfBZ2KI0BG/jTWgjGYpzalIVAkosU
        UQlLwMDFc1dFDkerhsEGU652T8gIGYaANg==
X-Google-Smtp-Source: APXvYqyy93D4u/4fyfGaogLMtiMjbjktxYdJjqvu555rM06/JgrUxLKamGaHJUP2hOZTjSK3nw/55A==
X-Received: by 2002:a63:500c:: with SMTP id e12mr312091pgb.214.1579806839580;
        Thu, 23 Jan 2020 11:13:59 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id k44sm3731287pjb.20.2020.01.23.11.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:13:59 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
 <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
 <20200116170342.4jvkhbbw4x6z3txn@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d3d4932-8894-6969-4006-25141ca1286e@kernel.dk>
Date:   Thu, 23 Jan 2020 12:13:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116170342.4jvkhbbw4x6z3txn@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/16/20 10:03 AM, Stefano Garzarella wrote:
> On Thu, Jan 16, 2020 at 09:30:12AM -0700, Jens Axboe wrote:
>> On 1/16/20 9:26 AM, Stefano Garzarella wrote:
>>>> Since the use case is mostly single submitter, unless you're doing
>>>> something funky or unusual, you're not going to be needing POLLOUT ever.
>>>
>>> The case that I had in mind was with kernel side polling enabled and
>>> a single submitter that can use epoll() to wait free slots in the SQ
>>> ring. (I don't have a test, maybe I can write one...)
>>
>> Right, I think that's the only use case where it makes sense, because
>> you have someone else draining the sq side for you. A test case would
>> indeed be nice, liburing has a good arsenal of test cases and this would
>> be a good addition!
> 
> Sure, I'll send a test to liburing for this case!

Gentle ping on the test case :-)

-- 
Jens Axboe

