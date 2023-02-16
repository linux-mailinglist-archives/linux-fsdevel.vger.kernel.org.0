Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD269996C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBPQDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 11:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPQDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:03:05 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9514E5EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 08:02:43 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id i4so1401698vkn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676563361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yidu0zU1od6YrjrFmPSZm0LFBFCVNontJd1Rn2+cFKE=;
        b=BvNaTgeiuDfpGNqMqeyD1QX2wPyf2ZWxrAW1w7QoL4UTSPc1TUdJPfNpC8nWtRRUIq
         IZldLc+LfaQ+OIW4gr+zJ3AoZWkQ4aylTKTAquUOCV5pLIiZBy9LEpv9sZL4W/K0df3y
         0k1GnOpTf1F32gRCIPzjShgF/UaaJeIcsRSYBSdHDABFHPpVNSe6CyWnEiG/pgStoKig
         PVWOf9a8rl2H+R90SzevN2/0ppCqsJm0PzMJXe9aiNabBohVqQgF31y7fsYekcMjIOPH
         8shi3+LCPBexM7f0mwLnakBqhaDeP8cL8ftaQDrvh2GUadThQaqYdTrS5PacXeMEbI14
         HK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676563361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yidu0zU1od6YrjrFmPSZm0LFBFCVNontJd1Rn2+cFKE=;
        b=faAD7N/O2VQMbZ8WbZCrDb8lOaeECp15ATFfFW2Xsb06r9r3dLXFpxm5bC+tBjVjr6
         ozrKvZ0DZhWeRQwDdwrysaLoJtAjJ1gQBQqXpWLZ+pCVLLx45CLParLdXHTq6vBali2+
         hFFqLQWn2hZ+rwazLdOMOaN+otm1/kPl/0fWEwsAObacIyVutz9f+jk+d8Yi3/F+eXdt
         vGfERUGqrk830ggMAzPTnU1pMX66CurLdXXUZtIW+ZYlPRpU1ZwlF3DI721XvMfXF/67
         7PnJ5v8fRga2+UE27/1j9PplHQdnAx+7AgPTOcl8sBP/tH0aISwEFvpZ7pJOoaTZwhG4
         kzVg==
X-Gm-Message-State: AO0yUKUIaot+iOu21UT9z38pZkSkg4is+MshmDXHRWBxy1Onjhfl5+q8
        wwPI63dQq8xMLWlUJke2Zi+c9qpUikW2ve7rVOlpuWCC+47KBGVnGaM=
X-Google-Smtp-Source: AK7set+D0X+i2k1nuvorSnxEkaiXd5fNUekPdMFj+R7grjawOoZH2y2VvU5mxDIw8rLloYrsDIfs5BiqSiefcco5x8A=
X-Received: by 2002:a1f:9f10:0:b0:401:ce45:f9d6 with SMTP id
 i16-20020a1f9f10000000b00401ce45f9d6mr958535vke.13.1676563360728; Thu, 16 Feb
 2023 08:02:40 -0800 (PST)
MIME-Version: 1.0
References: <00000000000057042905f4cf1130@google.com>
In-Reply-To: <00000000000057042905f4cf1130@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 16 Feb 2023 17:02:29 +0100
Message-ID: <CANp29Y5ydC0F9NiYQShfW9fDcre6ZLFi3ZHj7=U5Zpq6=4Z_HA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_mknodat
To:     syzbot <syzbot+3509066790782614b600@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This one was reported by a mistake, sorry.
The crash happened only once quite a long time ago and has no
reproducer. Let's close it.

#syz invalid

On Thu, Feb 16, 2023 at 11:57 AM syzbot
<syzbot+3509066790782614b600@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12437928480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3509066790782614b600
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b0959a409a79/disk-0a924817.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/388daa76797b/vmlinux-0a924817.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b9d2d406c075/bzImage-0a924817.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3509066790782614b600@syzkaller.appspotmail.com
>
> WARNING: CPU: 1 PID: 8065 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
> WARNING: CPU: 1 PID: 8065 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
> Modules linked in:
> CPU: 1 PID: 8065 Comm: syz-executor.1 Not tainted 6.1.0-syzkaller-14321-g0a924817d2ed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
> RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
> Code: c7 00 ac ed 8a 48 c7 c6 a0 ae ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 9b 59 e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 98 8a 96 8e 80 e1 07 80 c1 03 38 c1
> RSP: 0000:ffffc90016557d20 EFLAGS: 00010292
> RAX: 4e2f149d5ad82600 RBX: ffffffff8aedace0 RCX: 0000000000040000
> RDX: ffffc9000b6bc000 RSI: 000000000001920b RDI: 000000000001920c
> RBP: ffffc90016557df0 R08: ffffffff816f2c9d R09: fffff52002caaf5d
> R10: fffff52002caaf5d R11: 1ffff92002caaf5c R12: 0000000000000000
> R13: ffff88807799b6d0 R14: 1ffff92002caafac R15: dffffc0000000000
> FS:  00007f84df1f6700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff06e74d68 CR3: 0000000021050000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  inode_unlock include/linux/fs.h:761 [inline]
>  done_path_create fs/namei.c:3857 [inline]
>  do_mknodat+0x4e1/0x740 fs/namei.c:3980
>  __do_sys_mknod fs/namei.c:3998 [inline]
>  __se_sys_mknod fs/namei.c:3996 [inline]
>  __x64_sys_mknod+0x8a/0xa0 fs/namei.c:3996
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f84de48c0a9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f84df1f6168 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000085
> RAX: ffffffffffffffda RBX: 00007f84de5ac050 RCX: 00007f84de48c0a9
> RDX: 0000000000000702 RSI: 00000000ffffc000 RDI: 00000000200001c0
> RBP: 00007f84de4e7ae9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc94aa0aef R14: 00007f84df1f6300 R15: 0000000000022000
>  </TASK>
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000057042905f4cf1130%40google.com.
