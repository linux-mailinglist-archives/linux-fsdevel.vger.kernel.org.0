Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00981A3172
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDIJBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 05:01:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46971 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDIJBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:01:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id m19so5301528lfq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bL9ifUNW59crmzsbt6dLo+loyDPtO9QCB/tGi8Xv10s=;
        b=yit1NHNGe2LMUd6uNWHOj/JoYnC//4fbuMT69yswwnLXwr/x/l8GKovnWAwpEbD+fn
         hHekbdd4URx8tlZPLkkaHboAvu8zSZYZ/SzQoxZG3AHKgiRS/cYIo2/qEORnXX0Vvvo5
         mOOfG9pxdE2RcEgM3c64JAXbtPhrBhyxHg5uzfezcvr8ZAzCh2lk+yuZoxFGseUdaIE7
         Q38il3/mkWwBj7pTVK9lacERVuhl/a+05OUEhMW5l9GHR8/l15N9q8o20HQmb1zanELy
         bNxBgD6mvQmgGTzYDxND+ji8oAcQz1iBYZiKht+oWGgYYluryXuJwSgHyhp0/33CpMQ/
         oW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bL9ifUNW59crmzsbt6dLo+loyDPtO9QCB/tGi8Xv10s=;
        b=uQ3+hEWC0aekArtk2vGllh371jqs8qeQtam6ASYO4JZy1ucJnUFZKWyQjOVn7v3Z9V
         BJE6qAyGmEWGALNvAR/Z5vdLq8yoIuvde2Ghq68sHdf+C3ECiNfFwWzE11JEwN/R7B5/
         MoM+tJva1BgWZr+CToSPY7NwpAtjeylV1l5JE400y+pwuNyC3Tsp6w6vOQaJak5UpSIy
         s3efgeIIyAkLthXYh00X8SwE0eXAl1hSs/O5AK0TjHLVgnWkliaxZnfhtrQs1LlKyM7U
         90FTXrX8VfGRrKdnD8k/J9dMXuRsqoNc6d0EjVEhmO/XTE2pxmG71a209QfEcI87ozZI
         J22Q==
X-Gm-Message-State: AGi0PuZfvRj2BSznFLg2ByS43Xz0joVP5D5M1xuSmahIubhzJiuW0n7t
        +X1J3BhB3h5TRVn/GvdUu0SQKBjUF5oWDpxYEq2GBQ==
X-Google-Smtp-Source: APiQypKELkgKiHNjicowPErrJEQbXbFPe6vvVay3gM3VtClfJFqU4xTmZR5uCDhTkctQxTqVbbHKgZL59q1r5hl9XvM=
X-Received: by 2002:a19:c64b:: with SMTP id w72mr7087057lff.82.1586422896545;
 Thu, 09 Apr 2020 02:01:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Apr 2020 14:31:24 +0530
Message-ID: <CA+G9fYtMupyHuEsdUwSGQu6czFO7xhe45Km_=DJ8P1v7wpto7Q@mail.gmail.com>
Subject: memfd/fuse_test: BUG: kernel NULL pointer dereference, address: 00000041
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hugh Dickins <hughd@google.com>, ngeoffray@google.com,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, miklos@szeredi.hu,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running kselftest memfd fuse_test test case kernel BUG found on
i386 kernel running x86_64 device running Linux-next
5.6.0-next-20200408 kernel version.

