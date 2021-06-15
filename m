Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D93A819E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFOOCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:02:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4922 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFOOCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:02:05 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G48xs0H3gz706r;
        Tue, 15 Jun 2021 21:56:49 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 21:59:58 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 21:59:57 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH] poll: mark racy accesses on pwq->triggered
Date:   Tue, 15 Jun 2021 22:08:57 +0800
Message-ID: <20210615140857.3804405-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix data races to pwq->triggered by using READ_ONCE and WRITE_ONCE.
These accesses are expected to be racy per comment.

Original KCSAN report:
==================================================================
BUG: KCSAN: data-race in do_sys_poll / pollwake

write to 0xffffc90000883c70 of 4 bytes by task 9351 on cpu 1:
 __pollwake fs/select.c:197 [inline]
 pollwake+0xa7/0xf0 fs/select.c:217
 __wake_up_common+0xbc/0x130 kernel/sched/wait.c:93
 __wake_up_common_lock kernel/sched/wait.c:123 [inline]
 __wake_up_sync_key+0x83/0xc0 kernel/sched/wait.c:190
 pipe_write+0x88b/0xd20 fs/pipe.c:580
 call_write_iter include/linux/fs.h:1903 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0x6d2/0x7c0 fs/read_write.c:605
 ksys_write+0xce/0x180 fs/read_write.c:658
 __do_sys_write fs/read_write.c:670 [inline]
 __se_sys_write fs/read_write.c:667 [inline]
 __x64_sys_write+0x3e/0x50 fs/read_write.c:667
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffc90000883c70 of 4 bytes by task 9353 on cpu 3:
 poll_schedule_timeout fs/select.c:242 [inline]
 do_poll fs/select.c:961 [inline]
 do_sys_poll+0x940/0xb80 fs/select.c:1011
 __do_sys_poll fs/select.c:1069 [inline]
 __se_sys_poll+0xce/0x1c0 fs/select.c:1057
 __x64_sys_poll+0x3f/0x50 fs/select.c:1057
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 3 PID: 9353 Comm: scp Not tainted 5.10.0-rc5-csan #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
         BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
==================================================================

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5f820f648c92a ("poll: allow f_op->poll to sleep")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 945896d0ac9e..e71b4d1a2606 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -194,7 +194,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	 * and is paired with smp_store_mb() in poll_schedule_timeout.
 	 */
 	smp_wmb();
-	pwq->triggered = 1;
+	WRITE_ONCE(pwq->triggered, 1);
 
 	/*
 	 * Perform the default wake up operation using a dummy
@@ -239,7 +239,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 	int rc = -EINTR;
 
 	set_current_state(state);
-	if (!pwq->triggered)
+	if (!READ_ONCE(pwq->triggered))
 		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.31.1

