Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2492744EB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGBRR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjGBRR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:17:58 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B0E5C
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jul 2023 10:17:57 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-66a44bf4651so4167874b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jul 2023 10:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688318276; x=1690910276;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oxkh1rlVYSPaTWCnwoOH+MUQYhTKlCRUMgq6i3k0l+U=;
        b=bprXx5IfrKWEvdOQAb3z2IdRfDNdYtxBIxR6h7n+6XqdIhCyV4kOcqsY9ceeuyjpGB
         kkTUWsOOoLdcqyYX7FwtpSZQaKu729/6nS0zP0P3JW5B+lcX5v01YnuWC8saQCvh1wFB
         txe37o+MODwMsoDbt6jf3DCUbSJkIE9VT5ldN7UYbkDfupzt/wDHj7bXN+Zih1JKoxWV
         oJkUN0LJhe3Le2CQAeDh+t/LVdwBfpU3NgnCUCU8oE69dXMGBN4qBHn6ZHemVWCOWc0w
         lMjkciCLmA5+x4hlD4vgWwLyUJjtKQiJs+HL2kF5GF5u2y3vMZVHPHNbMQ9xqCSwJ0i1
         xXyg==
X-Gm-Message-State: AC+VfDzdlyjlXCcIDBnGpNo99YhR2jPSVHV0mY4Z9guhEmTvYwsxG504
        h6nw2a9BiOyZm5cJxC8+8Tdom4bkPf0LW23LEkbWWv5bBaZl
X-Google-Smtp-Source: ACHHUZ4jxb0ETuqCVb4he+NlUfpEskuZySMvmo5XV6rQfDo7VVCnw06aWXEwh5ekbYKojx9vSqDqIU3H59qStqGeN+2/jKzA1D58
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:198f:b0:67a:a9bf:f88b with SMTP id
 d15-20020a056a00198f00b0067aa9bff88bmr9254326pfl.3.1688318276496; Sun, 02 Jul
 2023 10:17:56 -0700 (PDT)
Date:   Sun, 02 Jul 2023 10:17:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002373f005ff843b58@google.com>
Subject: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in ___slab_alloc
From:   syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>
To:     42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        rientjes@google.com, roman.gushchin@linux.dev,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168b84fb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf0693aee9ea61dda749
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10310670a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220c777280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f27c1d41217a/disk-e8f75c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/843ae5d5c810/vmlinux-e8f75c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da48bc4c0ec1/bzImage-e8f75c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/658601e354e4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ___slab_alloc+0x12c3/0x1400 mm/slub.c:3270
CPU: 0 PID: 5009 Comm: syz-executor248 Not tainted 6.4.0-syzkaller-01406-ge8f75c0270d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 panic+0x686/0x730 kernel/panic.c:340
 __stack_chk_fail+0x19/0x20 kernel/panic.c:759
 ___slab_alloc+0x12c3/0x1400 mm/slub.c:3270


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
