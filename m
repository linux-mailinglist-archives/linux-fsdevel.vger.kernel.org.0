Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269D36664D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhDUHgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 03:36:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44714 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhDUHgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:36:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210421073526euoutp02418f3feedced1a31d167c684ac44c2e4~3z05hwKsx1717817178euoutp02p
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 07:35:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210421073526euoutp02418f3feedced1a31d167c684ac44c2e4~3z05hwKsx1717817178euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618990526;
        bh=iNC2JGm8JQHaUP5EaOW6wGw0f6laDFIqRjY1Uqk+010=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p3g/qabOb6gJjJIe1GTQzPp5yyjDmt5dqBSi6Addz7C4D4Qhymfn5KZjMtuhVPaVM
         /0k40b40jCl+bcIFR5NERgUCpAyONEyPt6+4hVFqKkH/HUuFh71tyVkWg77/Dz0eLS
         lwemosuuEYHH62LOF1iIZaAfTp/pT04k1iEqf3go=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210421073525eucas1p20a9f991a5acec3b37967fcdb969dcaa8~3z0423X791121811218eucas1p2N;
        Wed, 21 Apr 2021 07:35:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.05.09452.DB5DF706; Wed, 21
        Apr 2021 08:35:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210421073525eucas1p2de039236195308aa06fdee8b77fe01c7~3z04M84bi0689506895eucas1p2Z;
        Wed, 21 Apr 2021 07:35:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210421073525eusmtrp18822b2b5a245e7875a4a08a4bb655afb~3z04LUbIY3012430124eusmtrp1e;
        Wed, 21 Apr 2021 07:35:25 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-91-607fd5bd2d9f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.32.08705.CB5DF706; Wed, 21
        Apr 2021 08:35:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210421073523eusmtip246be203a67bd3d460f00b7af00eb9498~3z02pxT2U0194101941eusmtip2x;
        Wed, 21 Apr 2021 07:35:23 +0000 (GMT)
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and
 si_perf to siginfo
From:   Marek Szyprowski <m.szyprowski@samsung.com>
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
Message-ID: <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
Date:   Wed, 21 Apr 2021 09:35:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1DTZRzHe76/9mW59WViPKGH3TjlsAOCs3q0DrPr8uvZeXrdJe0qWPrl
        R/LDbS7MREEOGjtAGZY6FFaRcIBuTRgymeIo1o4xYRyhHor8CAUb3FKLqFF++V7Ff6/P53l/
        ns/7/dxD4zILFUFn5uzn1DnKLDklJmzdf1yPdQweSX3R+Es80t+5RCGd9TSJgoZuEWq6fYxC
        350yk6hwJgodHy0RoRJPG4kmbzkw9HnAgSNT8SMR8rlj0Q+9QQw1TI5gSGd/TKAOh5tAA/Yz
        FDo5PEuhb4f6MfTNtU4S+TpNGDp6rpVArVeLATo2PEQhV3knhi5av8DR9aCLRHOWcfL1VWxz
        TTNg/5w3ADZ4NoCzJquW7ah0U+zFhnXsQK+WtTaWUuyM1ytinV06wNa4d7KzVwYptqKlEbAP
        rZGsdcKP7XhGIX5tD5eV+Qmnjk9KFWfYH5tF+wLPHqgr9JEFoFWmBzQNmfXQdnmXHoTQMqYB
        wAffhwr8CMDAiErghwBeufE8z7y8rsVB6IH4Sb8ewBablxSKAIBGmx7jVcsZBezy9uE8U0wC
        1Pv1FM9hjBz6xytwfgBnBmmoa+/CeBcSJgnWTW/lNQSzBtbqRhZnVzAfwZu+vxdZwoRC9+kJ
        gucQZhM8b6leZJxZDdv8Z3CBw+GtiVqMvx8yDjG8oG+nBNtvwlmbBxd4OZx2tYgEXgV7qsoI
        YaAIwFHveZFQlAE4cPQUEFSvwmHvPMU7xZkYaLbHC+3NcNpixIRnlMIb/lDBhBQabCdxoS2B
        uhKZoF4Lja4L/6291ufDjwO5cUk045I4xiVxjP/vNQGiEYRzWk12OqdJyOHy4jTKbI02Jz1u
        d262FTz51D0Lrl8vgbPTgTgnwGjgBJDG5WGSkfxDqTLJHuWnBzl1bopam8VpnGAlTcjDJY3V
        zSkyJl25n9vLcfs49b+nGB0SUYDFlN3TFm/vfvf3WOdYRFpUkssyNTbWbyi+vEnliWub8wdL
        PRvUivIJhWohrRzr21ihWvP17uqt9o5sc9T7D642sFkKQ9Mbwe3RJulm2+3D7pdD31MHKsNS
        0yT5PxbFSV/am/ccmL154C4WPBTTmxh/sMBXuEWFP61ySTMTa+/137Unj29smvlqWdGH3oQj
        huCybXkxnE6x463IDlPrgm7ttrdH71cOVddUbdglVQ6l6NXGjM4TaOVfny3Q0Vni33qche84
        B2elAVJW/zE5Wbrzqcj8OV1ybnR3Z45pYioEM5/rKR7ZEpZYn3zn5xXt65vJFzxTq39K+eDw
        /dKM1C9fma+SE5oMZcI6XK1R/gNsDtkAQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xe7p7rtYnGPw+bGPRdW8Hm0XHppms
        Fn8nHWO3WH23n81i44z1rBaN75QtJjxsY7doO7Od1eLZrb1MFu0f9zJbLGj9wm5x6aSuxdGz
        f5ksVjy7z2TRsesri8WevSdZLC7vmsNmMf3OezaLpdcvMlksPniA1eLSgQVMFk3LtrJYbN3f
        ymjRf+c6m8Xx3gNMFps3TWW2OP/3OKvFjw2PWR1kPNbMW8Po8fvXJEaPv3M/Mnss2FTqsWfi
        STaPzSu0PC6fLfXYtKqTzePduXPsHocOdzB6zDsZ6PF+31U2j74tqxg9Pm+S89j05C1TAH+U
        nk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaur+vZ
        Cz6KVSxpvMTawLhVqIuRk0NCwERiyZa9LCC2kMBSRomXhwIh4jISJ6c1sELYwhJ/rnWxdTFy
        AdW8Z5R487CRHSQhLBAlcenvO2YQm03AUKLrLUgRJ4eIgJLE28d9zCANzAI3OSSW7HzCBNH9
        ikli28qPQA4HB6+AncSSV54gDSwCqhLzO+6DDRIVSJK4d3klmM0rIChxcuYTsOs4Bewl1m6Y
        DWYzC5hJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bn
        FhvqFSfmFpfmpesl5+duYgSmp23Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeO/X1iQI8aYkVlal
        FuXHF5XmpBYfYjQF+mcis5Rocj4wQeaVxBuaGZgamphZGphamhkrifNunbsmXkggPbEkNTs1
        tSC1CKaPiYNTqoFpR83eJUpa2Zkrth3UFmJvi0o89WLNjLY3149aqCsXrnqX+ohhquiGI0k7
        2R7GfBdmTi1J1ZFNuiI1pY9D3PJ+xcmnIU0HmNIaWounLbfcNMVO4oaPcvaR/Wwv303z0qg+
        HVEXatT8oGDho+MOij2Pykz4v8vOfPH+k0dtulO+puoMGeFTUup+Dr6lDpOUL53x2LTOPJ/3
        UCt32onLnqqpGV5HHhqLZxlq/bnt+ElgepnG/Lvv/7SI260+zCN66vIRhYlvDrgrfNeen33i
        tU3Ng26eJ4aK77bMPnMjXJvL4cyr5YwGm7ySH99tuWnlxnRpkjjj2/aJ3YV6s/fIlb9+rnBv
        pbPS1/rr0wr2PwlTYinOSDTUYi4qTgQAWVBtBtgDAAA=
