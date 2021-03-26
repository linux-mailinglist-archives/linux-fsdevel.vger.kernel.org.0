Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9E34A2E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 09:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZICt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCZICW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:02:22 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34EC0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 01:02:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o19so2544367qvu.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGCnALPAzpuJPfXClfFJQGT2XN6gTh/jFVROAs81JWg=;
        b=KUbtQtIFl/WnRQvgicbHb88RAlztW74KwS2a+qdDXBfszCL18rFRvq0O9xvORA7i4d
         GtrKNUpHYbALvJ3S0Ii9yBBzXAIQ2WxUYRNWueeUlKlCvm3LXgMjGre1el6ubp/wXfSW
         GojYnYupBUAzKX5xayhZt0oYCMxPXNLDRjJIleJ6sClkjKS0xJ/aRgiV0O88bHP3/GFk
         h9UhuqTA+jhcOKmKp92ALFO8N0dusklkVD48Gay2y2GFXmCKp15H1yD0WR0kYsM98mfV
         Nwwj5+RnEcYrS4tXJEmXlWrwrsvdYEitASIprrBgluaqKWYqO4CxrE8bdtr55ZFmB4A7
         z3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGCnALPAzpuJPfXClfFJQGT2XN6gTh/jFVROAs81JWg=;
        b=AGwakOLeeu6g7VoDXm2iV4/yfwEx7pO/JJDBi1R7MOU2WcMOFStsRsQTvCLYRUndKZ
         Hl/QxZ0BrOHc679cb8bnFH2G75g3EJS5PRUv0cbxa97AVKuKg0wb4RnS1rTuCo9j+4Vn
         +3gc6yGLiKDMY7yX2IL3IAiOsGrT/HGNveId+G9D8Gc/zv7J93Vq4UZCw1saZe7jgSZJ
         48ntvzX4djF6KgLjNhv7xvIF9ZYh4yBXcYJuVSgR+TFuMga14fo9igFEZ5UJtG2rQnyP
         kDo+bTfVxOnsHn3iDP1w1LGiPEwVR6J6yRjZ3KHblSXYby1NA6TayyGkpXO7OJa7hJxG
         bhlg==
X-Gm-Message-State: AOAM530xivYqV/iETKGSP9ni7DOVt32cjRQ4cLKjwmURW6KaMtxH5aAy
        FCeFFjgOKPCRrFdE3S2jBh7T0Oj3G3iTNUXp07J1QQ==
X-Google-Smtp-Source: ABdhPJwHQmy9jxPAImEPt65p8+J8BHvWfCOlV1FFpkyYB05z0IDJM8Mg70cy33K6BozeGuat4UvKLQ95HAaqAeWwsy4=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr11872535qvb.23.1616745739890;
 Fri, 26 Mar 2021 01:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069c40405be6bdad4@google.com>
In-Reply-To: <00000000000069c40405be6bdad4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Mar 2021 09:02:08 +0100
Message-ID: <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
To:     syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 8:55 AM syzbot
<syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17fb84bed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com

I was able to reproduce this with the following C program:
https://gist.githubusercontent.com/dvyukov/00fb7aae489f22c60b4e64b45ef14d60/raw/cb368ca523d01986c2917f4414add0893b8f4243/gistfile1.txt

+Christian
The repro also contains close_range as the previous similar crash:
https://syzkaller.appspot.com/bug?id=1bef50bdd9622a1969608d1090b2b4a588d0c6ac
I don't know if it's related or not in this case, but looks suspicious.


> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
> BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
> BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170 fs/open.c:1289
> Read of size 8 at addr 0000000000000077 by task syz-executor.4/16965
>
> CPU: 0 PID: 16965 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  __kasan_report mm/kasan/report.c:403 [inline]
>  kasan_report.cold+0x5f/0xd8 mm/kasan/report.c:416
>  check_region_inline mm/kasan/generic.c:180 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
>  atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
>  filp_close+0x22/0x170 fs/open.c:1289
>  close_files fs/file.c:403 [inline]
>  put_files_struct fs/file.c:418 [inline]
>  put_files_struct+0x1d0/0x350 fs/file.c:415
>  exit_files+0x7e/0xa0 fs/file.c:435
>  do_exit+0xbc2/0x2a60 kernel/exit.c:820
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  get_signal+0x42c/0x2100 kernel/signal.c:2773
>  arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
>  handle_signal_work kernel/entry/common.c:147 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x466459
> Code: Unable to access opcode bytes at RIP 0x46642f.
> RSP: 002b:00007feb5e334218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000056bf68 RCX: 0000000000466459
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf68
> RBP: 000000000056bf60 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf6c
> R13: 0000000000a9fb1f R14: 00007feb5e334300 R15: 0000000000022000
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000069c40405be6bdad4%40google.com.
