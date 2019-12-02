Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63B10E6BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLBIOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfLBIOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B119688A35CFBD2BA1F2;
        Mon,  2 Dec 2019 16:14:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:13 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 7/7] fs/proc/array.c: allow reporting eip/esp for all coredumping threads
Date:   Mon, 2 Dec 2019 16:35:19 +0800
Message-ID: <20191202083519.23138-8-yi.zhang@huawei.com>
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

From: John Ogness <john.ogness@linutronix.de>

commit cb8f381f1613cafe3aec30809991cd56e7135d92 upstream.

0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in /proc/PID/stat")
stopped reporting eip/esp and fd7d56270b52 ("fs/proc: Report eip/esp in
/prod/PID/stat for coredumping") reintroduced the feature to fix a
regression with userspace core dump handlers (such as minicoredumper).

Because PF_DUMPCORE is only set for the primary thread, this didn't fix
the original problem for secondary threads.  Allow reporting the eip/esp
for all threads by checking for PF_EXITING as well.  This is set for all
the other threads when they are killed.  coredump_wait() waits for all the
tasks to become inactive before proceeding to invoke a core dumper.

Link: http://lkml.kernel.org/r/87y32p7i7a.fsf@linutronix.de
Link: http://lkml.kernel.org/r/20190522161614.628-1-jlu@pengutronix.de
Fixes: fd7d56270b526ca3 ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Jan Luebbe <jlu@pengutronix.de>
Tested-by: Jan Luebbe <jlu@pengutronix.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 42e33ea50d1c..6238f45eed02 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -434,7 +434,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & PF_DUMPCORE)) {
+		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
 			if (try_get_task_stack(task)) {
 				eip = KSTK_EIP(task);
 				esp = KSTK_ESP(task);
-- 
2.17.2

