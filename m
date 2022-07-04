Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278085656AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiGDNNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiGDNNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:13:31 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6A2BF7
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 06:13:25 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89653790so30792697b3.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jul 2022 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIaZlI7YS4bdFXxHZ8WhYhNHONpm3C6tjWHfLQFHPJE=;
        b=EoMOIJZKUTGDl0CfSoRv+QPLiJHTN69qAPhHhFFMjtWil0l0PJNDSWiBQYRQqYR5ml
         XivWqSsgCxuA3/ldtmkzJXXnXhy/RHGvt4rLt8Rb66tlBIHblZxsLwTZpOSz7/SY5dNz
         7v2D49Ct6f7jtcs52xS/2JIyqizTm/0OnNMrORQmcT4tHrBMIas+aHriLwMVXztvB4gE
         /9z3+WPEAiwWDQoljrZJdq9Pz4iGFNYGm/XqXkSKwJUJeydT3PZZwl0fjbvwkouALR/1
         XZFckRc+zu8SCenYaN3LQ0aUMlvWQa1VazCOBvV0l/pukS4EsBeIcH5CTIpA8dvGSlnW
         pT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIaZlI7YS4bdFXxHZ8WhYhNHONpm3C6tjWHfLQFHPJE=;
        b=OKLiQIYGCS7aGPAFBuIhLa8OqWm7KMqcoKQB2oCulEmJocFw/ZGzYZ3ciJtn3CUzqh
         Jtesivp1Ofr0mlD4iY3BEN/N08MzeDrOMM9oD3RkttOtrLcLCbLI62K7SEJcQfhLn5ou
         VDrOQwr0J9ay8t2VsSWhJ/Q+y8Ew5O9i+IMoRTc8V4e/P+M4oXbUpc9jQXgJQDz6PU6j
         8S2z7JK4LnpsgE6AXuv0F5q0BtR6WAAxaCp37XcWcE/7TMvN4wc6jjOjeTm8vo3n7o/M
         LfZiTakwOqbb52NTQpv0RRy68OFYCoiclb1cjsm2sGfgfF2KrsDg643mUFz01Iwx9wX5
         FgJA==
X-Gm-Message-State: AJIora8/JV5HXP94guQVR4UIN4WelhRtKxbTLGIsN7u/QR8Cd0HKuWWq
        TKN0YTqoIoW7JClajGcXxvxpObZFEODD6i+tr/wWaA==
X-Google-Smtp-Source: AGRyM1tIRXXKL/oBiPqhG44ZBxlySTemohahY9bpwMI1GUgf/c24VjzCJBMyJ21UiS2hf4L8u8gyuLj6YHC/L16FxdI=
X-Received: by 2002:a81:60d6:0:b0:31b:8d6c:165e with SMTP id
 u205-20020a8160d6000000b0031b8d6c165emr32322747ywb.405.1656940404744; Mon, 04
 Jul 2022 06:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008f6f7405e2f81ce9@google.com> <YsLHQCvp8W5oObv2@casper.infradead.org>
In-Reply-To: <YsLHQCvp8W5oObv2@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Jul 2022 15:13:13 +0200
Message-ID: <CACT4Y+ZvK0Oxf=Hw7mznmFU=x_zCwC4Ev_Zxo2N0p79DNNi-jw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in mark_buffer_dirty (4)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Jul 2022 at 12:56, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jul 04, 2022 at 03:22:22AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d9b2ba67917c Merge tag 'platform-drivers-x86-v5.19-3' of g..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d5f0f0080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3a010dbf6a7af480
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2af3bc9585be7f23f290
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14464f70080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1779a598080000
> >
> > Bisection is inconclusive: the first bad commit could be any of:
> >
> > a1a98689301b drm: Add privacy-screen class (v4)
> > befe5404a00b drm/privacy-screen: Add X86 specific arch init code
> > 107fe9043020 drm/connector: Add support for privacy-screen properties (v4)
> > 8a12b170558a drm/privacy-screen: Add notifier support (v2)
> > 334f74ee85dc drm/connector: Add a drm_connector privacy-screen helper functions (v2)
>
> It's clearly none of those commits.  This is a bug in minix, afaict.
> Judging by the earlier errors, I'd say that it tried to read something,
> failed, then marked it dirty, at which point we hit an assertion that
> you shouldn't mark a !uptodate buffer as dirty.  Given that this is
> minix, I have no interest in pursuing this bug further.  Why is syzbot
> even testing with minix?

Shouldn't it? Why? It does not seem to depend on BROKEN.

> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a2e85c080000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com
> >
> > WARNING: CPU: 0 PID: 3647 at fs/buffer.c:1081 mark_buffer_dirty+0x59d/0xa20 fs/buffer.c:1081
> > Modules linked in:
> > CPU: 1 PID: 3647 Comm: syz-executor864 Not tainted 5.19.0-rc4-syzkaller-00036-gd9b2ba67917c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:mark_buffer_dirty+0x59d/0xa20 fs/buffer.c:1081
> > Code: 89 ee 41 83 e6 01 4c 89 f6 e8 8f c2 94 ff 4d 85 f6 0f 84 7a fe ff ff e8 21 c6 94 ff 49 8d 5d ff e9 6c fe ff ff e8 13 c6 94 ff <0f> 0b e9 ac fa ff ff e8 07 c6 94 ff 0f 0b e9 d0 fa ff ff e8 fb c5
> > RSP: 0018:ffffc900030c7d30 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff88806e7bda38 RCX: 0000000000000000
> > RDX: ffff888071720100 RSI: ffffffff81e4d16d RDI: 0000000000000001
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807c21e7d8
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffffed100f314eda
> > FS:  00007fe4fb903700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fe4fb925000 CR3: 0000000079e8a000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  minix_put_super+0x199/0x500 fs/minix/inode.c:49
> >  generic_shutdown_super+0x14c/0x400 fs/super.c:462
> >  kill_block_super+0x97/0xf0 fs/super.c:1394
> >  deactivate_locked_super+0x94/0x160 fs/super.c:332
> >  deactivate_super+0xad/0xd0 fs/super.c:363
> >  cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
> >  task_work_run+0xdd/0x1a0 kernel/task_work.c:177
> >  ptrace_notify+0x114/0x140 kernel/signal.c:2353
> >  ptrace_report_syscall include/linux/ptrace.h:420 [inline]
> >  ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
> >  syscall_exit_work kernel/entry/common.c:249 [inline]
> >  syscall_exit_to_user_mode_prepare+0xdb/0x230 kernel/entry/common.c:276
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
> >  syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
> >  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7fe4fb9774c9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fe4fb9032f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffec RBX: 00007fe4fb9fc3f0 RCX: 00007fe4fb9774c9
> > RDX: 0000000020000140 RSI: 00000000200000c0 RDI: 00000000200002c0
> > RBP: 00007fe4fb9c90a8 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> > R13: 6f6f6c2f7665642f R14: 000000807fffffff R15: 00007fe4fb9fc3f8
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YsLHQCvp8W5oObv2%40casper.infradead.org.
