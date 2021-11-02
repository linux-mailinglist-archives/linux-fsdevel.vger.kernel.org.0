Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512144425B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 03:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKBCtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 22:49:47 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:49015 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhKBCtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:49:46 -0400
X-QQ-mid: bizesmtp49t1635821222tdyjsnyr
Received: from localhost.localdomain (unknown [113.200.76.118])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 02 Nov 2021 10:47:00 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000B00C0000000
X-QQ-FEAT: FXvDfBZI5O7KJUiSdc+ua464MSTTQNnKWcPonMNU3zFtXHzp+Kh89BV4O7IMO
        IKdIPyi2upu0x3oPBoT34xf1Gybyn6gbdkgfMmqXjVEB5+mVVT5+eWkDrKgMAZIuaVpYLno
        H+5q9y7Et9gWgypkysypaEn1vxlrtaOZi306waIeXldiqxV7/3nuKy1KkavzO+lAEohEvgx
        vFnhMcLwaVEmPWyMbJPlKvDciGF/FYrJaMaoB/CRvUA0zamKzqtcOfTnm/bFhPp/Zu/8UTl
        VSjtfU1kCnL59cvilUPK7xLlsf6+xpHs1O3OXYT3PDorBwzvoom75I5RfxZdqJrosVjaOOG
        OUmRS7ckgcXx7+8gM+QH+GW2KwnwKte0XOZOz0WVVyzTy3JZaI=
X-QQ-GoodBg: 2
From:   Gou Hao <gouhao@uniontech.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiaofenfang@uniontech.com, willy@infradead.org
Subject: [PATCH V2] fs: remove fget_many and fput_many interface
Date:   Tue,  2 Nov 2021 10:46:48 +0800
Message-Id: <20211102024648.14578-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two interface were added in 091141a42 commit,
but now there is no place to call them.

The only user of fput/fget_many() was removed in commit
62906e89e63b ("io_uring: remove file batch-get optimisation").

A user of get_file_rcu_many() were removed in commit 
f073531070d2 ("init: add an init_dup helper").

And replace atomic_long_sub/add to atomic_long_dec/inc
can improve performance.

Here are the test results of unixbench:

Cmd: ./Run -c 64 context1

Without patch:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe-based Context Switching                   4000.0    2798407.0   6996.0
                                                                   ========
System Benchmarks Index Score (Partial Only)                         6996.0

With patch:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe-based Context Switching                   4000.0    3486268.8   8715.7
                                                                   ========
System Benchmarks Index Score (Partial Only)                         8715.7

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/file.c            | 22 ++++++++--------------
 fs/file_table.c      |  9 ++-------
 include/linux/file.h |  2 --
 include/linux/fs.h   |  4 +---
 4 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 8627dacfc..49fbb6313 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -842,7 +842,7 @@ void do_close_on_exec(struct files_struct *files)
 }
 
 static struct file *__fget_files(struct files_struct *files, unsigned int fd,
-				 fmode_t mask, unsigned int refs)
+				 fmode_t mask)
 {
 	struct file *file;
 
@@ -856,7 +856,7 @@ loop:
 		 */
 		if (file->f_mode & mask)
 			file = NULL;
-		else if (!get_file_rcu_many(file, refs))
+		else if (!get_file_rcu(file))
 			goto loop;
 	}
 	rcu_read_unlock();
@@ -864,26 +864,20 @@ loop:
 	return file;
 }
 
-static inline struct file *__fget(unsigned int fd, fmode_t mask,
-				  unsigned int refs)
+static inline struct file *__fget(unsigned int fd, fmode_t mask)
 {
-	return __fget_files(current->files, fd, mask, refs);
-}
-
-struct file *fget_many(unsigned int fd, unsigned int refs)
-{
-	return __fget(fd, FMODE_PATH, refs);
+	return __fget_files(current->files, fd, mask);
 }
 
 struct file *fget(unsigned int fd)
 {
-	return __fget(fd, FMODE_PATH, 1);
+	return __fget(fd, FMODE_PATH);
 }
 EXPORT_SYMBOL(fget);
 
 struct file *fget_raw(unsigned int fd)
 {
-	return __fget(fd, 0, 1);
+	return __fget(fd, 0);
 }
 EXPORT_SYMBOL(fget_raw);
 
@@ -893,7 +887,7 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 
 	task_lock(task);
 	if (task->files)
-		file = __fget_files(task->files, fd, 0, 1);
+		file = __fget_files(task->files, fd, 0);
 	task_unlock(task);
 
 	return file;
@@ -962,7 +956,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
-		file = __fget(fd, mask, 1);
+		file = __fget(fd, mask);
 		if (!file)
 			return 0;
 		return FDPUT_FPUT | (unsigned long)file;
diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1..10781a901 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -331,9 +331,9 @@ EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-void fput_many(struct file *file, unsigned int refs)
+void fput(struct file *file)
 {
-	if (atomic_long_sub_and_test(refs, &file->f_count)) {
+	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
@@ -352,11 +352,6 @@ void fput_many(struct file *file, unsigned int refs)
 	}
 }
 
-void fput(struct file *file)
-{
-	fput_many(file, 1);
-}
-
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
diff --git a/include/linux/file.h b/include/linux/file.h
index 51e830b4f..39704eae8 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -14,7 +14,6 @@
 struct file;
 
 extern void fput(struct file *);
-extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
 struct task_struct;
@@ -47,7 +46,6 @@ static inline void fdput(struct fd fd)
 }
 
 extern struct file *fget(unsigned int fd);
-extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353..600470c2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1015,9 +1015,7 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu_many(x, cnt)	\
-	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
-#define get_file_rcu(x) get_file_rcu_many((x), 1)
+#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
-- 
2.20.1



