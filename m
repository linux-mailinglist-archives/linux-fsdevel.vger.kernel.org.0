Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D152583B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 01:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359444AbiELX0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359445AbiELX0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 19:26:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E022B1F
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4OGFt/RuhqZvF9I/pswtLr39DEvgW304DrR4MR8e7mM=; b=eihfcq8AeoEtqKjwF8Kl4Kz8QD
        sVfmaxsrf+h47X9bn9ZFuoyj7+hzbPUTBZ9QOp0U4tzok+a8a8cw71jnmOCLmkvwoVO1VXnwenrsI
        rXIiiy03kPzaTgaG/ik+TqT9pIgFNGyshY6kfhfFnTgPWRjx5aBXPFO5Zr9tBigG4r7cFnQeBKovz
        j5gDRfQC0AiMcTld1ND7/onxP58idcTRRY2v2A9ChoBqByiHQjblrN0eBafnrxI7Y5JguS3uEb/oi
        xcZg2gGqo5M92GrUJhacBKWvUuJ5zKiFtdu+jAGbka2E0JUvGNF62of1VKTvjbotIzzK+3tW27gYz
        41cwprSA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npICd-00EQiY-5A; Thu, 12 May 2022 23:26:39 +0000
Date:   Thu, 12 May 2022 23:26:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC][PATCH] get rid of the remnants of 'batched' fget/fput stuff
Message-ID: <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hadn't been used since 62906e89e63b "io_uring: remove file batch-get
optimisation", should've been killed back then...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file.c b/fs/file.c
index 9780888fa2da..9fbc0c653930 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -850,7 +850,7 @@ void do_close_on_exec(struct files_struct *files)
 }
 
 static inline struct file *__fget_files_rcu(struct files_struct *files,
-	unsigned int fd, fmode_t mask, unsigned int refs)
+	unsigned int fd, fmode_t mask)
 {
 	for (;;) {
 		struct file *file;
@@ -876,10 +876,10 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 * Such a race can take two forms:
 		 *
 		 *  (a) the file ref already went down to zero,
-		 *      and get_file_rcu_many() fails. Just try
+		 *      and get_file_rcu() fails. Just try
 		 *      again:
 		 */
-		if (unlikely(!get_file_rcu_many(file, refs)))
+		if (unlikely(!get_file_rcu(file)))
 			continue;
 
 		/*
@@ -888,11 +888,11 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 *       pointer having changed, because it always goes
 		 *       hand-in-hand with 'fdt'.
 		 *
-		 * If so, we need to put our refs and try again.
+		 * If so, we need to put our ref and try again.
 		 */
 		if (unlikely(rcu_dereference_raw(files->fdt) != fdt) ||
 		    unlikely(rcu_dereference_raw(*fdentry) != file)) {
-			fput_many(file, refs);
+			fput(file);
 			continue;
 		}
 
@@ -905,37 +905,31 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 }
 
 static struct file *__fget_files(struct files_struct *files, unsigned int fd,
-				 fmode_t mask, unsigned int refs)
+				 fmode_t mask)
 {
 	struct file *file;
 
 	rcu_read_lock();
-	file = __fget_files_rcu(files, fd, mask, refs);
+	file = __fget_files_rcu(files, fd, mask);
 	rcu_read_unlock();
 
 	return file;
 }
 
-static inline struct file *__fget(unsigned int fd, fmode_t mask,
-				  unsigned int refs)
-{
-	return __fget_files(current->files, fd, mask, refs);
-}
-
-struct file *fget_many(unsigned int fd, unsigned int refs)
+static inline struct file *__fget(unsigned int fd, fmode_t mask)
 {
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
 
@@ -945,7 +939,7 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 
 	task_lock(task);
 	if (task->files)
-		file = __fget_files(task->files, fd, 0, 1);
+		file = __fget_files(task->files, fd, 0);
 	task_unlock(task);
 
 	return file;
@@ -1014,7 +1008,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
-		file = __fget(fd, mask, 1);
+		file = __fget(fd, mask);
 		if (!file)
 			return 0;
 		return FDPUT_FPUT | (unsigned long)file;
diff --git a/fs/file_table.c b/fs/file_table.c
index 7d2e692b66a9..1ffd74bbbed6 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -368,9 +368,9 @@ EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-void fput_many(struct file *file, unsigned int refs)
+void fput(struct file *file)
 {
-	if (atomic_long_sub_and_test(refs, &file->f_count)) {
+	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
@@ -389,11 +389,6 @@ void fput_many(struct file *file, unsigned int refs)
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
index 51e830b4fe3a..39704eae83e2 100644
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
index bbde95387a23..0521f0b1356b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -981,9 +981,8 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu_many(x, cnt)	\
-	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
-#define get_file_rcu(x) get_file_rcu_many((x), 1)
+#define get_file_rcu(x)	\
+	atomic_long_add_unless(&(x)->f_count, 1, 0)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
