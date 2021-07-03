Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F286C3BA772
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 07:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGCFyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 01:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGCFyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 01:54:01 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315DC061765
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jul 2021 22:51:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h18so5790343qve.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biRXCrniOr8NyrU3rxSndxHeht/aiaaxQabSzPvoUfA=;
        b=FAythbNB54SNLPjZbhrQoBnQLBug9s7RaH7mPFs+sRyYjSicsRv3/Sxpmwek0kGpS7
         sgPzXKS0hxO4HV6vnl+oKGtU3Rw/pkQKva7dz23gfSIYXxpNHn952X/IdFKm6GdmYYKE
         AEEIKneyIxVMJ67vodZrL58/mr3ACBLg8CiFQUFSW5dliKtmy7j4plQSwEeoT+mbA/bE
         bJN9hZPDEG8Zf1cr10TCdXnWzuQZRE5BeZfbPHoLc4qbcEcEgaD0uPDco5oT9CzB1T3O
         r0s1ClVAyQvaQQgasKz1D2NhHVImU9RQLF35caT800FlNyEWntqABBb6irCh4N08AG9K
         4+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biRXCrniOr8NyrU3rxSndxHeht/aiaaxQabSzPvoUfA=;
        b=e7KjOoKjRtQ78fMPsWWGwxl6X7oEfz20jgYw7eog7j0MrW7PhOQOQpZoNkD1xlkibw
         tW6gZKCsYPNhM2f7Mtfwr9GSU9AriI1k3xMf+eNkB7qP1xpFMBXZOSkfBKDcGXpw6u5q
         M7mzA794E5YQMLNrb7AW+ppuLjBFKVvl002Yjjlpn/oTNCpOc6WPSMlhk0mmxK/8tn5r
         h29xt+Rv8mAAy6mtBfykeKpBlvBNW3KzmEQQOcu8UkddBbeDJIooAykePCaX4DuyaH5v
         AfCEXdLt2Dp04e+7qkBiHTeonFbZhMA4V7AedVzb/pKPUFOomGBNImEDeBKyMKfRk+D3
         INUA==
X-Gm-Message-State: AOAM533jdge67+tXLEGCPwVpi6Tuk+NO3FFAeME3JN7mH4SzVC2Q4pNw
        HODzaAAUuae9BKfCgeT+pVilez/EpQ/U0V9/FL4cIw==
X-Google-Smtp-Source: ABdhPJyVgAyzc8jWkJwL7WOHMxEXX9kXqICyPLFKIH7MblGmOpiuf3CmZoqIFVM6QOco5E4Yx+LpXhchgCQbWmG2Zd8=
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr3044519qvb.37.1625291486134;
 Fri, 02 Jul 2021 22:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004e5ec705c6318557@google.com>
In-Reply-To: <0000000000004e5ec705c6318557@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 3 Jul 2021 07:51:04 +0200
Message-ID: <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
To:     syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 3, 2021 at 7:41 AM syzbot
<syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    62fb9874 Linux 5.13
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com

+Casey for what looks like a smackfs issue

The crash was triggered by this test case:

21:55:33 executing program 1:
r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
&(0x7f0000000300)='default_permissions', 0x0)

And I think the issue is in smack_fs_context_parse_param():
https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691

But it seems that selinux_fs_context_parse_param() contains the same issue:
https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
+So selinux maintainers as well.



> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
>  vfs_fsconfig_locked fs/fsopen.c:265 [inline]
>  __do_sys_fsconfig fs/fsopen.c:439 [inline]
>  __se_sys_fsconfig+0xba9/0xff0 fs/fsopen.c:314
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe01ae27188 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> RDX: 00000000200002c0 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020000300 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007ffd4bb7c5bf R14: 00007fe01ae27300 R15: 0000000000022000
> Modules linked in:
> ---[ end trace 5d7119165725bd63 ]---
> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
> FS:  00007fe01ae27700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004e4da0 CR3: 0000000018afc000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004e5ec705c6318557%40google.com.
