Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915B784CA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjHVWFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHVWFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:05:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D311F;
        Tue, 22 Aug 2023 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692741895; x=1693346695; i=deller@gmx.de;
 bh=xY/2+QyySjuCzXpTOznTGPpaO1FAuAXckq+otWDEeRc=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=meesxSB46CrRLY9BxOovDIYo2YRRIJGmrq8c4Mn/YACOlv8SLaFu0xL77Tvwq6CcvmMl3FK
 qfLZmKHuXwB8I0oUtxEMzvf8zX8+ciEA74z05kizeYLFOgMRe6rp9KoXeulZ0HG9EVuXYa8g3
 cUVeRWNJsE22hjS9KEo368UFkCrM7E+K2JmjHHUfCHgSXpCRsx6d/Y5SHK9lpcZMK/o318jME
 hUsz35X0gtBYBGMfH8bEQ2DuZBw1Chk6L/A8uXKhATQ1TC1/vy3mPI3vpRinKpt+whYjZDQi2
 /e1hHNF+bqaqQYAkOMh6jkxapydHWxbOq3TUpLNPfweOipjJ+2Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1qet1b3Tuj-006yac; Wed, 23
 Aug 2023 00:04:54 +0200
Message-ID: <a1a19e05-0cfd-cae5-9edb-9d63e70ee06d@gmx.de>
Date:   Wed, 23 Aug 2023 00:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] procfs: Fix /proc/self/maps output for 32-bit kernel
 and compat tasks
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        linux-parisc <linux-parisc@vger.kernel.org>
References: <ZOR95DiR8tdcHDfq@p100>
 <20230822113453.acc69f8540bed25cde79e675@linux-foundation.org>
 <8eb38faf-16a2-a538-b243-1b4706f73169@gmx.de>
In-Reply-To: <8eb38faf-16a2-a538-b243-1b4706f73169@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JVY7fCK5v9wIrnBlZE4htJ33HQe7Ld+JMw3YMCTGofeBjCy3OgZ
 rTXx/E1wJNn79gz8MRdNvff7mqPJoKUIjNw8MCXIyGiV+6hWFRBniI7FLg9gcmLMfnSaksb
 sKKBkBNqEeBKYCDvBtgJdJgDASkArsTdP1lV6mRumtKCtVog4HEOiJXM2JrN5xk5nvWz+pv
 hiMGYC1sLRU432TNN20zg==
UI-OutboundReport: notjunk:1;M01:P0:3C4JX0WuOeA=;DvqILYy0YE33/S8D4xbe+hBWs7q
 jK6K5mTdoZG1Femfk2n6BevtKXkb2O/4iPOdeYUlGtyl5CVel4QeHc9gUH7K7eLr6ln1xbDkc
 kcRpuba2zahxX4IhQ37cXSRIvI4d5qKV/xYB9SsXkT5ukrRp6cPiPTkURt4bXhOJiflqNnaCT
 Nhqz9pfMfxUEarrAslbTEoQb3P3sii8yibUJMgo15iJRibXjQlXixB2clVRXxCVYAxmyGQH6F
 luOTNqCYvW5ROw/6PTaIwG1G9KJIlbPlbbfdohjozLgmZrW1WPMJXcKH3pmSdrYMBDYgBF90b
 PJd6Ip4SbUuGK+VMYcrk5MhC6kL3EFDksBn7HKr+kcdyqW+0dSmKyOIavfSY4ngtxiVeiP/QZ
 3tuHqbyObEKTHa+ZX77yQI2Yo4vp1JEHG+48j/35NR0BqjRd3a0xIb5IEFdFIj2gSgPoE9ipJ
 BCpzVKyFUKzl725Rl2h1IDIpycb4vArBFv9QodL3URgIs14I9lbUsSCcKPFoDmgVl40rV+k89
 9VokyzyQIgwvLT2UI/MAfIafwcHlfg6diYRSUgWdVn6ph/QMqe6FjJ2OSEtGaOLe5nX89+ufB
 4w+T8RNg84SkCVyaRVZ+Gj/FfWVy3TefGbqNcTpj/y1wjHv2jxqk2grhAmr3zNYI3yMtqcbPf
 Ph89IybQsT2smPLaGbuh/BC5TH3SW6rgKwc+xHjeJLaj3Z0xU0k4af9RXyPgcr8K9Z91TzOJh
 ybaUliMY1MOMzA/Uwrz/jivCf6W8SPM3CC83Ns5wN8CRfXkE5EowbPUZtyTLMNURS2fiLHEJd
 BIqpEu49BdUkUZ0p61/owNURVpGz0PbXWVyYkcqlHsVXCULZxcWJnSay+kClzJ5ZTky7Isfqp
 YahjHHkAvWYp3aS0TNxKPtr2say9YgH1e0dKhRRrizX9gBP9GZNMDECPRc/OqpnpXhGgF6mFb
 TIdSBO2geJO9OLtQSS/sfTD5+us=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/22/23 22:53, Helge Deller wrote:
> On 8/22/23 20:34, Andrew Morton wrote:
>> On Tue, 22 Aug 2023 11:20:36 +0200 Helge Deller <deller@gmx.de> wrote:
>>
>>> On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:
>>>
>>> root@debian:~# cat /proc/self/maps
>>> 00010000-00019000 r-xp 00000000 08:05 787324=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/bin/cat
>>> 00019000-0001a000 rwxp 00009000 08:05 787324=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/bin/cat
>>> 0001a000-0003b000 rwxp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [heap]
>>> f7551000-f770d000 r-xp 00000000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/libc.so.6
>>> f770d000-f770f000 r--p 001bc000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/libc.so.6
>>> f770f000-f7714000 rwxp 001be000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/libc.so.6
>>> f7d39000-f7d68000 r-xp 00000000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/ld.so.1
>>> f7d68000-f7d69000 r--p 0002f000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/ld.so.1
>>> f7d69000-f7d6d000 rwxp 00030000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 /=
usr/lib/hppa-linux-gnu/ld.so.1
>>> f7ea9000-f7eaa000 r-xp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [vdso]
>>> f8565000-f8587000 rwxp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [stack]
>>>
>>> But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed u=
p
>>> /proc/pid/maps") even on native 32-bit kernels the output looks like t=
his:
>>>
>>> root@debian:~# cat /proc/self/maps
>>> 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324=
=C2=A0 /usr/bin/cat
>>> 0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 7873=
24=C2=A0 /usr/bin/cat
>>> 000000001a000-000000003b000 rwxp 00000000 00:00 0=C2=A0 [heap]
>>> 00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 79=
4765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>> 00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:000000=
005 794765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>> 00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:000000=
005 794765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>> 00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 79=
4759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>> 00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:0000000=
05 794759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>> 00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:0000000=
05 794759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>> 00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0=C2=A0 [vdso]
>>> 00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0=C2=A0 [stack]
>>>
>>> This patch brings back the old default 8-hex digit output for
>>> 32-bit kernels and compat tasks.
>>>
>>> Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pid=
/maps")
>>
>> That was five years ago.=C2=A0 Given there is some risk of breaking exi=
sting
>> parsers, is it worth fixing this?
>
> Huh... that's right!
> Nevertheless, kernel 6.1.45 has it right, which isn't 5 years old.
> I don't see the reason for that change right now, so I'll need to figure=
 out what changed...

It seems to be due to a new bug in gcc's __builtin_clzll()
function (at least on parisc), which seems to return values
for "long" (32bit) instead for "long long" (64bit).

Please ignore this patch for now.

Thanks!
Helge
