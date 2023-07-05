Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919F747BEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 05:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGEDzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEDzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:55:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5610E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 20:55:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so248385e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 20:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688529337; x=1691121337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaO+Xx+AffiAOFAxmcebERanhAHdbOWTOJWXKAKt4bs=;
        b=7wUNH7avrpxryyy6C9KEuNHJPJH10Qhk+QmpnP7wvg0Y0CYLwO/jYKY0d7XuXEYIWH
         HefCN1SsmbswImVyio4B+emgVVu+F4sZTBje3g5jZKjAkvs2cQssqysZEBqlnv+5zbHU
         QvaL23XspKrJjvyQMdGyvJx5toyYRllgOSVl1dAuyCI0qjg/DybEga/YbmGyYvvhwDHM
         0vPcb5IupX+UXoebxoCu5iiOS3Z/SpNYO/pEZfrFPAPdo63A1eVBEdNI41qD2zHOCkVo
         vUbMm2qDdis90mNM5Dz2hIh5Uz+wlnnIcRJgPXBtsdmffqvVxSM22j74kVP+U5hEgxQY
         ejXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688529337; x=1691121337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaO+Xx+AffiAOFAxmcebERanhAHdbOWTOJWXKAKt4bs=;
        b=bkyfCu3/1vZNyeDQt+iNDHm0ZM1qhD4p6qMJNQ/jHKipeGO9D5MGRu0K2DG/ZifGBx
         O/EoY1n4v/GB2x+r0t4gtYuO8HeQLrZAYeL0vU1QEQBPxZyROFd1nyoDbgaE5YmnyZQj
         qHGSijqt4dOhOjG8pcz7+WZzc2Km7C8VpGt5Xy1Kuz7BKc9xI6dshVlj+j7sX2NwbKiq
         qpqZzK9+ugvamD5YR9oJY0sZ9E8jLaka4PH03d8sqk+KUtCymruovQQQ5JEsMBjUOm66
         6Zbv04+sgHdXVNzRbeAnVBgDjFHVbGmn0wutxNBG0yO/Rg5MAtRbkhta6WVdrDErhcua
         Ki7g==
X-Gm-Message-State: ABy/qLYShkHklX9idmMWi2lPoTDB6Z/xWp/LBvjKutwUjMJXxaeBxvVy
        tw1gk6MFTdpytdA6vQwpFoeHje08vXdLqTJIBSgumw==
X-Google-Smtp-Source: APBJJlETKlxByGVhbMEQprFacD+SpR4g71GUaaNIA3XyET1zsdvRYMBVqxEVTUUQsM8eboALav5uNE5Nuf6JasdXrXw=
X-Received: by 2002:a05:600c:3ba3:b0:3f7:e59f:2183 with SMTP id
 n35-20020a05600c3ba300b003f7e59f2183mr17526wms.5.1688529336872; Tue, 04 Jul
 2023 20:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000008d0f405ff98fa21@google.com> <CAL3q7H4uHx14j91qNmXcghk-N-8yTC2mtF+5_9-SSg78jwmDLw@mail.gmail.com>
