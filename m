Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7020358
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEPKYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKYM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84CE2C0624A1;
        Thu, 16 May 2019 10:24:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FA32101E676;
        Thu, 16 May 2019 10:24:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] vfs: Move kernel_read_file() to fs/read_write.c
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 11:24:09 +0100
Message-ID: <155800224959.20648.3112025968119530518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 16 May 2019 10:24:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit bdd1d2d3d251 ("fs: fix kernel_read prototype") moved kernel_read()
to fs/read_write.c without moving the helpers.

Move kernel_read_file() to fs/read_write.c and out of fs/exec.c as it's not
actually used by anything in the execve subsystem.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---

 fs/exec.c       |  106 -------------------------------------------------------
 fs/read_write.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d88584ebf07f..026ea2458b41 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -61,7 +61,6 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
 #include <linux/compat.h>
-#include <linux/vmalloc.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -892,111 +891,6 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
-	ssize_t bytes = 0;
-	int ret;
-
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
-		return -EINVAL;
-
-	ret = deny_write_access(file);
-	if (ret)
-		return ret;
-
-	ret = security_kernel_read_file(file, id);
-	if (ret)
-		goto out;
-
-	i_size = i_size_read(file_inode(file));
-	if (i_size <= 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
-		ret = -EFBIG;
-		goto out;
-	}
-
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
-	if (!*buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
-		if (bytes < 0) {
-			ret = bytes;
-			goto out_free;
-		}
-
-		if (bytes == 0)
-			break;
-	}
-
-	if (pos != i_size) {
-		ret = -EIO;
-		goto out_free;
-	}
-
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
-	if (!ret)
-		*size = pos;
-
-out_free:
-	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
-			vfree(*buf);
-			*buf = NULL;
-		}
-	}
-
-out:
-	allow_write_access(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file);
-
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
-{
-	struct file *file;
-	int ret;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	ret = kernel_read_file(file, buf, size, max_size, id);
-	fput(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
-
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
-{
-	struct fd f = fdget(fd);
-	int ret = -EBADF;
-
-	if (!f.file)
-		goto out;
-
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
-	fdput(f);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/fs/read_write.c b/fs/read_write.c
index c543d965e288..61febd54f353 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/vmalloc.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -1390,6 +1391,111 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 
 #endif
 
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	loff_t i_size, pos;
+	ssize_t bytes = 0;
+	int ret;
+
+	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+		return -EINVAL;
+
+	ret = deny_write_access(file);
+	if (ret)
+		return ret;
+
+	ret = security_kernel_read_file(file, id);
+	if (ret)
+		goto out;
+
+	i_size = i_size_read(file_inode(file));
+	if (i_size <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
+		*buf = vmalloc(i_size);
+	if (!*buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pos = 0;
+	while (pos < i_size) {
+		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+		if (bytes < 0) {
+			ret = bytes;
+			goto out_free;
+		}
+
+		if (bytes == 0)
+			break;
+	}
+
+	if (pos != i_size) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	if (!ret)
+		*size = pos;
+
+out_free:
+	if (ret < 0) {
+		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+			vfree(*buf);
+			*buf = NULL;
+		}
+	}
+
+out:
+	allow_write_access(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	struct file *file;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	int ret = -EBADF;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, id);
+out:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
+
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		  	   size_t count, loff_t max)
 {

