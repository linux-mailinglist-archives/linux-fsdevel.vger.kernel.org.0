Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9F58B567
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiHFMYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiHFMYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:24:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725BDE8B;
        Sat,  6 Aug 2022 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659788630;
        bh=2Q7uVoi9etUHQcg6k8CWD2qINr2lwPxkOfHfz7vCqgM=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=dFXsfITa8u0yUy3ATKvqfVosIu2sxDMttJpXYT3TExqQp1qxFdgnoUQjeMpqd5gQ/
         QQMHQiWm6SdRlU8OgFdbjAzlUKw2mQ1dhutjmaGiPsYC8liv37JyMFe1/qpAHknbYv
         DYlmqzk0EIASiPY1ep0YZABrkVCvEuXaXAojiaVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.170.46]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1oGzSU1xXg-003PL9; Sat, 06
 Aug 2022 14:23:50 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/3] Dump command line of faulting process to syslog
Date:   Sat,  6 Aug 2022 14:23:45 +0200
Message-Id: <20220806122348.82584-1-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SFsa6Df2ppv7VmXIO81pLmiWdYqA+5p7hjdVr9P8sJdlxgTdXyx
 4V3iT2wC6bHvXC7t2xifm5y+1XtJi7CeGrvmNskRuT+NUD70O1J5kP8BJ76oKwyi2IlzJAr
 BeVqMiWEYJvxsEVrSmCLgUqGp4CJmeKFij/TJWDQe8IoiingusSdIpMlpJ9baRQDqGsZIjv
 Umt6qVYh0t5eerHTwNAng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:waMzHaSporw=:pQQ6T0vUgoaQCVoAd7gFx7
 H8ZBcdX2uzjCQClblhUib7tkJIHgOxIQohRDHqxhIWZdiWr4boLS/sQ9PTFwgAk6Um8zRnRMM
 Gg+BqEmCX1lSXMxIdAQ1Z0zSn2q4mfQHHg6J8mp/spSzeBmtzqjUl46qQjwi7cGbNrkM3aoEQ
 2KYtL6YvPbn6Fw5G82JRCMl5znSrsBdw7aAQthAWmvEB6mlk0lAi3QEeXCPJf9bbseBNg99h2
 mVJPPfovCvwh465Yq5qtGD+OqVQf5KeCtLQSW+oarzW6uEgb+orvD34GckkJ/HUjA9kWbHtS4
 PeNa3ok49xe/PRcLCQ+L65pnUgJwAI3rnYhzzk0PHuPyVpPyYSXlqKgfnWAblvHPckqrjplua
 xhrWpIQjOznlPKvGjTbm3ALXChSVyEuamC85KXGhk1LUrtGbvJYDwbpMe2SfX6HKyF7QXDeEI
 qyI+XTnEzuUzhoJe410UWCc8rxeLSdkToyTtrnCit02WglwTPgxoXqO9iejf1FAlIVJ/JsB9I
 jtC2YV+S0rVcC4LBhHpJF2KECzMZImJWt6nGr1tFUu9gWF7hnSyKfBlGihnnYmTCDrlhJ+cMQ
 0/H4LZKXvI/3hW4Cen8Xi9YINAQ01GjOdEsAo9m1YrsjnRgGiKIW6qpUoIP8RSmViT9zyMZrJ
 8sOHniLPOdPeHP0xTSZ5HAcZqIqYDN/UEVZgllQjDrlUq90JW7wh8AufIIJ5KTCw2i/94zRjC
 /O3NtijzwGRs8wAtY20v7nhukQBt/c2Wc7uwnB0fC4rk4/RCM1ogUYyKidgHgyX54VlaW3Rbw
 nimX0uG44H8ll17vPZdKe/deUwIe5Jk7VFvUnt42qnnBzUP/OOgRVPOQwLzLTm+/vpy+gZYN9
 87oJQANgA7w/dJmnp0pvs0mRgAV3jXhoyEguzuw1x1JWxWb0Im7/ToAJOq2amhQfeZVVQWEQi
 HfSiHrbgxVk4SM5aifHPQ4GYREukr8JSjjSscgDJaupYeFWtv6m/mkWt6qBtEyZqPmJRkN01n
 +9RmeFlvcC5tQ9ZRZOxyjKnn9f/LpeYVvd1XBc6k8iviKZgjzN8iIz15z+oMOCq+ykV/7gpEM
 7dtXolVTvvRrkiLCJgrNc2tjARUPGdMGI/3X0z8o+CrNmWV0eVzMu7/FQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series allows the arch-specific kernel fault handlers to dump
the command line parameters of the faulting process.

The motivation for this patch is that it's sometimes quite hard to find ou=
t and
annoying to not know which program *exactly* faulted when looking at the s=
yslog.

Some examples from the syslog are:

On parisc:
   do_page_fault() command=3D'cc1' type=3D15 address=3D0x00000000 in libc-=
2.33.so[f6abb000+184000]
   CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ #45
   Hardware name: 9000/785/C8000

-> We see the "cc1" compiler crashed, but it would be useful to know which=
 file was compiled.

With this patch series, the kernel now prints in addition:
   cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccR=
kFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D NO=
_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-9.0=
.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface -qu=
iet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -Wim=
plicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13413=
_0/ghc_5.s

-> now we know that cc1 crashed while compiling some haskell code.

Another parisc example:
   do_page_fault() command=3D'ld.so.1' type=3D15 address=3D0x565921d8 in l=
ibc.so[f7339000+1bb000]
   CPU: 1 PID: 1151 Comm: cc1 Tainted: G            E     5.10.133+ #45
   Hardware name: 9000/785/C8000

-> apparently here a program from the glibc testsuite segfaulted.

With this patch we now additionally get:
   ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-pat=
h /home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
        /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1

-> it was the tst-safe-linking-malloc-hugetlb1 testcase which faulted.

An example of a typical x86 fault shows up as:
   crash[2326]: segfault at 0 ip 0000561a7969c12e sp 00007ffe97a05630 erro=
r 6 in crash[561a7969c000+1000]
   Code: 68 ff ff ff c6 05 19 2f 00 00 01 5d c3 0f 1f 80 00 00 00 00 c3 0f=
 1f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 b8 00 00 00 00 <c7> 00 01 00=
 00 00 b8 00 00 00 00 5d c3 0f 1f 44 00 00 41 57 4c 8d

-> with this patch we now will see the whole command line:
   crash[2326] cmdline: ./crash test_write_to_page_0

The patches are relatively small, and reuses functions which are used
to create the output for the /proc/<pid>/cmdline files.

In this version 2 of the patch set, all or parts of the command line isn't
shown if the value of the kptr_restrict sysctl >=3D 1.

Thanks!
Helge

=2D--

Changes compared to v1 of this patchset:
=2D---------------------------------------
- Don't dump all or parts of the commandline depending on the
  kptr_restrict sysctl value (suggested by Josh Triplett).
- Patch sent to more arch mailing lists

Helge Deller (3):
  proc: Add get_task_cmdline_kernel() function
  lib/dump_stack: Add dump_stack_print_cmdline() and wire up in
    dump_stack_print_info()
  x86/fault: Dump command line of faulting process to syslog

 arch/x86/mm/fault.c     |  2 ++
 fs/proc/base.c          | 68 +++++++++++++++++++++++++++--------------
 include/linux/printk.h  |  5 +++
 include/linux/proc_fs.h |  5 +++
 lib/dump_stack.c        | 34 +++++++++++++++++++++
 5 files changed, 91 insertions(+), 23 deletions(-)

=2D-
2.37.1