In-Reply-To: <CAL3q7H4uHx14j91qNmXcghk-N-8yTC2mtF+5_9-SSg78jwmDLw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Jul 2023 05:55:24 +0200
Message-ID: <CACT4Y+ZFU3sLjdW5oVLNH4=8BG3GadiQ69f1t1kSKY80xiCw4Q@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in merge_reloc_roots
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     syzbot <syzbot+adac949c4246513f0dc6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Jul 2023 at 22:30, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, Jul 3, 2023 at 7:34=E2=80=AFPM syzbot
> <syzbot+adac949c4246513f0dc6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    b19edac5992d Merge tag 'nolibc.2023.06.22a' of git://gi=
t.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17e0cfe0a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D33c8c2baba1=
cfc7e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadac949c42465=
13f0dc6
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1562a47f2=
80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e1a4f239105a/d=
isk-b19edac5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/25776c3e9785/vmli=
nux-b19edac5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ca7e959d451d=
/bzImage-b19edac5.xz
> > mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2926f=
e9a4819/mount_0.gz
> > mounted in repro #2: https://storage.googleapis.com/syzbot-assets/da38c=
75be578/mount_17.gz
> >
> > The issue was bisected to:
> >
> > commit 751a27615ddaaf95519565d83bac65b8aafab9e8
> > Author: Filipe Manana <fdmanana@suse.com>
> > Date:   Thu Jun 8 10:27:49 2023 +0000
> >
> >     btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()
>
> If the bisection is correct, then it means before that commit we would
> hit a BUG_ON(), which is definitely not better...
>
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15196068=
a80000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17196068=
a80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13196068a80=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+adac949c4246513f0dc6@syzkaller.appspotmail.com
> > Fixes: 751a27615dda ("btrfs: do not BUG_ON() on tree mod log failures a=
t btrfs_del_ptr()")
> >
> > assertion failed: 0, in fs/btrfs/relocation.c:2011
> > ------------[ cut here ]------------
> > kernel BUG at fs/btrfs/relocation.c:2011!
>
> I don't see how this can be related to removing the BUG_ON() in
> del_ptr(), aborting the transaction and propagating the error up the
> call chain.
>
> So it seems not hitting the BUG_ON()'s removed by that commit may
> somehow trigger this assertion failure in an error path of relocation.
>
> But this assertion is in a path that is able to handle the error:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/btrfs/relocation.c?h=3Dv6.4#n2011
>
> The ASSERT(0) is there to make sure developers are notified of this
> unexpected case.
> Replacing it with a WARN_ON() would prevent the crash when
> CONFIG_BTRFS_ASSERT=3Dy, but syzbot would still complain about a
> warning/stack trace, even if it doesn't trigger a crash.
>
> So I'm not sure if we can keep syzbot always happy all the time for all c=
ases.

Hi Filipe,

If this condition does not mean a kernel bug, then it shouldn't use WARN/BU=
G.
It's not about syzbot, it's about any automated and manual testing.
If it aims at end users, then a readable message with pr_err stating
what to do and where to report it would be more suitable/useful.

But the current message suggests it's a kernel bug, no?
Or at least it looks like developers couldn't think of a way how it
can happen, so the comment can be updated as well now that we know how
it can happen.

/*
* This is actually impossible without something
* going really wrong (like weird race condition
* or cosmic rays).
*/



> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 7243 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-01312=
-gb19edac5992d #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/27/2023
> > RIP: 0010:merge_reloc_roots+0x98b/0x9a0 fs/btrfs/relocation.c:2011
> > Code: cb d1 10 07 0f 0b e8 84 9d ed fd 48 c7 c7 60 45 2b 8b 48 c7 c6 c0=
 50 2b 8b 48 c7 c2 e0 45 2b 8b b9 db 07 00 00 e8 a5 d1 10 07 <0f> 0b e8 7e =
12 13 07 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41
> > RSP: 0018:ffffc9000656f760 EFLAGS: 00010246
> > RAX: 0000000000000032 RBX: ffff88806a59a030 RCX: a7b6d3c4bc715b00
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffc9000656f870 R08: ffffffff816efd9c R09: fffff52000cadea1
> > R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888079e16558
> > R13: ffff888079e16000 R14: ffff88806a59a000 R15: dffffc0000000000
> > FS:  00007f62d8f56700(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f7ba56f1000 CR3: 000000001a7d0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  relocate_block_group+0xa68/0xcd0 fs/btrfs/relocation.c:3751
> >  btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
> >  btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
> >  __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
> >  btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
> >  btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f62d828c389
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f62d8f56168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f62d83abf80 RCX: 00007f62d828c389
> > RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000006
> > RBP: 00007f62d82d7493 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffedd8614bf R14: 00007f62d8f56300 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:merge_reloc_roots+0x98b/0x9a0 fs/btrfs/relocation.c:2011
> > Code: cb d1 10 07 0f 0b e8 84 9d ed fd 48 c7 c7 60 45 2b 8b 48 c7 c6 c0=
 50 2b 8b 48 c7 c2 e0 45 2b 8b b9 db 07 00 00 e8 a5 d1 10 07 <0f> 0b e8 7e =
12 13 07 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41
> > RSP: 0018:ffffc9000656f760 EFLAGS: 00010246
> > RAX: 0000000000000032 RBX: ffff88806a59a030 RCX: a7b6d3c4bc715b00
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffc9000656f870 R08: ffffffff816efd9c R09: fffff52000cadea1
> > R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888079e16558
> > R13: ffff888079e16000 R14: ffff88806a59a000 R15: dffffc0000000000
> > FS:  00007f62d8f56700(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f83ebdff000 CR3: 000000001a7d0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
