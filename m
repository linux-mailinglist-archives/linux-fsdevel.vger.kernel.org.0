Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21C2785523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjHWKPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjHWKOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:14:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398EFEE;
        Wed, 23 Aug 2023 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692785671; x=1693390471; i=deller@gmx.de;
 bh=+vjVPKDrBOyCnqJ4pbOmswE10ObdhKDRZDAv7WIvODs=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=U2IboGXy1UTBXX2U2qDOIpIq8HRll3xR4k2DYkCpGHQiDnjh0/XvJE5R3vlkKRNMFGbulab
 zD2oHpPG/ls/vHACZV1t4qAJrb5BNbpZF1GeyEfzzdztH8jD6m4R4rdUhAmzdwDsPx/x3cjB1
 hxs/TuXP4HwUtmYXGC/tFjEKfFXxdScOuWkD0iJJBlLJAKSuQtt54xuf+4BFxunMW/ACJAEPI
 l2M0fFquME9sX1RYMtRG4aUL2AwnlxqidhUQniN5AW3FIqK6t+XVOB7UHtViAtFZ74EPuqVBn
 FnB7VMDKHuDpyjk8OigM4gFATQlgej86V3wOngQl2alLto6rbdbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1pvaei4AqI-00nDT0; Wed, 23
 Aug 2023 12:14:31 +0200
Message-ID: <1d5a18b1-efde-6c67-e17a-8c40e4e6d09c@gmx.de>
Date:   Wed, 23 Aug 2023 12:14:30 +0200
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
        linux-parisc <linux-parisc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <ZOR95DiR8tdcHDfq@p100>
 <20230822113453.acc69f8540bed25cde79e675@linux-foundation.org>
 <8eb38faf-16a2-a538-b243-1b4706f73169@gmx.de>
 <a1a19e05-0cfd-cae5-9edb-9d63e70ee06d@gmx.de>
In-Reply-To: <a1a19e05-0cfd-cae5-9edb-9d63e70ee06d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:POnCAhUkxWA7Nycr7xMtIc6ojJsSa3o2+uLXrEfu0dGr7FZsKks
 2GPaOjPIdyS6drBp33SJKBjK2YPOfovQXXIqb42hCBUwBEDOMgDymdcsnq+uLZNDh4P/YDv
 Gdb/JlLsQsRUrWrSkTIBbzhaiNWvsHRmnHVWoA/VYHHPlR5prNkBVmAcBng4VPcNSJXjQcr
 JYqhudQ+WCV8epDIi+0YA==
UI-OutboundReport: notjunk:1;M01:P0:g40IZdfjNfM=;US7ldrjTh3lYV1VlXRlibG6ijaI
 mpeVbsJXJZQWEEHfsiwM0eusH///mETjZjkEL7APqGrIWunc4V+PrmKViA8oOkRQeR4FbStx7
 49I0t+1/9ilKWYUknP1F4ZCLmVP67Niabj/szIObOKk/sNkjClmAB6uKgq/Q2nq8e30gYKGOO
 7EBqBz7+2EqrQO4a+KIL/xaIJFI4JqnT80OKYRxlt571lSiKT+wah4mkjvKZcrdvqpLYVG/Cp
 DFZGDaCz4P41OZ45ViSJwcuVYYQFGeZLdrqaDaQnudabWc5grv9jeDocOK4MMpjHoriaUzFaK
 hBv26Q4RSscB8TMjXhqP5FaZ8eeZ9WC2zJcVda9WD4uY3jjPZz3ijsA+1DeZY8F58M9NRtkCG
 7VvdDFULi1oNgJRtvefOSf0BbryhhaXv72I2X3rS3+/99+BkvZOmBI/Zg4UsXhiEIB1SXFAD1
 HmRVCIJFjwfo5j9DfBR8HA87CIgO2qcv/X1qLYxN2/kx9dlAJKGd7ULgKSPaRLNkwF7WaQJUx
 nMKjdKKmBIDXOhoXc7J7BPOIWLu0oaNxahzRMkeUDn3z1fMYKgiyQV3zYCBnfLzMHZfySe4O/
 eyXFZ5fIx0fDL/JixHNFQz+teJiNjZgeVtbSu40CaRBGmDwDjqp16KKk3DB3f7to4kFMe3dhh
 cmGsmqVGy+T/utVkKcgdT1MjIOWZx9wSVABRbUsMgrvvqwwGWqyQxc8NACsbWAaG4PU3umY0O
 Mdh2IGVoNKQSR3x1+1wfRzFEzWJpkd7Wzoq0ot842Xb10roW6cG+axuKVSo182diS1ssCIAW3
 GL+y9GN+KEYnhSDov3tHWDBAjV/+QONrXxmipmovzR4ERIIPZGT1lhfA70iAl5gZbAhRj37nx
 P62Ns/tX7T0a/Six8IojLm45hghEwz+gmPSVfQLmmDrXkmyOC+HA+kVXGzLkKJQp2z+m6o1L6
 Ubhzf11tujelZQ/cytofGm9r4QA=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/23 00:04, Helge Deller wrote:
