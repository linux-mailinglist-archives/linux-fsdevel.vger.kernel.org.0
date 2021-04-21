Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BA366822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhDUJgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:36:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31244 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbhDUJf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:35:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210421093523euoutp01ab7258d906de71f42eab7a56355308b2~31doWDaiI2910929109euoutp016
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 09:35:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210421093523euoutp01ab7258d906de71f42eab7a56355308b2~31doWDaiI2910929109euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618997723;
        bh=AN/04FgvAqzABcyyvdUV6OXT5CUrutzKOCHl9Vs9JMw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WI9rVvVQhlH46U9WiAXbFkjWSoOLVX1TSJit6rBmA7u8vOltttVe9IJcdidlm+jYy
         kDFmCxancpOrWmc0C5Ls9qSTGqwF0PhXTMAhP6rKfysnf0i+5epGZwaPwAYhmhfwgR
         rj81pHQAIgCU4uNuSjq3dzijv/JoYAyTiFpNFweA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210421093523eucas1p264374ab1d1f4c98df1606d348145bd13~31dnt_7u22054820548eucas1p2F;
        Wed, 21 Apr 2021 09:35:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.5E.09439.AD1FF706; Wed, 21
        Apr 2021 10:35:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210421093522eucas1p1f0bf1889f23b7a71e8ea35313273606c~31dnM5u6t0040500405eucas1p1R;
        Wed, 21 Apr 2021 09:35:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210421093522eusmtrp23da702d9b240a0ce063e6582bc69a744~31dnLjT981228112281eusmtrp2f;
        Wed, 21 Apr 2021 09:35:22 +0000 (GMT)
