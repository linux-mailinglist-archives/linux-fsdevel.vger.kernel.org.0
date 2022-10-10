Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0995F9A13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiJJHix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiJJHid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:38:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E763C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:32:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m14so12276574ljg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HoevG8guEuIveklFwyIJN94Jfdt5yBCCAsgVY0m6qQ4=;
        b=jzh5s2LfQMufug0HVpzThDeJGoSoVOsGCL3NDWkJaxm6ycsm7KJ/hVwQxM97a+C2oM
         ugLTj1Uo2gHcsU8MDuKWw6FCTbBEP/kWWrmiu4zZJM6KhwlV4L7/n6qgkdtyBc7juYDj
         ONIusGbhF6v2mMCzHuIhWe962/nfy5nk/pp7APbdSD29J+/qYSaP6NI0mAf1m4IEBjew
         YZzwKyNLQ0y0jtzkED6U++TPWUjWQ3A0Axn/lq0EtmLiHqkAUz4Wm3EbE6zV/mBlBe0I
         OfxtJEuqdLYUJmEciqb0sE6Hdy9d1S2+k6Pu/Oz3EKR/jvN10cfJES3V8+VVJFm01sKi
         Xilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoevG8guEuIveklFwyIJN94Jfdt5yBCCAsgVY0m6qQ4=;
        b=2YYhvc44muHmcC2JEtA5vg8JO1+bWQh+0xUi3yNOI2bruJT0S+rduGPd/d9BP4rLPA
         evKMwOQrqUe6aPalhjA922gQTJDkqXT/GGf8mG+1ivimKMPPUGi1HYkZekVaJY6eUjtH
         G3FDMZH7rgz6jZjzkIla9y24jbk/v5HysyaWc9Tmx+wT8V5XV6cThrLU5dHgrso6ZxFl
         ySdV7OiZvl3zdli+eGyT1f3l289lnBNK+Iaxpv8TwgvraevmU2qNXsPrq9nHg56x1df+
         SvvsCo3rCKSgXLtZV4ylB4VZuAetwn4OijpxE+F7NOFyCl9sLa4kVA1uxX8M17tYB6qO
         1HDQ==
X-Gm-Message-State: ACrzQf23RG8QcxNvfPLJp4hCVILrNtnfLdlr1IRgJVPZlOxfexc6/V3l
        J4MMywJz6qVku8+O7kNDB0o3j8svO7tHrssRVtVeXg==
X-Google-Smtp-Source: AMsMyM46E9UQ/49MwtRP69MMnMKBAyJKimFv1t84zIgncflJc3pR7IOczDt8F4M8QiHq09sg0dEP+93xM6UrYynWHvs=
X-Received: by 2002:a2e:978e:0:b0:26e:8ad6:6d5b with SMTP id
 y14-20020a2e978e000000b0026e8ad66d5bmr4352859lji.363.1665387153867; Mon, 10
 Oct 2022 00:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a418e405eaa8ed24@google.com>
In-Reply-To: <000000000000a418e405eaa8ed24@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Oct 2022 09:32:22 +0200
Message-ID: <CACT4Y+ZACxCR_uUfJX5kTrLsjtREvPcs7HsQo287PN2wSqnHRg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in find_lock_entries
To:     syzbot <syzbot+17eb1d8cd53dbad65d63@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

On Mon, 10 Oct 2022 at 09:15, syzbot
<syzbot+17eb1d8cd53dbad65d63@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1268e884880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd3623e135f4c106
> dashboard link: https://syzkaller.appspot.com/bug?extid=17eb1d8cd53dbad65d63
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171bc9a2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152e2e1c880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7c58f480421f/disk-833477fc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8a50ac7bd40b/vmlinux-833477fc.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/763012bec257/mount_0.gz

+ntfs3 maintainers (ntfs3 is mounted in the repro)
btw, there is the mounted image in the "mounted in repro" link above

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17eb1d8cd53dbad65d63@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY)
> WARNING: CPU: 1 PID: 7921 at kernel/locking/lockdep.c:5031 __lock_acquire+0x16a2/0x1f60 kernel/locking/lockdep.c:5031
> Modules linked in:
> CPU: 1 PID: 7921 Comm: syz-executor252 Not tainted 6.0.0-syzkaller-05118-g833477fce7a1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:__lock_acquire+0x16a2/0x1f60 kernel/locking/lockdep.c:5031
> Code: 85 bb 08 00 00 83 3d c4 a6 a5 0c 00 0f 85 e7 fe ff ff 45 31 f6 48 c7 c7 80 7d 8d 8a 48 c7 c6 00 a6 8d 8a 31 c0 e8 4e 45 e8 ff <0f> 0b e9 c8 fe ff ff 0f 0b e9 24 fb ff ff 48 c7 c1 94 96 0c 8e 80
> RSP: 0018:ffffc9000b927448 EFLAGS: 00010046
> RAX: 89f46c2ecaded100 RBX: 0000000000000028 RCX: ffff88807e309d80
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff816af64d R09: ffffed1017364f13
> R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: 1ffff1100fc614fd
> R13: d9e18f2b6560b4e9 R14: 0000000000000000 R15: ffff88807e30a818
> FS:  0000555555677300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4123ae45b0 CR3: 000000007a13c000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
>  rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:304
>  rcu_read_lock include/linux/rcupdate.h:738 [inline]
>  find_lock_entries+0x173/0x1040 mm/filemap.c:2099
>  truncate_inode_pages_range+0x1a2/0x1780 mm/truncate.c:364
>  ntfs_evict_inode+0x18/0xb0 fs/ntfs3/inode.c:1741
>  evict+0x2a4/0x620 fs/inode.c:665
>  ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
>  get_tree_bdev+0x400/0x620 fs/super.c:1323
>  vfs_get_tree+0x88/0x270 fs/super.c:1530
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4123ab5b3a
> Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe8fd49088 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4123ab5b3a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe8fd490a0
> RBP: 00007ffe8fd490a0 R08: 00007ffe8fd490e0 R09: 00007ffe8fd490e0
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
> R13: 00007ffe8fd490e0 R14: 000000000000010e R15: 0000000020001b50
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
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a418e405eaa8ed24%40google.com.
