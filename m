Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A5F8ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 12:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKLLpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 06:45:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46429 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLLpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:45:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so17387045ljp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 03:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OKVAcfxje194zRFNg/njiwM3RXKHmEbB7kwF9f13aU4=;
        b=rrGAgDcw0hfIi1JObttZLe7eSMRBkVLgtX1HFB+GTOIJDlG98i7klpUyDW6/AD0qvI
         wusLVhTISByponZeeV5EiUAV2APBQH6To55cCSLjNUXwNOsG7W2ow/J9KD2r+d6Tvbkx
         a503poAcuEagiwRTbGjoZILmfRjuNzfN8b49NdX9EBOJ6ZePIZkJlyv+irvfbIa4BwSL
         oQN584YsQmTTBY4HnXZIW6ln7V8hiiI88LvPdwhVT6yLxSdILXGCG4MnFUHk/sIDENQv
         suVkNbS4tfz32YR88A1bFY4Rrm3Ul0WXww0tZPnFx0DUjRvCKh4YKOoJVtUnhJemwkrL
         6afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKVAcfxje194zRFNg/njiwM3RXKHmEbB7kwF9f13aU4=;
        b=hHKSteKN4+XTXTuM/tVxRN77izRXMsIci43LO+0C6qtj/AkLuuu4rJ2jhQz/c97Hiy
         TfJmMza3XKg+YGM9AEcFbqPk5mg3pcnDoB95tCILZ7C6stgMH1RzsA/d9pRdN2JcyaTC
         Wf6xMzrvpo0LnvL1BI4kxgPSPdTfsge9OmUNtgC1Y7AGUtYzqMDFksWmLb8Q2pbw1V89
         GR6wPjK0DXJnMCG5y3dR16AI3AGE3Ikpsr9tRN5/V5fXsJahHuJErn40Z1UFx+ocGw3Z
         +H7s3xNKPAf6VINucP5u75mfMxaGJKzk3pRUwSxJtBw3QdRQ7FrEQw2mnBGJv8CLrmgC
         X2Ug==
X-Gm-Message-State: APjAAAXo2YbOjZTBrejejCtFqf7Tgy7w0O9er7UijDDjJeBTHTjg514A
        ysloi9CuAc4s6SHsEDD7O1j8TlF3EX8=
X-Google-Smtp-Source: APXvYqzTqPhCfZVHqO7F9eCfkbuqDPiuc0hTUrpxUHYPRpP1a4l6WliePfIu8Cp6P8QyW1a6me/1pA==
X-Received: by 2002:a2e:98c1:: with SMTP id s1mr20538408ljj.215.1573559141877;
        Tue, 12 Nov 2019 03:45:41 -0800 (PST)
Received: from [10.94.250.118] ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id t17sm8138112ljc.88.2019.11.12.03.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:45:41 -0800 (PST)
Subject: Re: [PATCH 1/2] dm-snapshot: fix crash with the realtime kernel
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <alpine.LRH.2.02.1911110811060.28408@file01.intranet.prod.int.rdu2.redhat.com>
 <c9a772e9-e305-cf0b-1155-fb19bdb84e55@arrikto.com>
 <20191112011444.GA32220@redhat.com>
 <alpine.LRH.2.02.1911120240020.25757@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <a6f588d3-2403-d50a-70a1-ed644082cc83@arrikto.com>
Date:   Tue, 12 Nov 2019 13:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1911120240020.25757@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/19 9:50 AM, Mikulas Patocka wrote:
> 
> 
> On Mon, 11 Nov 2019, Mike Snitzer wrote:
> 
>> On Mon, Nov 11 2019 at 11:37am -0500,
>> Nikos Tsironis <ntsironis@arrikto.com> wrote:
>>
>>> On 11/11/19 3:59 PM, Mikulas Patocka wrote:
>>>> Snapshot doesn't work with realtime kernels since the commit f79ae415b64c.
>>>> hlist_bl is implemented as a raw spinlock and the code takes two non-raw
>>>> spinlocks while holding hlist_bl (non-raw spinlocks are blocking mutexes
>>>> in the realtime kernel, so they couldn't be taken inside a raw spinlock).
>>>>
>>>> This patch fixes the problem by using non-raw spinlock
>>>> exception_table_lock instead of the hlist_bl lock.
>>>>
>>>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>>> Fixes: f79ae415b64c ("dm snapshot: Make exception tables scalable")
>>>>
>>>
>>> Hi Mikulas,
>>>
>>> I wasn't aware that hlist_bl is implemented as a raw spinlock in the
>>> real time kernel. I would expect it to be a standard non-raw spinlock,
>>> so everything works as expected. But, after digging further in the real
>>> time tree, I found commit ad7675b15fd87f1 ("list_bl: Make list head
>>> locking RT safe") which suggests that such a conversion would break
>>> other parts of the kernel.
>>
>> Right, the proper fix is to update list_bl to work on realtime (which I
>> assume the referenced commit does).  I do not want to take this
>> dm-snapshot specific workaround that open-codes what should be done
>> within hlist_{bl_lock,unlock}, etc.
> 
> If we change list_bl to use non-raw spinlock, it fails in dentry lookup 
> code. The dentry code takes a seqlock (which is implemented as preempt 
> disable in the realtime kernel) and then takes a list_bl lock.
> 
> This is wrong from the real-time perspective (the chain in the hash could 
> be arbitrarily long, so using non-raw spinlock could cause unbounded 
> wait), however we can't do anything with it.
> 
> I think that fixing dm-snapshot is way easier than fixing the dentry code. 
> If you have an idea how to fix the dentry code, tell us.
> 

I too think that it would be better to fix list_bl. dm-snapshot isn't
really broken. One should be able to acquire a spinlock while holding
another spinlock.

Moreover, apart from dm-snapshot, anyone ever using list_bl is at risk
of breaking the realtime kernel, if he or she is not aware of that
particular limitation of list_bl's implementation in the realtime tree.

But, I agree that it's a lot easier "fixing" dm-snapshot than fixing the
dentry code.

>> I'm not yet sure which realtime mailing list and/or maintainers should
>> be cc'd to further the inclussion of commit ad7675b15fd87f1 -- Nikos do
>> you?

No, unfortunately, I don't know for sure either. [1] and [2] suggest
that the relevant mailing lists are LKML and linux-rt-users and the
maintainers are Sebastian Siewior, Thomas Gleixner and Steven Rostedt.

I believe they are already Cc'd in the other thread regarding Mikulas'
"realtime: avoid BUG when the list is not locked" patch (for some reason
the thread doesn't properly appear in dm-devel archives and also my
mails to dm-devel have being failing since yesterday - Could there be an
issue with the mailing list?), so maybe we should Cc them in this thread
too.

Nikos

[1] https://wiki.linuxfoundation.org/realtime/communication/mailinglists
[2] https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches

>>
>> Thanks,
>> Mike
> 
> Mikulas
> 
