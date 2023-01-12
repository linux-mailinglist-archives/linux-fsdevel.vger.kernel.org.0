Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241B6687E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 00:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjALXg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 18:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjALXg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:36:57 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD0BC81
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 15:36:56 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j130so16545411oif.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyKJUQtbXtAfFvc9DdHISkJE08GBS8U1MkoKFAxUAKQ=;
        b=lpvMe6SDkX77s0ewCmh5sDGHXEaR8a8nPlU2wh23wal2DYvRPTtWGF1UI2uzxUlzeF
         XkiCJO+G6fmxNMsQrhQnva66fDY4fkBWHQvKMiSl3IjsiXiE4PQh0MdlJEbXcO2iz1G9
         UXWlQVOTcFV+nEz7brCGx51COd0VuUjZhjaf9Xmp382+rcaIZ0oKT8ic5aWH6lEHpr6k
         1UrzkGYeUfQyqxbvmdt45Q1UkaW2hOgAoya7GIaj6pZXKUll1AafuQVYbHIcTjGlVf7S
         XztmjUeaXTUCQRE3Q1B8pTiHNs0qUITl0VfaCRIykkKcYOP/qZULBT8pJr7tYB4dU4gZ
         Jkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyKJUQtbXtAfFvc9DdHISkJE08GBS8U1MkoKFAxUAKQ=;
        b=zyD5OXKfwRDPx7TlQhRcm4Y4jl3nabzQ9IirOc4ymAAzJOcA1ybjN5haUx81HRQyW4
         toVcq7tqEzv1k9H6UlnrFZMtAZ1pirn1693oNrSuOZhL7Y7NpmI7E2+PZl3fWKXGU1pc
         VZ05CBLyhi4Wz4AnxmGhXAz3FzfPwWNhrQImNqDPBwmZ9s90ScIt6aZudmJSOBv74Z0c
         O2Ci8Kzbf/QTsrRZwoFOEaAlE1QT0l8fiOL+9uV0/n6yriBGpQLKV+4KnEwq523Ls9L3
         WeKNozruaWYV15viYBp32RWoDEIO04aeR4rP3V2hbKai3ux6sTW6yMNutV5ix25i0+ZB
         72SQ==
X-Gm-Message-State: AFqh2ko3dc7NP8oDEU7ASd1k1oU0Orwv93DbzfCfkBF0D9TitZYUN6RF
        LEL2IHcqRHFne3xVydfJ1fkU4/OynbpdMIM7dl7gC3vg
X-Google-Smtp-Source: AMrXdXtkYNwksxe1OOG0q+HSCdM2dzTYffjddycnY81pqQgEnsRHwaCdqHlUubblpElNijOxRLRVEqFDRNWITWJXdUM=
X-Received: by 2002:a05:6808:218c:b0:364:5474:688f with SMTP id
 be12-20020a056808218c00b003645474688fmr840731oib.159.1673566615691; Thu, 12
 Jan 2023 15:36:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:77d5:0:b0:491:8368:9bdd with HTTP; Thu, 12 Jan 2023
 15:36:55 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 13 Jan 2023 00:36:55 +0100
Message-ID: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
Subject: lockref scalability on x86-64 vs cpu_relax
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

[cc is probably woefully incomplete, just grabbed people from lockref
history; should this land on a x86 list instead of vfs?]

I intended to send a patch which fixes cred-related bottleneck in
access(), and while getting the expected win for calls with different
files, I got a *slowdown* when benchmarking against the same file and
according to perf top it was all lockref. I'm going to post it after
this issue is resolved, interested parties can take a peek here:
https://dpaste.com/8SVDF8HJH .

The problem is visible with open3 test ("Same file open/close") from
will-it-scale. I ran the _processes variant against stock + no-pause
kernel on Cascade Lake (2 sockets * 24 cores * 2 threads) running
6.2-rc3.

Results are:
proc    stock   no-pause
1       805603  814942
2       1054980 1054781
8       1544802 1822858
24      1191064 2199665
48      851582  1469860
96      609481  1427170

As you can see degradation already shows up at ~8 workers.

While trying to do my homework regarding history in the area I found
this thread:
https://lkml.iu.edu/hypermail/linux/kernel/1309.0/02330.html

It mentions a stat-based test, which I presume was multithreaded
stat on the same dentry. will-it-scale somehow does not have stat
benches, so I posted a PR to add some:
https://github.com/antonblanchard/will-it-scale/pull/35/files

With fstat2_processes (Same file fstat) I get:
proc    stock   no-pause
1       3013872 3047636
2       4284687 4400421
8       3257721 5530156
24      2239819 5466127
48      1701072 5256609
96      1269157 6649326

To my understanding on said architecture failed cmpxchg still grants you
exclusive access to the cacheline, making immediate retry preferable
when trying to inc/dec unless a certain value is found. By doing pause
instead one not only induces a delay, but also increases likelihood that
the line will have to be grabbed E again. Something to that extent was
even stated in thread and it definitely lines up with results above.

I see pause first shoed up first here:
commit d472d9d98b463dd7a04f2bcdeafe4261686ce6ab
Author: Tony Luck <tony.luck@intel.com>
Date:   Tue Sep 3 14:49:49 2013 -0700

    lockref: Relax in cmpxchg loop

... without numbers attached to it. Given the above linked thread it
looks like the arch this was targeting was itanium, not x86-64, but
the change landed for everyone.

Later it was further augmented with:
commit 893a7d32e8e04ca4d6c882336b26ed660ca0a48d
Author: Jan Glauber <jan.glauber@gmail.com>
Date:   Wed Jun 5 15:48:49 2019 +0200

    lockref: Limit number of cmpxchg loop retries
[snip]
    With the retry limit the performance of an open-close testcase
    improved between 60-70% on ThunderX2.

While the benchmark was specifically on ThunderX2, the change once more
was made for all archs.

I should note in my tests the retry limit was never reached fwiw.

That aside, the open-close testcase mentioned should match open3.

All that said, I think the thing to do here is to replace cpu_relax
with a dedicated arch-dependent macro, akin to the following:

diff --git a/lib/lockref.c b/lib/lockref.c
index 45e93ece8ba0..e057e1630e7c 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -2,6 +2,10 @@
=C2=A0#include <linux/export.h>
=C2=A0#include <linux/lockref.h>

+#ifndef arch_cpu_relax_cmpxchg_loop
+#define arch_cpu_relax_cmpxchg_loop() cpu_relax()
+#endif
+
=C2=A0#if USE_CMPXCHG_LOCKREF

=C2=A0/*
@@ -23,7 +27,7 @@
                }
         \
                if (!--retry)
         \
                        break;
         \
-               cpu_relax();
         \
+               arch_cpu_relax_cmpxchg_loop();
         \
        }
         \
=C2=A0} while (0)

Then x86-64 would simply:
+#define        arch_cpu_relax_cmpxchg_loop do { } while (0)

Not an actual patch and I don't care about the name, just illustrating
what I mean.

I have to note there are probably numerous other cmpxchg loops without
the pause/fallback treatment, quick grep reveals one in
refcount_dec_not_one, if the fallback and/or cpu_relax thing is indeed
desirable the other loops should probably get augmented to have it.

Any comments?

If you agree with the idea I'll submit a  proper patch.

--=20
Mateusz Guzik <mjguzik gmail.com>
