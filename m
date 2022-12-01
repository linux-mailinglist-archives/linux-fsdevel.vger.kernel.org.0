Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEC63F195
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLAN15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 08:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLAN1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:27:55 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596298023
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 05:27:50 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142faa7a207so2078687fac.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKX7XbV45ypYpzPDw9elTD9CiMI8plRjBBbcyN9gt8c=;
        b=k290NBge+7x8zsRMOEqR+FNvzJ7CKWqruPNVjZrPrsoxjjkzNur8PN062w6gpJtLwP
         PbLa4ieeffSyraHBVpBkMmDlXggS83Y1D9bkutj63LPm+ooztmPAVqzsnlkvsa9NJvpX
         cL3HGsob5j0yo+GpRSKBijXlI6FyB4RacXI/Y8hgj+AQ3g2zGtd7tSd6T/kok8ykl5/W
         tMRleQLJ79wf4+oXP4fX8swI/psLpdbwvDPuYocuJeTW0n1WbRvTUsIrSVLzgkBiDl+2
         8A+4KNX4abdjGPT31QLCjuYLuDwA4h8Nk5Qz+kK5FFTLAZL2QhFitgQ4J4DWaHx8YMr8
         6mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKX7XbV45ypYpzPDw9elTD9CiMI8plRjBBbcyN9gt8c=;
        b=KEhkmfzNcnuC5IGlOQYCyR1xvXmcLsXKOBPQYFIuvIG1KiW2i+EYrEzsmMz4hmn0yY
         /K7/IQDo4QyAkVnjC73q3zlTyXiog+b1x82nRyK8l39DG/yTm4Wfb2jpyD9OfNo+y009
         BHg/K6BRkbVhDfuyZw8jJ24soT8DZO5hnuJ0USeM8NJTksBQPndHIyqm8sS/BIvjuMAY
         tEPHas+mAhgsqDIPeCKx6KbtMAIKQt/OlKkpWdhBCVP4In+JWJBOmu/Zq4QVkcZEQv/M
         HRNKVrf3r8PrmV79MOCyGAfxdNrmrfqP1M+o1mUYfKloRA00SzlG+9POT2LC7mhWLgVm
         EbJA==
X-Gm-Message-State: ANoB5plzJScspWVNfMBZ0GX65m8hP0GBTAUQrlEyFRg2jkdLGSBsZ1a8
        b9t5dl+Q8jMX/EhN3WemKg9109W1B9Fc2LE8ilYiyQ==
X-Google-Smtp-Source: AA0mqf4Q4727PKmPz/jEaHJf9BWuLDES9qwrpnH5XiL6CQUDZAAuK0g7tkj/lwGSk//UWx853d+S/yLDY+qizR4yyDk=
X-Received: by 2002:a05:6870:b689:b0:13c:7d1c:5108 with SMTP id
 cy9-20020a056870b68900b0013c7d1c5108mr27415122oab.282.1669901269175; Thu, 01
 Dec 2022 05:27:49 -0800 (PST)
MIME-Version: 1.0
References: <00000000000031692f05ebc4cf8a@google.com> <CAKYAXd_sNEM1KE=Tom-htUsvw5h-iF+M+arzjP7uPYLEcJQ+tw@mail.gmail.com>
In-Reply-To: <CAKYAXd_sNEM1KE=Tom-htUsvw5h-iF+M+arzjP7uPYLEcJQ+tw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 1 Dec 2022 14:27:37 +0100
Message-ID: <CACT4Y+bhncXf4LArLVNJGanSinn4sYBWza-wT1Wkv=6Xuj+JHw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in exfat_fill_super
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     syzbot <syzbot+74fa8cb75d0a18df4790@syzkaller.appspotmail.com>,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, 30 Nov 2022 at 16:17, Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> Hello,
>
> I have tried to reproduce this issue using syzkaller and your
> testcase(C reproducer)
>
> root@syzkaller:~# ./repro
> [ 4278.566005] loop0: detected capacity change from 0 to 4096
> [ 4278.570538] exfat: Bad value for 'iocharset
>
> But I can't see kernel oops or KASAN logs.
> Could you pleaes confirm that you can still reproduce this ?

Hi Namjae,

This was reported by a robot, it won't understand such a request.
But you can see all the info it has about the bug on the dashboard
page (when it happened, how many times, on what commits, etc):
https://syzkaller.appspot.com/bug?extid=74fa8cb75d0a18df4790

I am assuming you used the provided kernel commit and config. If you
can't reproduce it, but need it for debugging/testing, you can ask
syzbot to test your patches.

