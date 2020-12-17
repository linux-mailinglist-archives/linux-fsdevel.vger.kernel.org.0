Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29B2DDAE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgLQVeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 16:34:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38649 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLQVeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:34:22 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kq0u3-00011J-Bo; Thu, 17 Dec 2020 21:33:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [PATCH] close_range: cap range for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
Date:   Thu, 17 Dec 2020 22:33:03 +0100
Message-Id: <20201217213303.722643-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <https://lore.kernel.org/lkml/000000000000a3962305b6ab0077@google.com>
References: <https://lore.kernel.org/lkml/000000000000a3962305b6ab0077@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After introducing CLOSE_RANGE_CLOEXEC syzbot reported a crash when
CLOSE_RANGE_CLOEXEC is specified in conjunction with CLOSE_RANGE_UNSHARE.
When CLOSE_RANGE_UNSHARE is specified the caller will receive a private
file descriptor table in case their file descriptor table is currently
shared. When the caller requests that all file descriptors are supposed to
be operated on via e.g. a call like close_range(3, ~0U) and the caller
shares their file descriptor table then the kernel will only copy all
files in the range from 0 to 3 and no others.
When the caller requests CLOSE_RANGE_CLOEXEC in such a scenario we need to
make sure that the maximum fd of the newly allocated file descriptor table
is used, not the maximum of the old file descriptor table. The patch has
been tested by syzbot (see below) and the issue went away.

syzbot reported
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170 fs/open.c:1274
Read of size 8 at addr 0000000000000077 by task syz-executor511/8522

CPU: 1 PID: 8522 Comm: syz-executor511 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 filp_close+0x22/0x170 fs/open.c:1274
 close_files fs/file.c:402 [inline]
 put_files_struct fs/file.c:417 [inline]
 put_files_struct+0x1cc/0x350 fs/file.c:414
 exit_files+0x12a/0x170 fs/file.c:435
 do_exit+0xb4f/0x2a00 kernel/exit.c:818
 do_group_exit+0x125/0x310 kernel/exit.c:920
 get_signal+0x428/0x2100 kernel/signal.c:2792
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x124/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447039
Code: Unable to access opcode bytes at RIP 0x44700f.
RSP: 002b:00007f1b1225cdb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00000000006dbc28 RCX: 0000000000447039
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000006dbc2c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff223b6bef R14: 00007f1b1225d9c0 R15: 00000000006dbc2c
==================================================================

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com

Tested on:

commit:         3274183b close_range: cap range for CLOSE_RANGE_UNSHARE | ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d42216b510180e3
dashboard link: https://syzkaller.appspot.com/bug?extid=96cfd2b22b3213646a93
compiler:       gcc (GCC) 10.1.0-syz 20200507

Reported-by: syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com
Fixes: 582f1fb6b721 ("fs, close_range: add flag CLOSE_RANGE_CLOEXEC")
Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
I'll try to send this asap to get this fixed unless someone sees an
issue with this. I'll also add tests for this in a little bit.

Christian
---
 fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 8434e0afecc7..0420cdb2ae5d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -639,6 +639,10 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
 
 	spin_lock(&cur_fds->file_lock);
 	fdt = files_fdtable(cur_fds);
+	if (max_fd >= fdt->max_fds) {
+		max_fd = fdt->max_fds;
+		max_fd--;
+	}
 	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
 	spin_unlock(&cur_fds->file_lock);
 }

base-commit: accefff5b547a9a1d959c7e76ad539bf2480e78b
-- 
2.29.2

