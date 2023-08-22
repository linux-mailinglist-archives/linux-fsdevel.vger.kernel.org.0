Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF23784BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHVUxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHVUxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:53:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCDCF1;
        Tue, 22 Aug 2023 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692737584; x=1693342384; i=deller@gmx.de;
 bh=Are6fJPpf2GrCvnn9ZLWc5stlCBG5A9K0k7+zpI9a8Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UujIy8J0m7z64qJb0ZOxeYC9Gvweu+iD6LFb4WB2LNfULYTEroAlTYCJXVRDTNjyP4EOGq9
 79ZP0yWKvd8KtmFtKhaQDhshPtZ95hn59R0KADQnIKr92E143JmXojqakwRNqG9KbbSBGIMaR
 0MWlTCRPOdUMhfxUsYAt4TbDVywa9cloMOSb+svjm6rxHx6AKlxbyc0GldNGS4Vd5+Y0s8G1b
 bB71SIGCq+LqAmSKdaobp42QeOGfehBiJS7MkXybhEJ6mlrGF1SEHlzTE99rhlF6/A8lCEqXq
 oDpG0u6saaH4Hxns7dzmBaR6tOSu5X1X3glLUkdRO+QzZpNB5RHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.33]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1pxpxy2zaU-00pIUc; Tue, 22
 Aug 2023 22:53:04 +0200
Message-ID: <8eb38faf-16a2-a538-b243-1b4706f73169@gmx.de>
Date:   Tue, 22 Aug 2023 22:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] procfs: Fix /proc/self/maps output for 32-bit kernel
 and compat tasks
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        linux-parisc <linux-parisc@vger.kernel.org>
References: <ZOR95DiR8tdcHDfq@p100>
 <20230822113453.acc69f8540bed25cde79e675@linux-foundation.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230822113453.acc69f8540bed25cde79e675@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2Kl7fJqaZBWh9Ge4eOt4afWk1M7tcFHymfxHhnsjV3CSTNZfmR
 1uZx262VXCN2nx5scteMT1bm02yduGYH8KSgk75gdJt1IwHi5qalWXvr19AbF48t3hJTNSE
 gj7ynSJUDYqvuTXq8+Yj90ia2P7X+9vTEhb84iam+zyTQoMB/cqO6elXMJ7/xW518AzMCtM
 Vd+5E1AWjpXeZXQlaqfBw==
UI-OutboundReport: notjunk:1;M01:P0:DQWp0+C5sEs=;2SSbkYGD35JglifMG+0f7Cs6yQe
 2SOsq+13+EA0K8AXGDvPW0ckDO2LjZjbLoFt6mibNPeR/gEvBCLnTY8XdtIAFseZAdRxHgAvH
 nNvyGpa8Lxj5ftE5RL8bFgKWAIWBIUQXr3DRHJdMgJOhHj6uvf59E9mg4o9S5PB2W/bWqQ9SE
 SggECNYkNmsq4rSTQZ6J7UYXAZFP4uwsHsaujxkD0eOsJSxlSL78l/blbobEJvkczyR55pvD6
 OWCNMUDabBEZ4D94JV+hvcMEZVe3N0z/9ezC9os/UKvkvXv5G/TBSb5RJOvUAVrygM1bJhO0a
 XOvLmlHhxWcJB3lioxYIuqvNVmmqtzHzW2fMC7an9SejOp70AewQWzvxCuBqYS8nQPJqRnKG0
 LVaM82wxi0N4KvEycqkiF1S+Conef3i3EBtZOMpR6gSfpx9UQ1P1Yrv6g2tVtbETdTklvoDw5
 nChBorxWHHaWOnVnpDOqmr0l+rzhXecqVwDklIn3KgpFzLxxSZW5uOIWWM8qZEysOLD9R1Lo5
 MDqt47mxQvMMN67MP3isT9mw5UV30P88gUnhelvf5icpbm/L12Tz9qbahtOYdcERySJ1vkW2o
 bGCKwAn0rG3mo/sMPa7pxyi4WHH3JiBG7xYuQXF8pQTWKFXBkWIsripN2P11f9glAtvLp6fMN
 HpW9XocWb+9moiogNFwAi64EcN/rsDdSXBD0kRaiRIT6/FYxGOvx70lemiQWriLcjhD0uSab/
 pEefJVqtSbmHMGz3bzkKVZd+yOrB5uOnN8Zw7HkryzLktvAkVtfxZgaxDtVtoxrIak/K2yi0T
 ZyMuASjBRtGkQ20TskOuelCXhWM2r1k+nfXZj3gl0/RRZNNp9Uw8VeyVc/ldZp9dsDMctByPY
 O8G4lp/N+J7V3Cx17F3Esqy8rSm6oVhTE+/WEJRmyO9E8AZPrilmHXfEVauyyEHLsxmWBtvtZ
 zVcfQg==
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