X-CMS-MailID: 20210421073525eucas1p2de039236195308aa06fdee8b77fe01c7
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.04.2021 08:21, Marek Szyprowski wrote:
> On 21.04.2021 00:42, Marco Elver wrote:
>> On Tue, 20 Apr 2021 at 23:26, Marek Szyprowski 
>> <m.szyprowski@samsung.com> wrote:
>>> On 08.04.2021 12:36, Marco Elver wrote:
>>>> Introduces the TRAP_PERF si_code, and associated siginfo_t field
>>>> si_perf. These will be used by the perf event subsystem to send 
>>>> signals
>>>> (if requested) to the task where an event occurred.
>>>>
>>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
>>>> Signed-off-by: Marco Elver <elver@google.com>
>>> This patch landed in linux-next as commit fb6cc127e0b6 ("signal:
>>> Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes
>>> regression on my test systems (arm 32bit and 64bit). Most systems fails
>>> to boot in the given time frame. I've observed that there is a timeout
>>> waiting for udev to populate /dev and then also during the network
>>> interfaces configuration. Reverting this commit, together with
>>> 97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to let it
>>> compile, on top of next-20210420 fixes the issue.
>> Thanks, this is weird for sure and nothing in particular stands out.
>>
>> I have questions:
>> -- Can you please share your config?
>
> This happens with standard multi_v7_defconfig (arm) or just defconfig 
> for arm64.
>
>> -- Also, can you share how you run this? Can it be reproduced in qemu?
> Nothing special. I just boot my test systems and see that they are 
> waiting lots of time during the udev populating /dev and network 
> interfaces configuration. I didn't try with qemu yet.
>> -- How did you derive this patch to be at fault? Why not just
>> 97ba62b27867, given you also need to revert it?
> Well, I've just run my boot tests with automated 'git bisect' and that 
> was its result. It was a bit late in the evening, so I didn't analyze 
> it further, I've just posted a report about the issue I've found. It 
> looks that bisecting pointed to a wrong commit somehow.
>> If you are unsure which patch exactly it is, can you try just
>> reverting 97ba62b27867 and see what happens?
>
> Indeed, this is a real faulty commit. Initially I've decided to revert 
> it to let kernel compile (it uses some symbols introduced by this 
> commit). Reverting only it on top of linux-next 20210420 also fixes 
> the issue. I'm sorry for the noise in this thread. I hope we will find 
> what really causes the issue.

This was a premature conclusion. It looks that during the test I've did 
while writing that reply, the modules were not deployed properly and a 
test board (RPi4) booted without modules. In that case the board booted 
fine and there was no udev timeout. After deploying kernel modules, the 
udev timeout is back.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