> On 8/22/23 22:53, Helge Deller wrote:
>> On 8/22/23 20:34, Andrew Morton wrote:
>>> On Tue, 22 Aug 2023 11:20:36 +0200 Helge Deller <deller@gmx.de> wrote:
>>>
>>>> On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:
>>>>
>>>> root@debian:~# cat /proc/self/maps
>>>> 00010000-00019000 r-xp 00000000 08:05 787324=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/bin/cat
>>>> 00019000-0001a000 rwxp 00009000 08:05 787324=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/bin/cat
>>>> 0001a000-0003b000 rwxp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [heap]
>>>> f7551000-f770d000 r-xp 00000000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/libc.so.6
>>>> f770d000-f770f000 r--p 001bc000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/libc.so.6
>>>> f770f000-f7714000 rwxp 001be000 08:05 794765=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/libc.so.6
>>>> f7d39000-f7d68000 r-xp 00000000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/ld.so.1
>>>> f7d68000-f7d69000 r--p 0002f000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/ld.so.1
>>>> f7d69000-f7d6d000 rwxp 00030000 08:05 794759=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/lib/hppa-linux-gnu/ld.so.1
>>>> f7ea9000-f7eaa000 r-xp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [vdso]
>>>> f8565000-f8587000 rwxp 00000000 00:00 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [stack]
>>>>
>>>> But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed =
up
>>>> /proc/pid/maps") even on native 32-bit kernels the output looks like =
this:
>>>>
>>>> root@debian:~# cat /proc/self/maps
>>>> 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324=
=C2=A0 /usr/bin/cat
>>>> 0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 787=
324=C2=A0 /usr/bin/cat
>>>> 000000001a000-000000003b000 rwxp 00000000 00:00 0=C2=A0 [heap]
>>>> 00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 7=
94765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>>> 00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:00000=
0005 794765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>>> 00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:00000=
0005 794765=C2=A0 /usr/lib/hppa-linux-gnu/libc.so.6
>>>> 00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 7=
94759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>>> 00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:000000=
005 794759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>>> 00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:000000=
005 794759=C2=A0 /usr/lib/hppa-linux-gnu/ld.so.1
>>>> 00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0=C2=A0 [vdso]
>>>> 00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0=C2=A0 [stack]
>>>>
>>>> This patch brings back the old default 8-hex digit output for
>>>> 32-bit kernels and compat tasks.
>>>>
>>>> Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pi=
d/maps")
>>>
>>> That was five years ago.

It's even worse :-)
The real bug was introduced 10 years ago, in kernel 3.11.
Commit 4df87bb7b6a22 ("lib: add weak clz/ctz functions") added __clzsi2()
and __clzdi2() which operate on 32-bit parameters instead of 64-bit
parameters (64-bit kernel is OK, just 32-bit kernels are affected!).

This patch in my for-next tree fixes it:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3Dc8daddb96ddc4cc95b19944ef5dfa831d317fb4b

I'll send the final patch to the mailing list if the tests via for-next se=
ems ok.

>> Given there is some risk of breaking existing parsers, is it worth fixi=
ng this?
The parsers are not the problem, but Yes, we will have to fix it.

The patch will not affect 64-bit kernels.
But for 32-bit kernels we will need that patch to get __clzdi2() return th=
e correct
values, otherwise there might be other upcoming issues.

Helge
