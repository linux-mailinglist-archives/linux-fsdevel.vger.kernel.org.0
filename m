Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795F78902E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 23:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjHYVKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHYVJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:09:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6C211E;
        Fri, 25 Aug 2023 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692997782; x=1693602582; i=deller@gmx.de;
 bh=t9bxSjK12LeGCsmisqAXpIIyjCQZXoB1R6YMQj1H2HE=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=bY/A9oCZit5AtFz7eNRLjtoj6/tVjjxcHri0JhZOWP6Yv1HHixduLkTrYjXo36++LrAsHml
 j3XfQJ90epx19+glgxdcBBpzwHPS37f1/Un+HpDcVc2NnjAvWwHwXwLbRpX5AYtgVu5R5JMa+
 OW0GycZDlqmdt39YNaQa3494SNlIZHh/h244sxullC3RDVwG51WZu1Nn2rn7/3O4LsV5Kqkd0
 dJw5qOCrt2Ib5udICoWu73LwVB08bnOExhaOn8G3S7pmRUqdHZlLLJHPtf1F00j9JMNEBU3Uo
 tD7xXRd+Ja82OVh/WyeW/We1Rytij5GnUmAdwv+/nXwz7lsHncTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.149.122]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1qW5pL2odB-00EZmp; Fri, 25
 Aug 2023 23:09:42 +0200
Message-ID: <a7bbca09-b733-2e6e-0662-cb5d7b67d255@gmx.de>
Date:   Fri, 25 Aug 2023 23:09:42 +0200
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
 <a1a19e05-0cfd-cae5-9edb-9d63e70ee06d@gmx.de>
In-Reply-To: <a1a19e05-0cfd-cae5-9edb-9d63e70ee06d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgE4+/iNO0aZYR+fzWXyvjMkNs3h2BleANDINF8q2LmPadMpRcA
 Nxxi8U7KzoF8wOSEgScVK8/1WXSQ4keaDmoOjhoPUDxlgQsPe2XHEeRP9aLNdR1eKezTveB
 PZipSe2pFhrldUsZPB/UslmB68RtMqUPY5fJENvxGJZJ8/CMKbC2Mh8f/o7d0srSWsxTuvN
 +sPsQpIsC/wtj52UmqRsQ==
UI-OutboundReport: notjunk:1;M01:P0:4dNZi+3V608=;0kgLbPPTQEtBxVBcOBBz7lLhB+l
 QEQaQ58OslxI8G1BwP/iCmm4afXPep2x1Pk0T09w+LLzqm/dZtiow1nlsTc/L++FNTRPhwbXx
 1iExaAGEZMpmIrLn5ho+xY+Ex3K4T2+yJAMFWkkIjWQPbK6HjM7ZaSXNHJERcmQEov/rh0C+1
 T6+n5AOKuuTu9IKcYXuwYa4pcYrgeH5AgQlMtatXC5dXr9dXtF1Ez/Bsrd3LdO5S3wtrBtu0N
 w0VMwBylVE9QqL0DlMBcn5tUfjHeaFSCxQbmr+992Hd6DDc/46fMA8WZnd9OOMhO5sZIJL0Nk
 J4xX3tPrGYQf5uEfhuGwHS/wJzAfbVRZBflZfBH1f66zb3GIQZcq1xZcOCrxo97x8VYW8elb4
 iPpF2AnB3bnHO7n/Oa4dq0YTYkMPVbJSu2FN4pLDtAUuurnrKuIA9Em+yF1UGT8EnrjmbBIN9
 u5zYMlD0Ft2RtGnQfUF2J9wDN91dg8wLDEqqfPdFAGV8LJCwjR0KIIzX+Wc4OEgJ/f/42qhJv
 WK1oIqWjdMkxgHE9ds0ZIRbAeGmLDyhuIpqnUSYKJEQOT0VqbCnCS+Krdkn9MDTZ7yVPRhTcY
 oxpan1EB1cJNBVcmthp2OzhI2LK2C0xotgolUbJsF3N2dFdp9RNFJ+epF9dntEvbWYZWddoIa
 AXBjtMJObP2bt4yr6LhQUgd5oE2JrSkGZ8FaJcV5+n0TFMcTFE2vedAaVfDjwD7clyJSo/dy+
 iXQRX28IuYjJ2Hmy70QySyVY5+D+uYuWqZ/PIrjQKwFC8PXJpqODqp99MtdZuCrkZcgJtgojt
 KURKVFGfFpC9MGd/XftLjnOOhW/5Q9rB8RMiKi3kSO/PkWo3UQ0huqq1EqEoFe90VUjVffEVl
 qDVawubySS09uekF15tI7GnBp+ol4x6myobbZupmkuetYD3OKNw3hesKcwvLvFTGghAwRmO2/
 D6NWiH6Ki0+GGu7Sk8PpTJeUbdE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>>> That was five years ago.=C2=A0 Given there is some risk of breaking ex=
isting
>>> parsers, is it worth fixing this?
>>
>> Huh... that's right!
>> Nevertheless, kernel 6.1.45 has it right, which isn't 5 years old.
>> I don't see the reason for that change right now, so I'll need to figur=
e out what changed...
>
> It seems to be due to a new bug in gcc's __builtin_clzll()
> function (at least on parisc), which seems to return values
> for "long" (32bit) instead for "long long" (64bit).
>
> Please ignore this patch for now.

To sum up:
It was a bug in the in-kernel __clzdi2() function.
This patch ("lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kerne=
ls") fixes it:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D382d4cd1847517ffcb1800fd462b625db7b2ebea

Thanks!
Helge
