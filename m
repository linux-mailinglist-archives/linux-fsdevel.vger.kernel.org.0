Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C23DC612
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhGaNSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 09:18:10 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:23563 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230303AbhGaNSK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 09:18:10 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 09:18:09 EDT
X-QQ-mid: bizesmtp32t1627737014tpv99w6x
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 31 Jul 2021 21:10:13 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: bj+H3nJpNbUXQNLi6YvOfJns/925NzbUJywgbkzKAuYqShvwscyZ5afsB4H52
        4FVqC2lNigyVV3pCHVCLGoqIiYMw0VUeJki6rm/UPEtlfjWLTyW06heXk25WgG1OoccXws8
        jo2l1Qy6xmF+zrsPfJ3OUe0zMwSWwIKcM36Az5L/aiXBEcSQMW67VsAfwjD3CrZPpznCJMc
        CRYuVrsGBmWHTuTVYDPoaNqa6IfAXIOf/aUtpBCu7GlKSM5FdrbRDD9LAiCszTXI6TILfGs
        I831LHgvmvIRgmFdUVummw3EsZMIjm/22mySc/ENOCkqPTNW8VY8eVbYybpvgXgqhH0ZGCD
        bajq3Ch+VAVHy5xYuc=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] file: use 'unsigned int' instead of 'unsigned'
Date:   Sat, 31 Jul 2021 21:09:57 +0800
Message-Id: <20210731130957.416337-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/file.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index d8afa8266859..9b8513ccf006 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -467,7 +467,7 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-static int alloc_fd(unsigned start, unsigned end, unsigned flags)
+static int alloc_fd(unsigned int start, unsigned int end, unsigned int flags)
 {
 	struct files_struct *files = current->files;
 	unsigned int fd;
@@ -525,12 +525,12 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	return error;
 }
 
-int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
+int __get_unused_fd_flags(unsigned int flags, unsigned long nofile)
 {
 	return alloc_fd(0, nofile, flags);
 }
 
-int get_unused_fd_flags(unsigned flags)
+int get_unused_fd_flags(unsigned int flags)
 {
 	return __get_unused_fd_flags(flags, rlimit(RLIMIT_NOFILE));
 }
@@ -606,7 +606,7 @@ EXPORT_SYMBOL(fd_install);
  *
  * Returns: The file associated with @fd, on error returns an error pointer.
  */
-static struct file *pick_file(struct files_struct *files, unsigned fd)
+static struct file *pick_file(struct files_struct *files, unsigned int fd)
 {
 	struct file *file;
 	struct fdtable *fdt;
@@ -630,7 +630,7 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
 	return file;
 }
 
-int close_fd(unsigned fd)
+int close_fd(unsigned int fd)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -651,7 +651,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
  *
  * Returns: Last valid index into fdtable.
  */
-static inline unsigned last_fd(struct fdtable *fdt)
+static inline unsigned int last_fd(struct fdtable *fdt)
 {
 	return fdt->max_fds - 1;
 }
@@ -699,7 +699,7 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
  */
-int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
+int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags)
 {
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
@@ -807,14 +807,14 @@ int close_fd_get_file(unsigned int fd, struct file **res)
 
 void do_close_on_exec(struct files_struct *files)
 {
-	unsigned i;
+	unsigned int i;
 	struct fdtable *fdt;
 
 	/* exec unshares first */
 	spin_lock(&files->file_lock);
 	for (i = 0; ; i++) {
 		unsigned long set;
-		unsigned fd = i * BITS_PER_LONG;
+		unsigned int fd = i * BITS_PER_LONG;
 		fdt = files_fdtable(files);
 		if (fd >= fdt->max_fds)
 			break;
@@ -1030,7 +1030,7 @@ bool get_close_on_exec(unsigned int fd)
 }
 
 static int do_dup2(struct files_struct *files,
-	struct file *file, unsigned fd, unsigned flags)
+	struct file *file, unsigned int fd, unsigned int flags)
 __releases(&files->file_lock)
 {
 	struct file *tofree;
@@ -1073,7 +1073,7 @@ __releases(&files->file_lock)
 	return -EBUSY;
 }
 
-int replace_fd(unsigned fd, struct file *file, unsigned flags)
+int replace_fd(unsigned int fd, struct file *file, unsigned int flags)
 {
 	int err;
 	struct files_struct *files = current->files;
@@ -1219,7 +1219,7 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 	return ret;
 }
 
-int f_dupfd(unsigned int from, struct file *file, unsigned flags)
+int f_dupfd(unsigned int from, struct file *file, unsigned int flags)
 {
 	unsigned long nofile = rlimit(RLIMIT_NOFILE);
 	int err;
@@ -1233,8 +1233,8 @@ int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 	return err;
 }
 
-int iterate_fd(struct files_struct *files, unsigned n,
-		int (*f)(const void *, struct file *, unsigned),
+int iterate_fd(struct files_struct *files, unsigned int n,
+		int (*f)(const void *, struct file *, unsigned int),
 		const void *p)
 {
 	struct fdtable *fdt;
-- 
2.32.0

