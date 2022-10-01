Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D0B5F1CBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJAO0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJAO0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:26:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FED15FC3
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Oct 2022 07:26:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o7so3573745lfk.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Oct 2022 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TJL3XXljKiLeAtCItEGRKkWqiI5YNRAhLTMDZxiSNTQ=;
        b=amd5rhwDiqgWnopu4yJyzpt0nAXBu8mrvHR2bRK1d/L68eOaoIrk8JDufQo373hyxm
         GeBVmbDOTKn+H7/xiVFFxm5QwrrYvVo0F3nwVDlArOzCUv5DFc+nkU3vLBpKHO7tM7wL
         OFdkNhVEAyaf4ngqPvxZshlkvqYrb82Zb18fGcls2/XdAuuckQRZaAULwgfG/Y2Wtulq
         BJ3GMMgdgznhLn+BsG0vNw2Vev3gR2+85oHZ0D0MIUTBQQHLK+ZvIrK3wvOL0D/Hhfxj
         0vMiiV+dVVKEeO3c+f7/7EFHvv/OTEeF+88YbnlVm6lUifHTueT19ra10u5DfxkHKocd
         Pq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TJL3XXljKiLeAtCItEGRKkWqiI5YNRAhLTMDZxiSNTQ=;
        b=HS9sjvT5Y8nXR1O7kS0wE2KhgYZM9nvdkAoYgFDP08dYuzHVC280z5/3fOmEQyw0ja
         xzwnk6UzkqxDUgktJIxgRrCYvTtbgEwc8wZjm0fCXn7fLKKioswTWbzi6Z/4K2e78wvQ
         FMJ4X96OldD+Szth5arHhoj7yvhVxIwbGUkWn52WTXozAN0iP6HZNNKY6LzLrBXauEVm
         B8f8jdkMOVYEEpGOSyQE+rMbv0NztfmYJC26kLR67aSYn44iodkCtw0QtZ1MWOtQczgn
         /NvoHvvn++PTnfw9csIYb5jsPl1fxpURoAzDUQzWy140Mw2mAtSTtRfT3ItUVj7jvlx4
         NHzg==
X-Gm-Message-State: ACrzQf3WU0mDCR8NwPlqT+pB78/RKrXPT1d7x7ZIKeQb2o1MRuhvPT+u
        K/0TgWiMq5z06PYaASdlwqlEoqF3wvPVrzw2HOc5fQ==
X-Google-Smtp-Source: AMsMyM4RGgUwSexsbuCqV80Lp+hVzOYvShzKBOc/z06XQRLu2sr2TvacuU6Ou2aA9kHCgipaWQ2KEfqmB2vwhEsZ3L4=
X-Received: by 2002:ac2:5462:0:b0:49b:8aee:3535 with SMTP id
 e2-20020ac25462000000b0049b8aee3535mr4582153lfn.410.1664634403171; Sat, 01
 Oct 2022 07:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043f31305e9f965f6@google.com>
In-Reply-To: <00000000000043f31305e9f965f6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 1 Oct 2022 16:26:30 +0200
Message-ID: <CACT4Y+aZFUoHpsY1JR8reMSCSkJxr9FbCPQYxGBqm9ZC2VPKow@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __find_get_block
To:     syzbot <syzbot+250b054f84ffcf12d7f1@syzkaller.appspotmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
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

On Sat, 1 Oct 2022 at 15:50, syzbot
<syzbot+250b054f84ffcf12d7f1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bbbb9c880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=250b054f84ffcf12d7f1
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+250b054f84ffcf12d7f1@syzkaller.appspotmail.com

+fat maintainers

> ------------[ cut here ]------------
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
> WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 brelse include/linux/buffer_head.h:327 [inline]
> WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 bh_lru_install fs/buffer.c:1259 [inline]
> WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 __find_get_block+0xfe9/0x1110 fs/buffer.c:1309
> Modules linked in:
> CPU: 0 PID: 6477 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:__brelse fs/buffer.c:1145 [inline]
> RIP: 0010:brelse include/linux/buffer_head.h:327 [inline]
> RIP: 0010:bh_lru_install fs/buffer.c:1259 [inline]
> RIP: 0010:__find_get_block+0xfe9/0x1110 fs/buffer.c:1309
> Code: 8e ff e8 5a f5 94 ff fb e9 02 f3 ff ff e8 5f 48 8e ff e9 f8 f2 ff ff e8 55 48 8e ff 48 c7 c7 a0 9a 9d 8a 31 c0 e8 27 d5 56 ff <0f> 0b e9 de f2 ff ff 44 89 f9 80 e1 07 38 c1 0f 8c a1 f3 ff ff 4c
> RSP: 0018:ffffc90004a9f880 EFLAGS: 00010246
> RAX: 533f0fab2aa63200 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc900054e9000 RSI: 000000000000bd65 RDI: 000000000000bd66
> RBP: ffffc90004a9f9e0 R08: ffffffff816bd38d R09: ffffed1017364f14
> R10: ffffed1017364f14 R11: 1ffff11017364f13 R12: 1ffff11017366bae
> R13: ffff8880292d6828 R14: ffff88802901ee80 R15: ffff8880290195d0
> FS:  00007fc26c747700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110f33724b CR3: 000000007c6dd000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __getblk_gfp+0x2d/0x290 fs/buffer.c:1329
>  sb_getblk include/linux/buffer_head.h:363 [inline]
>  fat_zeroed_cluster+0x18b/0x8c0 fs/fat/dir.c:1092
>  fat_alloc_new_dir+0x7c6/0xc90 fs/fat/dir.c:1185
>  vfat_mkdir+0x15a/0x410 fs/fat/namei_vfat.c:859
>  vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
>  do_mkdirat+0x279/0x550 fs/namei.c:4038
>  __do_sys_mkdirat fs/namei.c:4053 [inline]
>  __se_sys_mkdirat fs/namei.c:4051 [inline]
>  __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fc26b68a5a9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc26c747168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00007fc26b7abf80 RCX: 00007fc26b68a5a9
> RDX: 0000000000000004 RSI: 0000000020000040 RDI: 0000000000000005
> RBP: 00007fc26b6e5580 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffdd6d66b0f R14: 00007fc26c747300 R15: 0000000000022000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000043f31305e9f965f6%40google.com.
