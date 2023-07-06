Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF074939F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 04:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjGFCSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjGFCSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:18:07 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024C1BC5
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 19:18:06 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b8b2a2e720so947895ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 19:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688609886; x=1691201886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3HkeJQHl4QsBqigrw2AyOZVstwcjef6Y+Q4cyGlEL0=;
        b=PW9Pb9+om9eQG1OU987UeaVDsXhv7+L24Sa+w9Xru258INRj3qIKglh8ZzLfiUYn3O
         LJWx+7Su46cmpXfJ5N7QSiVJOH4b42jKl+4q2pV49+k4AiN8o/fEgWd468Gy2Dy36K6I
         oDTYW9brQDG8cuyiP3TCfpE4FQyMx/dWtSQ6xmqGmO0FxtGD0et8vnGa5cBsFMVIguAr
         ywCeJUoOJt071mjKrdk1NPs5LhrfizX0Ja8nL2NxNVM1xegjFpKbaw8lmMWlG++R8mG8
         1crkZvRcT+s7iiTAEKmWyuAeOxmwnBJb4I0PI7W+rji5m7GZaPAg9UI7VVVLhYJfT76J
         Dh+g==
X-Gm-Message-State: ABy/qLbZfaNNq1MtYUgWGd8W7E17gRqjOzrq3qA58EZqYz1qtcPNN6dz
        KLL4HjpndaU/9LLLcaKBPeinbDy908JvnwUIA7CYlnebX1K7
X-Google-Smtp-Source: APBJJlFKzvbEhwVHAQ31CCemK89sHRJfQnkA1kIRiIRAL0FUmCUZsbtrteTYgL7IgsCwwU4+WyWVV0vmdGWZNJdfjTaiqQOo5+YU
MIME-Version: 1.0
X-Received: by 2002:a17:902:8f96:b0:1ac:3f51:fa64 with SMTP id
 z22-20020a1709028f9600b001ac3f51fa64mr619291plo.13.1688609886159; Wed, 05 Jul
 2023 19:18:06 -0700 (PDT)
Date:   Wed, 05 Jul 2023 19:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dca4d05ffc82098@google.com>
Subject: [syzbot] [gfs2?] memory leak in gfs2_quota_init
From:   syzbot <syzbot+4ee56df41d0cc0f0783a@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10443370a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87bd445ea3f7a661
dashboard link: https://syzkaller.appspot.com/bug?extid=4ee56df41d0cc0f0783a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172d3d14a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143b6648a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c2c2ab2bd05/disk-f8566aa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0af022babece/vmlinux-f8566aa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e335287813f6/bzImage-f8566aa4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2f0686bcdcb4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ee56df41d0cc0f0783a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810aa24000 (size 8192):
  comm "syz-executor334", pid 5004, jiffies 4294954804 (age 12.830s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154c55a>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff8154c55a>] __kmalloc+0x4a/0x120 mm/slab_common.c:998
    [<ffffffff821964d9>] kmalloc include/linux/slab.h:583 [inline]
    [<ffffffff821964d9>] kzalloc include/linux/slab.h:700 [inline]
    [<ffffffff821964d9>] gfs2_quota_init+0xd9/0x770 fs/gfs2/quota.c:1373
    [<ffffffff821a1aef>] gfs2_make_fs_rw+0x11f/0x200 fs/gfs2/super.c:155
    [<ffffffff8218a1cf>] gfs2_reconfigure+0x3cf/0x530 fs/gfs2/ops_fstype.c:1602
    [<ffffffff81665d5c>] reconfigure_super+0x14c/0x3e0 fs/super.c:961
    [<ffffffff816cd5cb>] vfs_fsconfig_locked fs/fsopen.c:254 [inline]
    [<ffffffff816cd5cb>] __do_sys_fsconfig+0x80b/0x8d0 fs/fsopen.c:439
    [<ffffffff84a6bff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a6bff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810f360000 (size 8192):
  comm "syz-executor334", pid 5007, jiffies 4294955349 (age 7.380s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154c55a>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff8154c55a>] __kmalloc+0x4a/0x120 mm/slab_common.c:998
    [<ffffffff821964d9>] kmalloc include/linux/slab.h:583 [inline]
    [<ffffffff821964d9>] kzalloc include/linux/slab.h:700 [inline]
    [<ffffffff821964d9>] gfs2_quota_init+0xd9/0x770 fs/gfs2/quota.c:1373
    [<ffffffff821a1aef>] gfs2_make_fs_rw+0x11f/0x200 fs/gfs2/super.c:155
    [<ffffffff8218a1cf>] gfs2_reconfigure+0x3cf/0x530 fs/gfs2/ops_fstype.c:1602
    [<ffffffff81665d5c>] reconfigure_super+0x14c/0x3e0 fs/super.c:961
    [<ffffffff816cd5cb>] vfs_fsconfig_locked fs/fsopen.c:254 [inline]
    [<ffffffff816cd5cb>] __do_sys_fsconfig+0x80b/0x8d0 fs/fsopen.c:439
    [<ffffffff84a6bff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a6bff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
