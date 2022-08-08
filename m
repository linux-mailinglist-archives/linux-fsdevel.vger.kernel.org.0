Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4CA58C91C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbiHHNKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiHHNJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:09:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A46CE0D;
        Mon,  8 Aug 2022 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659964158;
        bh=aM64I3xT+nrAAK/BCGOu7rEdx/4nHtHx5JVVg4BjZUA=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Yhhqd8gNlgo7WkmfXdoNiJLT5rGDDzerm7vNcQdF0WC3fY3jLTKPOnaS4Dd2/o89E
         uxV3tIAJBlPmf75Tt4tttgsxJrFwmeq+7am5xzYog9YODqjr2JOClwchIpus4BjujT
         3Z7F1zwZOh7SPl5IFCtBNm9NNoK33vXkUQ+4Awlk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.169.184]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1nMENI0sCY-010Q4h; Mon, 08
 Aug 2022 15:09:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] Dump command line of faulting process to syslog
Date:   Mon,  8 Aug 2022 15:09:13 +0200
Message-Id: <20220808130917.30760-1-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:84TWQbnNKsaSON1sxgzA8VMcCW1N9C9kjxeNROJetaoTlrwHyEJ
 4kLAo2nY0nBKJzTbYKeIFs0wsAhsUj400kCXTzFd1LBKOgRGmPhIDqCoKMQfbK1f02UFheV
 T5pSHxSbW+FPInvGlRKQqW+uW/on0h1xD6YnsEiYHniWkmRAmTI8WGJknLpw6yJ+ky2f7sR
 gQHsOTDFqQcj4xa5P6+Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkPkvFZxlQc=:l818vHvl4KYHXR/6nteSWt
 Drrh+hI657zDwl8V1U3h+u1Z+pOM/EhP9IKv5hA7uLlCzTiO9h3pjn1v1K5w8gwcEAN73aD8b
 xWcGgKdNy9u4vAX31e2esewWODiQTuMd29ETswYKbHPzvMcGj/2AhEau5TlRb7AjyeruQUbST
 2cRf63S+seosQS7tx5rFHOgu3vprnK2TI3nQFWP44C/hu88i4roi9lLh9g5IT5ImcxCpVNh6v
 +Nnw9li6J7kmfxqO4imAqs5lpcU7HkrH4fObsgfpglMx5CY0oscIgV8vRJ4wNF9C4mKGjgdDq
 EBCSvYTlBd0tu1Z4X2opkt9bIl1/07DxbhrcDHISOhhGZ8GjzP3WzCXXQfLF6YVSeDfJuBcbR
 FrQYJPohyACh+I01hf1nqRGL0ckxXyILyaog2XfeBcXQXAbi/XzHzW2KoDSI125XRbe/GJ23e
 BcwSDEHo8OcTLB48E06g4rRFjc4m4ACnM/wPOUfdpZDZEGTrgO7CR3rnx40SRU609Tyx0FoGQ
 denhspTfCIzVcTbC+O7mWNIgm8YqPaDwQ+35V3VtMR+kvz6PN9w73BtcPwNKih913fyODePNX
 fGJr2KYAz2bbSltbJxEMvuM0jl0807rCn+BrlBYHh7sIdqcIhy4wpm1m3nnvyyAe+r2ASxrzh
 DZqXgVCrWJFT+gVejvEspBcZ+ewAldyBW/KmLrL+RyNM++W0utwU4ipQecY70fOyPIJceWkiY
 cGNmmby290PdNv1o1QTDO5wrLsoK8m/SYdFwuadOLXpCUj9MYB2bG4o3RbliCeQbBrjfUoHKL
 DzinenDxGpMs7IaMVBCCOw+VKKTm+DxclOVjjw5Kcdfkf2U0/gdjnM6DekiDxppmkdpH6t/xw
 aM5XuAU8q52e2DgR9220p6fHhmXPB0hreFOHFArj/bizQDgwORqgpARBmRsNHSo60C0gegv3P
 dOeLwa7YU5a+JMGUqXSQ9aTf/kM9MQ/YIZqOOg8w2mvCwDj27+luOGR7xO2S+yWzjEgit73GA
 hPx6/S6bWrqRdNitUF8aDK7FSHU4/ZrznQUNKhkPBb3dOE1PPl7sFrovZ5fHvhUa1Dmanldv8
 oL5QHd1A8QxrA2nBCkObPsYPUln4QFPUAdswWgSqiyGJqFcqOymz8uumA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series dumps the command line (including the program parameters=
) of
a faulting process to the syslog.

The motivation for this patch is that it's sometimes quite hard to find ou=
t and
annoying to not know which program *exactly* faulted when looking at the s=
yslog.

For example, a dump on parisc shows:
   do_page_fault() command=3D'cc1' type=3D15 address=3D0x00000000 in libc-=
2.33.so[f6abb000+184000]

-> We see the "cc1" compiler crashed, but it would be useful to know which=
 file was compiled.
With this patch you will see that cc1 crashed while compiling some haskell=
 code:

   cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/ccR=
kFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D NO=
_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-9.0=
.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface -qu=
iet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -Wim=
plicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13413=
_0/ghc_5.s

Another example are the glibc testcases which always segfault in "ld.so.1"=
 with no other info:

   do_page_fault() command=3D'ld.so.1' type=3D15 address=3D0x565921d8 in l=
ibc.so[f7339000+1bb000]

-> With the patch you can see it was the "tst-safe-linking-malloc-hugetlb1=
" testcase:

   ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-pat=
h /home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
        /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1

An example of a typical x86 fault shows up as:
   crash[2326]: segfault at 0 ip 0000561a7969c12e sp 00007ffe97a05630 erro=
r 6 in crash[561a7969c000+1000]
   Code: 68 ff ff ff c6 05 19 2f 00 00 01 5d c3 0f 1f 80 00 00 00 00 c3 0f=
 1f 80 00 00 ...

-> with this patch you now see the whole command line:
   crash[2326] cmdline: ./crash test_write_to_page_0

The patches are relatively small, and reuse functions which are used
to create the output for the /proc/<pid>/cmdline files.

The relevant changes are in patches #1 and #2.
Patch #3 adds the cmdline dump on x86.
Patch #4 drops code from arc which now becomes unnecessary as this is done=
 by generic code.

Helge

=2D--

Changes in v3:
- require task to be locked by caller, noticed by kernel test robot
- add parameter names in header files, noticed by kernel test robot

Changes in v2:
- Don't dump all or parts of the commandline depending on the
  kptr_restrict sysctl value (suggested by Josh Triplett).
- Patch sent to more arch mailing lists

Helge Deller (4):
  proc: Add get_task_cmdline_kernel() function
  lib/dump_stack: Add dump_stack_print_cmdline() and wire up in
    dump_stack_print_info()
  x86/fault: Dump command line of faulting process to syslog
  arc: Use generic dump_stack_print_cmdline() implementation

 arch/arc/kernel/troubleshoot.c | 24 -----------
 arch/x86/mm/fault.c            |  2 +
 fs/proc/base.c                 | 74 +++++++++++++++++++++++-----------
 include/linux/printk.h         |  5 +++
 include/linux/proc_fs.h        |  5 +++
 lib/dump_stack.c               | 34 ++++++++++++++++
 6 files changed, 97 insertions(+), 47 deletions(-)

=2D-
2.37.1

