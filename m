Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5A75DCDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGVOMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGVOMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:12:19 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85852128
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jul 2023 07:12:17 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1bb4f5cf0fbso159532fac.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jul 2023 07:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690035137; x=1690639937;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnDcp0NLtVq/ey0neKiVHzKFmmKRPAJzB+a/EW3co1A=;
        b=eL6VCXqQIc7kb6C48JTyhjYLsEICKm1SD+QkTe5t20v5rn8O43uHHIniOZehLhhcEy
         duc/WHOpaFpEcCuleDnpCMfeAE1KSSrmVki8HbBI7hYDG5hZFIhkDtOVZMNRr9Q9PBLH
         qpND8Bpm5ohQKJ8QCcJGp0Qs84UlUGhcrmiW7E//TJUkZB87XlCjnLd0Pzq40M4zKjl2
         YtjTBeLl8dvZ/fynWbddRZgct9Ta12OiZMXnNAhBOFxbCuUXPqo4D6/PhQnKkwyjjJCX
         GLjfE3rzYEGSj+a/Bgp3ym0EoMrV8yug3sy44iXsLC1BV59+rhACPkKpRi1hXh2kMOjC
         CwCQ==
X-Gm-Message-State: ABy/qLY64gFCLvzvvgeXMpWr52xNDkfiLIDXuIv7n25rWL3W1eK/2zdR
        vZt2yk8pZbBMQZZtcX+gwKbRyZNNnEk+lbfGVPpEl91bqf1R
X-Google-Smtp-Source: APBJJlEHDo8OtHioN1r+g5+qChjUQbWNll529ioG7mRnUPiQuDKhK1vas5Z8pEd572WIojX7LbcREqWqtJ6ynlcvopPteUlZ6db0
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98b3:b0:1b0:401:823d with SMTP id
 eg51-20020a05687098b300b001b00401823dmr5732307oab.6.1690035137296; Sat, 22
 Jul 2023 07:12:17 -0700 (PDT)
Date:   Sat, 22 Jul 2023 07:12:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000043f64060113f871@google.com>
Subject: [syzbot] [mm?] BUG: soft lockup in generic_file_write_iter (2)
From:   syzbot <syzbot+3b5bce3e397a2c9dcac6@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a0beef98b58 Merge tag 'tpmdd-v6.4-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1744b894280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aa4ca13c88f2286
dashboard link: https://syzkaller.appspot.com/bug?extid=3b5bce3e397a2c9dcac6
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b5bce3e397a2c9dcac6@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor.0:3202]
Modules linked in:
irq event stamp: 50116
hardirqs last  enabled at (50115): [<ffff80000ca7e160>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (50115): [<ffff80000ca7e160>] exit_to_kernel_mode+0x38/0x120 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (50116): [<ffff80000ca7fdc8>] __el1_irq arch/arm64/kernel/entry-common.c:468 [inline]
hardirqs last disabled at (50116): [<ffff80000ca7fdc8>] el1_interrupt+0x24/0x54 arch/arm64/kernel/entry-common.c:486
softirqs last  enabled at (50020): [<ffff80000801080c>] _stext+0x80c/0xd70
softirqs last disabled at (49871): [<ffff800008019484>] ____do_softirq+0x10/0x1c arch/arm64/kernel/irq.c:80
CPU: 1 PID: 3202 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-00113-g1a0beef98b58 #0
Hardware name: linux,dummy-virt (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __arch_copy_from_user+0x1b0/0x230 arch/arm64/lib/copy_template.S:164
lr : copyin lib/iov_iter.c:183 [inline]
lr : copyin+0xb8/0x118 lib/iov_iter.c:175
sp : ffff8000192a7840
x29: ffff8000192a7840 x28: ffff8000192a7c30 x27: ffff80000dddb378
x26: 0000000000001000 x25: 0000000040000000 x24: ffff000006324000
x23: 0000ffff99400000 x22: 0000ffff99454000 x21: ffff000006324000
x20: 0000ffff99454000 x19: 0000000000001000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff99454000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff000006324d80
x5 : ffff000006325000 x4 : 0000000000000000 x3 : ffff80000910e070
x2 : 0000000000000200 x1 : 0000ffff99454dc0 x0 : ffff000006324000
Call trace:
 __arch_copy_from_user+0x1b0/0x230 arch/arm64/lib/copy_template.S:158
 copy_page_from_iter_atomic+0x33c/0xe5c lib/iov_iter.c:815
 generic_perform_write+0x218/0x3ec mm/filemap.c:3934
 __generic_file_write_iter+0x1e8/0x3a0 mm/filemap.c:4054
 generic_file_write_iter+0xc0/0x294 mm/filemap.c:4086
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x4c8/0x740 fs/read_write.c:584
 ksys_write+0xec/0x1d0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x6c/0x9c fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x50/0x124 arch/arm64/kernel/syscall.c:193
 el0_svc+0x54/0x140 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