On 8/22/23 20:34, Andrew Morton wrote:
> On Tue, 22 Aug 2023 11:20:36 +0200 Helge Deller <deller@gmx.de> wrote:
>
>> On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:
>>
>> root@debian:~# cat /proc/self/maps
>> 00010000-00019000 r-xp 00000000 08:05 787324     /usr/bin/cat
>> 00019000-0001a000 rwxp 00009000 08:05 787324     /usr/bin/cat
>> 0001a000-0003b000 rwxp 00000000 00:00 0          [heap]
>> f7551000-f770d000 r-xp 00000000 08:05 794765     /usr/lib/hppa-linux-gn=
u/libc.so.6
>> f770d000-f770f000 r--p 001bc000 08:05 794765     /usr/lib/hppa-linux-gn=
u/libc.so.6
>> f770f000-f7714000 rwxp 001be000 08:05 794765     /usr/lib/hppa-linux-gn=
u/libc.so.6
>> f7d39000-f7d68000 r-xp 00000000 08:05 794759     /usr/lib/hppa-linux-gn=
u/ld.so.1
>> f7d68000-f7d69000 r--p 0002f000 08:05 794759     /usr/lib/hppa-linux-gn=
u/ld.so.1
>> f7d69000-f7d6d000 rwxp 00030000 08:05 794759     /usr/lib/hppa-linux-gn=
u/ld.so.1
>> f7ea9000-f7eaa000 r-xp 00000000 00:00 0          [vdso]
>> f8565000-f8587000 rwxp 00000000 00:00 0          [stack]
>>
>> But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up
>> /proc/pid/maps") even on native 32-bit kernels the output looks like th=
is:
>>
>> root@debian:~# cat /proc/self/maps
>> 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324  /=
usr/bin/cat
>> 0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 78732=
4  /usr/bin/cat
>> 000000001a000-000000003b000 rwxp 00000000 00:00 0  [heap]
>> 00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 794=
765  /usr/lib/hppa-linux-gnu/libc.so.6
>> 00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:0000000=
05 794765  /usr/lib/hppa-linux-gnu/libc.so.6
>> 00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:0000000=
05 794765  /usr/lib/hppa-linux-gnu/libc.so.6
>> 00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 794=
759  /usr/lib/hppa-linux-gnu/ld.so.1
>> 00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:00000000=
5 794759  /usr/lib/hppa-linux-gnu/ld.so.1
>> 00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:00000000=
5 794759  /usr/lib/hppa-linux-gnu/ld.so.1
>> 00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0  [vdso]
>> 00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0  [stack]
>>
>> This patch brings back the old default 8-hex digit output for
>> 32-bit kernels and compat tasks.
>>
>> Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pid/=
maps")
>
> That was five years ago.  Given there is some risk of breaking existing
> parsers, is it worth fixing this?

Huh... that's right!
Nevertheless, kernel 6.1.45 has it right, which isn't 5 years old.
I don't see the reason for that change right now, so I'll need to figure o=
ut what changed...

Helge
