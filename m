Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F136EAD03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDUOeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjDUOeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:34:09 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF31258F
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:33:51 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7606d6bbc60so163555039f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087631; x=1684679631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Xd2qd+WH/MF9eO5FF4xvXMEmGQHBwIElfg0S6pRbbI=;
        b=FHukbFiHeWujUyPPjfEIwYkBFWYVHLHYJWC5AKyrO53M8ky0t+v2Jju1ShDcjLNuRx
         EeZHFUpgcP+MkWfXNfBTv0FbWu/BdgKCz/odQlzij6Jh0y/Nwsbjoz940iN1QxqTANzP
         V5r+Lg2lGG/+kT0LtvlNGF/14gurVyZ+SdhMlo3cKP/ig2H3d6FUuMG2gh/GBvZqRtsW
         Q6W6bdGSSX1R/h2zXzyfGtMavQKCsgc/L+pF3E17ol98EoxUuIwUt24m56uyXhZ+gzu3
         iTnKGn6KvxYQ1PyneGt1c3VJAdXZUbBw5jTwNEV3aQx0toqdHdm+x8XRoXNOYkVVb9o2
         gNHg==
X-Gm-Message-State: AAQBX9dyVIrlabB0SKV6mCaIt0wPnahHdnXc844Gq/Ur7PWMSJdhCjHv
        TS6fykVwPDIERI6I/fnYD64DTIdsE10oFh1USR1dEfwVxWXC
X-Google-Smtp-Source: AKy350brjF+Ql9WJtxgiejEpnpViFjaxOuOrE62IqEN/HsbedJPQiTthgLnXxcF82gPlJ1j0Udt/bpFBsLm7zd3MA/AphV+p3arI
MIME-Version: 1.0
X-Received: by 2002:a02:8502:0:b0:40f:80e3:6585 with SMTP id
 g2-20020a028502000000b0040f80e36585mr2518484jai.1.1682087630965; Fri, 21 Apr
 2023 07:33:50 -0700 (PDT)
Date:   Fri, 21 Apr 2023 07:33:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9915d05f9d98bdd@google.com>
Subject: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
From:   syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133bfbedc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5d44636e91081b
dashboard link: https://syzkaller.appspot.com/bug?extid=c2de99a72baaa06d31f3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3654f5f77b9/disk-76f598ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abfb4aaa5772/vmlinux-76f598ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/789fb5546551/bzImage-76f598ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in strscpy / strscpy

write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
 strscpy+0xa9/0x170 lib/string.c:165
 strscpy_pad+0x27/0x80 lib/string_helpers.c:835
 __set_task_comm+0x46/0x140 fs/exec.c:1232
 set_task_comm include/linux/sched.h:1984 [inline]
 __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
 kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
 ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
 ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
 __ext4_fill_super fs/ext4/super.c:5480 [inline]
 ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
 get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
 ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
 vfs_get_tree+0x51/0x190 fs/super.c:1510
 do_new_mount+0x200/0x650 fs/namespace.c:3042
 path_mount+0x498/0xb40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
 strscpy+0xde/0x170 lib/string.c:174
 ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
 bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
 ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
 __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
 bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
 __bpf_prog_run include/linux/filter.h:601 [inline]
 bpf_prog_run include/linux/filter.h:608 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
 bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
 __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
 schedule+0x51/0x80 kernel/sched/core.c:6701
 schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
 kthread+0x11c/0x1e0 kernel/kthread.c:369
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

value changed: 0x72 -> 0x34

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 16161 Comm: ext4lazyinit Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
