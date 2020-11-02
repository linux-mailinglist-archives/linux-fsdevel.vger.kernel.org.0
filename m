Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA62A34BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKBT4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKBTym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:54:42 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594DC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:54:42 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r10so7376270plx.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4ZxLGbZAH9QpwNm6ZRnurDjpa1h//fgROghHVw24OQ=;
        b=yf0U0iun06zfbK7Cnuqcth6fCp7a8lCxpobpBe+kmTP4SyoXbbUO2K3TYCK6UyDLoj
         ooPYjS4cznerRqU0lXrjLZCVpGCpPjd6Sn+ZNDbEjsdUHgnUiuCOiXXXcxl25lstTQJG
         tmcUn2mbPmmgM9njQGrxNbnj4QroRySYb0+a1/882d/2pjRY/D8LnjJp6l6lMudGtW5l
         WQab6USbKTmTM9oIjp5ESaE+M0vuJq1eJDjJCPIIqKtYMZlvA+lpI665wyc4MzyKlu3s
         kTVXUcgePa/052LwP1SMAb2vgEgBZB0k8BfsD4mulTlNDODd+8fQGcPEGpsaAJAy6WPG
         y+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4ZxLGbZAH9QpwNm6ZRnurDjpa1h//fgROghHVw24OQ=;
        b=a27lRCAqc1U7wF4WI8N9zI+DhLAf3eKK1XaiX9TOXuaOzoEPJdZ0+2JQ0uZT4Wvnyf
         zkKYFfgcPIeQJFfaYbi7q+sgMm7pfax84C3tnpwp4Pu3Aeqpi4RbFBbShPApChg2koMx
         d9H4+ypgu2mnVleiGI7Z9sBdAu1up98K+PKC0kg6+oYiluswirfIuw3Kj6s4tdFscnmx
         9wN4deH2Hk+CDumMI00hyXVb2gDqirYJyPmsM5QBFMDAsXIcCbL0EaGiNfPYdYzt8TIA
         lR3fF7v34wipIULcp6zIPN/ZM+yz5U+O+tpfOGfLM9iD+dsc1madt5rOnk2Ed7cNqMoY
         OfZA==
X-Gm-Message-State: AOAM531HC3kbAvwMHQuOm8k7OsHGAN3+vwC1h91QduR+oU8fijwep0aX
        1Kt9HLlwu72FIFXoIyM8EX8vyg==
X-Google-Smtp-Source: ABdhPJx4OQKRrGqzCD36YPhLdEtoW51FRwM41PHLjI8T2B1Z88FwOtyf99yHIQdpRZQFmBq9iDKmQg==
X-Received: by 2002:a17:902:fe0f:b029:d6:9fa1:eee0 with SMTP id g15-20020a170902fe0fb02900d69fa1eee0mr143358plj.24.1604346881997;
        Mon, 02 Nov 2020 11:54:41 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b6sm269265pjq.42.2020.11.02.11.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:54:41 -0800 (PST)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
 <20201030184918.GQ3576660@ZenIV.linux.org.uk>
 <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
 <20201030222213.GR3576660@ZenIV.linux.org.uk>
 <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
 <87eelba7ai.fsf@x220.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
Date:   Mon, 2 Nov 2020 12:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eelba7ai.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/20 12:27 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/30/20 4:22 PM, Al Viro wrote:
>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>
>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>> and it wasn't ready.
>>>>>>
>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>> usable from io_uring.
>>>>>
>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>> threads, I hope...
>>>>
>>>> How so? If we have all the necessary context assigned, what's preventing
>>>> it from working?
>>>
>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>> *do* pass through that, /dev/stdin included)
>>
>> Don't we just need ->thread_pid for that to work?
> 
> No.  You need ->signal.
> 
> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
> that ->thread_pid is needed.
> 
> Even more so than ->thread_pid, it is a kernel invariant that ->signal
> does not change.

I don't care about the pid itself, my suggestion was to assign ->thread_pid
over the lookup operation to ensure that /proc/self/ worked the way that
you'd expect.

-- 
Jens Axboe

