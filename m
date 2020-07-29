Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94D4231EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgG2NFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 09:05:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56524 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2NFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:05:23 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06TD55nd061122;
        Wed, 29 Jul 2020 22:05:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Wed, 29 Jul 2020 22:05:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06TD51pY060995
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Jul 2020 22:05:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] fput: Allow calling __fput_sync() from !PF_KTHREAD thread.
Date:   Wed, 29 Jul 2020 22:04:45 +0900
Message-Id: <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__fput_sync() was introduced by commit 4a9d4b024a3102fc ("switch fput to
task_work_add") with BUG_ON(!(current->flags & PF_KTHREAD)) check, and
the only user of __fput_sync() was introduced by commit 17c0a5aaffa63da6
("make acct_kill() wait for file closing."). However, the latter commit is
effectively calling __fput_sync() from !PF_KTHREAD thread because of
schedule_work() call followed by immediate wait_for_completion() call.
That is, there is no need to defer close_work() to a WQ context. I guess
that the reason to defer was nothing but to bypass this BUG_ON() check.
While we need to remain careful about calling __fput_sync(), we can remove
bypassable BUG_ON() check from __fput_sync().

If this change is accepted, racy fput()+flush_delayed_fput() introduced
by commit e2dc9bf3f5275ca3 ("umd: Transform fork_usermode_blob into
fork_usermode_driver") will be replaced by this raceless __fput_sync().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/file_table.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f..7c41251 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -359,20 +359,15 @@ void fput(struct file *file)
 }
 
 /*
- * synchronous analog of fput(); for kernel threads that might be needed
- * in some umount() (and thus can't use flush_delayed_fput() without
- * risking deadlocks), need to wait for completion of __fput() and know
- * for this specific struct file it won't involve anything that would
- * need them.  Use only if you really need it - at the very least,
- * don't blindly convert fput() by kernel thread to that.
+ * synchronous analog of fput(); for threads that need to wait for completion
+ * of __fput() and know for this specific struct file it won't involve anything
+ * that would need them.  Use only if you really need it - at the very least,
+ * don't blindly convert fput() to __fput_sync().
  */
 void __fput_sync(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
-		struct task_struct *task = current;
-		BUG_ON(!(task->flags & PF_KTHREAD));
+	if (atomic_long_dec_and_test(&file->f_count))
 		__fput(file);
-	}
 }
 
 EXPORT_SYMBOL(fput);
-- 
1.8.3.1

