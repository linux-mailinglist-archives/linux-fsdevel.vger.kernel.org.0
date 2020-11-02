Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4B2A3521
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKBUbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBUbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:31:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29803C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:31:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x13so12148312pfa.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=taI5V1PmKR84k5WuxRX//AHvUGNpKhqq+imLNWnt1k4=;
        b=vLvy5N3qjQFUvEJJO5v5PRIQdTgbNoxDRQCor83tF0Uqv19vCQKM2Wcz4NIjY84WaP
         ZDuhPcrFM5YZvvGHOFRaVOYe2BkrLh5jZzhkpzt8G2bLTi1SpSSFbvqzi5noI8vmGITL
         rKpJxFQLBvb4yb4IxCyZgSH+w0R/pfttrVvoKqx9wEp+1drmpUchYbncawehUDXxAj+S
         I0D8zRVbkofR+b8Ne3DkQVRkrDZBJeF1csXcB5rWr4bdXIFLjh6xzmzui8jsduIRDNRH
         Amml1LTu86cyl1k8s/AP2lrjEIP3R04L2h7J7OkC5hBvzIduhZQYMNXeRagDjIBuaO5I
         iaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=taI5V1PmKR84k5WuxRX//AHvUGNpKhqq+imLNWnt1k4=;
        b=YgNBLd4SsXf8AsBNYYM2yk09uMemsuc42Jfo2b4HUR6FqEZGD85JUhXpYW30waD74Y
         0rGv0U/hU4yaBn8CMdmvh07CcDHjiI7zsMsxYqNBTcA4LlkoRhzCgcH44MbsLG5jpuQh
         Q0qMlp5H4WP2+UsONn5pfvxKQ2iDOsdcZolY5WeMbAepJnBAUqn/ouYckXJMziNFEjSR
         rmqkRz5YYShWSHZFeDZE0q2JRv5nOHUxBSa3u/CZgxFeRLbzjnRU0wSf6UFj8E7FDU7X
         j21CSu8nUQeZEOZyR2Mp+SGuU7LNFhlD3vfVdGbkxSLwL8GmSGVPNtIzDYO07gmT7zj2
         x2EQ==
X-Gm-Message-State: AOAM531h1W219XfwI1bZAGtA3klbrB7YLlWs+N3Oz7DtyVzhX8jLRNeg
        d+UJHVVfsrRtMHuci2Yo/o4Gjg==
X-Google-Smtp-Source: ABdhPJwd9hKXh1kE1Bcx0wezEg07bK53IiR4nPRLnnPmcSCDUsKuKPiMakIXHBOfzj21lTyawQMk2w==
X-Received: by 2002:a17:90b:4749:: with SMTP id ka9mr19576253pjb.197.1604349069502;
        Mon, 02 Nov 2020 12:31:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e13sm5210784pfm.2.2020.11.02.12.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:31:08 -0800 (PST)
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
 <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
 <87k0v38qlw.fsf@x220.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d77e2d82-22da-a7a0-54e0-f5d315f32a75@kernel.dk>
Date:   Mon, 2 Nov 2020 13:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0v38qlw.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/20 1:12 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 11/2/20 12:27 PM, Eric W. Biederman wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 10/30/20 4:22 PM, Al Viro wrote:
>>>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>>>
>>>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>>>> and it wasn't ready.
>>>>>>>>
>>>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>>>> usable from io_uring.
>>>>>>>
>>>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>>>> threads, I hope...
>>>>>>
>>>>>> How so? If we have all the necessary context assigned, what's preventing
>>>>>> it from working?
>>>>>
>>>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>>>> *do* pass through that, /dev/stdin included)
>>>>
>>>> Don't we just need ->thread_pid for that to work?
>>>
>>> No.  You need ->signal.
>>>
>>> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
>>> that ->thread_pid is needed.
>>>
>>> Even more so than ->thread_pid, it is a kernel invariant that ->signal
>>> does not change.
>>
>> I don't care about the pid itself, my suggestion was to assign ->thread_pid
>> over the lookup operation to ensure that /proc/self/ worked the way that
>> you'd expect.
> 
> I understand that.
> 
> However /proc/self/ refers to the current process not to the current
> thread.  So ->thread_pid is not what you need to assign to make that
> happen.  What the code looks at is: ->signal->pids[PIDTYPE_TGID].
> 
> It will definitely break invariants to assign to ->signal.
> 
> Currently only exchange_tids assigns ->thread_pid and it is nasty.  It
> results in code that potentially results in infinite loops in
> kernel/signal.c
> 
> To my knowledge nothing assigns ->signal->pids[PIDTYPE_TGID].  At best
> it might work but I expect the it would completely confuse something in
> the pid to task or pid to process mappings.  Which is to say even if it
> does work it would be an extremely fragile solution.

Thanks Eric, that's useful. Sounds to me like we're better off, at least
for now, to just expressly forbid async lookup of /proc/self/. Which
isn't really the end of the world as far as I'm concerned.

-- 
Jens Axboe

