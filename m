Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BD10E6C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLBIOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfLBIOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2D0261252F11F487C83;
        Mon,  2 Dec 2019 16:14:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:11 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 4/7] fs/proc: Stop reporting eip and esp in /proc/PID/stat
Date:   Mon, 2 Dec 2019 16:35:16 +0800
Message-ID: <20191202083519.23138-5-yi.zhang@huawei.com>
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

From: Andy Lutomirski <luto@kernel.org>

commit 0a1eb2d474edfe75466be6b4677ad84e5e8ca3f5 upstream.

Reporting these fields on a non-current task is dangerous.  If the
task is in any state other than normal kernel code, they may contain
garbage or even kernel addresses on some architectures.  (x86_64
used to do this.  I bet lots of architectures still do.)  With
CONFIG_THREAD_INFO_IN_TASK=y, it can OOPS, too.

As far as I know, there are no use programs that make any material
use of these fields, so just get rid of them.

Reported-by: Jann Horn <jann@thejh.net>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Tycho Andersen <tycho.andersen@canonical.com>
Link: http://lkml.kernel.org/r/a5fed4c3f4e33ed25d4bb03567e329bc5a712bcc.1475257877.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/proc/array.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 60cbaa821164..618c83f1866d 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -425,10 +425,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	mm = get_task_mm(task);
 	if (mm) {
 		vsize = task_vsize(mm);
-		if (permitted) {
-			eip = KSTK_EIP(task);
-			esp = KSTK_ESP(task);
-		}
+		/*
+		 * esp and eip are intentionally zeroed out.  There is no
+		 * non-racy way to read them without freezing the task.
+		 * Programs that need reliable values can use ptrace(2).
+		 */
 	}
 
 	get_task_comm(tcomm, task);
-- 
2.17.2

