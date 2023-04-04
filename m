Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF16D6D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjDDTwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 15:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDTwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:52:20 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF11705;
        Tue,  4 Apr 2023 12:52:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DA44A604F7;
        Tue,  4 Apr 2023 21:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680637935; bh=517XR0X/jWCzTJ7yxauRblo40oIwOYagNQNSBg+Elk8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=vbr463yLg6E/91ja4r5cUTG4PFXK6EE2y/wP/YOQolcwyCqDrW+cwvb4T3lJG0fIT
         1NsS4sN2IWO11KVqNzyx8zrTjJ1MOtmdvhsbDzAOd7qGi7+mxnaMKIgWzk5lqpbFA9
         43k/ZrYET1d17fDawSzGxKdqdy/33DTAAHtOkVT3Dydzg6tRVMcFCHXuXwyapg99N9
         YylAZe+ysoN0dVM51AeznBFhLmxPUh5Xk6dJAgaTi110PTzMoq/CYn4zWdCUKnPbdc
         ybdGOkgJnorco6VLHlusvU+TqVZ5eq0wuCgasDavAzazFJi2Ekg/pfkPfwUVBUyXiv
         cKc+hUKeuhPgg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tpLIWn--HPqm; Tue,  4 Apr 2023 21:52:12 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id B2C90604F5;
        Tue,  4 Apr 2023 21:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680637932; bh=517XR0X/jWCzTJ7yxauRblo40oIwOYagNQNSBg+Elk8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=QndEKGPN3KzRPtffYaMI11AaybT1KKz461JBirev43xcrCnGGOfbEk34KUSxiIkzM
         WiGlvBuUCSKCc2BLwPtgRXixp2TBiaqZeRnhkzjfZn2EzhJ+ddC4E3qnL8j2Rg9XgG
         4yohloX2Z7bOK/asPheDOnmtH6hQf33SX8mWdVGtlN9FinfW1Bxx7u/KFSVvlnMycy
         gYFhns5UokvpbuCh5Ju4Ph9/M1k8OmEUktS4O8nk080bnCaVJqr+fW1a43n2slsp9D
         ZI4pCBtkGrsk11E+498fgyP+HIzOhH/k3BHTpSg2aLcj22jQxNCSKuAsXdPxcuFFFy
         g7GnZeFVGeJpA==
Message-ID: <76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr>
Date:   Tue, 4 Apr 2023 21:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [BUG RESEND] [BISECTED]: selftest: ftracetest: memleak in
 vfs_write()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <ca4dca01-66ce-c1a9-23cd-9d83b0d2c4b0@alu.unizg.hr>
Content-Language: en-US, hr
In-Reply-To: <ca4dca01-66ce-c1a9-23cd-9d83b0d2c4b0@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

No progress on this bug report, so it is still unpatched in 6.3-rc5 so I am
submitting again.

Please see the relevant data at the bottom:

