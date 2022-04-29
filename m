Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E65142A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354813AbiD2GyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354794AbiD2Gx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:53:57 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7B2FFC0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 23:50:40 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so1269642ooj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+XC6XJ22D0S1cH5HWUA5JVybXpxIUxsIoXafbiib3Y=;
        b=hCoZTDIK9MHdaFZJjHUovQmzkcH/OG1a9pfOJabjPGfK4LgBp8KEr/gPwaMmIk84E+
         nPkT0d4qOJ/Qm7mz5qpWFvnY4j//b3rzhZypAOfparLMkWEtFgNAZZVNB/HHg/7rjLQT
         cNIFTtfLm9Yge/QDPNZnxQIAEWkXoUKiLzRzRWYksdH0unIifhwWSzu0wI3xqxRly8OE
         MhEK2M0+bS1FxEBWJn17uLzxS/Rk6+XbFnT7SSSdDGxnKT53gRN5X856M63kMiuuLB4U
         G/3Rh3q/B+mIJiMKMjHzrLrCrrZb+iAm44q/s/G4hAoGsIaUxLwDv9d2ZiMHRn884HpA
         21Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+XC6XJ22D0S1cH5HWUA5JVybXpxIUxsIoXafbiib3Y=;
        b=7MeAimZLsNCtuznrgmqWPjCqdGnHvQ+GviJ8vIknR483KhhNcs7MgMb0rg2WjIbg/p
         nRWKbrW1OmECsyMqYEqwhiJSTSKMyNk9plR8kfQPFKwx1nQokIrVXF3OiSzGHa4HQOxl
         /ETRzHUjozJ+ss9NDCRslfElzCUz/DB764YUyNCZsCjK7j3SKwVS7MtLMi40pg/a8zRM
         wq6IyNVIz3fRogR+DzxjjZb7iMibGxh93jasZG0sUiYKQ9gKByQXcGXs+BpBtysP1emU
         wSMFRQwGKjsNyEOCho22+CVvn2nxcpJsZF7Ducftcr1XGC7MchpmKdL61LhTi40Axart
         0TLA==
X-Gm-Message-State: AOAM533fnlvE4Nm9c+WYCOZdGs+4gobkC7dz+KKYCg+WvuSROZ5zdDqD
        vJg27cnKYEYh7gyhZpu0VuqdhRb6NDaDt3R5YPiclA==
X-Google-Smtp-Source: ABdhPJxDJgXvFfv5EMw3Jg6MkbEZ1iKwq9S2dgjZGHQgoTY2PhT+EvLpdbq0aBy9XYREWG62rYbwl0YydZUwfE8jRKc=
X-Received: by 2002:a4a:ad0a:0:b0:35e:79da:30c7 with SMTP id
 r10-20020a4aad0a000000b0035e79da30c7mr7353381oon.53.1651215039520; Thu, 28
 Apr 2022 23:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000001044205ddc55870@google.com>
In-Reply-To: <00000000000001044205ddc55870@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Apr 2022 08:50:28 +0200
Message-ID: <CACT4Y+Z=+u_HdmJUcRJ6e0srvqh4pk273CC2C3AmfH9B1Z=o+A@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in do_page_fault
To:     syzbot <syzbot+f8181becdab66ab4b181@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 Apr 2022 at 08:42, syzbot
<syzbot+f8181becdab66ab4b181@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=1128ae72f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
> dashboard link: https://syzkaller.appspot.com/bug?extid=f8181becdab66ab4b181
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f8181becdab66ab4b181@syzkaller.appspotmail.com
>
> ============================================
> WARNING: possible recursive locking detected
> 5.17.0-rc1-syzkaller-00002-g0966d385830d #0 Not tainted
> --------------------------------------------
> dhcpcd-run-hook/3780 is trying to acquire lock:
> ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
> ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x24e/0xa3c arch/riscv/mm/fault.c:285
>
> but task is already holding lock:
> ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
> ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: setup_arg_pages+0x1aa/0x4b8 fs/exec.c:793
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&mm->mmap_lock);
>   lock(&mm->mmap_lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 1 lock held by dhcpcd-run-hook/3780:
>  #0: ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
>  #0: ffffaf8010608d18 (&mm->mmap_lock){++++}-{3:3}, at: setup_arg_pages+0x1aa/0x4b8 fs/exec.c:793
>
> stack backtrace:
> CPU: 1 PID: 3780 Comm: dhcpcd-run-hook Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
> [<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
> [<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
> [<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
> [<ffffffff83175742>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
> [<ffffffff8011404e>] print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
> [<ffffffff8011404e>] check_deadlock kernel/locking/lockdep.c:2999 [inline]
> [<ffffffff8011404e>] validate_chain kernel/locking/lockdep.c:3788 [inline]
> [<ffffffff8011404e>] __lock_acquire+0x1dcc/0x333e kernel/locking/lockdep.c:5027
> [<ffffffff80116582>] lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5639
> [<ffffffff8011682a>] lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5612
> [<ffffffff831ab656>] down_read+0x3c/0x54 kernel/locking/rwsem.c:1461
> [<ffffffff800117d4>] mmap_read_lock include/linux/mmap_lock.h:117 [inline]
> [<ffffffff800117d4>] do_page_fault+0x24e/0xa3c arch/riscv/mm/fault.c:285

+riscv maintainers
this looks riscv related

> [<ffffffff80005724>] ret_from_exception+0x0/0x10
> [<ffffffff80c0069a>] __stack_depot_save+0x40/0x4b2 lib/stackdepot.c:360
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000001044205ddc55870%40google.com.