X-AuditID: cbfec7f5-c1bff700000024df-2a-607ff1da516b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.C9.08705.AD1FF706; Wed, 21
        Apr 2021 10:35:22 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210421093520eusmtip1254c053cba84fc98636bab56c42935ae~31dlr8s4R2875628756eusmtip1f;
        Wed, 21 Apr 2021 09:35:20 +0000 (GMT)
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and
 si_perf to siginfo
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com>
Date:   Wed, 21 Apr 2021 11:35:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG/c45PT1tUjkUtn7pEJcymboUx4TlMyNsmoUd9webkmUJGYOq
        Z4VxXWu9bMpQA+u6CYgXpKGIKbcgKpSbIHdGaydU5DI2AgNGQ5aSQhoBHaYwyoGN/37v+z5v
        nudNXgoXm0gplZByklWlKJJkpJBoMP9jk4+6vo97u9d+AOn+fEAiramAh9x5Zj66M55Dopqb
        93nowlwAyp3K4qOs3kYemhltxdAPrlYcFWcu8NGAVY56+twYqpiZwJC2eZFALa1WAg02F5Io
        f2yeRKUjTzFk7OzgoYGOYgxdLKsnUH17JkA5YyMkslzuwFCt6TqOnrgtPPSiepr3gR9TVVQF
        mJfLeYBxG1w4U2zSMC1XrCRTW7GXGezTMKbKH0lmzmbjM13dWsAUWY8w823DJJNdVwmYZyZ/
        xmR3Yp96RQvDTrBJCadY1b7wOGF80eqXaTd2nOk1BmaASYkOCChIh8DsqzU8D4vpCgBzZ+J1
        QLjGCwDOjP5KcsUzANu7JnmbG9dLHBuDcgBvuxYwrnAB2LKaw/eofOho2G3rxz3sS8ugczob
        94hwepiC2qZuzDMg6WCoc+pID4vocFj609C6BUHvgquP2wgPv0Ifg38MrOKcxhtaC+zrfQF9
        BNYby9bNcHonbHQW4hxL4Kj91noiSDcJ4bVRM+ByfwhzHpbzOfaBDkvdBvvB1abNhUsATtnu
        8rniZwAHL97c2H4PjtmW16JSaxZ74P3mfVz7IHRU6zFPG9Lb4e9Oby7EdpjXkI9zbRHUZok5
        dSDUW+79Z9vZP4DnApl+y2n6Lefot5yj/9+3GBCVQMJq1MlKVr0/hT0dpFYkqzUpyqDjqckm
        sPbWj1csiw9AhcMV1AUwCnQBSOEyX9HE+XNxYtEJxdlvWVVqrEqTxKq7wGsUIZOImuurYsW0
        UnGSTWTZNFa1OcUogTQDux1+PIY3/8n4sD9x1d2gNFx4XimgUMgd5kWEfH/26x/H7Da0vypf
        MkqM6WEfzeL6gFTRX+b6d/qmnpLX0KGWSVu48rODBVrNw1nFo+WzXyy0RPsFvHkuaWK5piy/
        uPKtqF/ORyz9XS04853paMJvCfQ3rfaBw2G+4s49JW/s6H93Fkz7bIt0XTIzparPQ1Ob/GMN
        2/rTH+kCC0snI3RzxLiyp+LecGRwUtRpR60hZPHrr0oypI11/SMjkWmhXvnH4kNWeobSHaF3
        L9cEQz1xQBKz8tLYNuT3XNWcecNdILjlLX0yUValM0a9nyiVnoqqLRReCXLuXjokz9hZXutF
        JiplhDpeEbwXV6kV/wIdY7s/RQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xu7q3PtYnGCyaKWTRdW8Hm0XHppms
        Fn8nHWO3WH23n81i44z1rBaN75QtJjxsY7doO7Od1eLZrb1MFu0f9zJbLGj9wm5x6aSuxdGz
        f5ksVjy7z2TRsesri8WevSdZLC7vmsNmMf3OezaLpdcvMlksPniA1eLSgQVMFk3LtrJYbN3f
        ymjRf+c6m8Xx3gNMFps3TWW2OP/3OKvFjw2PWR1kPNbMW8Po8fvXJEaPv3M/Mnss2FTqsWfi
        STaPzSu0PC6fLfXYtKqTzePduXPsHocOdzB6zDsZ6PF+31U2j74tqxg9Pm+S89j05C1TAH+U
        nk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsa8/3EF
        02QrzixWa2B8IN7FyMkhIWAiMXXJK7YuRi4OIYGljBITbj1kgUjISJyc1sAKYQtL/LnWBVX0
        nlGidc5FJpCEsECUxKW/75hBbBEBJYm3j/uYQYqYBW5ySCzZ+YQJouMZs8STz3vAqtgEDCW6
        3oKM4uTgFbCTWNp9BWwFi4CqxP/T+8BWiwokSdy7vJIZokZQ4uTMJ2BxToFAia2Ll7GD2MwC
        ZhLzNj9khrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrF
        ibnFpXnpesn5uZsYgelp27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHe+7U1CUK8KYmVValF+fFF
        pTmpxYcYTYH+mcgsJZqcD0yQeSXxhmYGpoYmZpYGppZmxkrivFvnrokXEkhPLEnNTk0tSC2C
        6WPi4JRqYGK2DdvgX/SrJOaB77Q3rO4LXRdzHcnS2D3XULg/vHeZ3f7JhX+EU9IusW98LGVs
        rbJl4beQy//MpK+Hy2/P/nDZUXK/xs4ny305Jm41evB0uuc8/tMX5zOdXe8W+OkXyyTTNTVL
        UhZ0PWCKqFd9cTFha/sEyZQ/uSkKlzgPqc56oufOwWYe9+fe5/yPx4NnNYunzIpycxL/Wbjt
        xbvgqzVXO9r+T604/1M7+++Gk0t4w7oYvtm02s2K1Hqa+/q2ypmauo2mRXu2tqjzHAzIEPm9
        Uaw8K6lx/rK5f/4Y8/XVBuUlPXZne1r3KUVg7u5dOX83ep4WFtBgnq/C8HnbkyMK7yqjHn54
        p2s1l+VFsbMSS3FGoqEWc1FxIgC7i2Ns2AMAAA==