Linux version 5.6.0-next-20200408 (oe-user@oe-host) (gcc version 7.3.0
(GCC), GNU ld (GNU Binutils) 2.30.0.20180208) #1 SMP Wed Apr 8
04:48:57 UTC 2020
<>
[  452.885727] kselftest: Running tests in memfd
[  452.974683] audit: type=1701 audit(1586366703.840:87435):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=13617
comm=\"fuse_test\"
exe=\"/opt/kselftests/default-in-kernel/memfd/fuse_test\" sig=6 res=1
[  452.975400] BUG: kernel NULL pointer dereference, address: 00000041
[  452.999344] #PF: supervisor read access in kernel mode
[  453.004475] #PF: error_code(0x0000) - not-present page
[  453.009605] *pde = 00000000
[  453.012482] Oops: 0000 [#2] SMP
[  453.015619] CPU: 1 PID: 13617 Comm: fuse_test Tainted: G      D W
      5.6.0-next-20200408 #1
[  453.024388] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  453.031862] EIP: __kmalloc+0xa2/0x310
[  453.035525] Code: 9c 01 00 00 89 75 e4 8b 07 64 8b 50 04 64 03 05
d8 92 bd cb 8b 08 85 c9 89 4d f0 0f 84 07 02 00 00 8b 75 f0 8b 47 14
8d 4a 01 <8b> 1c 06 89 f0 8b 37 64 0f c7 0e 75 d0 8b 75 e4 8b 47 14 0f
18 04
[  453.054264] EAX: 00000040 EBX: 00000cc0 ECX: 000045c3 EDX: 000045c2
[  453.060519] ESI: 00000001 EDI: f5403680 EBP: e1effcb8 ESP: e1effc98
[  453.066776] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
[  453.073555] CR0: 80050033 CR2: 00000041 CR3: 216ee000 CR4: 003406d0
[  453.079812] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  453.086067] DR6: fffe0ff0 DR7: 00000400
[  453.089898] Call Trace:
[  453.092345]  ? elf_core_dump+0x520/0x16a0
[  453.096357]  elf_core_dump+0x520/0x16a0
[  453.100215]  ? kmem_cache_free+0xeb/0x2e0
[  453.104236]  do_coredump+0x617/0x1070
[  453.107911]  ? trace_hardirqs_off+0x1d/0xf0
[  453.112095]  ? lock_acquire+0x81/0x320
[  453.115850]  get_signal+0xaa8/0xb40
[  453.119341]  do_signal+0x23/0x630
[  453.122659]  ? _raw_spin_unlock_irq+0x22/0x30
[  453.127019]  ? __set_current_blocked+0x47/0x50
[  453.131468]  exit_to_usermode_loop+0x6a/0xd0
[  453.135736]  do_fast_syscall_32+0x297/0x330
[  453.139914]  entry_SYSENTER_32+0xaa/0x102
[  453.143916] EIP: 0xb7f1bce1
[  453.146706] Code: 5e 5d c3 8d b6 00 00 00 00 b8 40 42 0f 00 eb c1
8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 8b 3c 24 c3 90 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  453.165444] EAX: 00000000 EBX: 00000002 ECX: bfb63cc0 EDX: 00000000
[  453.171700] ESI: 00000008 EDI: 00000000 EBP: bfb63cc0 ESP: bfb63cb0
[  453.177957] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  453.184737] Modules linked in: test_printf(+) cls_bpf sch_fq
sch_ingress algif_hash x86_pkg_temp_thermal fuse [last unloaded:
test_strscpy]
[  453.197292] CR2: 0000000000000041
[  453.200612] ---[ end trace 4ae6b60cdb1cebfa ]---
[  453.205222] EIP: ida_free+0x61/0x130
[  453.208794] Code: 00 c7 45 e8 00 00 00 00 c7 45 ec 00 00 00 00 0f
88 c4 00 00 00 89 d3 e8 6d 60 8a 00 89 c7 8d 45 d8 e8 c3 1a 01 00 a8
01 75 3f <0f> a3 30 72 72 8b 45 d8 89 fa e8 40 62 8a 00 53 68 e8 db 80
cb e8
[  453.227529] EAX: 00000000 EBX: 00000000 ECX: f37c3540 EDX: 00000000
[  453.233787] ESI: 00000000 EDI: 00000246 EBP: e1e75cdc ESP: e1e75cb0
[  453.240043] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010046
[  453.246820] CR0: 80050033 CR2: 00000041 CR3: 216ee000 CR4: 003406d0
[  453.253077] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  453.259334] DR6: fffe0ff0 DR7: 00000400
[  453.263176] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:49
[  453.273445] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
13617, name: fuse_test
[  453.281615] INFO: lockdep is turned off.
[  453.285533] irq event stamp: 0
[  453.288585] hardirqs last  enabled at (0): [<00000000>] 0x0
[  453.294173] hardirqs last disabled at (0): [<ca6ed9ea>]
copy_process+0x3ea/0x17d0
[  453.301672] softirqs last  enabled at (0): [<ca6ed9ea>]
copy_process+0x3ea/0x17d0
[  453.309172] softirqs last disabled at (0): [<00000000>] 0x0
[  453.314741] CPU: 1 PID: 13617 Comm: fuse_test Tainted: G      D W
      5.6.0-next-20200408 #1
[  453.323519] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  453.330988] Call Trace:
[  453.333435]  dump_stack+0x6e/0x96
[  453.336754]  ___might_sleep+0x14d/0x240
[  453.340592]  __might_sleep+0x33/0x80
[  453.344173]  exit_signals+0x2a/0x2d0
[  453.347750]  do_exit+0x8e/0xb40
[  453.350889]  ? exit_to_usermode_loop+0x6a/0xd0
[  453.355336]  rewind_stack_do_exit+0x11/0x13
[  453.359519] EIP: 0xb7f1bce1
[  453.362308] Code: 5e 5d c3 8d b6 00 00 00 00 b8 40 42 0f 00 eb c1
8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 8b 3c 24 c3 90 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  453.381044] EAX: 00000000 EBX: 00000002 ECX: bfb63cc0 EDX: 00000000
[  453.387303] ESI: 00000008 EDI: 00000000 EBP: bfb63cc0 ESP: bfb63cb0
[  453.393560] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/745/config

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1352031#L10567

-- 
Linaro LKFT
https://lkft.linaro.org