On 27. 01. 2023. 19:36, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> I came across a memory leak with the vanilla mainline Torvalds tree kernel
> with MGLRU and CONFIG_KMEMLEAK enabled:
> 
> unreferenced object 0xffff8d7c92ad5180 (size 192):
>   comm "ftracetest", pid 2738512, jiffies 4335176273 (age 4842.976s)
>   hex dump (first 32 bytes):
>     c0 59 ad 92 7c 8d ff ff 60 dd d7 31 7c 8d ff ff  .Y..|...`..1|...
>     60 55 df 97 ff ff ff ff 09 00 02 00 00 00 00 00  `U..............
>   backtrace:
>     [<ffffffff965d9bf0>] __kmem_cache_alloc_node+0x1e0/0x340
>     [<ffffffff96556dda>] kmalloc_trace+0x2a/0xa0
>     [<ffffffff964382fc>] tracing_log_err+0x16c/0x1b0
>     [<ffffffff96451963>] append_filter_err+0x113/0x1d0
>     [<ffffffff96453c0a>] create_event_filter+0xba/0xe0
>     [<ffffffff96454b18>] set_trigger_filter+0x98/0x160
>     [<ffffffff96456554>] event_trigger_parse+0x104/0x180
>     [<ffffffff96455823>] trigger_process_regex+0xc3/0x110
>     [<ffffffff964558f7>] event_trigger_write+0x77/0xe0
>     [<ffffffff96623a41>] vfs_write+0xd1/0x420
>     [<ffffffff9662413b>] ksys_write+0x7b/0x100
>     [<ffffffff966241e9>] __x64_sys_write+0x19/0x20
>     [<ffffffff971c9188>] do_syscall_64+0x58/0x80
>     [<ffffffff972000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff8d7b076be000 (size 32):
>   comm "ftracetest", pid 2738512, jiffies 4335176273 (age 4842.976s)
>   hex dump (first 32 bytes):
>     0a 20 20 43 6f 6d 6d 61 6e 64 3a 20 61 0a 00 00  .  Command: a...
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff965d9bf0>] __kmem_cache_alloc_node+0x1e0/0x340
>     [<ffffffff96557a8d>] __kmalloc+0x4d/0xd0
>     [<ffffffff96438314>] tracing_log_err+0x184/0x1b0
>     [<ffffffff96451963>] append_filter_err+0x113/0x1d0
>     [<ffffffff96453c0a>] create_event_filter+0xba/0xe0
>     [<ffffffff96454b18>] set_trigger_filter+0x98/0x160
>     [<ffffffff96456554>] event_trigger_parse+0x104/0x180
>     [<ffffffff96455823>] trigger_process_regex+0xc3/0x110
>     [<ffffffff964558f7>] event_trigger_write+0x77/0xe0
>     [<ffffffff96623a41>] vfs_write+0xd1/0x420
>     [<ffffffff9662413b>] ksys_write+0x7b/0x100
>     [<ffffffff966241e9>] __x64_sys_write+0x19/0x20
>     [<ffffffff971c9188>] do_syscall_64+0x58/0x80
>     [<ffffffff972000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff8d7c92ad59c0 (size 192):
>   comm "ftracetest", pid 2738512, jiffies 4335176280 (age 4843.088s)
>   hex dump (first 32 bytes):
>     c0 5c ad 92 7c 8d ff ff 80 51 ad 92 7c 8d ff ff  .\..|....Q..|...
>     60 55 df 97 ff ff ff ff 01 00 0b 00 00 00 00 00  `U..............
>   backtrace:
>     [<ffffffff965d9bf0>] __kmem_cache_alloc_node+0x1e0/0x340
>     [<ffffffff96556dda>] kmalloc_trace+0x2a/0xa0
>     [<ffffffff964382fc>] tracing_log_err+0x16c/0x1b0
>     [<ffffffff96451963>] append_filter_err+0x113/0x1d0
>     [<ffffffff96453c0a>] create_event_filter+0xba/0xe0
>     [<ffffffff96454b18>] set_trigger_filter+0x98/0x160
>     [<ffffffff96456554>] event_trigger_parse+0x104/0x180
>     [<ffffffff96455823>] trigger_process_regex+0xc3/0x110
>     [<ffffffff964558f7>] event_trigger_write+0x77/0xe0
>     [<ffffffff96623a41>] vfs_write+0xd1/0x420
>     [<ffffffff9662413b>] ksys_write+0x7b/0x100
>     [<ffffffff966241e9>] __x64_sys_write+0x19/0x20
>     [<ffffffff971c9188>] do_syscall_64+0x58/0x80
>     [<ffffffff972000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The bug was noticed on Lenovo desktop 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
> running AlmaLinux 8.7 (Stone Smilodon), a CentOS clone, with the compiler:
> 
> mtodorov@domac:~/linux/kernel/linux_torvalds$ gcc --version
> gcc (Debian 8.3.0-6) 8.3.0
> Copyright (C) 2018 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> mtodorov@domac:~/linux/kernel/linux_torvalds$ 
> 
> Bisecting gave the following culprit commit:
> 
> git bisect good a92ce570c81dc0feaeb12a429b4bc65686d17967
> # good: [c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a] ipmi/watchdog: use strscpy() to instead of strncpy()
> git bisect good c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a
> # good: [90b12f423d3c8a89424c7bdde18e1923dfd0941e] Merge tag 'for-linus-6.2-1' of https://github.com/cminyard/linux-ipmi
> git bisect good 90b12f423d3c8a89424c7bdde18e1923dfd0941e
> # first bad commit: [71946a25f357a51dcce849367501d7fb04c0465b] Merge tag 'mmc-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> 
> The commit was merged on December 13th 2022.
> 
> It is a huge commit.
> 
> The selftests/ftrace/ftracetest triggers this leak, sometimes several times in a run.
> ftracetest requires root permission to run, but I haven't yet realised whether a non-superuser
> could devise an automated script to abuse this leak exhausting all kernel's memory.
> 
> Non-root user gets a EPERM error when trying to access /proc/sys/kernel internals:
> 
> [marvin@pc-mtodorov linux_torvalds]$ tools/testing/selftests/ftrace/ftracetest 
> Error: this must be run by root user
> tools/testing/selftests/ftrace/ftracetest: line 46: /proc/sys/kernel/sched_rt_runtime_us: Permission denied
> [marvin@pc-mtodorov linux_torvalds]$ 
> 
> Hope this helps.
> 
> According to the Code of Conduct, I have Cc:-ed maintainers from get_maintainers.pl and
> I will add Thorsten because this is sort of a regression :-)

The debug output is like follows:

unreferenced object 0xffff93a3dc2d1e18 (size 192):
  comm "ftracetest", pid 12451, jiffies 4295087353 (age 463.476s)
  hex dump (first 32 bytes):
    20 08 2d dc a3 93 ff ff c0 bd 5d cd a3 93 ff ff   .-.......].....
    c0 bf 85 b6 ff ff ff ff 09 00 02 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb4afb23c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb4b02b19>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb4a7693e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb493a8fb>] tracing_log_err+0x18b/0x1d0
    [<ffffffffb4959049>] append_filter_err.isra.13+0x119/0x190
    [<ffffffffb495a89f>] create_filter+0xbf/0xe0
    [<ffffffffb495ab10>] create_event_filter+0x10/0x20
    [<ffffffffb495c040>] set_trigger_filter+0xa0/0x180
    [<ffffffffb495d745>] event_trigger_parse+0xf5/0x160
    [<ffffffffb495c889>] trigger_process_regex+0xc9/0x120
    [<ffffffffb495c976>] event_trigger_write+0x86/0xf0
    [<ffffffffb4b52dc2>] vfs_write+0xf2/0x520
    [<ffffffffb4b533d8>] ksys_write+0x68/0xe0
    [<ffffffffb4b5347e>] __x64_sys_write+0x1e/0x30
    [<ffffffffb586619c>] do_syscall_64+0x5c/0x90
    [<ffffffffb5a000ae>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff93a3873dda20 (size 32):
  comm "ftracetest", pid 12451, jiffies 4295087353 (age 463.476s)
  hex dump (first 32 bytes):
    0a 20 20 43 6f 6d 6d 61 6e 64 3a 20 61 0a 00 00  .  Command: a...
    00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
  backtrace:
    [<ffffffffb4afb23c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb4b02b19>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb4a77785>] __kmalloc+0x55/0x160
    [<ffffffffb493a913>] tracing_log_err+0x1a3/0x1d0
    [<ffffffffb4959049>] append_filter_err.isra.13+0x119/0x190
    [<ffffffffb495a89f>] create_filter+0xbf/0xe0
    [<ffffffffb495ab10>] create_event_filter+0x10/0x20
    [<ffffffffb495c040>] set_trigger_filter+0xa0/0x180
    [<ffffffffb495d745>] event_trigger_parse+0xf5/0x160
    [<ffffffffb495c889>] trigger_process_regex+0xc9/0x120
    [<ffffffffb495c976>] event_trigger_write+0x86/0xf0
    [<ffffffffb4b52dc2>] vfs_write+0xf2/0x520
    [<ffffffffb4b533d8>] ksys_write+0x68/0xe0
    [<ffffffffb4b5347e>] __x64_sys_write+0x1e/0x30
    [<ffffffffb586619c>] do_syscall_64+0x5c/0x90
    [<ffffffffb5a000ae>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Please find the complete debug info at the URL:

https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/ftracetest/

Bisect log is [edited]:

> git bisect good a92ce570c81dc0feaeb12a429b4bc65686d17967
> # good: [c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a] ipmi/watchdog: use strscpy() to instead of strncpy()
> git bisect good c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a
> # good: [90b12f423d3c8a89424c7bdde18e1923dfd0941e] Merge tag 'for-linus-6.2-1' of https://github.com/cminyard/linux-ipmi
> git bisect good 90b12f423d3c8a89424c7bdde18e1923dfd0941e
> # first bad commit: [71946a25f357a51dcce849367501d7fb04c0465b] Merge tag 'mmc-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> 
> The commit was merged on December 13th 2022.

The amount of applied diffs in the culprit commit 71946a25f357a51dcce849367501d7fb04c0465b
prevents me from bisecting further - I do not know which changes depend of which, and which
can be tested independently.

Hopefully I might come up with a reproducer, but I need some feedback first. Maybe there
are ways to narrow down the lines of code that could have caused the leaks, yet I am
completely new to the kernel/trace subtree.

Apologies for not Cc:ing Ulf nine weeks ago, but it was an omission, not deliberate act.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

