Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4C3679B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 08:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhDVGNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 02:13:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:19397 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhDVGNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:13:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210422061258euoutp0268a566c55ad870bd2a3d849680871fd3~4GWL0AY-J3088630886euoutp02e
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 06:12:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210422061258euoutp0268a566c55ad870bd2a3d849680871fd3~4GWL0AY-J3088630886euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619071978;
        bh=F0PjIyOcubJnY7+qhwxO7Q7JqOwk4FqnDrRIqy6JxX8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FHmXtW/r5uQfrbsUEdu3/vRloVWdgbF2aVYmbJ23Nmojbf3mMNrNt2vANHWfB2X2E
         blxygf4OZHaMPt78aDpiCz+kZo9NiKyqI7v7JHoUDFkA63GvbNIppHHi89fNhwIpKX
         Zgj/UK9uilvsF77zcitgNskBONZ8aabnTgKyFtEI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210422061258eucas1p1de7228b9f3acb3f7e5db89f5922b37ee~4GWLNMu8Q1409814098eucas1p1Q;
        Thu, 22 Apr 2021 06:12:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4C.B3.09452.9E311806; Thu, 22
        Apr 2021 07:12:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210422061257eucas1p1222af71d8da6a2e55bd93804c3be1869~4GWKkBDyv1326913269eucas1p1_;
        Thu, 22 Apr 2021 06:12:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210422061257eusmtrp2cb4fad19555e9b46202aba614594a2b0~4GWKilVPi0288702887eusmtrp2k;
        Thu, 22 Apr 2021 06:12:57 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-b4-608113e99344
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.23.08696.9E311806; Thu, 22
        Apr 2021 07:12:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210422061255eusmtip24d75f5e31ad58c0e9c546589fa2cbbaa~4GWI9jJcF2898528985eusmtip2A;
        Thu, 22 Apr 2021 06:12:55 +0000 (GMT)
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <dd99b921-3d79-a21f-8942-40fa5bf53190@samsung.com>
Date:   Thu, 22 Apr 2021 08:12:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBtr2w/8KhOoiUA@elver.google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzN7Xt9LQ2wB8i4EZGkui00UiVzyU0wiHMxL9vYV9Bp3QKdvIAI
        RVu6uWXGVrErH1roMrBFPgITmq6ItiDala/y0XUbhZUBs0OUwZTgAFFYnFAZ7ZON/8753fM7
        53eSy8VCu4mN3KOSXFoqEWfxCR5+vfef/tjpMGXqjuIlgArGbhBIbdaxkVfby0Hf3dYQ6NrF
        RjZSzm5BxeMqDlL93MJG9zytLPTVfCuGqs8tcJDbGYt6+rwslKevwZHh3h0WUlsXcWSeGGYj
        W6sTR4PWSwQqG50jUP6CnkCXR35hodrODjZyd1Sz0Jm6Zhw1t58DSDM6QiDH+Q4Wspi/wVC/
        18FGT65OsBOjKVOlCVBLT7WA8lbMY1S1WU7ZSpwEZTEIqME+OWU25hPUrMvFoexdakBVOt+n
        LN+eps6fnSWoubYhgrrQZATUY/Pm90JEvF1pdNbRT2np9oRUXsb9H+5wjlduPdnwsAdTgNKo
        AhDAheROaDMp2D4cShoAtBnjCwBvFS8AeE1bhTHkMYB388Y5axu6KdPzjXoA5zTHGNE8gI7F
        Xr8ojBTBLtcA5sMbSD6cmbjgd8LIjgDo+LrEv02QcbBgpoDw4SAyAc6axvxznHwJFukr/PNw
        8hN4y72CMZoQ6NRN4j4cQO6ACkONPwwjo2HLzCWMwRHQM1nF8oVBcogHXa21q4S7St6Af9Vl
        Mw3C4LSj6XmbTXDl5pr+LIDjrgYOQ4oAHDxzETCqeDjqekr4jDAyBjZatzOee+DV5UAGBsPf
        ZkKYE4Kh9noZxoyDoFoVyni8DPWOK/+ldg64sWLA168rpl9XRr+ujP7/2GqAG0EELZdlp9Oy
        OAn9mVAmzpbJJenCIznZZrD60X965nh0A1RMzwvtgMUFdgC5GH9DUINMkRoalCb+/AtampMi
        lWfRMjuI5OL8iCBjuSkllEwX59LHaPo4LV17ZXEDNipYUcrlvMzhzZ1xnV3pY5FZ6sG3c0R1
        +FSfsz3xhOCELv/3sK1dDwr3Pgq2En9mGvYkpcSoPs47UjR1quSjvd3wxdlD3vCTmt0PrMqd
        0VhueZSjpTU5JV7iGR7QLu+nhP1fLkrfNcR6DpsOHOj/8e+VfXdfqX+1Z6ld/TDw9pWbbnfN
        mDCp2jYUUnr417kXip4EawJK7wdaO5qwTbbJzLJ3JG1vbjHUbkvmnt7W9eH+yL4kUUblEG+p
        dvfB76OSY/ILhVWNharS8pK3JpT7YhM8dUPLbSLLs/ARrSQR65HZmxebdLdaptJGD8V0A8Eu
        ZdUHr7sFvY7XLicdPFX8R3d0s63ewsdlGeI4ASaVif8F5/V6YVcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsVy+t/xe7ovhRsTDNbsErHoureDzaJj00xW
        i7+TjrFbrL7bz2axccZ6VovGd8oWEx62sVu0ndnOavHs1l4mi/aPe5ktFrR+Ybe4dFLX4ujZ
        v0wWLbMWsViseHafyaJj11cWi02Pr7Fa7Nl7ksXi8q45bBbT77xns+j8MovNYun1i0wWiw8e
        YLW4dGABk0XTsq0sFlv3tzJa9N+5zmZxvPcAk8XmTVOZLc7/Pc5q8WPDY1YHeY8189Ywevz+
        NYnR4+/cj8weCzaVeuyZeJLNY/MKLY/LZ0s9Nq3qZPN4d+4cu8ehwx2MHvNOBnpsXlLv0dv8
        js3j/b6rbB59W1YxenzeJBcgGKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSq
        pG9nk5Kak1mWWqRvl6CX8fzEffaCeSoVaz8cZW5gnCbbxcjJISFgIjHzxRrWLkYuDiGBpYwS
        DedWMEIkZCROTmtghbCFJf5c62KDKHrPKHHz/g0WkISwQJTEpb/vmEFsEQElibeP+5hBipgF
        DnFK/H/yCarjHKvE4d5TbCBVbAKGEl1vu8BsXgE7iXdr7oGtYBFQleiZNRcsLiqQJHHv8kpm
        iBpBiZMzn4Bt4xQwkGhYsYgdxGYWMJOYt/khM4QtL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUW
        kpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECExk24793LKDceWrj3qHGJk4GA8x
        SnAwK4nwri1uSBDiTUmsrEotyo8vKs1JLT7EaAr0z0RmKdHkfGAqzSuJNzQzMDU0MbM0MLU0
        M1YS5zU5siZeSCA9sSQ1OzW1ILUIpo+Jg1OqgWl/8kO9Xk6fOwmTK80v3QwROD1TpaJLfbtF
        p4/K0YSP57cayDbeWms798rr3Zs+HvMNvnzyXILrqrc1W7Z0tihPb716IMdCY8neiDCLPHbr
        m1v6vZwfyTl3n9k610niuPTVY0ohs+3rxBUKv21ceH6Cv6qI5tJ74oyFJ9jYNToV/D9a35ZN
        ctnjemKWy70LF+67GuUYrj6RdnXZxDq/SWF1O5yehO6+V7Do4MlX21tcmyZ7m6jWrYi1DDZK
        trTRfzL/1KL716pvi8z4uzDN/Y6QreeJd7PWLd+mdFhf96TUnsfzllx84D7t/uPyZ+9NvbgK
        dBme5bQ/ubN0u5DjzRiLu8bqIYKWn+M9bssuUhFXYinOSDTUYi4qTgQAiY5lx+0DAAA=