X-CMS-MailID: 20210421093522eucas1p1f0bf1889f23b7a71e8ea35313273606c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8
References: <20210408103605.1676875-1-elver@google.com>
        <CGME20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8@eucas1p1.samsung.com>
        <20210408103605.1676875-6-elver@google.com>
        <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
        <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
        <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
        <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
        <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Marco,

On 21.04.2021 10:11, Marco Elver wrote:
> On Wed, 21 Apr 2021 at 09:35, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 21.04.2021 08:21, Marek Szyprowski wrote:
>>> On 21.04.2021 00:42, Marco Elver wrote:
>>>> On Tue, 20 Apr 2021 at 23:26, Marek Szyprowski
>>>> <m.szyprowski@samsung.com> wrote:
>>>>> On 08.04.2021 12:36, Marco Elver wrote:
>>>>>> Introduces the TRAP_PERF si_code, and associated siginfo_t field
>>>>>> si_perf. These will be used by the perf event subsystem to send
>>>>>> signals
>>>>>> (if requested) to the task where an event occurred.
>>>>>>
>>>>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
>>>>>> Signed-off-by: Marco Elver <elver@google.com>
>>>>> This patch landed in linux-next as commit fb6cc127e0b6 ("signal:
>>>>> Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes
>>>>> regression on my test systems (arm 32bit and 64bit). Most systems fails
>>>>> to boot in the given time frame. I've observed that there is a timeout
>>>>> waiting for udev to populate /dev and then also during the network
>>>>> interfaces configuration. Reverting this commit, together with
>>>>> 97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to let it
>>>>> compile, on top of next-20210420 fixes the issue.
>>>> Thanks, this is weird for sure and nothing in particular stands out.
>>>>
>>>> I have questions:
>>>> -- Can you please share your config?
>>> This happens with standard multi_v7_defconfig (arm) or just defconfig
>>> for arm64.
>>>
>>>> -- Also, can you share how you run this? Can it be reproduced in qemu?
>>> Nothing special. I just boot my test systems and see that they are
>>> waiting lots of time during the udev populating /dev and network
>>> interfaces configuration. I didn't try with qemu yet.
>>>> -- How did you derive this patch to be at fault? Why not just
>>>> 97ba62b27867, given you also need to revert it?
>>> Well, I've just run my boot tests with automated 'git bisect' and that
>>> was its result. It was a bit late in the evening, so I didn't analyze
>>> it further, I've just posted a report about the issue I've found. It
>>> looks that bisecting pointed to a wrong commit somehow.
>>>> If you are unsure which patch exactly it is, can you try just
>>>> reverting 97ba62b27867 and see what happens?
>>> Indeed, this is a real faulty commit. Initially I've decided to revert
>>> it to let kernel compile (it uses some symbols introduced by this
>>> commit). Reverting only it on top of linux-next 20210420 also fixes
>>> the issue. I'm sorry for the noise in this thread. I hope we will find
>>> what really causes the issue.
>> This was a premature conclusion. It looks that during the test I've did
>> while writing that reply, the modules were not deployed properly and a
>> test board (RPi4) booted without modules. In that case the board booted
>> fine and there was no udev timeout. After deploying kernel modules, the
>> udev timeout is back.
> I'm confused now. Can you confirm that the problem is due to your
> kernel modules, or do you think it's still due to 97ba62b27867? Or
> fb6cc127e0b6 (this patch)?

I don't use any custom kernel modules. I just deploy all modules that 
are being built from the given kernel defconfig (arm multi_v7_defconfig 
or arm64 default) and they are automatically loaded during the boot by 
udev. I've checked again and bisect was right. The kernel built from 
fb6cc127e0b6 suffers from the described issue, while the one build from 
the previous commit (2e498d0a74e5) works fine.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