> Thanks!
>
> 2022-10-24 18:56 GMT+09:00, syzbot
> <syzbot+74fa8cb75d0a18df4790@syzkaller.appspotmail.com>:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fc516e880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=74fa8cb75d0a18df4790
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils
> > for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1056a9b4880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14613b3c880000
> >
> > Downloadable assets:
> > disk image:
> > https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
> > vmlinux:
> > https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
> > mounted in repro:
> > https://storage.googleapis.com/syzbot-assets/6d392b37ac66/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+74fa8cb75d0a18df4790@syzkaller.appspotmail.com
> >
> > loop0: detected capacity change from 0 to 4096
> > general protection fault, probably for non-canonical address
> > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 0 PID: 3610 Comm: syz-executor183 Not tainted
> > 6.1.0-rc1-next-20221021-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 10/11/2022
> > RIP: 0010:strcmp+0x35/0xb0 lib/string.c:281
> > Code: df 41 54 55 53 48 89 fb 48 83 ec 08 eb 08 40 84 ed 74 5d 4c 89 e6 48
> > 89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38
> > d0 7f 04 84 c0 75 50 0f b6 6b ff 4c 8d 66 01 48
> > RSP: 0018:ffffc90003e3fbd8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff89e65300 RDI: 0000000000000000
> > RBP: ffffc90003e3fd38 R08: 0000000000000005 R09: 0000000000000100
> > R10: 0000000000000100 R11: 1ffffffff17b2629 R12: 0000000000000000
> > R13: dffffc0000000000 R14: ffff8880766a6000 R15: 0000000000000100
> > FS:  0000555556f6b300(0000) GS:ffff8880b9a00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000005d84c8 CR3: 0000000072c9f000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  exfat_fill_super+0x16d0/0x2990 fs/exfat/super.c:659
> >  get_tree_bdev+0x440/0x760 fs/super.c:1324
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1531
> >  do_new_mount fs/namespace.c:3040 [inline]
> >  path_mount+0x1326/0x1e20 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fa8d401085a
> > Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00
> > 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> > 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffdbcd10b08 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa8d401085a
> > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffdbcd10b20
> > RBP: 00007ffdbcd10b20 R08: 00007ffdbcd10b60 R09: 0000555556f6b2c0
> > R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
> > R13: 00007ffdbcd10b60 R14: 000000000000001d R15: 00000000200004b8
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:strcmp+0x35/0xb0 lib/string.c:281
> > Code: df 41 54 55 53 48 89 fb 48 83 ec 08 eb 08 40 84 ed 74 5d 4c 89 e6 48
> > 89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38
> > d0 7f 04 84 c0 75 50 0f b6 6b ff 4c 8d 66 01 48
> > RSP: 0018:ffffc90003e3fbd8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff89e65300 RDI: 0000000000000000
> > RBP: ffffc90003e3fd38 R08: 0000000000000005 R09: 0000000000000100
> > R10: 0000000000000100 R11: 1ffffffff17b2629 R12: 0000000000000000
> > R13: dffffc0000000000 R14: ffff8880766a6000 R15: 0000000000000100
> > FS:  0000555556f6b300(0000) GS:ffff8880b9a00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000005d84c8 CR3: 0000000072c9f000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0: df 41 54                filds  0x54(%rcx)
> >    3: 55                      push   %rbp
> >    4: 53                      push   %rbx
> >    5: 48 89 fb                mov    %rdi,%rbx
> >    8: 48 83 ec 08             sub    $0x8,%rsp
> >    c: eb 08                   jmp    0x16
> >    e: 40 84 ed                test   %bpl,%bpl
> >   11: 74 5d                   je     0x70
> >   13: 4c 89 e6                mov    %r12,%rsi
> >   16: 48 89 df                mov    %rbx,%rdi
> >   19: 48 83 c3 01             add    $0x1,%rbx
> >   1d: 48 89 f8                mov    %rdi,%rax
> >   20: 48 89 fa                mov    %rdi,%rdx
> >   23: 48 c1 e8 03             shr    $0x3,%rax
> >   27: 83 e2 07                and    $0x7,%edx
> > * 2a: 42 0f b6 04 28          movzbl (%rax,%r13,1),%eax <-- trapping
> > instruction
> >   2f: 38 d0                   cmp    %dl,%al
> >   31: 7f 04                   jg     0x37
> >   33: 84 c0                   test   %al,%al
> >   35: 75 50                   jne    0x87
> >   37: 0f b6 6b ff             movzbl -0x1(%rbx),%ebp
> >   3b: 4c 8d 66 01             lea    0x1(%rsi),%r12
> >   3f: 48                      rex.W
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAKYAXd_sNEM1KE%3DTom-htUsvw5h-iF%2BM%2BarzjP7uPYLEcJQ%2Btw%40mail.gmail.com.
