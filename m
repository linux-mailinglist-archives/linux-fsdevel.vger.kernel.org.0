Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61343218A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGHOZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 10:25:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60912 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgGHOZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:25:29 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 068EPCde004077;
        Wed, 8 Jul 2020 23:25:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Wed, 08 Jul 2020 23:25:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 068EOOel003215
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Jul 2020 23:25:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] fput: Allow calling __fput_sync() from !PF_KTHREAD thread.
Date:   Wed,  8 Jul 2020 23:24:09 +0900
Message-Id: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
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

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Al, is this change acceptable?

Eric is trying to use fput()/flush_delayed_fput()/task_work_run() from
blob_to_mnt() which is going to be introduced by
https://lkml.kernel.org/r/20200702164140.4468-8-ebiederm@xmission.com
in order to make sure that a file (which was opened for writing and is
intended to be execve()d shortly) is closed by current thread before
leaving blob_to_mnt().

But since current thread might fail to find the interested file (which was
opened for writing and is intended to be execve()d shortly) and/or might find
uninterested files (which current thread does not need to process) when
multiple threads concurrently called flush_delayed_fput(), I think that we
should use __fput_sync() in order to make sure that only the interested file
is closed by current thread.

Therefore, I propose this change.

 fs/file_table.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..7c4125179469 100644
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
2.18.4

