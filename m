Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFA10E6BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfLBIOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbfLBIOZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AAB21B4B9543D1B553E4;
        Mon,  2 Dec 2019 16:14:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:12 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 6/7] proc: fix coredump vs read /proc/*/stat race
Date:   Mon, 2 Dec 2019 16:35:18 +0800
Message-ID: <20191202083519.23138-7-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191202083519.23138-1-yi.zhang@huawei.com>
References: <20191202083519.23138-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

commit 8bb2ee192e482c5d500df9f2b1b26a560bd3026f upstream.

do_task_stat() accesses IP and SP of a task without bumping reference
count of a stack (which became an entity with independent lifetime at
some point).

Steps to reproduce:

    #include <stdio.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <sys/time.h>
    #include <sys/resource.h>
    #include <unistd.h>
    #include <sys/wait.h>

    int main(void)
    {
    	setrlimit(RLIMIT_CORE, &(struct rlimit){});

    	while (1) {
    		char buf[64];
    		char buf2[4096];
    		pid_t pid;
    		int fd;

    		pid = fork();
    		if (pid == 0) {
    			*(volatile int *)0 = 0;
    		}

    		snprintf(buf, sizeof(buf), "/proc/%u/stat", pid);
    		fd = open(buf, O_RDONLY);
    		read(fd, buf2, sizeof(buf2));
    		close(fd);

    		waitpid(pid, NULL, 0);
    	}
    	return 0;
    }

    BUG: unable to handle kernel paging request at 0000000000003fd8
    IP: do_task_stat+0x8b4/0xaf0
    PGD 800000003d73e067 P4D 800000003d73e067 PUD 3d558067 PMD 0
    Oops: 0000 [#1] PREEMPT SMP PTI
    CPU: 0 PID: 1417 Comm: a.out Not tainted 4.15.0-rc8-dirty #2
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc27 04/01/2014
    RIP: 0010:do_task_stat+0x8b4/0xaf0
    Call Trace:
     proc_single_show+0x43/0x70
     seq_read+0xe6/0x3b0
     __vfs_read+0x1e/0x120
     vfs_read+0x84/0x110
     SyS_read+0x3d/0xa0
     entry_SYSCALL_64_fastpath+0x13/0x6c
    RIP: 0033:0x7f4d7928cba0
    RSP: 002b:00007ffddb245158 EFLAGS: 00000246
    Code: 03 b7 a0 01 00 00 4c 8b 4c 24 70 4c 8b 44 24 78 4c 89 74 24 18 e9 91 f9 ff ff f6 45 4d 02 0f 84 fd f7 ff ff 48 8b 45 40 48 89 ef <48> 8b 80 d8 3f 00 00 48 89 44 24 20 e8 9b 97 eb ff 48 89 44 24
    RIP: do_task_stat+0x8b4/0xaf0 RSP: ffffc90000607cc8
    CR2: 0000000000003fd8

John Ogness said: for my tests I added an else case to verify that the
race is hit and correctly mitigated.

Link: http://lkml.kernel.org/r/20180116175054.GA11513@avx2
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: "Kohli, Gaurav" <gkohli@codeaurora.org>
Tested-by: John Ogness <john.ogness@linutronix.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/proc/array.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index c3e1732bcaa5..42e33ea50d1c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -435,8 +435,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		 * safe because the task has stopped executing permanently.
 		 */
 		if (permitted && (task->flags & PF_DUMPCORE)) {
-			eip = KSTK_EIP(task);
-			esp = KSTK_ESP(task);
+			if (try_get_task_stack(task)) {
+				eip = KSTK_EIP(task);
+				esp = KSTK_ESP(task);
+				put_task_stack(task);
+			}
 		}
 	}
 
-- 
2.17.2