X-CMS-MailID: 20210422061257eucas1p1222af71d8da6a2e55bd93804c3be1869
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210421182355eucas1p23b419002936ab5f1ffc25652135cc152
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210421182355eucas1p23b419002936ab5f1ffc25652135cc152
References: <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
        <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
        <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
        <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
        <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com>
        <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
        <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com>
        <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
        <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
        <YIBSg7Vi+U383dT7@elver.google.com>
        <CGME20210421182355eucas1p23b419002936ab5f1ffc25652135cc152@eucas1p2.samsung.com>
        <YIBtr2w/8KhOoiUA@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Marco,

On 21.04.2021 20:23, Marco Elver wrote:
> On Wed, Apr 21, 2021 at 06:27PM +0200, Marco Elver wrote:
>> On Wed, Apr 21, 2021 at 05:11PM +0200, Marco Elver wrote:
>>> +Cc linux-arm-kernel
>>>
>> [...]
>>>> I've managed to reproduce this issue with a public Raspberry Pi OS Lite
>>>> rootfs image, even without deploying kernel modules:
>>>>
>>>> https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip
>>>>
>>>> # qemu-system-arm -M virt -smp 2 -m 512 -kernel zImage -append "earlycon
>>>> console=ttyAMA0 root=/dev/vda2 rw rootwait" -serial stdio -display none
>>>> -monitor null -device virtio-blk-device,drive=virtio-blk -drive
>>>> file=/tmp/2021-03-04-raspios-buster-armhf-lite.img,id=virtio-blk,if=none,format=raw
>>>> -netdev user,id=user -device virtio-net-device,netdev=user
>>>>
>>>> The above one doesn't boot if zImage z compiled from commit fb6cc127e0b6
>>>> and boots if compiled from 2e498d0a74e5. In both cases I've used default
>>>> arm/multi_v7_defconfig and
>>>> gcc-linaro-6.4.1-2017.11-x86_64_arm-linux-gnueabi toolchain.
>>> Yup, I've narrowed it down to the addition of "__u64 _perf" to
>>> siginfo_t. My guess is the __u64 causes a different alignment for a
>>> bunch of adjacent fields. It seems that x86 and m68k are the only ones
>>> that have compile-time tests for the offsets. Arm should probably add
>>> those -- I have added a bucket of static_assert() in
>>> arch/arm/kernel/signal.c and see that something's off.
>>>
>>> I'll hopefully have a fix in a day or so.
>> Arm and compiler folks: are there some special alignment requirement for
>> __u64 on arm 32-bit? (And if there is for arm64, please shout as well.)
>>
>> With the static-asserts below, the only thing that I can do to fix it is
>> to completely remove the __u64. Padding it before or after with __u32
>> just does not work. It seems that the use of __u64 shifts everything
>> in __sifields by 4 bytes.
>>
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index d0bb9125c853..b02a4ac55938 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -92,7 +92,10 @@ union __sifields {
>>   				__u32 _pkey;
>>   			} _addr_pkey;
>>   			/* used when si_code=TRAP_PERF */
>> -			__u64 _perf;
>> +			struct {
>> +				__u32 _perf1;
>> +				__u32 _perf2;
>> +			} _perf;
>>   		};
>>   	} _sigfault;
>>
>> ^^ works, but I'd hate to have to split this into 2 __u32 because it
>> makes the whole design worse.
>>
>> What alignment trick do we have to do here to fix it for __u64?
> So I think we just have to settle on 'unsigned long' here. On many
> architectures, like 32-bit Arm, the alignment of a structure is that of
> its largest member. This means that there is no portable way to add
> 64-bit integers to siginfo_t on 32-bit architectures.
>
> In the case of the si_perf field, word size is sufficient since the data
> it contains is user-defined. On 32-bit architectures, any excess bits of
> perf_event_attr::sig_data will therefore be truncated when copying into
> si_perf.
>
> Feel free to test the below if you have time, but the below lets me boot
> 32-bit arm which previously timed out. It also passes all the
> static_asserts() I added (will send those as separate patches).
>
> Once I'm convinced this passes all others tests too, I'll send a patch.

This fixes the issue I've observed on my test systems. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> Thanks,
> -- Marco
>
>
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index c8821d966812..f0d2dd35d408 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -237,7 +237,7 @@ typedef struct compat_siginfo {
>   					u32 _pkey;
>   				} _addr_pkey;
>   				/* used when si_code=TRAP_PERF */
> -				compat_u64 _perf;
> +				compat_ulong_t _perf;
>   			};
>   		} _sigfault;
>   
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d0bb9125c853..03d6f6d2c1fe 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -92,7 +92,7 @@ union __sifields {
>   				__u32 _pkey;
>   			} _addr_pkey;
>   			/* used when si_code=TRAP_PERF */
> -			__u64 _perf;
> +			unsigned long _perf;
>   		};
>   	} _sigfault;
>   
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

